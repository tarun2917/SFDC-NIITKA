/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture 
    Description:    Clase para asginar el importe correspondiente a una maleta perdida
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    13/11/2017             Sara Torres Bermudez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_BaggageTriggerMethods_Test {
    static testMethod void asignarImporteMaletaInsertDefectoTipo1(){
        R1_CLS_LogHelper.throw_exception = false;
        
         // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'No Iberia Plus';
        insert acc; 
        
       
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '05';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '05&Defecto';
        cs_bag.R2_DIV_estimated_amount__c = 60.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
		List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(60.0, malet[0].R2_BAG_DIV_Estimated_amount__c);        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    static testMethod void asignarImporteMaletaInsertDefectoTipo2(){
        R1_CLS_LogHelper.throw_exception = false;

        // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'No Iberia Plus';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '22';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '22&Defecto';
        cs_bag.R2_DIV_estimated_amount__c = 80.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
        List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(80.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    static testMethod void asignarImporteMaletaInsertDefectoTipo3(){
        R1_CLS_LogHelper.throw_exception = false;

        // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'No Iberia Plus';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '01';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '01&Defecto';
        cs_bag.R2_DIV_estimated_amount__c = 100.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
		List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(100.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    static testMethod void asignarImporteMaletaInsertOro(){
        R1_CLS_LogHelper.throw_exception = false;

         // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'Oro';
        insert acc;
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '03';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '03&Oro';
        cs_bag.R2_DIV_estimated_amount__c = 90.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
        List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(90.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void asignarImporteMaletaInsertClasica(){
        R1_CLS_LogHelper.throw_exception = false;

        // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'Clasica';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '05';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '05&Clasica';
        cs_bag.R2_DIV_estimated_amount__c = 50.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
		List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(50.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void asignarImporteMaletaInsertPlata(){
        R1_CLS_LogHelper.throw_exception = false;

        // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'Plata';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '05';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '05&Plata';
        cs_bag.R2_DIV_estimated_amount__c = 70.0;
        insert cs_bag;
        
        Test.startTest();
        insert lst_maletas;
        List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(70.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void asignarImporteMaletaInsertPlatino(){
        R1_CLS_LogHelper.throw_exception = false;

         // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'Platino';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '05';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '05&Platino';
        cs_bag.R2_DIV_estimated_amount__c = 100.0;
        insert cs_bag; 
        
        Test.startTest();
        insert lst_maletas;
        List<R2_Baggage__c> malet = [SELECT Id, R2_BAG_DIV_Estimated_amount__c FROM R2_Baggage__c WHERE Id =: maleta1.Id];
        System.assertEquals(100.0, malet[0].R2_BAG_DIV_Estimated_amount__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void asignarImporteMaletaUpdate(){
        R1_CLS_LogHelper.throw_exception = false;

        // cuenta
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.R1_ACC_PKL_Card_Type__c = 'Platino';
        insert acc; 
        
        // incidencia
        R1_Incident__c inci = new R1_Incident__c();
        inci.R1_INC_LOO_Client__c = acc.id;
        inci.RecordTypeId = Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId(); 
        insert inci;
      
        List<R2_Baggage__c> lst_maletas = new List<R2_Baggage__c>();
        
        R2_Baggage__c maleta1 = new R2_Baggage__c();
        maleta1.R2_BAG_PKL_Type__c = '05';
     	maleta1.R2_BAG_MSDT_Incident__c = inci.id;
        lst_maletas.add(maleta1);
        
        Test.startTest();
        insert lst_maletas;
        lst_maletas[0].R2_BAG_PKL_Type__c = '03';
        update lst_maletas;
        System.assertEquals('03', lst_maletas[0].R2_BAG_PKL_Type__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R2_CLS_BaggageTriggerMethods.asignarImporteMaleta(null);
    }

}