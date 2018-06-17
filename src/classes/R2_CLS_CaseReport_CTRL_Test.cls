/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    23/10/2017                  Rubén Pingarrón Jerez                Initial Version
    20/04/2018                  Jaime Ascanta                       refactorizado el codigo y corregido errores
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_CaseReport_CTRL_Test {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/04/2018                  Jaime Ascanta                       Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initView(){
        R1_CLS_LogHelper.throw_exception = false;
        Test.startTest();

            R2_CLS_CaseReport_CTRL ctrl = new R2_CLS_CaseReport_CTRL();

            System.assertNotEquals(null, ctrl.categorias);
            System.assertNotEquals(null, ctrl.idiomas);
            System.assertNotEquals(null, ctrl.owners);

            System.assertEquals(null, ctrl.categoriaSelected);
            System.assertEquals(null, ctrl.idiomaSelected);
            System.assertEquals(null, ctrl.ownerSelected);

            System.assertEquals(null, ctrl.casesToShow);
            System.assertEquals(null, ctrl.telexToShow);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/04/2018                  Jaime Ascanta                       Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void filtersTest(){
        R1_CLS_LogHelper.throw_exception = false;

        Test.startTest();

            // cas 1 : filter by owner
            R2_CLS_CaseReport_CTRL ctrl = new R2_CLS_CaseReport_CTRL();
            ctrl.ownerSelected = 'SYR Gestión Equipaje';
            ctrl.totalPageSelected = '10';
            ctrl.reRenderTables();
            System.assertEquals(3, ctrl.casesToShow.size());

            // cas 2 : filter by owner and category = Estándar
            ctrl.categoriaSelected = 'Estándar';
            ctrl.reRenderTables();
            System.assertEquals(1, ctrl.casesToShow.size());

            // cas 3 : filter by owner and category = Estándar AND idioma = es
            ctrl.categoriaSelected = 'Estándar';
            ctrl.idiomaSelected = 'es';
            ctrl.reRenderTables();
            System.assertEquals(0, ctrl.casesToShow.size());

            // cas 4 : filter by owner and category = VIP AND idioma = en
            ctrl.categoriaSelected = 'VIP';
            ctrl.idiomaSelected = 'en';
            ctrl.reRenderTables();
            System.assertEquals(1, ctrl.casesToShow.size());

            // cas 5 : empty filters categoria, idioma
            ctrl.categoriaSelected = null;
            ctrl.idiomaSelected = null;
            ctrl.reRenderTables();
            System.assertEquals(3, ctrl.casesToShow.size());

            // cas 5 : empty all filters
            ctrl.ownerSelected = null;
            ctrl.reRenderTables();
            System.assertEquals(0, ctrl.casesToShow.size());

            // cas 6 : view tabe telex msg SYR Action File
            ctrl.ownerSelected = 'SYR Action File';
            ctrl.reRenderTables();
            System.assertEquals(1, ctrl.telexToShow.size());

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/04/2018                  Jaime Ascanta                       Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void reorderTable_Cases_test(){
        R1_CLS_LogHelper.throw_exception = false;
        Test.startTest();

            R2_CLS_CaseReport_CTRL ctrl = new R2_CLS_CaseReport_CTRL();
            ctrl.ownerSelected = 'SYR Gestión Equipaje';
            ctrl.totalPageSelected = '10';
            ctrl.reRenderTables();
            System.assertEquals(3, ctrl.casesToShow.size());

            ctrl.orderbyFieldCas = 'Status';
            ctrl.ordenacionSentido = 'ASC';
            ctrl.reorderTable();
            System.assertEquals(3, ctrl.casesToShow.size());

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/04/2018                  Jaime Ascanta                       Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void reorderTable_Telex_test(){
        R1_CLS_LogHelper.throw_exception = false;
        Test.startTest();

            R2_CLS_CaseReport_CTRL ctrl = new R2_CLS_CaseReport_CTRL();
            ctrl.ownerSelected = 'SYR Action File';
            ctrl.reRenderTables();
            System.assertEquals(1, ctrl.telexToShow.size());

            ctrl.orderbyFieldTelex = 'Name';
            ctrl.ordenacionSentido = 'DESC';
            ctrl.totalPageSelected = '10';
            ctrl.reorderTable();
            System.assertEquals(1, ctrl.telexToShow.size());

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    @TestSetup
    static void setupTests(){

        R1_CLS_LogHelper.throw_exception = false;

        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

        List<Group> listGroup = [SELECT Id, Name FROM Group WHERE Name='SYR Gestión Equipaje' AND Type='Queue'];
        List<Group> listGroup2 = [SELECT Id, Name FROM Group WHERE Name='SYR Action File' AND Type='Queue'];

        List<Case> listCases = new List<Case>();
        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Llamada';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'es';
        casoPa.OwnerId = listGroup[0].Id;
        listCases.add(casoPa);

        Case casoPa1 = new Case();
        casoPa1.RecordTypeId = rTExp;
        casoPa1.Status = 'Abierto';
        casoPa1.Origin = 'Llamada';
        casoPa1.Type = 'Demora';
        casoPa1.Subject = 'SubjectTest';
        casoPa1.Description = 'DescriptionTest';
        casoPa1.R2_CAS_PKL_Vip_Type__c = 'Estándar';
        casoPa1.Priority = 'Sin prioridad';
        casoPa1.R1_CAS_PKL_Idioma__c = 'de';
        casoPa1.OwnerId = listGroup[0].Id;
        listCases.add(casoPa1);

        Case casoPa2 = new Case();
        casoPa2.RecordTypeId = rTExp;
        casoPa2.Status = 'Abierto';
        casoPa2.Origin = 'Llamada';
        casoPa2.Type = 'Demora';
        casoPa2.Subject = 'SubjectTest';
        casoPa2.Description = 'DescriptionTest';
        casoPa2.R2_CAS_PKL_Vip_Type__c = 'VIP';
        casoPa2.Priority = 'Sin prioridad';
        casoPa2.R1_CAS_PKL_Idioma__c = 'en';
        casoPa2.OwnerId = listGroup[0].Id;
        listCases.add(casoPa2);

        insert listCases;

        R2_MG_Message__c mg = new R2_MG_Message__c();
        mg.R2_MG_CHK_Processed__c = false;
        mg.OwnerId = listGroup2[0].Id;
        insert mg;

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
    23/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CLS_CaseReport_CTRL ctrl = new R2_CLS_CaseReport_CTRL();


        ctrl.reRenderTables();
        ctrl.mostrarCasos();
        ctrl.mostrarMensajesTelex();
        ctrl.reorderTable();
    }
}