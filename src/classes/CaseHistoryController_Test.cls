/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class CaseHistoryController_Test {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            Testing again

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void testCaseHistoryController() {
        R1_CLS_LogHelper.throw_exception = false;
        //create a new case
        
        System.Test.startTest();
        
        Id rTExp = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;
        Id rTEquip = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        
        Id recordTypeId = [SELECT Id FROM recordType WHERE sObjectType = 'Account' AND Name like 'Cuenta personal' LIMIT 1].Id;
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
        
        Case c = new Case();
        c.RecordTypeId = rTExp;
        c.origin='sample1';
        c.Status = 'Abierto';
        c.Type = 'Deterioro';
        insert c;
        
        Case ch = new Case();
        ch.RecordTypeId = rTEquip;
        ch.origin = 'sample2';
        ch.parentId = c.Id;
        insert ch;
        
        R2_CLA_Claimant_Entity__c ec = new R2_CLA_Claimant_Entity__c();
        //ec.Name = 'ejemp';
        ec.R2_CLA_LOO_Case__c = c.Id;
        ec.R2_CLA_LOO_Account__c = acc.Id;
        insert ec;
        
        CaseComment cc = new CaseComment();
        cc.parentId = c.id;
        insert cc;
        
        
        EmailMessage em = new EmailMessage();
        em.parentId = c.id;
        em.MessageDate = Date.today();
        em.FromAddress = 'test@from.com';
        em.ToAddress = 'test@to.com';
        em.Subject = 'test subject';
        em.TextBody = 'heres a text body.';
        insert em;
        
        Blob blobTest = Blob.valueOf('Hola soy un archivo de prueba');
        
        Attachment attCase = new Attachment();
        attCase.Name = 'TestAtt1';
        attCase.ParentId = c.Id;
        attCase.Body = blobTest;
        insert attCase;
        
        Attachment attEmail = new Attachment();
        attEmail.Name = 'TestAtt2';
        attEmail.ParentId = em.Id;
        attEmail.Body = blobTest;
        insert attEmail;
        
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.R1_INC_LOO_Case__c = ch.Id;
        incidencia.R2_INC_LOO_Case__c = c.Id;
        insert incidencia;
        
        //c.Source = em;
        c.Status = 'Trabajando';
        
        update c;
        
        ApexPages.currentPage().getParameters().put('id', c.id );
        CaseHistoryController chc = new CaseHistoryController();
        chc.setupHistories(c);
        chc.setupEmailAttachment(c);
        chc.tipoSelected = 'Historial (Automaticas)';
        
        //String label = CaseHistoryController.returnFieldLabel('Status');
 
        System.assert(CHC.caseID != null);
        
        
        System.assert(CHC.CHIList.get(0).itemType=='activity.png');
        
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        System.debug('TESTS ENDED');
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void filtro1_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Test.startTest();
        
        CaseHistoryController chc = new CaseHistoryController();
        chc.filtroTipo();
        chc.tipoSelected = 'Todos';
        chc.filtrarTipo();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void filtro2_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Test.startTest();
        
        DateTime fechaT = DateTime.newInstance(2017, 09, 20);
        Date fecha = Date.newInstance(2017, 09, 20);
        String vacia = '';
        String tipo = 'Archivo email';
        
        CaseHistoryController.CaseHistoryItem chi;
       	chi = new CaseHistoryController.CaseHistoryItem(vacia, false, fechaT, fechaT, vacia, vacia, vacia, vacia, vacia, vacia, vacia, vacia, fecha, vacia, vacia, vacia);
        chi.ItemTypeName = 'Archivo email';
        
        CaseHistoryController chc = new CaseHistoryController();
        chc.CHIlist.add(chi);
        chc.filtroTipo();
        chc.tipoSelected = 'Adjunto';
        chc.filtrarTipo();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void filtro3_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Test.startTest();
        
        DateTime fechaT = DateTime.newInstance(2017, 09, 20);
        Date fecha = Date.newInstance(2017, 09, 20);
        String vacia = '';
        String tipo = 'Archivo email';
        
        CaseHistoryController.CaseHistoryItem chi;
       	chi = new CaseHistoryController.CaseHistoryItem(vacia, false, fechaT, fechaT, vacia, vacia, vacia, vacia, vacia, vacia, vacia, vacia, fecha, vacia, vacia, vacia);
        chi.ItemTypeName = 'Archivo email';
        
        CaseHistoryController chc = new CaseHistoryController();
        chc.CHIlist.add(chi);
        chc.filtroTipo();
        chc.tipoSelected = 'Todos sin tipo Historial';
        chc.filtrarTipo();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void filtro4_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Test.startTest();
        
        DateTime fechaT = DateTime.newInstance(2017, 09, 20);
        Date fecha = Date.newInstance(2017, 09, 20);
        String vacia = '';
        String tipo = 'Email';
        
        CaseHistoryController.CaseHistoryItem chi;
        chi = new CaseHistoryController.CaseHistoryItem(vacia, false, fechaT, fechaT, vacia, vacia, vacia, vacia, vacia, vacia, vacia, vacia, fecha, vacia, vacia, vacia);
        chi.ItemTypeName = 'Email';
        
        CaseHistoryController chc = new CaseHistoryController();
        chc.CHIlist.add(chi);
        chc.filtroTipo();
        chc.tipoSelected = 'Email';
        chc.filtrarTipo();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static TestMethod void testNoId() {
        R1_CLS_LogHelper.throw_exception = false;
        
        CaseHistoryController CHC = new CaseHistoryController();
        
        String label = CaseHistoryController.returnFieldLabel('Test');
        
        System.assert(CHC.caseID == null);
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture 
    Description:    Clase de test para la controladora de caseHistory
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static TestMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        CaseHistoryController chc = new CaseHistoryController();
        
        chc.setupAttachments(null);
        chc.setupEmails(null);
        chc.setupCaseComments(null);
        chc.setupCases(null);
        chc.setupEmailAttachment(null);
        chc.setupEntidades(null);
        chc.setupHistories(null);
        chc.setupIncidencias(null);
        chc.setupPagos(null);
        chc.filtrarTipo();
        chc.filtroTipo();
        CaseHistoryController.returnFieldLabel(null);
    }
}