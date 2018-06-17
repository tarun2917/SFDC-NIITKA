@IsTest
public class R2_CLS_MP_TriggerMethods_Test {

    static Account cuenta()
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
        return acc;
    }

    @IsTest
    static void general()
    {
        Account acc = cuenta();
        insert acc;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=true;
        mp.R1_MP_CHK_Flag_enabled__c = true;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
            Test.startTest();
            update mp;
            Test.stopTest();
    }

    @IsTest
    static void exception_test(){
        R1_CLS_LogHelper.throw_exception = true;
        R2_CLS_MP_TriggerMethods.enviarIBCOM(null,0);
        R2_CLS_MP_TriggerMethods.getAllMP(null,null);
        R2_CLS_MP_TriggerMethods.comprobarbajaGDPR(null);
        R2_CLS_MP_TriggerMethods.filtrarPermisosMKT(null);
        R2_CLS_MP_TriggerMethods.filtrarPermisosMKTFalse(null);
        R2_CLS_MP_TriggerMethods.formatearFecha(null);
        
    }
      
    @IsTest
    static void actualizarAll()
    {
        Account acc = cuenta();
        insert acc;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=true;
        mp.R1_MP_CHK_Flag_enabled__c = true;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
        User u =[Select id from User where Name='MC System User'];
        System.runAs(u)
        {
            Test.startTest();
            update mp;
            Test.stopTest();
        }
    }
    
    @IsTest
    static void enviarMPAIBCOMffnull()
    {
        R1_CLS_LogHelper.throw_exception = false;
        Account acc =cuenta();
        insert acc;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=false;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
        Test.startTest();
        update mp;
        Test.stopTest();
    }
 
    @IsTest
    static void enviarMPAIBCOMcachenull()
    {
        R1_CLS_LogHelper.throw_exception = false;
        Account acc =cuenta();
        insert acc;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=false;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
        Test.startTest();
        update mp;
        Test.stopTest();
    } 

    @IsTest
    static void enviarMPAIBCOMtoken()
    {
        R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c loginEp = new R1_CS_Endpoints__c();
        loginEp.Name = 'ETL_Login';
        loginEp.R1_CHK_Activo__c = true;
        loginEp.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert loginEp;

        R1_CS_Endpoints__c loginEp2 = new R1_CS_Endpoints__c();
        loginEp2.Name = 'marketingPermissionsIBCOM';
        loginEp2.R1_CHK_Activo__c = true;
        loginEp2.R1_TXT_EndPoint__c = 'marketingPermissionsIBCOM_test_endpoint';
        insert loginEp2;

        Account acc =cuenta();
        acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c ='0987654321';
        insert acc;
        //R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        //ep2.Name = 'Login';
        //ep2.R1_CHK_Activo__c = true;
        //ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        //insert ep2;
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=false;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
        Test.startTest();
        update mp;
        Test.stopTest();
    }

    @IsTest
    static void comprobarbajaGDPR()
    {
        Account acc = cuenta();
        insert acc;
        R1_Marketing_permission__c mp2 = new R1_Marketing_permission__c();
        mp2.R1_MP_LOO_Client__c =acc.id;
        mp2.R1_MP_CHK_Flag_enabled__c = true;
        mp2.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp2;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R1_MP_LOO_Client__c =acc.id;
        mp.R1_MP_CHK_Flag_enabled__c = true;
        mp.R1_MP_PKL_Type_of_communication__c = 'All';
        insert mp;
        Test.startTest();
        update mp2;
        update mp;
        Test.stopTest();     
    }
    
    @IsTest
    static void actualizarMPTrue()
    {
        Account acc = cuenta();
        insert acc;
        R1_Marketing_permission__c mp = new R1_Marketing_permission__c();
        mp.R2_MP_CHK_Update_Control__c=true;
        mp.R1_MP_CHK_Flag_enabled__c = true;
        mp.R1_MP_PKL_Type_of_communication__c = 'API';
        insert mp;
        mp.R1_MP_LOO_Client__c =acc.id;
        Test.startTest();
            update mp;
        Test.stopTest();
    }
}