/*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Controller of R2_VF_TTY_Messages
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017             		Jaime Ascanta                  		Initial Version
    24/11/2017             		Alberto Puerto Collado				Extended version
    09/01/2018             		Alberto Puerto Collado             	Saving record on SF
    ----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_TTY_Messages_CTRL {

	public String inputTX{get;set;}{inputTX = '';}
	public String messageTextarea{get;set;}{messageTextarea = '';}
	public String response{get;set;}{response = '';}
	public String copyTo1{get;set;}{copyTo1 = '';}
	public String copyTo2{get;set;}{copyTo2 = '';}
	public String copyTo3{get;set;}{copyTo3 = '';}
	public String copyTo4{get;set;}{copyTo4 = '';}

	public String pirID{get;set;}
	public R1_Incident__c pirObject{get;set;}


	public R2_TTY_Messages_CTRL(ApexPages.StandardController stdController) {
		pirID = stdController.getId();
        System.debug('constructor con StandardController-> ' + pirID);

        pirObject = [SELECT Id, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c, RecordType.DeveloperName, R1_INC_LOO_Case__c
        			FROM R1_Incident__c WHERE Id =:pirID];
        System.debug(':::incidencia asociada -> ' + pirObject);
	}
	//public R2_TTY_Messages_CTRL() {
	//	pirID = null;
 //       System.debug('constructor sin StandardController-> ' + pirID);
	//}

	public void submit() {
		System.debug('*** input inputTX ' + inputTX);
		System.debug('*** input messageTextarea ' + messageTextarea);

		sendMessage();
    }

	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Calling SendInboxMessage on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                     		    <Change Description>
    20/11/2017             		Jaime Ascanta             	     			Initial Version
    24/11/2017             		Alberto Puerto Collado                 		Extended version
    09/01/2018             		Alberto Puerto Collado                 		Saving record on SF
    07/05/2018             		Alberto Puerto Collado                 		Added mensaje.R2_MG_LOO_Case__c and pirObject.R1_INC_LOO_Case__c
    09/05/2018             		Alberto Puerto Collado              		Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
	public void sendMessage(){
		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
        try{
			R2_CLS_WT_Bags_Management.WR_SendTeletypeMessageWebReq req = new R2_CLS_WT_Bags_Management.WR_SendTeletypeMessageWebReq();
			
			String alias = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
			System.debug(':::ALIAS del user: ' + alias);


				R2_CLS_WT_Bags_Management.OriginType originType = new R2_CLS_WT_Bags_Management.OriginType();
				originType.teletypeAddress = 'TTY05A9';
				originType.chargeableairline = 'IB';
			req.origin = originType;
				
				R2_CLS_WT_Bags_Management.RecordIDType recID = new R2_CLS_WT_Bags_Management.RecordIDType();
					List<R2_CLS_WT_Bags_Management.NewRecordType> lstRecID = new List<R2_CLS_WT_Bags_Management.NewRecordType>();
						R2_CLS_WT_Bags_Management.NewRecordType registro= new R2_CLS_WT_Bags_Management.NewRecordType();
							R2_CLS_WT_Bags_Management.AssociatedRecord recordReference = new R2_CLS_WT_Bags_Management.AssociatedRecord();
								recordReference.stationCode = pirObject.R2_INC_TXT_PIR_Station_Code__c;//'MAD';
								recordReference.airlineCode = pirObject.R2_INC_TXT_PIR_Airline_Code__c;//'IB';
								recordReference.referenceNumber = pirObject.R2_INC_TXT_PIR_Reference_Number__c;//'67801'; 
							registro.recordReference = recordReference;
							registro.recordType = pirObject.RecordType.DeveloperName;//'DELAYED';
					lstRecID.add(registro);
				recID.recordID = lstRecID;
			req.copyTo = recID;

			List<String> tx_teletypeAddress = new List<String>();
				List<String> lst_txs = inputTX.split('/');
				for(Integer i = 0; i<lst_txs.size(); i++){
					tx_teletypeAddress.add(lst_txs[i]);
				}
				System.debug('*** tx_teletypeAddress: ' + tx_teletypeAddress);
			req.destinationTeletypeAddress = tx_teletypeAddress;

			
			req.message = messageTextarea;//'Message';
			req.agentId = alias; //'AgentId';

			String jsonData = JSON.serialize(req);

			System.debug('*** jsonData: antes helper ' + jsonData);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: despues' + jsonData);


			response = R2_CLS_WT_Bags_Management.SendTeletypeMessage(jsonData,0);
			System.debug('respuesta :::::::::' + response);

			//Save record into Salesforce: -> done at R2_CLS_WT_Bags_Management.SendTeletypeMessage()
			//SAVING RECORD & Display response:
			if(response == '1'){//pendiente de mejorar por devolver el wrapper y response.success = 'YES'
				response = 'Mensaje TTY correctamente enviado';
				System.debug('respuesta :::::::::' + response);
				//SAVING RECORD:
				String idRT = Schema.SObjectType.R2_MG_Message__c.getRecordTypeInfosByName().get('TTY').getRecordTypeId();

				R2_MG_Message__c mensaje = new R2_MG_Message__c();
					mensaje.R2_MG_TXT_TX__c = inputTX;
					mensaje.R2_MG_ATXT_Message__c = messageTextarea;
					mensaje.R2_MG_TXT_Copy_1__c = copyTo1;
					mensaje.R2_MG_TXT_Copy_2__c = copyTo2;
					mensaje.R2_MG_TXT_Copy_3__c = copyTo3;
					mensaje.R2_MG_TXT_Copy_4__c = copyTo4;
					//mensaje.CreatedBy.Alias = alias; <-- falta saber donde se guarda o si se guarda el alias 
					mensaje.RecordTypeId = idRT;
					mensaje.R2_MG_PKL_Type__c = 'Saliente';
					mensaje.R2_MG_LOO_Incident__c  = pirID; 

					//07/05/08 added
					if(pirObject.R1_INC_LOO_Case__c != null){
						mensaje.R2_MG_LOO_Case__c = pirObject.R1_INC_LOO_Case__c;
					}

					System.debug(':::Mensaje TTY :::::::::' + mensaje);
				insert mensaje;
				response += ' Y guardado en Salesforce.';
			}else{
				response = 'Error al enviar el mensaje.' + response;
			}
			CLS_INC_WT_Monitoring.watchingWT( 'send TTY', 'Messages');
		}catch(System.CalloutException ex){
			R1_CLS_LogHelper.generateErrorLog('R2_TTYMessages_CTRL.sendMessage()', 'Error por callout en la integración', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
		}catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_TTYMessages_CTRL.sendMessage()', 'Error al insertar en SF el TTY enviado', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
	    }catch(Exception ex){
	        R1_CLS_LogHelper.generateErrorLog('R2_TTYMessages_CTRL.sendMessage()', 'Error en sendMessage()', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
	    }
	}
}