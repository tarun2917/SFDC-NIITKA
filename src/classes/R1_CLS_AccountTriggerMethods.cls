public with sharing class R1_CLS_AccountTriggerMethods {
    
    public class WS_login_Body {
        public String clientId;
        public String clientSecret;
    }
    
    public class WS_login_response {
        public String accessToken;
        public Integer expiresIn;
    }

    public class wrpBorradoMKT{
        public Integer ContactTypeId = 2;
        public List<String> Values = new List<String>();
        public String DeleteOperationType = 'ContactAndAttributes';
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia 
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    18/05/2017              Alvaro Garcia           Initial Version     
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to check if its neccessary to send the data to MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    18/05/2017                 Alvaro Garcia            Initial Version
    07/05/2018                 Alvaro Garcia            Add condition to don't do anything if change the field R2_ACC_CHK_Send_to_MDM__c or R1_ACC_DATH_Send_to_MDM__c or R1_ACC_TXT_Id_Golden_record__c
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
    public static void callIntegrationMDM(List<Account> lst_news, List<Account> lst_olds){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
                        
            for (Integer i = 0; i < lst_news.size(); i++) {
                //insert
                if (lst_olds == null) {
                    R1_CLS_SendCustomerMDM.callRegister(lst_news[i].Id, 0);
                }
                //update
                else {
                    //if (lst_news[i].firstName != lst_olds[i].firstName || lst_news[i].lastName != lst_olds[i].lastName || lst_news[i].R1_ACC_DAT_Date_birth__c != lst_olds[i].R1_ACC_DAT_Date_birth__c || lst_news[i].R1_ACC_EMA_Marketing_Email__c != lst_olds[i].R1_ACC_EMA_Marketing_Email__c
                    //     || lst_news[i].R1_ACC_TXT_Email_Operative__c != lst_olds[i].R1_ACC_TXT_Email_Operative__c || lst_news[i].R1_ACC_TLF_Phone_Marketing__c != lst_olds[i].R1_ACC_TLF_Phone_Marketing__c || lst_news[i].R1_ACC_TLF_Phone_Operative__c != lst_olds[i].R1_ACC_TLF_Phone_Operative__c) 
                    //Se envia con cualquier cambio en el cliente
                    if (lst_news[i].R1_ACC_CHK_Unsubscribe__c != lst_olds[i].R1_ACC_CHK_Unsubscribe__c && lst_news[i].R1_ACC_CHK_Unsubscribe__c == true && lst_news[i].R1_ACC_TXT_Id_Golden_record__c!=null) {
                        R1_CLS_SendCustomerMDM.callDelete(lst_news[i].Id, 0);
                    }
                    else if (lst_news[i].R1_ACC_DATH_Send_to_MDM__c != lst_olds[i].R1_ACC_DATH_Send_to_MDM__c || lst_news[i].R2_ACC_CHK_Send_to_MDM__c != lst_olds[i].R2_ACC_CHK_Send_to_MDM__c || (lst_news[i].R1_ACC_TXT_Id_Golden_record__c != lst_olds[i].R1_ACC_TXT_Id_Golden_record__c && lst_news[i].R1_ACC_TXT_Id_Golden_record__c != null)|| (lst_news[i].R2_ACC_CHK_GDPR_UnSub__c)) {
                        return ;
                    }
                    else {
                        R1_CLS_SendCustomerMDM.callUpdate(lst_news[i].Id, 0, lst_news[i].R1_ACC_TXT_Id_Golden_record__c);
                    }
                }
            }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.callIntegrationMDM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        }
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that sets the format for the marketing phones.
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    03/08/2017                 Borja Gay            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
    public static void formatPhones(List<Account> lst_news){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
                for(Account acc : lst_news){
                    if(acc.R1_ACC_TLF_Phone_Marketing__c!=null && acc.R1_ACC_TLF_Phone_Marketing__c!=''){
                        if(acc.R1_ACC_TLF_Phone_Marketing__c.startsWith('+')){
                            List<String> tlfPartido = acc.R1_ACC_TLF_Phone_Marketing__c.subString(1).split(' ');
                            String tlf='';
                            for(String parte : tlfPartido){
                                tlf=tlf+parte;
                            }
                            acc.R2_ACC_TLF_Phone_MarketingII__c = tlf;
                        }
                        else{
                            acc.R2_ACC_TLF_Phone_MarketingII__c = acc.R1_ACC_TLF_Phone_Marketing__c;
                        }
                    }
                    else{}
                    
                    if(acc.R1_ACC_TLF_Phone_Operative__c!=null && acc.R1_ACC_TLF_Phone_Operative__c!=''){
                        if(acc.R1_ACC_TLF_Phone_Operative__c.startsWith('+')){
                            List<String> tlfPartido = acc.R1_ACC_TLF_Phone_Operative__c.subString(1).split(' ');
                            String tlf='';
                            for(String parte : tlfPartido){
                                tlf=tlf+parte;
                            }
                            acc.R2_ACC_TLF_Phone_OperativeII__c = tlf;
                        }
                        else{
                            acc.R2_ACC_TLF_Phone_OperativeII__c = acc.R1_ACC_TLF_Phone_Operative__c;
                        }
                    }
                    else{}
                
                }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.formatPhones()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to check if its neccessary to send the data to MDM
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    18/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
    //public static void callIntegrationMDM(List<Account> lst_news, List<Account> lst_olds){
 //     try{
 //         if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
 //         Set<Id> setAccId = new Set<Id>();
 //         for (Account acc : lst_news) {
 //             setAccId.add(acc.Id);
 //         }

 //         //String query = 'SELECT Id, R1_CD_LOO_Client__c FROM R1_Contact_Data__c WHERE R1_CD_LOO_Client__c : IN setAccId AND ';
 //         //for (String campo : lst_campos) {
 //         //  query += ' AND ' + campo + '!= null OR ' + campo + '!= \'\'';
 //         //}
    //      //List<R1_Contact_Data__c> lst_CD = Database.query(query);
            
 //         List<R1_Contact_Data__c> lst_CD = [SELECT Id, R1_CD_LOO_Client__c, R1_CD_TXT_Contact__c, R1_CD_PKL_Type_contact__c FROM R1_Contact_Data__c WHERE R1_CD_LOO_Client__c IN :setAccId AND R1_CD_TXT_Contact__c != null AND R1_CD_TXT_Contact__c != '' AND R1_CD_PKL_Type_contact__c != null AND R1_CD_PKL_Type_contact__c != ''];
            
 //         Set<Id> setSendMDM = new Set<Id>();
 //         for(R1_Contact_Data__c cd : lst_CD) {
 //             setSendMDM.add(cd.R1_CD_LOO_Client__c);
 //         }

 //         for (Integer i = 0; i < lst_news.size(); i++) {
 //             if (setSendMDM.contains(lst_news[i].id)) {
 //                 //for (String campo : lst_campos) {
                        
    //                  //if (lst_news[i].get(campo) != lst_olds[i].get(campo)) {
    //                      R1_CLS_SendCustomerMDM.updateCustomer(lst_news[i].Id, 0);
    //                      //break;
    //                  //}
    //              //}
 //             }
                
 //         }

    //  }catch(Exception exc){

    //      R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.callIntegrationMDM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
    //  }
    //}


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alejandro Turiégano
    Company:        Accenture
    Description:    Method to check if its neccessary to give vissibility to MarketingCloud
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                     <Change Description>
    30/11/2017                 Alejandro Turiégano          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
    public static void checkToMarketingCloud(List<Account> lst_news){
        try{
            for(Account acc : lst_news){
                if(((acc.PersonEmail != null && acc.PersonEmail != '') || (acc.Phone != null && acc.Phone != '')) && acc.isPersonAccount == true){
                    acc.R2_ACC_CHK_Marketing_Cloud__c = true;
                    acc.R2_CON_CHK_Marketing_Cloud__pc = true;
                }else{
                    acc.R2_ACC_CHK_Marketing_Cloud__c = false;
                    acc.R2_CON_CHK_Marketing_Cloud__pc = false;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.checkToMarketingCloud()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        }
    }


    public static void loginMKT() {
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            WS_login_Body wrp = new WS_login_Body();
            wrp.clientId = 'q3m8puu6ht0jkxplsyph6dfz';
            wrp.clientSecret = '0ZRTL7fNokY8GjTl9rOsPzcI';
            
            string wsMethod = 'SMS_Login';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                return;
            }
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            String body=JSON.serialize(wrp);
            
            req.setbody(body);
            
            req.setTimeout(8000);
            system.debug('!!!req: ' + req);
            
            Http http = new Http();
            HTTPResponse res;
            
            
            res = http.send(req);
            WS_login_response responseToken = new WS_login_response();
            responseToken = (WS_login_response)JSON.deserialize(res.getBody(),WS_login_response.class);
            System.debug('!!!res.getBody(): ' + res.getBody());
            System.debug('responseToken: ' + responseToken);
            System.debug('responseToken.accessToken: ' + responseToken.accessToken);
            
            R1_CLS_Utilities.putCache('local.sessionCache.tokenBorrado', responseToken.accessToken);
            
            
            
        }catch(Exception exc){
            
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.loginMKT()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        }
    }
    

    @future(callout=true)
    public static void borrarEnMKT(List<String> lstId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            integer res = enviarBorradoMKT(lstId,0);
            if(res == 200 || res ==201 || res == 202 || res == 203){
               
            }
            
  
        }catch(Exception exc){
               R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.borrarEnMKT', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');

        }
    }

    public static integer enviarBorradoMKT(List<String> lstId, integer intentos){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay Flores
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    18/04/2018              Borja Gay Flores             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            wrpBorradoMKT wrp = new wrpBorradoMKT();
            wrp.Values.addAll(lstId);

            string wsMethod = 'borrarMKT';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No existe endPoint', 'R1_Marketing_Permission__c');
  
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.tokenBorrado');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    loginMKT();
                    enviarBorradoMKT(lstId,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No puede conectarse a IBIS, 3 intentos de login fallidos', 'R1_Marketing_Permission__c');
                    
                }
            }

            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c;
            
            System.debug('urlEndp' + endPoint);
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Accept-Language', 'http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.10');
            req.setHeader('Accept','application/json');
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

            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    loginMKT();
                    enviarBorradoMKT(lstId,intentos);
                }else{
                    String reason = res.getBody().subStringBetween('reason":"','",');
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No puede conectarse a IBIS, 3 intentos de login fallidos', 'R1_Marketing_Permission__c');
                }
            }         
            return res.getStatusCode();
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return 0;
        }
    }
    public static void bajaGDPR(Set<id> setAccounts){
        try{
        List<R1_Marketing_Permission__c> lstMKT = [SELECT id,R1_MP_CHK_Flag_enabled__c,R2_MP_CHK_Update_Control__c from R1_Marketing_Permission__c where R1_MP_LOO_Client__c in :setAccounts and R1_MP_PKL_Type_of_communication__c!= 'All'];
        for(R1_Marketing_Permission__c mkt : lstMKT){
            mkt.R1_MP_CHK_Flag_enabled__c = false;
        }
        List<R1_Marketing_Permission__c> lstMPAll = [SELECT id,R1_MP_CHK_Flag_enabled__c,R2_MP_CHK_Update_Control__c from R1_Marketing_Permission__c where R1_MP_LOO_Client__c in :setAccounts and R1_MP_PKL_Type_of_communication__c = 'All'];
        for(R1_Marketing_Permission__c mkt : lstMPAll){
            mkt.R1_MP_CHK_Flag_enabled__c = true;
        }
        update lstMPAll;
        update lstMKT;
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.bajaGDPR()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
        }
    }

    public static List<String> filtrarAccountGDPR(List<Account> lstAcc){
        try{
        List<String> lstAccNOmkt = new List<String>();
        for(Account acc : lstAcc){
            if(acc.R2_CON_CHK_Marketing_Cloud__PC == false && acc.R2_ACC_CHK_Marketing_Cloud__c == false){
                lstAccNOmkt.add(acc.PersonContactId);
            }
        }

        return lstAccNOmkt;
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.filtrarAccountGDPR()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return null;

        }    
    }
}