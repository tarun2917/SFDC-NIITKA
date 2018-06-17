trigger R1_SIP_Status_Trigger on R1_SIP_Status__c (after insert) {

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);    
    
    if(trigger.isAfter){
        if(trigger.isInsert){
          if(trigger.new.size()==1){
                 if ( !( (objectByPass.contains('R1_SIP_Status__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) { 
                    R1_CLS_SIPInt.enviarVueloVIP(trigger.new[0].id);
                 }   
          }
          else{}
            
        }
    }


}