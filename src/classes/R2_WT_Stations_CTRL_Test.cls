/*---------------------------------------------------------------------------------------------------------------------
Author:         Jaime Ascanta
Company:        Accenture
Description:
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
12/02/2018       	   				jaime ascanta                  Initial Version
----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_WT_Stations_CTRL_Test {
	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	12/02/2018       	   		Jaime Ascanta                  		 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void listStations_test() {
		R1_CLS_LogHelper.throw_exception = false;

		// endpoint
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_StationBags';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_StationBags';
		lst_ep.add(ep);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		Test.startTest();

		R2_WT_Stations_CTRL controller = new R2_WT_Stations_CTRL();
		controller.inputEstacion = 'MAD';
		controller.inputAirC = 'IB';

		controller.listStations();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	12/02/2018       	   		Jaime Ascanta                  		 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void screenStations_test() {
		R1_CLS_LogHelper.throw_exception = false;

		// endpoint
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_StationBags';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_StationBags';
		lst_ep.add(ep);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		Test.startTest();

		R2_WT_Stations_CTRL controller = new R2_WT_Stations_CTRL();
		controller.inputEstacion = 'MAD';
		controller.inputAirC = 'IB';

		controller.screenStations();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_WT_Stations_CTRL controller = new R2_WT_Stations_CTRL();
        controller.screenStations();
        controller.listStations();
    }

}