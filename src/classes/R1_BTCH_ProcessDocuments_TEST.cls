/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia
    Company:        Accenture
    Description:    Apex test para la clase 'R1_BTCH_ProcessLoyaltyCards'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    30/06/2017             Alvaro Garcia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_BTCH_ProcessDocuments_TEST {
	
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia
    Company:        Accenture
    Description:    Metodo testear el batch que rellena datos del cliente con datos del customer_ID
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    30/06/2017             Alvaro Garcia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

	@isTest static void execute_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Account acc = new Account ();
        acc.LastName = 'test';
        acc.R1_ACC_TLF_Phone_Operative__c = '000000000';
		insert acc;

		R1_Customer_Id__c custId = new R1_Customer_Id__c(R1_DOC_MSDT_Client__c = acc.Id, R1_DOC_CHK_Preference__c = true, R1_DOC_TXT_Identification_number__c = 'test', 
											R1_DOC_PKL_Type_document__c = '05');
		insert custId;

		Test.startTest();
			Database.executeBatch(new R1_BTCH_ProcessDocuments());
		Test.stopTest();

	}

 /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    30/06/2017             Alvaro Garcia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        Account acc = new Account ();
        acc.LastName = 'test';
        acc.R1_ACC_TLF_Phone_Operative__c = '000000000';
        insert acc;

		R1_Customer_Id__c custId = new R1_Customer_Id__c(R1_DOC_MSDT_Client__c = acc.Id,  R1_DOC_CHK_Preference__c = true, R1_DOC_TXT_Identification_number__c = 'test', 
											R1_DOC_PKL_Type_document__c = '05');
		insert custId;
        
        Test.startTest();
        
            Database.executeBatch(new R1_BTCH_ProcessDocuments());
        
        Test.stopTest(); 
    }	
}