/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    19/03/2018          Jaime Ascanta		   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
@isTest
private class R2_CLS_Iberia_Voucher_TriggerMeth_Test {
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    19/03/2018          Jaime Ascanta		   	 Initial version
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@isTest 
	static void insertarBonoIbcomOkResp_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtIbCom = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'BonoIberiacom' LIMIT 1].Id;

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_IberiaComBonos';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_IberiaComBonosOkResponse';
		insert ep;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		Test.startTest();
			R2_Voucher__c vou = new R2_Voucher__c();
			vou.RecordTypeId = rtIbCom;
			vou.R2_VOU_TXT_Campaign_Commercial_Code__c = 'SALESFORCE3';
			vou.R2_VOU_NUM_Maximum_Bonus_Consumption__c = 99999999;
			vou.R2_VOU_PKL_Discount_Type__c = '0';
			vou.R2_VOU_NUM_Discount_Value__c = 17;
			vou.R2_VOU_PKL_Coin__c = 'EUR';
			vou.R2_VOU_DATH_Effective_Date_From__c = Date.newInstance(2018, 01, 01);
			vou.R2_VOU_DATH_Effective_Date_To__c = Date.newInstance(2018, 01, 06);
			insert vou;
		Test.stopTest();

		R2_Voucher__c vouData = [SELECT Id, R2_VOU_PKL_Status__c FROM R2_Voucher__c WHERE Id=:vou.Id];
		System.assertNotEquals(null, vouData);
		System.assertEquals('Emitido', vouData.R2_VOU_PKL_Status__c);

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    19/03/2018          Jaime Ascanta		   	 Initial version
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@isTest 
	static void insertarBonoIbcomErrorResp_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtIbCom = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'BonoIberiacom' LIMIT 1].Id;

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_IberiaComBonos';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_IberiaComBonosErrorResponse';
		insert ep;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		Test.startTest();
			R2_Voucher__c vou = new R2_Voucher__c();
			vou.RecordTypeId = rtIbCom;
			vou.R2_VOU_TXT_Campaign_Commercial_Code__c = 'SALESFORCE3';
			vou.R2_VOU_NUM_Maximum_Bonus_Consumption__c = 99999999;
			vou.R2_VOU_PKL_Discount_Type__c = '0';
			vou.R2_VOU_NUM_Discount_Value__c = 17;
			vou.R2_VOU_PKL_Coin__c = 'EUR';
			vou.R2_VOU_DATH_Effective_Date_From__c = Date.newInstance(2018, 01, 01);
			vou.R2_VOU_DATH_Effective_Date_To__c = Date.newInstance(2018, 01, 06);
			insert vou;
		Test.stopTest();

		R2_Voucher__c vouData = [SELECT Id, R2_VOU_PKL_Status__c FROM R2_Voucher__c WHERE Id=:vou.Id];
		System.assertNotEquals(null, vouData);
		System.assertEquals('Rechazado', vouData.R2_VOU_PKL_Status__c);

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Prepara los datos necesarios para los test
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    20/03/2018          Jaime Ascanta		   	 Initial version
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@TestSetup 
	static void setupTests(){
		// Login
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		insert epLogin;
		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'BonoIberiacom';
		cst.setTimeOut__c = 8000;
		insert cst;
	}

	@isTest
	static void exception_test(){
		R1_CLS_LogHelper.throw_exception = true;
		R2_CLS_Iberia_Voucher_TriggerMethods.insertarBonoIbcom(null);
		R2_CLS_Iberia_Voucher_TriggerMethods.wsInsertarBonoIbcom(null, null, null, null, null, null, null, null);
	}
}