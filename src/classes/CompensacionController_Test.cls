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
@isTest
private class CompensacionController_Test {
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
    static testMethod void getLookupAccount_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.cuentaLookup = acc;
        //ctrl.compensacionIni();
        //ctrl.cliente = acc;
        ctrl.getLookupAccount();
        
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
    static testMethod void compensacionIniPadre_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc); 
        ctrl.compensacion = pagos;
        ctrl.cliente = acc;
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        ctrl.compensacionIni();
        
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
    static testMethod void compensacionIniHijoPasaje_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Emitido';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        //pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoH);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compensacion = pagos;
        ctrl.cliente = acc;
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        ctrl.compensacionIni();
        
        
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
    static testMethod void compensacionIniHijoEquipaje_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        List<R2_Compensation__c> lstPaogs = new List<R2_Compensation__c>();
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        //pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        lstPaogs.add(pagos);
        
        R2_Compensation__c pago2s = new R2_Compensation__c();
        pago2s.RecordTypeId = rtIndem;
        pago2s.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2s.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2s.R2_COM_PKL_Status__c = 'Emitido';
        pago2s.R2_COM_LOO_Case__c = casoH.Id;
        pago2s.R2_COM_LOO_Account__c = acc.Id;
        //pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2s.R2_COM_TXT_Charge_account__c = '102312';
        pago2s.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2s.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2s.R2_COM_DIV_Total_Amount__c = 25;
        pago2s.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2s.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2s.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2s.R2_COM_PKL_Type__c = 'Indemnización';
        pago2s.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2s.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago2s.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2s.R2_COM_PKL_Document_Type__c = '04';
        pago2s.R2_COM_TXT_Address__c = 'calle test 24';
        pago2s.R2_COM_TXT_Document_Number__c = '248242343';
        pago2s.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        lstPaogs.add(pago2s);
        
        insert lstPaogs;
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoH);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compensacion = pagos;
        ctrl.cliente = acc;
        ctrl.compensacionIni();
        
        
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
    static testMethod void guardar_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Ready';
        orden.R2_OPY_TXT_IBAN__c = '213414213';
        orden.R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
        orden.R2_OPY_TXT_Frecuent_Flyer__c = 'IB4422';
        orden.R2_OPY_TXT_Account_Num__c = '667578';
        orden.R2_OPY_TXT_Bank_Name__c = 'BBVVA';
        orden.R2_OPY_TXT_Bank_Country__c = 'ARMENIA';
        orden.R2_OPY_TXT_Budget_Center__c = 'ES';
        orden.R2_OPY_TXT_Fed_ABA__c = 'ES';
        orden.R2_OPY_TXT_Chips_ABA__c = 'ES';
        orden.R2_OPY_TXT_SWIFT__c = 'ES';
        orden.R2_OPY_TXT_City__c = 'Madrid';
        orden.R2_OPY_TXT_Province__c = 'Madrid';
        orden.R2_OPY_TXT_Postal_Code__c = '28905';
        orden.R2_OPY_TXT_Coin__c = 'USD';
        orden.R2_OPY_TXT_Account_Type__c = 'Cuenta corriente';
        insert orden;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.oPago = orden;
        ctrl.guardar();
        
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
    /*static testMethod void guardarIBAN_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
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
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
        pagos.R2_COM_LOO_Flight__c = vuelo.Id;
        pagos.R2_COM_PKL_Type__c = 'Indemnización';
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        ctrl.compensacionIni();
        ctrl.guardarIBAN();
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
                
    }*/
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
    static testMethod void ComprobarDuplicados_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Enviado';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        //pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;    
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.ComprobarDuplicados();
        
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
    static testMethod void gotoPage_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
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
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
        pagos.R2_COM_LOO_Flight__c = vuelo.Id;
        pagos.R2_COM_PKL_Type__c = 'Indemnización';
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.gotoPage();
        
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
    static testMethod void GotoOP_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.GotoOP();
        
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
    static testMethod void crearOpComp_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
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
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.crearOp();
        
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
    static testMethod void traza_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        //ctrl.compensacionIni();
        ctrl.traza();
        
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
    static testMethod void iniciaValidados_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_Charge_account__c = '102312';
        pagos.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pagos.R2_COM_TXT_Passenger_Reason__c = 'res';
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.iniciaValidados();
        
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
    static testMethod void cancelar_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
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
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
        pagos.R2_COM_LOO_Flight__c = vuelo.Id;
        pagos.R2_COM_PKL_Type__c = 'Indemnización';
        pagos.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pagos.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pagos.R2_COM_LOO_Incidence__c = incidencia.Id;
        pagos.R2_COM_PKL_Document_Type__c = '04';
        pagos.R2_COM_TXT_Address__c = 'calle test 24';
        pagos.R2_COM_TXT_Document_Number__c = '248242343';
        pagos.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pagos, '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.cancelar();
        
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
    static testMethod void cerrarFormularioCuenta_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
       
        ctrl.compensacionIni();
        ctrl.cerrarFormularioCuenta();
        
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
    static testMethod void pendiente_Test(){
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Emitido';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_Charge_account__c = '102312';
        pagos.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        List<R2_Compensation__c> pago = [SELECT Id, R2_COM_PKL_Status__c FROM R2_Compensation__c WHERE Id = :pagos.Id];
        CompensacionController.wrapPayment wrpPay = new CompensacionController.wrapPayment(pago[0], '');
        List<CompensacionController.wrapPayment> wrpList = new List<CompensacionController.wrapPayment>();
        wrpPay.selected = true;
        wrpList.add(wrpPay);
        ctrl.compenEmitido.add(wrpPay);
        ctrl.compenEmitidoList.add(wrpList);
        ctrl.compenEmitidoList2.add(wrpList);
        //ctrl.compensacionIni();
        ctrl.pendiente();
        
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
    static testMethod void getcompensacionesPending_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        
        ctrl.compensacionIni();
        ctrl.getcompensacionesPending();
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePayment_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';

        
        ctrl.validarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePaymentError_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PagosError';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';

        
        ctrl.validarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        System.assertEquals(2, [SELECT count() FROM R1_Log__c]);
    }

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePayment400_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos400';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';

        
        ctrl.validarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        System.assertEquals(2, [SELECT count() FROM R1_Log__c]);
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePaymentNoAccount_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        //ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';

        
        ctrl.validarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
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
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compensacionIni();
        ctrl.guardar();
        //ctrl.GuardarIBAN();
        ctrl.cancelar();
        ctrl.cerrarFormularioCuenta();
        ctrl.ComprobarDuplicados();
        ctrl.crearOp();
        ctrl.getcompensacionesPending();
        ctrl.iniciaValidados();
        ctrl.getLookupAccount();
        ctrl.traza();
        ctrl.pendiente();
        ctrl.GotoOP();
        ctrl.gotoPage();
        ctrl.validarPago();
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void habilitarPagoSEPA_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPA';
        
        ctrl.habilitarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void habilitarPagoCHEQUE_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'CHEQUE';
        
        ctrl.habilitarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void habilitarPagoLATAM_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Case casoPa = new Case();
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';
        insert casoPa;
        Account acc = new Account();
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'LATAM';
        
        ctrl.habilitarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la valdiacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    06/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void habilitarPagoError_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.habilitarPago();
        ctrl.closePopup();
        ctrl.showPopup();
        ctrl.comprobacionCentroCuenta();
        ctrl.cambioCliente();
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    @isTest
    static void calcularOF()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
                //System.assertEquals(0, [SELE
    }

        @isTest
    static void calcularSAP()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularSAP1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Condenas superiores';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularOF1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Condenas superiores';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularOF2()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rtPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Gastos varios';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Condenas superiores';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularOF3()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rtPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = '3q)lost permanently and mishandled baggage';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularSAP2()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rtPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = '3q)lost permanently and mishandled baggage';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularEquipajeOF()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Gastos abogado cliente';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularEquipajeSAP()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Gastos abogado cliente';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularEquipajeSAP1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Costas judiciales';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularEquipajeOF1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = '03-Baggage';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Costas judiciales';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Cambio programación';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Cambio programación';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Asistencia';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago (Resto)';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF1()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Asistencia';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago (Resto)';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP2()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Denegación a embarque';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF2()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Denegación a embarque';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF3()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Downgrade';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP3()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Downgrade';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP4()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Desvío Otro Aeropuerto';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.R2_CAS_PKL_Manage__c = 'Pago';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Aeropuerto destino inoperativo';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF4()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Desvío Otro Aeropuerto';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.R2_CAS_PKL_Manage__c = 'Pago';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Aeropuerto destino inoperativo';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP5()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Manchas_Daños';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF5()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.RecordTypeId = rTPasaje;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Manchas_Daños';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'Pago';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeOF6()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        vuelo.R1_FLG_TXT_Carrier_code__c = 'I0';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'I0';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'I022342';
        insert vuelo;
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Manchas_Daños';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = '5e)recognition';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('OF', casoH);
        ctrl.calcularCentro('OF', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    @isTest
    static void calcularPasajeSAP6()
    {
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
        Id rtIndem = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        
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
        vuelo.R1_FLG_TXT_Carrier_code__c = 'I0';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'I0';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'I022342';
        insert vuelo;
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Manchas_Daños';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = '5e)recognition';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        
        R2_Compensation__c pagos = new R2_Compensation__c();
        pagos.RecordTypeId = rtIndem;
        pagos.R2_COM_PKL_Marketing_Company__c = 'IB';
        pagos.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pagos.R2_COM_PKL_Status__c = 'Inicial';
        pagos.R2_COM_LOO_Case__c = casoH.Id;
        pagos.R2_COM_LOO_Account__c = acc.Id;
        pagos.R2_COM_TXT_IBAN__c = '131412412';
        pagos.R2_COM_PKL_Payment_method__c = 'Cheque';
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
        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.calcularCuenta('SAP', casoH);
        ctrl.calcularCentro('SAP', casoH);
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELE
    }

    static testMethod void comprobacionCentroCuentaCheque(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102313';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test2';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago1.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        System.debug('MI lista de pagos: ' + ctrl.compenEmitidoList2[0]);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolCheque =  true;
        
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    static testMethod void comprobacionCentroCuentaSEPA(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;
        
        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test2';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago1.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        System.debug('MI lista de pagos: ' + ctrl.compenEmitidoList2[0]);
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolSepa = true;
        
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    static testMethod void comprobacionCentroCuentaLatam(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;

        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago1.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolLatam = true;
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    static testMethod void comprobacionCentroCuentaNoCountry(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;

        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago1.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolLatam = true;
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    static testMethod void comprobacionCentroCuentaNoPago(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
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
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
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
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;

        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'MXN';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    static testMethod void comprobacionCentroCuenta(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;
        System.debug('Despues de endopints');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
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

        System.debug('Despues de Accounts');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
        
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

        System.debug('Despues de vuelos');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
        
        Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtID;
        incidencia.R2_INC_DAT_PIR_Claims_Created_Date__c = Date.newInstance(2017, 08, 05);
        incidencia.R2_INC_TXT_PIR_PIR_incident__c = '5232';
        incidencia.R2_INC_PKL_II_Type__c = 'Asistencia por cancelación';
        insert incidencia;
        

        System.debug('Despues de incidencia');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
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
        

        System.debug('Despues de caso padre');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
        Case casoH = new Case();
        casoH.RecordTypeId = rTEquip;
        casoH.R2_CAS_PKL_Code_type_case__c = '0';
        casoH.ParentId = casoPa.Id;
        casoH.AccountID = acc.Id;
        casoH.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoH.Status = 'Abierto';
        casoH.Origin = 'Llamada';
        casoH.Type = 'Pago';
        casoH.Subject = 'SubjectTest';
        casoH.Description = 'DescriptionTest';
        casoH.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoH.Priority = 'Sin prioridad';
        casoH.R1_CAS_PKL_Idioma__c = 'Español';
        casoH.R1_CAS_PKL_Subtype__c = 'No conforme con indemnización';
        casoH.R2_CAS_TXT_EA_Main_File__c = 'Test';
        casoH.R1_CAS_TXT_Charge_account__c = '102312';
        casoH.R1_CAS_TXT_Budgetary_center__c = 'es';
        insert casoH;


        System.debug('Despues de caso hijo');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
        List <R2_Compensation__c> pagos = new List <R2_Compensation__c>();

        R2_Compensation__c pago = new R2_Compensation__c();
        pago.RecordTypeId = rtIndem;
        pago.R2_COM_LOO_Client__c =acc.Id;
        pago.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';
        pago.R2_COM_LOO_Case__c = casoH.Id;
        pago.R2_COM_LOO_Account__c = acc.Id;
        pago.R2_COM_TXT_IBAN__c = '131412412';
        pago.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago.R2_COM_DIV_Total_Amount__c = 25;
        pago.R2_COM_NUM_Total_Amount_local__c = 25;
        pago.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago.R2_COM_LOO_Flight__c = vuelo.Id;
        pago.R2_COM_PKL_Type__c = 'Indemnización';
        pago.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago.R2_COM_PKL_Document_Type__c = '04';
        pago.R2_COM_TXT_Address__c = 'calle test 24';
        pago.R2_COM_TXT_Document_Number__c = '248242343';
        pago.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago);

        R2_Compensation__c pago1 = new R2_Compensation__c();
        pago1.RecordTypeId = rtIndem;
        pago1.R2_COM_LOO_Client__c =acc.Id;
        pago1.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago1.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago1.R2_COM_PKL_Status__c = 'Inicial';
        pago1.R2_COM_LOO_Case__c = casoH.Id;
        pago1.R2_COM_LOO_Account__c = acc.Id;
        pago1.R2_COM_TXT_IBAN__c = '131412412';
        pago1.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago.R2_COM_TXT_Charge_account__c = '102312';
        pago1.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago1.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago1.R2_COM_DIV_Total_Amount__c = 25;
        pago1.R2_COM_NUM_Total_Amount_local__c = 25;
        pago1.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago1.R2_COM_LOO_Flight__c = vuelo.Id;
        pago1.R2_COM_PKL_Type__c = 'Indemnización';
        pago1.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago1.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago1.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago1.R2_COM_PKL_Document_Type__c = '04';
        pago1.R2_COM_TXT_Address__c = 'calle test 24';
        pago1.R2_COM_TXT_Document_Number__c = '248242343';
        pago1.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago1);

        R2_Compensation__c pago2 = new R2_Compensation__c();
        pago2.RecordTypeId = rtIndem;
        pago2.R2_COM_PKL_Marketing_Company__c = 'IB';
        pago2.R2_COM_TXT_CIA_Flight_Incident__c = 'IB';
        pago2.R2_COM_PKL_Status__c = 'Emitido';
        pago2.R2_COM_LOO_Case__c = casoH.Id;
        pago2.R2_COM_LOO_Account__c = acc.Id;
        pago2.R2_COM_TXT_IBAN__c = '131412412';
        pago2.R2_COM_PKL_Payment_method__c = 'Cheque';
        pago2.R2_COM_TXT_Charge_account__c = '102312';
        pago2.R2_COM_TLF_Passenger_Phone__c = '994819489';
        pago2.R2_COM_TXT_Passenger_Reason__c = 'res';
        pago2.R2_COM_DIV_Total_Amount__c = 25;
        pago2.R2_COM_NUM_Total_Amount_local__c = 25;
        pago2.R2_COM_TXT_Budgetary_center__c = 'Test';
        pago2.R2_COM_LOO_Flight__c = vuelo.Id;
        pago2.R2_COM_PKL_Type__c = 'Indemnización';
        pago2.R2_COM_TXT_Main_Flight_Number__c = '1234';
        pago2.R2_COM_PKL_Currency_Claimed__c = 'EUR';
        pago2.R2_COM_LOO_Incidence__c = incidencia.Id;
        pago2.R2_COM_PKL_Document_Type__c = '04';
        pago2.R2_COM_TXT_Address__c = 'calle test 24';
        pago2.R2_COM_LOO_Client__c =acc.Id;
        pago2.R2_COM_TXT_Document_Number__c = '248242343';
        pago2.R2_COM_DAT_Flight_Date__c = Date.newInstance(2018, 05, 05);
        pagos.add(pago2);

        insert pagos;
    System.debug('Despues de endopints');
        System.debug( 'Querys utilizadas ' + Limits.getQueries() + ' //Quedan ' + Limits.getLimitQueries());
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoPa);
        CompensacionController ctrl = new CompensacionController(sc);
        ctrl.compenEmitidoList2[0][0].selected = true;
        ctrl.compenEmitidoList2[0][1].selected = true;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Country__c = 'ES';
        ctrl.opUpdate.R2_OPY_LOO_CaseAccount__c= acc.Id;
        ctrl.opUpdate.R2_OPY_TXT_Bank_Name__c = 'Banco Santander';
        ctrl.opUpdate.R2_OPY_TXT_Bank_Account__c = '2010138058';
        ctrl.opUpdate.R2_OPY_TXT_Control_Digit__c = '00';
        ctrl.opUpdate.R2_OPY_TXT_SWIFT__c = 'BSCHESMM';
        ctrl.opUpdate.R2_OPY_TXT_IBAN__c = 'ES3200491500002010138058';
        ctrl.opUpdate.R2_OPY_TXT_Postal_Code__c = '28033';
        ctrl.opUpdate.R2_OPY_TXT_Address1__c = 'Martinez Villerga';
        ctrl.opUpdate.R2_OPY_TXT_City__c = 'Madrid';
        ctrl.valueTipoPago = 'SEPAAA';
        ctrl.boolLatam = true;
        ctrl.comprobacionCentroCuenta();
        
        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

}