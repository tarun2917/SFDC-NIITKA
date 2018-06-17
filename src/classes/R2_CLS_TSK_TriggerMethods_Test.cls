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
public class R2_CLS_TSK_TriggerMethods_Test {
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para el envio de sms
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    18/09/2017             Ismael Yubero Moreno                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
     static testMethod void createTaskTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='SMS_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='SMS_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'SendSMS';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'SendSMS';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        insert acc;
        
        Task tsk = new Task();   
        tsk.WhatId = acc.Id;
        String body = 'Este es el contenido del SMS';
        tsk.Description = body;
        tsk.Status = 'Completed';
        tsk.Type='Sms';
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
            
        insert tsk;
  
        Test.startTest();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    } 

    static testMethod void loginFailTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='SMS_Fail';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='SMS_Fail';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'SendSMS';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'SendSMS';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        insert acc;
        
        Task tsk = new Task();   
        tsk.WhatId = acc.Id;
        String body = 'Este es el contenido del SMS';
        tsk.Description = body;
        tsk.Status = 'Completed';
        tsk.Type='Sms';
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
            
        insert tsk;
  
        Test.startTest();
        
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    } 


    static testMethod void endpointErrorTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='SMS_Fail';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='SMS_Fail';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'SendSMS_Fail';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'SendSMS_Fail';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        insert acc;
        
        Task tsk = new Task();   
        tsk.WhatId = acc.Id;
        String body = 'Este es el contenido del SMS';
        tsk.Description = body;
        tsk.Status = 'Completed';
        tsk.Type='Sms';
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
            
        insert tsk;
  
        Test.startTest();
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    } 

    static testMethod void tlfErrorTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='SMS_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='SMS_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'SendSMS';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'SendSMS';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '';
        insert acc;
        
        Task tsk = new Task();   
        tsk.WhatId = acc.Id;
        String body = 'Este es el contenido del SMS';
        tsk.Description = body;
        tsk.Status = 'Completed';
        tsk.Type='Sms';
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
        System.debug('TLF: "' + tsk.R2_ACT_TLF_Phone__c + '"');
        insert tsk;
  
        Test.startTest();
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    } 


static testMethod void statusTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='SMS_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='SMS_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'SendSMS';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Send TSK';
        lst_ep.add(ep2);

        insert lst_ep;


        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Test';
        acc.PersonBirthdate =  date.today();
        acc.R2_ACC_TLF_Phone_OperativeII__c= '34663084579';
        insert acc;
        
        Task tsk = new Task();   
        tsk.WhatId = acc.Id;
        String body = 'Este es el contenido del SMS';
        tsk.Description = body;
        tsk.Status = 'Completed';
        tsk.Type='Sms';
        tsk.Subject='SMS_'+acc.Name+'_'+date.today().format();
        tsk.R2_ACT_TLF_Phone__c = acc.R2_ACC_TLF_Phone_OperativeII__c;
            
        insert tsk;
  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    } 
    

    static testMethod void exceptionTest(){
        R2_CLS_TSK_TriggerMethods.login();
        R2_CLS_TSK_TriggerMethods.enviarTSK(null);
        R2_CLS_TSK_TriggerMethods.enviarTSKMkt(null,null);
        //R2_CLS_TSK_TriggerMethods.enviarSMSMkt(null, 0);
    }

}