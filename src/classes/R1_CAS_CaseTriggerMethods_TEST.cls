/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   

    History: 
    
    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_CAS_CaseTriggerMethods_TEST {

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   Test method to test the creaEntitlement method

    History: 
    
    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	@isTest static void creaEntitlement_TEST() {
		R1_CLS_LogHelper.throw_exception = false;

		Account a = new Account(
			Name = 'test',
			//PersonBirthdate = Date.today(),
			R1_ACC_TLF_Phone_Marketing__c = '666666666',
			R1_ACC_TLF_Phone_Operative__c = '666666666',
			R1_ACC_EMA_Marketing_Email__c = 'test@test.test',
			R1_ACC_TXT_Email_Operative__c = 'test@test.test',
			R1_ACC_TXT_Identification_number__c = '123456',
			R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'Plata'
		);
		insert a;

		Case c = new Case(
			AccountId = a.Id,
			Type = 'Incidencias equipaje',
			RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Asistencia').getRecordTypeId(),
			Origin = 'Web'
		);

		Test.startTest();
		insert c;
		Test.stopTest();
	}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   Test to make the exception

    History: 
    
    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	@isTest static void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        Account a = new Account(
			Name = 'test',
			//PersonBirthdate = Date.today(),
			R1_ACC_TLF_Phone_Marketing__c = '666666666',
			R1_ACC_TLF_Phone_Operative__c = '666666666',
			R1_ACC_EMA_Marketing_Email__c = 'test@test.test',
			R1_ACC_TXT_Email_Operative__c = 'test@test.test',
			R1_ACC_TXT_Identification_number__c = '123456',
			R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'Plata'
		);
		insert a;

		Case c = new Case(
			AccountId = a.Id,
			Type = 'Incidencias equipaje',
			RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Asistencia').getRecordTypeId(),
			Origin = 'Web'
		);

		Test.startTest();
		insert c;
		Test.stopTest();
    }
}