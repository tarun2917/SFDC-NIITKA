public with sharing class R2_CLS_DNBNumberNotification {
	public class WrpDNB{
		public string crmRequestId;
		public string amadeusLocator;
		public string resiberLocator;
		public string service;
		public string iberiaConectaCompensationId;
		public string status;
		public List<WrpPassenger> passengers;

	}
	public class WrpRespDNB{
		public string status;
	}
	public class WrpPassenger{
		public string voucher;
		public string state;
		public string crmVoucherId;
		public string profileId;
	}
    @future(callout=true)
	public static void sendDNB(String id){
		try{

			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();

			List<R2_Voucher__c> listVou = [SELECT Id, R2_VOU_TXT_Voucher__c,R2_VOU_TXT_ProfileId__c,R2_VOU_TXT_IBConecta__c,R2_VOU_PKL_Service__c,R2_VOU_PKL_Status__c,RecordTypeId, R2_VOU_TXT_AmadeusLocator__c, R2_VOU_TXT_ResiberLocator__c
										FROM R2_Voucher__c WHERE RecordTypeId=:recordTypeDNB AND Id=:id];

			if(!listVou.isEmpty() ) {
				WrpRespDNB wrp = R2_CLS_DNBNumberNotification.sendDNBNumber(listVou[0], 0);
			}

		}
		catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.sendDNB', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
    }
	}

	@future(callout=true)
	public static void sendDNBNotVoucher(String caseId){
		try{

			List<Case> listCase = [SELECT Id, R2_CAS_TXT_IBConnectID__c, R2_CAS_TXT_ProfileId__c,
									R2_CAS_TXT_Amadeus_Locator__c,R2_CAS_TXT_Resiber_Locator__c,R2_CAS_PKL_Type1__c
									 FROM Case WHERE Id=:caseId];

			System.debug('*** inicia sendDNBNotVoucher() ');

			R2_Voucher__c vou = new R2_Voucher__c();
			vou.R2_VOU_TXT_IBConecta__c = listCase[0].R2_CAS_TXT_IBConnectID__c;
			vou.R2_VOU_TXT_ProfileId__c = listCase[0].R2_CAS_TXT_ProfileId__c;
			vou.R2_VOU_PKL_Service__c = '5';
			vou.R2_VOU_TXT_AmadeusLocator__c = listCase[0].R2_CAS_TXT_Amadeus_Locator__c;
			vou.R2_VOU_TXT_ResiberLocator__c = listCase[0].R2_CAS_TXT_Resiber_Locator__c;
			vou.R2_VOU_LOO_Case__c = listCase[0].Id;

			WrpRespDNB wrp = R2_CLS_DNBNumberNotification.sendDNBNumber(vou, 0);
		
		}catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.sendDNBNotVoucher', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
    	}
	}

	public static WrpRespDNB sendDNBNumber(R2_Voucher__c vou, integer intentos){
		System.debug('*** inicia sendDNBNumber() ');

		try{
			String myCrmId = vou.Id!=null ? R2_CLS_VOU_VoucherIntegrationMethods.makeCRMID(vou.Id) : R2_CLS_VOU_VoucherIntegrationMethods.makeCRMID(vou.R2_VOU_LOO_Case__c);
			
			WrpPassenger wrpP = new WrpPassenger();
			wrpP.voucher = vou.R2_VOU_TXT_Voucher__c;
			wrpP.crmVoucherId = myCrmId;
			wrpP.state = '000';
			wrpP.profileId = vou.R2_VOU_TXT_ProfileId__c;
			WrpDNB wrp = new WrpDNB();
           		wrp.crmRequestId = vou.R2_VOU_TXT_IBConecta__c;
				wrp.amadeusLocator = vou.R2_VOU_TXT_AmadeusLocator__c;
				wrp.resiberLocator = vou.R2_VOU_TXT_ResiberLocator__c;
           		//wrp.service = vou.R2_VOU_PKL_Service__c;
				wrp.service = '5';
           		wrp.iberiaConectaCompensationId = vou.R2_VOU_TXT_IBConecta__c ;
				wrp.status = '000';
           		wrp.passengers = new List<WrpPassenger>();
           		wrp.passengers.add(wrpP);



            string wsMethod = 'Send DNB';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);


            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token==null){
                if(intentos<3){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return sendDNBNumber(vou,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.sendDNB', '','No se puede conectar', 'Account');
                    return null;
                }
            }

						//String requestBody = JSON.serialize(wrp);
						String requestBody = makeRequestXML(wrp);

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/xml');
            req.setHeader('Content-Type', 'application/xml');
            req.setTimeout(15000);
            req.setBody(requestBody);


						System.debug(req);

						System.debug('*** request body: ' + req.getBody());


            Http http = new Http();

            HTTPResponse res;
            res = http.send(req);

            System.debug('*** response code: ' + res.getStatusCode() );
						System.debug('*** response body: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
								// WrpRespDNB resp = (WrpRespDNB)JSON.deserialize(res.getBody(), WrpRespDNB.class);
								WrpRespDNB resp = makeResponseFromXML(res);

								System.debug('*** WrpRespDNB: ' + resp);

								return resp;

            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return sendDNBNumber(vou,intentos);

                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '','', 'Account');
            		return null;
                }
            }
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.sendDNB', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
            return null;
		}
	}

	public static String makeRequestXML(WrpDNB wrp){
		try{
				DOM.Document doc = new DOM.Document();
				String cmn = 'http://www.ib.com/schema/vcm/CommonWebTypesV01';
				String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
				String schema = 'http://www.ib.com/schema/vcm/NotifyVoucherCreationWebRequestV01 NotifyVoucherCreationWebRequestV01.xsd';

				dom.XmlNode envelope = doc.createRootElement('NotifyVoucherCreationWebRequest', schema, 'p');

				envelope.setNamespace('xsi', xsi);
				envelope.setAttributeNS('schemaLocation', schema, xsi, null);
				envelope.setAttribute('xmlns:cmn', cmn);

				envelope.addChildElement('CrmRequestId', schema, null).addTextNode( wrp.crmRequestId != null ? wrp.crmRequestId : '' );
				envelope.addChildElement('AmadeusLocator', schema, null).addTextNode(wrp.amadeusLocator != null ? wrp.amadeusLocator : '');
				envelope.addChildElement('ResiberLocator', schema, null).addTextNode(wrp.resiberLocator != null ? wrp.resiberLocator : '');
				envelope.addChildElement('Service', schema, null).addTextNode(wrp.service != null ? wrp.service : '');
				envelope.addChildElement('IberiaConectaCompensationId', schema, null).addTextNode( wrp.iberiaConectaCompensationId != null ? wrp.iberiaConectaCompensationId : '');
				envelope.addChildElement('Status', schema, null).addTextNode(wrp.status != null ? wrp.status : '');

				dom.XmlNode pasNode = envelope.addChildElement('Passengers', schema, null);
				for(WrpPassenger passenger : wrp.passengers){
					pasNode.addChildElement('Voucher', schema, null).addTextNode( passenger.voucher != null ? passenger.voucher : '');
					pasNode.addChildElement('State', schema, null).addTextNode(passenger.state != null ? passenger.state : '');
					pasNode.addChildElement('CrmVoucherId', schema, null).addTextNode(passenger.crmVoucherId != null ? passenger.crmVoucherId : '');
					pasNode.addChildElement('ProfileId', schema, null).addTextNode(passenger.profileId != null ? passenger.profileId : '');
				}


				String xmlString = doc.toXmlString();

				xmlString = xmlString.replace(' NotifyVoucherCreationWebRequestV01.xsd' , '');
				xmlString = xmlString.replace('NotifyVoucherCreationWebRequestV01.xsd' , '');

				return xmlString;

		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.makeRequestXML', '', exc.getmessage()+', '+exc.getLineNumber(), '');
			return null;
		}

	}


	public static WrpRespDNB makeResponseFromXML(HttpResponse response){
		try{
			WrpRespDNB wrpRes = null;
			String body = response.getBody();

			if(body.containsIgnoreCase('<Status>SUCCESS</Status>')) {
					wrpRes = new WrpRespDNB();
					wrpRes.status = 'SUCCESS';
			}else if (body.containsIgnoreCase('<Status>FAILURE</Status>')) {
					wrpRes = new WrpRespDNB();
					wrpRes.status = 'FAILURE';
			}

			return wrpRes;

		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_DNBNumberNotification.makeResponseFromXML', '', exc.getmessage()+', '+exc.getLineNumber(), '');
      return null;
		}
	}


}