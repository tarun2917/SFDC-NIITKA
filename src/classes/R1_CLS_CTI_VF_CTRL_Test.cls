/*---------------------------------------------------------------------------------------------------------------------
  Author:         Borja Gay Flores
  Company:        Accenture
  Description:    Apex test de la clase apex "R1_CLS_CTI_VF_CTRL"
  IN:             
  OUT:            

  History: 
   <Date>                     <Author>                         <Change Description>
  05/07/2017               Borja Gay Flores                       Initial Version
  23/08/2017                  David Barco Infante               Add the value to uui parameter
  17/10/2017                    jaime ascanta                   agreagado campo obligatorio (PersonBirthdate) al cear una cuenta.
  ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R1_CLS_CTI_VF_CTRL_Test {

    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        Case caso = new Case();
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R1_CLS_CTI_VF_CTRL ctiCtrl = new R1_CLS_CTI_VF_CTRL(sc);
        ctiCtrl.asignarCaso();
        ctiCtrl.cargarCaso();
    }

    static testMethod void testCTI_Valido(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.LastName = 'Jose Murillo';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        acc.recordTypeId = recordTypeIdAcc;
        insert acc;
        
        String uuiValue = acc.Id + '40!39';
      	ApexPages.currentPage().getParameters().put('ani','987403361');
        ApexPages.currentPage().getParameters().put('dnis','913875432');
        ApexPages.currentPage().getParameters().put('cid','12345');
        ApexPages.currentPage().getParameters().put('calltype','Inbound');
        ApexPages.currentPage().getParameters().put('uui',uuiValue);
        ApexPages.currentPage().getParameters().put('recordid',acc.id);
        
        R1_CTI_Services__c ctiService = new R1_CTI_Services__c();
        ctiService.Name = 'Test';
        ctiService.R1_CTI_Phone__c = '913875432';
        insert ctiService;
        
        Test.startTest();
        Case caso = new Case();
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R1_CLS_CTI_VF_CTRL ctiCtrl = new R1_CLS_CTI_VF_CTRL(sc);
        ctiCtrl.asignarCaso();
        Test.stopTest();      
        Case casoFinal = [SELECT Id, AccountId FROM Case WHERE AccountId = :acc.Id LIMIT 1];
        System.assertEquals(acc.Id, casoFinal.AccountId);
    }		
	
	static testMethod void testCTI_Valido2(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.LastName = 'Jose Murillo';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        acc.recordTypeId = recordTypeIdAcc;
        insert acc;
        
        Account acc2 = new Account();
        acc2.LastName = 'Pepito Grillo';
        acc2.PersonBirthdate = Date.newInstance(1990, 12, 31);
        acc2.recordTypeId = recordTypeIdAcc;
        insert acc2;

        String uuiValue = acc.Id + '40!100';
      	ApexPages.currentPage().getParameters().put('ani','987403361');
        ApexPages.currentPage().getParameters().put('dnis','913875432');
        ApexPages.currentPage().getParameters().put('cid','12345');
        ApexPages.currentPage().getParameters().put('calltype','Inbound');
        ApexPages.currentPage().getParameters().put('uui',uuiValue);
        ApexPages.currentPage().getParameters().put('recordid',acc.id+';'+acc2.Id);
        
        R1_CTI_Services__c ctiService = new R1_CTI_Services__c();
        ctiService.Name = 'Test';
        ctiService.R1_CTI_Phone__c = '913875432';
        insert ctiService;
        
        Test.startTest();
        Case caso = new Case();
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R1_CLS_CTI_VF_CTRL ctiCtrl = new R1_CLS_CTI_VF_CTRL(sc);
        ctiCtrl.asignarCaso();
        Test.stopTest();      
       
    }
	    
    static testMethod void testCTI_Invalido(){
        R1_CLS_LogHelper.throw_exception = false;
        
      	ApexPages.currentPage().getParameters().put('ani','987403361');
        ApexPages.currentPage().getParameters().put('dnis','913875432');
        ApexPages.currentPage().getParameters().put('cid','12345');
        ApexPages.currentPage().getParameters().put('calltype','Internal');
        ApexPages.currentPage().getParameters().put('uui', '');
        ApexPages.currentPage().getParameters().put('recordid','');
        
        Test.startTest();
        Case caso = new Case();
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R1_CLS_CTI_VF_CTRL ctiCtrl = new R1_CLS_CTI_VF_CTRL(sc);
        ctiCtrl.internal = false;
        ctiCtrl.noCliente = false;
        ctiCtrl.asignarCaso();
        Test.stopTest();        
        List<Case> casoFinal = [SELECT Id, AccountId FROM Case];
        System.assert(casoFinal.size()==0);
    }
  
	
}