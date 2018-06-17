/*---------------------------------------------------------------------------------------------------------------------
Author:         Alberto Puerto Collado
Company:        Accenture
Description:    R2_CLS_InboxTelex class
IN:             
OUT:            

History: 
 <Date>                     <Author>                         <Change Description>
02/03/2018             Alberto Puerto Collado                  Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_InboxTelex {
	//WRAPPERS
		//REQUEST 
		//empty - Consumers need to only invoke the Int Int URL to trigger the call to Stratus, and not required to pass any input elements
		//			Int Int service should query the Stratus queue by using the port-PID numbers and endpoints
	
		//RESPONSE
	public class WR_ReadInbox_TELEX_Resp{
        public String success;
        public Header header;
        public List<TelexMessages> telexMessages;
        public List<errorType> errors;
    }

    public class TelexMessages{
    	public String destination;
        public String origin;
        public String messageText;
    }

    public class Header{
    	public String start;
        public String serial;
        public String dateTime_r;
    }

    public class ErrorType{
        public String code;
        public String reason;
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling DXF_createRequest() for each area 

    IN:		
    OUT:        

    History:

    <Date>              <Author>            	<Description>
    02/03/2018    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void initGetTelex(){
    	try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

    		System.debug('::Comienzo initGetTelex');

            scheduleNextTELEX();
            System.debug('::Siguiente job ya planificado');
    		callInboxMessageTelex();        
    	}catch(Exception exc){
    		R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.initGetTelex', 'Error en initGetTelex', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
    	}
    }



/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Asynchronous @future method which call ServiceRead_TELEX()

    IN:		
    OUT:         

    History:

    <Date>              <Author>            	<Description>
    02/03/2018    Alberto Puerto Collado   		Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @future(Callout = true)
    public static void callInboxMessageTelex(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
           
            WR_ReadInbox_TELEX_Resp respuesta = ServiceRead_TELEX(0);
            if(respuesta != null){
    			if(respuesta.errors == null){
    				System.debug('::Llamada a insertTelex con mensajes descargados');
    				insertTELEX(respuesta);
				}else {
					System.debug('::Errores:' + respuesta.errors);
				}	
    		}else{
    			System.debug('::Respuesta vacía o nula en callInboxMessageTelex');
    		}   
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.callInboxMessageTelex', 'Error en el calling de callInboxMessageTelex', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Class to manage INTEGRATION of TELEX records - Inbox Message TELEX

    IN:		1) Intentos: count the tries to connect with login (integration conection with IBIS)

    OUT:    -> WR_ReadInbox_TELEX_Resp: wrapper which is fulfilled with success, list of messages and list of warnings
    																	or with list of errors       

    History:

    <Date>              <Author>           		<Description>
    02/03/2018    Alberto Puerto Collado        Initial Version
    25/04/2018    Alberto Puerto Collado        Retry service after Timeout try
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static WR_ReadInbox_TELEX_Resp ServiceRead_TELEX(Integer intentos){
        try{
        	System.debug('::Comienzo ServiceRead_TELEX');
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_ReadTelex'; // [pre|pro] + /api/bgm-scm/rs/v1/telex/message
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '' ,'El endpoint R2_ReadTelex está inactivo o no existe', 'R2_MG_Message__c');
                return null;
            }

            HttpRequest req = new HttpRequest();

            System.debug('::endpoint value: ' + R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);// + 'messages/inbox');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return ServiceRead_TELEX(intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '' ,'Error en login tras 3 intentos de conexión', 'R2_MG_Message__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('GET');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');//mismo TimeOut
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);


            //String body = wrapper; - TELEX does not use body
            //System.debug(':::Body antes de http.send: '+body);
            //req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            System.debug(':::Este el el body despues .send: ' + res.getBody());
            if(res.getBody() != null && res.getBody() != ''){
                String jsonString =res.getBody();
                String jsonReplacedString = jsonString.replace('dateTime', 'dateTime_r');
                System.debug(':::Este es el body con valores replaced: '+ jsonReplacedString);

                WR_ReadInbox_TELEX_Resp resp = (WR_ReadInbox_TELEX_Resp)JSON.deserialize(jsonReplacedString,WR_ReadInbox_TELEX_Resp.class);
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203 
                    || res.getStatusCode() == 204){
                    if(res.getStatusCode() == 204){
                        System.debug(':::status 204 = NO hay mensajes telex en la queue de Stratus: '+resp);
                        return null; //cambiado a null, ahora body empty
                    }else{
                        System.debug(':::RESP válida: '+resp);
                        return resp;
                    }     
                }else {
                    if(intentos<3 && (res.getStatusCode() == 401 || res.getStatusCode() == 408)){//added 25/04 status  408
                        intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        ServiceRead_TELEX(intentos);
                        return null;
                    }else if(res.getStatusCode() == 408){
                        System.debug(':::TIMEOUT EXTERNO entre II y Stratus - statusCode 408 / intento:' + intentos);
                        R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '', 'Error externo entre TCS y Stratus: Not able to connect Stratus - Connection Timeout', 'R2_MG_Message__c');
                        return null;
                    }else if(res.getStatusCode() == 500){
                        System.debug(':::II responde: Technical Error Occurred');
                        R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '', 'TCS answer: Technical Error Occurred', 'R2_MG_Message__c');
                        return resp;
                    }else{
                        if(intentos<3){
                            return resp;
                        }
                        R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '', 'Error en ServiceRead_TELEX', 'R2_MG_Message__c');
                        return null;
                    }
                }
            }else{
                return null;
            }
            
        }catch(CalloutException exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', 'CalloutException', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
            System.debug(':::TIMEOUT exception:  '+ exc);
            if(intentos < 3){
                R1_CLS_SendCustomerMDM.login();
                intentos += 1;
                ServiceRead_TELEX(intentos);
                return null;
            }
            else{
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '' ,'Error en login', 'R2_MG_Message__c');
                return null;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.ServiceRead_TELEX', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
            return null;
        }
    }
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    insert TELEX files on Salesforce Database. This class will be called by scheduled jobs each 1 hour, always will be new TELEX

    IN:		1) Wrapper used as request
    		

    OUT:    

    History:

    <Date>              <Author>            	<Description>
    02/03/2018    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void insertTELEX(WR_ReadInbox_TELEX_Resp resp){
    	 try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

	    	System.debug(':::insertTELEX:');
	    		    	
	    	if(resp != null){
	    		//cola a la que adjudicar los mensajes:  -> VERIFICAR
	    		Id queueTelex = [SELECT QueueId FROM QueueSObject WHERE Queue.Developername = 'R2_Action_File' LIMIT 1].QueueId;

	    		//R2_Job_Telex_Inbox__c setDay = R2_Job_Telex_Inbox__c.getInstance('R2_UltimaActualizacionTelex_JOB');
	    		
		    	String idRT = Schema.SObjectType.R2_MG_Message__c.getRecordTypeInfosByName().get('SCM Telex').getRecordTypeId();

		    	List<R2_MG_Message__c> lstMessages = new List<R2_MG_Message__c>();
		    	for(Integer i = 0; i < resp.telexMessages.size(); i++){
			    	//para 1, temporal:
			    	R2_MG_Message__c message = new R2_MG_Message__c();
			    		message.OwnerId = queueTelex;
			    		message.RecordTypeId = idRT;
			    		message.R2_MG_ATXT_Message__c = resp.telexMessages[i].messageText;
			    		message.R2_MG_PKL_Type__c = 'Entrante';
			    		message.R2_MG_TXT_Destination__c = resp.telexMessages[i].destination;
			    		message.R2_MG_TXT_Origin__c = resp.telexMessages[i].origin;
			    		if(resp.header != null){
			    			message.R2_MG_TXT_Start__c = resp.header.start; //hardcodea II a ZCZC
				    		message.R2_MG_TXT_Sequence_number__c = resp.header.serial; //me lo hardcodean a 001 siempre
				    		// format datetime -> MMddHHmm + year currentYear 
				    		if(resp.header.dateTime_r != null){
				    			String dateTim = resp.header.dateTime_r;
				    			message.R2_MG_DATH_Reception_Date__c = Datetime.newInstance(System.Today().year(), 
				    																	Integer.valueOf(dateTim.substring(0, 2)), 
				    																	Integer.valueOf(dateTim.substring(2, 4)),
				    																	Integer.valueOf(dateTim.substring(4, 6)),
				    																	Integer.valueOf(dateTim.substring(6, 8)),
				    																	0);
				    		}
			    		}
			    	System.debug(':::message:' + message);	
		    		lstMessages.add(message);
				}	
		    	insert lstMessages;
		    	System.debug(':::Telex insertados:' + lstMessages);	    	
	    	}else{
	    		System.debug(':::Sin registros de TELEX');
	    	}	   

    	}catch(DmlException exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.insertTELEX', 'Error DML al insertar la lista de mensajes TELEX', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.insertTELEX', 'Error con insertTELEX method', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
        }
    }
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    schedule Next TELEX (each hour)

    IN:     
    OUT:    

    History:

    <Date>              <Author>                <Description>
    13/03/2018    Alberto Puerto Collado        Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void scheduleNextTELEX(){
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug(':::scheduleNextTELEX method:');
            //Programación del siguiente job:
            Datetime ahora = Datetime.now();
            Datetime plusHora = ahora.addHours(+1);

            System.schedule('R2_JOB_WT_readTelex' + DateTime.now(), R1_CLS_Utilities.generateStrProg(plusHora), new R2_JOB_WT_readTelex());
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxTelex.insertTELEX', 'Error con scheduleNextTELEX method', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c');
        }
    }


}