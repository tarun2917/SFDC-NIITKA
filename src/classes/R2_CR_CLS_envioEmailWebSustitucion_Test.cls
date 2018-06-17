/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    13/02/2018              Sara Torres Bermúdez                    Initial Version
    05/04/18                Alberto Puerto Collado                  Added param nombreCompleto to sendEmailWebSustitucion()
    ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R2_CR_CLS_envioEmailWebSustitucion_Test {
    
    
	static testMethod void sendEmailWebSustitucionES_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
		String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        String email;
        String valor;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03';
        pais = 'Spain';
        numIbPlus = '21344';
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<Case> lstCasos = new List<Case>();
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        lstCasos.add(caso);
        
        email = 'test@test.com';
        valor = '60';
        String lengua = 'ES';
        String fechaValida = '2018-01-03';
        String cod_ama = '343R-"RTFC-RTEV-34RE';

        String nombreCompleto = 'Pepito Grillo';
        
        List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, String.valueof(lstinci[0].R2_INC_FOR_PIR__c) , fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
    }
    static testMethod void sendEmailWebSustitucionIT_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
		String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        String email;
        String valor;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03';
        pais = 'Spain';
        numIbPlus = '21344';
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<Case> lstCasos = new List<Case>();
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        lstCasos.add(caso);
        
        email = 'test@test.com';
        valor = '60';
        String lengua = 'IT';
        String fechaValida = '2018-01-03';
        String cod_ama = '343R-"RTFC-RTEV-34RE';

        String nombreCompleto = 'Pepito Grillo';
        
        List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, String.valueof(lstinci[0].R2_INC_FOR_PIR__c) , fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
    }
    static testMethod void sendEmailWebSustitucionDE_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
		String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        String email;
        String valor;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03';
        pais = 'Spain';
        numIbPlus = '21344';
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<Case> lstCasos = new List<Case>();
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        lstCasos.add(caso);
        
        email = 'test@test.com';
        valor = '60';
        String lengua = 'DE';
        String fechaValida = '2018-01-03';
        String cod_ama = '343R-"RTFC-RTEV-34RE';

        String nombreCompleto = 'Pepito Grillo';
        
        List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, String.valueof(lstinci[0].R2_INC_FOR_PIR__c) , fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
    }
    static testMethod void sendEmailWebSustitucionFR_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
		String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        String email;
        String valor;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03';
        pais = 'Spain';
        numIbPlus = '21344';
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<Case> lstCasos = new List<Case>();
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        lstCasos.add(caso);
        
        email = 'test@test.com';
        valor = '60';
        String lengua = 'FR';
        String fechaValida = '2018-01-03';
        String cod_ama = '343R-"RTFC-RTEV-34RE';

        String nombreCompleto = 'Pepito Grillo';
        
        List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, String.valueof(lstinci[0].R2_INC_FOR_PIR__c) , fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
    }
    static testMethod void sendEmailWebSustitucionEN_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
		String fechaInc;
        String pais;
        String numIbPlus;
        String pirNumber;
        String email;
        String valor;
        // crear la incidencia
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        R1_Incident__c inci = new R1_Incident__c();
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        insert inci;      
        fechaInc = '2018-01-03';
        pais = 'Spain';
        numIbPlus = '21344';
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<Case> lstCasos = new List<Case>();
        Case caso = new Case();
        caso.R1_CAS_LOO_Incidences__c = inci.id;
        insert caso;
        lstCasos.add(caso);
        
        inci.R2_INC_LOO_Case__c = caso.id;
        update inci;
        
        email = 'test@test.com';
        valor = '60';
        String lengua = 'EN';
        String fechaValida = '2018-01-03';
        String cod_ama = '343R-"RTFC-RTEV-34RE';

        String nombreCompleto = 'Pepito Grillo';
        
        List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE id =: inci.id LIMIT 1];
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, String.valueof(lstinci[0].R2_INC_FOR_PIR__c) , fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
    }
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(null, null, null, null, null, null, null, null, null, null);
        
    }
}