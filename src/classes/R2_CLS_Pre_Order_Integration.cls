/*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ruben Pingarron Jerez
Company:        Accenture
Description:    Class what manage the integration for check Pre-Orders
IN:         

OUT:           

History:

<Date>              <Author>                 <Description>
09/10/2017        Ruben Pingarron Jerez     Initial version

--------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
public class R2_CLS_Pre_Order_Integration {
    
    // COMMON WRAPPERS
    public class ErrorType{
        public String errorCode;
        public String errorDescription;
    }
    
    public class Flight{
        public String flightNumber;
        public String flightDate;
        public String departureAirport;
        public String arrivalAirport;
    }
    
    public class Menu{
        public String menuName;
        public String iberiaMenuID;
        public String gateGourmetMenuID;         
    }
    
    public class Service{
        public String serviceId;
        public Menu menu;
    }
    
    public class Order{
        public String orderID;
        public String orderPNR;
        public String orderPNRResiber;
        public String orderLanguage;
        public String orderStatus;
        public String refundRequestedIndicator;
        public String refundableIndicator;
        public Service service;
        public String customerEmail;
        public Flight flight;
        public String emdidentifier;
    }
    
    // WRAPPERS REQUEST
    public class WpRequestCheckRefundPreOrder{
        public String orderTicketNumber;
        public Flight flight;
        public String issueType;
    }
    
    public class WpRequestRequestRefund{
        public String emdidentifier;
        public String resiberPNR;
    }
    
    // WRAPPERS RESPONSE
    public class WpResponseCheckRefundPreOrder{
        public Order order;
    }
    
    public class WpResponseRequestRefund{
        public String status;
        public ErrorType error;       
    }
    
    
  /*  @future(callout=true)
    public static void callCheckPreOrder(String orderTicketNumber, String flightNumber, Date flightDate, String departureAirport, String arrivalAirport, String issueType){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ruben Pingarron Jerez
Company:        Accenture
Description:    Future method what call the method checkPreOrder
IN:         

OUT:           

History:

<Date>              <Author>                 <Description>
07/11/2017        Ruben Pingarron Jerez     Initial version

--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
      /*  try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            
            checkPreOrder(orderTicketNumber, flightNumber, flightDate, departureAirport, arrivalAirport, issueType, 0);

        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.callCheckPreOrder', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }*/
    
    public static WpResponseCheckRefundPreOrder checkPreOrder (String orderTicketNumber, String flightNumber, Date flightDate, String departureAirport, String arrivalAirport, String issueType, Integer intentos){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        	Ruben Pingarron Jerez
Company:        Accenture
Description:    Method what realize the integration with Pre-Order

IN:       
OUT:      

History: 
<Date>                     <Author>                <Change Description>
07/11/2017         	Ruben Pingarron Jerez         Initial Version

--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            String diaVuelo = String.valueOf(flightDate.day());
            if(diaVuelo.length()==1){
                diaVuelo = '0' + diaVuelo;
            }
            String mesVuelo = String.valueOf(flightDate.month());
            if(mesVuelo.length()==1){
                mesVuelo = '0' + mesVuelo;
            }
            
            Flight fl = new Flight();
            fl.flightNumber = flightNumber;
            fl.flightDate = String.valueOf(flightDate.year()) + '/' + mesVuelo + '/' + diaVuelo;
            fl.departureAirport = departureAirport;
            fl.arrivalAirport = arrivalAirport;        
            
            WpRequestCheckRefundPreOrder wrp = new WpRequestCheckRefundPreOrder();
            wrp.orderTicketNumber = orderTicketNumber;
            wrp.flight = fl;
            wrp.issueType = issueType;
            
            system.debug('antes de request: ' + wrp);
            
            string wsMethod = 'PreOrderCheck';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                return null;
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return checkPreOrder(orderTicketNumber, flightNumber, flightDate, departureAirport, arrivalAirport, issueType, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.checkPreOrder()', '', 'No se puede conectar con Intelligence Integration TOKEN', 'R2_Compensation__c');
                    return null;
                }
            }
            
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c;
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(10000);
            system.debug('WRP ANTES: $$$ ' + wrp);
           	String body = JSON.serialize(wrp);
            //String body = '{"orderTicketNumber": "0752000280428", "flight": {"flightNumber": "IB6253", "flightDate": "2017/07/10", "departureAirport": "MAD", "arrivalAirport": "JFK"},   "issueType": "TDM"}';        
            req.setBody(body);          
            
            Http http = new Http();
            HTTPResponse res;
            System.debug('request: ' + req.getBody());
            res = http.send(req);
            System.debug('reeeeesStatus: ' + res.getStatusCode());
            
            system.debug('RES: ' + res);
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                System.debug('Responseeee serializado: ' + res.getBody());
                WpResponseCheckRefundPreOrder resp = (WpResponseCheckRefundPreOrder)JSON.deserialize(res.getBody(),WpResponseCheckRefundPreOrder.class);
                System.debug('Responseeee: ' + resp);
                return resp;
            }else{
                System.debug('reeeeesStatus: ' + res.getStatusCode());
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return checkPreOrder(orderTicketNumber, flightNumber, flightDate, departureAirport, arrivalAirport, issueType, intentos);
                }else{
                    System.debug('reeeeesStatus: ' + res.getStatusCode());
                    System.debug('resStatus : ' + res.getStatus());
                    System.debug('resStatusBody : ' + res.getBody());
                    String reason = res.getBody().subStringBetween('reason":"','",');
                    System.debug('reaseon : ' + reason);
                    Order orden = new Order();
                    WpResponseCheckRefundPreOrder respfail = new WpResponseCheckRefundPreOrder();
                    respfail.order = orden;
                    respfail.order.orderStatus = reason;
                    respfail.order.orderLanguage = 'Fallo';
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.checkPreOrder()', '', 'No se puede conectar con Intelligence Integration CANCEL', 'R2_Compensation__c');
                    return respfail;
                }
            }               
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.checkPreOrder()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    
   /* @future(callout=true)
    public static void callRequestRefund(String emdIdentifier, String resiberPNR){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ruben Pingarron Jerez
Company:        Accenture
Description:    Future method what call the method requestRefund
IN:         

OUT:           

History:

<Date>              <Author>                 <Description>
07/11/2017        Ruben Pingarron Jerez     Initial version

--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
       /* try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            requestRefund(emdIdentifier, resiberPNR, 0);
            
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.callRequestRefund', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }*/
    
    public static WpResponseRequestRefund requestRefund (String emdIdentifier, String resiberPNR, Integer intentos){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        	Ruben Pingarron Jerez
Company:        Accenture
Description:    Method what realize the integration with Pre-Order

IN:       
OUT:      

History: 
<Date>                     <Author>                <Change Description>
07/11/2017          	Ruben Pingarron Jerez         Initial Version

--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            WpRequestRequestRefund wrp = new WpRequestRequestRefund();
            wrp.emdidentifier = emdIdentifier;
            wrp.resiberPNR = resiberPNR;
            
            string wsMethod = 'PreOrderIni';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                return null;
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            system.debug('--> token: ' + token);
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return requestRefund(emdIdentifier, resiberPNR, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.requestRefund()', '', 'No se puede conectar con Intelligence Integration TOKEN', 'R2_Compensation__c');
                    return null;
                }
            }
            
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c;
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(10000);
           	String body = JSON.serialize(wrp);
            req.setBody(body);          
            
            Http http = new Http();
            HTTPResponse res;
            
            res = http.send(req);
            System.debug('reeeeesStatus: ' + res.getStatusCode());
            
            system.debug('RES: ' + res);
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                WpResponseRequestRefund resp = (WpResponseRequestRefund)JSON.deserialize(res.getBody(),WpResponseRequestRefund.class);
                System.debug('Responseeee: ' + resp);
                return resp;
            }else{
                System.debug('reeeeesStatus: ' + res.getStatusCode());
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return requestRefund(emdIdentifier, resiberPNR, intentos);
                }else{
                    System.debug('reeeeesStatus: ' + res.getStatusCode());
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.requestRefund()', '', 'No se puede conectar con Intelligence Integration CANCEL', 'R2_Compensation__c');
                    return null;
                }
            }               
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Pre_Order_Integration.requestRefund()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
}