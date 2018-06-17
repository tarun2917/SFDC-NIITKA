@isTest
private class R2_WT_BaggageHistory_CTRL_Test {
	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alvaro Garcia Tapia
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	12/02/2018       	   	Alvaro Garcia Tapia                  Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void readRecordId_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.readRecordId();

		//List<R2_MG_Message__c> listMsg = [SELECT Id,R2_MG_TXT_TX__c,R2_MG_ATXT_Message__c,R2_MG_LOO_Incident__c FROM R2_MG_Message__c WHERE R2_MG_LOO_Incident__c=:inc.Id];

		//System.assertNotEquals(0, listMsg.size());
		//System.assertEquals(controller.inputTX, listMsg[0].R2_MG_TXT_TX__c);
		//System.assertEquals(controller.messageTextarea, listMsg[0].R2_MG_ATXT_Message__c);


		Test.stopTest();
		//System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alvaro Garcia Tapia
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	12/02/2018       	   	Alvaro Garcia Tapia                  Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void processROH_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selectionFull = '10  MCH  08FEB/1436 OHD MADIB73418   - 72 TN/CT/FD/BI';
		controller.processROH();

		//List<R2_MG_Message__c> listMsg = [SELECT Id,R2_MG_TXT_TX__c,R2_MG_ATXT_Message__c,R2_MG_LOO_Incident__c FROM R2_MG_Message__c WHERE R2_MG_LOO_Incident__c=:inc.Id];

		//System.assertNotEquals(0, listMsg.size());
		//System.assertEquals(controller.inputTX, listMsg[0].R2_MG_TXT_TX__c);
		//System.assertEquals(controller.messageTextarea, listMsg[0].R2_MG_ATXT_Message__c);


		Test.stopTest();
		//System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void readDOHAux_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 OHD MADIB73418   - 72 TN/CT/FD/BI';
		controller.readDOHAux();

		Test.stopTest();
		//System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void readDOHAuxFWD_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.readDOHAux();

		Test.stopTest();
		System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void prepareROHAux_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 OHD MADIB73418   - 72 TN/CT/FD/BI';
		controller.prepareROHAux();

		Test.stopTest();
		// System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void prepareROHAuxFWD_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.prepareROHAux();

		Test.stopTest();
		// System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void prepareROH_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.prepareROH();

		Test.stopTest();
	}

	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ismael Yubero Moreno
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	27/02/2018       	   	Ismael Yubero MOreno                 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void rushSearchROH_test() {
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
		ep.Name='R2_OnhandBagManager';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
		lst_ep.add(ep);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', inc.Id);

		Test.startTest();

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.rushSearchROH();

		Test.stopTest();
		System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
	}

		/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alvaro Garcia Tapia
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	12/02/2018       	   	Alvaro Garcia Tapia                  Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	//@isTest static void readDOHAux_test() {
	//	R1_CLS_LogHelper.throw_exception = false;

	//	Id delayedRT = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;

	//	R1_Incident__c inc = new R1_Incident__c();
	//	inc.RecordTypeId = delayedRT;
	//	inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
	//	inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
	//	inc.R2_INC_TXT_PIR_Reference_Number__c = '68814';
	//	insert inc;

	//	// endpoint
	//	List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
	//	R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
	//	epLogin.Name = 'ETL_Login';
	//	epLogin.R1_CHK_Activo__c = true;
	//	epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
	//	lst_ep.add(epLogin);

	//	R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
	//	ep.Name='R2_OnhandBagManager';
	//	ep.R1_CHK_Activo__c = true;
	//	ep.R1_TXT_EndPoint__c = 'R2_OnhandBagManager';
	//	lst_ep.add(ep);

	//	R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
	//	read.Name='R2_SearchBags';
	//	read.R1_CHK_Activo__c = true;
	//	read.R1_TXT_EndPoint__c = 'R2_SearchBags';
	//	lst_ep.add(read);

	//	insert lst_ep;

	//	//timeOut
	//	TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
	//	cst.Name = 'WorldTracer';
	//	cst.setTimeOut__c = 8000;
	//	insert cst;

	//	Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

	//	PageReference pageRef = Page.R2_BAG_VF_BaggageMatch;
	//	Test.setCurrentPage(pageRef);
	//	ApexPages.currentPage().getParameters().put('id', inc.Id);

	//	Test.startTest();

	//	ApexPages.StandardController sc = new ApexPages.StandardController(inc);
	//	R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
	//	controller.selection = '10  MCH  08FEB/1436 OHD MADIB73418   - 72 TN/CT/FD/BI';
	//	controller.readDOHAux();

	//	//List<R2_MG_Message__c> listMsg = [SELECT Id,R2_MG_TXT_TX__c,R2_MG_ATXT_Message__c,R2_MG_LOO_Incident__c FROM R2_MG_Message__c WHERE R2_MG_LOO_Incident__c=:inc.Id];

	//	//System.assertNotEquals(0, listMsg.size());
	//	//System.assertEquals(controller.inputTX, listMsg[0].R2_MG_TXT_TX__c);
	//	//System.assertEquals(controller.messageTextarea, listMsg[0].R2_MG_ATXT_Message__c);


	//	Test.stopTest();
		//System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	//}

//	@isTest static void exception_Test(){

//        R1_CLS_LogHelper.throw_exception = true;        
//        R1_Incident__c incidencia = new R1_Incident__c();
//        ApexPages.StandardController sc = new ApexPages.StandardController(incidencia);
//        R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
//		controller.createRequest_ROH();
//		controller.updateSelectedBag();
		
//    }

	@isTest
    static void exception_Test(){
    	R1_CLS_LogHelper.throw_exception = true;

		Id delayedRT = [select id, DeveloperName from RecordType where DeveloperName ='DELAYED' LIMIT 1].Id;

		R1_Incident__c inc = new R1_Incident__c();
		inc.RecordTypeId = delayedRT;
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.R2_INC_TXT_PIR_Reference_Number__c = '68814';
		insert inc;

		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_WT_BaggageHistory_CTRL controller = new R2_WT_BaggageHistory_CTRL(sc);
		controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.incident = inc;
        controller.readRecord_WT(null, null, null, null, null);
        controller.readRecordId();
        controller.selection = '10  MCH  08FEB/1436 FWD MADIB73418   - 72 TN/CT/FD/BI';
		controller.incident = inc;
        controller.readDOH();
        controller.createRequest_ROH();
        controller.updateSelectedBag();
        
    }

}