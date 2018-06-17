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
private class R1_BTCH_ProcessLoyaltyCards_TEST {
	
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia
    Company:        Accenture
    Description:    Metodo testear el batch que rellena datos del cliente con datos del loyalty card
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

		R1_Loyalty_Card__c loyalty = new R1_Loyalty_Card__c(R1_FF_MSDT_Client__c = acc.Id,  R1_FF_CHK_Preference__c = true, R1_FF_PKL_Type_FF__c = '4', R1_FF_PKL_Platinum_level_description__c = '04');
		insert loyalty;

		Test.startTest();
			Database.executeBatch(new R1_BTCH_ProcessLoyaltyCards());
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

		R1_Loyalty_Card__c loyalty = new R1_Loyalty_Card__c(R1_FF_MSDT_Client__c = acc.Id,  R1_FF_CHK_Preference__c = true, R1_FF_PKL_Type_FF__c = '4', R1_FF_PKL_Platinum_level_description__c = '04');
		insert loyalty;
        
        Test.startTest();
        
            Database.executeBatch(new R1_BTCH_ProcessLoyaltyCards());
        
        Test.stopTest(); 
    }	
}