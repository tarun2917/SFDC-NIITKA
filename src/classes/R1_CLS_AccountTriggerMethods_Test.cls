/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Clase apex test para la clase R1_CLS_AccountTriggersMethods()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    30/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_CLS_AccountTriggerMethods_Test {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion callIntegrationMDM()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/03/2018             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void callIntegrationMDM_Insert_contactNull_Test(){
        R1_CLS_LogHelper.throw_exception = false;
  
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c ='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'R1_MDM_registerCustomer';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'R1_MDM_registerCustomer';
        lst_ep.add(ep2);
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;

        Account newAcc = new Account();
        newAcc.RecordTypeId = recordTypeIdAcc;
        newAcc.LastName = 'CuentaNueva';
        newAcc.FirstName = 'Abc';
        newAcc.PersonBirthdate = date.newInstance(1998, 10, 21);
        
        Test.startTest();
        insert newAcc;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion callIntegrationMDM()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/03/2018             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void callIntegrationMDM_Insert_Test(){
        R1_CLS_LogHelper.throw_exception = false;
  
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'R1_MDM_registerCustomer';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'R1_MDM_registerCustomer';
        lst_ep.add(ep2);
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;

        Account newAcc = new Account();
        newAcc.RecordTypeId = recordTypeIdAcc;
        newAcc.LastName = 'CuentaNueva';
        newAcc.FirstName = 'Abc';
        newAcc.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '+912141241';
        newAcc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        newAcc.PersonEmail = 'test@test.com';
        newAcc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '42343242';
        newAcc.R1_ACC_TXT_Identification_number__c = '4325232';
        
        Test.startTest();
        insert newAcc;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion callIntegrationMDM()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/03/2018             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void createPackageNull_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Test.startTest();
        R1_CLS_SendCustomerMDM.createPackage(null);
        Test.stopTest();
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion callIntegrationMDM()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/03/2018             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void callIntegrationMDM_Update_Test(){
        R1_CLS_LogHelper.throw_exception = false;
  
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'R1_MDM_registerCustomer';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'R1_MDM_registerCustomer';
        lst_ep.add(ep2);
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;

        Account newAcc = new Account();
        newAcc.RecordTypeId = recordTypeIdAcc;
        newAcc.LastName = 'CuentaNueva';
        newAcc.FirstName = 'Abc';
        newAcc.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '+912141241';
        newAcc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert newAcc;

        Test.startTest();
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@easdlope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '+912781241';
        newAcc.R1_ACC_TXT_Id_Golden_record__c = '111';
        update newAcc;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

        /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion callIntegrationMDM()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/03/2018             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void callIntegrationMDM_Delete_Test(){
        R1_CLS_LogHelper.throw_exception = false;
  
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'R1_MDM_registerCustomer';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'R1_MDM_registerCustomer';
        lst_ep.add(ep2);
        insert lst_ep;

        TimeOut_Integrations__c timeCS = new TimeOut_Integrations__c();
        timeCS.Name = 'MDM_online';
        timeCS.setTimeOut__c = 3500;
        insert timeCS;

        Account newAcc = new Account();
        newAcc.RecordTypeId = recordTypeIdAcc;
        newAcc.LastName = 'CuentaNueva';
        newAcc.FirstName = 'Abc';
        newAcc.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '+912141241';
        newAcc.R1_ACC_TLF_Phone_Operative__c = '244242424';
        insert newAcc;

        Test.startTest();
        newAcc.R1_ACC_CHK_Unsubscribe__c = true;
        update newAcc;
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion formatPhones() cuando el telefono Operacion empiece por '+'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/10/2017             Sara Torres Bermudez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void formatPhones_Test(){
        R1_CLS_LogHelper.throw_exception = false;
  
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        
        Account newAcc = new Account();
        newAcc.RecordTypeId = recordTypeIdAcc;
        newAcc.LastName = 'CuentaNueva';
        newAcc.FirstName = 'Abc';
        newAcc.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        newAcc.R1_ACC_TLF_Phone_Operative__c = '+244242424';
        
        Test.startTest();
        insert newAcc;
        newAcc.R1_ACC_TXT_Email_Operative__c = 'acc@easdlope.com';
        newAcc.R1_ACC_TLF_Phone_Marketing__c = '912781241';
        update newAcc;
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
    30/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R1_CLS_AccountTriggerMethods.callIntegrationMDM(null, null);
        R1_CLS_AccountTriggerMethods.formatPhones(null);
        R1_CLS_AccountTriggerMethods.checkToMarketingCloud(null);
    }
    
        /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alejandro Turiégano
    Company:        Accenture
    Description:    Test Method to cover checkToMarketingCloud method with R2_ACC_CHK_Marketing_Cloud__c result as false

    IN:
    OUT:

    History:
    <Date>                     <Author>                     <Change Description>
    30/11/2017                 Alejandro Turiégano          Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void checkToMarketingCloud1(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE DeveloperName like 'PersonAccount' LIMIT 1].Id;
        Account newAcc2 = R1_CLS_Utilities.helper_Account_constructor();
        newAcc2.RecordTypeId = recordTypeIdAcc;
        newAcc2.LastName = 'CuentaNueva2';
        newAcc2.FirstName = 'Abc';
        newAcc2.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc2.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc2.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc2.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        newAcc2.R1_ACC_TLF_Phone_Operative__c = '244242424';
        newAcc2.PersonEmail = '';
        newAcc2.Phone = '';

        Test.startTest();
        insert newAcc2;

        List <Account> cuenta = [SELECT R2_ACC_CHK_Marketing_Cloud__c FROM Account WHERE Id =:newAcc2.Id];
        Test.stopTest();
        System.assertEquals(false,cuenta[0].R2_ACC_CHK_Marketing_Cloud__c);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alejandro Turiégano
    Company:        Accenture
    Description:    Test Method to cover checkToMarketingCloud method with R2_ACC_CHK_Marketing_Cloud__c result as true

    IN:
    OUT:

    History:
    <Date>                     <Author>                     <Change Description>
    30/11/2017                 Alejandro Turiégano          Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void checkToMarketingCloud2(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE DeveloperName like 'PersonAccount' LIMIT 1].Id;

        Account newAcc3 = R1_CLS_Utilities.helper_Account_constructor();
        newAcc3.RecordTypeId = recordTypeIdAcc;
        newAcc3.LastName = 'CuentaNueva2';
        newAcc3.FirstName = 'Abc';
        newAcc3.PersonBirthdate = date.newInstance(1998, 10, 21);
        newAcc3.R1_ACC_EMA_Marketing_Email__c = 'acc@emailmark.com';
        newAcc3.R1_ACC_TXT_Email_Operative__c = 'acc@emailope.com';
        newAcc3.R1_ACC_TLF_Phone_Marketing__c = '912141241';
        newAcc3.R1_ACC_TLF_Phone_Operative__c = '244242424';
        newAcc3.PersonEmail = 'acc@emailmark.com';

        Test.startTest();
        insert newAcc3;
        System.debug(newAcc3.id);

        List <Account> cuenta = [SELECT R2_ACC_CHK_Marketing_Cloud__c FROM Account WHERE Id =:newAcc3.Id];
        Test.stopTest();
        System.assertEquals(true,cuenta[0].R2_ACC_CHK_Marketing_Cloud__c);
    }
    
    @isTest
    static void bajaGDPRAll()
    {
        //Account cuenta = R1_CLS_Utilities.helper_Account_constructor();
        Account acc = new Account();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            acc.RecordTypeId = recordTypeId;
            acc.LastName = 'ClienteTest';
            acc.PersonEmail = 'test@test.com';
            acc.R1_ACC_PKL_Gender_description__c = 'M';
            acc.R1_ACC_PKL_identification_Type__c = '02';
            acc.R1_ACC_TXT_Identification_number__c = '123456789';
            acc.PersonBirthdate = Date.valueOf('1982-11-16');
            acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
            acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
            acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567'; 
            acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
            acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';
        	acc.R2_ACC_CHK_GDPR_UnSub__c  = false;
		insert acc; 
        R1_Marketing_permission__c marketing = new R1_Marketing_permission__c();
        marketing.R1_MP_LOO_Client__c = acc.id;
        marketing.R1_MP_PKL_Type_of_communication__c = 'All';
   		insert marketing;
        acc.R2_ACC_CHK_GDPR_UnSub__c  = true;
        Test.startTest();
        update acc;
        List<R1_Marketing_permission__c> lstMkt2 =[SELECT id,R1_MP_CHK_Flag_enabled__c,R2_MP_CHK_Update_Control__c from R1_Marketing_Permission__c where R1_MP_LOO_Client__c = :acc.id];
        System.assertEquals(true, lstMkt2[0].R1_MP_CHK_Flag_enabled__c);
        Test.stopTest();
    }

    @isTest
    static void bajaGDPRnoAll()
    {
        //Account cuenta = R1_CLS_Utilities.helper_Account_constructor();
        Account acc = new Account();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            acc.RecordTypeId = recordTypeId;
            acc.LastName = 'ClienteTest';
            acc.PersonEmail = 'test@test.com';
            acc.R1_ACC_PKL_Gender_description__c = 'M';
            acc.R1_ACC_PKL_identification_Type__c = '02';
            acc.R1_ACC_TXT_Identification_number__c = '123456789';
            acc.PersonBirthdate = Date.valueOf('1982-11-16');
            acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
            acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
            acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567'; 
            acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
            acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';
        	acc.R2_ACC_CHK_GDPR_UnSub__c  = false;
		insert acc; 
        R1_Marketing_permission__c marketing = new R1_Marketing_permission__c();
        marketing.R1_MP_LOO_Client__c = acc.id;
        marketing.R1_MP_PKL_Type_of_communication__c = 'API';
   		insert marketing;
        acc.R2_ACC_CHK_GDPR_UnSub__c  = true;
        Test.startTest();
        update acc;
        List<R1_Marketing_permission__c> lstMkt2 =[SELECT id,R1_MP_CHK_Flag_enabled__c,R2_MP_CHK_Update_Control__c from R1_Marketing_Permission__c where R1_MP_LOO_Client__c = :acc.id];
        System.assertEquals(false, lstMkt2[0].R1_MP_CHK_Flag_enabled__c);
        Test.stopTest();
    }
    
    @isTest
    static void filtrarAccountGDPR()
    {
         Account acc = new Account();
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            acc.RecordTypeId = recordTypeId;
            acc.LastName = 'ClienteTest';
            acc.PersonEmail = 'test@test.com';
            acc.R1_ACC_PKL_Gender_description__c = 'M';
            acc.R1_ACC_PKL_identification_Type__c = '02';
            acc.R1_ACC_TXT_Identification_number__c = '123456789';
            acc.PersonBirthdate = Date.valueOf('1982-11-16');
            acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
            acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
            acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567'; 
            acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
            acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';
        	acc.R2_ACC_CHK_GDPR_UnSub__c  = false;
        	acc.R2_CON_CHK_Marketing_Cloud__PC = false;
        	acc.R2_ACC_CHK_Marketing_Cloud__c = false;
		insert acc; 
        acc.LastName ='LastName';
        Test.startTest();
        update acc;
        Test.stopTest();
        
    }
}