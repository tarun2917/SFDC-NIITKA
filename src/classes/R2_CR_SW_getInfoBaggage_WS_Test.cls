/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:       Clase de test que prueba la clase: R2_CR_SW_getInfoBaggage_WS       

    History: 
     <Date>                     <Author>                         <Change Description>
    26/02/2018              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

@istest
private class R2_CR_SW_getInfoBaggage_WS_Test {
    
    static testMethod void rellenarWO_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        
        String pirNumber = 'BCNIB71421';
        String reqcode = '';
        String fechaInc = '2018-01-03 00:00:00';
        String fechaValida = '';
        String cod_ama = '';
        String giftCodeId = '';
       // R2_Work_Order__c workO;
        
         //   R2_CLS_GiftCard.WPCreateGiftCardWeb_Response resp, 
          //  List<R2_Baggage__c> lstMaletas, 
           

                
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '124';
        insert workO;
        
		test.startTest();
		//R2_CR_SW_getInfoBaggage_WS.rellenarWO(fechaValida, cod_ama, giftCodeId, workO, resp, lstMaletas, pirNumber, reqcode, fechaInc);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
	static testMethod void createCase_Test() {
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='webSustitucion';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'ES';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'DNI';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'M';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        Account acc = new Account();
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.FirstName = 'test';
        acc.LastName = 'test';
        acc.R1_ACC_TXT_Identification_number__c = '44555666';
        insert acc;
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
        insert inci;
        
        R2_CS_Baggage__c cs_bag = new R2_CS_Baggage__c();
        cs_bag.Name = '01&Defecto';
        cs_bag.R2_DIV_estimated_amount__c = 100.00;
        insert cs_bag;
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        
        
        List<R2_Baggage__c> lstmale = [SELECT id,Name FROM R2_Baggage__c where id =: male.Id];
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = cs_bag.R2_DIV_estimated_amount__c ;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_OT__c = '006';
        workO.R2_WO_TXT_PIR__c = 'test';
       
                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseIT_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'IT';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'CIF';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '125';

                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseDE_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'DE';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'Desconocido';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
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
        workO.R2_WO_TXT_OT__c = '126';

                
        test.startTest();
        insert workO;
       // List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseFR_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'FR';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'C. conducir Noruega';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '127';
                
        test.startTest();
        insert workO;
       // List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseRU_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'RU';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'Tarjeta residente';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '129';

        test.startTest();
        insert workO;
       // List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCasePT_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'PT';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'NIF';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '121';

                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseCT_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'CT';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = '99Desconocido';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
     
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '122';

                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseCarnetDiplomatico_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = '';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'CT';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'Carnet Diplomatico';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
        insert inci;
        
        R2_Baggage__c male = new R2_Baggage__c();
        male.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male.R2_BAG_PKL_Type__c = '01';
        male.R2_BAG_DIV_Estimated_amount__c = 60.0;
        male.R2_BAG_PKL_Colour__c = 'BU';
        male.R2_BAG_MSDT_Incident__c = inci.id;
        male.R2_BAG_TXT_Brand_Info__c = 'test';
        male.R2_BAG_TXT_Trademark__c = 'ss';
        insert male;
        
        List<R2_Baggage__c> lstmale = [SELECT id, Name, R2_BAG_DIV_Estimated_amount__c, R2_BAG_NUMA_Amazon_Request_Id__c FROM R2_Baggage__c where id =: male.Id];
        reqcode = lstmale[0].Name;
        String numAmazon = String.valueOf(lstmale[0].R2_BAG_NUMA_Amazon_Request_Id__c);
        String valor = String.valueOf(lstmale[0].R2_BAG_DIV_Estimated_amount__c);
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String val = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '100';
               
        test.startTest();
        //insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(fechaInc).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseCI_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'EE';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'CI';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '156';

                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(listWO[0].R2_WO_DATH_GiftCard_Expiracion__c).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCaseDNI_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'EE';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'DNI (12 Digitos)';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '178';
                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(listWO[0].R2_WO_DATH_GiftCard_Expiracion__c).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCasePasaporte_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'EE';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'Pasaporte';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '000';
                
        test.startTest();
        insert workO;
        List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        List<String> ExpirationDate = String.valueof(listWO[0].R2_WO_DATH_GiftCard_Expiracion__c).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void createCasePO_Test() {
        R1_CLS_LogHelper.throw_exception = false;
 
        String pirNumber = 'BCNIB71421';
        String fechaInc = '2018-01-03 00:00:00';
        String reqcode ;
        String lengua = 'PO';
        String email = 'test@test.com';
        String docnum = '44555666';
        String docty = 'DNI AR';
        String apell1 = 'test';
        String nombre = 'test';
        String genero = 'Mujer';
        String apell2 = '';
        String reminder = 'True';
        String numIberiaPlus = '';
        String telfpais = '34';
        String telfnum = '111111';
     
        
        Case caso = new Case();
        insert caso;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        inci.R2_INC_EMA_email_web__c = email;
        inci.R2_INC_LOO_Case__c = caso.id;
       
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
        reqcode = lstmale[0].Name;
        
        R2_Work_Order__c workO = new R2_Work_Order__c();
        workO.R2_WO_DATH_GiftCard_Expiracion__c = Date.valueOf(fechaInc);
        workO.R2_WO_PKL_status__c = '0';
        workO.R2_WO_NUM_Amount_tot__c = 60;
        String valor = String.Valueof(workO.R2_WO_NUM_Amount_tot__c);
        workO.R2_WO_TXT_PIR__c = pirNumber;
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_PKL_type__c = 'Amazon';
        workO.R2_WO_TXT_Bags__c = reqcode;
        workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
        workO.R2_WO_TXT_AmazonId__c = 'test';
        workO.R2_WO_TXT_PIR__c = 'test';
        workO.R2_WO_TXT_OT__c = '009';
                
        test.startTest();
        insert workO;
        //List<R2_Work_Order__c> listWO = [SELECT ID, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c WHERE ID =: workO.id LIMIT 1];
        //List<String> ExpirationDate = String.valueof(listWO[0].R2_WO_DATH_GiftCard_Expiracion__c).split(' ');
		R2_CR_SW_getInfoBaggage_WS.createCase(pirNumber, fechaInc, numIberiaPlus, reminder, genero, nombre, apell1, apell2, docty, docnum, email, telfpais, telfnum, lengua, reqcode);
		//R2_CR_SW_getInfoBaggage_WS.crearFecha(ExpirationDate);
        test.stopTest();
          
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
	}
    static testMethod void tipo02_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;

        
        R2_Baggage__c male2 = new R2_Baggage__c();
        male2.R2_BAG_TXT_Ticket_number__c = 'IB0002';
        male2.R2_BAG_PKL_Type__c = '03';
        male2.R2_BAG_PKL_Colour__c = 'BU';
        male2.R2_BAG_MSDT_Incident__c = inci.id;
        male2.R2_BAG_TXT_Brand_Info__c = 'test';
        male2.R2_BAG_TXT_Trademark__c = 'ss';
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male2.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

	}
    static testMethod void tipo04_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;

        
        R2_Baggage__c male4 = new R2_Baggage__c();
        male4.R2_BAG_TXT_Ticket_number__c = 'IB0004';
        male4.R2_BAG_PKL_Type__c = '05';
        male4.R2_BAG_PKL_Colour__c = 'BU';
        male4.R2_BAG_MSDT_Incident__c = inci.id;
        male4.R2_BAG_TXT_Brand_Info__c = 'test';
        male4.R2_BAG_TXT_Trademark__c = 'ss';
        
