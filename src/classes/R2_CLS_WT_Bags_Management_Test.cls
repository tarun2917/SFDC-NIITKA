@isTest
private class R2_CLS_WT_Bags_Management_Test {

	@isTest static void SuspendDelayedBag_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{ "stationCode": "MAD","airlineCode": "IB","referenceNumber": "67693"},"agentId": "ABC"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.SuspendDelayedBag(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void ReinstateDelayedBag_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "67697"},"agentId": "ABC"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.ReinstateDelayedBag(wrapper, 0, null);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void CloseDelayedBag_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"record":{"stationCode":"MAD","referenceNumber":"68179","airlineCode":"IB"},"handledAirlineCopy":"YES","claim":{"payments":{"passengerPayment":[{"seq":1,"costType":"A","amount":{"amountValue":2500,"currencyCode":"EUR"}}]},"lossReasonCode":"20","lossComments":"CMN:LOSSCOMMENTS","faultTerminal":"T2","faultStation":"MAD"},"agentId":"12345"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.CloseDelayedBag(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void ReopenDelayedBag_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67633"},"newStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"agentId":"Agent"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.ReopenDelayedBag(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void ReassignDelayedBag_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67633"},"newStationAirline":{"airlineCode":"IB","stationCode":"BCN"},"agentId":"1234567"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.ReassignDelayedBag(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void GenerateSummaryReport_PIR_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DelayedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DelayedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67989"},"agentId":"aBC"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void GenerateDamagedBagReportResponse_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DamagedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DamagedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67989"},"agentId":"aBC"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void ReassignDamagedBagResponse_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DamagedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DamagedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"73136"},"newStationAirline":{"stationCode":"BCN","airlineCode":"IB"},"agentId":"Agent"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void CloseDamaged_CFI_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_DamagedBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_DamagedBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":[{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"73049"}],"agentId":"AGENT"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.CloseDamaged_CFI(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void RetrieveOHD_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_OnhandBagManager';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_OnhandBagManager';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{  "delayedBag": {    "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "68205"  },  "onHandBags": {    "onHandBag":[{       "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "72635"  }]  },  "passengerName": ["AB"],  "supplementaryText": ["0"],  "agentId": "abcd,"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.RetrieveOHD(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void searchBags_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"bagType":"DELAYED","searchType":"SIMPLE","name":{"name":"KARLA","exact":"false"},"itinerary":{"flight":{"airlineCode":"IB","flightNumber":"3740"}},"agentId":"123"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.searchBags(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void ReadRecord_OHD_DOH_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordId":{"recordType":"ON-HAND","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"72637"}},"agentId":"12"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.ReadRecord_OHD_DOH(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void readRecord_AHL_DAH_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordId":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67894"}},"agentId":"1278"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(wrapper, 0, true);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void readHistory_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{    "recordId": {     "recordType": "DELAYED",      "recordReference": {        "stationCode": "MAD",        "airlineCode": "IB",        "referenceNumber": "67894"   }    },    "agentId": "1278"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.readHistory(wrapper, 0, 'DELAYED');
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void InboxMessageSend_PXF_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_StationBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_StationBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"agentId":"AGENT","destinationInboxAddress":[{"stationCode":"MAD","airlineCode":"IB","area":"AA"}],"originStation":"MAD","message":"MESSAGE TO BE SEND","recordId":[{"recordType":"DELAYED","recordReference":{"airlineCode":"IB","stationCode":"MAD","referenceNumber":"67801"}}],"teletypeAddress":["TTY05AA"]}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.InboxMessageSend_PXF(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void InboxMessageRead_DXF_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_StationBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_StationBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"inboxMessageSearch":{"inboxAreaAddress":{"stationCode":"MAD","airlineCode":"IB","areaType":"SP","date":"2017-11-12"}},"agentId":"Test"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.InboxMessageRead_DXF(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void SendTeletypeMessage_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_StationBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_StationBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"origin":{"teletypeAddress":"TTY05A9","chargeableAirline":"IB"},"destinationTeletypeAddress":["TTY05A9"],"copyTo":{"recordID":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"68111"}}]},"message":"Message","agentId":"AgentId"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.SendTeletypeMessage(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

    @isTest static void DisplayStationList_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_StationBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_StationBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"status": "A","agentId": "agentId"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.DisplayStationList(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

    @isTest static void DisplayStationScreen_Test() {
		R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_StationBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_StationBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"referenceStationAirline": {"stationCode": "MAD","airlineCode": "IB"},"agentId": "Test"}';
		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		Test.startTest();
        R2_CLS_WT_Bags_Management.DisplayStationScreen(wrapper, 0);
		Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

    @isTest static void errorLogin_Test() {
		R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> listEndp = new List<R1_CS_Endpoints__c>();

        R1_CS_Endpoints__c ep1 = new R1_CS_Endpoints__c();
        ep1.Name='R2_DelayedBags';
        ep1.R1_CHK_Activo__c = true	;
        ep1.R1_TXT_EndPoint__c='R2_DelayedBags';
        listEndp.add(ep1);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name='R2_DamagedBags';
        ep2.R1_CHK_Activo__c = true	;
        ep2.R1_TXT_EndPoint__c='R2_DamagedBags';
        listEndp.add(ep2);

        R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
        ep3.Name='R2_InactiveBags';
        ep3.R1_CHK_Activo__c = true	;
        ep3.R1_TXT_EndPoint__c='R2_InactiveBags';
        listEndp.add(ep3);

        R1_CS_Endpoints__c ep5 = new R1_CS_Endpoints__c();
        ep5.Name='R2_OnhandBagManager';
        ep5.R1_CHK_Activo__c = true	;
        ep5.R1_TXT_EndPoint__c='R2_OnhandBagManager';
        listEndp.add(ep5);

        R1_CS_Endpoints__c ep6 = new R1_CS_Endpoints__c();
        ep6.Name='R2_SearchBags';
        ep6.R1_CHK_Activo__c = true	;
        ep6.R1_TXT_EndPoint__c='R2_SearchBags';
        listEndp.add(ep6);

        R1_CS_Endpoints__c ep7 = new R1_CS_Endpoints__c();
        ep7.Name='R2_StationBags';
        ep7.R1_CHK_Activo__c = true	;
        ep7.R1_TXT_EndPoint__c='R2_StationBags';
        listEndp.add(ep7);

        insert listEndp;

		Test.startTest();
        R2_CLS_WT_Bags_Management.SuspendDelayedBag(null, 0);
		R2_CLS_WT_Bags_Management.ReinstateDelayedBag(null, 0, null);
		R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReopenDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR(null, 0);
        R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse(null, 0);
        R2_CLS_WT_Bags_Management.CloseDamaged_CFI(null, 0);
        R2_CLS_WT_Bags_Management.RetrieveOHD(null, 0);
        R2_CLS_WT_Bags_Management.searchBags(null, 0);
        R2_CLS_WT_Bags_Management.ReadRecord_OHD_DOH(null, 0);
        R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(null, 0, true);
        R2_CLS_WT_Bags_Management.readHistory(null, 0, null);
        R2_CLS_WT_Bags_Management.InboxMessageSend_PXF(null, 0);
        R2_CLS_WT_Bags_Management.InboxMessageRead_DXF(null, 0);
        R2_CLS_WT_Bags_Management.SendTeletypeMessage(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationList(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationScreen(null, 0);
		Test.stopTest();
	}

    @isTest static void errorEndoint_Test() {
		R1_CLS_LogHelper.throw_exception = false;
		Test.startTest();
        R2_CLS_WT_Bags_Management.SuspendDelayedBag(null, 0);
		R2_CLS_WT_Bags_Management.ReinstateDelayedBag(null, 0, null);
		R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReopenDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR(null, 0);
        R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse(null, 0);
        R2_CLS_WT_Bags_Management.CloseDamaged_CFI(null, 0);
        R2_CLS_WT_Bags_Management.RetrieveOHD(null, 0);
        R2_CLS_WT_Bags_Management.searchBags(null, 0);
        R2_CLS_WT_Bags_Management.ReadRecord_OHD_DOH(null, 0);
        R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(null, 0, true);
        R2_CLS_WT_Bags_Management.readHistory(null, 0, null);
        R2_CLS_WT_Bags_Management.InboxMessageSend_PXF(null, 0);
        R2_CLS_WT_Bags_Management.InboxMessageRead_DXF(null, 0);
        R2_CLS_WT_Bags_Management.SendTeletypeMessage(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationList(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationScreen(null, 0);
		Test.stopTest();
	}

    @isTest static void exception_Test() {
		R1_CLS_LogHelper.throw_exception = true;
		Test.startTest();
        R2_CLS_WT_Bags_Management.SuspendDelayedBag(null, 0);
		R2_CLS_WT_Bags_Management.ReinstateDelayedBag(null, 0, null);
		R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.CloseDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReopenDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDelayedBag(null, 0);
        R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR(null, 0);
        R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse(null, 0);
        R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse(null, 0);
        R2_CLS_WT_Bags_Management.CloseDamaged_CFI(null, 0);
        R2_CLS_WT_Bags_Management.RetrieveOHD(null, 0);
        R2_CLS_WT_Bags_Management.searchBags(null, 0);
        R2_CLS_WT_Bags_Management.ReadRecord_OHD_DOH(null, 0);
        R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(null, 0, true);
        R2_CLS_WT_Bags_Management.readHistory(null, 0, null);
        R2_CLS_WT_Bags_Management.InboxMessageSend_PXF(null, 0);
        R2_CLS_WT_Bags_Management.InboxMessageRead_DXF(null, 0);
        R2_CLS_WT_Bags_Management.SendTeletypeMessage(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationList(null, 0);
        R2_CLS_WT_Bags_Management.DisplayStationScreen(null, 0);
		Test.stopTest();
	}
}