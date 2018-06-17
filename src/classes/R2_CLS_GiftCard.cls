/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Integración para tarjetas de regalo de Amazon. Esta integracion consta de 2: Create y Cancel, pero de momento solo el Create.

    History:
     <Date>                     <Author>                         <Change Description>
    16/08/2017              Sara Torres Bermúdez                    Initial Version
    22/03/2018              Alberto Puerto Collado          Fixed CancelarGiftCard &  Global -> para tener métodos webService
    ----------------------------------------------------------------------------------------------------------------------*/
global with sharing class R2_CLS_GiftCard {

    //COMMON
    public class WPValueType{
        public String amount;
        public String currencyCode;
    }
    public class WPCardInfoType{
        //public List<String> lstCardNumber;
        public String cardStatus;
        public WPValueType value;
        //public List<String> lstExpirationDate;
    }
    public class WPGiftCardDetailsType{
        public String crmCreationRequestId;
        public String giftCodeId;
        public String giftClaimCode;
        public String giftCodeExpirationDate;
        public WPCardInfoType cardInfo;
    }
    public class WPGiftCardCodeType{
        public String crmCreationRequestId;
        public String giftCodeId;
    }

    /// CREATE ///

    // Response

    public class WPCreateGiftCardWeb_Response{
        public String status;
        public WPGiftCardDetailsType giftCard;
        public List<WPError> errors;
        public String timeout;
    }

    // Request

    public class WPCreateGiftCardWeb_Request{
        public String crmCreationRequestId;
        public String amount;
        public String currencyCode;

    }
    public class WPError{
        public String code;
        public String reason;
        public String timeStamp;
    }
    //////////// cancel ///

    //Response

    public class WR_GiftCard_Resp{
        public String status;
        public List<WR_GiftCard> lstGC;
        public List<WPError> errors;
    }

    //Request

    public class WR_GiftCard{
        public String crmCreationRequestId;
        public String giftCodeId;
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    16/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static WPCreateGiftCardWeb_Response CrearTarjetaResponseSinWO(String autoNumberAmazon, String amount, Integer contador) {

         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            string wsMethod = 'R2_Gift_Card';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
			system.debug('Entro en CrearTarjetaResponseSinWO: ' + autoNumberAmazon + ' ' + amount);
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            system.debug('req: ' + req);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
             system.debug(req.getEndpoint());
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return CrearTarjetaResponseSinWO(autoNumberAmazon, amount, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponse', '','', '');
                    return null;
                }
            }

             //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
             req.setHeader('Authorization', 'Bearer ' + token);
             req.setMethod('POST');
             req.setHeader('Accept', 'application/json');
             req.setHeader('Content-Type', 'application/json');
             req.setTimeout(13700);

             system.debug(req);

             WPCreateGiftCardWeb_Request giftCard = new WPCreateGiftCardWeb_Request();

             system.debug('request: ' + autoNumberAmazon);
             giftCard.crmCreationRequestId = autoNumberAmazon;
             //giftCard.crmCreationRequestId = 'FirstTes01';
             system.debug('request amount: ' + amount);
             giftCard.amount = amount;
             system.debug(giftCard.amount);
             //giftCard.amount = '10.0';
             system.debug('tercer campo');
             giftCard.currencyCode = 'EUR';
             // giftCard.currencyCode = 'EUR';

             //String body ='{"crmCreationRequestId":"FirstTes01","amount": "10.0","currencyCode": "EUR"}';
             String body = JSON.serialize(giftCard);
             req.setBody(body);

             Http http = new Http();

             HTTPResponse res;

             res = http.send(req);

             System.debug('!!!body: ' + res.getBody());

            System.debug('Status: '+ res.getStatusCode());
            //obtenemos los datos
            WPCreateGiftCardWeb_Response resp = new WPCreateGiftCardWeb_Response();
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WPCreateGiftCardWeb_Response resp = new WPCreateGiftCardWeb_Response();
                resp = (WPCreateGiftCardWeb_Response)JSON.deserialize(res.getBody(),WPCreateGiftCardWeb_Response.class);
                System.debug('Aqui ha ido bien: '+ resp);
                return resp;
            }else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return CrearTarjetaResponseSinWO(autoNumberAmazon, amount, contador);
            }else {
                system.debug(res.getBody());
                resp = (WPCreateGiftCardWeb_Response)JSON.deserialize(res.getBody(),WPCreateGiftCardWeb_Response.class);
                system.debug(resp);
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponseSinWO', 'getStatusCode de la respuesta no es 200 ni 401. Se ha intentado 3 veces el login','', '');
                return resp;
            }
        }catch(Exception exc){
            HttpRequest req = new HttpRequest();
            WPCreateGiftCardWeb_Response resp = new WPCreateGiftCardWeb_Response();
			resp.timeout = exc.getmessage();
            system.debug('timeout '+ resp.timeout);
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponseSinWO', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    16/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

    @future(callout=true)
    public static void CrearTarjeta(String WO_id){
        try{
            System.debug('Entro');
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('Id de la WOrk Order'+WO_id);
            WPCreateGiftCardWeb_Response resp = CrearTarjetaResponse(WO_id, 0);
            if (resp != null){
                R2_Work_Order__c workO = new R2_Work_Order__c();
                if (resp.status == 'SUCCESS'){
                    //workO.R2_WO_NUMA_Amazon_Request_Id__c = resp.giftCard.crmCreationRequestId;
                    workO.R2_WO_TXT_Amazon_Request_Id__c = resp.giftCard.crmCreationRequestId;
                    workO.R2_WO_TXT_AmazonId__c = resp.giftCard.giftCodeId;
                    system.debug('cod amazon ' + workO.R2_WO_TXT_AmazonId__c);
                      List<String> ExpirationDate = resp.giftCard.giftCodeExpirationDate.split(' ');
                    if (ExpirationDate[1] == 'Jan'){
                        ExpirationDate[1] = '01';
                    }else if(ExpirationDate[1] == 'Feb'){
                        ExpirationDate[1] = '02';
                    }else if(ExpirationDate[1] == 'Mar'){
                        ExpirationDate[1] = '03';
                    }else if(ExpirationDate[1] == 'Apr'){
                        ExpirationDate[1] = '04';
                    }else if(ExpirationDate[1] == 'May'){
                        ExpirationDate[1] ='05';
                    }else if(ExpirationDate[1] == 'Jun'){
                        ExpirationDate[1] = '06';
                    }else if(ExpirationDate[1] == 'Jul'){
                        ExpirationDate[1] = '07';
                    }else if(ExpirationDate[1] == 'Aug'){
                        ExpirationDate[1] = '08';
                    }else if(ExpirationDate[1] == 'Sep'){
                        ExpirationDate[1] = '09';
                    }else if(ExpirationDate[1] == 'Oct'){
                        ExpirationDate[1] = '10';
                    }else if(ExpirationDate[1] == 'Nov'){
                        ExpirationDate[1] = '11';
                    }else{
                        ExpirationDate[1] = '12';
                    }
                    String fechaValida = ExpirationDate[5] + '-' + ExpirationDate[1] + '-' + ExpirationDate[2] + ' ' + ExpirationDate[3];
                    workO.R2_WO_DATH_GiftCard_Expiracion__c = DateTime.valueOf(fechaValida);
                    workO.R2_WO_PKL_status__c = resp.giftCard.cardInfo.cardStatus;
                    workO.R2_WO_NUM_Amount_tot__c = Decimal.valueof(resp.giftCard.cardInfo.value.amount);
                    // workO. = resp.giftCard.cardInfo.value.currencyCode;
                    workO.id = WO_id;
                    update workO;
                }else{
                    system.debug('status de la respuesta: ' + resp.status);
                }

            }else{
                system.debug('he entrado por null ' + resp);
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjeta', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that calls the cancelGiftCard method.

    IN:

    OUT:           CancelGiftCard

    History:

    <Date>              <Author>            <Description>
    17/08/2017    Ruben Pingarron Jerez     Initial version
    10/10/2017  Sara Torres                 Modify version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

  /*   @future(Callout = true)
    public static void CallCancelGiftCard(String id){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            cancelGiftCard(id, 0);

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CancelGiftCard.CallCancelGiftCard', id, exc.getmessage()+', '+exc.getLineNumber(), 'GiftCard');
        }

    }*/

     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    16/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static WPCreateGiftCardWeb_Response CrearTarjetaResponse(String WO_id, Integer contador) {

         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            string wsMethod = 'R2_Gift_Card';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
             system.debug(req.getEndpoint());
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return CrearTarjetaResponse(WO_id, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponse', '','', '');
                    return null;
                }
            }

             //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
             req.setHeader('Authorization', 'Bearer ' + token);
             req.setMethod('POST');
             req.setHeader('Accept', 'application/json');
             req.setHeader('Content-Type', 'application/json');
             req.setTimeout(13700);
             system.debug(req);

             List<R2_Work_Order__c> lstCamposWO = [Select id, R2_WO_TXT_Amazon_Request_Id__c, R2_WO_NUM_Amount_tot__c FROM R2_Work_Order__c WHERE id =: WO_id];

             WPCreateGiftCardWeb_Request giftCard = new WPCreateGiftCardWeb_Request();
             system.debug('crmCreationRequestId ' + lstCamposWO);

             if (!lstCamposWO.isEmpty()){
                 giftCard.crmCreationRequestId = String.valueof(lstCamposWO[0].R2_WO_TXT_Amazon_Request_Id__c);
                 //giftCard.crmCreationRequestId = 'FirstTes01';
                 giftCard.amount = String.valueof(lstCamposWO[0].R2_WO_NUM_Amount_tot__c);
                 system.debug(giftCard.amount);
                 //giftCard.amount = '10.0';
                 giftCard.currencyCode = 'EUR';
                 // giftCard.currencyCode = 'EUR';
            }


             //String body ='{"crmCreationRequestId":"FirstTes01","amount": "10.0","currencyCode": "EUR"}';
             String body = JSON.serialize(giftCard);
             system.debug('!!!body request: ' + body);
             req.setBody(body);

             Http http = new Http();

             HTTPResponse res;

             res = http.send(req);

             System.debug('!!!body: ' + res.getBody());


            System.debug('Status: '+ res.getStatusCode());
            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                WPCreateGiftCardWeb_Response resp = new WPCreateGiftCardWeb_Response();
                resp = (WPCreateGiftCardWeb_Response)JSON.deserialize(res.getBody(),WPCreateGiftCardWeb_Response.class);
                System.debug('Aqui ha ido bien: '+ resp);
                return resp;
            }else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return CrearTarjetaResponse(WO_id, contador);
            }else {
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponse', '','', '');
                return null;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_GiftCard.CrearTarjetaResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that sends an http request when a GiftCard is cancelled.

    IN:

    OUT:           CancelGiftCardResponse

    History:

    <Date>              <Author>            <Description>
    17/08/2017      Ruben Pingarron Jerez       Initial version
    22/03&2018      Alberto Puerto Collado      Fixes and activate integration
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    webservice static String cancelGiftCard(String id, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            R2_Work_Order__c workOrder= [SELECT Id,R2_WO_NUMA_Amazon_Request_Id__c,R2_WO_TXT_Amazon_Request_Id__c,R2_WO_TXT_AmazonId__c FROM  R2_Work_Order__c
                                WHERE Id =:id];
            System.debug(':::R2_Work_Order__c: ' + workOrder);

            if(workOrder != null){
                string wsMethod = 'R2_Gift_Card';
                if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                    return null;
                }

                HttpRequest req = new HttpRequest();

                //req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/' + workOrder.R2_WO_TXT_AmazonId__c + '/cancel');
                //II pide un valor dummy, sin más -.-
                req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/' +  '123' + '/cancel');

                String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
                System.debug('!!!token: ' + token);
                if (token == null) {
                    if(intentos < 3){
                        R1_CLS_SendCustomerMDM.login();
                        intentos += 1;
                        return cancelGiftCard(id,intentos);
                    }
                    else{
                        R1_CLS_LogHelper.generateErrorLog('R2_CLS_CancelGiftCard.cancelGiftCard', id ,'No se pudo cancelar la tarjeta regalo', 'GiftCard');
                        return null;
                    }
                }

                req.setHeader('Authorization', 'Bearer ' + token);
                req.setMethod('POST');
                req.setHeader('Accept', 'application/json');
                req.setHeader('Content-Type', 'application/json');
                req.setTimeout(10000);
                system.debug(req);

                WR_GiftCard giftCard = new WR_GiftCard();
                giftCard.crmCreationRequestId = '789450';//(String)workOrder.R2_WO_NUMA_Amazon_Request_Id__c.substring(0, 14);R2_WO_TXT_Amazon_Request_Id__c
                if(workOrder.R2_WO_TXT_Amazon_Request_Id__c != null){
                     giftCard.crmCreationRequestId = workOrder.R2_WO_TXT_Amazon_Request_Id__c;
                }else{
                    System.debug('::Error! R2_WO_TXT_Amazon_Request_Id__c está vacío y no debería, probando campo hardcodeado válido temporal (no se sabe la fecha de expiración de la clave)');
                     giftCard.crmCreationRequestId = '789450';
                }
                giftCard.giftCodeId = workOrder.R2_WO_TXT_AmazonId__c;

                //String body = '{"crmCreationRequestId": "FirstTes01", "giftCodeId": "A3JZNQC7PUJD54"}';
                String body = JSON.serialize(giftCard);
                System.debug(':::body: ' +body);
                req.setBody(body);

                Http http = new Http();
                HTTPResponse res;

                res = http.send(req);
                System.debug(':::STATUS: ' +res.getStatusCode());
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                    WR_GiftCard_Resp resp = (WR_GiftCard_Resp)JSON.deserialize(res.getBody(),WR_GiftCard_Resp.class);
                    System.debug(':::resp: ' +resp);
                    //return resp;
                    if(resp.status == 'SUCCESS'){
                        return 'OK';
                    }else{
                        //return null;
                        if(resp.errors != null){
                            String errores = '';
                            for(WPError error : resp.errors){
                                errores += '+ (' + error.timeStamp + ') - '+ error.code + ' - ' + error.reason + '<br/>';
                            }
                            //return JSON.serialize(resp.errors);
                            return errores;
                        }else{
                            return 'Amazon no ha aceptado la cancelación del bono, consulte con un administrador';
                        }
                    }
                }else {
                    WR_GiftCard_Resp resp = (WR_GiftCard_Resp)JSON.deserialize(res.getBody(),WR_GiftCard_Resp.class);
                    System.debug(':::resp: ' +resp);
                    if(intentos<3 && res.getStatusCode() == 401){
                        intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return cancelGiftCard(id,intentos);
                    }
                    else{
                        R1_CLS_LogHelper.generateErrorLog('R1_CLS_SMS_TriggerMethods__c.cancelGiftCard', id, 'No se pudo cancelar la tarjeta regalo', 'GiftCard');
                        //return null;
                         if(resp.errors != null){
                            String errores = '';
                            for(WPError error : resp.errors){
                                errores += '+ (' + error.timeStamp + ') - '+ error.code + ' - ' + error.reason + '<br/>';
                            }
                            //return JSON.serialize(resp.errors);
                            return errores;
                        }else{
                            return 'Amazon no ha aceptado la cancelación del bono, consulte con un administrador';
                        }
                    }
                }
            }else{
                return null;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CancelGiftCard.cancelGiftCard', id, exc.getmessage()+', '+exc.getLineNumber(), 'GiftCard');
            return null;
        }
    }
}