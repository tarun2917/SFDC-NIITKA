global class R1_BTCH_ProcessLoyaltyCards implements Database.Batchable<sObject> {
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ricardo Pereira
    Company:        Accenture
    Description:    Metodo batch que rellena datos del cliente con datos del loyalty card
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    15/06/2017             Ricardo Pereira                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Name, R1_FF_TXT_FF_card_number__c,R1_FF_PKL_Type_FF__c, R1_FF_MSDT_Client__c, ' +
                                        'R1_FF_MSDT_Client__r.R1_ACC_PKL_Card_Type__c, R1_FF_PKL_Platinum_level_description__c, ' +
                                        'R1_FF_MSDT_Client__r.R1_ACC_PKL_Platinum_level_description__c ' +
                                        'FROM R1_Loyalty_Card__c ' +
                                        'WHERE (R1_FF_MSDT_Client__r.R1_ACC_PKL_Card_Type__c = null ' +
                                            'OR R1_FF_MSDT_Client__r.R1_ACC_PKL_Platinum_level_description__c = null) ' +
                                        'AND R1_FF_PKL_Type_FF__c != null ' +
                                        'AND R1_FF_CHK_Preference__c = true ' +
                                        'AND R1_FF_PKL_Platinum_level_description__c != null');

    }

    global void execute(Database.BatchableContext BC, List<R1_Loyalty_Card__c> scope) {

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            Map<Id, Account> mapAccToUpdate = new Map<Id, Account>();

            for(R1_Loyalty_Card__c loyCard: scope){
                if(!mapAccToUpdate.containsKey(loyCard.R1_FF_MSDT_Client__c)){
                    mapAccToUpdate.put(loyCard.R1_FF_MSDT_Client__c, 
                                    new Account( Id = loyCard.R1_FF_MSDT_Client__c,
                                                R1_ACC_PKL_Card_Type__c = loyCard.R1_FF_PKL_Type_FF__c,
                                                R1_ACC_PKL_Platinum_level_description__c = loyCard.R1_FF_PKL_Platinum_level_description__c));
                }

            }

            Database.update(mapAccToUpdate.values(), false);

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_BTCH_ProcessLoyaltyCards.execute()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Loyalty_Cards__c');
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}