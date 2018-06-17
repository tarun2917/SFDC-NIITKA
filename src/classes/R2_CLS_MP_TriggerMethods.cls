public with sharing class R2_CLS_MP_TriggerMethods {
    
    public class WpReq{
        public String origin = 'SALESFORCE';
        public String email;
        public String channel = 'COMMUNICATION_CENTRE';
        public String preferredLanguage;
        public String communicationLanguage;
        public String frequentFlyerNumber;
        public List<marketingPermissions> marketingPermissions;
        public String uuid = 'testBorja';
    }
    public class marketingPermissions{
        public String permissionType;
        public Boolean permissionGranted;
        public String modificationDateTime;
    }

    public class WS_login_response {
        public String access_token;
        public Integer expires_in;
        public Integer refresh_expires_in;
        public String refresh_token;
        public String token_type;
        public String id_token;
    }

    //public static void login() {
        
 //       try{
 //           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
                     
 //           string wsMethod = 'IBIS_Login';
            
 //           if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
 //               return;
 //           }
            
 //           HttpRequest req = new HttpRequest();
 //           req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
 //           req.setMethod('POST');
 //           req.setHeader('Authorization', 'Basic aW9zX2FwcDpjZTYyMTA0ZC00MTgwLTQ5OTktOGRhYS0zOTljYTcyOGViMDc=');
 //           req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

 //           String body = 'grant_type=client_credentials';

 //           req.setbody(body);
            
 //           req.setTimeout(8000);
 //           system.debug('!!!req: ' + req);
            
 //           Http http = new Http();
 //           HTTPResponse res;
            
            
 //          res = http.send(req);
 //          WS_login_response responseToken = new WS_login_response();
 //          responseToken = (WS_login_response)JSON.deserialize(res.getBody(),WS_login_response.class);
 //          system.debug('!!!res.getBody(): ' + res.getBody());
 //          System.debug('responseToken: ' + responseToken);
 //          System.debug('responseToken.access_token: ' + responseToken.access_token);

 //          R1_CLS_Utilities.putCache('local.sessionCache.tokenIBIS', responseToken.access_token);
            
            
            
 //       }catch(Exception exc){
            
 //           R1_CLS_LogHelper.generateErrorLog('R2_CLS_SMS_TriggerMethods.login()', '', exc.getmessage()+', '+exc.getLineNumber(), 'SMS');
 //       }
 //   }

    @future(callout=true)
    public static void enviarMPAIBCOM(List<id> lstId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R1_Marketing_permission__c> lstmpEnvio = [SELECT Id,R1_MP_LOO_Client__r.R2_ACC_CHK_GDPR_UnSub__c,R1_MP_LOO_Client__c, R1_MP_LOO_Client__r.PersonEmail,R1_MP_LOO_Client__r.R1_ACC_PKL_Preference_language_desc__c,R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c,R1_MP_LOO_Client__r.R1_ACC_PKL_Comunication_Language__c,R1_MP_PKL_Type_of_communication__c,R1_MP_CHK_Flag_enabled__c,LastModifiedDate from R1_Marketing_permission__c WHERE Id in :lstId and R1_MP_PKL_Type_of_communication__c!= 'All'];
            if(!lstmpEnvio.isEmpty()){
                enviarIBCOM(lstmpEnvio, 0);
               
            }
            
        }catch(Exception exc){
               R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarMPAIBCOM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');

        }
    }
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
      
    public static void enviarIBCOM(List<R1_Marketing_permission__c> lstMp, Integer intentos){
    try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            List<R2_CS_MP_Equivalence__c> lstE = R2_CS_MP_Equivalence__c.getAll().values();
             List<R2_CS_Country_ISO__c> lstCountry = R2_CS_Country_ISO__c.getAll().values();
            List<marketingPermissions> lstMkt = new List<marketingPermissions>();
            Map<String,String> mapEq = new Map <String,String>();
            Map<String,String> mapCountry = new Map<String,String>();
            for(R2_CS_MP_Equivalence__c eq : lstE){
                mapEq.put(eq.R2_CSMP_SFValue__c,eq.R2_CSMP_IBCOMValue__c);
            }
            for(R2_CS_Country_ISO__c CO : lstCountry){
                mapCountry.put(co.R2_CSISO_APIValue__c,co.R2_CSISO_ISO__c);
            }
            WpReq wrp = new WpReq();
            for(R1_Marketing_Permission__c mp : lstMP){
                marketingPermissions wrpMP = new marketingPermissions();
                String permiso = formatearPermiso(mp.R1_MP_PKL_Type_of_communication__c, mapEq);
                if(permiso == ' MAGAZINE' && (mp.R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c==null || mp.R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c=='')){
                    permiso = 'NEWSLETTER';
                }
                wrpMP.permissionType = permiso;
                wrpMP.permissionGranted = mp.R1_MP_CHK_Flag_enabled__c;
                String fecha = formatearFecha(mp.LastModifiedDate);
                wrpMP.modificationDateTime = fecha;
                lstmkt.add(wrpMP);
            }

            wrp.marketingPermissions=lstMkt;
            wrp.email = lstMP[0].R1_MP_LOO_Client__r.PersonEmail;
            wrp.preferredLanguage = mapCountry.get(lstMP[0].R1_MP_LOO_Client__r.R1_ACC_PKL_Preference_language_desc__c);
            wrp.preferredLanguage = mapCountry.get(lstMP[0].R1_MP_LOO_Client__r.R1_ACC_PKL_Preference_language_desc__c);
            integer ff;
            if(lstMP[0].R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c == null){
                ff = null;
            }
            else{
                ff = Integer.valueOf(lstMP[0].R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c);
            }
            if(ff != null){
                wrp.frequentFlyerNumber = String.valueOf(ff);
            }
            else{
                wrp.frequentFlyerNumber = null;
            }
            string wsMethod = 'marketingPermissionsIBCOM';
            
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No existe endPoint', 'R1_Marketing_Permission__c');
  
            }
            
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    enviarIBCOM(lstMP,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No puede conectarse a IBIS, 3 intentos de login fallidos', 'R1_Marketing_Permission__c');
                    
                }
            }
            else{
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
                if(lstMP[0].R1_MP_LOO_Client__r.R2_ACC_CHK_GDPR_UnSub__c){
                    R1_CLS_SendCustomerMDM.deleteCustomer(lstMP[0].R1_MP_LOO_Client__c, 0);
                }
            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    enviarIBCOM(lstMP,intentos);
                }else{
                    String reason = res.getBody().subStringBetween('reason":"','",');
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', 'No puede conectarse a IBIS, 3 intentos de login fallidos', 'R1_Marketing_Permission__c');
                }
            }         
            }
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.enviarIBCOM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');

        }
    }

    public static String formatearPermiso(String permiso, Map<String,String> eq){
        String formatoIBCOM = '';
        formatoIBCOM = eq.get(permiso);
        
        return formatoIBCOM;
    }

    public static String formatearFecha(Datetime fecha){
        try{
        integer dia=fecha.day();
        String day=string.valueOf(dia);
        integer mes=fecha.month();
        String month=string.valueOf(mes);
        if(dia<10){
            day='0'+dia;
        }
        if(mes<10){
            month='0'+mes;
        }

        String formatFecha = fecha.date().year()+'-'+month+'-'+day+' '+fecha.hour()+':'+fecha.minute()+':'+(fecha.second()-10)+'.'+fecha.millisecond();

        return formatFecha;
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.formatearFecha()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return null;
        }
    }

    public static R1_Marketing_Permission__c getAllMP(String idAcc,String idLoyalty){
        try{
        List<R1_Marketing_Permission__c> lstMKT = new List<R1_Marketing_Permission__c>();
        lstMKT = [SELECT id,R1_MP_CHK_Flag_enabled__c,R2_MP_CHK_Update_Control__c from R1_Marketing_Permission__c where R1_MP_LOO_Client__c = :idAcc and R1_MP_PKL_Type_of_communication__c= 'All'];
        if(!lstMkt.isEmpty()){
            return lstMKT[0];
        }
        else{return null;}
        /*else{
            R1_Marketing_Permission__c mp = new R1_Marketing_Permission__c();
            mp.R1_MP_CHK_Flag_enabled__c = false;
            mp.R1_MP_PKL_Type_of_communication__c = 'All';
            mp.R1_MP_PKL_Comunication_chanel__c = 'All';
            mp.R1_MP_LOO_Client__c = idAcc;
            mp.R1_MP_LOO_Loyalty_card__c = idLoyalty;
            insert mp;

            return mp;
        }*/
           }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.getAllMP()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return null;

        }
    }

    public static boolean comprobarBajaGDPR(String idAcc){
       try{
            boolean bajaGDPR = false;
            List<Account> lstAcc = new List<Account>();
            lstAcc = [SELECT id, R2_ACC_CHK_GDPR_UnSub__c from Account where id = :idAcc];
            if(!lstAcc.isEmpty()){
                System.debug('Baja GDPR');
                bajaGDPR = lstAcc[0].R2_ACC_CHK_GDPR_UnSub__c;
            }

            return bajaGDPR;
           }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.comprobarBajaGDPR()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return false;

        }
    }

    public static List<String> filtrarPermisosMKT(List<R1_Marketing_Permission__c> lstMKT){
       try{
            System.debug('Filtrando Permisos');
            List<String> lstMP = new List<String>();
            for(R1_Marketing_Permission__c mp : lstMKT){
                if(mp.R2_MP_CHK_Update_Control__c){
                    lstMP.add(mp.id);
                }
            }
            return lstMP;
           }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.filtrarPermisosMKT()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return null;

        }
    }

    public static List<String> filtrarPermisosMKTFalse(List<R1_Marketing_Permission__c> lstMKT){
       try{
            System.debug('Filtrando Permisos');
            List<String> lstMP = new List<String>();
            for(R1_Marketing_Permission__c mp : lstMKT){
                if(!mp.R2_MP_CHK_Update_Control__c){
                    lstMP.add(mp.id);
                }
            }
            return lstMP;
           }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_MP_TriggerMethods.filtrarPermisosMKT()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Marketing_Permission__c');
            return null;

        }
    }
    
    public static List<R1_Marketing_Permission__c> encontrarMPUpdateTrue(List<R1_Marketing_Permission__c> lstMKT){
        List<R1_Marketing_Permission__c> lstMP = new List<R1_Marketing_Permission__c>();
        for(R1_Marketing_Permission__c mp : lstMKT){
            if(mp.R2_MP_CHK_Update_Control__c && mp.R1_MP_PKL_Type_of_communication__c!='All'){
                lstMp.add(mp);
            }
        }
        return lstMP;
    }
    public static List<R1_Marketing_Permission__c> encontrarMPUpdateFalse(List<R1_Marketing_Permission__c> lstMKT){
        List<R1_Marketing_Permission__c> lstMP = new List<R1_Marketing_Permission__c>();
        for(R1_Marketing_Permission__c mp : lstMKT){
            if(!mp.R2_MP_CHK_Update_Control__c && mp.R1_MP_PKL_Type_of_communication__c!='All'){
                lstMp.add(mp);
            }
        }
        return lstMP;
    }
    public static void actualizarMPTrue(List<R1_Marketing_Permission__c> lstMKT,Map<id,R1_Marketing_Permission__c> mpMKT){
        for(R1_Marketing_Permission__c mp : lstMKT){
                mp.R1_MP_CHK_Flag_enabled__c = mpMKT.get(mp.id).R1_MP_CHK_Flag_enabled__c;
                System.debug('MPInter: '+mp);
                mp.R2_MP_CHK_Update_Control__c = false;
        }
    }
    public static void actualizarAll(List<R1_Marketing_Permission__c> lstMKT){
        System.debug('Actualizar All');
        Map<String,R1_Marketing_Permission__c> mapMP = new Map<String,R1_Marketing_Permission__c>();
        for(R1_Marketing_Permission__c mp : lstMKT){
            if(mp.R1_MP_CHK_Flag_enabled__c == true){
                mapMP.put(mp.R1_MP_LOO_Client__c,mp);
            }
        }
        Set<String> setAcc = mapMP.keySet();
        System.debug(setAcc);
        List<R1_Marketing_Permission__c> lstMPAll = new List<R1_Marketing_Permission__c>();
        lstMPAll = [SELECT Id,R1_MP_LOO_Client__c, R1_MP_LOO_Client__r.R1_ACC_EMA_Marketing_Email__c,R1_MP_LOO_Client__r.R1_ACC_PKL_Preference_language_desc__c,R1_MP_LOO_Client__r.R1_ACC_TXT_Primary_FF_Card_CCPO__c,R1_MP_LOO_Client__r.R1_ACC_PKL_Comunication_Language__c,R1_MP_PKL_Type_of_communication__c,R1_MP_CHK_Flag_enabled__c,LastModifiedDate from R1_Marketing_permission__c WHERE R1_MP_LOO_Client__c in :setAcc and R1_MP_PKL_Type_of_communication__c= 'All' and R1_MP_CHK_Flag_enabled__c = true];
        if(!lstMPAll.isEmpty()){
            for(R1_Marketing_Permission__c mp : lstMPAll){
                mp.R1_MP_CHK_Flag_enabled__c = false;
            }
            update lstMPAll;
        }
    }
}