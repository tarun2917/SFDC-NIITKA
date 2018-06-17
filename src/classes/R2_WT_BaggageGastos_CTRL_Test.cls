@isTest
public with sharing class R2_WT_BaggageGastos_CTRL_Test {
	
	@isTest
	static void getHeadersTable_test(){
		R1_CLS_LogHelper.throw_exception = false;
		Id rtInc = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;
		
		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
		aux.R2_ADI_MSDT_Incident__c = inc.Id;
		aux.R2_ADI_PKL_Type__c = 'MR';
		aux.R2_ADI_MSDT_Incident__c = inc.id;
		aux.R2_ADI_NUM_CS_Amount__c =  10;
		aux.R2_ADI_TXT_CS_Currency__c = 'EU';
		aux.R2_ADI_PKL_CS_Cost_Type__c = 'F';
		aux.R2_ADI_NUM_Decimal_Place__c = 2;
		insert aux;

		
		Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageGastos_CTRL controller = new R2_WT_BaggageGastos_CTRL(sc);

		controller.saveHandler();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	@isTest
	static void addRoowEmpty(){
		R1_CLS_LogHelper.throw_exception = false;
		Id rtInc = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageGastos_CTRL controller = new R2_WT_BaggageGastos_CTRL(sc);
		controller.getHeadersTable();
		controller.addRoowEmpty();
		controller.cancelHandler();
		controller.saveHandler();
		controller.deletedHandler();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	@isTest
	static void exception_test(){
		R1_CLS_LogHelper.throw_exception = true;
		Id rtInc = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageGastos_CTRL controller = new R2_WT_BaggageGastos_CTRL(sc);
		controller.getHeadersTable();
		controller.addRoowEmpty();
		controller.cancelHandler();
		controller.saveHandler();
		controller.deletedHandler();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


}