public class R2_CLS_Payment_Order_TriggerMethods {
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

    
    public static void calcularTipoOP(List<R2_Payment_Order__c> lstOrdenes){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} 
            if(lstOrdenes[0].R2_OPY_PKL_PaymentType__c != 'AVIOS'){
                    if(Label.R2_LBL_Escoger_Proceso_Pago_SAP_OF  == 'OF'){
                    String pais = lstOrdenes[0].R2_OPY_TXT_Bank_Country__c;
                    System.debug('Pais: '+pais);
                    String moneda = lstOrdenes[0].R2_OPY_TXT_Coin__c;
                    System.debug('Moneda: '+moneda);
                    List<pagosOracle__c> lstPagosOracle = new List<pagosOracle__c>();
                    List<Case> lstExpedientes = new List <Case>();
                    List<Account> lstAccount = new List<Account>();

                    lstPagosOracle = [SELECT tipo__c,Metodo_de_Pago__c,Centro_Emisor__c from pagosOracle__c where codigoPais__c = :pais AND moneda__c = :moneda AND activo__c = true];
                    lstExpedientes = [SELECT R2_CAS_TXT_Case_Number__c FROM Case where id = :lstOrdenes[0].R2_OPY_LOO_File_associated__c];
                    System.debug('Expedientes: '+lstExpedientes.size()+' '+lstExpedientes[0].R2_CAS_TXT_Case_Number__c+' Ordenes: '+lstOrdenes[0].R2_OPY_ATXTL_Others__c);
                    lstAccount = [SELECT id, Name from Account where id = :lstOrdenes[0].R2_OPY_LOO_CaseAccount__c];
                    if(!lstAccount.isEmpty()){
                        lstOrdenes[0].R2_OPY_TXT_NIF_Name__c = lstAccount[0].Name;
                    }
                    if(!lstPagosOracle.isEmpty()){
                        System.debug('Esto entra');
                        lstOrdenes[0].R2_OPY_PKL_PaymentType__c = lstPagosOracle[0].tipo__c;
                        lstOrdenes[0].R2_OPY_FOR_Payment_Method__c = lstPagosOracle[0].Metodo_de_Pago__c;
                        lstOrdenes[0].R2_OPY_TXT_broadcast_center__c = lstPagosOracle[0].Centro_Emisor__c;
                    }
                    else{
                        System.debug('Seguimiento de pagos');
                        lstOrdenes[0].R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
                    }

                    if((lstOrdenes[0].R2_OPY_ATXTL_Others__c == null || lstOrdenes[0].R2_OPY_ATXTL_Others__c =='') && !lstExpedientes.isEmpty()){
                        lstOrdenes[0].R2_OPY_ATXTL_Others__c = lstExpedientes[0].R2_CAS_TXT_Case_Number__c;
                    }
                }

                if(Label.R2_LBL_Escoger_Proceso_Pago_SAP_OF  == 'SAP'){
                    String pais = lstOrdenes[0].R2_OPY_TXT_Bank_Country__c;
                    System.debug('Pais: '+pais);
                    String moneda = lstOrdenes[0].R2_OPY_TXT_Coin__c;
                    System.debug('Moneda: '+moneda);
                    List<PagosSAP__c> lstPagosSAP = new List<PagosSAP__c>();
                    List<Case> lstExpedientes = new List <Case>();
                    List<Account> lstAccount = new List<Account>();

                    lstPagosSAP = [SELECT TIPO_SAP__c,Metodo_de_Pago_SAP__c,Centro_Emisor_SAP__c from PagosSAP__c where Codigo_Pais_SAP__c = :pais AND Moneda_SAP__c = :moneda AND Active_SAP__c = true];
                    lstExpedientes = [SELECT R2_CAS_TXT_Case_Number__c FROM Case where id = :lstOrdenes[0].R2_OPY_LOO_File_associated__c];
                    System.debug('Expedientes: '+lstExpedientes.size()+' '+lstExpedientes[0].R2_CAS_TXT_Case_Number__c+' Ordenes: '+lstOrdenes[0].R2_OPY_ATXTL_Others__c);
                    lstAccount = [SELECT id, Name from Account where id = :lstOrdenes[0].R2_OPY_LOO_CaseAccount__c];
                    if(!lstAccount.isEmpty()){
                        lstOrdenes[0].R2_OPY_TXT_NIF_Name__c = lstAccount[0].Name;
                    }
                    if(!lstPagosSAP.isEmpty()){
                        System.debug('Esto entra');
                        lstOrdenes[0].R2_OPY_PKL_PaymentType__c = lstPagosSAP[0].Tipo_SAP__c;
                        lstOrdenes[0].R2_OPY_FOR_Payment_Method__c = lstPagosSAP[0].Metodo_de_Pago_SAP__c;
                        lstOrdenes[0].R2_OPY_TXT_broadcast_center__c = lstPagosSAP[0].Centro_Emisor_SAP__c;
                    }
                    else{
                        System.debug('Seguimiento de pagos');
                        lstOrdenes[0].R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
                    }

                    if((lstOrdenes[0].R2_OPY_ATXTL_Others__c == null || lstOrdenes[0].R2_OPY_ATXTL_Others__c =='') && !lstExpedientes.isEmpty()){
                        lstOrdenes[0].R2_OPY_ATXTL_Others__c = lstExpedientes[0].R2_CAS_TXT_Case_Number__c;
                    }
                }
            }
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.calcularTipoOP', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
        }
    }

    @future(callout=true)
    public static void enviarASeguimientoPagos(String id){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R2_Payment_order__c> ordenAenviar = [SELECT Id, R2_OPY_TXT_Comments__c, R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id = :id];
            
            if(!ordenAenviar.isEmpty()){
                WpRes resp = initiatePayment(ordenAenviar[0].Id, 0);
                if(resp != null){
                        if(resp.result == 'Success'){
                            System.debug('UPDATE');
                            ordenAenviar[0].R2_OPY_TXT_Comments__c = 'La orden de pago entro correctamente en Seguimiento de Pagos';
                            update ordenAenviar;
                        }else{
                            ordenAenviar[0].R2_OPY_PCK_Status__c = 'RECHAZADO POR INTEGRACION';
                            ordenAenviar[0].R2_OPY_TXT_Comments__c = resp.result;
                            update ordenAenviar;
                        }
                    }
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.enviarASeguimientoPagos', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_Order__c');
        }
    }

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
    09/10/2017                 Ruben Pingarron Jerez    Modify
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            List<R2_Payment_order__c> paymentOrder = [SELECT id, R2_OPY_TXT_Address1__c, R2_OPY_TXT_City__c, R2_OPY_TXT_Province__c, R2_OPY_TXT_Postal_Code__c, R2_OPY_TXT_Bank_Country__c,
                                                      R2_OPY_CHK_Urgent__c, R2_OPY_TXT_Bank_Name__c, R2_OPY_TXT_Bank_Others__c, R2_OPY_TXT_External_Local_Account__c, R2_OPY_TXT_Fed_ABA__c,
                                                      R2_OPY_TXT_Chips_ABA__c, R2_OPY_TXT_SWIFT__c, R2_OPY_TXT_IBAN__c, R2_OPY_TXT_Account_Type__c, R2_OPY_DIV_Amount__c,
                                                      R2_OPY_NUM_Local_Amount__c, R2_OPY_TXT_Coin__c, R2_OPY_TXT_NIF_Name__c, R2_OPY_TXT_NIF__c, R2_OPY_PKL_Document_Type__c FROM R2_Payment_order__c WHERE id=:paymentId];
            
            
            WpReqIni wrp =  new WpReqIni();
            
            if(!paymentOrder.isEmpty()){
                List<R2_Compensation__c> pago = [SELECT Id, R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c, R2_COM_LOO_Case__r.CaseNumber, R2_COM_LOO_Case__r.CreatedDate,
                                                 R2_COM_LOO_Case__r.R2_CAS_TXT_EA_Main_File__c, R2_COM_LOO_Case__r.Type, R2_COM_LOO_Case__r.R1_CAS_PKL_Subtype__c,
                                                 R2_COM_LOO_Case__r.Parent.CaseNumber, R2_COM_LOO_Account__r.Name, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c,
                                                 R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_AC_owner__c,
                                                 R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code_oper__c, R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c,
                                                 R2_COM_LOO_Case__r.RecordType.Name, R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c, R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c,
                                                 R2_COM_TXT_Main_Flight_Number__c, R2_COM_PKL_Payment_method__c, R2_COM_PKL_Document_Type__c FROM R2_Compensation__c WHERE R2_COM_LOO_Payment_Code__c = :paymentOrder[0].Id];
                
                
                
                String diaOpening;
                String mesOpening;
                
                String diaVuelo;
                String mesVuelo;
                
                if(!pago.isEmpty()){
                    // File details
                    wrp.fileTypeCode = pago[0].R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c!=null ? pago[0].R2_COM_LOO_Case__r.R2_CAS_PKL_Code_type_case__c:'0';
                    wrp.fileNumber = pago[0].R2_COM_LOO_Case__r.CaseNumber.right(14);
                    diaOpening = String.valueOf(pago[0].R2_COM_LOO_Case__r.CreatedDate.day());
                    if(diaOpening.length()==1){
                        diaOpening = '0' + diaOpening;
                    }
                    mesOpening = String.valueOf(pago[0].R2_COM_LOO_Case__r.CreatedDate.month());
                    if(mesOpening.length()==1){
                        mesOpening = '0' + mesOpening;
                    }
                    wrp.openingDate = diaOpening + '/' + mesOpening + '/' + String.valueOf(pago[0].R2_COM_LOO_Case__r.CreatedDate.year());  
                    wrp.externalFileNumber = pago[0].R2_COM_LOO_Case__r.R2_CAS_TXT_EA_Main_File__c;
                    wrp.caseFile = pago[0].R2_COM_LOO_Case__r.Parent.CaseNumber;
                    wrp.firstReason = pago[0].R2_COM_LOO_Case__r.Type;
                    wrp.secondReason = pago[0].R2_COM_LOO_Case__r.R1_CAS_PKL_Subtype__c;
                    wrp.thirdReason = '';
                    wrp.fourthReason = '';
                    wrp.fifthReason = '';
                    
                    // Passenger Details
                    wrp.passengerName = paymentOrder[0].R2_OPY_TXT_NIF_Name__c;
                    wrp.documentType = paymentOrder[0].R2_OPY_PKL_Document_Type__c; // revisar
                    wrp.documentNumber = paymentOrder[0].R2_OPY_TXT_NIF__c;
                    wrp.phone = ''; // payment[0].R2_COM_TLF_Passenger_Phone__c;
                    wrp.address = paymentOrder[0].R2_OPY_TXT_Address1__c;
                    wrp.location = paymentOrder[0].R2_OPY_TXT_City__c;
                    wrp.province = paymentOrder[0].R2_OPY_TXT_Province__c;
                    wrp.postCode = paymentOrder[0].R2_OPY_TXT_Postal_Code__c;   
                    
                    Schema.DescribeFieldResult fieldResult = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
                    List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                    System.debug('values' + values);
                    for( Schema.PicklistEntry v : values){
                        if(v.getLabel()==paymentOrder[0].R2_OPY_TXT_Bank_Country__c){
                            wrp.countryCode = v.getValue();
                        }else if(v.getValue()==paymentOrder[0].R2_OPY_TXT_Bank_Country__c){
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
                    wrp.paymentAmount = paymentOrder[0].R2_OPY_DIV_Amount__c;
                    wrp.localPaymentAmount = paymentOrder[0].R2_OPY_NUM_Local_Amount__c;
                    wrp.currencyCode = paymentOrder[0].R2_OPY_TXT_Coin__c;
                    wrp.urgencyIndicator = paymentOrder[0].R2_OPY_CHK_Urgent__c ? 'Y' : 'N';
                    if(pago[0].R2_COM_PKL_Payment_method__c == 'Transferencia'){
                        wrp.transferIndicator = 'Y';
                    }else if(pago[0].R2_COM_PKL_Payment_method__c == 'Cheque'){
                        wrp.transferIndicator = 'N';
                    }
                    //wrp.transferIndicator = 'N'; // Pendiente crear picklist en OPY
                    wrp.incidenceType = pago[0].R2_COM_LOO_Case__r.RecordType.Name; // revisar
                    wrp.iberiaAccount = pago[0].R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c; // revisar
                    wrp.iberiaBudgetCenterCode = pago[0].R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c; // revisar
                    
                    // Payment Agency Details
                    wrp.paymentAgencyName = '';
                    wrp.paymentAgencyAddress = '';       
                    wrp.paymentAgencyCity = '';
                    wrp.paymentAgencyCountry = '';
                    
                    // Bank Details
                    wrp.bankName = paymentOrder[0].R2_OPY_TXT_Bank_Name__c;
                    Schema.DescribeFieldResult fieldResultBank = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
                    List<Schema.PicklistEntry> values2 = fieldResultBank.getPicklistValues();
                    System.debug('values' + values2);
                    for( Schema.PicklistEntry v : values2){
                        if(v.getLabel()==paymentOrder[0].R2_OPY_TXT_Bank_Country__c){
                            wrp.bankCountry = v.getValue();
                        }else if(v.getValue()==paymentOrder[0].R2_OPY_TXT_Bank_Country__c){
                            wrp.bankCountry = v.getValue();
                        }
                    }
                    //wrp.bankCountry =  payment[0].R2_COM_LOO_Payment_Code__r.R2_OPY_TXT_Bank_Country__c;
                    wrp.additionalDetails = paymentOrder[0].R2_OPY_TXT_Bank_Others__c;
                    wrp.fullAccountNumber = paymentOrder[0].R2_OPY_TXT_External_Local_Account__c;
                    wrp.fedAbaCode = paymentOrder[0].R2_OPY_TXT_Fed_ABA__c;
                    wrp.chipsAbaCode = paymentOrder[0].R2_OPY_TXT_Chips_ABA__c;
                    wrp.swiftCode = paymentOrder[0].R2_OPY_TXT_SWIFT__c;
                    wrp.ibanCode = paymentOrder[0].R2_OPY_TXT_IBAN__c;
                    wrp.accountType = paymentOrder[0].R2_OPY_TXT_Account_Type__c;
                    wrp.chequeCollectionLocation = '';
                    
                    // Flight details
                    wrp.marketingCompany = pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;
                    wrp.operatingCompany = pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code_oper__c;
                    wrp.responsibleCompany = pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_AC_owner__c;
                    wrp.flightNumber = pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c; 
                    wrp.principalFlightNumber = pago[0].R2_COM_TXT_Main_Flight_Number__c;
                    if(pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c!=null){
                        diaVuelo = String.valueOf(pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.day());
                        if(diaVuelo.length()==1){
                            diaVuelo = '0' + diaVuelo;
                        }
                        mesVuelo = String.valueOf(pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.month());
                        if(mesVuelo.length()==1){
                            mesVuelo = '0' + mesVuelo;
                        }
                        wrp.flightDate = diaVuelo + '/' + mesVuelo + '/' + String.valueOf(pago[0].R2_COM_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c.year()); 
                    }
                    
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
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.initiatePayment()', '', 'No se puede conectar con Intelligence Integration INIT TOKEN', 'R2_Compensation__c');
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
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.initiatePayment()', '', 'No se puede conectar con Intelligence Integration INIT', 'R2_Payment_order__c');
                    return respFail;
                }
            }         
            
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Payment_Order_TriggerMethods.initiatePayment()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Payment_order__c');
            return null;
        }
    }
    
}