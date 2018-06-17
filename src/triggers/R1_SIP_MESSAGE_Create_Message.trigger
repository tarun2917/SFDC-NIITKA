trigger R1_SIP_MESSAGE_Create_Message on R1_SIP_message__c (after insert, before delete) {

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);

   if(trigger.isAfter){
        if(trigger.isInsert){
        
            if(trigger.new.size()==1){
                if ( !( (objectByPass.contains('R1_SIP_Message__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    R1_CLS_SIPInt.mensajesSIP(trigger.new[0].id);
                }
            }
            else{}
            
        }
        
     
   }
   
   if(trigger.isBefore){
        if(trigger.isDelete){
            if(trigger.old.size()==1){
                System.debug('Entro en borrar');
                if ( !( (objectByPass.contains('R1_SIP_Message__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    String salaVIP=trigger.old[0].R1_SIM_PKL_VIP_lounge_name__c;
                    String texto=trigger.old[0].R1_SIM_ATXTL_Message_text_local__c;
                    String duracion=''+trigger.old[0].R1_SIM_NUM_Display_duration__c;
                    String tipo=trigger.old[0].R1_SIM_PKL_Message_type__c;
                    String textoIngles=trigger.old[0].R1_SIM_ATXTL_Message_text_english__c;
                    String textoSpanish=trigger.old[0].R1_SIM_ATXTL_Message_text_spanish__c;
                    String ident=trigger.old[0].id;
                    
                    R1_CLS_SIPInt.mensajesSIPBorrar(salaVIP,texto,duracion,tipo,textoIngles,textoSpanish,ident);
                }
            }
            else{}
       
        }
    }
}