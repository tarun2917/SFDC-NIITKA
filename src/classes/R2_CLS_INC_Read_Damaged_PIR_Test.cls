@isTest
public with sharing class R2_CLS_INC_Read_Damaged_PIR_Test {


	 @isTest
    static void readRetiredDamaged_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags/';
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
        String wrapper = '{"recordId":{"recordType":"DAMAGED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"73196"}},"agentId":"12"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     @isTest
    static void readRetiredDamaged2_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_SearchBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_SearchBags2/';
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
        String wrapper = '{"recordId":{"recordType":"DAMAGED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"73196"}},"agentId":"12"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP(wrapper, 0, false);
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

	 @isTest
    static void exception_Test(){
        R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP(null, null,null);
    }


}