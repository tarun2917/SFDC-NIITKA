//public with sharing class R2_CLS_Iberia_Voucher_TriggerMethods {
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Methods for the triggers of Voucher
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    14/03/2018          Alvaro Garcia Tapia	   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
global with sharing class R2_CLS_Iberia_Voucher_TriggerMethods{

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Insert vouchers in gestor de bonos
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    14/03/2018          Alvaro Garcia Tapia	   	 Initial version
	20/03/2018          Jaime Ascanta		   	 Commented DML operation in catch
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@future (callout=true)
    public static void insertarBonoIbcom(String jSONBonos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            
            List<R2_Voucher__c> listVoucher = (List<R2_Voucher__c>)JSON.deserialize(jSONBonos, List<R2_Voucher__c>.class); 
        	Id rtVoucherIberia = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('BonoIberia.com').getRecordTypeId();
        	
        	if(listVoucher[0].RecordTypeId == rtVoucherIberia){
	            
	            R2_CLS_BonosIberiacom.WsResponseBono wsResponseBono = new R2_CLS_BonosIberiacom.WsResponseBono();
	            //Parametros de entrada
            	String codigoCampanhaComercial = listVoucher[0].R2_VOU_TXT_Campaign_Commercial_Code__c;
				String maxUsoxBono = '0';
				if (listVoucher[0].R2_VOU_NUM_Maximum_Bonus_Consumption__c!=null){
					maxUsoxBono = String.valueof(Integer.valueOf(listVoucher[0].R2_VOU_NUM_Maximum_Bonus_Consumption__c));
				}
				String tipoDescuento = listVoucher[0].R2_VOU_PKL_Discount_Type__c;
				//if (listVoucher[0].R2_VOU_PKL_Discount_Type__c.startsWith('0')){
				//	tipoDescuento = '0';
				//}else{
				//	tipoDescuento = '1';
				//}
                /*
				if (listVoucher[0].R2_VOU_PKL_Discount_Type__c!=null){
					tipoDescuento = String.valueof(Integer.valueOf(listVoucher[0].R2_VOU_PKL_Discount_Type__c));
				}
				*/
				String valorDescuento = '0';
				if (listVoucher[0].R2_VOU_FOR_bono_amount_iberiacom__c != null){
					valorDescuento = String.valueof(Integer.valueOf(listVoucher[0].R2_VOU_FOR_bono_amount_iberiacom__c));
				}
				String moneda = listVoucher[0].R2_VOU_PKL_Coin__c;
				String startDateTime='';
				if (listVoucher[0].R2_VOU_DATH_Effective_Date_From__c != null){
					startDateTime = String.valueOf(listVoucher[0].R2_VOU_DATH_Effective_Date_From__c);
				}
				String endDateTime='';
				if (listVoucher[0].R2_VOU_DATH_Effective_Date_To__c != null){
					endDateTime = String.valueOf(listVoucher[0].R2_VOU_DATH_Effective_Date_To__c);
				}

				//Llamada al servicio
				wsResponseBono = wsInsertarBonoIbcom(codigoCampanhaComercial,maxUsoxBono,tipoDescuento,valorDescuento,moneda,startDateTime, endDateTime,0);
				List<R2_Voucher__c> listadoBonos = [SELECT Id, R2_VOU_TXT_Id_Bono__c, R2_VOU_TXT_Campaign_Commercial_Code__c FROM R2_Voucher__c WHERE Id =:listVoucher[0].Id];
				if (wsResponseBono.bonus != null){
	                System.debug(LoggingLevel.Info, 'insertarBonoIbcom : Se ha generado el bono con ID: '+ wsResponseBono.bonus.id);
	                
	                //List<R2_Voucher__c> listadoBonos = [Select id, R2_VOU_TXT_Id_Bono__c, R2_VOU_TXT_Campaign_Commercial_Code__c from R2_Voucher__c where id =:listVoucher[0].id];
	                
	                //carga de datos respuesta del WS
	                listadoBonos[0].R2_VOU_TXT_Id_Bono__c = wsResponseBono.bonus.id;
	                listadoBonos[0].R2_VOU_TXT_Campaign_Commercial_Code__c = wsResponseBono.bonus.campaignCommercialCode;
	                listadoBonos[0].R2_VOU_TXT_Commercial_Code__c = wsResponseBono.bonus.commercialCode;
	                //listadoBonos[0].R2_VOU_NUM_Discount_Value__c = decimal.valueOf(wsResponseBono.bonus.discountValue);
	                listadoBonos[0].R2_VOU_TXT_Campaign_Id__c = wsResponseBono.bonus.campaignID;
	                listadoBonos[0].R2_VOU_CHK_Allow_Unselected_Operators__c = boolean.valueOf(wsResponseBono.bonus.allowUnselectedOperators);
	                listadoBonos[0].R2_VOU_CHK_Redeem_Reservation__c = boolean.valueOf(wsResponseBono.bonus.reservationRedeemabilityIndicator);
	                listadoBonos[0].R2_VOU_CHK_User_logged__c = boolean.valueOf(wsResponseBono.bonus.logInUserRequiredIndicator);
	                listadoBonos[0].R2_VOU_CHK_Sunday_Rule__c = boolean.valueOf(wsResponseBono.bonus.sundayRuleApplicabilityIndicator);
	                listadoBonos[0].R2_VOU_NUM_Number_Uses_Bonus__c = decimal.valueOf(wsResponseBono.bonus.bonusUsageCount);
	                listadoBonos[0].R2_VOU_NUM_Consumed_Amount__c = decimal.valueOf(wsResponseBono.bonus.amountconsumed);
	                listadoBonos[0].R2_VOU_NUM_Maximum_Bonus_Consumption__c = decimal.valueOf(wsResponseBono.bonus.maximumPermittedUse);
	                if (wsResponseBono.bonus.validity != null){
	                	listadoBonos[0].R2_VOU_DATH_Effective_Date_From__c = Datetime.valueOf(wsResponseBono.bonus.validity.startDateTime);
	                	listadoBonos[0].R2_VOU_DATH_Effective_Date_To__c = Datetime.valueOf(wsResponseBono.bonus.validity.endDateTime);
	                }
	                
	                if (wsResponseBono.bonus.returnDays != null){
	                 	listadoBonos[0].R2_VOU_TXT_Days_Return__c='';
	                 	for (String dia:wsResponseBono.bonus.returnDays.dayCode){
	                 		listadoBonos[0].R2_VOU_TXT_Days_Return__c = listadoBonos[0].R2_VOU_TXT_Days_Return__c + dia + ';';
	                 	}
	                 	listadoBonos[0].R2_VOU_TXT_Days_Return__c.removeEnd(';');
	                }
	                if (wsResponseBono.bonus.departureDays != null){
	                 	listadoBonos[0].R2_VOU_TXT_Days_Departure__c='';
	                 	for (String dia:wsResponseBono.bonus.departureDays.dayCode){
	                 		listadoBonos[0].R2_VOU_TXT_Days_Departure__c = listadoBonos[0].R2_VOU_TXT_Days_Departure__c + dia + ';';
	                 	}
	                 	listadoBonos[0].R2_VOU_TXT_Days_Departure__c.removeEnd(';');
	                }               
	                listadoBonos[0].R2_VOU_PKL_Status__c = 'Emitido';
        		}else{
        			listadoBonos[0].R2_VOU_PKL_Status__c = 'Rechazado';
				}
                update listadoBonos[0];
              }  
                       
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Iberia_Voucher_TriggerMethods.insertarBonoIbcom()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
            // List<R2_Voucher__c> listVoucher = (List<R2_Voucher__c>)JSON.deserialize(jSONBonos, List<R2_Voucher__c>.class);
            // List<R2_Voucher__c> listadoBonos = [Select id, R2_VOU_TXT_Id_Bono__c, R2_VOU_TXT_Campaign_Commercial_Code__c from R2_Voucher__c where id =:listVoucher[0].id];
            // listVoucher[0].R2_VOU_PKL_Status__c = 'Rechazado';
            // update listadoBonos[0];
         }
    }
    
    
    public static R2_CLS_BonosIberiacom.WsResponseBono wsInsertarBonoIbcom (String codigoComercial, String maxUsoxBono, String tipoDescuento, String valorDescuento, String moneda, String fechaDesde, String fechaHasta, Integer intentos){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    	System.debug(LoggingLevel.Info, 'wsInsertarBonoIbcom');
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            string wsMethod = 'R2_IberiaComBonos'; //R2_VoucherManagement

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }
            //R1_CLS_SendCustomerMDM.login();
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            
            if(token ==null){
            	System.debug(LoggingLevel.Info, 'wsInsertarBonoIbcom : token null');
                if(intentos<3){
                	System.debug(LoggingLevel.Info, 'wsInsertarBonoIbcom : intento '+intentos);
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return wsInsertarBonoIbcom(codigoComercial, maxUsoxBono, tipoDescuento, valorDescuento, moneda, fechaDesde, fechaHasta, intentos);
                }else{
                    return null;
                }
            }
            
            System.debug('Ha funcionado el login: '+ token);
			System.debug(LoggingLevel.Info, 'Ha funcionado el login: '+ token);
			
			R2_CLS_BonosIberiacom.wpRequestAltaBono wpParamEntrada = new R2_CLS_BonosIberiacom.wpRequestAltaBono();
			
			R2_CLS_BonosIberiacom.validez validezAux = new R2_CLS_BonosIberiacom.validez();
			validezAux.startDateTime = fechaDesde;
			validezAux.endDateTime = fechaHasta;
			wpParamEntrada.campaignCommercialCode = codigoComercial;
			wpParamEntrada.maximumPermittedUse = maxUsoxBono;
			wpParamEntrada.discountValue = valorDescuento;
			wpParamEntrada.discountType = tipoDescuento;
			wpParamEntrada.currencyCode = moneda;
			wpParamEntrada.validity = validezAux;
			
			String body = JSON.serialize(wpParamEntrada);
			System.debug(LoggingLevel.Info, 'wsInsertarBonoIbcom : body del serialize '+body);
            
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c;//api/pvm-vcm/rs/v1/vouchers/
            System.debug('EndPoint: ' +  endPoint);
            System.debug(LoggingLevel.Info, 'EndPoint: ' +  endPoint);
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('BonoIberiacom');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            req.setBody(body);//carga parametros de entrada serializados
            
            Http http = new Http();
            HTTPResponse res;
            res = http.send(req);
            System.debug('Body: '+ res.getBody());
            System.debug('Status: '+ res.getStatusCode());
            System.debug(LoggingLevel.Info,'Body: '+ res.getBody());
            System.debug(LoggingLevel.Info,'Status: '+ res.getStatusCode());
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203 || res.getStatusCode() == 0){
                R2_CLS_BonosIberiacom.WsResponseBono resp = (R2_CLS_BonosIberiacom.WsResponseBono)JSON.deserialize(res.getBody(),R2_CLS_BonosIberiacom.WsResponseBono.class);
                if(resp == null){
                    return null;
                }
                return resp;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return wsInsertarBonoIbcom(codigoComercial, maxUsoxBono, tipoDescuento, valorDescuento, moneda, fechaDesde, fechaHasta, intentos);
                }else{
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Iberia_Voucher_TriggerMethod.wsInsertarBonoIbcom()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Flight');
            return null;
        }
    }
    
    
    
    
    


	
	//Método para enviar mail una vez insertado el bono
	//public static void enviarEmail(List<R2_Voucher__c> listVoucher) {
	//	try{
	//		//Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
	//		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
	//						// Se crea un email para cada destinatario
	//		Id rtVoucherIberia = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('BonoIberia.com').getRecordTypeId();
    //    	//List<R2_Voucher__c> bonos = trigger.new;
    //    	//R2_Voucher__c bono = bonos[0];
        	
    //        //List<R2_Voucher__c> lst_vouc = [SELECT Id, R2_VOU_CHK_Email_Sent__c FROM R2_Voucher__c WHERE Id = : listVoucher[0].Id ];
    //    	if(listVoucher[0].RecordTypeId == rtVoucherIberia){
    //             if ((listVoucher[0].R2_VOU_PKL_Status__c == 'Emitido') && (listVoucher[0].R2_VOU_CHK_Email_Sent__c == false)){ //Comprueba que el estado sea emitido y que el boolean de email sea falso
    //            /*Messaging.SingleEmailMessage[] mailsToSend = new Messaging.SingleEmailMessage[1];
    //            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              
    //            String[] toAddresses = new String[] {correo};
    //            Añadimos el destinatario al email
    //            mail.setToAddresses(toAddresses);
    
                
    //            mail.setSubject('Se ha emitido un ebono');
    //            mail.setPlainTextBody('');
                
    
                    
    //            //mail.setSenderDisplayName('Salesforce Support');
    //            //mail.setBccSender(false);
    //            mail.setUseSignature(false);
    //            mailsToSend[0]=mail;*/
               

    //                 system.debug('envio el correo ');
    //                 lst_vouc[0].R2_VOU_CHK_Email_Sent__c = true;
    //                 lst_vouc[0].R2_VOU_CHK_Workflow__c = true;
    //                 update lst_vouc;
    //             }
     //       }
	//	}catch(Exception exc){

	//		R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.enviarEmail()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
	//	}
	//} 
}