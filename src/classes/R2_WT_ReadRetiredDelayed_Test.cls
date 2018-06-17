@isTest
public with sharing class R2_WT_ReadRetiredDelayed_Test {
	
	@isTest static void helper_test(){
		String cadena = 'rDate';
    	R2_WT_ReadRetiredDamaged.helper_fixerJson(cadena);
    	//System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


    @isTest
    static void readRetiredDelayed_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    @isTest
    static void readRetiredDelayed401_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags401';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }


    @isTest
    static void readRetiredDelayed400_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags400';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

    
    @isTest
    static void readRetiredDelayed403_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags403';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

    @isTest
    static void readRetiredDelayed500_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags500';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

    @isTest
    static void readRetiredDelayedError_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBagsError';
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
        String wrapper = '{"recordID":{"recordType":"DAMAGED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"}},"date":"2017-01-10","agentID":"AGENT"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }
}