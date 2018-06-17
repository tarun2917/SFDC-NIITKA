/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Clase test de la clase R2_CLS_PaymentTriggerMethods
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    
@isTest
private class R2_CLS_CompensationTriggerMethods_Test {
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Clase test de la clase R2_CLS_PaymentTriggerMethods
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    /*static testMethod void iniciarPago_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Pagos';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Pagos';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
                
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
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
        vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest';
        vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB22342';
        insert vuelo;
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtID;
        incidencia.R2_INC_DAT_PIR_Claims_Created_Date__c = Date.newInstance(2017, 08, 05);
        incidencia.R2_INC_TXT_PIR_PIR_incident__c = '5232';
        insert incidencia;
        
        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Case casoH = new Case();
        casoH.RecordTypeId = rTEquip;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Demora';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Retraso en la entrega';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Payment_order__c orden = new R2_Payment_order__c();
        orden.R2_OPY_CHK_Urgent__c = true;
        orden.R2_OPY_CHK_Transfer__c = true;
        orden.R2_OPY_NUM_AVIOS_amount__c = 868;
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Ready';
        orden.R2_OPY_TXT_IBAN__c = '213414213';
		orden.R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
        orden.R2_OPY_TXT_Frecuent_Flyer__c = 'IB4422';
        orden.R2_OPY_TXT_Status__c = 'ENVIADO A BANCO';
        orden.R2_OPY_TXT_Account_Num__c = '667578';
        orden.R2_OPY_TXT_Bank_Name__c = 'BBVVA';
        orden.R2_OPY_TXT_Bank_Country__c = 'ES';
        orden.R2_OPY_TXT_Budget_Center__c = 'sa';
        orden.R2_OPY_TXT_Fed_ABA__c = 'asd';
        orden.R2_OPY_TXT_Chips_ABA__c = 'adsa';
        orden.R2_OPY_TXT_SWIFT__c = 'ads';
        orden.R2_OPY_TXT_City__c = 'Madrid';
        orden.R2_OPY_TXT_Province__c = 'Madrid';
        orden.R2_OPY_TXT_Postal_Code__c = '28905';
        orden.R2_OPY_TXT_Account_Type__c = 'Cuenta corriente';
        insert orden;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_Charge_account__c = '102312';
        pagos.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pagos.R2_COM_TXT_Passenger_Reason__c = 'res';
        pagos.R2_COM_DIV_Total_Amount__c = 25;
        pagos.R2_COM_NUM_Total_Amount_local__c = 25;
        pagos.R2_COM_LOO_Payment_Code__c = orden.Id;
        pagos.R2_COM_PKL_Type__c = 'Indemnización';
        pagos.R2_COM_TXT_Budgetary_center__c = 'ES';
        pagos.R2_COM_LOO_Flight__c = vuelo.Id;
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
      	        
        Test.startTest();
        insert pagos;
        
        //R2_CLS_CompensationTriggerMethods.iniciarPago(pagos.Id);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Clase test de la clase R2_CLS_PaymentTriggerMethods
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    /*static testMethod void inciarPagoNoLogin_Test(){
         R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Pagos';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaPagos';
        lst_ep.add(ep);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
         R2_CLS_CompensationTriggerMethods.initiatePayment('idPago', 1);
        Test.stopTest();
        
        System.assert(0< [SELECT count() FROM R1_Log__c]);
    }*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Clase test de la clase R2_CLS_PaymentTriggerMethods
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/  
    /*static testMethod void cancelarPagoNoLogin_Test(){
         R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Pagos';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaPagos';
        lst_ep.add(ep);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
         R2_CLS_CompensationTriggerMethods.cancelPayment('idPago', 1);
        Test.stopTest();
        
        System.assert(0< [SELECT count() FROM R1_Log__c]);
    }*/
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Clase test de la clase R2_CLS_PaymentTriggerMethods
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    /*static testMethod void cancelarPago_Test(){
        R1_CLS_LogHelper.throw_exception = false;      

 		List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name = 'cancel';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'cancel';
        lst_ep.add(ep);
        
	    R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;        
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        R2_Compensation__c pagos = new R2_Compensation__c();
      	pagos.R2_COM_DIV_Total_Amount__c = 25;
        insert pagos;
        
       
		R2_CLS_CompensationTriggerMethods.cancelarPago(pagos.Id);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }*/
	
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metod test del metodo calculaIndemnizacion()
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    06/03/2018            Alberto Puerto Collado         Added account fields to follow the Validation Rule named R1_ACC_VRU_Account_create & pago.pago02.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    
    static testMethod void calculaIndemnizacion_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.FirstName = 'Test';
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.PersonBirthdate = Date.valueOf('1982-11-16');
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
        acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567'; 
        acc.R1_ACC_TXT_Identification_number__c   = '121326565';
        acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
        acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';
        insert acc;
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest';
        vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'NumTest';
        insert vuelo;
        
        
        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Deterioro';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Case casoH = new Case();
        casoH.RecordTypeId = rTEquip;
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Deterioro';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoH;
        
