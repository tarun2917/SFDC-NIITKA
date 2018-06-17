public class R1_CLS_SIPInt{
  /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    SIP Integration Class.
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public class wraper{
        public String messageID;
        public String vipRoomName;
        public String marketingCarrierCode;
        public String flightNumber;
        public String flightDate;
        public String destination;
        public String scheduledTime;
        public String userID;
    }

    public class mensajeVIPResponse{
        public String result='Success';
        public String controlFlag;
        public String mktCompany;
        public String flightNumber;
        public String flightDate;
        public String boardingTime;

    }    

    public class wraperMensaje{
        
        public String messageID;
        public String vipRoomName;
        public String marketingCarrierCode;
        public String flightNumber;
        public String destination;
        public wraperTipoMensaje message;
        public String userID;

    }

    public class wraperTipoMensaje{
        public String displayDuration;
        public String messageType;
        public String action;
        public String passengerName;
        public String englishMessageText;
        public String spanishMessageText;
        public String localMessageText;
    } 
    
    public class wraperVuelo{
        String messageID;
        String vipRoomName;
        String marketingCarrierCode;
        String flightNumber;
        String flightDate;
        String flightStatus;
        String flightStatusDescription;
        String destination;
        String userID;
    }
    public class mensajeResponse{
        public String response;

    }
    @future(callout=true)
    public static void mensajesSIP(String id){
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that calls the crearMensaje method.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true
            crearMensaje(id,0);
          }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.mensajesSIP', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_SIP_Message__c');
        }
    }

    public static mensajeResponse crearMensaje(String id, integer intentos){
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that sends and http request when a message is created.
    
    IN:         

    OUT:           mensajeResponse
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
       try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            System.debug('Entro en mensaje');
            List<R1_SIP_Message__c> mensaje=[SELECT id,name,R1_SIM_ATXTL_Message_text_spanish__c,R1_SIM_ATXTL_Message_text_english__c,R1_SIM_ATXTL_Message_text_local__c,R1_SIM_PKL_VIP_lounge_name__c,R1_SIM_NUM_Display_duration__c,R1_SIM_PKL_Message_type__c,R1_SIM_PKL_Status__c from R1_SIP_Message__c where id=:id];
            System.debug('mensaje: ' + mensaje);
            id id1 = userinfo.getProfileId();
            List<Profile> user=[select Name from profile where id = :id1];
            
            wraperTipoMensaje message=new wraperTipoMensaje();
            
            message.displayDuration=''+mensaje[0].R1_SIM_NUM_Display_duration__c;
            
            String status=mensaje[0].R1_SIM_PKL_Message_type__c;
            String statusreal='';
        
            if(status=='Informativo'){
            statusreal='INFORMATIVE';
            }
        
            if(status=='Urgente'){
            statusreal='URGENT';
            }
                   
            message.messageType=statusreal;
            message.action='SUBMIT';
            message.passengerName=null;
            message.englishMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_english__c;
            message.spanishMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_spanish__c;
            message.localMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_local__c;
           
            String salaV=mensaje[0].R1_SIM_PKL_VIP_lounge_name__c;
            List<Salas_VIP__c> verdadero=[Select Nombre_SIP__c from Salas_VIP__c where Sala_Vip__c=:salaV limit 1];
            
            String sipName=verdadero[0].Nombre_SIP__c;
           
            wraperMensaje wrp=new wraperMensaje();
            
            wrp.messageID=mensaje[0].id;
            wrp.vipRoomName=sipName;
            wrp.marketingCarrierCode=null;
            wrp.flightNumber=null;
            wrp.destination=null;
            wrp.message=message;
            wrp.userID=id1;
           
            /*
            wrp.messageID=mensaje[0].id;
            wrp.vipRoomName=mensaje[0].R1_SIM_PKL_VIP_lounge_name__c;
            wrp.marketingCarrierCode=null;
            wrp.flightNumber=null;
            wrp.destination=null;
            wrp.message=new wraperTipoMensaje();
            wrp.userID=id1;

    
            wrp.message.displayDuration=''+mensaje[0].R1_SIM_NUM_Display_duration__c;
            wrp.message.messageType=mensaje[0].R1_SIM_PKL_Message_type__c;
            wrp.message.action='SUBMIT';
            wrp.message.passengerName='ALO';
            wrp.message.englishMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_english__c;
            wrp.message.spanishMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_spanish__c;
            wrp.message.localMessageText=mensaje[0].R1_SIM_ATXTL_Message_text_local__c;
            */
           
            
            HTTPResponse res;
            string wsMethod = 'Create Message';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
               return null;
            }
  
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  
     
           
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token'); 
            if(token==null) {
              if(intentos<3){
                  intentos+=1;
                  R1_CLS_SendCustomerMDM.login();
                  return crearMensaje(id,intentos);
              
           }
          else{
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.crearMensaje', id,'No se puede conectar a SIP, 3 Intentos de Login Fallidos' , 'R1_SIP_Message__c');
          return null;
               }
          }
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
            system.debug(req);

            req.setBody(JSON.serializePretty(wrp,true));
            System.debug(req.getBody());
            Http http = new Http();
           
  
            //if(!System.Test.isRunningTest()) {
                res = http.send(req);
            //}
            //else {
            //   res = new HTTPResponse();
            //   res.setStatusCode(200);
            //   res.setBody('{"Response" : "Success"}');
            //}        

            System.debug('!!!body: ' + res.getBody());

             //obtenemos los datos
                     if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               mensajeResponse resp = (mensajeResponse)JSON.deserialize(res.getBody(),mensajeResponse.class);
               return resp;
          }
          else {
          if(intentos<3 && res.getStatusCode() == 401){
              intentos+=1;
              R1_CLS_SendCustomerMDM.login();
              return crearMensaje(id,intentos);
              
          }
          else{
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.crearMensaje', id,'No se puede conectar a SIP, Cuerpo de mensaje: '+ res.getBody(), 'R1_SIP_Message__c');
          return null;
               }
          }
              }
        catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.crearMensaje', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_SIP_Message__c');
          return null;
        }
    }
    
    @future(callout=true)
    public static void mensajesSIPBorrar(String salaVIP, String texto, String duracion, String tipo,String textoEnglish, String textoSpanish,String ident){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            borrarMensaje(salaVIP,texto,duracion,tipo,textoEnglish,textoSpanish,ident,0);
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.mensajesSIPBorrar', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_SIP_Message__c');
        }
    }
 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that send an hhtp request when a message is deleted.
    
    IN:         

    OUT:           mensajeResponse
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    
    public static mensajeResponse borrarMensaje(String salaVIP, String texto, String duracion, String tipo,String textoEnglish, String textoSpanish,String ident,integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            id id1 = userinfo.getProfileId();
            List<Profile> user=[select Name from profile where id = :id1];
            wraperMensaje wrp=new wraperMensaje();
            
            String status=tipo;
            String statusreal='';
        
            if(status=='Informativo'){
            statusreal='INFORMATIVE';
            }
        
            if(status=='Urgente'){
            statusreal='URGENT';
            }
            String salaV=salaVIP;
            List<Salas_VIP__c> verdadero=[Select Nombre_SIP__c from Salas_VIP__c where Sala_Vip__c=:salaV limit 1];
            
            String sipName=verdadero[0].Nombre_SIP__c;
            wrp.messageID=ident;
            wrp.vipRoomName=sipName;
            wrp.marketingCarrierCode=null;
            wrp.flightNumber=null;
            wrp.destination=null;
            wrp.message=new wraperTipoMensaje();
            wrp.userID=id1;

    
            wrp.message.displayDuration=''+duracion;
            wrp.message.messageType=statusreal;
            wrp.message.action='REMOVE';
            wrp.message.passengerName=null;
            wrp.message.englishMessageText=textoEnglish;
            wrp.message.spanishMessageText=textoSpanish;
            wrp.message.localMessageText=texto;
    
            
            HTTPResponse res;
        
            string wsMethod = 'Delete Message';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
  
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  

        
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token'); 
            if(token==null){
                if(intentos<3){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return borrarMensaje(salaVIP,texto,duracion,tipo,textoEnglish,textoSpanish,ident,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.borrarMensaje', '','No se puede conectar a SIP, 3 Intentos de Login Fallidos', 'R1_SIP_Message__c');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
            system.debug(req);

            req.setBody(JSON.serialize(wrp,true));
            Http http = new Http();
        

            //if(!System.Test.isRunningTest()) {
                res = http.send(req);
            //}else{
            //    res = new HTTPResponse();
            //    res.setStatusCode(200);
            //    res.setBody('{"Response" : "Success"}');
            //}

            System.debug('!!!body: ' + res.getBody());

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                mensajeResponse resp = (mensajeResponse)JSON.deserialize(res.getBody(),mensajeResponse.class);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return borrarMensaje(salaVIP,texto,duracion,tipo,textoEnglish,textoSpanish,ident,intentos);
             
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.borrarMensaje', '','No se puede conectar a SIP, Cuerpo de mensaje: '+ res.getBody(), 'R1_SIP_Message__c');
                    return null;
                }
            }
          
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.borrarMensaje', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_SIP_Message__c');
            return null;
        }  
    }

    @future(callout=true)
    public static void enviarVueloVip(String id){
 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that calls the mensajeVueloVip method.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
                if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                mensajeVIPResponse response=mensajeVueloVip(id,0);
                if(response != null){
                    List<R1_SIP_Status__c> acceso=[Select R1_SIS_LOO_Flight__c,R1_SIS_PKL_Vip_lounge__c,R1_SIS_LOO_Flight__r.R1_FLG_TXT_External_ID__c,R1_SIS_CHK_Control_flag__c from R1_SIP_Status__c WHERE id=:id];
                    List<R1_Flight__c> vuelo = [SELECT Id, R1_FLG_CHK_Controlled_by_SIP__c, R1_FLG_DAT_Flight_date_local__c, R1_FLG_TXT_Carrier_code_oper__c, R1_FLG_TXT_Flight_no_oper__c
                                                FROM R1_Flight__c where id=:acceso[0].R1_SIS_LOO_Flight__c limit 1]; 
                    boolean control;
                    if(response.controlFlag!=null && response.controlFlag.equals('YES')){
                        control=true;
                    }else{
                        control=false;
                    }    
                    System.debug(control);
                    if(control!=vuelo[0].R1_FLG_CHK_Controlled_by_SIP__c && response.controlFlag!=null){
                        
                        vuelo[0].R1_FLG_CHK_Controlled_by_SIP__c=control;
                        update vuelo[0];
                        
                    }
                }
            }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.enviarVueloVip', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }


    public static mensajeVIPResponse mensajeVueloVip(String id,integer intentos){
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that sends an http request when an access is created in the VIP Lounge.
    
    IN:         

    OUT:           mensajeVIPResponse
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            List<R1_SIP_Status__c> acceso=[Select R1_SIS_LOO_Flight__c,R1_SIS_PKL_Vip_lounge__c,R1_SIS_LOO_Flight__r.R1_FLG_TXT_External_ID__c,R1_SIS_LOO_Flight__r.R1_FLG_DATH_Schedule_depart_time__c,R1_SIS_LOO_Flight__r.R1_FLG_TXT_Airport_arrive__c,R1_SIS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c,R1_SIS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c,R1_SIS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c,R1_SIS_CHK_Control_flag__c from R1_SIP_Status__c WHERE id=:id];
            id id1 = userinfo.getProfileId();
            Date fecha=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_DAT_Flight_date_local__c;
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
            
            integer hora=0;
            String hour='00';
            integer min=0;
            String minu='00';
            integer sec=0;
            String seco='00';
            
            if(acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_DATH_Schedule_depart_time__c!=null){
            DateTime schedule=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_DATH_Schedule_depart_time__c;
            
            hora=schedule.hour();
            hour=string.valueOf(hora);
            min=schedule.minute();
            minu=string.valueOf(min);
            sec=schedule.second();
            seco=string.valueOf(sec);
            if(hora<10){
                hour='0'+hour;
            }
            if(min<10){
                minu='0'+min;
            }
            if(sec<10){
                seco='0'+sec;
            }
            
            }
            
            String salaV=acceso[0].R1_SIS_PKL_Vip_lounge__c;
            List<Salas_VIP__c> verdadero=[Select Nombre_SIP__c from Salas_VIP__c where Sala_Vip__c=:salaV limit 1];
            
            String sipName=verdadero[0].Nombre_SIP__c;
            
            List<Profile> user=[select Name from profile where id = :id1];
            wraper wrp=new wraper();
            wrp.messageID=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_TXT_External_ID__c;
            wrp.vipRoomName=sipName;
            wrp.marketingCarrierCode=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;
            wrp.flightNumber=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;
            wrp.flightDate=month+'/'+day+'/'+fecha.year();
            wrp.destination=acceso[0].R1_SIS_LOO_Flight__r.R1_FLG_TXT_Airport_arrive__c;
            wrp.scheduledTime=hour+':'+minu+':'+seco;
            wrp.userID= userinfo.getProfileId();
            HTTPResponse res;


            string wsMethod = 'Submit Flight';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
  
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token==null)  {
                System.debug(intentos);
                if(intentos<3){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return mensajeVueloVip(id,intentos);
              
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.mensajeVueloVip', id,'No se puede conectar a SIP, 3 Intentos de Login Fallidos', 'R1_VIP_Lounge_Access__c');
                    return null;
                }
            } 
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
            system.debug(req);

            req.setBody(JSON.serialize(wrp,true));
            System.debug('Request:' + req.getBody());
            Http http = new Http();
           
  
            //if(!System.Test.isRunningTest()) {
                res = http.send(req);
                 System.debug('!!!body: ' + res.getBody());
            //}
            //else {
            //    res = new HTTPResponse();
            //    res.setStatusCode(200);
            //    res.setBody('{"Result" : "Success","controlFlag" : "true","mktCompany" : "IB","flightNumber" : "12345","flightDate" : "2017-01-12","boardingTime" : "2017-01-12 12:00:00"}');
            //}

           

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                mensajeVIPResponse resp = (mensajeVIPResponse)JSON.deserialize(res.getBody(),mensajeVIPResponse.class);
                return resp;
             }
              else {
              if(intentos<3 && res.getStatusCode() == 401){
              intentos+=1;
              R1_CLS_SendCustomerMDM.login();
              return mensajeVueloVip(id,intentos);
              
          }
          else{
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.mensajeVueloVip', id,'No se puede conectar a SIP, Cuerpo de mensaje: '+ res.getBody(), 'R1_VIP_Lounge_Access__c');
          return null;
           }
      }
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.mensajeVueloVip', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        return null;
        }
    }

    @future(callout=true)
    public static void actualizarVuelo(String id, String sala){
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that calls the actualizarMensajeVuelo method.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
           try{
               if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
               actualizarMensajeVuelo(id,sala,0);
               
           
   }
        catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.actualizarVuelo', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Flight__c');
        }
    }


    public static mensajeResponse actualizarMensajeVuelo(String id,String sala, integer intentos){
      /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that sends an http request when a Flight is updated.
    
    IN:         

    OUT:           mensajeResponse
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
        try{
        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
        List<R1_Flight__c> acceso=[Select id,R1_FLG_TXT_Carrier_code__c,R1_FLG_TXT_Flight_number__c,R1_FLG_TXT_External_ID__c,
        R1_FLG_DAT_Flight_date_local__c,R1_FLG_TXT_Airport_arrive__c,
        R1_FLG_ATXTL_Message_text__c,R1_FLG_PKL_Message_type__c from R1_Flight__c WHERE id=:id];
        System.debug('ID'+id);
        
        id id1 = userinfo.getProfileId();
        wraperVuelo wrp=new wraperVuelo();
        
        Date fecha=acceso[0].R1_FLG_DAT_Flight_date_local__c;
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
        
        String status=acceso[0].R1_FLG_PKL_Message_type__c;
        String statusreal='';
        
        if(status=='Embarcando'){
            statusreal='BOARDING';
        }
        
        if(status=='Retrasado'){
            statusreal='DELAY';
        }
        if(status=='Cancelado'){
        statusreal='CANCELLATION';
        }
        if(status=='Reapertura'){
            statusreal='REOPENING';
        }
        
         String salaV=sala;
         System.debug(sala);
            List<Salas_VIP__c> verdadero=[Select Nombre_SIP__c from Salas_VIP__c where Sala_Vip__c=:salaV limit 1];
            
            String sipName=verdadero[0].Nombre_SIP__c;
        
        wrp.messageID=acceso[0].R1_FLG_TXT_External_ID__c;
        wrp.vipRoomName=sipName;
        wrp.marketingCarrierCode=acceso[0].R1_FLG_TXT_Carrier_code__c;
        wrp.flightNumber=acceso[0].R1_FLG_TXT_Flight_number__c;
        wrp.flightDate=month+'/'+day+'/'+fecha.year();
        wrp.flightStatus=statusreal;
        wrp.flightStatusDescription=acceso[0].R1_FLG_ATXTL_Message_text__c;
        wrp.destination=acceso[0].R1_FLG_TXT_Airport_arrive__c;
        wrp.userID=id1;
        
        
         HTTPResponse res;

        string wsMethod = 'Update Flight Status';
        if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
           return null;
        }
  
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(endPoint);
        //system.debug(endPoint + parametersEndPoint);
        req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  
        String token = R1_CLS_Utilities.getCache('local.sessionCache.token'); 
        if(token==null){
          if(intentos<3){
              intentos+=1;
              R1_CLS_SendCustomerMDM.login();
              return actualizarMensajeVuelo(id,sala,intentos);
          }
          else{
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.actualizarMensajeVuelo', id, 'No se puede conectar a SIP, 3 Intentos de Login Fallidos', 'R1_Flight__c');
            return null;
           }
        }
        req.setHeader('Authorization', 'Bearer ' + token); 
        req.setMethod('PUT');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        //req.setBody(JSON.serialize(envio));
        req.setTimeout(15000);
        system.debug(req);

        req.setBody(JSON.serialize(wrp,true));
        
       
        
        Http http = new Http();
       
  
        //if(!System.Test.isRunningTest()) {
            res = http.send(req);
        //}
        //else {
        //   res = new HTTPResponse();
        //   res.setStatusCode(200);
        //    res.setBody('{"Response" : "Success"}');
        //}

      System.debug('!!!body: ' + res.getBody());

      //obtenemos los datos
      if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
           mensajeResponse resp = (mensajeResponse)JSON.deserialize(res.getBody(),mensajeResponse.class);
           return resp;
      }
      else {
          if(intentos<3 && res.getStatusCode() == 401){
              intentos+=1;
              R1_CLS_SendCustomerMDM.login();
              return actualizarMensajeVuelo(id,sala,intentos);
          }
          else{
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.actualizarMensajeVuelo', id, 'No se puede conectar a SIP, Cuerpo de mensaje: '+ res.getBody(), 'R1_Flight__c');
            return null;
           }
      }
      
         }
        catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.actualizarMensajeVuelo', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Flight__c');
          return null;
        }
    }

    public static void crearEstadoSIP(R1_VIP_Lounge_Access__c acceso){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            if((acceso.R1_VLI_PKL_Access_status__c=='Forzado' || acceso.R1_VLI_PKL_Access_status__c=='Aprobado')  && acceso.R1_VLI_LOO_Flight__c!=null){
                List<R1_SIP_Status__c> estado=[SELECT id, name from R1_SIP_Status__c where R1_SIS_LOO_Flight__c=:acceso.R1_VLI_LOO_Flight__c and R1_SIS_PKL_Vip_lounge__c=:acceso.R1_VLI_PKL_Sala_Vip__c];
                if(estado.size()==0){
                    R1_SIP_Status__c nuevoEstado=new R1_SIP_Status__c();
                    nuevoEstado.R1_SIS_LOO_Flight__c=acceso.R1_VLI_LOO_Flight__c;
                    nuevoEstado.R1_SIS_PKL_Vip_lounge__c=acceso.R1_VLI_PKL_Sala_Vip__c;
                    insert nuevoEstado;
            
                }
            }
        }
        catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_SIPInt__c.crearEstadoSIP', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Flight__c');
        }
    }
}