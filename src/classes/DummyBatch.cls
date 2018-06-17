global class DummyBatch implements Database.Batchable<sObject> {
    
    String query;
    
    global DummyBatch() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, R1_ACC_TXT_Primary_FF_Card_CCPO__c, R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c FROM Account WHERE R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c != null AND R1_ACC_TXT_Primary_FF_Card_CCPO__c = null');
    }

    global void execute(Database.BatchableContext BC, List<Account> scope) {
        String temp = '';
        for(Account acc: scope){

            if(acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c.length()> 2){
                //acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c;
                temp = acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c.remove(acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c.left(2));
                if(temp.length()== 1){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '0000000' + temp;
                }else if(temp.length()== 2){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '000000' + temp;
                }else if(temp.length()== 3){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '00000' + temp;
                }else if(temp.length()== 4){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '0000' + temp;
                }else if(temp.length()== 5){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '000' + temp;
                }else if(temp.length()== 6){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '00' + temp;
                }else if(temp.length()== 7){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = '0' + temp;
                }else if(temp.length()== 8){
                    acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = temp;
                }
            }
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}