        List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
        
        R2_Compensation__c pago01 = new R2_Compensation__c();
        pago01.R2_COM_DIV_Total_Amount__c = 5000;
        pago01.RecordTypeId = rtAvios; 
        pago01.R2_COM_LOO_Case__c = casoH.Id;
        pago01.R2_COM_PKL_Status__c = 'Completado';
        pago01.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
        pagos.add(pago01);
        
        R2_Compensation__c pago02 = new R2_Compensation__c();
        pago02.R2_COM_DIV_Total_Amount__c = 250;
        pago02.RecordTypeId = rtIndem; 
        pago02.R2_COM_LOO_Case__c = casoH.Id;
        pago02.R2_COM_PKL_Status__c = 'Completado';
        pago02.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
        pagos.add(pago02);      
        
        R2_Compensation__c pago04 = new R2_Compensation__c();
        pago04.R2_COM_DIV_Total_Amount__c = 250;
        pago04.RecordTypeId = rtIndem; 
        pago04.R2_COM_LOO_Case__c = casoH.Id;
        pago04.R2_COM_PKL_Status__c = 'Completado';
        pago04.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
        pagos.add(pago04);      
        
        Test.startTest();

        insert pagos;
        system.debug(pagos);

     	Case casoPadre = [SELECT Id, R2_CAS_DIV_Compensation__c, R1_CAS_NUM_Compensacion_en_Avios__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];

        System.assertEquals(500, casoPadre.R2_CAS_DIV_Compensation__c);
        System.assertEquals(5000, casoPadre.R1_CAS_NUM_Compensacion_en_Avios__c);
       
        Case casoHijo = [SELECT Id, R2_CAS_DIV_Compensation__c, R1_CAS_NUM_Compensacion_en_Avios__c FROM Case WHERE Id = :casoH.Id LIMIT 1];
        
        System.assertEquals(500, casoHijo.R2_CAS_DIV_Compensation__c);
        System.assertEquals(5000, casoHijo.R1_CAS_NUM_Compensacion_en_Avios__c);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
   	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    25/10/2017            Ruben Pingarron Jerez          Initial Version
    06/03/2018            Alberto Puerto Collado         Added account fields to follow the Validation Rule named R1_ACC_VRU_Account_create & pago.pago02.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    static testMethod void pagoToEC_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Entidad Comunicante').getRecordTypeId();
                
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.Name = 'ClientTest';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
        acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567'; 
        acc.R1_ACC_TXT_Identification_number__c   = '121326565';
        acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
        acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';
        insert acc;
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest';
        vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'NumTest';
        insert vuelo;
        
        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.R2_CAS_LOO_Claimant_Entity__c = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Deterioro';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Case casoH = new Case();
        casoH.RecordTypeId = rTEquip;
        casoH.ParentId = casoPa.Id;
        casoH.R2_CAS_LOO_Claimant_Entity__c = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Deterioro';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R2_CAS_CHK_Payment_to_EC__c = True;
        insert casoH;
        
        List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
        
        R2_Compensation__c pago01 = new R2_Compensation__c();
        pago01.R2_COM_LOO_Case__c = casoH.Id;
        pago01.RecordTypeId = rtAvios; 
        pago01.R2_COM_PKL_Status__c = 'Enviado';
        pago01.R2_COM_DIV_Total_Amount__c = 25;
        pago01.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
        pagos.add(pago01);
        
        Id re = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc2 = new Account();
        acc2.RecordTypeId = re;
        acc2.FirstName = 'Test';
        acc2.LastName = 'ClienteTest';
        acc2.PersonEmail = 'test@test.com';
        acc2.R1_ACC_PKL_Gender_description__c = 'M';
        acc2.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc2.R1_ACC_PKL_identification_Type__c = '02';
        acc2.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc2;
        
        R2_Compensation__c pago02 = new R2_Compensation__c();
        pago02.R2_COM_LOO_Account__c = acc2.Id;
        pago02.RecordTypeId = rtAvios; 
        pago02.R2_COM_LOO_Case__c = casoH.Id;
        pago02.R2_COM_PKL_Status__c = 'Enviado';
        pago02.R2_COM_DIV_Total_Amount__c = 25;
        pago02.R2_COM_TXT_Frecuent_Flyer__c = '12312321';
        pagos.add(pago02);
        
