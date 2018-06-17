@isTest
private class R2_CLS_Work_Order_TriggerMethods_Test {
    

    @isTest static void testProcesarOTVacio() {
        Account acc = new Account();
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Identification_number__c='71520940W';
        insert acc;
        R2_Work_Order__c wo = new R2_Work_Order__c();
        wo.R2_WO_TXT_OT__c='Test';
        wo.R2_WO_PKL_status__c='0';
        wo.R2_WO_DAT_Opening_date__c= Date.newInstance(2017, 10, 30);
        wo.R2_WO_DAT_Shutdown_date__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_TXT_Commentary__c='Test';
        wo.R2_WO_NUM_Amount_tot__c=123;
        wo.R2_WO_TXT_Description_Borrower__c='Test';
        wo.R2_WO_TXT_Code_Borrower__c='Test';
        wo.R2_WO_TXT_Bags__c='1,Blue,ABC\n2,Red,DEF';
        wo.R2_WO_TXT_Name__c='Test';
        wo.R2_WO_TXT_Last_Name__c='Test';
        wo.R2_WO_TXT_Document_Number__c='11111111A';
        wo.R2_WO_EMA_email__c='Test5@Test5.com';
        wo.R2_WO_TLF_Phone__c='666666666';
        wo.R2_WO_TXT_delivery_address__c='Test';
        wo.R2_WO_TXT_delivery_city__c='Test';
        wo.R2_WO_TXT_delivery_Postal_Code__c='Test';
        wo.R2_WO_TXT_delivery_Country__c='Test';
        wo.R2_WO_TXT_delivery_time__c='Test';
        wo.R2_WO_TXT_delivery_commentary__c='Test';
        wo.R2_WO_TXT_PIR__c='Test';
        wo.R2_WO_TXT_main_file__c='Test';
        wo.R2_WO_DAT_Date_Creation_PIR__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_LOO_Client__c=acc.id;

        Test.startTest();
        insert wo;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    @isTest static void testProcesarOTLleno() {
            Account acc = new Account();
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Identification_number__c='71520940W';
        insert acc;
        
        List<R2_Work_Order__c> lstWorkOrders = new List<R2_Work_Order__c>();
        
        R2_Work_Order__c wo = new R2_Work_Order__c();
        wo.R2_WO_TXT_OT__c='Test2';
        wo.R2_WO_PKL_status__c='0';
        wo.R2_WO_DAT_Opening_date__c= Date.newInstance(2017, 10, 30);
        wo.R2_WO_DAT_Shutdown_date__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_TXT_Commentary__c='Test';
        wo.R2_WO_NUM_Amount_tot__c=123;
        wo.R2_WO_TXT_Description_Borrower__c='Test';
        wo.R2_WO_TXT_Code_Borrower__c='Test';
        wo.R2_WO_TXT_Bags__c='1,Blue,ABC\n2,Red,DEF';
        wo.R2_WO_TXT_Name__c='Test';
        wo.R2_WO_TXT_Last_Name__c='Test';
        wo.R2_WO_TXT_Document_Number__c='11111111A';
        wo.R2_WO_EMA_email__c='Test5@Test5.com';
        wo.R2_WO_TLF_Phone__c='666666666';
        wo.R2_WO_TXT_delivery_address__c='Test';
        wo.R2_WO_TXT_delivery_city__c='Test';
        wo.R2_WO_TXT_delivery_Postal_Code__c='Test';
        wo.R2_WO_TXT_delivery_Country__c='Test';
        wo.R2_WO_TXT_delivery_time__c='Test';
        wo.R2_WO_TXT_delivery_commentary__c='Test';
        wo.R2_WO_TXT_PIR__c='Test';
        wo.R2_WO_TXT_main_file__c='Test';
        wo.R2_WO_DAT_Date_Creation_PIR__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_LOO_Client__c=acc.id;
        lstWorkOrders.add(wo);
        
        R2_Work_Order__c wo2 = new R2_Work_Order__c();
        wo2.R2_WO_TXT_OT__c='Test';
        wo2.R2_WO_PKL_status__c='0';
        wo2.R2_WO_DAT_Opening_date__c= Date.newInstance(2017, 10, 30);
        wo2.R2_WO_DAT_Shutdown_date__c=Date.newInstance(2017, 10, 30);
        wo2.R2_WO_TXT_Commentary__c='Test';
        wo2.R2_WO_NUM_Amount_tot__c=123;
        wo2.R2_WO_TXT_Description_Borrower__c='Test';
        wo2.R2_WO_TXT_Code_Borrower__c='Test';
        wo2.R2_WO_TXT_Bags__c='1,Blue,ABC\n2,Red,DEF';
        wo2.R2_WO_TXT_Name__c='Test';
        wo2.R2_WO_TXT_Last_Name__c='Test';
        wo2.R2_WO_TXT_Document_Number__c='11111111A';
        wo2.R2_WO_EMA_email__c='Test5@Test5.com';
        wo2.R2_WO_TLF_Phone__c='666666666';
        wo2.R2_WO_TXT_delivery_address__c='Test';
        wo2.R2_WO_TXT_delivery_city__c='Test';
        wo2.R2_WO_TXT_delivery_Postal_Code__c='Test';
        wo2.R2_WO_TXT_delivery_Country__c='Test';
        wo2.R2_WO_TXT_delivery_time__c='Test';
        wo2.R2_WO_TXT_delivery_commentary__c='Test';
        wo2.R2_WO_TXT_PIR__c='Test';
        wo2.R2_WO_TXT_main_file__c='Test';
        wo2.R2_WO_DAT_Date_Creation_PIR__c=Date.newInstance(2017, 10, 30);
        wo2.R2_WO_LOO_Client__c=acc.id;
        lstWorkOrders.add(wo2);
        Test.startTest();
        insert lstWorkOrders;
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     @isTest static void testProcesarOTVacioTipo() {
        Account acc = new Account();
        acc.LastName = 'Test';
        acc.R1_ACC_TXT_Identification_number__c='71520940W';
        insert acc;
        R2_Work_Order__c wo = new R2_Work_Order__c();
        wo.R2_WO_TXT_OT__c='Test';
        wo.R2_WO_PKL_status__c='0';
        wo.R2_WO_DAT_Opening_date__c= Date.newInstance(2017, 10, 30);
        wo.R2_WO_DAT_Shutdown_date__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_TXT_Commentary__c='Test';
        wo.R2_WO_NUM_Amount_tot__c=123;
        wo.R2_WO_TXT_Description_Borrower__c='Test';
        wo.R2_WO_TXT_Code_Borrower__c='Test';
        wo.R2_WO_TXT_Bags__c='1,Blue,ABC\n2,Red,DEF';
        wo.R2_WO_TXT_Name__c='Test';
        wo.R2_WO_TXT_Last_Name__c='Test';
        wo.R2_WO_TXT_Document_Number__c='11111111A';
        wo.R2_WO_EMA_email__c='Test5@Test5.com';
        wo.R2_WO_TLF_Phone__c='666666666';
        wo.R2_WO_TXT_delivery_address__c='Test';
        wo.R2_WO_TXT_delivery_city__c='Test';
        wo.R2_WO_TXT_delivery_Postal_Code__c='Test';
        wo.R2_WO_TXT_delivery_Country__c='Test';
        wo.R2_WO_TXT_delivery_time__c='Test';
        wo.R2_WO_TXT_delivery_commentary__c='Test';
        wo.R2_WO_TXT_PIR__c='Test';
        wo.R2_WO_TXT_main_file__c='Test';
        wo.R2_WO_DAT_Date_Creation_PIR__c=Date.newInstance(2017, 10, 30);
        wo.R2_WO_LOO_Client__c=acc.id;
        wo.R2_WO_PKL_type__c ='Europe Assistance';

        Test.startTest();
        insert wo;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
}