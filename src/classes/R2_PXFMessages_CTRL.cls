/*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Controller of R2_VF_PXFMessages
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017             		Jaime Ascanta                  		Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_PXFMessages_CTRL {

	public String xfAddress{get;set;}
	public String xtAddress{get;set;}
	public String delayedPXF{get;set;}

	//public String messageAHL{get;set;}
	//public String messageDPR{get;set;}
	//public String messageOHD{get;set;}

	public String copyTo1{get;set;}
	public String copyTo2{get;set;}
	public String copyTo3{get;set;}
	public String copyTo4{get;set;}
	

	public String messageTextarea{get;set;}

	public String response{get;set;}

	public String pirID{get;set;}

	//{response = '';}

	public R2_PXFMessages_CTRL(ApexPages.StandardController stdController) {
		pirID = stdController.getId();
        System.debug('constructor con StandardController-> ' + pirID);
	}
	public R2_PXFMessages_CTRL() {
		pirID = null;
        System.debug('constructor sin StandardController-> ' + pirID);
    }
	
	public void submit() {
		System.debug('*** input xfAddress: ' + xfAddress);
		System.debug('*** input xtAddress: ' + xtAddress);
		System.debug('*** input delayedPXF: ' + delayedPXF);
		//System.debug('*** input messageAH:L' + messageAHL);
		//System.debug('*** input messageDPR: ' + messageDPR);
		//System.debug('*** input messageOHD: ' + messageOHD);
		System.debug('*** input messageTextarea: ' + messageTextarea);

		//response = '';
		sendMessage();       
    }

	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Calling SendInboxMessage on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017             		Jaime Ascanta                  		Initial Version
    05/12/2017             		Alberto Puerto Collado         		Structural changes
    15/01/2018             		Alberto Puerto Collado         		Saving the message on SF and calling helper function splitCopyToX(copyToX)
    07/05/2018             		Alberto Puerto Collado              Added mensaje.R2_MG_LOO_Case__c and pirObject.R1_INC_LOO_Case__c
    09/05/2018             		Alberto Puerto Collado              Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
	public void sendMessage(){		
        try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

			R2_CLS_WT_Bags_Management.WR_InboxMessageSend_PXFWebReq req = new R2_CLS_WT_Bags_Management.WR_InboxMessageSend_PXFWebReq();			

			if(!String.isBlank(xfAddress)){
				List<R2_CLS_WT_Bags_Management.DestinationType> lstDestinationType = new List<R2_CLS_WT_Bags_Management.DestinationType>();
				List<String> lstCodes = xfAddress.split('/');
				System.debug('::##RP## lstCodes: ' + lstCodes);
				for(Integer i = 0; i < lstCodes.size(); i++){
					R2_CLS_WT_Bags_Management.DestinationType destinationType = new R2_CLS_WT_Bags_Management.DestinationType();
					destinationType.stationCode = lstCodes[i].substring(0, 3);
					destinationType.airlineCode = lstCodes[i].substring(3, 5);
					destinationType.area = lstCodes[i].substring(5);

					System.debug('::##RP## destinationType: ' + destinationType);
					lstDestinationType.add(destinationType);
				}
				System.debug('::##RP## lstDestinationType: ' + lstDestinationType);
                req.destinationInboxAddress = lstDestinationType;
                System.debug('::##RP## req.destinationInboxAddress: ' + req.destinationInboxAddress);
			}    
			
			List<R2_CLS_WT_Bags_Management.NewRecordType> recordTypeList = new List<R2_CLS_WT_Bags_Management.NewRecordType>();
			if(!String.isBlank(copyTo1)){
				System.debug(':::copyTo1 rellenado: '+  copyTo1);
				R2_CLS_WT_Bags_Management.NewRecordType recordType = splitCopyToX(copyTo1);				
				recordTypeList.add(recordType);
			}
			if(!String.isBlank(copyTo2)){
				System.debug(':::copyTo2 rellenado: '+  copyTo2);
				R2_CLS_WT_Bags_Management.NewRecordType recordType = splitCopyToX(copyTo2);				
				recordTypeList.add(recordType);
			}
			if(!String.isBlank(copyTo3)){
				System.debug(':::copyTo3 rellenado: '+  copyTo3);
				R2_CLS_WT_Bags_Management.NewRecordType recordType = splitCopyToX(copyTo3);		
				recordTypeList.add(recordType);
			}
			if(!String.isBlank(copyTo4)){
				System.debug(':::copyTo4 rellenado: '+  copyTo4);
				R2_CLS_WT_Bags_Management.NewRecordType recordType = splitCopyToX(copyTo4);				
				recordTypeList.add(recordType);
			}

			R2_CLS_WT_Bags_Management.MessageDeliveryType messageDeliveryType = new R2_CLS_WT_Bags_Management.MessageDeliveryType();
			String diaMesFrom = null; //inicializo fuera para reutilizar al guardar el registro
			String diaMesToDate = null; 
            if(!String.isBlank(delayedPXF)){
                List<String> lstDelayedParts = delayedPXF.split('/');
            //Time
                messageDeliveryType.rTime = lstDelayedParts[1];
            //FromDAte
            	diaMesFrom = lstDelayedParts[0];
                System.debug('::diaMesFrom FROMDATE:: ' + diaMesFrom);
                diaMesFrom = R1_CLS_Utilities.helper_DateStringToDateSF(diaMesFrom);
                System.debug('::diaMesFrom FROMDATE transformado:: ' + diaMesFrom);
                messageDeliveryType.fromDate = diaMesFrom;//String.valueOf(fromDate);
            //ToDate
            	if(lstDelayedParts.size() == 3){
                	diaMesToDate = lstDelayedParts[2];
					System.debug('::diaMesToDate TODATE:: ' + diaMesToDate);
	                diaMesToDate = R1_CLS_Utilities.helper_DateStringToDateSF(diaMesToDate);
	                System.debug('::diaMesToDate TODATE transformado:: ' + diaMesToDate);
	                messageDeliveryType.toDate = diaMesToDate;
                }             
            }
    
			if(!recordTypeList.isEmpty()){
				if(req.recordId == null){
					req.recordId = new List<R2_CLS_WT_Bags_Management.NewRecordType>();
				}	
				for(Integer i = 0; i < recordTypeList.size(); i++){
					if(recordTypeList[i] != null){
						System.debug('::::::recordTypeList[i] ' + recordTypeList[i]);	
						 req.recordId.add(recordTypeList[i]);
					}	
				}
			}
			System.debug('::::::req.recordId ' + req.recordId);

			//req.airlinevendorid = 'IB'; No en xsd//hard code always IB
			//req.destinationinboxaddress = lstDestinationType;
			req.originstation = 'MAD';
			req.message = messageTextarea;
			//req.records = assoRecList;
            req.messagedelivery = messageDeliveryType;
            
            if(!String.isBlank(xtAddress)){
                req.teletypeaddress = xtAddress.split('/');
            }
            
            String alias = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

			req.agentid = alias;//'AGENT';
			//req.version = '';

			String jsonData = JSON.serialize(req);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);

			response = R2_CLS_WT_Bags_Management.InboxMessageSend_PXF(jsonData,0);
			System.debug('respuesta :::::::::' + response);

			// respStation = ret;
			//return ret;
			if(response == '1'){//pendiente de mejorar por devolver el wrapper y response.success = 'YES'
				response = 'Mensaje PXF correctamente enviado.';
				System.debug('respuesta :::::::::' + response);
				//SAVING RECORD:
				String idRT = Schema.SObjectType.R2_MG_Message__c.getRecordTypeInfosByName().get('PXF').getRecordTypeId();

				R2_MG_Message__c mensaje = new R2_MG_Message__c();
					mensaje.R2_MG_TXT_XF__c = xfAddress;//direcciones XF
					mensaje.R2_MG_TXT_TX__c = xtAddress;//direcciones TX
					//delayed split
					if(!String.isBlank(delayedPXF)){
						List<String> lstDelayedPXF = delayedPXF.split('/'); //Ejemplo 14DEC/1500
						String tiempo = lstDelayedPXF[1];
						tiempo = tiempo.replaceAll('[:/.,;-]{1}', '');
						System.debug(':::tiempo antes:::::::::' + tiempo);

						mensaje.R2_MG_HOU_DT_Hour__c = Time.newInstance(Integer.valueOf(tiempo.substring(0,2)), Integer.valueOf(tiempo.substring(2,4)), 0, 0);
						if(diaMesFrom != null){
							diaMesFrom = diaMesFrom.substringBefore(' ');
							System.debug(':::Date.valueOf(diaMesFrom) split sin ceros:::::::::' + Date.valueOf(diaMesFrom));	
							mensaje.R2_MG_DAT_DT_Start_Date__c = Date.valueOf(diaMesFrom);//Date.valueOf(lstDelayedPXF[0]);
						}
						if(diaMesFrom != null){
							diaMesToDate = diaMesFrom.substringBefore(' ');
							System.debug(':::Date.valueOf(diaMesToDate) split sin ceros:::::::::' + Date.valueOf(diaMesToDate));
							mensaje.R2_MG_DAT_DT_End_Date__c = Date.valueOf(diaMesToDate);//Date.valueOf(lstDelayedPXF[2]);
						}
						System.debug(':::tiempo despues:::::::::hour: ' + mensaje.R2_MG_HOU_DT_Hour__c + ' - stardate ' + mensaje.R2_MG_DAT_DT_Start_Date__c + ' - enddate' + mensaje.R2_MG_DAT_DT_End_Date__c + ' - ');
					}
									
					mensaje.R2_MG_ATXT_Message__c = messageTextarea;
					mensaje.R2_MG_TXT_Copy_1__c = copyTo1;
					mensaje.R2_MG_TXT_Copy_2__c = copyTo2;
					mensaje.R2_MG_TXT_Copy_3__c = copyTo3;
					mensaje.R2_MG_TXT_Copy_4__c = copyTo4;
					//mensaje.CreatedBy.Alias = alias;  ->falta saber donde se guarda o si se guarda el alias 
					mensaje.RecordTypeId = idRT;
					mensaje.R2_MG_PKL_Type__c = 'Saliente';
					mensaje.R2_MG_LOO_Incident__c  = pirID;
					//07/05/08 added
					R1_Incident__c pirObject = [SELECT Id, R1_INC_LOO_Case__c FROM R1_Incident__c WHERE id =:pirID];
					if(pirObject.R1_INC_LOO_Case__c != null){
						mensaje.R2_MG_LOO_Case__c = pirObject.R1_INC_LOO_Case__c;
					}
					
					System.debug(':::Mensaje PXF :::::::::' + mensaje);
				//insert mensaje;
				insertPXF(mensaje);
				response += ' Y guardado en Salesforce.';
			}else{
				response = 'Error al enviar el mensaje: ' + response;
			}
			CLS_INC_WT_Monitoring.watchingWT( 'send PXF', 'Messages'); 
		}catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_PXFMessages_CTRL.sendMessage()', 'Error al insertar en SF el PXF enviado', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
		}catch(Exception ex){
			response = 'Error al enviar el mensaje<br/>' + response;
            R1_CLS_LogHelper.generateErrorLog('R2_PXFMessages_CTRL.sendMessage()', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
            //return null;
        }
	}
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado  
    Company:        Accenture
    Description:    
    IN:           String cadena:   							- Value of copyTo[1-4] field
    OUT:          R2_CLS_WT_Bags_Management.NewRecordType:  - RecordType subwrapper for each field named copyToX

    History: 
     <Date>                     <Author>                         <Change Description>
    15/01/2018             		Alberto Puerto Collado          		Initial Version       		
    ----------------------------------------------------------------------------------------------------------------------*/
	public static R2_CLS_WT_Bags_Management.NewRecordType splitCopyToX(String cadena){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
			System.debug(':::splitCopyToX:::::::::' + cadena);
			List<String> lstCopySplitted = cadena.split(' ');

		//recordType WT:
			String recordTypeWT = lstCopySplitted[0];
			recordTypeWT = recordTypeWT.toUpperCase();
			recordTypeWT = recordTypeWT.trim();
			if(recordTypeWT.contains('AHL')){
				recordTypeWT = 'DELAYED';
			}else if(recordTypeWT.contains('DDP')){
				recordTypeWT = 'DAMAGED';
			}else if(recordTypeWT.contains('OHD')){
				recordTypeWT = 'ON-HAND';
			}else if(recordTypeWT.contains('FWD')){
				recordTypeWT = 'RUSH';
			}
			System.debug('::recordTypeWT: ' + recordTypeWT);
			
		//create subwrapper pir & use recordtype
			String pir = lstCopySplitted[1];
			pir = pir.trim();
			R2_CLS_WT_Bags_Management.NewRecordType recordType = new R2_CLS_WT_Bags_Management.NewRecordType();
	            R2_CLS_WT_Bags_Management.AssociatedRecord associatedRecord = new R2_CLS_WT_Bags_Management.AssociatedRecord();
					associatedRecord.stationcode = pir.substring(0, 3);
					associatedRecord.airlinecode = pir.substring(3, 5);
					associatedRecord.referenceNumber = pir.substring(5);
				recordType.recordReference = associatedRecord;
				recordType.recordType = recordTypeWT;	
			return recordType;
		}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_PXFMessages_CTRL.splitCopyToX()', 'Error separando el campo Delayed PXF', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
            return null;
        }
	}
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado  
    Company:        Accenture
    Description:    
    IN:           R2_MG_Message__c mensaje: message to be inserted
    OUT:          

    History: 
     <Date>                     <Author>                         <Change Description>
    15/01/2018             		Alberto Puerto Collado          		Initial Version       		
    ----------------------------------------------------------------------------------------------------------------------*/
	public static void insertPXF(R2_MG_Message__c mensaje){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        	System.debug('::::insertPXF mensaje 	- ' + mensaje);
        	insert mensaje;
			
		}catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_PXFMessages_CTRL.insertPXF()', 'Error al insertar en SF el PXF enviado', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');	    
		}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_PXFMessages_CTRL.insertPXF()', 'Error separando el campo Delayed PXF', ex.getmessage()+', '+ex.getLineNumber(), 'R2_MG_Message__c');
        }
	}

}