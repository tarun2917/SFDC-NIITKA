/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    17/08/2017             Rubén Pingarrón Jerez                   Initial Version
    17/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
trigger R2_ATT_TRG_emailAttachmentVisibleOnParent on Attachment (before insert, before update) {
    
    List<Attachment> news = trigger.new;
    List<Attachment> olds = trigger.old;
    
    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            R2_CLS_ATT_TriggersMethods.valorParentId(news);
            system.debug('INSERT');
        }
        if(Trigger.isUpdate){
            R2_CLS_ATT_TriggersMethods.valorParentId(news);
            system.debug('isUpdate');

        }
    }
    
}