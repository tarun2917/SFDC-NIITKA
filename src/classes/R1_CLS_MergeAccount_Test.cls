/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Apex test de la clase apex "R1_CLS_MergeAccount"
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	26/04/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R1_CLS_MergeAccount_Test {  
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion mergeAccounts()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	26/04/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void mergeAccounts_Test(){
        R1_CLS_LogHelper.throw_exception = false;   
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Id recordTypeIdCase = [SELECT Id FROM recordType WHERE Name like 'Asistencia' LIMIT 1].Id;
        List<Account> lstAcc = new List<Account>();
        for(Integer i = 1; i <= 2; i++){
            Account accTest = new Account();
            accTest.LastName = 'Test' + i;
            accTest.RecordTypeId = recordTypeIdAcc;
            accTest.R1_ACC_TXT_Id_Golden_record__c = '' + i;
            accTest.PersonBirthdate = Date.newInstance(1990, 12, 31);
            lstAcc.add(accTest);
        }
        insert lstAcc;		
        
        R1_IntegrationObject__c ioTest = new R1_IntegrationObject__c();
        ioTest.R1_Field__c = 'AccountId';
        ioTest.Name = 'Case';
        insert ioTest;
        
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdCase;
        caso.AccountId = lstAcc[0].Id;
        caso.Type = 'Asistencia';
        caso.Origin = 'Email';
        caso.Status = 'Abierto';
        insert caso;
        
        Map<String, String> testMap = new Map<String, String>();
        testMap.put(lstAcc[0].R1_ACC_TXT_Id_Golden_record__c, lstAcc[1].R1_ACC_TXT_Id_Golden_record__c);
		             
        Blob body;
        RestRequest req = new RestRequest();
		body = Blob.valueof(JSON.serialize(testMap));
        req.httpMethod = 'PUT';
        req.requestBody = body;
		req.requestURI = '/receiveAccounts/';
		RestContext.request = req; 

        Test.startTest();
		R1_CLS_MergeAccount.mergeAccounts(testMap);  
		Test.stopTest();        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion updateObject()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	26/04/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void updateObject_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Id recordTypeIdCase = [SELECT Id FROM recordType WHERE Name like 'Asistencia' LIMIT 1].Id;
        List<Account> lstAcc = new List<Account>();
        for(Integer i = 1; i <= 2; i++){
            Account accTest = new Account();
            accTest.LastName = 'Test' + i;
            accTest.RecordTypeId = recordTypeIdAcc;
            accTest.R1_ACC_TXT_Id_Golden_record__c = '' + i;
            accTest.PersonBirthdate = Date.newInstance(1990, 12, 31);
            lstAcc.add(accTest);
        }
        insert lstAcc;		
        
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdCase;
        caso.AccountId = lstAcc[0].Id;
        caso.Type = 'Asistencia';
        caso.Origin = 'Email';
        caso.Status = 'Abierto';
        insert caso;

        R1_Alert__c alerta = new R1_Alert__c();
        alerta.R1_ATA_LOO_Client__c = lstAcc[0].Id;
        insert alerta;
        
        Map<Id, Id> idTestMap = new Map<Id, Id>();
        idTestMap.put(lstAcc[0].Id, lstAcc[1].Id);
        Map<Id, Id> idTestMap2 = new Map<Id, Id>();
        
        Test.startTest();
        R1_CLS_MergeAccount.updateObject(idTestMap, idTestMap2, 'Case', 'AccountId', 'R1_CAS_TXT_Golden_Record_Previous__c');
        R1_CLS_MergeAccount.updateObject(idTestMap, idTestMap2, 'R1_Alert__c', 'AccountId', 'R1_CAS_TXT_Golden_Record_Previous__c');
        Test.stopTest();
    }
	
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para cubrir los catch
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	26/04/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        Map<String, String> testMap = new Map<String, String>();
        R1_CLS_MergeAccount.mergeAccounts(testMap);
        R1_CLS_MergeAccount.updateObject(null, null, '', '', '');
    }
}