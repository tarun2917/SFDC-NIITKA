/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:    Apex test from class "R2_ACC_CLS_CasesList_CTRL"
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	23/10/2017       	   			Jaime Ascanta                   		Initial Version
	----------------------------------------------------------------------------------------------------------------------*/

@isTest
private class R2_ACC_CLS_CasesList_CTRL_Test {

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from method loadTabSelected()
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		19/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/

	@isTest
	static void loadTabSelected_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
		Account acc = new Account();
		acc.RecordTypeId = recordTypeId;
		acc.LastName = 'ClienteTest';
		acc.PersonEmail = 'test@test.com';
		acc.R1_ACC_PKL_Gender_description__c = 'M';
		acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
		acc.R1_ACC_PKL_identification_Type__c = '02';
		acc.R1_ACC_TXT_Identification_number__c = '123456789';
		insert acc;

		//caso de 'Expediente'
		Id rtExp = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;
		Case casExp = new Case();
		casExp.RecordTypeId = rtExp;
		casExp.AccountID = acc.Id;
		casExp.Status = 'Abierto';
		casExp.Origin = 'Email';
		casExp.Type = 'Demora';
		casExp.R2_CAS_EMA_Email__c = 'Test@test.com';
		insert casExp;

		//caso de 'Comunicaciones entrantes'
		Id rtCom = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Comunicaciones entrantes' LIMIT 1].Id;
		Case casCom = new Case();
		casCom.RecordTypeId = rtCom;
		casCom.AccountID = acc.Id;
		casCom.Status = 'Abierto';
		casCom.Origin = 'Email';
		casCom.Type = 'Demora';
		casCom.R2_CAS_EMA_Email__c = 'Test@test.com';
		insert casCom;


		Test.startTest();
				ApexPages.StandardController sc = new ApexPages.StandardController(acc);
				R2_ACC_CLS_CasesList_CTRL controller = new R2_ACC_CLS_CasesList_CTRL(sc);

				//case 1 - Expediente
				controller.tab_selected = '1.expediente';
				controller.loadTabSelected();
				System.assert(controller.tam_lst_case>0);


				//case 2 - Comunicaciones entrantes
				controller.tab_selected = '2.comunicacion_entrante';
				controller.changeTab();
				//System.assert(controller.tam_lst_case>0);

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from method newCase()
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		19/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/

	@isTest
	static void newCase_test() {

		R1_CLS_LogHelper.throw_exception = false;

		Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
		Account acc = new Account();
		acc.RecordTypeId = recordTypeId;
		acc.LastName = 'ClienteTest';
		acc.R1_ACC_TLF_Phone_Marketing__c  = '+34 123456789';
		acc.R1_ACC_TLF_Phone_Operative__c = '+34 123456789';
		acc.R2_ACC_TLF_Phone_MarketingII__c = '+34 123456789';
		acc.R2_ACC_TLF_Phone_OperativeII__c = '+34 123456789';
		insert acc;

		Test.startTest();
				ApexPages.StandardController sc = new ApexPages.StandardController(acc);
				R2_ACC_CLS_CasesList_CTRL controller = new R2_ACC_CLS_CasesList_CTRL(sc);
				controller.newCase();
				System.assert(controller.shouldRedirect);
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from method showAll()
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		19/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/

	@isTest
	static void showAll_test() {

		R1_CLS_LogHelper.throw_exception = false;

		Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
		Account acc = new Account();
		acc.RecordTypeId = recordTypeId;
		acc.LastName = 'ClienteTest';
		acc.R1_ACC_TLF_Phone_Marketing__c  = '+34 123456789';
		acc.R1_ACC_TLF_Phone_Operative__c = '+34 123456789';
		acc.R2_ACC_TLF_Phone_MarketingII__c = '+34 123456789';
		acc.R2_ACC_TLF_Phone_OperativeII__c = '+34 123456789';
		insert acc;

		Test.startTest();
				ApexPages.StandardController sc = new ApexPages.StandardController(acc);
				R2_ACC_CLS_CasesList_CTRL controller = new R2_ACC_CLS_CasesList_CTRL(sc);
				controller.showAll();
				System.assert(controller.shouldRedirectLink);
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from methods of pagination
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		23/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void pagination_Test(){
				R1_CLS_LogHelper.throw_exception = false;

				Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
				Account acc = new Account();
				acc.RecordTypeId = recordTypeId;
				acc.LastName = 'ClienteTest';
				acc.PersonEmail = 'test@test.com';
				acc.R1_ACC_PKL_Gender_description__c = 'M';
				acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
				acc.R1_ACC_PKL_identification_Type__c = '02';
				acc.R1_ACC_TXT_Identification_number__c = '123456789';
				insert acc;

				Id rtExp = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;
				List<Case> casList = new List<Case>();
				for(Integer i = 0; i < 15; i++){
					Case cas = new Case();
					cas.RecordTypeId = rtExp;
					cas.AccountID = acc.Id;
					cas.Status = 'Abierto';
					cas.Origin = 'Email';
					cas.Type = 'Demora';
					cas.R2_CAS_EMA_Email__c = 'Test@test.com';
					casList.add(cas);
				}
				insert casList;


				Test.startTest();
						ApexPages.StandardController sc = new ApexPages.StandardController(acc);
						R2_ACC_CLS_CasesList_CTRL controller = new R2_ACC_CLS_CasesList_CTRL(sc);

						controller.loadTabSelected();
						controller.Next();
						controller.Previous();
						controller.End();
						System.assertEquals(true, controller.getDisableNext() );
						controller.Beginning();
						System.assertEquals(true, controller.getDisablePrevious() );


				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from excenptions
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		23/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void exceptions_Test(){
				R1_CLS_LogHelper.throw_exception = true;

				Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
				Account acc = new Account();
				acc.RecordTypeId = recordTypeId;
				acc.LastName = 'ClienteTest';
				acc.PersonEmail = 'test@test.com';
				acc.R1_ACC_PKL_Gender_description__c = 'M';
				acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
				acc.R1_ACC_PKL_identification_Type__c = '02';
				acc.R1_ACC_TXT_Identification_number__c = '123456789';
				insert acc;

				Test.startTest();

						ApexPages.StandardController sc = new ApexPages.StandardController(acc);
		        R2_ACC_CLS_CasesList_CTRL controller = new R2_ACC_CLS_CasesList_CTRL(sc);

						controller.init(null);
						controller.newCase();
						controller.showAll();

				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


}