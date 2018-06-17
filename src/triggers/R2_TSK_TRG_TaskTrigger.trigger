trigger R2_TSK_TRG_TaskTrigger on Task (after insert) {
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero MOreno
    Company:        Accenture
    Description:    Trigger del objeto Task
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    15/09/2017            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   

	R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    if(trigger.isAfter){    
            
        if(trigger.isInsert){
            if(trigger.new.size()==1){
                System.debug('Preba del trigger: ' + trigger.new[0].id);
                if(trigger.new[0].Subject.contains('SMS')){
                    R2_CLS_TSK_TriggerMethods.enviarTSK(trigger.new[0].id);            
                }
            }
            else{}
            }
        }
}