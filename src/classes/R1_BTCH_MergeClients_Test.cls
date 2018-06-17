/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Apex test para la clase apex 'R1_BTCH_MergeClients'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    12/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_BTCH_MergeClients_Test {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion executeBatch()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    12/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void executeBachTest(){
        R1_CLS_LogHelper.throw_exception = false;  
      
        List<Account> lstClientes = new List<Account>();
        
        Id recordTypeIdAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId();
        Id recordTypeIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Asistencia').getRecordTypeId();
        
        Account accMaster = new Account();
        accMaster.RecordTypeId = recordTypeIdAcc;
        accMaster.LastName = 'Master';
        accMaster.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accMaster.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accMaster);
        
        Account accDup = new Account();
        accDup.RecordTypeId = recordTypeIdAcc;
        accDup.LastName = 'Master';
        accDup.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accDup.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accDup);
        insert lstClientes;
        
        //List<R1_Cliente_duplicado__c> lstDuplicados = new List<R1_Cliente_duplicado__c>();
        R1_Cliente_duplicado__c clienteDup = new R1_Cliente_duplicado__c();
        clienteDup.R1_DUP_TXT_Golden_Record_Duplicado__c = accDup.R1_ACC_TXT_Id_Golden_record__c;
        clienteDup.R1_DUP_TXT_Golden_Record_Master__c = accMaster.R1_ACC_TXT_Id_Golden_record__c;
        //lstDuplicados.add(clienteDup);
        insert clienteDup;
        
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdCase;
        caso.AccountId = accDup.Id;
        caso.Type = 'Asistencia';
        caso.Origin = 'Email';
        caso.Status = 'Abierto';
        insert caso;
        
        List<R1_IntegrationObject__c> lstIntObjec = new List<R1_IntegrationObject__c>();
        R1_IntegrationObject__c intObject = new R1_IntegrationObject__c(Name = 'Case', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_CAS_TXT_Golden_Record_Previous__c');
        R1_IntegrationObject__c intObject2 = new R1_IntegrationObject__c(Name = 'Entitlement', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_ENT_TXT_Golden_Record_Previous__c');
        lstIntObjec.add(intObject);
        lstIntObjec.add(intObject2);
        insert lstIntObjec;

        R1_Job_Helper__c jobHelper = new R1_Job_Helper__c(Name = 'R1_Merge_JOB', R1_DT_Hora_inicio_Job__c = System.now());
        insert jobHelper;

        Test.startTest();
            
            Integer cont = 3;
            R1_BTCH_MergeClients mergeBatch = new R1_BTCH_MergeClients(cont);
            Database.executeBatch(mergeBatch, 2);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion executeBatch()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    12/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void executeBachTest_2(){
        R1_CLS_LogHelper.throw_exception = false;  
        
        List<Account> lstClientes = new List<Account>();
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Id recordTypeIdCase = [SELECT Id FROM recordType WHERE Name like 'Asistencia' LIMIT 1].Id;
        
        Account accMaster = new Account();
        accMaster.RecordTypeId = recordTypeIdAcc;
        accMaster.LastName = 'Master';
        accMaster.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accMaster.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accMaster);
        
        Account accDup = new Account();
        accDup.RecordTypeId = recordTypeIdAcc;
        accDup.LastName = 'Duplicado';
        accDup.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accDup.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accDup);
        insert lstClientes;
        
        //List<R1_Cliente_duplicado__c> lstDuplicados = new List<R1_Cliente_duplicado__c>();
        R1_Cliente_duplicado__c clienteDup = new R1_Cliente_duplicado__c();
        clienteDup.R1_DUP_TXT_Golden_Record_Duplicado__c = accDup.R1_ACC_TXT_Id_Golden_record__c;
        clienteDup.R1_DUP_TXT_Golden_Record_Master__c = accMaster.R1_ACC_TXT_Id_Golden_record__c;
        clienteDup.R1_DUP_CHK_No_Procesados__c = true;
        //lstDuplicados.add(clienteDup);
        insert clienteDup;
        
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdCase;
        caso.AccountId = accDup.Id;
        caso.Type = 'Asistencia';
        caso.Origin = 'Email';
        caso.Status = 'Abierto';
        insert caso;
        
        List<R1_IntegrationObject__c> lstIntObjec = new List<R1_IntegrationObject__c>();
        R1_IntegrationObject__c intObject = new R1_IntegrationObject__c(Name = 'Case', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_CAS_TXT_Golden_Record_Previous__c');
        R1_IntegrationObject__c intObject2 = new R1_IntegrationObject__c(Name = 'Entitlement', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_ENT_TXT_Golden_Record_Previous__c');
        lstIntObjec.add(intObject);
        lstIntObjec.add(intObject2);
        insert lstIntObjec;

        R1_Job_Helper__c jobHelper = new R1_Job_Helper__c(Name = 'R1_Merge_JOB', R1_DT_Hora_inicio_Job__c = System.now());
        insert jobHelper;
 
        
        Test.startTest();
            
            Integer cont = 1;
            R1_BTCH_MergeClients mergeBatch = new R1_BTCH_MergeClients(cont);
            Database.executeBatch(mergeBatch);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia       
    Company:        Accenture
    Description:    Metodo test para la funcion executeBatch()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/12/2017             Alvaro Garcia                           Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void executeBachTest_3(){
        R1_CLS_LogHelper.throw_exception = false;  
        
        List<Account> lstClientes = new List<Account>();
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Id recordTypeIdCase = [SELECT Id FROM recordType WHERE Name like 'Asistencia' LIMIT 1].Id;
        
        Account accMaster = new Account();
        accMaster.RecordTypeId = recordTypeIdAcc;
        accMaster.LastName = 'Master';
        accMaster.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accMaster.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accMaster);
        
        Account accDup = new Account();
        accDup.RecordTypeId = recordTypeIdAcc;
        accDup.LastName = 'Duplicado';
        accDup.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        accDup.R1_ACC_TXT_Id_Golden_record__c = 'master';
        lstClientes.add(accDup);
        insert lstClientes;
        
        //List<R1_Cliente_duplicado__c> lstDuplicados = new List<R1_Cliente_duplicado__c>();
        R1_Cliente_duplicado__c clienteDup = new R1_Cliente_duplicado__c();
        clienteDup.R1_DUP_TXT_Golden_Record_Duplicado__c = accDup.R1_ACC_TXT_Id_Golden_record__c;
        clienteDup.R1_DUP_TXT_Golden_Record_Master__c = accMaster.R1_ACC_TXT_Id_Golden_record__c;
        clienteDup.R1_DUP_CHK_No_Procesados__c = true;
        //lstDuplicados.add(clienteDup);
        insert clienteDup;
        
        R1_Alert__c alerta = new R1_Alert__c();
        alerta.Name = 'testAlert';
        alerta.R1_ATA_LOO_Client__c = accDup.Id;
        alerta.R1_ATA_PKL_Alert_for__c = 'CCPO';
        alerta.R1_ATA_PKL_State__c = 'Activada';
        insert alerta;
        
        List<R1_IntegrationObject__c> lstIntObjec = new List<R1_IntegrationObject__c>();
        R1_IntegrationObject__c intObject = new R1_IntegrationObject__c(Name = 'Case', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_CAS_TXT_Golden_Record_Previous__c');
        R1_IntegrationObject__c intObject2 = new R1_IntegrationObject__c(Name = 'Entitlement', R1_Field__c = 'AccountId', R1_TXT_GR_previous__c = 'R1_ENT_TXT_Golden_Record_Previous__c');
        R1_IntegrationObject__c intObject3  = new R1_IntegrationObject__c(Name = 'R1_Alert__c', R1_Field__c = 'R1_ATA_LOO_Client__c', R1_TXT_GR_previous__c = 'R1_ATA_TXT_Golden_Record_Previous__c');
        lstIntObjec.add(intObject);
        lstIntObjec.add(intObject2);
        lstIntObjec.add(intObject3);
        insert lstIntObjec;

        R1_Job_Helper__c jobHelper = new R1_Job_Helper__c(Name = 'R1_Merge_JOB', R1_DT_Hora_inicio_Job__c = System.now());
        insert jobHelper;
 
        
        Test.startTest();
            
            Integer cont = 1;
            R1_BTCH_MergeClients mergeBatch = new R1_BTCH_MergeClients(cont);
            Database.executeBatch(mergeBatch);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    12/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        Integer cont = 0;
        R1_BTCH_MergeClients mergeBatch = new R1_BTCH_MergeClients(cont);
        Database.executeBatch(mergeBatch);       
    }
}