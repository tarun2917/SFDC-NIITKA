/*---------------------------------------------------------------------------------------------------------------------
    Author:         UPH
    Company:        Accenture
    Description:

    History:
    <Date>                     <Author>                         <Change Description>
    30/11/2017                   UPH                               Initial Version
    16/03/2018              Alberto Puerto Collado                  Added giveMeController() method
    ----------------------------------------------------------------------------------------------------------------------*/

@isTest
private class R2_CLS_caseFilteredReport_CTRL_TEST {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:

    History:
    <Date>                     <Author>                         <Change Description>
    16/03/2018              Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    private static R2_CLS_caseFilteredReport_CTRL giveMeController(){
        Campaign camp = new Campaign();
        ApexPages.StandardController sc = new ApexPages.StandardController(camp);
        R2_CLS_caseFilteredReport_CTRL ctrl = new R2_CLS_caseFilteredReport_CTRL(sc);
        return ctrl;
    }
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         UPH
    Company:        Accenture
    Description:

    History:
    <Date>                     <Author>                         <Change Description>
    30/11/2017                   UPH                               Initial Version
    16/03/2018              Alberto Puerto Collado                  Added giveMeController() method
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void reorderTable_Test() {
        R1_CLS_LogHelper.throw_exception = false;

        Id rTExp = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND (Name = 'Campañas salientes') LIMIT 1].Id;
        Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
        QueueSobject idOwn = [SELECT Id, QueueId, Queue.Name FROM QueueSobject WHERE Queue.Name = 'SYR Gestión Equipaje' LIMIT 1];

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
        casoPa.OwnerId = idOwn.QueueId;
        insert casoPa;

        Test.startTest();

        //R2_CLS_caseFilteredReport_CTRL ctrl = new R2_CLS_caseFilteredReport_CTRL();
        R2_CLS_caseFilteredReport_CTRL ctrl = giveMeController();
        ctrl.idiomaSelected = 'Español';
        ctrl.estadoSelected = 'Abierto';
        ctrl.mostrarCasos();

        ctrl.fieldNameAPI = 'CreatedDate';
        ctrl.reorderTable();

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         UPH
    Company:        Accenture
    Description:

    History:
    <Date>                     <Author>                         <Change Description>
    30/11/2017                   UPH                               Initial Version
    16/03/2018              Alberto Puerto Collado                  Added giveMeController() method
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R2_CLS_caseFilteredReport_CTRL ctrl = giveMeController();

        //R2_CLS_caseFilteredReport_CTRL ctrl = new R2_CLS_caseFilteredReport_CTRL();
        ctrl.mostrarCasos();
    }
}