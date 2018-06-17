trigger R1_VIP_Lounge_Access_ValidationTrigger on R1_VIP_Lounge_Access__c (before insert, after insert, after update) {

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);

    if(trigger.isBefore){
        if(trigger.isInsert){
            if(trigger.new.size()==1){
                if ( !( (objectByPass.contains('R1_VIP_Lounge_Access__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    System.debug('Entro en trigger');
                    R1_VIP_Lounge_Access_CLS.validarAcceso(trigger.new,0);
                }
            }
            else{}
        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert){
            if(trigger.new.size()==1){
                if ( !( (objectByPass.contains('R1_VIP_Lounge_Access__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    R1_CLS_SIPInt.crearEstadoSIP(trigger.new[0]);
                }
            }
            else{}
            
        }
        if(trigger.isUpdate){
            if(trigger.new.size()==1){
                if ( !( (objectByPass.contains('R1_VIP_Lounge_Access__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    R1_CLS_SIPInt.crearEstadoSIP(trigger.new[0]);
                }
            }
            else{}
        }
    }
}