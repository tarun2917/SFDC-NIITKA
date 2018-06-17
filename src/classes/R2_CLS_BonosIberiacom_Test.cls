/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    20/03/2018          Jaime Ascanta		   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/   
@isTest
private class R2_CLS_BonosIberiacom_Test {
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    20/03/2018          Jaime Ascanta		   	 Initial version
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@isTest static void consultarBonoIberiacom_test() {
		R1_CLS_LogHelper.throw_exception = false;

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_IberiaComBonos';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'QueryVoucherPostiveResponse';
		insert ep;
		
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R2_Voucher__c vou = [SELECT Id, R2_VOU_TXT_Id_Bono__c FROM R2_Voucher__c WHERE R2_VOU_TXT_Id_Bono__c='12345' LIMIT 1];

		Test.startTest();
			R2_CLS_BonosIberiacom.consultarBonoIberiacom(vou.Id);
		Test.stopTest();

		vou = [SELECT Id, R2_VOU_TXT_Id_Bono__c,R2_VOU_TXT_Commercial_Code__c,R2_VOU_TXT_Campaign_Id__c FROM R2_Voucher__c WHERE R2_VOU_TXT_Id_Bono__c='12345' LIMIT 1];
		System.assertNotEquals(null, vou);
		System.assertEquals('testXXXXX', vou.R2_VOU_TXT_Commercial_Code__c);
		System.assertEquals('123', vou.R2_VOU_TXT_Campaign_Id__c);

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
    20/03/2018          Jaime Ascanta		   	 Initial version
    23/03/2018			Alvaro Garcia Tapia		 Not in use, If they need to cancel the use of bono Iberiacom, only uncomment
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	//@isTest static void cancelarBonoIbcom_test() {
	//	R1_CLS_LogHelper.throw_exception = false;

	//	R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
	//	ep.Name='R2_IberiaComBonos';
	//	ep.R1_CHK_Activo__c = true;
	//	ep.R1_TXT_EndPoint__c = 'CancelVoucherConsumptionWebPositiveResponse';
	//	insert ep;
		
	//	Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

	//	R2_Voucher__c vou = [SELECT Id, R2_VOU_TXT_Id_Bono__c FROM R2_Voucher__c WHERE R2_VOU_TXT_Id_Bono__c='12345' LIMIT 1];

	//	Test.startTest();
	//		String result = R2_CLS_BonosIberiacom.cancelarBonoIbcom(vou.Id, 'test');
	//	Test.stopTest();

	//	System.assertEquals('OK', result);

	//	System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	//}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    20/03/2018          Jaime Ascanta		   	 Initial version
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/   		
	@isTest static void anularEbono_test() {
		R1_CLS_LogHelper.throw_exception = false;

		// R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		// ep.Name='anulacionBono';
		// ep.R1_CHK_Activo__c = true;
		// ep.R1_TXT_EndPoint__c = 'CancelVoucherConsumptionWebPositiveResponse';
		// insert ep;
		
		// Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		// R2_Voucher__c vou = [SELECT Id, R2_VOU_TXT_Id_Bono__c FROM R2_Voucher__c WHERE R2_VOU_TXT_Id_Bono__c='12345' LIMIT 1];

		// Test.startTest();
		// 	String result = R2_CLS_BonosIberiacom.cancelarBonoIbcom(vou.Id, 'test');
		// Test.stopTest();

		// System.assertEquals('OK', result);

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

		Id rtIbCom = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'BonoIberiacom' LIMIT 1].Id;
		R2_Voucher__c vou = new R2_Voucher__c();
		vou.RecordTypeId = rtIbCom;
		vou.R2_VOU_TXT_Id_Bono__c = '12345';
		vou.R2_VOU_TXT_Campaign_Commercial_Code__c = 'SALESFORCE3';
		vou.R2_VOU_NUM_Maximum_Bonus_Consumption__c = 10;
		vou.R2_VOU_PKL_Discount_Type__c = '0';
		vou.R2_VOU_NUM_Discount_Value__c = 17;
		vou.R2_VOU_PKL_Coin__c = 'EUR';
		vou.R2_VOU_DATH_Effective_Date_From__c = Date.newInstance(2018, 01, 01);
		vou.R2_VOU_DATH_Effective_Date_To__c = Date.newInstance(2018, 01, 06);
		insert vou;

	}
}