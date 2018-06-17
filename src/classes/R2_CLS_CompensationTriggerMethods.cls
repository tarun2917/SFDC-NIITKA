public class R2_CLS_CompensationTriggerMethods {
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno                        
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                      <Change Description>
    16/08/2017                  Ismael Yubero Moreno          Initial Version
    14/12/2017                  Alberto Puerto Collado       calculaAmountsExpedienteAsociadoOPs() Added
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public class WpReq{
        public String crmUserId;
        public String crmPaymentId;
    }

    public class WpReqIni{
    	public String fileTypeCode;
    	public String fileNumber;
    	public String openingDate;
        public String externalFileNumber;
    	public String caseFile;
    	public String firstReason;
    	public String secondReason;
    	public String thirdReason;
        public String fourthReason;
        public String fifthReason;
    	public String passengerName;
    	public String documentType;
    	public String documentNumber;
    	public String phone;
    	public String address;
    	public String location;
    	public String province;
    	public String postCode;
    	public String countryCode;
    	public String crmPaymentId;
    	public String crmUserId;
    	public Decimal paymentAmount;
    	public Decimal localPaymentAmount;
    	public String currencyCode;
    	public String urgencyIndicator;
    	public String transferIndicator;
    	public String incidenceType;
    	public String iberiaAccount;
    	public String iberiaBudgetCenterCode;
        public String paymentAgencyName;
        public String paymentAgencyAddress;       
        public String paymentAgencyCity;
        public String paymentAgencyCountry;
    	public String bankName;
    	public String bankCountry;
        public String additionalDetails;
        public String fullAccountNumber;
        public String fedAbaCode;
        public String chipsAbaCode;
        public String swiftCode;
        public String ibanCode;
        public String accountType;
        public String chequeCollectionLocation;
    	public String marketingCompany;
    	public String operatingCompany;
    	public String responsibleCompany;
    	public String flightNumber;
        public String principalFlightNumber;
    	public String flightDate;
    }

    public class WpRes{
        public String result;
        public String crmUserId;
        public String crmPaymentId;
    }

    
	//@future(callout=true)
    //public static void cancelarPago(String idPago){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    16/08/2017          Ismael Yubero Moreno     Initial version
	09/10/2017          Ruben Pingarron Jerez    Modify
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    /*       try{
                if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
                cancelPayment(idPago, 0);
                    
           
            }
            catch(Exception exc){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.cancelarPago', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            }
    }
    
    
    public static WpRes cancelPayment (String paymentId, Integer intentos){*/
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    16/08/2017                 Ismael Yubero Moreno    Initial Version
	09/10/2017          		Ruben Pingarron Jerez    Modify
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
     /*   try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            WpReq wrp =  new WpReq();
            
            if(paymentId.length()>15){
                paymentId = paymentId.left(15);
            }
            
            wrp.crmUserId = 'SALESFORCE'; 
            wrp.crmPaymentId = paymentId;
            
            string wsMethod = 'Pagos';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return cancelPayment(paymentId, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.cancelPayment()', '', 'No se puede conectar con Intelligence Integration TOKEN CANCEL', 'R2_Compensation__c');
                    return null;
                }
            }

            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/' + paymentId + '/cancel';
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(3700);
            String body = JSON.serialize(wrp);
           	// String body = '{"crmUserId": "SITSVQAG539","crmPaymentId": "896RU788A"}';
            req.setBody(body);
            
            
            Http http = new Http();
            HTTPResponse res;


            res = http.send(req);
            System.debug('reeeeesStatus: ' + res.getStatusCode());
            
			system.debug('RES: ' + res);
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                WpRes resp = (WpRes)JSON.deserialize(res.getBody(),WpRes.class);
                System.debug('Responseeee' + resp);
                return resp;
            }else{
				System.debug('reeeeesStatus: ' + res.getStatusCode());
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return cancelPayment(paymentId, intentos);
                }else{
                    System.debug('reeeeesStatus: ' + res.getStatusCode());
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.cancelPayment()', '', 'No se puede conectar con Intelligence Integration CANCEL', 'R2_Compensation__c');
                    return null;
                }
            }         
            
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.cancelPayment()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    */
    /*@future(callout=true)
    public static void iniciarPago(String idPago){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    17/08/2017          Ismael Yubero Moreno     Initial version
	09/10/2017          Ruben Pingarron Jerez    Modify
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    /*       try{
                if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
                    initiatePayment(idPago, 0);
                    
           
            }
            catch(Exception exc){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.iniciarPago', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            }
    }*/
	/*
    public static WpRes initiatePayment(String paymentId, Integer intentos){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    17/08/2017                 Ismael Yubero Moreno    Initial Version
	09/10/2017          	   Ruben Pingarron Jerez    Modify
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
      /*  try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            List<R2_Compensation__c> payment = [SELECT id, R2_COM_LOO_Case__r.Type, R2_COM_LOO_Case__r.Parent.CaseNumber, R2_COM_LOO_Case__r.CaseNumber, 
                                                R2_COM_LOO_Case__r.R2_CAS_TXT_EA_Main_File__c, R2_COM_TXT_Main_Flight_Number__c, R2_COM_LOO_Case__r.CreatedDate, 
                                                R2_COM_TLF_Passenger_Phone__c, R2_COM_DIV_Total_Amount__c, R2_COM_PKL_Document_Type__c, R2_COM_TXT_Document_Number__c,
                                                R2_COM_LOO_Flight__r.R1_FLG_TXT_Flight_number__c, R2_COM_LOO_Payment_Code__r.R2_OPY_CHK_Urgent__c, 
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_CHK_Transfer__c, R2_COM_DAT_Flight_Date__c, R2_COM_PKL_Currency_Claimed__c, 
                                                R2_COM_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Fed_ABA__c, 
                                                R2_COM_NUM_Total_Amount_local__c, R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c, R2_COM_LOO_Account__r.Name, 
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_FOR_Country__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Province__c,
                                                R2_COM_LOO_Flight__r.R1_FLG_TXT_Carrier_code_oper__c, R2_COM_LOO_Flight__r.R1_FLG_TXT_AC_owner__c,
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Name__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c,
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Chips_ABA__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_SWIFT__c, 
                                                R2_COM_LOO_Case__r.RecordType.Name, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c,
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_City__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Postal_Code__c,
                                                R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c, R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c, 
                                                R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_IBAN__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Account_Type__c,
                                                R2_COM_LOO_Case__r.R1_CAS_PKL_Subtype__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_External_Local_Account__c, 
                                                R2_COM_PKL_Payment_method__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Address1__c, R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Others__c,
                                                R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c,
                                                R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code_oper__c, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_AC_owner__c
                                                FROM R2_Compensation__c WHERE id=:paymentId];
                                                
                                                
            String diaOpening;
            String mesOpening;
            
            String diaVuelo;
            String mesVuelo;
            
            
           	WpReqIni wrp =  new WpReqIni();

 
            if(!payment.isEmpty()){
                // File details
                wrp.fileTypeCode = payment[0].R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c!=null ? payment[0].R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c:'0';
                wrp.fileNumber = payment[0].R2_COM_LOO_Case__r.CaseNumber.right(14);
                diaOpening = String.valueOf(payment[0].R2_COM_LOO_Case__r.CreatedDate.day());
                if(diaOpening.length()==1){
                    diaOpening = '0' + diaOpening;
                }
                mesOpening = String.valueOf(payment[0].R2_COM_LOO_Case__r.CreatedDate.month());
                if(mesOpening.length()==1){
                    mesOpening = '0' + mesOpening;
                }
                wrp.openingDate = diaOpening + '/' + mesOpening + '/' + String.valueOf(payment[0].R2_COM_LOO_Case__r.CreatedDate.year());  
                wrp.externalFileNumber = payment[0].R2_COM_LOO_Case__r.R2_CAS_TXT_EA_Main_File__c;
                wrp.caseFile = payment[0].R2_COM_LOO_Case__r.Parent.CaseNumber;
                wrp.firstReason = payment[0].R2_COM_LOO_Case__r.Type;
                wrp.secondReason = payment[0].R2_COM_LOO_Case__r.R1_CAS_PKL_Subtype__c;
                wrp.thirdReason = '';
                wrp.fourthReason = '';
                wrp.fifthReason = '';
  
                // Passenger Details
                wrp.passengerName = payment[0].R2_COM_LOO_Account__r.Name;
                wrp.documentType = payment[0].R2_COM_PKL_Document_Type__c;
                wrp.documentNumber = payment[0].R2_COM_TXT_Document_Number__c;
                wrp.phone = payment[0].R2_COM_TLF_Passenger_Phone__c;
                wrp.address = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Address1__c;
                wrp.location = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_City__c;
                wrp.province = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Province__c;
                wrp.postCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Postal_Code__c;   
                
                Schema.DescribeFieldResult fieldResult = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
				List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                System.debug('values' + values);
                for( Schema.PicklistEntry v : values){
                    if(v.getLabel()==payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c){
                        wrp.countryCode = v.getValue();
                    }else if(v.getValue()==payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c){
                        wrp.countryCode = v.getValue();
                    }
                }
                //wrp.countryCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c;
                
                // PaymentId and UserId
                if(paymentId.length()>15){
                    paymentId = paymentId.left(15);
                }
				wrp.crmPaymentId = paymentId;
                wrp.crmUserId = 'SALESFORCE';  
                
                // Payment Details
                wrp.paymentAmount = payment[0].R2_COM_DIV_Total_Amount__c;
				wrp.localPaymentAmount = payment[0].R2_COM_NUM_Total_Amount_local__c;
                wrp.currencyCode = payment[0].R2_COM_PKL_Currency_Claimed__c;
                wrp.urgencyIndicator = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_CHK_Urgent__c ? 'Y' : 'N';
                if(payment[0].R2_COM_PKL_Payment_method__c == 'Transferencia'){
                    wrp.transferIndicator = 'Y';
                }else if(payment[0].R2_COM_PKL_Payment_method__c == 'Cheque'){
                    wrp.transferIndicator = 'N';
                }
                wrp.incidenceType = payment[0].R2_COM_LOO_Case__r.RecordType.Name;
                wrp.iberiaAccount = payment[0].R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c;
                wrp.iberiaBudgetCenterCode = payment[0].R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c;
    			
                // Payment Agency Details
				wrp.paymentAgencyName = '';
        		wrp.paymentAgencyAddress = '';       
        		wrp.paymentAgencyCity = '';
        		wrp.paymentAgencyCountry = '';
                
                // Bank Details
                wrp.bankName = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Name__c;
                Schema.DescribeFieldResult fieldResultBank = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
				List<Schema.PicklistEntry> values2 = fieldResultBank.getPicklistValues();
                System.debug('values' + values2);
                for( Schema.PicklistEntry v : values2){
                    if(v.getLabel()==payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c){
                        wrp.bankCountry = v.getValue();
                    }else if(v.getValue()==payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c){
                        wrp.bankCountry = v.getValue();
                    }
                }
                //wrp.bankCountry =  payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c;
				wrp.additionalDetails = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Others__c;
                wrp.fullAccountNumber = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_External_Local_Account__c;
                wrp.fedAbaCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Fed_ABA__c;
                wrp.chipsAbaCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Chips_ABA__c;
                wrp.swiftCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_SWIFT__c;
				wrp.ibanCode = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_IBAN__c;
                wrp.accountType = payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Account_Type__c;
                wrp.chequeCollectionLocation = '';
                
                // Flight details
                wrp.marketingCompany = payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;
                wrp.operatingCompany = payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code_oper__c;
                wrp.responsibleCompany = payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_AC_owner__c;
               	wrp.flightNumber = payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c; 
                wrp.principalFlightNumber = payment[0].R2_COM_TXT_Main_Flight_Number__c;
                if(payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c!=null){
                     diaVuelo = String.valueOf(payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.day());
                    if(diaVuelo.length()==1){
                        diaVuelo = '0' + diaVuelo;
                    }
                    mesVuelo = String.valueOf(payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.month());
                    if(mesVuelo.length()==1){
                        mesVuelo = '0' + mesVuelo;
                    }
                    wrp.flightDate = diaVuelo + '/' + mesVuelo + '/' + String.valueOf(payment[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.year()); 
                }else{
                    wrp.flightDate = '';
                }
            }
                        
            string wsMethod = 'Pagos';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return initiatePayment(paymentId, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.initiatePayment()', '', 'No se puede conectar con Intelligence Integration INIT TOKEN', 'R2_Compensation__c');
                    return null;
                }
            }

            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c;
            
            System.debug('urlEndp' + endPoint);
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(10000);
			String body = JSON.serialize(wrp);
            //String body = '{ "fileTypeCode": "0", "fileNumber": "1a589685r2", "openingDate": "01/05/2017", "caseFile": "C16191-3543429567", "firstReason": "EQUIPAJE", "secondReason": "DPR DETERIORO", "thirdReason": "DPR CON DETERIORO", "passengerName": "RIMA KRISHNAN", "documentType": "05", "documentNumber": "451177548", "phone": "52618936441111111111", "address": "155 West 13th Street 5D ", "location": "NEW YORK", "province": "NEW YORK", "postCode": "NY 10011", "countryCode": "US", "crmPaymentId": "89585RASDF", "crmUserId": "SITSVQAG540", "paymentAmount": "200111111111.59", "localPaymentAmount": "224444444111.58", "currencyCode": "USD", "urgencyIndicator": "N", "transferIndicator": "N", "incidenceType": "EQUIPAJE", "iberiaAccount": "65902003", "iberiaBudgetCenterCode": "PR013200", "bankName": "AXIS", "bankCountry": "99", "marketingCompany": "IB", "operatingCompany": "IB", "responsibleCompany": "IB", "flightNumber": "6234", "flightDate": "30/09/2016"}';
            System.debug('JSON: ' + body);
            req.setBody(body);
            
            
            Http http = new Http();
            HTTPResponse res;

			
            System.debug('reeeeeeq' + req);
            
            res = http.send(req);
			System.debug('reeeeesStatus: ' + res.getStatusCode());
            System.debug('reeeees: ' + res.getBody());
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                WpRes resp = (WpRes)JSON.deserialize(res.getBody(),WpRes.class);
                System.debug('Responseeee' + resp);
                return resp;
            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return initiatePayment(paymentId, intentos);
                }else{
                    String reason = res.getBody().subStringBetween('reason":"','",');
                    WpRes respFail = new WpRes();
                    respFail.result = reason;
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.initiatePayment()', '', 'No se puede conectar con Intelligence Integration INIT', 'R2_Compensation__c');
                    return respFail;
                }
            }         
            
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.initiatePayment()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }*/
	
        public static void crearOPAvios(String idPago){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            String idRTAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
            List<R2_Compensation__c> lstPagos = [SELECT id,RecordTypeId,R2_COM_LOO_Payment_Code__c,R2_COM_LOO_Case__r.ParentId,R2_COM_LOO_Client__c,R2_COM_TXT_Frecuent_Flyer__c,R2_COM_DIV_Total_Amount__c FROM R2_Compensation__c WHERE id = :idPago];
            if(!lstPagos.isEmpty()){
                System.debug('lstPagos != empty');
                if(lstPagos[0].recordTypeId == idRTAvios){
                    R2_Payment_order__c op = new R2_Payment_order__c();
                    op.R2_OPY_LOO_CaseAccount__c = lstPagos[0].R2_COM_LOO_Client__c;
                    op.R2_OPY_TXT_Frecuent_Flyer__c = lstPagos[0].R2_COM_TXT_Frecuent_Flyer__c;
                    op.R2_OPY_LOO_File_associated__c = lstPagos[0].R2_COM_LOO_Case__r.ParentId;
                    op.R2_OPY_PKL_PaymentType__c = 'AVIOS';
                    op.R2_OPY_PCK_Status__c = 'Borrador';

                    insert op;
                    System.debug('::OP INSERTADO');

                    lstPagos[0].R2_COM_LOO_Payment_Code__c = op.id;
                    lstPagos[0].R2_COM_PKL_Status__c = 'Enviado'; //added 13/12/17
                    System.debug(lstPagos.size());
                    System.debug('OP Creada: '+op.id);

                    update lstPagos;
                }
            }
            System.debug('lstPagos  empty');
        }
        catch(Exception exc){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.crearOPAvios', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo que calcula el importe total de pagos y lo muestra en indemnizaciones del caso padre
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017              Ruben Pingarron Jerez          Initial Version

    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
  	
    public static void calculaIndemnizacion(List<R2_Compensation__c> lstPagos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
           	Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
            
            Set<Id> casosID = new Set<Id>();
            Decimal totalAvios = 0;
            Decimal totalImporte = 0;
            Decimal totalImpHijo = 0;
            Decimal totalAviosHijo = 0;
            
            System.debug('entro en calcularIndemnizacion - INSERT');
            for(R2_Compensation__c pago : lstPagos){
                casosID.add(pago.R2_COM_LOO_Case__c);
            }
            
        
            List<Case> casosDePagos = [SELECT Id, ParentId FROM Case WHERE Id IN :casosID AND ParentId != null];
            Set<Id> padresId = new set<Id>();
            
            if(!casosDePagos.isEmpty()){
                for(Case caso : casosDePagos){
                    padresId.add(caso.ParentId);              	
                }
            }
            
            List<Case> casosPadre = [SELECT Id, R2_CAS_DIV_Compensation__c, R1_CAS_NUM_Compensacion_en_Avios__c FROM Case WHERE Id IN :padresId];
            
            List<Case> casosHijos = [SELECT Id, R1_CAS_NUM_Compensacion_en_Avios__c, R2_CAS_DIV_Compensation__c, ParentId, Type, RecordType.Name FROM Case WHERE ParentId IN :padresId];
            
            List<R2_Compensation__c> pagosTotales = [SELECT Id, RecordTypeId, R2_COM_LOO_Case__r.ParentId, R2_COM_PKL_Status__c, R2_COM_DIV_Total_Amount__c, R2_COM_LOO_Case__c FROM R2_Compensation__c WHERE R2_COM_PKL_Status__c = 'Completado' AND R2_COM_LOO_Case__c IN :casosHijos];  
                       
            Map<String, Decimal> mapTotalesAvios = new Map<String, Decimal>();
            Map<String, Decimal> mapTotalesIndem = new Map<String, Decimal>();
            Map<String, Decimal> mapAviosHijo = new Map<String, Decimal>();
            Map<String, Decimal> mapIndemHijo = new Map<String, Decimal>();
            
            for(R2_Compensation__c pago : pagosTotales){ 
                if(pago.RecordTypeId == rtAvios){
                    if(!mapTotalesAvios.containsKey(pago.R2_COM_LOO_Case__r.ParentId)){
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            mapTotalesAvios.put(pago.R2_COM_LOO_Case__r.ParentId, pago.R2_COM_DIV_Total_Amount__c);
                            System.debug('::::MAPA_AVIOS 1'+mapTotalesAvios);
                        }else{
                            mapTotalesAvios.put(pago.R2_COM_LOO_Case__r.ParentId, 0);
                            System.debug('::::MAPA_AVIOS 2'+mapTotalesAvios);
                        }
                    }else{
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            totalAvios = mapTotalesAvios.get(pago.R2_COM_LOO_Case__r.ParentId) + pago.R2_COM_DIV_Total_Amount__c;
                            mapTotalesAvios.put(pago.R2_COM_LOO_Case__r.ParentId, totalAvios);
                            System.debug('::::MAPA_AVIOS 3'+mapTotalesAvios);
                        }                 
                    }
                    
                    if(!mapAviosHijo.containsKey(pago.R2_COM_LOO_Case__c)){
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            mapAviosHijo.put(pago.R2_COM_LOO_Case__c, pago.R2_COM_DIV_Total_Amount__c);
                        }else{
                            mapAviosHijo.put(pago.R2_COM_LOO_Case__c, 0);
                        }
                    }else{
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            totalAviosHijo = mapAviosHijo.get(pago.R2_COM_LOO_Case__c) + pago.R2_COM_DIV_Total_Amount__c;
                            mapAviosHijo.put(pago.R2_COM_LOO_Case__c, totalAviosHijo);
                        }                 
                    }
                }else if(pago.RecordTypeId != rtAvios){
                    if(!mapTotalesIndem.containsKey(pago.R2_COM_LOO_Case__r.ParentId)){
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            mapTotalesIndem.put(pago.R2_COM_LOO_Case__r.ParentId, pago.R2_COM_DIV_Total_Amount__c);
                        }else{
                            mapTotalesIndem.put(pago.R2_COM_LOO_Case__r.ParentId, 0);
                        }
                    }else{
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            totalImporte = mapTotalesIndem.get(pago.R2_COM_LOO_Case__r.ParentId) + pago.R2_COM_DIV_Total_Amount__c;
                            mapTotalesIndem.put(pago.R2_COM_LOO_Case__r.ParentId, totalImporte);
                        }                 
                    }
                    
                    if(!mapIndemHijo.containsKey(pago.R2_COM_LOO_Case__c)){
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            mapIndemHijo.put(pago.R2_COM_LOO_Case__c, pago.R2_COM_DIV_Total_Amount__c);
                        }else{
                            mapIndemHijo.put(pago.R2_COM_LOO_Case__c, 0);
                        }
                    }else{
                        if(pago.R2_COM_DIV_Total_Amount__c != null){
                            totalImpHijo = mapIndemHijo.get(pago.R2_COM_LOO_Case__c) + pago.R2_COM_DIV_Total_Amount__c;
                            mapIndemHijo.put(pago.R2_COM_LOO_Case__c, totalImpHijo);
                        }                 
                    }
                }
            }
             
            if(!casosPadre.isEmpty()){
                for(Case CasoPa : casosPadre){
                    if(mapTotalesAvios.containsKey(casoPa.Id)){
                        casoPa.R1_CAS_NUM_Compensacion_en_Avios__c = mapTotalesAvios.get(casoPa.Id);
                        System.debug('::::MAPA_AVIOS FIN '+mapTotalesAvios);
                    }
                    if(mapTotalesIndem.containsKey(casoPa.Id)){
                        casoPa.R2_CAS_DIV_Compensation__c = mapTotalesIndem.get(casoPa.Id);
                    }
                }               
                update casosPadre;
            }
            
            if(!casosHijos.isEmpty()){
                for(Case casoH : casosHijos){
                    if(mapAviosHijo.containsKey(casoH.Id)){
                        casoH.R1_CAS_NUM_Compensacion_en_Avios__c = mapAviosHijo.get(casoH.Id); 
                    }    
                    if(mapIndemHijo.containsKey(casoH.Id)){    
                        casoH.R2_CAS_DIV_Compensation__c = mapIndemHijo.get(casoH.Id);
                    }
                }  
           		update casosHijos;
            } 
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.calculaIndemnizacion', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }

    public static void calcularPeriodoPresupuestario(List<R2_Compensation__c> lstPagos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            List<R2_Compensation__c> pagos =[SELECT id,CreatedDate,R2_COM_TXT_Budgetary_Period__c,R2_COM_TXT_Charge_account__c FROM R2_Compensation__c where id= :lstPagos[0].id];
            String cuenta = '';
            if(pagos[0].R2_COM_TXT_Charge_account__c !=null && pagos[0].R2_COM_TXT_Charge_account__c !=''){
                cuenta = pagos[0].R2_COM_TXT_Charge_account__c;
            }
            if(cuenta.startsWith('6') || cuenta.startsWith('7')){
                integer mes = pagos[0].CreatedDate.month();
                String month = '';
                if(mes<10){
                    month='0'+mes;
                } 
                else{
                    month = String.valueOf(mes);
                }
                String year = String.ValueOf(pagos[0].CreatedDate.year());
                String yearFormato = year.substring(2);
                pagos[0].R2_COM_TXT_Budgetary_Period__c =''+month+'-'+yearFormato;
            }
            update pagos;
            }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.calcularPeriodoPresupuestario', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }

    }

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    

    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    24/10/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
  	
    public static void pagoToEC(List<R2_Compensation__c> lstPagos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            Set<Id> casosID = new Set<Id>();
            Map<Id, Id> mapECId = new Map<Id, Id>();
            Map<Id, Id> mapClientId = new Map<Id, Id>();
            
            for(R2_Compensation__c pago : lstPagos){
                    casosID.add(pago.R2_COM_LOO_Case__c);
            }
          
        	List<Case> casosHijos = [SELECT Id, AccountId, R2_CAS_CHK_Payment_to_EC__c, R2_CAS_LOO_Claimant_Entity__c FROM Case WHERE Id IN :casosID];
        	
            for(Case casoH : casosHijos){
                if(casoH.R2_CAS_CHK_Payment_to_EC__c){
                    mapECId.put(casoH.Id, casoH.R2_CAS_LOO_Claimant_Entity__c);
                    
                }
                mapClientId.put(casoH.Id, casoH.AccountId);
            }
        	
            for(R2_Compensation__c pago : lstPagos){
                if(mapECId.containsKey(pago.R2_COM_LOO_Case__c)){
                    pago.R2_COM_LOO_Account__c = mapECId.get(pago.R2_COM_LOO_Case__c);
                }else{
                    pago.R2_COM_LOO_Account__c = mapClientId.get(pago.R2_COM_LOO_Case__c);
                }
            }
        
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.pagoToEC', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    

    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    21/11/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
   	/*@future(callout=true)
    public static void lanzarIniciarPago(String pagosId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R2_Compensation__c> pagosAenviar = [SELECT Id, R2_COM_PKL_Status__c, R2_COM_LOO_Payment_Code__c, R2_COM_LOO_Payment_Code__r.R2_OPY_PCK_Status__c, R2_COM_LOO_Payment_Code__r.R2_OPY_PKL_PaymentType__c FROM R2_Compensation__c WHERE Id = :pagosId AND R2_COM_LOO_Payment_Code__c != null];
            
            if(!pagosAenviar.isEmpty()){
                if(pagosAenviar[0].R2_COM_LOO_Payment_Code__r.R2_OPY_PCK_Status__c == 'Ready' && pagosAenviar[0].R2_COM_LOO_Payment_Code__r.R2_OPY_PKL_PaymentType__c == 'Seguimiento de Pagos'){
                    WpRes resp = initiatePayment(pagosAenviar[0].Id, 0);
                    if(resp != null){
                        List<R2_Payment_order__c> ordenEnviada = [SELECT Id, R2_OPY_TXT_Comments__c, R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id = :pagosAenviar[0].R2_COM_LOO_Payment_Code__c];
                        if(resp.result == 'Success'){
                            System.debug('UPDATE');
                            pagosAenviar[0].R2_COM_PKL_Status__c = 'Enviado';
                            ordenEnviada[0].R2_OPY_TXT_Comments__c = 'El pago entro correctamente en Seguimiento de Pagos';
                            update pagosAenviar;
                            update ordenEnviada;
                        }else{
                            pagosAenviar[0].R2_COM_PKL_Status__c = 'Rechazado';
                            ordenEnviada[0].R2_OPY_PCK_Status__c = 'RECHAZADO POR INTEGRACION';
                            ordenEnviada[0].R2_OPY_TXT_Comments__c = resp.result;
                            System.debug('UPDATE');
                            update pagosAenviar;
                            update ordenEnviada;
                        }
                    }
                }    
            }  
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.lanzarIniciarPago', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }    
    }*/
    
    public static List<R2_Compensation__c> filtrarPagosOrden(List<R2_Compensation__c> antiguo, List<R2_Compensation__c> nuevo){
        try{
            List<R2_Compensation__c> lstPagos= new List<R2_Compensation__c>();
            for(integer i=0;i<antiguo.size();i++){
                System.debug(antiguo[i].R2_COM_LOO_Payment_Code__c);
                System.debug(nuevo[i].R2_COM_LOO_Payment_Code__c);
                if((antiguo[i].R2_COM_LOO_Payment_Code__c == null) && (nuevo[i].R2_COM_LOO_Payment_Code__c != null) ){
                    lstPagos.add(nuevo[i]);
                    System.debug('Lista de Pagos Filtro: '+lstPagos.size());
                }
            }
            
            return lstPagos;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.filtrarPagosOrden()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    public static List<R2_Payment_order__c> sumarImportesOP(List<R2_Compensation__c> lstPagos){
        try{
            Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
            Decimal importeTotal = 0;
            Decimal importeLocal = 0;
            Integer importeAvios = 0;

            System.debug('Lista de pagos: '+lstPagos);
            List<R2_Payment_order__c> lstOPY = [SELECT id,R2_OPY_NUM_AVIOS_amount__c,R2_OPY_DIV_Amount__c,R2_OPY_PCK_Status__c,R2_OPY_LOO_File_associated__c,R2_OPY_PKL_PaymentType__c from R2_Payment_order__c where id = :lstPagos[0].R2_COM_LOO_Payment_Code__c];
            System.debug(lstOPY);
            if(!lstOPY.isEmpty()){
                for(R2_Compensation__c pago : lstPagos){
                    if(pago.recordTypeId == rtAvios){
                        importeAvios += (Integer)pago.R2_COM_DIV_Total_Amount__c;
                    }
                    else{
                        importeTotal += pago.R2_COM_DIV_Total_Amount__c;
                        importeLocal += pago.R2_COM_NUM_Total_Amount_local__c;
                    }
                }
                lstOPY[0].R2_OPY_NUM_AVIOS_amount__c = importeAvios;
                lstOPY[0].R2_OPY_DIV_Amount__c = importeTotal;   
                lstOPY[0].R2_OPY_NUM_Local_Amount__c = importeLocal;
                update lstOPY;
                return lstOPY;
            }  
            return null;         
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.filtrarPagosOrden()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    //public static void sumarOrdenEnviada(List<R2_Payment_Order__c> ordenes){
    //    try{
    //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
    //        System.debug('Ordenes: '+ordenes);
    //        Map<Id, Decimal>  mapOrdenesAvios = new Map<Id, Decimal>();
    //        Map<Id, Decimal> mapOrdenesImden = new Map<Id, Decimal>();
            
    //        Set<Id> casosId = new Set<Id>();
            
    //        Decimal importeTotal = 0;
    //        Decimal importeAvios = 0;
            
    //        if(!ordenes.isEmpty()){
    //            for(R2_Payment_Order__c order : ordenes){
    //                casosId.add(order.R2_OPY_LOO_File_associated__c);
    //                if(order.R2_OPY_PKL_PaymentType__c == 'AVIOS' && order.R2_OPY_PCK_Status__c != 'ANULADO POR BANCO'){
    //                    mapOrdenesAvios.put(order.R2_OPY_LOO_File_associated__c, order.R2_OPY_NUM_AVIOS_amount__c);                
    //                }else if(order.R2_OPY_PKL_PaymentType__c != 'AVIOS' && order.R2_OPY_PCK_Status__c != 'ANULADO POR BANCO'){
    //                    mapOrdenesImden.put(order.R2_OPY_LOO_File_associated__c, order.R2_OPY_DIV_Amount__c);
    //                }
    //            }
    //        }
            
    //        List<Case> expAsociados = [SELECT Id, R2_CAS_NUM_Sum_Avios__c, R2_CAS_DIV_Sum_Compensation__c FROM Case WHERE Id IN :casosId]; //mapOrdenesAvios.keySet() OR Id IN :mapOrdenesImden.keySet()];
    //        System.debug('mapaExp: ' + expAsociados);
    //        if(!expAsociados.isEmpty()){
    //            for(Case casoExp : expAsociados){
    //                if(mapOrdenesAvios.containsKey(casoExp.Id)){
    //                    System.debug('mapOrdenesAvios: ' + mapOrdenesAvios.get(casoExp.Id));
    //                    if(casoExp.R2_CAS_NUM_Sum_Avios__c!= null){
    //                        System.debug('Importe Avios: '+casoExp.R2_CAS_NUM_Sum_Avios__c);
    //                        casoExp.R2_CAS_NUM_Sum_Avios__c += mapOrdenesAvios.get(casoExp.Id);
    //                    }
    //                    else{
    //                        casoExp.R2_CAS_NUM_Sum_Avios__c = 0;
    //                        casoExp.R2_CAS_NUM_Sum_Avios__c += mapOrdenesAvios.get(casoExp.Id);
    //                    }
    //                    System.debug('Pagos AVIOS: '+casoExp.R2_CAS_NUM_Sum_Avios__c);
    //                }else if(mapOrdenesImden.containsKey(casoExp.Id)){
    //                    System.debug('mapOrdenesImden: ' + mapOrdenesImden.get(casoExp.Id));
    //                    if(casoExp.R2_CAS_DIV_Sum_Compensation__c!=null){
    //                        casoExp.R2_CAS_DIV_Sum_Compensation__c += mapOrdenesImden.get(casoExp.Id);
    //                    }
    //                    else{
    //                        casoExp.R2_CAS_DIV_Sum_Compensation__c = 0;
    //                        casoExp.R2_CAS_DIV_Sum_Compensation__c += mapOrdenesImden.get(casoExp.Id);
    //                    }
    //                    System.debug('Pagos Indem: '+casoExp.R2_CAS_NUM_Sum_Avios__c);
    //                }
    //            } 
    //            update expAsociados;
    //        } 
            
    //    }catch(Exception exc){
    //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.sumarOrdenEnviada', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
    //    }
    //}
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    
    
    IN:             lstPagos: R2_Compensation__c payment list (in fact only one record will be received)
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    14/12/2017              Alberto Puerto Collado       Initial Version
    20/02/2018              Alberto Puerto Collado       Added calling to changeFlagEscalation
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/      
    public static void calculaAmountsExpedienteAsociadoOPs(List<R2_Payment_Order__c> lstOPs){      
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            System.debug(':::lstOPs recibidas:'+ lstOPs);
            /*
            notas: 
            - OP
                R2_OPY_LOO_File_associated__c = lookup a case (Expediente asociado)
                R2_OPY_PKL_PaymentType__c = Tipo de pago [AVIOS, SEPA, LATAM, CHEQUE,  Seguimiento de Pagos]
                R2_OPY_NUM_AVIOS_amount__c -> Importe AVIOS
                R2_OPY_DIV_Amount__c -> Importe
            - CASO (expedienteAsociado)
                R2_CAS_NUM_Sum_Avios__c 
                R2_CAS_DIV_Sum_Compensation__c
            */

             List<R2_Payment_order__c> lstOPsRelacionadas = [SELECT Id, R2_OPY_LOO_File_associated__c, R2_OPY_PKL_PaymentType__c, R2_OPY_NUM_AVIOS_amount__c, R2_OPY_DIV_Amount__c
                                                 FROM R2_Payment_order__c WHERE R2_OPY_LOO_File_associated__c =: lstOPs[0].R2_OPY_LOO_File_associated__c
                                                 AND (R2_OPY_PCK_Status__c = 'APLICADO' OR R2_OPY_PCK_Status__c = 'Borrador' OR R2_OPY_PCK_Status__c = 'ENVIADO A BANCO' 
                                                        OR R2_OPY_PCK_Status__c = 'ESCALADO' OR R2_OPY_PCK_Status__c = 'PENDIENTE_APLICADO' OR R2_OPY_PCK_Status__c = 'PENDIENTE_EXTRACTO'
                                                        OR R2_OPY_PCK_Status__c = 'Ready' OR R2_OPY_PCK_Status__c = 'TRAMITANDO' OR R2_OPY_PCK_Status__c = 'PAGADO'
                                                        OR R2_OPY_PCK_Status__c = 'PAGO EN GERENCIA' OR R2_OPY_PCK_Status__c = 'PENDIENTE DE PAD' OR R2_OPY_PCK_Status__c = 'EMITIDO'
                                                        OR R2_OPY_PCK_Status__c = 'PRCD' OR R2_OPY_PCK_Status__c = 'PAID')

                                                 ];
             System.debug(':::lstOPsRelacionadas: '+ lstOPsRelacionadas); 

             Case expedienteAsociado = [SELECT Id, R2_CAS_NUM_Sum_Avios__c, R2_CAS_DIV_Sum_Compensation__c FROM Case WHERE Id =: lstOPs[0].R2_OPY_LOO_File_associated__c];
             System.debug(':::expedienteAsociado: '+ expedienteAsociado); 

             if(!lstOPsRelacionadas.isEmpty()){
                Decimal sumatorioAVIOS = 0;
                Decimal sumatorioCOMP = 0;
                System.debug(':::INICIAL sumatorioAVIOS'+ sumatorioAVIOS);
                System.debug(':::INICIAL sumatorioCOMP'+ sumatorioCOMP);

                for(R2_Payment_order__c ordenPago : lstOPsRelacionadas){
                    if(ordenPago.R2_OPY_PKL_PaymentType__c == 'AVIOS'){ 
                        if(ordenPago.R2_OPY_NUM_AVIOS_amount__c != null){
                            sumatorioAVIOS += ordenPago.R2_OPY_NUM_AVIOS_amount__c; 
                            System.debug(':::sumatorioAVIOS'+ sumatorioAVIOS);
                        }
                        
                    }else if(ordenPago.R2_OPY_PKL_PaymentType__c != 'AVIOS'){
                        if(ordenPago.R2_OPY_DIV_Amount__c != null){
                            sumatorioCOMP += ordenPago.R2_OPY_DIV_Amount__c;
                            System.debug(':::sumatorioCOMP'+ sumatorioCOMP);
                        }                        
                    }
                }
                expedienteAsociado.R2_CAS_NUM_Sum_Avios__c = sumatorioAVIOS;
                expedienteAsociado.R2_CAS_DIV_Sum_Compensation__c = sumatorioCOMP;
                
                ////20/02/2018 añadido para utilizar en el Process Builder de Escalado
                changeFlagEscalation(lstOPs[0].Id);

                try{
                    update expedienteAsociado;
                    System.debug(':::INSERTADO expedienteAsociado'+ expedienteAsociado);
                }catch(DmlException exc){
                       R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.calculaAmountsExpedienteAsociadoOPs', ':::Error en: update expedienteAsociado', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
                }                
             }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CompensationTriggerMethods.calculaAmountsExpedienteAsociadoOPs', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
        }
    }  
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Asynchronous @future method to launch Process Builder with fields updated

    IN:     
    OUT:           

    History:

    <Date>                       <Author>                <Description>
    20/02/2018           Alberto Puerto Collado        Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @future(Callout = true)
    public static void changeFlagEscalation(Id opyId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug(':::changeFlag para process builder');
            List<R2_Payment_order__c> lstOPs = [SELECT Id, R2_OPY_CHK_Flag_Escalation_PBuilder__c FROM R2_Payment_order__c WHERE Id =: opyId];

            //System.debug(':::SEGUNDO UPDATE VERIFICANDO de OrdenDePago VERIFICANDO');
            if( lstOPs[0].R2_OPY_CHK_Flag_Escalation_PBuilder__c == false){
                lstOPs[0].R2_OPY_CHK_Flag_Escalation_PBuilder__c = true;
                //System.debug(':::SEGUNDO UPDATE ANTES de OrdenDePago ANTES'+ lstOPs[0]);
                update lstOPs[0];
                //System.debug(':::SEGUNDO UPDATE HECHO de OrdenDePago HECHO');
            }            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_InboxMessageRead.callInboxMessageRead_DXF', 'Error en el calling de InboxMessageRead_DXF', exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
        }
    }

    public static void lockCase (List<R2_Compensation__c> lstPagos){
    try{
        if(lstPagos[0].R2_COM_PKL_Status__c == 'Enviado'){
            List<Case> lstHijos = new List<Case>();
            lstHijos = [SELECT id,ParentId, Parent.R2_CAS_CHK_EA_Locked__c FROM Case where id = :lstPagos[0].R2_COM_LOO_Case__c limit 1];
            if(!lstHijos.isEmpty()){
                    Case padre = new Case();
                    padre.id = lstHijos[0].ParentId;
                    padre.R2_CAS_CHK_EA_Locked__c = true;
                    update padre;
                }
            }
        }
    
        catch (Exception exc){
             R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.lockCase', 'Error bloqueando expediente', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
        }

    }
}