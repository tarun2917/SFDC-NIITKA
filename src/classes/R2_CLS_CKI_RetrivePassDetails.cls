/*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado                      
    Company:        Accenture
    Description:    R2_CKI_info__c Retrieve Passenger Class
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                   <Change Description>
    10/08/2017              Alberto Puerto Collado          Initial Version
    21/08/2017              Alberto Puerto Collado          Global -> para tener métodos webService
    03/10/2017              Ismael Yubero Moreno
	30/10/2017				Sara Torres Bermudez			Modify version -> cambio en el nombre de la clase, ya que no me dejaba crear el test por ser el nombre demasiado largo
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
global with sharing class R2_CLS_CKI_RetrivePassDetails{
	/*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado                      
    Company:        Accenture
    Description:    Wrappers para ButtomCustomer
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>              	  <Change Description>
    10/08/2017              Alberto Puerto Collado 		    Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
 	public class RetrievePassengerDetailsWebRequest{
        public PassengerOptionType  passengerOption;
        public String fullFlightNumber;
        public String  flightDate;
        public String flightClass;
        public String departureAirPort; 
    }

    public class PassengerOptionType{
        public String sequenceNumber;
        public String seatNumber;
        public String passengerName;
    }

    public class Wr_Passenger_Resp{
        public String passengerRecord;
    }
/*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado                      
    Company:        Accenture
    Description:    Calls buttonCustomer method
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                   <Change Description>
    10/08/2017              Alberto Puerto Collado          Initial Version
    21/08/2017              Alberto Puerto Collado          Cambio en parámetros (sólo id) y webservice
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
    //@future(callout=true)
    webservice static String callButtonCustomer(String idPassenger){//String flightnumber, Date flightdateSalesforce, String flightclass, String departureairport, String passengeroption){
        try{
            system.debug('Comienzo call');
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            //query
            //R2_CKI_info__c pasajero = [SELECT R2_CKI_LOO_Flight__c, R2_CKI_LOO_Flight__r.R1_FLG_TXT_Flight_number__c, R2_CKI_FOR_Flight_date__c, R2_CKI_TXT_Flight_class__c, R2_CKI_TXT_Airport_depart__c, Name, R2_CKI_TXT_Seat_number__c
            //                                    FROM R2_CKI_info__c WHERE id = :idPassenger];//, passengeroption -> 1º seat number, 2º name
            R2_CKI_info__c pasajero =  [SELECT Id, R2_CKI_LOO_Flight__c, R2_CKI_LOO_Flight__r.R1_FLG_TXT_Flight_number__c, R2_CKI_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c, R2_CKI_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c, Name,R2_CKI_TXT_Seat_number__c, R2_CKI_TXT_Flight_class__c FROM R2_CKI_info__c WHERE id = :idPassenger];
                //conversión de fecha SF a String requerido
            System.debug('Aeropuerto: '+ pasajero.R2_CKI_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c);
            system.debug('string ID -> ' + idPassenger + ' //  CKI object ->' + pasajero);
            String flightdate = R2_CLS_Flight_TriggerMethods.formatoFecha(pasajero.R2_CKI_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c);
            
            String pasOption;
            Integer aux;
            if(pasajero.R2_CKI_TXT_Seat_number__c != '' && pasajero.R2_CKI_TXT_Seat_number__c != null){
                aux = 0;
                pasOption = pasajero.R2_CKI_TXT_Seat_number__c;
                system.debug('Hay SEAT NUMBER');
            }else if(pasajero.Name != '' && pasajero.Name != null){
                aux = 1;
                pasOption = pasajero.Name;
                system.debug(' NO seatNumb - si NAME');
            }
            //buttonCustomer(0, pasajero.R2_CKI_LOO_Flight__c, flightdate, pasajero.R2_CKI_TXT_Flight_class__c, pasajero.R2_CKI_TXT_Airport_depart__c, pasOption);  
            String numberF = pasajero.R2_CKI_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;
            Wr_Passenger_Resp resp = buttonCustomer(0, numberF, flightdate, pasajero.R2_CKI_TXT_Flight_class__c, pasajero.R2_CKI_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c, pasOption, aux);  
            //buttonCustomer(0, flightnumber, flightdate, flightclass, departureairport, passengeroption);
            system.debug('fin call');
         
            if(resp != null && resp.passengerRecord != null){ 
                resp.passengerRecord = resp.passengerRecord.replaceAll('\\\\n','\n'); 
                System.debug(resp.passengerRecord);
                return resp.passengerRecord;
            }else{
                return '';
            }
              
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CKI_RetrivePassDetails.callButtomCustomer', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_CKI_info__c');
            return 'Se ha producido un error';
        }
            
    }
/*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado                      
    Company:        Accenture
    Description:    Sends a HTTPRequest
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                   <Change Description>
    10/08/2017              Alberto Puerto Collado          Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
    public static Wr_Passenger_Resp buttonCustomer(Integer contador, String flightnumber, String flightdate, String flightclass, String departureairport, String passengeroption, Integer auxiliar) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;   
            
            string wsMethod = 'R2_Retrieve_Passenger_Details';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            } 
            //Control de token
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(contador < 3){                    
                    contador += 1;
                    R1_CLS_SendCustomerMDM.login();
                    System.debug('Aqui llega????');
                    return buttonCustomer(contador, flightnumber, flightdate, flightclass, departureairport, passengeroption, auxiliar);
                }
                else{
                    System.debug('Por que entra por aqui');
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Flight_TriggerMethods.buttonCustomer()', //idCustomer
                        flightnumber+'__'+flightdate+'__'+flightclass+'__'+departureairport+'__'+passengeroption
                        ,'No se puede conectar con MDM', 'R2_CKI_info__c'); //objeto passenger        
                    return null;
                }
            }

            

            //request
            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c+flightnumber+'-'+flightdate+'-'+departureairport+'/passengers/details');
            System.debug('ENDPOINT_____METHOD_______'+req.getEndpoint());
            
            RetrievePassengerDetailsWebRequest wrp = new RetrievePassengerDetailsWebRequest();
            PassengerOptionType wrapper = new PassengerOptionType();
            
            auxiliar=0;
            if(auxiliar == 0){
                wrapper.passengerName = passengerOption;
            }else if(auxiliar ==1){
                wrapper.seatNumber     = passengerOption;
            }
            
            wrp.fullFlightNumber = flightnumber;
            wrp.flightDate =  flightdate;
            wrp.departureAirPort = departureairport;
            wrp.flightClass =  flightclass;
            wrp.passengerOption = wrapper;

            //req-> header + body (al ser get, no body)
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(3700);
            String body= JSON.serialize(wrp);
            System.debug('Bodyyyyyy: '+body);
            req.setBody(body);
            system.debug('REQUEST********'+req);

            //llamada
            Http http = new Http();
            HTTPResponse res;
            System.debug('res previo send********'+res);
            res = http.send(req);
            system.debug('SEND********'+res.getStatusCode());
            //recogemos datos de response
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //parse data
                String resFixed = R1_CLS_Utilities.helper_duplicateBackslashes(res.getBody());
                system.debug('RESFIXED:::::::'+resFixed);
                
                //llenamos el wrapper de respuesta
                Wr_Passenger_Resp resp = (Wr_Passenger_Resp)JSON.deserialize(resFixed,Wr_Passenger_Resp.class);
                //Wr_Passenger_Resp resp = (Wr_Passenger_Resp)JSON.deserialize(res.getBody(),Wr_Passenger_Resp.class);
                
                //resp.passengerRecord = 'Prueba'; //BORRAR TRAS VERIFICAR, arreglo a capón para ir debugeando
                system.debug('RESP********'+resp);
                return resp;
            }
            else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return buttonCustomer(contador, flightnumber, flightdate, flightclass, departureairport, passengeroption, auxiliar);
            }else {
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_CKI_RetrivePassDetails.buttonCustomer()', //idCustomer
                    flightnumber+'__'+flightdate+'__'+flightclass+'__'+departureairport+'__'+passengeroption
                    ,'No se puede conectar con MDM', 'R2_CKI_info__c');          
                return null;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CKI_RetrivePassDetails.buttonCustomer()', 
                flightnumber+'__'+flightdate+'__'+flightclass+'__'+departureairport+'__'+passengeroption
                , exc.getmessage()+', '+exc.getLineNumber(), 'R2_CKI_info__c');
            return null;
        }
    }
}