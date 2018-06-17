public with sharing class R2_CLS_PYT_Validate_Payment {
	


	public class PaymentValidationWebRequest{
		public String customerName;
		public String financialInstitution;
		public String countryCode;
		public String ankKey;
		public String bankAccountNumber;
		public String bankControlKey;
		public String swift;
		public String iban;
		public String postalCode;
		public String street;
		public String city;

	}

	public class PaymentValidationWebResponse{
		public String responseType;
		public String messageNumber;
		public String messageText;
		public List<ErrorType> errors;
		public Integer statusCode;
	}

	public class ErrorType{
		public String code;
		public String reason;
		public String uuid;
		public String timeStamp;
	}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    

    IN:				
    OUT:           	

    History:

    <Date>              <Author>            		<Description>
    02/02/2018    		Ismael Yubero Moreno   			Initial version
   --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	public static PaymentValidationWebResponse validatePayment(String wrapper, Integer contador){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
			System.debug('Inicio de la validacion del pago');
			//Endpoint to callout
            String wsMethod = 'Pagos';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
            System.debug('Se ha cogido el endopoint de la validacion del pago');

			//1.- Create request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/validate/');
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return validatePayment(wrapper, contador);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('PaymentValidationWebResponse.validatePayment', wrapper, 'Error en login', 'R2_Compensation__c');
                    return null;
                }
            }

            System.debug('Se ha iniciado sesion');
			//2.- Include headers into request
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            //req.setTimeout((Integer)timeOut.setTimeOut__c);
            System.debug('Http Request: ' + req); //LoggingLevel.DEBUG, 

			//3.- Body for request
			String strBodyRequest = wrapper;
			//String strBodyRequest = '{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127 ELMO AVE, POUGHKEEPSIE VA 30335"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420 HIGH STREET, DAYTON OH 45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM","seq":"1"}]},"bagPhones":{"phone":["770 850 4550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:33","status":{"outForDelivery":"123","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERS MISSING"],"contentsDamage":"CONTENTS DAMAGE"},"passenger":{"names":{"name":["TINTIN","KAMINSKYA"],"seq":"1"},"initials":{"initial":["OK"],"seq":"1"},"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666 PALACE BLVD, LONDON GB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"Great Britain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400 PENNSYLVANIA LN, WASHINGTON OK 30339"},"validityDate":"2017-09-10"},"permanentPhones":{"phone":["770 850 4550"],"seq":"1"},"cellPhones":{"phone":["404 431 9238"]},"temporaryPhones":{"phone":["404 431 3980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","noOfpassenger":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","date":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}]},"designatedLocator":"1234","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Free misc"},{"miscInfoText":"Free misc One"}],"furtherInfo":"further info","supplementaryInfo":[{"supplimentInfoText":"Free supp info"},{"supplimentInfoText":"Free supp info One"}],"customsInfo":"customs info","userComments":[{"commentsText":"abcgd"}]},"claim":{"claimAmount":{"amount":{"amount":"5000","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OST REMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35.45","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-09-10","notifiedDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BAB"},"lossComments":"RL COMMENTS","lossReasonCode":"91","replacementBag":"true","repairBag":"false"},"agentId":"AGENT"}';
            
            
            req.setBody(strBodyRequest);

			//4.- Send data
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('Status Response Code: ' + res.getStatusCode());

            //5.- Get data for web service
            String strBodyResponse = res.getBody();
            System.debug('Body Response: ' + strBodyResponse);
            
            //6.- Parsing data response
            PaymentValidationWebResponse resp = (PaymentValidationWebResponse)JSON.deserialize(strBodyResponse, PaymentValidationWebResponse.class);
            System.debug('Body resp: ' + resp);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('RESPPPPP 20x: ' + resp);
                resp.statusCode = res.getStatusCode();
                return resp;
            }else{
                if(contador<3 && res.getStatusCode() == 401){
                	System.debug('RESPPPPP: 401');
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return validatePayment(wrapper, contador);
                }else{
                    if(contador<3){
                    	System.debug('RESPPPPP != 20x && != 401: ' + resp);
                        String callResponse = '';
                        

                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('PaymentValidationWebResponse.validatePayment', '', 'Error en \'validatePayment\', fallos de login', 'R2_Compensation__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('PaymentValidationWebResponse.validatePayment', '', exc.getmessage() +', ' + exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
}