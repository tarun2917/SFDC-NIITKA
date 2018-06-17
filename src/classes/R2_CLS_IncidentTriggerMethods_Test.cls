/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_IncidentTriggerMethods_Test {
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void rellenarExternalID_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();

        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtID;
        incidencia.R2_INC_DAT_PIR_Claims_Created_Date__c = Date.newInstance(2017, 08, 05);
        incidencia.R2_INC_TXT_PIR_PIR_incident__c = '5232';
      

      
      
        Test.startTest();
                  
        insert incidencia;
        List<R1_Incident__c> incident = [SELECT Id, R2_INC_TXT_PIR_EA_External_ID__c FROM R1_Incident__c WHERE Id = :incidencia.Id LIMIT 1];
        System.debug('Incidencia external ID ' + incident[0].R2_INC_TXT_PIR_EA_External_ID__c);
        System.assertEquals('523220170805', incident[0].R2_INC_TXT_PIR_EA_External_ID__c);
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    1/12/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void crearMotivoPreOrderSinAcc_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        
        Test.startTest();
                  
        insert incidencia;
        
        List<Case> casos = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c = :incidencia.Id];
        System.debug('Que tenemos hasta ahora? 1 ' + casos);
        //System.assertEquals(2, casos.size());
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    1/12/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void crearMotivoPreOrderConAcc_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.FirstName = 'Test';
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id; 
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        
        Test.startTest();
                  
        insert incidencia;
        
        List<Case> casos = [SELECT Id, AccountId FROM Case WHERE R1_CAS_LOO_Incidences__c = :incidencia.Id];
        System.debug('Que tenemos hasta ahora? 2 ' + casos);
        System.assertEquals(acc.Id, casos[0].AccountId);
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    21/03/2018               Ismael Yubero Moreno                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void incidentTriggerMethods_Test_1(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.FirstName = 'Test';
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id; 
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        
        Test.startTest();
                  
        insert incidencia;
        
        List<Case> casos = [SELECT Id, AccountId FROM Case WHERE R1_CAS_LOO_Incidences__c = :incidencia.Id];
        System.debug('Que tenemos hasta ahora? 2 ' + casos);
        // System.assertEquals(acc.Id, casos[0].AccountId);
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CLS_IncidentTriggerMethods.crearMotivoPreOrder(null);
        R2_CLS_IncidentTriggerMethods.rellenaExternalID(null);
    }
}