		test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male4.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
    static testMethod void tipo05_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    
        R2_Baggage__c male5 = new R2_Baggage__c();
        male5.R2_BAG_TXT_Ticket_number__c = 'IB0005';
        male5.R2_BAG_PKL_Type__c = '06';
        male5.R2_BAG_PKL_Colour__c = 'BU';
        male5.R2_BAG_MSDT_Incident__c = inci.id;
        male5.R2_BAG_TXT_Brand_Info__c = 'test';
        male5.R2_BAG_TXT_Trademark__c = 'ss';
        
		test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male5.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void tipo06_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    
        R2_Baggage__c male6 = new R2_Baggage__c();
        male6.R2_BAG_TXT_Ticket_number__c = 'IB0006';
        male6.R2_BAG_PKL_Type__c = '07';
        male6.R2_BAG_PKL_Colour__c = 'BU';
        male6.R2_BAG_MSDT_Incident__c = inci.id;
        male6.R2_BAG_TXT_Brand_Info__c = 'test';
        male6.R2_BAG_TXT_Trademark__c = 'ss';
        insert male6;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male6.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
        
    }
    static testMethod void tipo07_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    
        R2_Baggage__c male7 = new R2_Baggage__c();
        male7.R2_BAG_TXT_Ticket_number__c = 'IB0007';
        male7.R2_BAG_PKL_Type__c = '08';
        male7.R2_BAG_PKL_Colour__c = 'BU';
        male7.R2_BAG_MSDT_Incident__c = inci.id;
        male7.R2_BAG_TXT_Brand_Info__c = 'test';
        male7.R2_BAG_TXT_Trademark__c = 'ss';
        insert male7;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male7.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
        
    }
    static testMethod void tipo08_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    
        R2_Baggage__c male8 = new R2_Baggage__c();
        male8.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male8.R2_BAG_PKL_Type__c = '09';
        male8.R2_BAG_PKL_Colour__c = 'BU';
        male8.R2_BAG_MSDT_Incident__c = inci.id;
        male8.R2_BAG_TXT_Brand_Info__c = 'test';
        male8.R2_BAG_TXT_Trademark__c = 'ss';
        insert male8;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male8.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo09_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male9 = new R2_Baggage__c();
        male9.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male9.R2_BAG_PKL_Type__c = '10';
        male9.R2_BAG_PKL_Colour__c = 'BU';
        male9.R2_BAG_MSDT_Incident__c = inci.id;
        male9.R2_BAG_TXT_Brand_Info__c = 'test';
        male9.R2_BAG_TXT_Trademark__c = 'ss';
        insert male9;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male9.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo10_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male10 = new R2_Baggage__c();
        male10.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male10.R2_BAG_PKL_Type__c = '12';
        male10.R2_BAG_PKL_Colour__c = 'BU';
        male10.R2_BAG_MSDT_Incident__c = inci.id;
        male10.R2_BAG_TXT_Brand_Info__c = 'test';
        male10.R2_BAG_TXT_Trademark__c = 'ss';
        insert male10;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male10.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo11_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male11 = new R2_Baggage__c();
        male11.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male11.R2_BAG_PKL_Type__c = '20';
        male11.R2_BAG_PKL_Colour__c = 'BU';
        male11.R2_BAG_MSDT_Incident__c = inci.id;
        male11.R2_BAG_TXT_Brand_Info__c = 'test';
        male11.R2_BAG_TXT_Trademark__c = 'ss';
        insert male11;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male11.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo12_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male12 = new R2_Baggage__c();
        male12.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male12.R2_BAG_PKL_Type__c = '22';
        male12.R2_BAG_PKL_Colour__c = 'BU';
        male12.R2_BAG_MSDT_Incident__c = inci.id;
        male12.R2_BAG_TXT_Brand_Info__c = 'test';
        male12.R2_BAG_TXT_Trademark__c = 'ss';
        insert male12;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male12.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo13_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male13 = new R2_Baggage__c();
        male13.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male13.R2_BAG_PKL_Type__c = '22D';
        male13.R2_BAG_PKL_Colour__c = 'BU';
        male13.R2_BAG_MSDT_Incident__c = inci.id;
        male13.R2_BAG_TXT_Brand_Info__c = 'test';
        male13.R2_BAG_TXT_Trademark__c = 'ss';
        insert male13;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male13.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo14_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male14 = new R2_Baggage__c();
        male14.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male14.R2_BAG_PKL_Type__c = '22R';
        male14.R2_BAG_PKL_Colour__c = 'BU';
        male14.R2_BAG_MSDT_Incident__c = inci.id;
        male14.R2_BAG_TXT_Brand_Info__c = 'test';
        male14.R2_BAG_TXT_Trademark__c = 'ss';
        insert male14;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male14.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
     static testMethod void tipo15_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male15 = new R2_Baggage__c();
        male15.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male15.R2_BAG_PKL_Type__c = '23';
        male15.R2_BAG_PKL_Colour__c = 'BU';
        male15.R2_BAG_MSDT_Incident__c = inci.id;
        male15.R2_BAG_TXT_Brand_Info__c = 'test';
        male15.R2_BAG_TXT_Trademark__c = 'ss';
        insert male15;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male15.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo16_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male16 = new R2_Baggage__c();
        male16.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male16.R2_BAG_PKL_Type__c = '25';
        male16.R2_BAG_PKL_Colour__c = 'BU';
        male16.R2_BAG_MSDT_Incident__c = inci.id;
        male16.R2_BAG_TXT_Brand_Info__c = 'test';
        male16.R2_BAG_TXT_Trademark__c = 'ss';
        insert male16;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male16.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo17_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male17 = new R2_Baggage__c();
        male17.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male17.R2_BAG_PKL_Type__c = '26';
        male17.R2_BAG_PKL_Colour__c = 'BU';
        male17.R2_BAG_MSDT_Incident__c = inci.id;
        male17.R2_BAG_TXT_Brand_Info__c = 'test';
        male17.R2_BAG_TXT_Trademark__c = 'ss';
        insert male17;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male17.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo18_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male18 = new R2_Baggage__c();
        male18.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male18.R2_BAG_PKL_Type__c = '27';
        male18.R2_BAG_PKL_Colour__c = 'BU';
        male18.R2_BAG_MSDT_Incident__c = inci.id;
        male18.R2_BAG_TXT_Brand_Info__c = 'test';
        male18.R2_BAG_TXT_Trademark__c = 'ss';
        insert male18;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male18.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo19_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male19 = new R2_Baggage__c();
        male19.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male19.R2_BAG_PKL_Type__c = '28';
        male19.R2_BAG_PKL_Colour__c = 'BU';
        male19.R2_BAG_MSDT_Incident__c = inci.id;
        male19.R2_BAG_TXT_Brand_Info__c = 'test';
        male19.R2_BAG_TXT_Trademark__c = 'ss';
        insert male19;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male19.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo20_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male20 = new R2_Baggage__c();
        male20.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male20.R2_BAG_PKL_Type__c = '29';
        male20.R2_BAG_PKL_Colour__c = 'BU';
        male20.R2_BAG_MSDT_Incident__c = inci.id;
        male20.R2_BAG_TXT_Brand_Info__c = 'test';
        male20.R2_BAG_TXT_Trademark__c = 'ss';
        insert male20;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male20.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo21_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male21 = new R2_Baggage__c();
        male21.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male21.R2_BAG_PKL_Type__c = '50';
        male21.R2_BAG_PKL_Colour__c = 'BU';
        male21.R2_BAG_MSDT_Incident__c = inci.id;
        male21.R2_BAG_TXT_Brand_Info__c = 'test';
        male21.R2_BAG_TXT_Trademark__c = 'ss';
        insert male21;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male21.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo22_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male22 = new R2_Baggage__c();
        male22.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male22.R2_BAG_PKL_Type__c = '51';
        male22.R2_BAG_PKL_Colour__c = 'BU';
        male22.R2_BAG_MSDT_Incident__c = inci.id;
        male22.R2_BAG_TXT_Brand_Info__c = 'test';
        male22.R2_BAG_TXT_Trademark__c = 'ss';
        insert male22;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male22.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo23_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male23 = new R2_Baggage__c();
        male23.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male23.R2_BAG_PKL_Type__c = '52';
        male23.R2_BAG_PKL_Colour__c = 'BU';
        male23.R2_BAG_MSDT_Incident__c = inci.id;
        male23.R2_BAG_TXT_Brand_Info__c = 'test';
        male23.R2_BAG_TXT_Trademark__c = 'ss';
        insert male23;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male23.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo24_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male24 = new R2_Baggage__c();
        male24.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male24.R2_BAG_PKL_Type__c = '53';
        male24.R2_BAG_PKL_Colour__c = 'BU';
        male24.R2_BAG_MSDT_Incident__c = inci.id;
        male24.R2_BAG_TXT_Brand_Info__c = 'test';
        male24.R2_BAG_TXT_Trademark__c = 'ss';
        insert male24;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male24.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo25_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male25 = new R2_Baggage__c();
        male25.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male25.R2_BAG_PKL_Type__c = '54';
        male25.R2_BAG_PKL_Colour__c = 'BU';
        male25.R2_BAG_MSDT_Incident__c = inci.id;
        male25.R2_BAG_TXT_Brand_Info__c = 'test';
        male25.R2_BAG_TXT_Trademark__c = 'ss';
        insert male25;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male25.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo26_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male26 = new R2_Baggage__c();
        male26.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male26.R2_BAG_PKL_Type__c = '55';
        male26.R2_BAG_PKL_Colour__c = 'BU';
        male26.R2_BAG_MSDT_Incident__c = inci.id;
        male26.R2_BAG_TXT_Brand_Info__c = 'test';
        male26.R2_BAG_TXT_Trademark__c = 'ss';
        insert male26;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male26.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo27_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
    	R2_Baggage__c male27 = new R2_Baggage__c();
        male27.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male27.R2_BAG_PKL_Type__c = '56';
        male27.R2_BAG_PKL_Colour__c = 'BU';
        male27.R2_BAG_MSDT_Incident__c = inci.id;
        male27.R2_BAG_TXT_Brand_Info__c = 'test';
        male27.R2_BAG_TXT_Trademark__c = 'ss';
        insert male27;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male27.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo28_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male28 = new R2_Baggage__c();
        male28.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male28.R2_BAG_PKL_Type__c = '57';
        male28.R2_BAG_PKL_Colour__c = 'BU';
        male28.R2_BAG_MSDT_Incident__c = inci.id;
        male28.R2_BAG_TXT_Brand_Info__c = 'test';
        male28.R2_BAG_TXT_Trademark__c = 'ss';
        insert male28;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male28.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo29_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
         R2_Baggage__c male29 = new R2_Baggage__c();
        male29.R2_BAG_TXT_Ticket_number__c = 'IB0029';
        male29.R2_BAG_PKL_Type__c = '58';
        male29.R2_BAG_PKL_Colour__c = 'BU';
        male29.R2_BAG_MSDT_Incident__c = inci.id;
        male29.R2_BAG_TXT_Brand_Info__c = 'test';
        male29.R2_BAG_TXT_Trademark__c = 'ss';
        insert male29;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male29.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo30_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male30 = new R2_Baggage__c();
        male30.R2_BAG_TXT_Ticket_number__c = 'IB0030';
        male30.R2_BAG_PKL_Type__c = '59';
        male30.R2_BAG_PKL_Colour__c = 'BU';
        male30.R2_BAG_MSDT_Incident__c = inci.id;
        male30.R2_BAG_TXT_Brand_Info__c = 'test';
        male30.R2_BAG_TXT_Trademark__c = 'ss';
        insert male30;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male30.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo31_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male31 = new R2_Baggage__c();
        male31.R2_BAG_TXT_Ticket_number__c = 'IB0031';
        male31.R2_BAG_PKL_Type__c = '60';
        male31.R2_BAG_PKL_Colour__c = 'BU';
        male31.R2_BAG_MSDT_Incident__c = inci.id;
        male31.R2_BAG_TXT_Brand_Info__c = 'test';
        male31.R2_BAG_TXT_Trademark__c = 'ss';
        insert male31;
        
        R2_CR_SW_getInfoBaggage_WS.tipo(male31.R2_BAG_PKL_Type__c);

        
    }
    static testMethod void tipo32_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male32 = new R2_Baggage__c();
        male32.R2_BAG_TXT_Ticket_number__c = 'IB0032';
        male32.R2_BAG_PKL_Type__c = '61';
        male32.R2_BAG_PKL_Colour__c = 'BU';
        male32.R2_BAG_MSDT_Incident__c = inci.id;
        male32.R2_BAG_TXT_Brand_Info__c = 'test';
        male32.R2_BAG_TXT_Trademark__c = 'ss';
        insert male32;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male32.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
    }
    static testMethod void tipo33_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male33 = new R2_Baggage__c();
        male33.R2_BAG_TXT_Ticket_number__c = 'IB0033';
        male33.R2_BAG_PKL_Type__c = '62';
        male33.R2_BAG_PKL_Colour__c = 'BU';
        male33.R2_BAG_MSDT_Incident__c = inci.id;
        male33.R2_BAG_TXT_Brand_Info__c = 'test';
        male33.R2_BAG_TXT_Trademark__c = 'ss';
        insert male33;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male33.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo34_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male34 = new R2_Baggage__c();
        male34.R2_BAG_TXT_Ticket_number__c = 'IB0034';
        male34.R2_BAG_PKL_Type__c = '63';
        male34.R2_BAG_PKL_Colour__c = 'BU';
        male34.R2_BAG_MSDT_Incident__c = inci.id;
        male34.R2_BAG_TXT_Brand_Info__c = 'test';
        male34.R2_BAG_TXT_Trademark__c = 'ss';
        insert male34;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male34.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo35_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male35 = new R2_Baggage__c();
        male35.R2_BAG_TXT_Ticket_number__c = 'IB0035';
        male35.R2_BAG_PKL_Type__c = '64';
        male35.R2_BAG_PKL_Colour__c = 'BU';
        male35.R2_BAG_MSDT_Incident__c = inci.id;
        male35.R2_BAG_TXT_Brand_Info__c = 'test';
        male35.R2_BAG_TXT_Trademark__c = 'ss';
        insert male35;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male35.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo36_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male36 = new R2_Baggage__c();
        male36.R2_BAG_TXT_Ticket_number__c = 'IB0036';
        male36.R2_BAG_PKL_Type__c = '65';
        male36.R2_BAG_PKL_Colour__c = 'BU';
        male36.R2_BAG_MSDT_Incident__c = inci.id;
        male36.R2_BAG_TXT_Brand_Info__c = 'test';
        male36.R2_BAG_TXT_Trademark__c = 'ss';
        insert male36;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male36.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo37_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male37 = new R2_Baggage__c();
        male37.R2_BAG_TXT_Ticket_number__c = 'IB0037';
        male37.R2_BAG_PKL_Type__c = '66';
        male37.R2_BAG_PKL_Colour__c = 'BU';
        male37.R2_BAG_MSDT_Incident__c = inci.id;
        male37.R2_BAG_TXT_Brand_Info__c = 'test';
        male37.R2_BAG_TXT_Trademark__c = 'ss';
        insert male37;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male37.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo38_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male38 = new R2_Baggage__c();
        male38.R2_BAG_TXT_Ticket_number__c = 'IB0038';
        male38.R2_BAG_PKL_Type__c = '67';
        male38.R2_BAG_PKL_Colour__c = 'BU';
        male38.R2_BAG_MSDT_Incident__c = inci.id;
        male38.R2_BAG_TXT_Brand_Info__c = 'test';
        male38.R2_BAG_TXT_Trademark__c = 'ss';
        insert male38;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male38.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
     static testMethod void tipo39_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male39 = new R2_Baggage__c();
        male39.R2_BAG_TXT_Ticket_number__c = 'IB0039';
        male39.R2_BAG_PKL_Type__c = '68';
        male39.R2_BAG_PKL_Colour__c = 'BU';
        male39.R2_BAG_MSDT_Incident__c = inci.id;
        male39.R2_BAG_TXT_Brand_Info__c = 'test';
        male39.R2_BAG_TXT_Trademark__c = 'ss';
        insert male39;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male39.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo40_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male40 = new R2_Baggage__c();
        male40.R2_BAG_TXT_Ticket_number__c = 'IB0040';
        male40.R2_BAG_PKL_Type__c = '69';
        male40.R2_BAG_PKL_Colour__c = 'BU';
        male40.R2_BAG_MSDT_Incident__c = inci.id;
        male40.R2_BAG_TXT_Brand_Info__c = 'test';
        male40.R2_BAG_TXT_Trademark__c = 'ss';
        insert male40;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male40.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    	
    static testMethod void tipo41_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male41 = new R2_Baggage__c();
        male41.R2_BAG_TXT_Ticket_number__c = 'IB0041';
        male41.R2_BAG_PKL_Type__c = '71';
        male41.R2_BAG_PKL_Colour__c = 'BU';
        male41.R2_BAG_MSDT_Incident__c = inci.id;
        male41.R2_BAG_TXT_Brand_Info__c = 'test';
        male41.R2_BAG_TXT_Trademark__c = 'ss';
        insert male41;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male41.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo42_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male42 = new R2_Baggage__c();
        male42.R2_BAG_TXT_Ticket_number__c = 'IB0042';
        male42.R2_BAG_PKL_Type__c = '72';
        male42.R2_BAG_PKL_Colour__c = 'BU';
        male42.R2_BAG_MSDT_Incident__c = inci.id;
        male42.R2_BAG_TXT_Brand_Info__c = 'test';
        male42.R2_BAG_TXT_Trademark__c = 'ss';
        insert male42;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male42.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo43_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male43 = new R2_Baggage__c();
        male43.R2_BAG_TXT_Ticket_number__c = 'IB0043';
        male43.R2_BAG_PKL_Type__c = '73';
        male43.R2_BAG_PKL_Colour__c = 'BU';
        male43.R2_BAG_MSDT_Incident__c = inci.id;
        male43.R2_BAG_TXT_Brand_Info__c = 'test';
        male43.R2_BAG_TXT_Trademark__c = 'ss';
        insert male43;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male43.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo44_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male44 = new R2_Baggage__c();
        male44.R2_BAG_TXT_Ticket_number__c = 'IB0044';
        male44.R2_BAG_PKL_Type__c = '74';
        male44.R2_BAG_PKL_Colour__c = 'BU';
        male44.R2_BAG_MSDT_Incident__c = inci.id;
        male44.R2_BAG_TXT_Brand_Info__c = 'test';
        male44.R2_BAG_TXT_Trademark__c = 'ss';
        insert male44;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male44.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo45_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male45 = new R2_Baggage__c();
        male45.R2_BAG_TXT_Ticket_number__c = 'IB0045';
        male45.R2_BAG_PKL_Type__c = '75';
        male45.R2_BAG_PKL_Colour__c = 'BU';
        male45.R2_BAG_MSDT_Incident__c = inci.id;
        male45.R2_BAG_TXT_Brand_Info__c = 'test';
        male45.R2_BAG_TXT_Trademark__c = 'ss';
        insert male45;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male45.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    
    static testMethod void tipo46_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male46 = new R2_Baggage__c();
        male46.R2_BAG_TXT_Ticket_number__c = 'IB0046';
        male46.R2_BAG_PKL_Type__c = '81';
        male46.R2_BAG_PKL_Colour__c = 'BU';
        male46.R2_BAG_MSDT_Incident__c = inci.id;
        male46.R2_BAG_TXT_Brand_Info__c = 'test';
        male46.R2_BAG_TXT_Trademark__c = 'ss';
        insert male46;
        
        test.startTest();
       R2_CR_SW_getInfoBaggage_WS.tipo(male46.R2_BAG_PKL_Type__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo47_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male47 = new R2_Baggage__c();
        male47.R2_BAG_TXT_Ticket_number__c = 'IB0047';
        male47.R2_BAG_PKL_Type__c = '82';
        male47.R2_BAG_PKL_Colour__c = 'BE';
        male47.R2_BAG_MSDT_Incident__c = inci.id;
        male47.R2_BAG_TXT_Brand_Info__c = 'test';
        male47.R2_BAG_TXT_Trademark__c = 'ss';
        insert male47;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male47.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male47.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
       
    }
    static testMethod void tipo48_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male48 = new R2_Baggage__c();
        male48.R2_BAG_TXT_Ticket_number__c = 'IB0048';
        male48.R2_BAG_PKL_Type__c = '83';
        male48.R2_BAG_PKL_Colour__c = 'YW';
        male48.R2_BAG_MSDT_Incident__c = inci.id;
        male48.R2_BAG_TXT_Brand_Info__c = 'test';
        male48.R2_BAG_TXT_Trademark__c = 'ss';
        insert male48;
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male48.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male48.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
       
    }
    static testMethod void tipo49_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male49 = new R2_Baggage__c();
        male49.R2_BAG_TXT_Ticket_number__c = 'IB0049';
        male49.R2_BAG_PKL_Type__c = '85';
        male49.R2_BAG_PKL_Colour__c = 'WT';
        male49.R2_BAG_MSDT_Incident__c = inci.id;
        male49.R2_BAG_TXT_Brand_Info__c = 'test';
        male49.R2_BAG_TXT_Trademark__c = 'ss';
        insert male49;
        
       test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male49.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male49.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    
    static testMethod void tipo50_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male50 = new R2_Baggage__c();
        male50.R2_BAG_TXT_Ticket_number__c = 'IB0050';
        male50.R2_BAG_PKL_Type__c = '89';
        male50.R2_BAG_PKL_Colour__c = 'RD';
        male50.R2_BAG_MSDT_Incident__c = inci.id;
        male50.R2_BAG_TXT_Brand_Info__c = 'test';
        male50.R2_BAG_TXT_Trademark__c = 'ss';
        insert male50;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male50.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male50.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo51_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male51 = new R2_Baggage__c();
        male51.R2_BAG_TXT_Ticket_number__c = 'IB0051';
        male51.R2_BAG_PKL_Type__c = '90';
        male51.R2_BAG_PKL_Colour__c = 'PU';
        male51.R2_BAG_MSDT_Incident__c = inci.id;
        male51.R2_BAG_TXT_Brand_Info__c = 'test';
        male51.R2_BAG_TXT_Trademark__c = 'ss';
        insert male51;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male51.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male51.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
     static testMethod void tipo52_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male52 = new R2_Baggage__c();
        male52.R2_BAG_TXT_Ticket_number__c = 'IB0052';
        male52.R2_BAG_PKL_Type__c = '92';
        male52.R2_BAG_PKL_Colour__c = 'PR';
        male52.R2_BAG_MSDT_Incident__c = inci.id;
        male52.R2_BAG_TXT_Brand_Info__c = 'test';
        male52.R2_BAG_TXT_Trademark__c = 'ss';
        insert male52;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male52.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male52.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo53_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male53 = new R2_Baggage__c();
        male53.R2_BAG_TXT_Ticket_number__c = 'IB0053';
        male53.R2_BAG_PKL_Type__c = '93';
        male53.R2_BAG_PKL_Colour__c = 'PR';
        male53.R2_BAG_MSDT_Incident__c = inci.id;
        male53.R2_BAG_TXT_Brand_Info__c = 'test';
        male53.R2_BAG_TXT_Trademark__c = 'ss';
        insert male53;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male53.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male53.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo54_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male54 = new R2_Baggage__c();
        male54.R2_BAG_TXT_Ticket_number__c = 'IB0054';
        male54.R2_BAG_PKL_Type__c = '94';
        male54.R2_BAG_PKL_Colour__c = 'MC';
        male54.R2_BAG_MSDT_Incident__c = inci.id;
        male54.R2_BAG_TXT_Brand_Info__c = 'test';
        male54.R2_BAG_TXT_Trademark__c = 'ss';
        insert male54;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male54.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male54.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo55_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male55 = new R2_Baggage__c();
        male55.R2_BAG_TXT_Ticket_number__c = 'IB0055';
        male55.R2_BAG_PKL_Type__c = '95';
        male55.R2_BAG_PKL_Colour__c = 'GY';
        male55.R2_BAG_MSDT_Incident__c = inci.id;
        male55.R2_BAG_TXT_Brand_Info__c = 'test';
        male55.R2_BAG_TXT_Trademark__c = 'ss';
        insert male55;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male55.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male55.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo56_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        R2_Baggage__c male56 = new R2_Baggage__c();
        male56.R2_BAG_TXT_Ticket_number__c = 'IB0056';
        male56.R2_BAG_PKL_Type__c = '96';
        male56.R2_BAG_PKL_Colour__c = 'GN';
        male56.R2_BAG_MSDT_Incident__c = inci.id;
        male56.R2_BAG_TXT_Brand_Info__c = 'test';
        male56.R2_BAG_TXT_Trademark__c = 'ss';

        insert male56;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male56.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male56.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);


       
    }
    static testMethod void tipo57_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        
		R2_Baggage__c male57 = new R2_Baggage__c();
        male57.R2_BAG_TXT_Ticket_number__c = 'IB0057';
        male57.R2_BAG_PKL_Type__c = '97';
        male57.R2_BAG_PKL_Colour__c = 'BU';
        male57.R2_BAG_MSDT_Incident__c = inci.id;
        male57.R2_BAG_TXT_Brand_Info__c = 'test';
        male57.R2_BAG_TXT_Trademark__c = 'ss';
        insert male57;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male57.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male57.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
       

       
    }
    static testMethod void tipo58_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        
		R2_Baggage__c male58 = new R2_Baggage__c();
        male58.R2_BAG_TXT_Ticket_number__c = 'IB0058';
        male58.R2_BAG_PKL_Type__c = '98';
        male58.R2_BAG_PKL_Colour__c = 'BN';
        male58.R2_BAG_MSDT_Incident__c = inci.id;
        male58.R2_BAG_TXT_Brand_Info__c = 'test';
        male58.R2_BAG_TXT_Trademark__c = 'ss';
        insert male58;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male58.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male58.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

       
    }
    static testMethod void tipo59_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
    
        
		R2_Baggage__c male59 = new R2_Baggage__c();
        male59.R2_BAG_TXT_Ticket_number__c = 'IB0059';
        male59.R2_BAG_PKL_Type__c = '99';
        male59.R2_BAG_PKL_Colour__c = 'BK';
        male59.R2_BAG_MSDT_Incident__c = inci.id;
        male59.R2_BAG_TXT_Brand_Info__c = 'test';
        male59.R2_BAG_TXT_Trademark__c = 'ss';
        insert male59;
        
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male59.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male59.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);


    }
   
    static testMethod void tipo01_Test(){
         Id recordTypeId = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c inci = new R1_Incident__c();
        inci.R2_INC_TXT_II_Passenger_name__c = 'test';
        inci.RecordTypeId = recordTypeId;
        inci.R2_INC_TXT_PIR_Station_Code__c  = 'BCN';
        inci.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        inci.R2_INC_TXT_PIR_Reference_Number__c = '71421';
        inci.R2_INC_CHK_mail_web__c = True;
        insert inci;
        
        R2_Baggage__c male1 = new R2_Baggage__c();
        male1.R2_BAG_TXT_Ticket_number__c = 'IB0001';
        male1.R2_BAG_PKL_Type__c = '01';
        male1.R2_BAG_PKL_Colour__c = 'BE';
        male1.R2_BAG_MSDT_Incident__c = inci.id;
        male1.R2_BAG_TXT_Brand_Info__c = 'test';
        male1.R2_BAG_TXT_Trademark__c = 'ss';
		insert male1;    
        test.startTest();
        R2_CR_SW_getInfoBaggage_WS.tipo(male1.R2_BAG_PKL_Type__c);
        R2_CR_SW_getInfoBaggage_WS.color(male1.R2_BAG_PKL_Colour__c);
        test.stopTest();
       
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

        
	}
 
    
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CR_SW_getInfoBaggage_WS.crearFecha(null);
    	R2_CR_SW_getInfoBaggage_WS.tipo(null);
        R2_CR_SW_getInfoBaggage_WS.color(null);
		R2_CR_SW_getInfoBaggage_WS.actualizarCliente(null, null, null, null, null, null, null, null, null, null, null);
    	R2_CR_SW_getInfoBaggage_WS.validacion(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

    }
}