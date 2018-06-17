public with sharing class R1_CLS_SendCustomerMDM {

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                  <Author>                <Change Description>
    12/05/2017              Alvaro García           Initial Version
    13/12/2017              Ricardo Pereira         Updated Wrappers
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public class Organization {
        public String organisationId;
        public String organisationName;
        public String tourCode;
        public String ssrClid;
        public String cifNumber;
        public String activityCode;
        public String activityDescription;
        public String categoryCode;
        public String categoryDescription;
        public String businessSalesType;
        public String organisationSalesLevel;
        public String organisationObLevel;
        public String loyaltyCardCode;
        public String status;
        public Datetime lastUpdateDate;
    }

    public class Address {
        public String addressId;
        public String addressType;
        public String streetName;
        public String streetNumber;
        public String streetNumberComplement;
        public String streetComplement;
        public String residentialArea;
        public String postalCode;
        public String town;
        public String municipality;
        public String province;
        public String region;
        public String country;
        public String loyaltyCardCode;
        public String addressValidation;
        public String status;
        public Datetime lastUpdateDate;
    }

    public class Contacto {
        public String contactId;
        public String contactType;
        public String formOfContact;
        public String contactData;
        public String primaryMarketingFlag;
        public String primaryOperativeFlag;
        public String contactValidation;
        public String loyaltyCardCode;
        public String status;
        public Datetime lastUpdateDate;
    }

    public class Document {
        public String documentId;
        public String idType;
        public String identificationNumber;
        public Date expiryDate;
        public String countryOfIssuance;
        public String documentNationality;
        public String preference;
        public String documentValidation;
        public String loyaltyCardCode;
        public String status;
        public Datetime lastUpdateDate;
    }

    public class Card {
        public String loyaltyCardId;
        public String cardTypeCode;
        public String cardTypeDescription;
        public String cardNumber;
        public String plasticTypeCode;
        public String plasticTypeDescription;
        public String preference;
        public String loyaltyCardCode;
        public String status;
    }

    public class MarketingPermission {
        public String channel;
        public String communicationType;
        public String communicationEnabledFlag;
        public String loyaltyCardCode;
        public String status;
        public Datetime lastUpdateDate;

    }

    public class Source_MDM {
        public String sourceSystemName;
        public String customerId;
    }

    public class RequestDelete {
        public Source_MDM source;
        public String goldenRecordId;
    }

    public class Request {
        public Source_MDM source;
        public String goldenRecordId;
        public String customerName;
        public String firstSurname;
        public String secondSurname;
        public Date registrationDate;
        public Date birthDate;
        public String genderCode;
        public String maritalStatusCode;
        public String familyMemberCount;
        public String childrenBirthYear;
        public String nationalityCode;
        public String secondNationalityCode;
        public String thirdNationalityCode;
        public String onBusinessRole;
        public String salesRole;
        public String professionCode;
        public String preferredLanguageCode;
        public String communicationLanguageCode;
        public String collectiveCode;
        public String largeFamilyFlag;
        public String influencerFlag;
        public String ibEmployeeFlag;
        public String ibBeneficiaryFlag;
        public String referenceCustomerFlag;
        public String ibSingularFlag;
        public String pdnIndicator;
        public String decisionMakerIndicator;
        public String recruitmentCode;
        public String watchlistFlag;
        public String whitelistFlag;
        public String marketingPhone;
        public String operativePhone;
        public OrganizationList organizations;
        public AddressList addresses;
        public ContactList contacts;
        public DocumentList documents;
        public CardList cards;
        public MKList marketingPermissions;
    }

    public class OrganizationList{
        public List<Organization> organization;
    }

    public class AddressList{
        public List<Address> address;
    }

    public class ContactList{
        public List<Contacto> contact;
    }

    public class DocumentList{
        public List<Document> document;
    }

    public class CardList{
        public List<Card> card;
    }

    public class MKList{
        public List<MarketingPermission> marketingPermission;
    }

    public class RequestBody{
        public Request request;
    }

    //public abstract class Response {

    //}

    public class SuccessResponse {// extends Response{
        public String goldenRecordId;
        public Source_MDM source;
    }

    public class SuccessResponseUpdate {// extends Response{
        public Response response;
    }
    public class Response {// extends Response{
        public String goldenRecordId;
        public Source sources;
    }

    public class Source {// extends Response{
        public List<Source_MDM> source;
    }

    public class ErrorResponse {// extends Response{
        public String errorCode;
        public String errorDescription;
    }

    public class WS_responseCustomer_Error {
        //public Customer ws_Customer;
        public ErrorResponse ws_Error;
    }

    public class WS_login_Body {
        public String grant_type;
    }

    public class WS_login_response {
        public String access_token;
        public Integer expires_in;
        public Integer refresh_expires_in;
        public String refresh_token;
        public String token_type;
        public String id_token;
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to create the package to send to MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    12/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static RequestBody createPackage(Id idcustomer){

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            Account acc = [SELECT FirstName, Id, LastName, PersonEmail, Phone, R1_ACC_CHK_Flag_Iberia_Singular__c, 
                    R1_ACC_CHK_Flag_numerous_family__c, R1_ACC_CHK_flag_referenced_customer__c, R1_ACC_CHK_Flag_watch_list__c, 
                    R1_ACC_CHK_Flag_white_list__c, R1_ACC_CHK_Ind_decision_maker__c, PersonBirthdate, 
                    R1_ACC_DAT_registration_date__c, R1_ACC_EMA_Email_Operative__c, R1_ACC_EMA_Marketing_Email__c, 
                    R1_ACC_NUM_Number_people_in_family__c, R1_ACC_PKL_Card_Type__c, R1_ACC_PKL_Collective__c, R1_ACC_PKL_Comunication_Language__c,
                    R1_ACC_PKL_Gender_description__c, R1_ACC_PKL_identification_Type__c, R1_ACC_PKL_Ind_PDN__c, 
                    R1_ACC_PKL_Marital_Status_description__c, R1_ACC_PKL_Nationality_Desc__c, R1_ACC_PKL_Nationality2_Desc__c, 
                    R1_ACC_PKL_Nationality3_Desc__c, R1_ACC_PKL_Preference_language_desc__c, R1_ACC_PKL_Proffesion_description__c, 
                    R1_ACC_PKL_Recruitment_code__c, R1_ACC_TLF_Phone_Marketing__c, R1_ACC_TLF_Phone_Operative__c, R1_ACC_TXT_Children_years_birth__c, 
                    R1_ACC_TXT_Email_Operative__c, R1_ACC_TXT_Identification_number__c, R1_ACC_TXT_Ind_beneficiary_Ib_employee__c, 
                    R1_ACC_TXT_Ind_IB_employee__c, R1_ACC_TXT_Ind_influencer__c, R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c , 
                    R1_ACC_TXT_Role_on_bussines__c, R1_ACC_TXT_Role_on_sales__c,R1_ACC_TXT_Id_Golden_record__c 
                    FROM Account WHERE Id = : idCustomer LIMIT 1];

            //Construyo body de la request con datos de cliente
            if (acc != null) {
                RequestBody body = new RequestBody();

                Source_MDM source_MDM = new Source_MDM();
                source_MDM.sourceSystemName = 'SFS';
                source_MDM.customerId = acc.Id;

                Request cliente = new Request();
                cliente.goldenRecordId = acc.R1_ACC_TXT_Id_Golden_record__c;
                cliente.birthDate = acc.PersonBirthdate;
                cliente.childrenBirthYear = acc.R1_ACC_TXT_Children_years_birth__c;
                cliente.collectiveCode = acc.R1_ACC_PKL_Collective__c;
                cliente.communicationLanguageCode = acc.R1_ACC_PKL_Comunication_Language__c;
                cliente.customerName = acc.firstName;
                cliente.decisionMakerIndicator = acc.R1_ACC_CHK_Ind_decision_maker__c?'Yes':'No';
                cliente.familyMemberCount = String.valueOf(acc.R1_ACC_NUM_Number_people_in_family__c);
                cliente.firstSurname = acc.lastName;
                cliente.genderCode = acc.R1_ACC_PKL_Gender_description__c;
                cliente.ibBeneficiaryFlag = acc.R1_ACC_TXT_Ind_beneficiary_Ib_employee__c == 'YES' || acc.R1_ACC_TXT_Ind_beneficiary_Ib_employee__c == 'No'?acc.R1_ACC_TXT_Ind_IB_employee__c:null;
                cliente.ibEmployeeFlag = acc.R1_ACC_TXT_Ind_IB_employee__c == 'YES' || acc.R1_ACC_TXT_Ind_IB_employee__c == 'No'?acc.R1_ACC_TXT_Ind_IB_employee__c:null;
                cliente.ibSingularFlag = acc.R1_ACC_CHK_Flag_Iberia_Singular__c?'Yes':'No';
                cliente.influencerFlag = acc.R1_ACC_TXT_Ind_influencer__c == 'YES' || acc.R1_ACC_TXT_Ind_influencer__c == 'No'?acc.R1_ACC_TXT_Ind_IB_employee__c:null;
                cliente.largeFamilyFlag = acc.R1_ACC_CHK_Flag_numerous_family__c?'Yes':'No';
                cliente.maritalStatusCode = acc.R1_ACC_PKL_Marital_Status_description__c;
                cliente.nationalityCode = acc.R1_ACC_PKL_Nationality_Desc__c;
                cliente.onBusinessRole = acc.R1_ACC_TXT_Role_on_bussines__c;
                cliente.pdnIndicator = acc.R1_ACC_PKL_Ind_PDN__c;
                cliente.preferredLanguageCode = acc.R1_ACC_PKL_Preference_language_desc__c;
                cliente.professionCode = acc.R1_ACC_PKL_Proffesion_description__c;
                cliente.recruitmentCode = acc.R1_ACC_PKL_Recruitment_code__c;
                cliente.referenceCustomerFlag = acc.R1_ACC_CHK_flag_referenced_customer__c?'Yes':'No';
                cliente.registrationDate = acc.R1_ACC_DAT_registration_date__c;
                cliente.salesRole = acc.R1_ACC_TXT_Role_on_sales__c;
                cliente.secondNationalityCode = acc.R1_ACC_PKL_Nationality2_Desc__c;
                cliente.marketingPhone = acc.R1_ACC_TLF_Phone_Marketing__c ;
                cliente.operativePhone =  acc.R1_ACC_TLF_Phone_Operative__c;
                //cliente.secondSurname = ; //no lo rrellenamos nunca, todo el apellido en first surname
                cliente.source = source_MDM;
                cliente.thirdNationalityCode = acc.R1_ACC_PKL_Nationality3_Desc__c;
                cliente.watchlistFlag = acc.R1_ACC_CHK_Flag_watch_list__c?'Yes':'No';
                cliente.whitelistFlag = acc.R1_ACC_CHK_Flag_white_list__c?'Yes':'No';


                body.request = cliente;
                //List<R1_Contact_Data__c> contact_lst = [SELECT Id, R1_CD_PKL_Type_contact__c, R1_CD_TXT_Contact__c FROM R1_Contact_Data__c WHERE R1_CD_LOO_Client__c = : idCustomer];
                //String[] lst_Campos = new String[]{'R1_ACC_EMA_Marketing_Email__c', 'R1_ACC_TXT_Email_Operative__c', 'R1_ACC_TLF_Phone_Marketing__c', 'R1_ACC_TLF_Phone_Operative__c'};

                //Envio como registro de Contact: Marketing/operative Email, Marketing/operative phone y PersonEmail
                ContactList contacts = new ContactList();
                List<Contacto> contact_lst_MDM = new List<Contacto>();
                cliente.contacts = contacts;
                contacts.contact = contact_lst_MDM;

                Contacto contacto_aux;
                if(acc.R1_ACC_EMA_Marketing_Email__c != null){
                    contacto_aux = new Contacto();
                    contacto_aux.contactData = acc.R1_ACC_EMA_Marketing_Email__c;
                    contact_lst_MDM.add(contacto_aux);
                }

                if(acc.R1_ACC_TXT_Email_Operative__c != null){
                    contacto_aux = new Contacto();
                    contacto_aux.contactData = acc.R1_ACC_TXT_Email_Operative__c;
                    contact_lst_MDM.add(contacto_aux);

                }

                if(acc.R1_ACC_TLF_Phone_Marketing__c != null){
                    contacto_aux = new Contacto();
                    contacto_aux.contactData = acc.R1_ACC_TLF_Phone_Marketing__c;
                    contact_lst_MDM.add(contacto_aux);

                }

                if(acc.R1_ACC_TLF_Phone_Operative__c != null){
                    contacto_aux = new Contacto();
                    contacto_aux.contactData = acc.R1_ACC_TLF_Phone_Operative__c;
                    contact_lst_MDM.add(contacto_aux);

                }

                if(acc.PersonEmail != null){
                    contacto_aux = new Contacto();
                    contacto_aux.contactData = acc.PersonEmail;
                    contact_lst_MDM.add(contacto_aux);

                }

                if(contact_lst_MDM.isEmpty()){
                    contact_lst_MDM = null;
                } 
                //for(String campo : lst_Campos) {
                //    if (acc.get(campo) != null && acc.get(campo) != '') {
                //        Contacto contacto_aux = new Contacto();
                //        contacto_aux.contactType = campo.contains('EMA') ? 'EMAIL': 'PHONE'; // PHONE /EMAIL
                //        contacto_aux.contactData = (String)acc.get(campo);
                //        contact_lst_MDM.add(contacto_aux);
                //    }
                    
                //}
                

                //OrganizationList organizations = new OrganizationList();
                //List<Organization> organization_lst_MDM = new List<Organization>();
                //organization empresa = new organization();
                //organization_lst_MDM.add(empresa);
                //cliente.organizations = organizations;
                //organizations.organization = organization_lst_MDM;

                //AddressList adresses = new AddressList();
                //List<Address> address_lst_MDM = new List<Address>();
                //address direccion = new address();
                //address_lst_MDM.add(direccion);
                //cliente.addresses = adresses;
                //adresses.address = address_lst_MDM;

                DocumentList documents = new DocumentList();
                List<Document> documentIdent_lst_MDM = new List<Document>();
                
                if(acc.R1_ACC_TXT_Identification_number__c != null){
                    Document documento = new Document();
                    documento.identificationNumber = acc.R1_ACC_TXT_Identification_number__c;
                    documento.idType = acc.R1_ACC_PKL_identification_Type__c;
                    documentIdent_lst_MDM.add(documento);
                }
                
                if(documentIdent_lst_MDM.isEmpty()){
                    documentIdent_lst_MDM = null;
                }
                cliente.documents = documents;
                documents.document = documentIdent_lst_MDM;

                CardList cards = new CardList();
                List<Card> loyaltyCard_lst_MDM = new List<Card>();

                if(acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c != null){
                    Card loyCard = new Card();
                    loyCard.cardNumber = acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c;
                    loyCard.cardTypeCode = acc.R1_ACC_PKL_Card_Type__c;
                    loyaltyCard_lst_MDM.add(loyCard);
                }
                if(loyaltyCard_lst_MDM.isEmpty()){
                    loyaltyCard_lst_MDM = null;
                }
                cliente.cards = cards;
                cards.card = loyaltyCard_lst_MDM;

                //MKList marketingPermissions = new MKList();
                //List<MarketingPermission> markPerm_lst_MDM = new List<MarketingPermission>();
                //MarketingPermission markPerm = new MarketingPermission();
                //markPerm_lst_MDM.add(markPerm);
                //cliente.marketingPermissions = marketingPermissions;
                //marketingPermissions.marketingPermission = markPerm_lst_MDM;
              

                return body;
            }
            else {
                return null;
            }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.createPackage()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to login in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    12/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //@future(Callout = true)
    public static void login() {
        HTTPResponse res;
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            string wsMethod = 'ETL_Login';
            System.debug('Aqui coge el ETL del login');
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    //System.debug('Peto en primer If');
                    return;
                   
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            System.debug('Ha cogido el endpoint del login' + req.getEndpoint());
            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            //Comentar una linea u otra dependiendo de si se va a subir a prod o a sandbox
            //Produccion
            //Blob client_authotization = Blob.valueOf('iberia_crm:87e6d4b4-b5d3-4a42-b31e-26938d2ec007');
            //Pre
            Blob client_authotization = Blob.valueOf(Label.LoginCredentials);
            
            
            String client_encode = EncodingUtil.base64Encode(client_authotization);
            System.debug('!!!client_encode: ' + client_encode);
            req.setHeader('Authorization', 'Basic ' +  client_encode);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            //req.setHeader('grant_type', 'client_credentials');

            String body = 'grant_type=client_credentials';
            req.setbody(body);
            //req.setbody(body);
            //WS_login_Body body = new WS_login_Body();
            //body.grant_type = 'client_credentials';
            //req.setBody(JSON.serialize(body));

            //System.debug('!!!body: ' + req.getBody());
            req.setTimeout(35000);
            system.debug('!!!req: ' + req);
            
            Http http = new Http();
            

            //comprueba si se esta ejecutando las pruebas del test
            if(!System.Test.isRunningTest()){
                res = http.send(req);
                WS_login_response responseToken = new WS_login_response();
                responseToken = (WS_login_response)JSON.deserialize(res.getBody(),WS_login_response.class);
                System.debug('!!!res.getBody(): ' + res.getBody());
                System.debug('responseToken: ' + responseToken);
                System.debug('responseToken.access_token: ' + responseToken.access_token);

                R1_CLS_Utilities.putCache('local.sessionCache.token', responseToken.access_token);
            }
            else{
                res = new HTTPResponse();
                res.setStatusCode(200);
                res.setBody('{"access_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiO", "expires_in":3600, "id_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiOiJhYTQ2OTUzOS1kMGFlL", "refresh_expires_in":604800, "refresh_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiOiJhMWNmNTUwYS1", "token_type":"bearer"}');

                WS_login_response responseToken = new WS_login_response();
                responseToken = (WS_login_response)JSON.deserialize(res.getBody(),WS_login_response.class);
                
                R1_CLS_Utilities.putCache('local.sessionCache.token', responseToken.access_token);
            }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.login()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to call to the method that insert the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    12/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    @future(Callout = true)
    public static void callRegister(Id idCustomer, Integer contador) {
        SuccessResponse regResponse = registerCustomer(idCustomer, contador);

        if(regResponse != null) {// && regResponse instanceof response){
                Account customer = new Account(Id = idCustomer, R1_ACC_TXT_Id_Golden_record__c = regResponse.goldenRecordId);
                update customer;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to insert the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    12/05/2017                 Alvaro García            Initial Version
    27/03/2018                 Alvaro García            Added time by custom setting
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static SuccessResponse registerCustomer(Id idCustomer, Integer contador) {

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            string wsMethod = 'R1_MDM_registerCustomer';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(contador < 3){
                    login();
                    contador += 1;
                    return registerCustomer(idCustomer, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.registerCustomer()', idCustomer,'No se puede conectar con MDM', 'Account');          
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            //req.setTimeout(35000);
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('MDM_online');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);
            
            RequestBody objectToSend = createPackage(idCustomer);
            System.debug('objectToSend: ' + objectToSend);

            System.debug('#RP# JSON Request: ' + JSON.serialize(objectToSend, true));
            req.setBody(JSON.serialize(objectToSend, true));
            System.debug('!!!req insertar mdm: ' + req);
            Http http = new Http();
            HTTPResponse res;
            
            if(objectToSend != null){

                if(!System.Test.isRunningTest()) {
                        res = http.send(req);
                }
                else {
                    res = new HTTPResponse();
                    res.setStatusCode(200);
                    res.setBody('{"goldenRecordId": "8860003","source": {"sourceSystemName": "IBPLUS","customerId": "X458921"}}');
                }

                System.debug('!!!body: ' + res.getBody());

                //obtenemos los datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                    SuccessResponse resp = (SuccessResponse)JSON.deserialize(res.getBody(),SuccessResponse.class);
                    System.debug('!!!res insertar mdm: ' + res);
                    System.debug('!!!resp insertar mdm: ' + resp);
                    return resp;
                }
                else if (contador < 3 && res.getStatusCode() == 401) {
                    login();
                    contador += 1;
                    return registerCustomer(idCustomer, contador);
                }
                else {
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.registerCustomer()', idCustomer,
                        'Error en conexion con MDM. \nCodigo: ' + (res!=null? ''+res.getStatusCode():'') + '\nResponseBody: ' + (res!=null?res.getBody():''), 'Account');          
                    return null;
                }
            }else{
                return null;
            }
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.registerCustomer()', idCustomer, exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to call to the method that update the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    15/05/2017                 Alvaro García            Initial Version
    27/03/2018                 Alvaro García            Added condition to update the account in Salesforce
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @future(Callout = true)
    public static void callUpdate(Id idCustomer, Integer contador, String goldenRecord) {
        SuccessResponseUpdate regResponse = updateCustomer(idCustomer, contador);

        //if(regResponse != null && regResponse.response != null && goldenRecord != regResponse.response.goldenRecordId) {// && regResponse instanceof response){
        //    Account customer = new Account(Id = idCustomer, R1_ACC_TXT_Id_Golden_record__c = regResponse.response.goldenRecordId);
        //    update customer;
        //}
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to updatet the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    15/05/2017                 Alvaro Garcia            Initial Version
    27/03/2018                 Alvaro Garcia            Added time by custom setting
    07/05/2018                 Alvaro Garcia            Update the field R2_ACC_CHK_Send_to_MDM__c a true and the field R1_ACC_DATH_Send_to_MDM__c with the actual date/time
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static SuccessResponseUpdate updateCustomer(Id idCustomer, Integer contador) {

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            string wsMethod = 'R1_MDM_registerCustomer';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            if (token == null) {
                if(contador < 3){
                    login();
                    contador += 1;
                    return updateCustomer(idCustomer, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.updateCustomer()', idCustomer,'No se puede conectar con MDM', 'Account');          
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('MDM_online');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);
            
            RequestBody objectToSend = createPackage(idCustomer);

            req.setBody(JSON.serialize(objectToSend, true));
            System.debug('!!!req actualizar mdm: ' + req);
            Http http = new Http();
            HTTPResponse res;
            


            if(!System.Test.isRunningTest()) {
                    res = http.send(req);
                    //Se pone a true el check de enviado a MDM 
                    Account customer = new Account(Id = idCustomer, R2_ACC_CHK_Send_to_MDM__c = true, R1_ACC_DATH_Send_to_MDM__c = System.now());
                    update customer;
            }
            else {
                res = new HTTPResponse();
                res.setStatusCode(200);
                res.setBody('{"goldenRecordId": "8860003","source": {"sourceSystemName": "IBPLUS","customerId": "X458921"}}');
            }

            System.debug('!!!body: ' + res.getBody());

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                SuccessResponseUpdate resp = (SuccessResponseUpdate)JSON.deserialize(res.getBody(),SuccessResponseUpdate.class);
                return resp;
            }
            else if (contador < 3 && res.getStatusCode() == 401) {
                login();
                contador += 1;
                return updateCustomer(idCustomer, contador);
            }
            else {
                R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.registerCustomer()', idCustomer,
                    'Error en conexion con MDM. \nCodigo: ' + (res!=null? ''+res.getStatusCode():'') + '\nResponseBody: ' + (res!=null?res.getBody():''), 'Account');          
                return null;
            }
        
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.updateCustomer()', idCustomer, exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to call to the method that delete the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    21/03/2018                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @future(Callout = true)
    public static void callDelete(Id idCustomer, Integer contador) {
        SuccessResponseUpdate regResponse = deleteCustomer(idCustomer, contador);

        //updateCustomer(idCustomer, contador);
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to call to the method that delete the client in MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    21/03/2018                 Alvaro García            Initial Version
    27/03/2018                 Alvaro García            Added time by custom setting
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    //@future(Callout = true)
    //no hay delete hasta el momento
    public static SuccessResponseUpdate deleteCustomer(String idCustomer, Integer contador) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            string wsMethod = 'R1_MDM_registerCustomer';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delete');
            //system.debug(endPoint + parametersEndPoint);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            if (token == null) {
                if(contador < 3){
                    login();
                    contador += 1;
                    return deleteCustomer(idCustomer, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.deleteCustomer()', idCustomer,'No se puede conectar con MDM', 'Account');          
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('MDM_online');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);
            List<Account> lstAcc = [SELECT id,R1_ACC_TXT_Id_Golden_record__c from Account where id = :idCustomer];   
            RequestDelete objectToSend = new RequestDelete();
            Source_MDM source = new Source_MDM();
            source.sourceSystemName = 'SFS';
            source.customerId = idCustomer;
            objectToSend.source = source;
            objectToSend.goldenRecordId = lstAcc[0].R1_ACC_TXT_Id_Golden_record__c;

            req.setBody(JSON.serialize(objectToSend));
            System.debug('!!!req borrar mdm: ' + req);
            Http http = new Http();
            HTTPResponse res;
                
            if(!System.Test.isRunningTest()) {
                res = http.send(req);
            }
            else {
                res = new HTTPResponse();
                res.setStatusCode(200);
                res.setBody('{"goldenRecordId": "8860003","source": {"sourceSystemName": "IBPLUS","customerId": "X458921"}}');
            }

            System.debug('!!!body: ' + res.getBody());

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                SuccessResponseUpdate resp = (SuccessResponseUpdate)JSON.deserialize(res.getBody(),SuccessResponseUpdate.class);
                return resp;
            }
            else if (contador < 3 && res.getStatusCode() == 401) {
                login();
                contador += 1;
                return deleteCustomer(idCustomer, contador);
            }
            else {
                R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.registerCustomer()', idCustomer,
                    'Error en conexion con MDM. \nCodigo: ' + (res!=null? ''+res.getStatusCode():'') + '\nResponseBody: ' + (res!=null?res.getBody():''), 'Account');          
                return null;
            }
            //if(res.getStatusCode() == 200 || res.getStatusCode() == 500){
            //    SuccessResponseUpdate resp = (SuccessResponseUpdate)JSON.deserialize(res.getBody(),SuccessResponseUpdate.class);
            //    return resp;
            //}
            //else {
            //    ErrorResponse resp = (ErrorResponse)JSON.deserialize(res.getBody(),ErrorResponse.class);
            //    return resp;
            //}
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SendCustomerMDM.deleteCustomer()', idCustomer, exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }
    }
}