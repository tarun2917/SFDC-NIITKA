/*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Daniel Cadalso
Company:        Accenture
Description:    R2_CLS_UpdateAccountsBatch test.



History:
<Date>                     <Author>                     <Change Description>
01/12/2017                 Daniel Cadalso               Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
@isTest
global class R2_CLS_UpdateAccountsBatch_TEST {
   /* static testMethod void executeTest(){
        Id personAccount_RT_Id = [select Id from RecordType where DeveloperName = 'PersonAccount' and SobjectType = 'Account'].Id;
        Account acc = new Account(LastName='Testing', PersonEmail = 'test@test.com',R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB11111111', R1_ACC_TLF_Phone_Marketing__c = '999888777', Phone = '999888777', RecordTypeId = personAccount_RT_Id, R2_ACC_NUM_ICAR_ind_act_last_2_years__c  = 1);
        insert acc;
        Account acc2 = new Account(LastName='Testing 2', PersonEmail = 'test2@test.com',R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB11111111', R1_ACC_TLF_Phone_Marketing__c = '999888777', Phone = '999888777', RecordTypeId = personAccount_RT_Id, R2_ACC_NUM_ICAR_ind_act_last_2_years__c = 1);
        insert acc2;
        Account acc3 = new Account(LastName='Testing 2', PersonEmail = 'test2@test.com',R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB11111111', R1_ACC_TLF_Phone_Marketing__c = '999888777', Phone = '999888777', RecordTypeId = personAccount_RT_Id, R2_ACC_NUM_ICAR_ind_act_last_2_years__c = 3);
        insert acc3;

        Test.startTest();
        R2_CLS_UpdateAccountsBatch claseBatch = new R2_CLS_UpdateAccountsBatch(1, null, null);
        DataBase.executeBatch(claseBatch);

        Test.stopTest();
    }*/
}