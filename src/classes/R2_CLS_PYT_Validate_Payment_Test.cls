@isTest
public with sharing class R2_CLS_PYT_Validate_Payment_Test {
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la integracion de validacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    07/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePayment_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos';
        lst_ep.add(ep2);

        insert lst_ep;

        String wrapper = '{"customerName":"IberiaL.A.ES.A.","financialInstitution":"BancoSantander","countryCode":"ES","bankKey":"00491500","bankAccountNumber":"2010138058","bankControlKey":"01","swift":"BSCHESMM","iban":"ES3200491500002010138058","postalCode":"28033","street":"MartinezVillerga","city":"Madrid"}';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.startTest();
        R2_CLS_PYT_Validate_Payment.validatePayment(wrapper, 0);
        
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la integracion de validacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    07/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePayment401_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos401';
        lst_ep.add(ep2);

        insert lst_ep;

        String wrapper = '{"customerName":"IberiaL.A.ES.A.","financialInstitution":"BancoSantander","countryCode":"ES","bankKey":"00491500","bankAccountNumber":"2010138058","bankControlKey":"01","swift":"BSCHESMM","iban":"ES3200491500002010138058","postalCode":"28033","street":"MartinezVillerga","city":"Madrid"}';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.startTest();
        R2_CLS_PYT_Validate_Payment.validatePayment(wrapper, 0);
        
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir la integracion de validacion del pago
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    07/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validatePaymentBagLogin_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='ETL_Login';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='ETL_Login';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Pagos';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'Pagos401';
        lst_ep.add(ep2);

        insert lst_ep;

        String wrapper = '{"customerName":"IberiaL.A.ES.A.","financialInstitution":"BancoSantander","countryCode":"ES","bankKey":"00491500","bankAccountNumber":"2010138058","bankControlKey":"01","swift":"BSCHESMM","iban":"ES3200491500002010138058","postalCode":"28033","street":"MartinezVillerga","city":"Madrid"}';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.startTest();
        R2_CLS_PYT_Validate_Payment.validatePayment(wrapper, 3);
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para cubrir las excepciones
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    07/03/2018            Ismael Yubero Moreno          Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CLS_PYT_Validate_Payment.validatePayment(null, null);
        
    }
}