        Test.startTest();
        insert pagos;
        
        List<R2_Compensation__c> pays = [SELECT Id, R2_COM_LOO_Account__c FROM R2_Compensation__c WHERE Id IN :pagos];
        System.debug('pagoooos: ' + pays);
        System.assertEquals(acc.Id, pays[0].R2_COM_LOO_Account__c);
        System.assertEquals(acc.Id, pays[1].R2_COM_LOO_Account__c);
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    25/10/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    /*static testMethod void lanzarIniciarPago_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Pagos';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Pagos';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
                
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
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
        vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest';
        vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 08);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB22342';
        insert vuelo;
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtID;
        incidencia.R2_INC_DAT_PIR_Claims_Created_Date__c = Date.newInstance(2017, 08, 05);
        incidencia.R2_INC_TXT_PIR_PIR_incident__c = '5232';
        incidencia.R2_INC_PKL_II_Type__c = 'Asistencia por cancelación';
        insert incidencia;
        
        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Case casoH = new Case();
        casoH.RecordTypeId = rTEquip;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Demora';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Retraso en la entrega';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Payment_order__c orden = new R2_Payment_order__c();
        orden.R2_OPY_CHK_Urgent__c = true;
        orden.R2_OPY_CHK_Transfer__c = true;
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Ready';
        orden.R2_OPY_TXT_IBAN__c = '213414213';
        orden.R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
        orden.R2_OPY_TXT_Frecuent_Flyer__c = 'IB4422';
        orden.R2_OPY_TXT_Account_Num__c = '667578';
        orden.R2_OPY_TXT_Bank_Name__c = 'BBVVA';
        orden.R2_OPY_TXT_Bank_Country__c = 'ES';
        orden.R2_OPY_TXT_Budget_Center__c = 'ES';
        orden.R2_OPY_TXT_Fed_ABA__c = 'ES';
        orden.R2_OPY_TXT_Chips_ABA__c = 'ES';
        orden.R2_OPY_TXT_SWIFT__c = 'ES';
        orden.R2_OPY_TXT_City__c = 'Madrid';
        orden.R2_OPY_TXT_Province__c = 'Madrid';
        orden.R2_OPY_TXT_Postal_Code__c = '28905';
        orden.R2_OPY_TXT_Account_Type__c = 'Cuenta corriente';
        insert orden;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_Charge_account__c = '102312';
        pagos.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pagos.R2_COM_TXT_Passenger_Reason__c = 'res';
        pagos.R2_COM_DIV_Total_Amount__c = 25;
        pagos.R2_COM_NUM_Total_Amount_local__c = 25;
        pagos.R2_COM_TXT_Budgetary_center__c = 'Test';
        pagos.R2_COM_LOO_Flight__c = vuelo.Id;
        pagos.R2_COM_PKL_Type__c = 'Indemnización';
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        
        Test.startTest();
        insert pagos;
        
        List<R2_Compensation__c> pays = [SELECT Id, R2_COM_PKL_Status__c, R2_COM_LOO_Payment_Code__c FROM R2_Compensation__c WHERE Id = :pagos.Id];
        pays[0].R2_COM_LOO_Payment_Code__c = orden.Id;
        pays[0].R2_COM_PKL_Status__c = 'Enviado';
        
        update pays;
            
        System.debug('pagoooos: ' + pays);
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    } */
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    22/08/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        //R2_CLS_CompensationTriggerMethods.cancelarPago(null);
        //R2_CLS_CompensationTriggerMethods.initiatePayment(null, null);
        //R2_CLS_CompensationTriggerMethods.cancelPayment(null, null);
		R2_CLS_CompensationTriggerMethods.calculaIndemnizacion(null);
        R2_CLS_CompensationTriggerMethods.pagoToEC(null);
        // R2_CLS_CompensationTriggerMethods.lanzarIniciarPago(null);
        R2_CLS_CompensationTriggerMethods.calcularPeriodoPresupuestario(null);
        R2_CLS_CompensationTriggerMethods.filtrarPagosOrden(null, null);
        R2_CLS_CompensationTriggerMethods.sumarImportesOP(null);
        R2_CLS_CompensationTriggerMethods.calculaAmountsExpedienteAsociadoOPs(null);
        R2_CLS_CompensationTriggerMethods.crearOPAvios(null);
    }
}