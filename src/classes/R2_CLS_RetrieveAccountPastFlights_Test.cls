@isTest
private class R2_CLS_RetrieveAccountPastFlights_Test
{
	@isTest
	static void getPastFlightsTest()
	{
	R1_CLS_LogHelper.throw_exception = false;  
	List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Retrieve Past Flights';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Retrieve Past Flights';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.R1_ACC_TXT_Id_Golden_record__c='96764130';
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB47663091';
        acc.R1_ACC_PKL_Platinum_level_description__c = '04';
        
        insert acc;

        Test.startTest();
        R2_CLS_RetrieveAccountPastFlights.getPastFlightsWRP(acc.id);
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
	
	@isTest
	static void getPastFlightsFailTest()
	{
		R1_CLS_LogHelper.throw_exception = false;  
		
		List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.R1_ACC_TXT_Id_Golden_record__c='96764130';
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB47663091';
        acc.R1_ACC_PKL_Platinum_level_description__c = '04';
        
        insert acc;

        Test.startTest();
        R2_CLS_RetrieveAccountPastFlights.getPastFlightsWRP(acc.id);
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
	}
	@isTest
	static void getPastFlightsLoginFailTest()
	{
		R1_CLS_LogHelper.throw_exception = false;  
		
		List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Retrieve Past Flights';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Retrieve Past Flights';
        lst_ep.add(ep);


        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.R1_ACC_TXT_Id_Golden_record__c='96764130';
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'IB47663091';
        acc.R1_ACC_PKL_Platinum_level_description__c = '04';
        
        insert acc;

        Test.startTest();
        R2_CLS_RetrieveAccountPastFlights.getPastFlightsWRP(acc.id);
        Test.stopTest();
        System.assertEquals(2, [SELECT count() FROM R1_Log__c]);
	}
        @isTest
        static void exceptionTest()
        {
        R1_CLS_LogHelper.throw_exception = false;  
                
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Retrieve Past Flights';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Retrieve Past Flights';
        lst_ep.add(ep);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Test.startTest();
        R2_CLS_RetrieveAccountPastFlights.getPastFlightsWRP(null);
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        }
}