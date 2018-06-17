/*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	07/11/2017				Sara Torres Bermúdez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R2_CLS_PreOrderMethods_Test {
/*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	07/11/2017				Sara Torres Bermúdez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    @isTest
    public static  void comprobarReembolsoPreOrder_Test(){
        R1_CLS_LogHelper.throw_exception = false;
      
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_name__c = 'Account Test';
        incidencia.R2_INC_TXT_lastname1__c = 'LastName';
        incidencia.R2_INC_TXT_lastname2__c = 'LastName2';
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        Set<Id> idCaso = new Set<Id>();
        idCaso.add(caso[0].Id);
        
        R2_CLS_PreOrderMethods.comprobacionesParaReembolso(idCaso);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    22/02/2018              Ismael Yubero  Moreno                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
    public static  void auxCreateCaseExpediente_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_Incident__c> lstInc = new List<R1_Incident__c>();
      
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264531';
        insert incidencia;
        
        lstInc.add(incidencia);
        Test.startTest();
        //List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        //Set<Id> idCaso = new Set<Id>();
        //idCaso.add(caso[0].Id);
        
        R2_CLS_PreOrderMethods.auxCreateCaseExpediente(lstInc);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }



/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    22/02/2018              Ismael Yubero  Moreno                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
    public static  void auxCreateCaseExpediente2_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_Incident__c> lstInc = new List<R1_Incident__c>();
      
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;

        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;

        //Id rtExpediente = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        //Case cas = new Case();
        //cas.RecordTypeId = rtExpediente;
        //cas.Type = 'Servicios gastronomicos';
        //cas.R1_CAS_PKL_Subtype__c = 'Petición datos';
        //cas.R1_CAS_PKL_Idioma__c = 'es';
        //cas.R1_CAS_LOO_Incidences__c = incidencia.Id;
        //cas.R1_CAS_LOO_Flight__c = incidencia.R2_INC_LOO_Flight__c;
        //cas.R1_CAS_Fecha_vuelo__c = Date.valueOf(incidencia.R2_INC_DATH_II_Flight_date__c);
        //cas.R2_CAS_TXT_Flight_number__c = incidencia.R2_INC_FOR_Flight_number__c;
        //cas.R2_CAS_TXT_Flight_Origin__c = incidencia.R2_INC_TXT_II_Depart_flight__c; 
        //cas.R2_CAS_TXT_Flight_Desnity__c = incidencia.R2_INC_TXT_II_Arrival_flight__c;
        //cas.AccountID = incidencia.R1_INC_LOO_II_Client__c;
        //cas.R2_CAS_TXT_Name__c = incidencia.R2_INC_TXT_name__c;
        //cas.R2_CAS_TXT_LastName__c = incidencia.R2_INC_TXT_lastname1__c + ' '+ incidencia.R2_INC_TXT_lastname2__c;
        //cas.R2_CAS_TXT_TKT_Ticket__c = incidencia.R2_INC_TXT_II_TKT__c;
        //cas.R2_CAS_PKL_Class_flown__c = incidencia.R2_INC_PKL_II_Cabin__c;

        //System.debug('Caso: ' + cas);
        //insert cas;
        //Case casPas = new Case();
        //casPas.ParentId = cas.Id;



        
        lstInc.add(incidencia);
        Test.startTest();
        //List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        //Set<Id> idCaso = new Set<Id>();
        //idCaso.add(caso[0].Id);
        
        R2_CLS_PreOrderMethods.auxCreateCaseExpediente(lstInc);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    22/02/2018              Ismael Yubero  Moreno                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
    public static  void auxCreateCaseExpediente3_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<R1_Incident__c> lstInc = new List<R1_Incident__c>();
      
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck2';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck2';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        lstInc.add(incidencia);
        Test.startTest();
        //List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        //Set<Id> idCaso = new Set<Id>();
        //idCaso.add(caso[0].Id);
        
        R2_CLS_PreOrderMethods.auxCreateCaseExpediente(lstInc);

        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void admiteReembolso_Test(){
        R1_CLS_LogHelper.throw_exception = false;

		List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
        ep2.Name='RequestRefund';
        ep2.R1_CHK_Activo__c=true;
        ep2.R1_TXT_EndPoint__c='RequestRefund';
        lst_ep.add(ep2);
        
        R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
        ep3.Name = 'ETL_Login';
        ep3.R1_CHK_Activo__c = true;
        ep3.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep3);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264531';
        insert incidencia;
        
        Test.startTest();
        List<Case> casoEXP = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Expediente'];
        System.debug('Lista de casos expediente: '+ casoEXP);
        List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        System.debug('Lista de casos pasaje: '+ caso);
        R2_CLS_PreOrderMethods.admiteReembolso(caso[0].Id);
        //System.assertEquals('True', result);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void noReembolsarCaso_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;

        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        String result = R2_CLS_PreOrderMethods.noReembolsarCaso(caso[0].Id);
        List<Case> casoNoReemb = [SELECT Id, R1_CAS_PKL_Subtype__c FROM Case WHERE Id =:caso[0].Id];
        System.assertEquals('No corresponde reembolso', casoNoReemb[0].R1_CAS_PKL_Subtype__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void esReembolsable_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       	
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
        ep2.Name='RequestRefund';
        ep2.R1_CHK_Activo__c=true;
        ep2.R1_TXT_EndPoint__c='RequestRefund';
        lst_ep.add(ep2);
        
        R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
        ep3.Name = 'ETL_Login';
        ep3.R1_CHK_Activo__c = true;
        ep3.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep3);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;

        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<Case> caso = [SELECT Id, R2_CAS_TXT_TKT_Ticket__c, R2_CAS_FOR_Flight_number__c, R2_CAS_FOR_Flight_date_local__c, R2_CAS_FOR_Origin__c, R2_CAS_FOR_Destination__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c,R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        String menuPreOrder = R2_CLS_PreOrderMethods.menuPreOrder(caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                
        R2_CLS_PreOrderMethods.WPinfo resp1 = R2_CLS_PreOrderMethods.esReembolsable(caso[0].R2_CAS_TXT_TKT_Ticket__c , caso[0].R2_CAS_FOR_Flight_number__c, caso[0].R2_CAS_FOR_Flight_date_local__c, caso[0].R2_CAS_FOR_Origin__c, caso[0].R2_CAS_FOR_Destination__c, menuPreOrder, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);

        System.assert(resp1!=null);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
	static testMethod void reembolsarCaso_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='PreOrderCheck';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PreOrderCheck';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
        ep2.Name='RequestRefund';
        ep2.R1_CHK_Activo__c=true;
        ep2.R1_TXT_EndPoint__c='RequestRefund';
        lst_ep.add(ep2);
        
        R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
        ep3.Name = 'ETL_Login';
        ep3.R1_CHK_Activo__c = true;
        ep3.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep3);

        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;

        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';

        insert acc;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menús Preorder/A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R1_INC_LOO_II_Client__c = acc.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<Case> caso = [SELECT Id FROM Case WHERE R1_CAS_LOO_Incidences__c =:incidencia.Id AND RecordType.Name = 'Pasaje'];
        String result = R2_CLS_PreOrderMethods.reembolsarCaso(caso[0].Id);
        //List<Case> casoReemb = [SELECT Id, R1_CAS_PKL_Subtype__c FROM Case WHERE Id =:caso[0].Id];
        //System.assertEquals('Reembolso', casoReemb[0].R1_CAS_PKL_Subtype__c);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
 /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
	static testMethod void menuPreOrder1_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'Y/C A la carta mal estado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('TBM', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder2_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'Y/C A la carta baja aceptación';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('BBM', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder3_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'Y/C A la carta mal estado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('No corresponde', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder4_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder falta solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Turista';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('TMM', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder5_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder falta solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('No corresponde', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder6_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta';
        incidencia.R2_INC_PKL_II_Subtype__c = 'J/C Preorder distinto solicitado';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('No corresponde', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void menuPreOrder7_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Airport_depart__c = 'MEX';
        vuelo.R1_FLG_TXT_Airport_arrive__c = 'MAD';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 04, 11);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB6403';
        insert vuelo;
        
        Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        
        R1_Incident__c incidencia = new R1_Incident__c();
        incidencia.RecordTypeId = rtInc;    
        incidencia.R2_INC_PKL_II_Type__c = 'Meal Standard SPML SBP';
        incidencia.R2_INC_PKL_II_Subtype__c = 'SPML no embarcada';
        incidencia.R2_INC_PKL_II_Cabin__c = 'Business';
        incidencia.R2_INC_TXT_II_Depart_flight__c = 'MAD';
        incidencia.R2_INC_TXT_II_Arrival_flight__c = 'MEX';
        incidencia.R2_INC_LOO_Flight__c = vuelo.Id;
        incidencia.R2_INC_TXT_II_TKT__c = '0752000264595';
        insert incidencia;
        
        Test.startTest();
        List<R1_Incident__c> inc = [SELECT Id, R2_INC_PKL_II_Cabin__c, R2_INC_PKL_II_Type__c, R2_INC_PKL_II_Subtype__c FROM R1_Incident__c WHERE Id =:incidencia.Id];
        //String tipo = ;
        String menu = R2_CLS_PreOrderMethods.menuPreOrder(inc[0].R2_INC_PKL_II_Type__c, inc[0].R2_INC_PKL_II_Subtype__c, inc[0].R2_INC_PKL_II_Cabin__c);
        System.assertEquals('', menu);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Ruben Pingarron Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	01/12/2017				Ruben Pingarron Jerez					Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_PreOrderMethods.comprobacionesParaReembolso(null);
        R2_CLS_PreOrderMethods.admiteReembolso(null);
        R2_CLS_PreOrderMethods.noReembolsarCaso(null);
        R2_CLS_PreOrderMethods.esReembolsable(null, null, null, null, null, null, null);
        R2_CLS_PreOrderMethods.reembolsarCaso(null);
        R2_CLS_PreOrderMethods.menuPreOrder(null, null, null);
    }
}