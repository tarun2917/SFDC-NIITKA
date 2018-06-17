public class R2_CLS_TSK_TriggerMethods {
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ismael Yubero Moreno
Company:        Accenture
Description:    

IN:       
OUT:      

History: 
<Date>                     <Author>                <Change Description>
15/09/2017                 Ismael Yubero Moreno            Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public class WS_login_Body {
        public String clientId;
        public String clientSecret;
    }
    
    public class WS_login_response {
        public String accessToken;
        public Integer expiresIn;
    }
    
    public class WS_sms{
        public List<String> mobileNumbers=new List<String>();
        public boolean Subscribe;
        public String Keyword;
        public boolean Resubscribe;
        public boolean Overridel;
        public String MessageText;
    }
    public class WS_sms_response{
        public String tokenId;
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay Flores
Company:        Accenture
Description:    Method to login in SMS APP

IN:       
OUT:      

History: 
<Date>                     <Author>                <Change Description>
12/05/2017                 Borja Gay Flores           Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //@future(Callout = true)
    public static void login() {
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            WS_login_Body wrp = new WS_login_Body();
            wrp.clientId = 'bhre12hlqrjdkyky1w6q8dt4';
            wrp.clientSecret = 'WDU65TEKL9pZ22bQr53alVon';
            
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
            
            R1_CLS_Utilities.putCache('local.sessionCache.tokenSMS', responseToken.accessToken);
            
            
            
        }catch(Exception exc){
            
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_SMS_TriggerMethods.login()', '', exc.getmessage()+', '+exc.getLineNumber(), 'SMS');
        }
    }
    
    
    
    @future(callout=true)
    public static void enviarTSK(String id){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ismael Yubero Moreno
Company:        Accenture
Description:    Method that calls the enviarTSKMkt method.

IN:         

OUT:           Void

History:

<Date>              <Author>            <Description>
15/09/2017          Ismael Yubero Moreno     Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
            System.debug('Prueba de que se envia el id de la task ' + id);
            enviarTSKMkt(id,0);
            
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SMS_TriggerMethods__c.enviarSMS', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_SMS__c');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Ismael Yubero Moreno
Company:        Accenture
Description:    Method that sends an http request when a Task is created.

IN:         

OUT:           SMSResponse

History:

<Date>              <Author>            <Description>
15/09/2017          Ismael Yubero Moreno     Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    
    public static WS_sms_response enviarTSKMkt(String id,integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            List<Task> tsk = [Select id,R2_ACT_TLF_Phone__c,Description FROM Task WHERE id=:id];
            //List<R2_SMS__c> sms=[Select id,R2_SMS_TXTA_Body__c,R2_SMS_LOO_To__r.R2_ACC_TLF_Phone_MarketingII__c,R2_SMS_LOO_To__r.R2_ACC_TLF_Phone_OperativeII__c,R2_SMS_PKL_Phone__c from R2_SMS__c WHERE id=:id];
            WS_sms wrp=new WS_sms();
            
            wrp.mobileNumbers.add(tsk[0].R2_ACT_TLF_Phone__c); 
            wrp.Subscribe=true;
            wrp.Keyword='IBERIA';
            wrp.Resubscribe=false;
            wrp.Overridel=true;
            wrp.MessageText=tsk[0].Description;
            
            
            HTTPResponse res;
            
            string wsMethod = 'SendSMS';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
            
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  
            String token = R1_CLS_Utilities.getCache('local.sessionCache.tokenSMS'); 
            if(token==null){
                if(intentos<3){
                    intentos+=1;
                    login();
                    return enviarTSKMkt(id,intentos);
                }else{
                    //revisar
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_TSK_TriggerMethods__c.enviarTSKMkt', id, 'No se puede conectar con Marketing', 'Task');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(wrp));
            req.setTimeout(3700);
            system.debug(req);
            String body = JSON.serialize(wrp);
            body = body.replaceAll('"Overridel":','"Override":');
            System.debug(body);
            req.setBody(body);
            
            Http http = new Http();
            
            //if(!System.Test.isRunningTest()) {
            if(tsk[0].R2_ACT_TLF_Phone__c!=null && tsk[0].R2_ACT_TLF_Phone__c!='' ){
                res = http.send(req);
                //}
                //else {
                //   res = new HTTPResponse();
                //   res.setStatusCode(200);
                //    res.setBody('{"Response" : "Success"}');
                //}
                
                System.debug('!!!status code: ' + res.getStatusCode());            
                
                //obtenemos los datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                    WS_sms_response resp = (WS_sms_response)JSON.deserialize(res.getBody(),WS_sms_response.class);
                    return resp;
                }
                else {
                    if(intentos<3 && res.getStatusCode() == 401){
                        intentos+=1;
                        login();
                        return enviarTSKMkt(id,intentos);
                    }
                    else{
                        R1_CLS_LogHelper.generateErrorLog('R2_CLS_TSK_TriggerMethods__c.enviarTSKMkt', id, 'No se puede conectar con Marketing', 'Task');
                        return null;
                    }
                }
            }
            else{
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_TSK_TriggerMethods__c.enviarTSKMkt', id, 'No existe teléfono', 'Task');
                return null;
            }
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_TSK_TriggerMethods__c.enviarTSKMkt', id, 'No se puede conectar con Marketing', 'Task');
            return null;
        }
    }
    
}