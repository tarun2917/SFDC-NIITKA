/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 

    <Date>                     <Author>                <Change Description>
    18/09/2017                 Ismael Yubero Moreno            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_TSK_New_SMS_CTRL_Test {
	static testMethod void seleccionarTlf_Test(){
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc; 
        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Selecciona un teléfono';
        cse.tratarTelefono();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void tratarTelefonoO_Test(){
		
		Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579';	
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc;	
        //String telefono='Teléfono Operacional';
        System.debug('Pasa por esta parte del test');

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        System.debug('Pasa por esta parte del test');
        insert tsk;
        System.debug('Pasa por esta parte del test');
        System.currentPageReference().getParameters().put('accId', acc.Id);
        //System.currentPageReference().getParameters().put('telefono', telefono);


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
		R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
		cse.tratarTelefono();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTelefonoOF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579'; 
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc; 
        //String telefono='Teléfono Operacional';
        

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
        //System.currentPageReference().getParameters().put('telefono', telefono);


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
        cse.tratarTelefono();
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTelefonoM_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.tratarTelefono();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTelefonoMF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.tratarTelefono();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}

    static testMethod void guardarTask_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.body ='';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
    static testMethod void guardarTaskF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
    static testMethod void guardarTaskOF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';

        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}

////////////////////////////////GuargarTask Marketing////////////////////////
static testMethod void guardarTaskM_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
    static testMethod void guardarTaskMF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';

        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
////////////////////////////////GuargarTask Otro////////////////////////
static testMethod void guardarTaskOt_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Otro';
        cse.codigoPais = '34';
        cse.numTlf = '651168309';
        cse.body='Prueba SMS';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
    static testMethod void guardarTaskOtroF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';

        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Otro';
        cse.codigoPais = '35';
        cse.numTlf = '658311609';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void guardarTaskOtro1F_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';

        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Otro';
        cse.codigoPais = '34';
        cse.numTlf = '6583116099';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
////////////////////////////////////////////////////////////////////////////////
    static testMethod void guardarTaskSelectTlf_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';

        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        //cse.telefono='Selecciona un teléfono';
        cse.codigoPais = '34';
        cse.numTlf = '6583116099';
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
	static testMethod void exceptionTest(){
		Task tsk = new Task();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579';	
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc;
		System.currentPageReference().getParameters().put('accId', acc.Id);
		ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
		R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);

	    cse.tratarTelefono();
	        //R2_CLS_TSK_New_SMS_CTRL.guardarTask();
	        //R2_CLS_TSK_TriggerMethods.enviarSMSMkt(null, 0);
	    }

    static testMethod void tratarTlfO_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc; 
        //String telefono='Teléfono Operacional';
        System.debug('Pasa por esta parte del test');

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        System.debug('Pasa por esta parte del test');
        insert tsk;
        System.debug('Pasa por esta parte del test');
        System.currentPageReference().getParameters().put('accId', acc.Id);
        //System.currentPageReference().getParameters().put('telefono', telefono);


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTlfOF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34663084579'; 
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 663084579';
        
        insert acc; 
        //String telefono='Teléfono Operacional';
        

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
        //System.currentPageReference().getParameters().put('telefono', telefono);


        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Operacional';
        cse.tratarTlf();
        cse.guardarTask();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTlfM_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTlfSelec_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R2_ACC_TLF_Phone_MarketingII__c= '34651168309'; 
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c = '+34 651168309';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Selecciona un teléfono';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
static testMethod void tratarTlfMF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}

static testMethod void tratarTlfMarketingF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R1_ACC_TLF_Phone_Marketing__c= '34663084579';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Teléfono Marketing';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}

static testMethod void tratarTlfOtrpF_Test(){
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        acc.R1_ACC_TLF_Phone_Operative__c= '+34 663084579';
        
        insert acc; 
         

        Task tsk = new Task();
        tsk.WhatId = acc.Id;
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        insert tsk;
        System.currentPageReference().getParameters().put('accId', acc.Id);
      

        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tsk);
        R2_CLS_TSK_New_SMS_CTRL cse = new R2_CLS_TSK_New_SMS_CTRL(sc);
        cse.telefono='Otro';
        cse.tratarTlf();
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

}
}