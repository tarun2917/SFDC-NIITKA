@isTest
private class DummyBatch_TEST {
	
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	25/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
	static testMethod void testAllLengths() {
        R1_CLS_LogHelper.throw_exception = false;
        
        List<Account> preAccList = new List<Account>();
        
        Account acc1 = R1_CLS_Utilities.helper_Account_constructor('1');
        acc1.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB1';
        preAccList.add(acc1);
        
        Account acc2 = R1_CLS_Utilities.helper_Account_constructor('2');
        acc2.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB12';
        preAccList.add(acc2);

        Account acc3 = R1_CLS_Utilities.helper_Account_constructor('3');
        acc3.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB123';
        preAccList.add(acc3);

        Account acc4 = R1_CLS_Utilities.helper_Account_constructor('4');
        acc4.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB1234';
        preAccList.add(acc4);

        Account acc5 = R1_CLS_Utilities.helper_Account_constructor('5');
        acc5.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB12345';
        preAccList.add(acc5);

        Account acc6 = R1_CLS_Utilities.helper_Account_constructor('6');
        acc6.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB123456';
        preAccList.add(acc6);

        Account acc7 = R1_CLS_Utilities.helper_Account_constructor('7');
        acc7.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB1234567';
        preAccList.add(acc7);

        Account acc8 = R1_CLS_Utilities.helper_Account_constructor('8');
        acc8.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB12345678';
        preAccList.add(acc8);


        insert preAccList;


        Test.startTest();

        Database.executeBatch(new DummyBatch());

        Test.stopTest();


        List<Account> postAccList = [SELECT Id, R1_ACC_TXT_Primary_FF_Card_CCPO__c, R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c FROM Account];
        System.assertEquals(postAccList.size(),8);
        System.assertEquals(postAccList[0].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00000001');
        System.assertEquals(postAccList[1].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00000012');
        System.assertEquals(postAccList[2].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00000123');
        System.assertEquals(postAccList[3].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00001234');
        System.assertEquals(postAccList[4].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00012345');
        System.assertEquals(postAccList[5].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'00123456');
        System.assertEquals(postAccList[6].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'01234567');
        System.assertEquals(postAccList[7].R1_ACC_TXT_Primary_FF_Card_CCPO__c,'12345678');
        
 	}
	
}