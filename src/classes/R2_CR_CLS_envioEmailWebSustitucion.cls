public class R2_CR_CLS_envioEmailWebSustitucion {
    
    public static void sendEmailWebSustitucion(String email, String pirNumber, String fechaInc, String lengua, List<Case> lstCasos, List<R1_Incident__c> lstinci, String valor, String cod_ama, String fechaValida, String nombreCompleto){
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

			//List<R1_Incident__c> lstInci = [SELECT id, R2_INC_TXT_PIR_PIR_incident__c FROM R1_Incident__c WHERE R2_INC_TXT_PIR_PIR_incident__c =: pirNumer];
            List<R2_Baggage__c> lstMaletas = [SELECT id, Name, R2_BAG_TXT_Description__c, R2_BAG_PKL_Type__c, R2_BAG_PKL_Colour__c, R2_BAG_TXT_Brand_Info__c, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c where R2_BAG_MSDT_Incident__c =: lstinci[0].id];
            system.debug('numero de maletas ' + lstMaletas.size());
            String aux = '';
            String aux2 = '';
            String aux3 = '';
            String aux4 = '';
            String color = '';
            String tipo = '';
            String auxMal = '';
           
           // List<OrgwideEmailAddress> orgwideaddress = [SELECT id FROM OrgwideEmailAddress WHERE displayname='noreply@iberia.com'];
             List<OrgwideEmailAddress> orgwideaddress = [SELECT id FROM OrgwideEmailAddress WHERE displayname='websustitucion@gmail.com'];
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            if(!orgwideaddress.isEmpty()) {
                mail.setOrgWideEmailAddressId(orgwideaddress[0].id);
            }else{
                mail.setSenderDisplayName('Iberia');
            }
            
            String[] toAddresses = new String[] {email};
           // String[] ccAddresses = new String[] {'noreply@iberia.com'};
           String[] ccAddresses = new String[] {'websustitucion@gmail.com'};
                    
            mail.setToAddresses(toAddresses);
            
            //mail.setReplyTo('noreply@iberia.com');
            mail.setReplyTo('websustitucion@gmail.com');
            String templ = '';
            // en cada template busco por un string de caracteres raros que contenga la template y reemplace la lista de las maletas con los campos por esos caracteres raros.
            if(!lstinci.isEmpty()){
                system.debug('lista de incidencia rellena');
                 if (!lstCasos.isEmpty()){
                     system.debug('lsta de casos rellena');
                    if (lengua == 'ES'){  //español
                        mail.setSubject('Confirmación compensación con cheques regalo Amazon por tu expediente: ' + lstCasos[0].R1_CAS_FOR_Case_Number__c);
                        templ = 'Plantilla_bono_maleta_1_ES';
                    } else if(lengua == 'IT'){ //italiano
                      	mail.setSubject('Conferma compensazione con buoni regalo Amazon riferita alla pratica: ' + lstCasos[0].R1_CAS_FOR_Case_Number__c);
                        templ = 'Plantilla_bono_maleta_1_IT';
                    } else if(lengua == 'DE'){ //aleman
                      	mail.setSubject('Confirmation compensation en chèques-cadeaux Amazon pour votre dossier: ' + lstCasos[0].R1_CAS_FOR_Case_Number__c);
                        templ = 'Plantilla_bono_maleta_1_ALE';
                    } else if(lengua == 'FR'){ //frances
                     	mail.setSubject('Confirmation compensation en chèques-cadeaux Amazon pour votre dossier: ' + lstCasos[0].R1_CAS_FOR_Case_Number__c);
                        templ = 'Plantilla_bono_maleta_1_FR';
                    } else{
                      	mail.setSubject('Confirmation of compensation with Amazon gift vouchers for your claim: ' + lstCasos[0].R1_CAS_FOR_Case_Number__c);
                        templ = 'Plantilla_bono_maleta_1_ENG';
                    }
                }
            }
            Date fechaIncDate = Date.valueOf(fechaInc);
            List<R2_Work_Order__c> lstWo = [SELECT id,R2_WO_TXT_cod_amazon__c, R2_WO_TXT_Bags__c, R2_WO_TXT_AmazonId__c, R2_WO_TXT_PIR__c, R2_WO_DAT_Date_Creation_PIR__c FROM R2_Work_Order__c where R2_WO_TXT_PIR__c = :pirNumber AND R2_WO_DAT_Date_Creation_PIR__c = :fechaIncDate];
            system.debug('lista de orden de pago: ' + lstWo + lstWo.size());
			system.debug('templ ' + templ);
            EmailTemplate et;
            if(templ != null || templ != ''){
                et = [SELECT HtmlValue, id from EmailTemplate where DeveloperName = :templ];
            }
            if(!lstMaletas.isEmpty()){
                if(et != null){
                     for(Integer i = 0 ;i< lstMaletas.size() ; i++){
                        color = R2_CR_SW_getInfoBaggage_WS.color(lstMaletas[i].R2_BAG_PKL_Colour__c);
                        tipo = R2_CR_SW_getInfoBaggage_WS.tipo(lstMaletas[i].R2_BAG_PKL_Type__c);
                        //auxMal += ('Maleta ' + i + '<br /><br />');
                        aux += ( 'Maleta: ' + lstMaletas[i].Name + '<br /> Tipo: ' + tipo + '<br /> Color: ' + color + '<br /> Marca: ' + lstMaletas[i].R2_BAG_TXT_Brand_Info__c + '<br /><br />');
                         system.debug('aux: ' + aux );
                        aux2 += valor + '€ <br /> <br />';
                         system.debug('aux: ' + aux2 );
                        aux3 += cod_ama + '<br /> <br />';
                         system.debug('aux: ' + aux3 );
                        aux4 += fechaValida + '<br /> <br />'; 
                         system.debug( 'aux: ' + aux4 + '<br /> <br />' );
                        system.debug('maleta: ' + i);
                    }
				}
            }
            
            
            system.debug('template: ' + templ);
            if(!lstinci.isEmpty()){
            	// poner en todos los idiomas
                //21/marzo/18 @Alberto.Puerto sustituido:
                //1.- R2_INC_TXT_II_Passenger_name__c por R2_INC_TXT_PIR_Name__c
                //2.- lstinci[0].R2_INC_LOO_Case__c  por caso expediente.R2_CAS_TXT_Case_Number__c 
                //3.- query:
                List<Case> lstCasesDelPIR = [SELECT Id, R2_CAS_TXT_Case_Number__c FROM Case WHERE Id =:lstinci[0].R2_INC_LOO_Case__c];
                System.debug(':::!lstCasesDelPIR: ' + lstCasesDelPIR);//Sólo debería de haber UNO!
                String nombreCasoExp = '';
                if(!lstCasesDelPIR.isEmpty()){
                    //control de size
                    if(lstCasesDelPIR.size() > 1){
                        R1_CLS_LogHelper.generateErrorLog('R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion()', 'Existen DOS casos EXPEDIENTE con un mismo PIR asociado', 'PIR en más de un CASE EXPEDIENTE', 'Case/PIR');
                    }
                    //replace 'Expediente: ' + lstinci[0].R2_INC_LOO_Case__c + POR 'Expediente: ' + nombreCasoExp +
                    nombreCasoExp = lstCasesDelPIR[0].R2_CAS_TXT_Case_Number__c;         
                }

                if (lengua == 'ES'){  //español
                    //et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Estimado: ' + lstinci[0].R2_INC_TXT_PIR_Name__c); nombreCompleto 
                //04/04/18 @Alberto.Puerto cambiado para enviar el nombre del formulario y no del PIR en el mail
                    et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Estimado: ' + nombreCompleto);
                    et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Expediente: ' + nombreCasoExp + '<br /> Número de PIR: ' + pirNumber + '<br /> Fecha Incidencia:' + fechaInc);
                } else if(lengua == 'IT'){ //italiano
                    et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Stimato/a: ' + nombreCompleto);
                    et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Pratica: ' + nombreCasoExp + '<br /> Numero PIR: ' + pirNumber + '<br /> Data dellevento: ' + fechaInc);
                } else if(lengua == 'DE'){ //aleman
                    et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Sehr geehrte/r Herr/Frau: ' + nombreCompleto);
                    et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Vorgang: ' + nombreCasoExp + '<br /> PIR-Nummer: ' + pirNumber + '<br /> Datum des Vorfalls:' + fechaInc);
                } else if(lengua == 'FR'){ //frances
                    et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Monsieur, Madame, ' + nombreCompleto);
                    et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Dossier: ' + nombreCasoExp + '<br /> Numéro de PIR: ' + pirNumber + '<br /> Date incident : ' + fechaInc);
                } else{
                    et.HtmlValue = et.HtmlValue.replace('%%%%%%%%%%%%%%' , 'Dear: ' + nombreCompleto);
                    et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Claim: ' + nombreCasoExp + '<br /> PIR number: ' + pirNumber + '<br /> Fecha Incidencia:' + fechaInc);
                }
                //et.HtmlValue = et.HtmlValue.replace('&&&&&&&&&&&&&&' , 'Expediente' + lstinci[0].R2_INC_LOO_Case__c + '<br /> Número de PIR: ' + pirNumber + '<br /> Incident date: ' + fechaInc);
                //et.HtmlValue = et.HtmlValue.replace('###""""")(())(!!: !!!!' , auxMal);
                et.HtmlValue = et.HtmlValue.replace('&&&%%%###@@@' , aux );
                et.HtmlValue = et.HtmlValue.replace('############' , aux2 );
                et.HtmlValue = et.HtmlValue.replace('@@@@@@@' , aux3);
                et.HtmlValue = et.HtmlValue.replace('-!-!-!-!!!!' , aux4);
                system.debug('--> ' + lstinci[0].R2_INC_TXT_PIR_Name__c);
            }
            mail.setPlainTextBody('body mail test');
            mail.setHtmlBody(et.HtmlValue);
            
            //System.debug('*** mail: ' + JSON.serialize(mail) );
            
            mails.add(mail);
            
            List<Messaging.SendEmailResult> result = Messaging.sendEmail(mails);
            
            System.debug('*** result emails: ' + result);
            
        }catch(Exception exc){
				R1_CLS_LogHelper.generateErrorLog('R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
		}
	}
}