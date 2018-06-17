global class R1_BTCH_ProcessDocuments implements Database.Batchable<SObject> {
    
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ricardo Pereira
    Company:        Accenture
    Description:    Metodo batch que rellena datos del cliente con datos del customer_ID
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    15/06/2017             Ricardo Pereira                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Name, R1_DOC_TXT_Identification_number__c, ' +
                                'R1_DOC_PKL_Type_document__c, R1_DOC_MSDT_Client__c, R1_DOC_MSDT_Client__r.R1_ACC_TXT_Identification_number__c, ' +
                                'R1_DOC_MSDT_Client__r.R1_ACC_PKL_identification_Type__c ' +
                                'FROM R1_Customer_Id__c ' +
                                'WHERE R1_DOC_CHK_Preference__c = true ' +
                                'AND R1_DOC_TXT_Identification_number__c != null ' +
                                'AND R1_DOC_PKL_Type_document__c != null ' +
                                'AND R1_DOC_MSDT_Client__c != null ' +
                                'AND R1_DOC_MSDT_Client__r.R1_ACC_TXT_Identification_number__c = null');
    }

    global void execute(Database.BatchableContext BC, List<R1_Customer_ID__c> scope) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            Map<Id, Account> mapAccToUpdate = new Map<Id, Account>();

            for(R1_Customer_ID__c doc: scope){
                if(!mapAccToUpdate.containsKey(doc.R1_DOC_MSDT_Client__c)){
                    mapAccToUpdate.put(doc.R1_DOC_MSDT_Client__c, new Account( Id = doc.R1_DOC_MSDT_Client__c,
                                                                    R1_ACC_TXT_Identification_number__c = doc.R1_DOC_TXT_Identification_number__c,
                                                                    R1_ACC_PKL_identification_Type__c = doc.R1_DOC_PKL_Type_document__c));
                }

            }

            Database.update(mapAccToUpdate.values(), false);
            
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_BTCH_ProcessDocuments.execute()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Customer_Id__c');
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}