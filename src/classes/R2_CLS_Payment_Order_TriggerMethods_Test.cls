/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
   13/12/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
@isTest
private class R2_CLS_Payment_Order_TriggerMethods_Test {
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
   13/12/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    static testMethod void calcularTipoOP_Test(){
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
        
        pagosOracle__c setPago = new pagosOracle__c();
        setPago.activo__c = true;
        setPago.codigoPais__c = 'ES';
        setPago.Metodo_de_Pago__c = 'S';
        setPago.moneda__c = 'EUR';
        setPago.pais__c = 'ESPAÑA';
        setPago.tipo__c = 'SEPA';
        setPago.Name = 'Test';
        insert setPago;
        
        R2_Payment_order__c orden = new R2_Payment_order__c();
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Ready';
        orden.R2_OPY_TXT_IBAN__c = '213414213';
        //orden.R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
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
        orden.R2_OPY_TXT_Coin__c = 'EUR';
        orden.R2_OPY_TXT_External_Local_Account__c = '6453';
        orden.R2_OPY_TXT_Bank_Account__c = '6454';
        orden.R2_OPY_TXT_Account_Type__c = 'Cuenta corriente';
        
        
        Test.startTest();
        insert orden;
        List<pagosOracle__c> lstPagosOracle = [SELECT Id, tipo__c, Metodo_de_Pago__c FROM pagosOracle__c WHERE Id = :setPago.Id];
        List<R2_Payment_order__c> ordenes = [SELECT Id, R2_OPY_PKL_PaymentType__c FROM R2_Payment_order__c WHERE Id = :orden.Id];
        System.assertEquals(ordenes[0].R2_OPY_PKL_PaymentType__c, 'SEPA');
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
    13/12/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    static testMethod void calcularTipoOPSegPagos_Test(){
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
        
        pagosOracle__c setPago = new pagosOracle__c();
        setPago.activo__c = true;
        setPago.codigoPais__c = 'ES';
        setPago.Metodo_de_Pago__c = 'S';
        setPago.moneda__c = 'EUR';
        setPago.pais__c = 'ESPAÑA';
        setPago.tipo__c = 'SEPA';
        setPago.Name = 'Test';
        insert setPago;
        
        R2_Payment_order__c orden = new R2_Payment_order__c();
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Ready';
        orden.R2_OPY_TXT_IBAN__c = '213414213';
        //orden.R2_OPY_PKL_PaymentType__c = 'Seguimiento de Pagos';
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
        
        
        Test.startTest();
        insert orden;
        List<pagosOracle__c> lstPagosOracle = [SELECT Id, tipo__c, Metodo_de_Pago__c FROM pagosOracle__c WHERE Id = :setPago.Id];
        List<R2_Payment_order__c> ordenes = [SELECT Id, R2_OPY_PKL_PaymentType__c FROM R2_Payment_order__c WHERE Id = :orden.Id];
        System.assertEquals(ordenes[0].R2_OPY_PKL_PaymentType__c, 'Seguimiento de Pagos');
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
    13/12/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    static testMethod void lanzarIniciarOrden_Test(){
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
        //orden.R2_OPY_NUM_AVIOS_amount__c = 868;
        orden.R2_OPY_LOO_File_associated__c = casoPa.Id;
        orden.R2_OPY_PCK_Status__c = 'Borrador';
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
        pagos.RecordTypeId = rtIndem;
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
        insert pagos;
        
        Test.startTest();
        
        //List<pagosOracle__c> lstPagosOracle = [SELECT Id, tipo__c, Metodo_de_Pago__c FROM pagosOracle__c WHERE Id = :setPago.Id];
        List<R2_Payment_order__c> ordenAenviar = [SELECT Id, R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id = :orden.Id];
        ordenAenviar[0].R2_OPY_PCK_Status__c = 'Ready';
        update ordenAenviar;
        //System.assertEquals(ordenes[0].R2_OPY_PCK_Status__c, 'Seguimiento de Pagos');
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
   13/12/2017            Ruben Pingarron Jerez          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_Payment_Order_TriggerMethods.calcularTipoOP(null);
        R2_CLS_Payment_Order_TriggerMethods.initiatePayment(null, null);
        R2_CLS_Payment_Order_TriggerMethods.enviarASeguimientoPagos(null);
    }
}