trigger R1_ACC_TRG_AccountTrigger on Account (after insert, before insert, after update) {

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia 
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    18/05/2017              Alvaro Garcia           Initial Version     
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    list<Account> news = trigger.new;
    list<Account> olds = trigger.old;

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);

    if(trigger.isAfter){
        if(trigger.isInsert){
            if(trigger.new.size()==1){
                if ( !( (objectByPass.contains('Account') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                    R1_CLS_AccountTriggerMethods.callIntegrationMDM(news, null);
                }
            }
        }
    }
    if(trigger.isBefore){
        if(trigger.isInsert){
            R1_CLS_AccountTriggerMethods.checkToMarketingCloud(news);
            R1_CLS_AccountTriggerMethods.formatPhones(news);
        }
        if(trigger.isUpdate){
        }
    }
    if(trigger.isAfter){
        if(trigger.isUpdate){
            if(trigger.new.size()==1){
                if (!System.isFuture()) {
                    if ( !( (objectByPass.contains('Account') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                        R1_CLS_AccountTriggerMethods.callIntegrationMDM(news, olds);
                    }
                }
                if(trigger.new[0].R2_ACC_CHK_GDPR_UnSub__c && !trigger.old[0].R2_ACC_CHK_GDPR_UnSub__c){
                    R1_CLS_AccountTriggerMethods.bajaGDPR(trigger.newMap.keyset());
                }
            }
            List<String> lstGDPR = new List<String>();
            lstGDPR =  R1_CLS_AccountTriggerMethods.filtrarAccountGDPR(news);
            if(!lstGDPR.isEmpty()){
                System.debug('Llamo a R2_CLS_QueueableAccountDelete');
                System.enqueueJob(new R2_CLS_QueueableAccountDelete(lstGDPR));
            }
        }
    }
}