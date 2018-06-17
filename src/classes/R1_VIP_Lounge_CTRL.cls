public with sharing class R1_VIP_Lounge_CTRL {

  /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Vip Lounge VF Controller.
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    
    public Id selectedObject{get;set;}
    public List<SelectOption> objectOptions {get;set;}
    public String idInteraccion{get;set;}
    public String idInvitado{get;set;}
    public String acceso{get;set;}
    public boolean invitado{get;set;}
    //Añadido DCO
    public boolean recuperar{get;set;}
    //
    public Boolean popUP{get;set;}
    public boolean recupInvitado{get;set;}
    public String idInvEncontrado{get;set;}
    //
    public String observaciones{get;set;}
    public String vip{get;set;}
    public String puesto{get;set;}
    public List<R1_Alert__c> alertas{get;set;}
    public List<R1_VIP_Lounge_Service__c> vipServices{get;set;}
    public List<R1_VIP_Lounge_Access__C> VipInt {get{
     List<Salas_Vip__c> sala = [SELECT name,Sala_Vip__c,Puesto_de_Trabajo__c FROM Salas_Vip__c WHERE name=:salaSel ORDER BY name limit 1];
     String vip='';
     String puesto='';
     if(sala.size()==0){
         sala.add(new Salas_Vip__c());
     }
     else{
         vip=sala[0].Sala_VIP__c;
         puesto=sala[0].Puesto_de_Trabajo__c;
     } 
     List<R1_VIP_Lounge_Access__c> lista=[SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_passenger_name__c, R1_VLI_LOO_Cliente__r.SALUTATION,R1_VLI_PKL_Access_status__c, R1_VLI_TXT_Comp_Flight__c, R1_VLI_TXT_Class__c,R1_VLI_PKL_OneWolrd_code__c, R1_VLI_LOO_Flight__c   FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c= :vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate DESC LIMIT 30];
     return lista;
    }
    set;}
    
    public String salaSel {get;set;}
    public List<R1_VIP_Lounge_Access__c> idC {get;set;}
    public List<R1_Vip_lounge_invitees__c> invitadosIDC{get;set;}
    public void SetSala(String valor){
        salaSel=valor;
    }
   
 
    public R1_VIP_Lounge_CTRL(ApexPages.StandardController stdController) {
        try{
            String usuario=userInfo.getUserId();
            objectOptions = new List<SelectOption>();
            objectOptions.add(new SelectOption('1','Selecciona Puesto de trabajo'));
            salaSel='';
            idInvEncontrado = '';
            popUP = false;
            recupInvitado=false;
            invitado=false;
            recuperar=false;
            List<Salas_Vip__c> objects = [SELECT name,Sala_VIP__c,Puesto_de_Trabajo__c FROM Salas_Vip__c ORDER BY name];
            for(Salas_Vip__c sala:objects){
                objectOptions.add(new SelectOption(sala.Name, sala.Name));
            }
        
            List <Schema.FieldSetMember> lst_fsAccount = Schema.SObjectType.R1_VIP_Lounge_Access__c.fieldSets.ClienteActualVIP.getFields(); 
            List<String> lst_campos = new List<String>();
            String query = 'SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_Inbound_Class__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_TXT_passenger_name__c,R1_VLI_RUS_Count_Invitees__c,R1_VLI_LOO_Cliente__r.ID, R1_VLI_LOO_Cliente__r.SALUTATION,R1_VLI_LOO_Flight__r.R1_FLG_CHK_boarded__c,R1_VLI_LOO_Flight__r.R1_FLG_PKL_Flight_status__c,R1_VLI_TXT_PNR__c ,R1_VLI_TXT_Comp_Flight__c,R1_VLI_PKL_Access_status__c,R1_VLI_TXT_Gate__c,R1_VLI_NUM_departure_tieme_cki__c, R1_VLI_CHK_Call__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_TXT_Special_Services__c,R1_VLI_NUM_Time_state__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_Destination__c, R1_VLI_DAT_Date__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_Seat_number__c,R1_VLI_TXT_Class__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Inbound__c,R1_VLI_TXT_Inb_origin__c,R1_VLI_TXT_Inb_destination__c,R1_VLI_TXT_ETKD__c,R1_VLI_NUM_Guest_number__c,R1_VLI_PKL_Boarded__c,R1_VLI_TXT_Meal__c,R1_VLI_ATXT_Observations__c, ';
            for (Integer i = 0 ; i <= lst_fsAccount.size()-1; i++) {
            
                if (i != lst_fsAccount.size() -1) {
                   query += lst_fsAccount[i].getFieldPath() + ', ';
                }

                else {
                    query += lst_fsAccount[i].getFieldPath();
                }

                lst_campos.add(lst_fsAccount[i].getFieldPath());
            }
            List<Salas_Vip__c> sala = [SELECT name,Sala_Vip__c,Puesto_de_Trabajo__c FROM Salas_Vip__c WHERE name=:salaSel ORDER BY name limit 1];
            vip='';
            puesto='';
                List<Salas_VIP__c> traza = [SELECT name,Sala_VIP__c,Puesto_de_Trabajo__c FROM Salas_VIP__c WHERE UserId__c=:usuario];
            if(traza.isEmpty()){}
            else{
                vip=traza[0].Sala_VIP__c;
                puesto=traza[0].Puesto_de_Trabajo__c;
            }
            if(sala.size()==0){
                sala.add(new Salas_Vip__c());
            }
            else{
                vip=sala[0].Sala_VIP__c;
                puesto=sala[0].Puesto_de_Trabajo__c;
            } 
            query+=' FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c= :vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate desc limit 1';
            idC=Database.query(query);
            if(idC.size()==0){
                idC.add(new R1_VIP_Lounge_Access__c());
            } 
            idInteraccion=idC[0].id;
            observaciones= idC[0].R1_VLI_ATXT_Observations__c;
            invitadosIDC=[SELECT id,name,R1_IV_LOO_Client__c,R1_IV_LOO_Client__r.name,R1_IV_TXT_passenger_name__c,R1_IV_TXT_Flight_number__c,R1_IV_LOO_Client__r.SALUTATION,R1_IV_LOO_Client__r.R1_ACC_PKL_Card_Type__c,R1_IV_TXT_Comp_Flight__c,R1_IV_TXT_Class__c,R1_IV_CHK_Ninos__c FROM R1_Vip_lounge_invitees__c WHERE R1_IV_MDRS_Vip_lounge_access__c=:idC[0].id];        
            if(invitadosIDC.size()==0){
                invitadosIDC.add(new R1_Vip_lounge_invitees__c());
        
            }    
        }
        catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    
    }
  
   
   public void esInvitado(){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that indicates the next access will be a guest.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
       try{
           invitado=true;
           
       }
       catch(Exception exc){
            System.debug('*** invitado:' + exc.getmessage());
          R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.esInvitado()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
       }
   }

    public void puesto(){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         David Barco
    Company:        Accenture
    Description:    Method that select the workspace when update the visualforce when the current user is in one workspace.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    17/07/2017          David Barco         Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
       try{
           
           List<Salas_VIP__c> salasVIP = [SELECT Id, UserId__c, Sala_Vip__c, Puesto_de_Trabajo__c FROM Salas_VIP__c WHERE UserId__c =:UserInfo.getUserId() ORDER BY LastModifiedDate DESC LIMIT 1];
           System.debug('===== lista salasVIP ---> ' + salasVIP);
           if(!salasVIP.isEmpty()){
              salaSel = salasVIP[0].Sala_Vip__c + ' ' + salasVIP[0].Puesto_de_Trabajo__c;
              System.debug('===== salaSel ---> ' + salaSel);
           }
       }
       catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.esInvitado()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
       }
   }
   
 
 public void actualizarObservaciones(){
   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that updates the field R1_VLI_ATXT_Observations__c of the selected client.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
     try{ 
         
         idC[0].R1_VLI_ATXT_Observations__c=observaciones;
         update idC[0];
     }
     catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.actualizarObservaciones()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
     }
 }
 
 public void actualizarInvitado(){
      /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that updates the field R1_IV_CHK_Ninos__c of the selected guest.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
    try{
   
        List<R1_Vip_lounge_invitees__c> lista=[SELECT id,name,R1_IV_LOO_Client__c,R1_IV_CHK_Ninos__c FROM R1_Vip_lounge_invitees__c WHERE ID=:idInvitado limit 1]; 
        if(lista.size()!=0){
            lista[0].R1_IV_CHK_Ninos__c=!lista[0].R1_IV_CHK_Ninos__c;
            update lista;   
        }
        idInteraccion=idC[0].id;
        observaciones= idC[0].R1_VLI_ATXT_Observations__c;
        cargarDatos();
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.actualizarInvitados()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
   } 
   
   
   public void refreshidC(){
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that refreshes the visualforce page adding the new access or the new invitee.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
        try{
            
             List<Salas_Vip__c> sala = [SELECT name,Sala_Vip__c,Puesto_de_Trabajo__c FROM Salas_Vip__c WHERE name=:salaSel ORDER BY name limit 1];
             //DCO
             
             //
             vip='';
             puesto='';
             if(sala.size()==0){
                 sala.add(new Salas_Vip__c());
             }
             else{
                 vip=sala[0].Sala_VIP__c;
                 puesto=sala[0].Puesto_de_Trabajo__c;
             } 
             System.debug('*** No dupl --> ' );
             
            if(recuperar){
                List <Schema.FieldSetMember> lst_fsAccount = Schema.SObjectType.R1_VIP_Lounge_Access__c.fieldSets.ClienteActualVIP.getFields(); 
                List<String> lst_campos = new List<String>();
                String query = 'SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_Inbound_Class__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_TXT_passenger_name__c,R1_VLI_RUS_Count_Invitees__c,R1_VLI_LOO_Cliente__r.ID, R1_VLI_LOO_Cliente__r.SALUTATION,R1_VLI_LOO_Flight__r.R1_FLG_CHK_boarded__c,R1_VLI_LOO_Flight__r.R1_FLG_PKL_Flight_status__c,R1_VLI_TXT_PNR__c ,R1_VLI_TXT_Comp_Flight__c,R1_VLI_PKL_Access_status__c,R1_VLI_TXT_Gate__c,R1_VLI_NUM_departure_tieme_cki__c, R1_VLI_CHK_Call__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_TXT_Special_Services__c,R1_VLI_NUM_Time_state__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_Destination__c, R1_VLI_DAT_Date__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_Seat_number__c,R1_VLI_TXT_Class__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Inbound__c,R1_VLI_TXT_Inb_origin__c,R1_VLI_TXT_Inb_destination__c,R1_VLI_TXT_ETKD__c,R1_VLI_NUM_Guest_number__c,R1_VLI_PKL_Boarded__c,R1_VLI_TXT_Meal__c,R1_VLI_ATXT_Observations__c, ';
                for (Integer i = 0 ; i <= lst_fsAccount.size()-1; i++) {
                
                    if (i != lst_fsAccount.size() -1) {
                       query += lst_fsAccount[i].getFieldPath() + ', ';
                    }
    
                    else {
                        query += lst_fsAccount[i].getFieldPath();
                    }
    
                    lst_campos.add(lst_fsAccount[i].getFieldPath());
                }
               
                
                query+=' FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c= :vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate desc limit 1';
                idC=Database.query(query);
            
                List<R1_VIP_Lounge_access__c> duplicado=[Select id,name,R1_VLI_PKL_Vip_lounge_position__c,R1_VLI_PKL_Sala_Vip__c from R1_VIP_Lounge_access__c where R1_VLI_TXT_Bn__c=:idC[0].R1_VLI_TXT_Bn__c AND R1_VLI_TXT_Comp_Mkt_flight__c=:idC[0].R1_VLI_TXT_Comp_Mkt_flight__c AND R1_VLI_TXT_Origin__c=:idC[0].R1_VLI_TXT_Origin__c AND R1_VLI_TXT_Flight_number__c=:idC[0].R1_VLI_TXT_Flight_number__c AND R1_VLI_DAT_Date__c=:idC[0].R1_VLI_DAT_Date__c AND R1_VLI_PKL_Sala_Vip__c= :vip/*AND R1_VLI_PKL_Vip_lounge_position__c=:puesto*/ ORDER BY CREATEDDATE DESC];
                if(duplicado.size()>1){
                System.debug('IDC '+idC[0].id);
                delete idC[0];
                recuperar=false;
                System.debug('Duplicado final '+duplicado[1].id);
                idInteraccion=duplicado[1].id;
                cargarDatos();
                }
                else{
                recuperar=false;
                idInteraccion=idC[0].id;
                cargarDatos();
                }
                
                //
            }else if(invitado){
                List<R1_VIP_Lounge_Access__c> invitados=[Select ID, R1_VLI_TXT_Unique_Identifier__c, Name,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_LOO_Cliente__r.R1_ACC_PKL_Card_Type__c,R1_VLI_TXT_Seat_number__c,R1_VLI_LOO_Cliente__r.SALUTATION, R1_VLI_TXT_Frecuent_Flyer_number__c,R1_VLI_PKL_Sala_Vip__c,R1_VLI_TXT_Meal__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_TXT_Special_Services__c,R1_VLI_TXT_Special_PAX__c,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_NUM_departure_tieme_cki__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_TXT_Inbound__c,R1_VIP_CHK_Minor__c,R1_VLI_TXT_Ancillaries__c,R1_VLI_TXT_ETKD__c,R1_VLI_TXT_passenger_status__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_ID_AD_indicator__c,R1_VLI_TXT_vip_lounge_permition__c,R1_VLI_TXT_Class__c,R1_VLI_DAT_Date__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_Comp_Flight__c,R1_VLI_TXT_Destination__c,R1_VLI_PKL_OneWolrd_code__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_PNR__c,R1_VLI_TXT_passenger_name__c FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c=:vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate DESC LIMIT 1 ];    
                R1_Vip_lounge_invitees__c registroInv=new R1_Vip_lounge_invitees__c();
                registroInv.R1_IV_LOO_Client__c=invitados[0].R1_VLI_LOO_Cliente__c;
                registroInv.R1_IV_TXT_Comp_Flight__c=invitados[0].R1_VLI_TXT_Comp_Flight__c;
                registroInv.R1_IV_TXT_Class__c=invitados[0].R1_VLI_TXT_Class__c;
                registroInv.R1_IV_TXT_Frecuent_Flyer_number__c=invitados[0].R1_VLI_TXT_Frecuent_Flyer_number__c;
                registroInv.R1_IV_TXT_Special_Services__c =invitados[0].R1_VLI_TXT_Special_Services__c;
                registroInv.R1_IV_TXT_Special_PAX__c =invitados[0].R1_VLI_TXT_Special_PAX__c;
                registroInv.R1_IV_TXT_boarding_gate_cki__c =invitados[0].R1_VLI_TXT_boarding_gate_cki__c;
                registroInv.R1_IV_NUM_departure_tieme_cki__c =invitados[0].R1_VLI_NUM_departure_tieme_cki__c;
                registroInv.R1_IV_TXT_Inbound_flight__c =invitados[0].R1_VLI_TXT_Inbound_flight__c;
                registroInv.R1_IV_TXT_Inbound__c =invitados[0].R1_VLI_TXT_Inbound__c;
                registroInv.R1_IV_CHK_Minor__c =invitados[0].R1_VIP_CHK_Minor__c;
                registroInv.R1_IV_TXT_Ancillaries__c =invitados[0].R1_VLI_TXT_Ancillaries__c;
                registroInv.R1_IV_TXT_ETKD__c =invitados[0].R1_VLI_TXT_ETKD__c;
                registroInv.R1_IV_TXT_passenger_status__c =invitados[0].R1_VLI_TXT_passenger_status__c;
                registroInv.R1_IV_TXT_Comp_Mkt_flight__c =invitados[0].R1_VLI_TXT_Comp_Mkt_flight__c;
                registroInv.R1_IV_TXT_Bn__c =invitados[0].R1_VLI_TXT_Bn__c;
                registroInv.R1_IV_TXT_Seat__c=invitados[0].R1_VLI_TXT_Seat_number__c;
                registroInv.R1_IV_TXT_ID_AD_indicator__c =invitados[0].R1_VLI_TXT_ID_AD_indicator__c;
                registroInv.R1_IV_DAT_Date__c =invitados[0].R1_VLI_DAT_Date__c;
                registroInv.R1_IV_TXT_Flight_number__c =invitados[0].R1_VLI_TXT_Flight_number__c;
                registroInv.R1_IV_TXT_Comp_Flight__c =invitados[0].R1_VLI_TXT_Comp_Flight__c;
                registroInv.R1_IV_TXT_Destination__c =invitados[0].R1_VLI_TXT_Destination__c;
                registroInv.R1_IV_TXT_OneWolrd_code__c =invitados[0].R1_VLI_PKL_OneWolrd_code__c;
                registroInv.R1_IV_TXT_Origin__c =invitados[0].R1_VLI_TXT_Origin__c;
                registroInv.R1_IV_TXT_PNR__c =invitados[0].R1_VLI_TXT_PNR__c;
                registroInv.R1_IV_TXT_passenger_name__c =invitados[0].R1_VLI_TXT_passenger_name__c;
                registroInv.R1_IV_TXT_Unique_Identifier__c = invitados[0].R1_VLI_TXT_Unique_Identifier__c;
                registroInv.R1_IV_MDRS_Vip_lounge_access__c=idC[0].ID;
     
               insert registroInv;
               delete invitados[0];
      
               idInteraccion=idC[0].id;                
               invitado = false;
               cargarDatos();
            }else if(recupInvitado){
                System.debug('pasa por recupInv');
                List<R1_VIP_Lounge_Access__c> lastAccess = [Select ID, R1_VLI_TXT_Unique_Identifier__c FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c=:vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate DESC LIMIT 1 ];    
                List<R1_Vip_lounge_invitees__c> invEncontrado = [SELECT Id, R1_IV_TXT_Unique_Identifier__c FROM R1_Vip_lounge_invitees__c WHERE CreatedDate = today AND R1_IV_TXT_Unique_Identifier__c = :lastAccess[0].R1_VLI_TXT_Unique_Identifier__c AND (R1_IV_TXT_Unique_Identifier__c != null AND R1_IV_TXT_Unique_Identifier__c != '')];
                if(!invEncontrado.isEmpty()){
                    idInvEncontrado = invEncontrado[0].Id;
                }else{
                    idInvEncontrado = 'NotFound';
                }
                System.debug('idInvEncontrado ' + idInvEncontrado);
                
                recupInvitado = false;
                delete lastAccess;
                cargarDatos();
            }else{
               List <Schema.FieldSetMember> lst_fsAccount = Schema.SObjectType.R1_VIP_Lounge_Access__c.fieldSets.ClienteActualVIP.getFields(); 
               List<String> lst_campos = new List<String>();
    			
               String query = 'SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_Inbound_Class__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_TXT_passenger_name__c,R1_VLI_LOO_Cliente__r.ID,R1_VLI_RUS_Count_Invitees__c,R1_VLI_LOO_Flight__r.R1_FLG_CHK_boarded__c,R1_VLI_LOO_Flight__r.R1_FLG_PKL_Flight_status__c, R1_VLI_LOO_Cliente__r.SALUTATION, R1_VLI_TXT_Comp_Flight__c,R1_VLI_PKL_Access_status__c,R1_VLI_TXT_Gate__c,R1_VLI_NUM_departure_tieme_cki__c, R1_VLI_CHK_Call__c,R1_VLI_TXT_Special_Services__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_NUM_Time_state__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_Destination__c, R1_VLI_DAT_Date__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_Seat_number__c,R1_VLI_TXT_Class__c,R1_VLI_TXT_PNR__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Inbound__c,R1_VLI_TXT_Inb_origin__c,R1_VLI_TXT_Inb_destination__c,R1_VLI_TXT_ETKD__c,R1_VLI_NUM_Guest_number__c,R1_VLI_PKL_Boarded__c,R1_VLI_TXT_Meal__c,R1_VLI_ATXT_Observations__c, ';
               for (Integer i = 0 ; i <= lst_fsAccount.size()-1; i++) {            
                   if (i != lst_fsAccount.size() -1) {
                       query += lst_fsAccount[i].getFieldPath() + ', ';
                   }
                   else {
                       query += lst_fsAccount[i].getFieldPath();
                   }
                   lst_campos.add(lst_fsAccount[i].getFieldPath());
               }
               query+=' FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c= :vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate desc limit 1';
               idC=Database.query(query);}
               if(idC.size()==0){
                   idC.add(new R1_VIP_Lounge_Access__c());
               }
               invitadosIDC=[SELECT id,name,R1_IV_LOO_Client__c,R1_IV_LOO_Client__r.name,R1_IV_TXT_passenger_name__c,R1_IV_TXT_Flight_number__c,R1_IV_LOO_Client__r.SALUTATION,R1_IV_LOO_Client__r.R1_ACC_PKL_Card_Type__c,R1_IV_TXT_Comp_Flight__c,R1_IV_TXT_Class__c,R1_IV_CHK_Ninos__c FROM R1_Vip_lounge_invitees__c WHERE R1_IV_MDRS_Vip_lounge_access__c=:idC[0].id]; 
               vipServices=[SELECT name,R1_VLS_PKL_Service_status__c from R1_VIP_Lounge_Service__c WHERE R1_VLS_LOO_VIP_Lounge_access__c=:idC[0].id];
               if(vipServices.size()==0){
                   vipServices.add(new R1_VIP_Lounge_Service__c());
               }
    
               if(invitadosIDC.size()==0){
            invitadosIDC.add(new R1_Vip_lounge_invitees__c());
            
            } 
            idInteraccion=idC[0].id;
            observaciones= idC[0].R1_VLI_ATXT_Observations__c;
 
        }catch(Exception exc){
            System.debug('*** refreshidC:' + exc.getmessage());
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.refreshidC()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        } 
    }
       
    
   
   public void cargarDatos(){
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that loads selected user data in the visualforce page.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
        try{
            
            List <Schema.FieldSetMember> lst_fsAccount = Schema.SObjectType.R1_VIP_Lounge_Access__c.fieldSets.ClienteActualVIP.getFields(); 
            List<String> lst_campos = new List<String>();

            String query = 'SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_Inbound_Class__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_LOO_Cliente__r.ID,R1_VLI_TXT_passenger_name__c,R1_VLI_RUS_Count_Invitees__c,R1_VLI_LOO_Flight__r.R1_FLG_CHK_boarded__c,R1_VLI_LOO_Cliente__r.SALUTATION,R1_VLI_LOO_Flight__r.R1_FLG_PKL_Flight_status__c, R1_VLI_TXT_Comp_Flight__c,R1_VLI_PKL_Access_status__c,R1_VLI_TXT_Gate__c,R1_VLI_NUM_departure_tieme_cki__c, R1_VLI_CHK_Call__c,R1_VLI_TXT_Special_Services__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_NUM_Time_state__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_Destination__c, R1_VLI_DAT_Date__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_Seat_number__c,R1_VLI_TXT_Class__c,R1_VLI_TXT_PNR__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Inbound__c,R1_VLI_TXT_Inb_origin__c,R1_VLI_TXT_Inb_destination__c,R1_VLI_TXT_ETKD__c,R1_VLI_NUM_Guest_number__c,R1_VLI_PKL_Boarded__c,R1_VLI_TXT_Meal__c,R1_VLI_ATXT_Observations__c, ';
            for (Integer i = 0 ; i <= lst_fsAccount.size()-1; i++) {
                if (i != lst_fsAccount.size() -1) {
                   query += lst_fsAccount[i].getFieldPath() + ', ';
                }

                else {
                   query += lst_fsAccount[i].getFieldPath();
                }
                
                lst_campos.add(lst_fsAccount[i].getFieldPath());
            }
            query+=' FROM R1_VIP_Lounge_Access__c WHERE ID= :idInteraccion ORDER BY createdDate desc limit 1';
            idC=Database.query(query);
            if(idC.size()==0){
                idC.add(new R1_VIP_Lounge_Access__c());
            }
            invitadosIDC=[SELECT id,name,R1_IV_LOO_Client__c,R1_IV_LOO_Client__r.SALUTATION,R1_IV_TXT_passenger_name__c,R1_IV_TXT_Flight_number__c,R1_IV_LOO_Client__r.name,R1_IV_LOO_Client__r.R1_ACC_PKL_Card_Type__c,R1_IV_TXT_Comp_Flight__c,R1_IV_TXT_Class__c,R1_IV_CHK_Ninos__c FROM R1_Vip_lounge_invitees__c WHERE R1_IV_MDRS_Vip_lounge_access__c=:idC[0].id]; 
        
            if(invitadosIDC.size()==0){
                invitadosIDC.add(new R1_Vip_lounge_invitees__c());
        
            } 
            vipServices=[SELECT name,R1_VLS_PKL_Service_status__c from R1_VIP_Lounge_Service__c WHERE R1_VLS_LOO_VIP_Lounge_access__c=:idC[0].id];
            if(vipServices.size()==0){
                vipServices.add(new R1_VIP_Lounge_Service__c());
            }
            observaciones= idC[0].R1_VLI_ATXT_Observations__c;
 
            invitado=false; 
        	
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.cargarDatos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
    
    public pageReference cambiaSala(){
       /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Method that changes the selected workspace.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay           Initial version
    24/07/2017          David Barco         Fill the field UserId__c of the Custom Setting Salas_Vip__c with the current user
    16/08/2017          Borja Gay           Added a Patch in order to avoid duplicated users in vip lounge
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
  
        try{
            
             //List<Salas_Vip__c> sala = [SELECT name,Sala_Vip__c,Puesto_de_Trabajo__c FROM Salas_Vip__c WHERE name=:salaSel ORDER BY name limit 1];
             List<Salas_Vip__c> sala = [SELECT name,Sala_Vip__c,Puesto_de_Trabajo__c, UserId__c FROM Salas_Vip__c WHERE name=:salaSel ORDER BY name limit 1];
             if(sala.size()==0){
                 sala.add(new Salas_Vip__c());
             }
             else{
                
                sala[0].UserId__c = UserInfo.getUserId();
                System.debug('===== sala[0].UserId__c --> ' + sala[0].UserId__c);
                update sala[0];
                //
                vip=sala[0].Sala_VIP__c;
                puesto=sala[0].Puesto_de_Trabajo__c;
             } 
        
             List <Schema.FieldSetMember> lst_fsAccount = Schema.SObjectType.R1_VIP_Lounge_Access__c.fieldSets.ClienteActualVIP.getFields(); 
             List<String> lst_campos = new List<String>();

             String query = 'SELECT ID,NAME,R1_VLI_LOO_Cliente__r.NAME,R1_VLI_TXT_boarding_gate_cki__c,R1_VLI_TXT_Inbound_Class__c,R1_VLI_TXT_Inbound_flight__c,R1_VLI_TXT_Flight_number__c,R1_VLI_TXT_passenger_name__c,R1_VLI_LOO_Cliente__r.ID,R1_VLI_RUS_Count_Invitees__c,R1_VLI_LOO_Cliente__r.SALUTATION,R1_VLI_LOO_Flight__r.R1_FLG_CHK_boarded__c,R1_VLI_LOO_Flight__r.R1_FLG_PKL_Flight_status__c,R1_VLI_TXT_Comp_Flight__c,R1_VLI_PKL_Access_status__c,R1_VLI_TXT_Gate__c,R1_VLI_NUM_departure_tieme_cki__c, R1_VLI_CHK_Call__c,R1_VLI_TXT_Special_Services__c,R1_VLI_TXT_Mkt_Flight__c,R1_VLI_NUM_Time_state__c,R1_VLI_TXT_Origin__c,R1_VLI_TXT_Destination__c, R1_VLI_DAT_Date__c,R1_VLI_TXT_Bn__c,R1_VLI_TXT_Seat_number__c,R1_VLI_TXT_Class__c,R1_VLI_TXT_PNR__c,R1_VLI_TXT_Comp_Mkt_flight__c,R1_VLI_TXT_Inbound__c,R1_VLI_TXT_Inb_origin__c,R1_VLI_TXT_Inb_destination__c,R1_VLI_TXT_ETKD__c,R1_VLI_NUM_Guest_number__c,R1_VLI_PKL_Boarded__c,R1_VLI_TXT_Meal__c,R1_VLI_ATXT_Observations__c, ';
             for (Integer i = 0 ; i <= lst_fsAccount.size()-1; i++) {
            
                 if (i != lst_fsAccount.size() -1) {
                     query += lst_fsAccount[i].getFieldPath() + ', ';
                 }

                 else {
                     query += lst_fsAccount[i].getFieldPath();
                 }

                 lst_campos.add(lst_fsAccount[i].getFieldPath());
             }
             query+=' FROM R1_VIP_Lounge_Access__c WHERE R1_VLI_PKL_Sala_Vip__c= :vip AND R1_VLI_PKL_Vip_lounge_position__c=:puesto ORDER BY createdDate desc limit 1';
             idC=Database.query(query);
             if(idC.size()==0){
                 idC.add(new R1_VIP_Lounge_Access__c());
             }
             idInteraccion=idC[0].id;
             invitadosIDC=[SELECT id,name,R1_IV_LOO_Client__c,R1_IV_LOO_Client__r.SALUTATION,R1_IV_TXT_passenger_name__c,R1_IV_TXT_Flight_number__c,R1_IV_LOO_Client__r.name,R1_IV_LOO_Client__r.R1_ACC_PKL_Card_Type__c,R1_IV_TXT_Comp_Flight__c,R1_IV_TXT_Class__c,R1_IV_CHK_Ninos__c FROM R1_Vip_lounge_invitees__c WHERE R1_IV_MDRS_Vip_lounge_access__c=:idC[0].id]; 
        
             if(invitadosIDC.size()==0){
                 invitadosIDC.add(new R1_Vip_lounge_invitees__c());
             }  
             System.debug('Cambio');
             invitado=false;
             cargarDatos();
             List<Salas_VIP__c> salasOcupadas = [SELECT UserId__c from Salas_VIP__c where UserId__c=:UserInfo.getUserId() and name!=:salaSel];
                if(!salasOcupadas.isEmpty()){
                    for(Salas_VIP__c vip : salasOcupadas){
                        vip.UserId__c='';
                    }
                    update salasOcupadas;
                    
                }
             return null;
         }
         catch(Exception exc){
             R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.cambiaSala()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
             return null;
         }
    }
   
    public PageReference forzarEntrada (){
        try{
            
            R1_VIP_Lounge_Access__c actualizar=[SELECT ID, R1_VLI_PKL_Access_status__c FROM R1_VIP_Lounge_Access__c WHERE ID =:idC[0].ID];
            idC[0].R1_VLI_PKL_Access_status__c='Forzado';
            actualizar.R1_VLI_PKL_Access_status__c='Forzado';
            actualizar.OwnerId = UserInfo.getUserId();
            update actualizar;
        
            return null;
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.forzarEntrada()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
            return null;
        }
    }

    public void recuperarAcceso(){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Daniel Cadalso
    Company:        Accenture
    Description:    Method that recover the access.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    07/09/2017          Daniel Cadalso      Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
        try{
            recuperar = true;
            
        }catch(Exception exc){
            System.debug('*** Debug: '+exc.getMessage());
          R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL__c.recuperarAcceso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that check if a guess exists.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
 07/09/2017        Ruben Pingarron Jerez    Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
    public void recuperarInvitado(){
         try{
            
             recupInvitado = true;
             
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL.recuperarInvitado()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that check if a guess exists.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
 07/09/2017        Ruben Pingarron Jerez    Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
    
    public void limpiaID(){
        try{
            
            System.debug('idInvEncontrado1 ' + idInvEncontrado);
            
            idInvEncontrado = '';
            
            recupInvitado = false;
            System.debug('idInvEncontrado2 ' + idInvEncontrado);
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL.limpiaID()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that check if a guess exists.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
 07/09/2017        Ruben Pingarron Jerez    Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    

    public void saltaPopUp(){
        try{
            
            popUP = true;
            recupInvitado = false;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL.limpiaID()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method that check if a guess exists.
    
    IN:         

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
 07/09/2017        Ruben Pingarron Jerez    Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    

    public void escondePopUp(){
        try{
            
            popUP = false;
           
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_CTRL.limpiaID()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
        }
    }
 }