/*---------------------------------------------------------------------------------------------------------------------
Author:         Alberto Puerto Collado
Company:        Accenture
Description:    World Tracer - Inbox Message Read (DXF) Action File class
IN:             
OUT:            

History: 
 <Date>                     <Author>                         <Change Description>
21/12/2017             Alberto Puerto Collado                  Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_InboxMessageRead {
	//WRAPPERS
		//REQUEST
	public class WR_InboxMessageSend_DXF_request{
        public InboxMessageSearch inboxMessageSearch;
        public String agentId;
    }
		//RESPONSE
	public class WR_ReadInboxMessage_DXF_Resp{
        public String success;
        public MessagesType messages;
        public List<WarningType> warnings;
        public List<errorType> errors;
    }
    	//COMMONs
    public class InboxMessageSearch{
    	public InboxAreaAddress inboxAreaAddress;
    }
    public class InboxAreaAddress{
    	public String stationCode;
    	public String airlineCode;
    	public String areaType;
    	public String rDate;
    }
    public class MessagesType{
        public String messageCount;
        public List<ReadInboxMessageType> messages;
    }
    public class ReadInboxMessageType{
        public String rDate;
        public String sequenceNumber;
        public String message;
    }
    public class WarningType{
        public String warningCode;
        public String warningDescription;
    }
    public class ErrorType{
        public String code;
        public String reason;
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling DXF_createRequest() for each area 

    IN:		Boolean conFecha: in order to search for one day or for the last 7 days
    OUT:        

    History:

    <Date>              <Author>            	<Description>
    22/12/2017    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void packAreasDXF(Boolean conFecha){
    	try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

    		String currentDay = '';
    		if(conFecha){
    			R2_Job_WT_DXF_SetDay__c setDay_DXF = R2_Job_WT_DXF_SetDay__c.getInstance('R2_UltimaActualizacion_JOB');
    			Datetime fecha = setDay_DXF.R2_DT_WT_HoraInicio__c;

    			System.debug(':::Fecha custom setting: ' + fecha);
    			//System.debug(':::Date.valueOf(fecha): ' + Date.valueOf(fecha));
    			//System.debug(':::Date.today(): ' + Date.today());
    			if(Date.valueOf(fecha).day() == Date.today().day()
    				&& Date.valueOf(fecha).month() == Date.today().month()
    				&& Date.valueOf(fecha).year() == Date.today().year()){
    				currentDay = String.valueOf(Date.valueOf(fecha));
    				System.debug(':::Dia coincide con CustomSetting, currentDay=' + currentDay);
				}else{
					currentDay = null;
				}
    			Datetime fecha2 = Datetime.now().addMinutes(5);
    			if(fecha.day() != fecha2.day()){
    				setDay_DXF.R2_NUM_DXF_Counter_AA__c = 0;
    				setDay_DXF.R2_NUM_DXF_Counter_AP__c = 0;
    				setDay_DXF.R2_NUM_DXF_Counter_SP__c = 0;
    				setDay_DXF.R2_NUM_DXF_Counter_PR__c = 0;
    			}

    			System.debug(':::Fecha custom setting MAS CINCO: ' + fecha2);
    			setDay_DXF.R2_DT_WT_HoraInicio__c = fecha2;
    			update setDay_DXF;
    			System.debug(':::custom setting setDay_DXF updateado: ' + setDay_DXF);    			

    			//Programación del siguiente job:
    			DateTime ahora = Datetime.now();
    				//ahora = ahora.addMinutes(+2); //+1 vale, pero dejo +2 para manejar la última programación del día
    			DateTime tenMinutes = Datetime.now().addMinutes(+10);
    			Datetime lastMinute = Datetime.newInstanceGMT(ahora.year(), ahora.month(), ahora.day()) ;
	    			lastMinute = lastMinute.addDays(+1);
	    			lastMinute = lastMinute.addMinutes(-1);
    			//últimos 10 minutos del día, programado al último minuto del día
    			if(!tenMinutes.isSameDay(ahora)){
    				if(ahora.minute() >= 55){
    					//si es el último del día (59) -> al día siguiente
    					ahora.addDays(+1);
    					Datetime primeraDiaria = Datetime.newInstance(ahora.year(), ahora.month(), ahora.day(), 00, 05, 00);
    					System.schedule('R2_JOB_WT_readActionFiles_DXF' + DateTime.now(), R1_CLS_Utilities.generateStrProg(primeraDiaria), new R1_JOB_WT_readActionFiles_DXF());
					}else{
						//últimos 10 minutos del día, schedule a y 59
						System.schedule('R2_JOB_WT_readActionFiles_DXF' + DateTime.now(), R1_CLS_Utilities.generateStrProg(lastMinute), new R1_JOB_WT_readActionFiles_DXF());
					}
				}else{
	    			System.schedule('R2_JOB_WT_readActionFiles_DXF' + DateTime.now(), R1_CLS_Utilities.generateStrProg(fecha2), new R1_JOB_WT_readActionFiles_DXF());
				}   		
			}else{
				//look for the last 7 days
				currentDay = null; 
			}
			System.debug(':::conFecha: ' + conFecha + ' - Current day: -> ' + currentDay);

    		System.debug('DXF_createRequest de AA area type y fecha ' + currentDay);
            DXF_createRequest('AA', currentDay);
            System.debug('DXF_createRequest de AP area type y fecha ' + currentDay);
            DXF_createRequest('AP', currentDay);
            System.debug('DXF_createRequest de SP area type y fecha ' + currentDay);
            DXF_createRequest('SP', currentDay);
            System.debug('DXF_createRequest de PR area type y fecha ' + currentDay);
            DXF_createRequest('PR', currentDay);

    		
    	}catch(Exception exc){
    		R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.packAreasDXF', 'Error en packAreasDXF llamando a DXF_createRequest', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c  ');
    	}
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Create request of DXF service (WORLDTRACER ACTION FILE read inbox message)

    IN:		String areaType: area type of DXF
    		String fecha: Date of that DXF file
    OUT:        

    History:

    <Date>              <Author>            	<Description>
    22/12/2017    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void DXF_createRequest(String areaType, String fecha){
    	try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            
            WR_InboxMessageSend_DXF_request wrp = new WR_InboxMessageSend_DXF_request();
            	InboxMessageSearch ims = new InboxMessageSearch();
            		InboxAreaAddress iaa = new InboxAreaAddress();
            		iaa.stationCode = 'MAD';
            		iaa.airlineCode = 'IB';
            		iaa.areaType = areaType; // [AA, AP, SP, PR]
            		iaa.rDate = fecha; //'2017-12-21'; //Used to search for messages on specific dates. Only the last seven days (including the current day) can be specified.
									//If no date is specified in the request, then messages of the last seven days wil be retrieved.
									//YYYY-MM-DD
            	ims.inboxAreaAddress = iaa;
            wrp.inboxMessageSearch = ims;
            wrp.agentId = 'Agente'; //verificar con qué se mapea, propuesta-> alias del user que ejecuta la acción

            System.debug(':::WR_InboxMessageSend_DXF_request: ' + wrp);
            String wrapper = JSON.serialize(wrp);
            System.debug(':::wrapper: ' + wrapper);

    		callInboxMessageRead_DXF(wrapper, areaType);
    	}catch(Exception exc){
    		R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.DXF_createRequest', 'Error con la creación de la request', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c  ');
            //return null;
    	}
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Asynchronous @future method which call InboxMessageRead_DXF()

    IN:		1) Wrapper used as request
    		2) String fecha: Date of that DXF file
    OUT:    void       

    History:

    <Date>              <Author>            	<Description>
    22/12/2017    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @future(Callout = true)
    public static void callInboxMessageRead_DXF(String wrapper, String areaType){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
           
            WR_ReadInboxMessage_DXF_Resp respuestaDXF = InboxMessageRead_DXF(wrapper, 0);
            if(respuestaDXF != null){
               if(respuestaDXF.errors == null || respuestaDXF.errors.isEmpty()){
                    insertDXFs(respuestaDXF, areaType);
                }else{
                    System.debug(':::Errores al leer DXF files:'+respuestaDXF.errors);//es Scheduled Job, no se muestran ni guardan los errores
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.callInboxMessageRead_DXF', 'Error en el calling de InboxMessageRead_DXF', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c  ');
        }
    }
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Class to manage INTEGRATION of DXF records - Inbox Message Action File

    IN:		1) Wrapper used as request
    		2) Intentos: count the tries to connect with login (integration conection with IBIS)

    OUT:    -> WR_ReadInboxMessage_DXF_Resp: wrapper which is fulfilled with success, list of messages and list of warnings
    																	or with list of errors       

    History:

    <Date>              <Author>           		<Description>
    22/12/2017    Alberto Puerto Collado   		Migration to this class & fix and end the integration
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static WR_ReadInboxMessage_DXF_Resp InboxMessageRead_DXF(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'messages/inbox');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return InboxMessageRead_DXF(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.InboxMessageRead_DXF', wrapper ,'Error en login', 'R2_MG_Message__c  ');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            //WR_InboxMessageSend_DXF_request wrp = new WR_InboxMessageSend_DXF_request();

            //String body = JSON.serialize(wrp);
            //String body = '{            "inboxMessageSearch": {      "inboxAreaAddress": {        "stationCode": "MAD",        "airlineCode": "IB",        "areaType": "AA",        "date": "2017-10-17"      }    },    "agentId": "Test"  }}';
            String body = wrapper;
            body = body.replace('rDate', 'date');
            System.debug(':::Body antes de http.send: '+body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            System.debug(':::Este el el body despues .send: ' + res.getBody());
            String jsonString =res.getBody();
            String jsonReplacedString = jsonString.replace('date', 'rDate');
            System.debug(':::Este es el body con valores replaced: '+ jsonReplacedString);

            WR_ReadInboxMessage_DXF_Resp resp = (WR_ReadInboxMessage_DXF_Resp)JSON.deserialize(jsonReplacedString,WR_ReadInboxMessage_DXF_Resp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_ReadInboxMessage_DXF_Resp resp = (WR_ReadInboxMessage_DXF_Resp)JSON.deserialize(jsonReplacedString,WR_ReadInboxMessage_DXF_Resp.class);
                System.debug(':::RESSSPPPPPP '+resp);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    InboxMessageRead_DXF(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.InboxMessageRead_DXF', wrapper, 'Error en InboxMessageRead_DXF', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(CalloutException exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.InboxMessageRead_DXF', 'CalloutException', exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c  ');
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.InboxMessageRead_DXF', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_MG_Message__c  ');
            return null;
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    insert DXF files on Salesforce Database. This class will be called by scheduled jobs each 5 or 10 minutes, only will be inserted those new values
    				DXFs only can be downloaded during the last 7 days

    IN:		1) Wrapper used as request
    		2) String fecha: Date of that DXF file

    OUT:    

    History:

    <Date>              <Author>            	<Description>
    22/12/2017    Alberto Puerto Collado    	Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void insertDXFs(WR_ReadInboxMessage_DXF_Resp resp, String areaType){
    	 try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

	    	System.debug(':::Inserción de DXFs:');
	    	
	    	System.debug(':::resp.success:' + resp.success);
	    	if(resp.success == 'TRUE' || resp.success == 'YES'){
	    		//cola a la que adjudicar los mensajes:
	    		Id queueAF = [SELECT QueueId FROM QueueSObject WHERE Queue.Developername = 'R2_Action_File' LIMIT 1].QueueId;

	    		//Integer contadorDXF = (Integer)R2_Job_WT_DXF_SetDay__c.getInstance('R2_UltimaActualizacion_JOB').R2_SumDXFs__c;
		    	R2_Job_WT_DXF_SetDay__c setDay = R2_Job_WT_DXF_SetDay__c.getInstance('R2_UltimaActualizacion_JOB');
		    	
		    	Integer contadorDXF = null;
			    //Determinar qué tipo estamos tratando:
	    		if(areaType.equalsIgnoreCase('AA')){
    				contadorDXF = (Integer)setDay.R2_NUM_DXF_Counter_AA__c;			
    			}else if(areaType.equalsIgnoreCase('AP')){
    				contadorDXF = (Integer)setDay.R2_NUM_DXF_Counter_AP__c;
    				System.debug(':::AP contador anterior : ' + contadorDXF);
    			}else if(areaType.equalsIgnoreCase('SP')){
    				contadorDXF = (Integer)setDay.R2_NUM_DXF_Counter_SP__c;
    			}else if(areaType.equalsIgnoreCase('PR')){
    				contadorDXF = (Integer)setDay.R2_NUM_DXF_Counter_PR__c;
    			}
    			//reinicio instancia de setDay para sobreescribir sólo con el valor que interese, sin pisar el resto
    			Id setDayOldId = setDay.Id;
    			setDay = new R2_Job_WT_DXF_SetDay__c();
    			setDay.Id = setDayOldId;
		    	System.debug(':::setDay: ' + setDay);
		    	System.debug(':::contadorDXF: ' + contadorDXF);
		    	System.debug(':::resp.messages.messages.size(): ' + resp.messages.messages.size());

		    	String idRTactionfile = Schema.SObjectType.R2_MG_Message__c.getRecordTypeInfosByName().get('DXF').getRecordTypeId();
                String idRTtelex = Schema.SObjectType.R2_MG_Message__c.getRecordTypeInfosByName().get('SCM Telex').getRecordTypeId();

		    	List<R2_MG_Message__c> lstMessages = new List<R2_MG_Message__c>();
		    	for(Integer aux = contadorDXF; aux < resp.messages.messages.size(); aux++){
		    		R2_MG_Message__c message = new R2_MG_Message__c();
			    		message.R2_MG_ATXT_Message__c = resp.messages.messages[aux].message;
			    		message.R2_MG_TXT_Sequence_number__c = resp.messages.messages[aux].sequenceNumber;
			    		message.R2_MG_DAT_Reception_Date__c	 = Date.valueOf(resp.messages.messages[aux].rDate);
			    		message.OwnerId = queueAF;
			    		message.R2_MG_PKL_Type__c = 'Entrante';
                        //07/05/08 addedd
                        if(areaType != null){
                            message.R2_MG_TXT_Area__c = areaType;
                            message.RecordTypeId = idRTactionfile;
                        }else{
                            message.RecordTypeId = idRTtelex;
                        }
			    		System.debug(':::message:' + message);
		    		lstMessages.add(message);
		    		
		    		if(areaType.equalsIgnoreCase('AA')){
			    		setDay.R2_NUM_DXF_Counter_AA__c = Integer.valueOf(message.R2_MG_TXT_Sequence_number__c);	
	    			}else if(areaType.equalsIgnoreCase('AP')){
	    				System.debug(':::AP antes de setear setDay dia actual : ' + setDay.R2_NUM_DXF_Counter_AP__c );
			    		setDay.R2_NUM_DXF_Counter_AP__c = Integer.valueOf(message.R2_MG_TXT_Sequence_number__c);
			    		System.debug(':::AP DESPUES de setear setDay dia actual : ' + setDay.R2_NUM_DXF_Counter_AP__c );
	    			}else if(areaType.equalsIgnoreCase('SP')){
			    		setDay.R2_NUM_DXF_Counter_SP__c = Integer.valueOf(message.R2_MG_TXT_Sequence_number__c);
	    			}else if(areaType.equalsIgnoreCase('PR')){
			    		setDay.R2_NUM_DXF_Counter_PR__c = Integer.valueOf(message.R2_MG_TXT_Sequence_number__c);		    			
		    		}		    		
		    	}
		    	System.debug(':::setDay.R2_NUM_DXF_Counter_AP__c después : ' + setDay.R2_NUM_DXF_Counter_AP__c);
		    	insert lstMessages;
		    	System.debug(':::DXFs insertados:' + lstMessages);
		    	try{
		    		System.debug(':::R2_Job_WT_DXF_SetDay__c ANTES actualizar:' + setDay);
		    		update setDay;
		    		System.debug(':::R2_Job_WT_DXF_SetDay__c actualizado:' + R2_Job_WT_DXF_SetDay__c.getInstance('R2_UltimaActualizacion_JOB'));
	    		}catch(DmlException exc){
	    			R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.insertDXFs', 'Error DML al update el contador del custom setting', exc.getmessage()+', '+exc.getLineNumber(), 'R2_CLS_InboxMessageRead DXF Action File');
	    		}		    	
	    	}	    	
    	}catch(DmlException exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.insertDXFs', 'Error DML al insertar la lista de mensajes DXF', exc.getmessage()+', '+exc.getLineNumber(), 'R2_CLS_InboxMessageRead DXF Action File');
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.insertDXFs', 'Error con insertDXFs method', exc.getmessage()+', '+exc.getLineNumber(), 'R2_CLS_InboxMessageRead DXF Action File');
        }
    }
}