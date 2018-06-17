/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:       Clase de test que prueba la clase: R2_CR_SW_getInfoIncidenciaPIR_WS       

    History: 
     <Date>                     <Author>                         <Change Description>
    26/02/2018              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/


@istest
private class R2_CR_SW_getInfoIncidenciaPIR_WS_Test {
    
    static testMethod void createCase_Test() {
        
        R1_CLS_LogHelper.throw_exception = false;
       
        String fechaInc = '2018-01-03 00:00:00';
        String pais = 'Spain';
        String numIbPlus = '21344';
        String pirNumber = '';
        
    	test.startTest();
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(pirNumber, fechaInc, pais, numIbPlus);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void createCaseError005_Test() {
        R1_CLS_LogHelper.throw_exception = false;

		String fechaInc;
        String pais;
        String numIbPlus;
        
		Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();

        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'XX';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;    
        fechaInc = '2018-01-03 00:00:00';
        pais = 'Spain';
        numIbPlus = '21344';
        
        test.startTest();
		List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(lstinci[0].R2_INC_FOR_PIR__c, fechaInc, pais, numIbPlus);
        test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void createCaseFaltaCampoObligatorio_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        // crear la incidencia
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();

        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03 00:00:00';
        pais = 'Spain';
        numIbPlus = '21344';
        
        test.startTest();
		List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(lstinci[0].R2_INC_FOR_PIR__c, fechaInc, pais, numIbPlus);
        test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }static testMethod void createCaseSinMaletaEnWT_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber = 'MADIB00003';

        fechaInc = '2018-01-03 00:00:00';
        pais = 'Spain';
        numIbPlus = '2111';
        
        test.startTest();
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(pirNumber, fechaInc, pais, numIbPlus);
        test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void createCaseSinMaleta_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
                // crear la incidencia
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();

        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'MAD';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71426';
        insert inci;     
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<R2_Baggage__c> lstmale = [SELECT id,Name FROM R2_Baggage__c where id =: male.Id];
        String reqcode = lstmale[0].Name;
        fechaInc = '2017-02-03 00:00:00';
        pais = 'Spain';
        
        test.startTest();
		List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(lstinci[0].R2_INC_FOR_PIR__c, fechaInc, pais, numIbPlus);
        test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void createCase2_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();

        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03 00:00:00';
        pais = 'Spain';
        numIbPlus = '21344';
        
        
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        //male.R2_BAG_DIV_Estimated_amount__c = cs_bag.R2_DIV_estimated_amount__c;
        insert male;
        
        List<R2_Baggage__c> lstmale = [SELECT id,Name FROM R2_Baggage__c where id =: male.Id];
        String reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        insert workO;
        
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        
        test.startTest();
		List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(lstinci[0].R2_INC_FOR_PIR__c, fechaInc, pais, numIbPlus);
        test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
	static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CR_SW_getInfoIncidendiaPIR_WS.createCase(null, null, null, null);
    }
}