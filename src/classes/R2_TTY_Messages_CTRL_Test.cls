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
private class R2_TTY_Messages_CTRL_Test {
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
	@isTest static void submit_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id delayedRT = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;

		R1_Incident__c inc = new R1_Incident__c();
		inc.RecordTypeId = delayedRT;
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.R2_INC_TXT_PIR_Reference_Number__c = '68814';
		insert inc;

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

		PageReference pageRef = Page.R2_VF_TTY_Messages;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_TTY_Messages_CTRL controller = new R2_TTY_Messages_CTRL(sc);
		controller.inputTX = 'FRAKKQQ/FRAKKQQ/FRAKKQQ/FRAKKQQ/FRAKKQQ';
		controller.messageTextarea = 'este esun mensaje de prueba en el test';
		controller.copyTo1 = 'AHL MADIB1234';
		controller.copyTo2 = 'OHD BCNIB1234';
		controller.copyTo3 = 'DDP BILIB1234';
		controller.submit();

		List<R2_MG_Message__c> listMsg = [SELECT Id,R2_MG_TXT_TX__c,R2_MG_ATXT_Message__c,R2_MG_LOO_Incident__c FROM R2_MG_Message__c WHERE R2_MG_LOO_Incident__c=:inc.Id];

		System.assertNotEquals(0, listMsg.size());
		System.assertEquals(controller.inputTX, listMsg[0].R2_MG_TXT_TX__c);
		System.assertEquals(controller.messageTextarea, listMsg[0].R2_MG_ATXT_Message__c);


		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void exception_Test(){

		/*
        R1_CLS_LogHelper.throw_exception = true;        
        R1_Incident__c incidencia = new R1_Incident__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(incidencia);
        R2_TTY_Messages_CTRL controller = new R2_TTY_Messages_CTRL(sc);
        controller.submit();
		controller.sendMessage();
		*/
    }
}