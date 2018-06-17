/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Apex test para la clase 'R1_CLS_SendCustomerMDM'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    @isTest
    private class R1_CLS_SendCustomerMDM_Test {


    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion createPackage()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void createPackage_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        
        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest(); 
        insert acc;
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion login()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void login_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
            R1_CLS_SendCustomerMDM.login();

        
        Test.stopTest();
        
       System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion login()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void login_NoActive_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'ETL_Login';
        ep.R1_CHK_Activo__c = false;
        ep.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();

            R1_CLS_SendCustomerMDM.login();

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion registerCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void registerCustomer_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        
            Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
            //insert acc;
            R1_CLS_SendCustomerMDM.registerCustomer(acc.Id, 0);
            
        Test.stopTest();
        
       System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion registerCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    29/05/2017             Alvaro Garcia Tapia                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void registerCustomer_ErrorAuthoritation_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomerError';
        lst_ep.add(ep);

        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        
            Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
            R1_CLS_SendCustomerMDM.registerCustomer(acc.Id, 0);
            
        Test.stopTest();
       
        System.assert(0 < [SELECT count() FROM R1_Log__c]);

    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion registerCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void registerCustomer_ContadorSuperado_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Integer contador = 3;
        R1_CLS_SendCustomerMDM.registerCustomer(acc.Id, contador);
        
        Test.stopTest();
        
        System.assert(0<[SELECT count() FROM R1_Log__c]);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion registerCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void registerCustomer_NotActive_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        //insert acc;
        
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = false;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        insert ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        insert acc;
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion updateCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void updateCustomer_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        acc.R1_ACC_TLF_Phone_Operative__c = '124141241';
        
        bpass.R1_CHK_skip_trigger__c = false;
        update bpass;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        update acc;
        
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion updateCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void updateCustomer_ContadorSuperado_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        acc.R1_ACC_TLF_Phone_Operative__c = '124141241';
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();
        //update acc;
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Integer contador = 3;
        R1_CLS_SendCustomerMDM.updateCustomer(acc.Id, contador);
        
        Test.stopTest();
        
        System.assert(0<[SELECT count() FROM R1_Log__c] );
        
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion updateCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    29/05/2017             Alvaro Garcia Tapia                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void updateCustomer_ErrorAuthoritation_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta Personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        acc.R1_ACC_TLF_Phone_Operative__c = '124141241';

        bpass.R1_CHK_skip_trigger__c = false;
        update bpass;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomerError';
        lst_ep.add(ep);
        
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
            update acc;

        Test.stopTest();
		
        //System.assert(0<[SELECT count() FROM R1_Log__c] );
 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion updateCustomer()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    29/05/2017             Alvaro Garcia Tapia                     Added mock
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void updateCustomer_NotActive_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert acc;
        acc.R1_ACC_TLF_Phone_Operative__c = '124141241';

        bpass.R1_CHK_skip_trigger__c = false;
        update bpass;
        
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name = 'R1_MDM_registerCustomer';
        ep.R1_CHK_Activo__c = false;
        ep.R1_TXT_EndPoint__c = 'PruebaSendCustomer';
        insert ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        update acc;
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
    19/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        /*Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'Abc';
        acc.FirstName = 'Abc';
        date diaBirth = date.newInstance(1998, 10, 21);
        acc.R1_ACC_DAT_Date_birth__c = diaBirth;
        acc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        //acc.R1_ACC_EMA_Email_Operative__c = 'acc@emailope.com';
        acc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        acc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        //insert acc;
          
        insert acc;
        acc.R1_ACC_TLF_Phone_Marketing__c = '144124111';
        update acc;
        */

        Test.startTest();
        
            Integer contador = 0;
            R1_CLS_SendCustomerMDM.createPackage(null);
            R1_CLS_SendCustomerMDM.login();
            R1_CLS_SendCustomerMDM.callUpdate(null, contador, null);
            R1_CLS_SendCustomerMDM.registerCustomer(null, contador);
            R1_CLS_SendCustomerMDM.updateCustomer(null, contador);
            R1_CLS_SendCustomerMDM.deleteCustomer(null, contador);
        
        Test.stopTest(); 
    }
}