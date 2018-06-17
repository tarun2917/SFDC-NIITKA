/*-------------------------------------------------------------------------------------------------------------------------------------------------------
	Author:        Alvaro Garcia Tapia
	Company:       Accenture
	Description:   Methods call by the different buttoms in voucher object to query, cancel or anulate a voucher in gestor de bonos system

	
	History: 
	
	<Date>                  <Author>                <Change Description>
	14/03/2018              Alvaro Garcia Tapia        Initial Version     
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

global with sharing class R2_CLS_BonosIberiacom {

	public class Salida {
		public String desde;
		public String hasta;
	}

	public class WsResponseBono {
		public Bonus bonus;
		public Error error;
		
	}
	public class Bonus{
       	public String ID;//servicios: consultar
       	public String commercialCode;//servicios: consultar
       	public String iBPlusNumber;//
       	public String email;//
       	public String campaignID;//servicios: consultar
       	public String maximumPermittedUse;//servicios: consultar
       	public String discountType;//servicios: consultar
       	public String discountValue;//servicios: consultar
       	public String currencyCode;//servicios: consultar    //no es currency porque es palabra reservada, posteriormente se hace un replace
       	public String discountPercentage;//servicios: consultar
       	public String commercialCompanyCode;//servicios: consultar
       	public String allowUnselectedOperators;//servicios: consultar
       	public String reservationRedeemabilityIndicator;//servicios: consultar
       	public OperatingCompanies operatingCompanies;//servicios: consultar
       	public Validity validity;//servicios: consultar
       	public DiscountConcept discountConcept;//servicios: consultar
	   	public String logInUserRequiredIndicator;//servicios: consultar
	   	public String sundayRuleApplicabilityIndicator;//servicios: consultar
	   	public DepartureDays departureDays;//servicios: consultar
	   	public ReturnDays returnDays;//servicios: consultar
	   	public String consumptiondate;//servicios: consultar
	   	public String firstConsumptiondate;//servicios: consultar
	   	public String bonusUsageCount;//servicios: consultar
	   	public String amountconsumed;//servicios: consultar
	   	public String counterUseBonus;//servicios: consultar
	   	public String creationDate;//servicios: consultar
	   	public String modificationDate;//servicios: consultar
       	public String reservationdate;//servicios: consultar

	   	public String campaignCommercialCode;////Este campo sale en el json
	   	public String minimumPre_departureInterval;
       	public String minimumTravelDuration;
       	public String maximumTravelDuration;
	   	public POS pOS;
	   	public Origin origin;
	   	public Destination destination;
	   	public WCSCommunities wCSCommunities;
	   	public BPMGroups bPMGroups;
	   	public DepartureInterval departureInterval;
	   	public ReturnInterval returnInterval;
	   	public DepatureBlackOutInterval depatureBlackOutInterval;
	   	public ReturnBlackOutInterval returnBlackOutInterval;
	   	public ReservationClasses reservationClasses;
	   	public ItineraryType itineraryType;
	   	public PaymentType paymentType;
    }
	   
	public class OperatingCompanies{//servicios: consultar
    	public List<String> companyCode; 
    }  
	public class Validity{//servicios: consultar
    	public String startDateTime; 
    	public String endDateTime;
    }
    public class DiscountConcept{//servicios: consultar
    	public List<String> conceptCode;
    }
    public class DepartureDays{//servicios: consultar
    	public List<String> dayCode ;
    }
    public class ReturnDays{//servicios: consultar
    	public List<String> dayCode;
    }
    public class POS {
    	public String POSCode;
    }
    
	public class Origin{
    	public String GranAreaCode;
    	public String AreaCode;
    	public String SubAreaCode;
    	public String CountryCode;
    	public String CityCode;
    }
    
	public class Destination{
    	public String GranAreaCode;
    	public String AreaCode;
    	public String SubAreaCode;
    	public String CityCode;
    }

	public class WCSCommunities{
    	public String Code;
    }
    
	public class BPMGroups{
    	public String Code; 
    }
    
	public class DepartureInterval{
    	public String StartDateTime;
    	public String EndDateTime;
    }
    
	public class ReturnInterval{
    	public String  StartDateTime;
    	public String  EndDateTime ;
    }
    
	public class DepatureBlackOutInterval{
    	public String StartDateTime;
    	public String EndDateTime; 
    }
    
	public class ReturnBlackOutInterval{
    	public String StartDateTime;
    	public String EndDateTime;
    }
    
	public class ReservationClasses{
    	public String  dayCode;
    }
    
	public class ItineraryType{
    	public String itineraryTypeCode;
    }
    
	public class PaymentType{
    	public String paymentTypeDesc;
    }

  	public class wpRequestAltaBono{
   		public String campaignCommercialCode;
   		public String maximumPermittedUse;
   		public String discountType;
   		public String discountValue;
   		public String currencyCode;
   		public Validez validity;
	}

	public class validez{
		public String startDateTime;
		public String endDateTime;
	}

	public class WpRequestCancelBono{
		public String id;
		public String amount;
		public String bookingReference;
	}
	
	//Para query
	
	public class WsResponseQueryBono {
		//public BonusQuery bonus;
		public Bonus bonus;
		public Error error;
	}

	public class WsResponseCancelBono {
		public String success;
		public Error error;
	}
	public class Error{
	   public String errorCode;
	   public String errorDescription;
  	}
	//public class BonusQuery{
 //      public String ID;
 //      public String CommercialCode;
 //      public String CampaignID;
 //      public String MaximumPermittedUse;
 //      public String CampaignCommercialCode;////Este campo sale en el json
 //      public String DiscountType;
 //      public String DiscountValue;
 //      public String CurrencyCode;
 //      public String DiscountPercentage;
 //      public String CommercialCompanyCode;
 //      public String AllowUnselectedOperators;
 //      public String ReservationRedeemabilityIndicator;
 //      public OperatingCompanies operatingCompanies;
 //      public Validez Validity;
 //      public DiscountQueryConcept discountConcept;
 //      public String LogInUserRequiredIndicator;
 //      public String SundayRuleApplicabilityIndicator;
 //      public DepartureDays departureDays;
 //      public ReturnDays returnDays;
 //      public String Consumptiondate;
	//   public String FirstConsumptiondate;
	//   public String BonusUsageCount;
 //      public String Amountconsumed;
	//   public String CounterUseBonus;
 //      public String CreationDate;
 //      public String ModificationDate;
 //      public String Reservationdate;
	//}
	
    //public class DiscountQueryConcept{
    //    public List<String> ConceptCode;
    //}

		
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Query bonoIberia from a buttom in Voucher
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    14/03/2018          Alvaro Garcia Tapia	   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    WebService static void consultarBonoIberiacom(String idBono){
    	 //ResultWebService result = new ResultWebService();
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
           	R2_Voucher__c bonoIbcom = [SELECT Id, R2_VOU_TXT_Id_Bono__c, R2_VOU_TXT_Voucher__c, R2_VOU_TXT_Campaign_Commercial_Code__c, R2_VOU_TXT_Commercial_Code__c, 
           								R2_VOU_NUM_Discount_Value__c, R2_VOU_TXT_Campaign_Id__c, R2_VOU_CHK_Allow_Unselected_Operators__c, R2_VOU_CHK_Redeem_Reservation__c, 
           								R2_VOU_CHK_User_logged__c, R2_VOU_CHK_Sunday_Rule__c, R2_VOU_NUM_Number_Uses_Bonus__c, R2_VOU_NUM_Consumed_Amount__c, 
           								R2_VOU_NUM_Maximum_Bonus_Consumption__c, R2_VOU_DATH_Effective_Date_From__c, R2_VOU_DATH_Effective_Date_To__c, R2_VOU_TXT_Days_Return__c, 
           								R2_VOU_TXT_Discount_Concept__c, R2_VOU_DAT_Date_First_Consumption_Bono__c, R2_VOU_DATH_Bonus_Consumption_Date__c, R2_VOU_NUM_Counter_Uses_Bono__c,
           								R2_VOU_DATH_Date_Reservation__c, R2_VOU_TXT_Days_Departure__c, R2_VOU_PKL_Coin__c, R2_VOU_PKL_Discount_Type__c, R2_VOU_TXT_Operating_Companies__c
           								FROM R2_Voucher__c WHERE Id =: idBono];

            if (bonoIbcom.R2_VOU_TXT_Id_Bono__c != null) {
                WsResponseQueryBono wsResponseQueryBono = new WsResponseQueryBono();
                
                //llamada al metodo de la integracion que consulta el voucher
                wsResponseQueryBono = wsConsultarBonoIbcom(bonoIbcom.R2_VOU_TXT_Id_Bono__c,0);
                //bonoIbcom.R2_VOU_TXT_Email_Address__c = 'prueba@prueba.com';
                //
                System.debug('!!!wsResponseQueryBono: ' + wsResponseQueryBono);
                if (wsResponseQueryBono != null && wsResponseQueryBono.bonus != null) {
	                bonoIbcom.R2_VOU_TXT_Id_Bono__c = wsResponseQueryBono.bonus.id;
	                bonoIbcom.R2_VOU_TXT_Campaign_Commercial_Code__c = wsResponseQueryBono.bonus.campaignCommercialCode;
	                bonoIbcom.R2_VOU_TXT_Commercial_Code__c = wsResponseQueryBono.bonus.commercialCode;
	                bonoIbcom.R2_VOU_TXT_Campaign_Id__c = wsResponseQueryBono.bonus.campaignID;
	                bonoIbcom.R2_VOU_NUM_Maximum_Bonus_Consumption__c = wsResponseQueryBono.bonus.maximumPermittedUse != null ? decimal.valueOf(wsResponseQueryBono.bonus.maximumPermittedUse) : null;
	                //if (wsResponseQueryBono.bonus.maximumPermittedUse != null) {bonoIbcom.R2_VOU_NUM_Maximum_Bonus_Consumption__c = decimal.valueOf(wsResponseQueryBono.bonus.maximumPermittedUse);}
	                bonoIbcom.R2_VOU_PKL_Discount_Type__c = wsResponseQueryBono.bonus.discountType;
	                //bonoIbcom.R2_VOU_NUM_Discount_Value__c = wsResponseQueryBono.bonus.discountValue != null ? decimal.valueOf(wsResponseQueryBono.bonus.discountValue) : null;
	                //if (wsResponseQueryBono.bonus.discountValue != null){bonoIbcom.R2_VOU_NUM_Discount_Value__c = decimal.valueOf(wsResponseQueryBono.bonus.discountValue);}
	                bonoIbcom.R2_VOU_PKL_Coin__c = wsResponseQueryBono.bonus.currencyCode;
	                //discountPercentage
	                //commercialCompanyCode
	                bonoIbcom.R2_VOU_CHK_Allow_Unselected_Operators__c = wsResponseQueryBono.bonus.allowUnselectedOperators != null ? boolean.valueOf(wsResponseQueryBono.bonus.allowUnselectedOperators) : null;
	                //if (wsResponseQueryBono.bonus.allowUnselectedOperators != null) {bonoIbcom.R2_VOU_CHK_Allow_Unselected_Operators__c = boolean.valueOf(wsResponseQueryBono.bonus.allowUnselectedOperators);}
	                bonoIbcom.R2_VOU_CHK_Redeem_Reservation__c = wsResponseQueryBono.bonus.reservationRedeemabilityIndicator != null ? boolean.valueOf(wsResponseQueryBono.bonus.reservationRedeemabilityIndicator) : null;
	                //if (wsResponseQueryBono.bonus.reservationRedeemabilityIndicator != null) {bonoIbcom.R2_VOU_CHK_Redeem_Reservation__c = boolean.valueOf(wsResponseQueryBono.bonus.reservationRedeemabilityIndicator);}
	                if (wsResponseQueryBono.bonus.operatingCompanies != null){
	                 	bonoIbcom.R2_VOU_TXT_Operating_Companies__c = '';
	                 	for (String comp : wsResponseQueryBono.bonus.operatingCompanies.companyCode){
	                 		bonoIbcom.R2_VOU_TXT_Operating_Companies__c   = bonoIbcom.R2_VOU_TXT_Operating_Companies__c + comp + ';';
	                 	}
	                 	bonoIbcom.R2_VOU_TXT_Operating_Companies__c = bonoIbcom.R2_VOU_TXT_Operating_Companies__c.removeEnd(';');
		            }
	                if (wsResponseQueryBono.bonus.validity != null){
	                	bonoIbcom.R2_VOU_DATH_Effective_Date_From__c = wsResponseQueryBono.bonus.validity.startDateTime != null ? Datetime.valueOf(wsResponseQueryBono.bonus.validity.startDateTime) : null;
	                	if (wsResponseQueryBono.bonus.validity.startDateTime != null){bonoIbcom.R2_VOU_DATH_Effective_Date_From__c = Datetime.valueOf(wsResponseQueryBono.bonus.validity.startDateTime);}
	                }
	                if (wsResponseQueryBono.bonus.validity != null){
	                	bonoIbcom.R2_VOU_DATH_Effective_Date_To__c = wsResponseQueryBono.bonus.validity.endDateTime != null ? Datetime.valueOf(wsResponseQueryBono.bonus.validity.endDateTime) : null;
	                	if (wsResponseQueryBono.bonus.validity.endDateTime != null){bonoIbcom.R2_VOU_DATH_Effective_Date_To__c = Datetime.valueOf(wsResponseQueryBono.bonus.validity.endDateTime);}
	                }
	                if (wsResponseQueryBono.bonus.DiscountConcept != null){
	                 	bonoIbcom.R2_VOU_TXT_Discount_Concept__c = '';
	                 	for (String concepto : wsResponseQueryBono.bonus.discountConcept.conceptCode){
	                 		bonoIbcom.R2_VOU_TXT_Discount_Concept__c = bonoIbcom.R2_VOU_TXT_Discount_Concept__c + concepto + ';';
	                 	}
	                 	bonoIbcom.R2_VOU_TXT_Discount_Concept__c = bonoIbcom.R2_VOU_TXT_Discount_Concept__c.removeEnd(';');
		            }
		            bonoIbcom.R2_VOU_CHK_User_logged__c = wsResponseQueryBono.bonus.logInUserRequiredIndicator != null ? boolean.valueOf(wsResponseQueryBono.bonus.logInUserRequiredIndicator) : null;
					//if (wsResponseQueryBono.bonus.logInUserRequiredIndicator != null) {bonoIbcom.R2_VOU_CHK_User_logged__c = boolean.valueOf(wsResponseQueryBono.bonus.logInUserRequiredIndicator);}
	                bonoIbcom.R2_VOU_CHK_Sunday_Rule__c = wsResponseQueryBono.bonus.sundayRuleApplicabilityIndicator != null ? boolean.valueOf(wsResponseQueryBono.bonus.sundayRuleApplicabilityIndicator) : null;
	                //if (wsResponseQueryBono.bonus.sundayRuleApplicabilityIndicator != null) {bonoIbcom.R2_VOU_CHK_Sunday_Rule__c = boolean.valueOf(wsResponseQueryBono.bonus.sundayRuleApplicabilityIndicator);}
	   				if (wsResponseQueryBono.bonus.departureDays != null){
	                 	bonoIbcom.R2_VOU_TXT_Days_Departure__c = '';
	                 	for (String dia : wsResponseQueryBono.bonus.returnDays.dayCode){
	                 		bonoIbcom.R2_VOU_TXT_Days_Departure__c = bonoIbcom.R2_VOU_TXT_Days_Departure__c + dia + ';';
	                 	}
	                 	bonoIbcom.R2_VOU_TXT_Days_Departure__c = bonoIbcom.R2_VOU_TXT_Days_Departure__c.removeEnd(';');
	                }
	   				if (wsResponseQueryBono.bonus.returnDays != null){
	                 	bonoIbcom.R2_VOU_TXT_Days_Return__c = '';
	                 	for (String dia : wsResponseQueryBono.bonus.returnDays.dayCode){
	                 		bonoIbcom.R2_VOU_TXT_Days_Return__c = bonoIbcom.R2_VOU_TXT_Days_Return__c + dia + ';';
	                 	}
	                 	bonoIbcom.R2_VOU_TXT_Days_Return__c = bonoIbcom.R2_VOU_TXT_Days_Return__c.removeEnd(';');
	                }
	                bonoIbcom.R2_VOU_DATH_Bonus_Consumption_Date__c = wsResponseQueryBono.bonus.consumptiondate != null ? Datetime.valueOf(wsResponseQueryBono.bonus.consumptiondate) : null;
				   	//if (wsResponseQueryBono.bonus.consumptiondate != null) {bonoIbcom.R2_VOU_DATH_Bonus_Consumption_Date__c = Datetime.valueOf(wsResponseQueryBono.bonus.consumptiondate);}
				   	bonoIbcom.R2_VOU_DAT_Date_First_Consumption_Bono__c = wsResponseQueryBono.bonus.firstConsumptiondate != null ? Date.valueOf(wsResponseQueryBono.bonus.firstConsumptiondate) : null;
				   	//if (wsResponseQueryBono.bonus.firstConsumptiondate != null) {bonoIbcom.R2_VOU_DAT_Date_First_Consumption_Bono__c = Date.valueOf(wsResponseQueryBono.bonus.firstConsumptiondate);}
	   				bonoIbcom.R2_VOU_NUM_Number_Uses_Bonus__c = wsResponseQueryBono.bonus.bonusUsageCount != null ? decimal.valueOf(wsResponseQueryBono.bonus.bonusUsageCount) : null;
	   				//if (wsResponseQueryBono.bonus.bonusUsageCount != null) {bonoIbcom.R2_VOU_NUM_Number_Uses_Bonus__c = decimal.valueOf(wsResponseQueryBono.bonus.bonusUsageCount);}
	                bonoIbcom.R2_VOU_NUM_Consumed_Amount__c = wsResponseQueryBono.bonus.amountconsumed != null ? decimal.valueOf(wsResponseQueryBono.bonus.amountconsumed) : null;
	                //if (wsResponseQueryBono.bonus.amountconsumed != null) {bonoIbcom.R2_VOU_NUM_Consumed_Amount__c = decimal.valueOf(wsResponseQueryBono.bonus.amountconsumed);}
	                bonoIbcom.R2_VOU_NUM_Counter_Uses_Bono__c = wsResponseQueryBono.bonus.counterUseBonus != null ? decimal.valueOf(wsResponseQueryBono.bonus.counterUseBonus) : null;
	                //bonoIbcom.R2_VOU_NUM_Counter_Uses_Bono__c = decimal.valueOf(wsResponseQueryBono.bonus.counterUseBonus);
				   	//creationDate
				   	//modificationDate
				   	bonoIbcom.R2_VOU_DATH_Date_Reservation__c = wsResponseQueryBono.bonus.reservationdate != null ? Datetime.valueOf(wsResponseQueryBono.bonus.reservationdate) : null;
				   	//bonoIbcom.R2_VOU_DATH_Date_Reservation__c = Datetime.valueOf(wsResponseQueryBono.bonus.reservationdate);
                }
            }
            System.debug('!!!bonoIbcom: ' + bonoIbcom);
            update bonoIbcom;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BonosIberiacom.consultarBonoIberiacom()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Integration to gestor de bonos to query about the id given
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    14/03/2018          Alvaro Garcia Tapia	   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/       
    public static WsResponseQueryBono wsConsultarBonoIbcom (String idBono, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            string wsMethod = 'R2_IberiaComBonos';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return wsConsultarBonoIbcom(idBono,intentos);
                }else{
                    return null;
                }
            }
            System.debug('Ha funcionado el login: '+ token);
			
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c +idBono;
           System.debug(LoggingLevel.Info,'EndPoint: ' +  endPoint);
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('BonoIberiacom');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            
            Http http = new Http();
            HTTPResponse res;
            res = http.send(req);
            System.debug(LoggingLevel.Info,'Body: '+ res.getBody());
            System.debug(LoggingLevel.Info,'Status: '+ res.getStatusCode());
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203 || res.getStatusCode() == 0){
            	String resultBody = res.getBody().replace('currency', 'currencyCode');
            	//resultBody = res.getBody().replace('MinimumPre-departureInterval', 'MinimumPre_departureInterval');
            	System.debug(LoggingLevel.Info,'resultBody: '+ resultBody);
                wsResponseQueryBono resp = (wsResponseQueryBono)JSON.deserialize(resultBody,wsResponseQueryBono.class);
                if(resp == null){
                    return null;
                }
                return resp;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return wsConsultarBonoIbcom(idBono, intentos);
                }else{
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Iberia_Voucher_TriggerMethod.wsConsultarBonoIbcom()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Voucher');
            return null;
        }
    }
	
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Integration to gestor de bonos to cancel the last use of the voucher 
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    15/03/2018          Alvaro Garcia Tapia	   	 Initial version
    23/03/2018			Alvaro Garcia Tapia		 Not in use, If they need to cancel the use of bono Iberiacom, only uncomment
--------------------------------------------------------------------------------------------------------------------------------------------------------*/    	
	//@future(callout=true)
	//WebService static String cancelarBonoIbcom(String idBono, String bookingReference ){
	//	try{
 //   		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            
 //           Id idVoucher = Id.valueOf(idBono);
 //           R2_Voucher__c bono = [SELECT Id, R2_VOU_TXT_Id_Bono__c, R2_VOU_NUM_Discount_Value__c FROM R2_Voucher__c WHERE Id=:idVoucher];
 //           System.debug('!!!id: '+ idbono +' idBono: ' + bono.R2_VOU_TXT_Id_Bono__c + ' importe: ' + String.valueof(bono.R2_VOU_NUM_Discount_Value__c) + ' bookingReference: ' + bookingReference);
 //           String resultado = wsAnularbonoParcial (bono.R2_VOU_TXT_Id_Bono__c, String.valueof(bono.R2_VOU_NUM_Discount_Value__c), bookingReference, 0);                 
 //           return resultado;
 //           //if (resultado == 'OK'){
 //           //	bono.R2_VOU_PKL_STATUS__c = 'CANCELADO';
 //           //}else{
 //           //	bono.R2_VOU_PKL_STATUS__c = 'RECHAZADO';
 //           //}
 //           //update bono;
      
 //       }catch(Exception exc){
	//		R1_CLS_LogHelper.generateErrorLog('R2_CLS_BonosIberiacom.cancelarBonoIbcom()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
	//		return 'KO';
	//	}
	//	//return null;
		
	//}
	
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Integration to gestor de bonos to cancel the last use of the voucher 
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    15/03/2018          Alvaro Garcia Tapia	   	 Initial version
    23/03/2018			Alvaro Garcia Tapia		 Not in use, If they need to cancel the use of bono Iberiacom, only uncomment
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
	//public static String wsAnularbonoParcial (String id, String importe, String bookingReference,Integer intentos){
 //       try{
 //           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
 //           string wsMethod = 'R2_IberiaComBonos';

 //           if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
 //                   return null;
 //           }
 //           String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
 //           if(token ==null){
 //               if(intentos<3){
 //                   intentos= intentos+1;
 //                   R1_CLS_SendCustomerMDM.login();
 //                   return wsAnularbonoParcial(id,importe,bookingReference,intentos);
 //               }else{
 //                   return null;
 //               }
 //           }
 //           System.debug('Ha funcionado el login: '+ token);

 //           HttpRequest req = new HttpRequest();
 //           String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c  +id +'/cancelconsumption';
 //           System.debug('EndPoint: ' +  endPoint);
 //           req.setHeader('Authorization', 'Bearer ' + token); 
 //           req.setEndpoint(endPoint);
            
 //           WpRequestCancelBono wpParametrosEntrada= new WpRequestCancelBono();
 //           wpParametrosEntrada.id = id;
 //           wpParametrosEntrada.amount = importe; 
 //           wpParametrosEntrada.bookingReference = bookingReference;
            
 //           String body = JSON.serialize(wpParametrosEntrada);
 //           System.debug('!!!body:' + body);
 //           req.setBody(body);
            
 //           req.setMethod('POST');
 //           req.setHeader('Content-Type', 'application/json');
 //           TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('BonoIberiacom');
 //           req.setTimeout((Integer)timeOut.setTimeOut__c);

 //           Http http = new Http();
 //           HTTPResponse res;
 //           res = http.send(req);
 //           System.debug('Body: '+ res.getBody());
 //           System.debug('Status: '+ res.getStatusCode());
 //           if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203 || res.getStatusCode() == 0){
 //           	String error;// = '';
 //           	wsResponseCancelBono resp = (wsResponseCancelBono)JSON.deserialize(res.getBody(),wsResponseCancelBono.class);
 //           	if (resp.error != null) {
 //           		error = 'Codigo del Error: '+ resp.error.errorCode + ' --> ' + resp.error.errorDescription;
 //           		return error;
 //           	}
 //               else {
 //               	return 'OK';
 //               }
 //           }else{
 //               if(intentos<3 && res.getStatusCode() == 401){
 //                   intentos += 1;
 //                       R1_CLS_SendCustomerMDM.login();
 //                       return wsAnularbonoParcial(id,importe,bookingReference,intentos);
 //               }else{
 //               	return 'KO';
 //               }
 //           }

 //       }catch(Exception exc){
 //           R1_CLS_LogHelper.generateErrorLog('R2_CLS_BonosIberiacom.wsAnularbonoParcial()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Flight');
 //           return 'KO';
 //       }
 //   }



	// //@future(callout=true)
    // WebService static String anularEbono(String idBono){
    // 	try{
    // 	 if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
    //                 Id idVoucher = Id.valueOf(idBono);
    //                 R2_Voucher__c bono = [SELECT Id, R2_VOU_NUM_Consumed_Amount__c,R2_VOU_TXT_Passenger_Record_Locator__c FROM R2_Voucher__c WHERE Id=:idVoucher];
    //                 String resultado='';
    //                 //String resultado = wsAnularEbono (bono.id, String.valueof(bono.R2_VOU_NUM_Consumed_Amount__c),0);                 
    //                 if (resultado == 'OK'){
    //                 	bono.R2_VOU_PKL_STATUS__c = 'ANULADO';
    //                 }else{
    //                 	bono.R2_VOU_PKL_STATUS__c = 'RECHAZADO';
    //                 }
    //                 update bono;
    //                 //Llama a webservice de anulacion de bono
    //                 //System.debug('resp' + resp);
                    
    //       }catch(Exception exc){

	// 		R1_CLS_LogHelper.generateErrorLog('R2_CLS_BonosIberiacom.anularEbono()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
	// 	}
	// 	return null;
    // }
    
    
    // public static String wsAnularEbono (String id, Integer intentos){
	// 	try{
    //         if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
    //         string wsMethod = 'anulacionBono';

    //         if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
    //                 return null;
    //         }
    //         String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
    //         if(token ==null){
    //             if(intentos<3){
    //                 intentos= intentos+1;
    //                 R1_CLS_SendCustomerMDM.login();
    //                 return wsAnularEbono(id,intentos);
    //             }else{
    //                 return null;
    //             }
    //         }
    //         System.debug('Ha funcionado el login: '+ token);

    //         HttpRequest req = new HttpRequest();
    //         String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c  +id +'/anulacionid'; //api/pvm-vcm/rs/v1/vouchers/{id}
    //         System.debug('EndPoint: ' +  endPoint);
    //         req.setHeader('Authorization', 'Bearer ' + token); 
    //         req.setEndpoint(endPoint);
    //         req.setMethod('DELETE');
    //         req.setHeader('Content-Type', 'application/json');
    //         TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('BonoIberiacom');
    //         req.setTimeout((Integer)timeOut.setTimeOut__c);
            
    //         Http http = new Http();
    //         HTTPResponse res;
    //         res = http.send(req);
    //         System.debug('Body: '+ res.getBody());
    //         System.debug('Status: '+ res.getStatusCode());
    //         if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203 || res.getStatusCode() == 0){
    //             return 'OK';
    //         }else{
    //             if(intentos<3 && res.getStatusCode() == 401){
    //                 intentos+=1;
    //                     R1_CLS_SendCustomerMDM.login();
    //                     return wsAnularEbono(id,intentos);
    //             }else{
    //                 return 'KO';
    //             }
    //         }

    //     }catch(Exception exc){
    //         R1_CLS_LogHelper.generateErrorLog('R2_CLS_BonosIberiacom.wsAnularEbono()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Flight');
    //         return 'KO';
    //     }
    // }



}