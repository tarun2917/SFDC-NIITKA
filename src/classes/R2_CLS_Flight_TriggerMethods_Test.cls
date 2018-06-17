/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Apex test para la clase apex 'R2_CLS_Flight_TriggerMethods'

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    23/08/2017                 Ismael Yubero Moreno    Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

@isTest
public class R2_CLS_Flight_TriggerMethods_Test {
   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Método test para la obtención de una lista de pasajeros

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    23/08/2017                 Ismael Yubero Moreno    Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

   static testMethod void getPassengers_Test(){

        R1_CLS_LogHelper.throw_exception = false;

        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='PasajerosVuelo';
        ep.R1_CHK_Activo__c = true;
        ep.R1_TXT_EndPoint__c='PasajerosVuelo';
        insert ep;
		/*
       system.debug('----------------1--------------------');
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
			*/
        R1_Flight__c vuelo = new R1_Flight__c();

       	vuelo.R1_FLG_TXT_Flight_number__c = '0123';
        //vuelo.R1_FLG_TXT_Airport_depart_name__c = 'MAD';
        vuelo.Name = 'IB311020170629';
        vuelo.R1_FLG_TXT_Origin__c = 'Origen';
        vuelo.R1_FLG_TXT_Destination__c= 'Destination';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
        vuelo.R1_FLG_DAT_Flight_date_local__c =  Date.newInstance(2017, 11, 21);
        insert vuelo;

        List<Account> lstAcc = new List<Account>();

        Account acc1 =  new Account();
        acc1.LastName = 'ClienteTest1';
        acc1.PersonEmail= 'test1@test.com';
        acc1.R1_ACC_PKL_Gender_description__c= 'M';
        acc1.R1_ACC_TLF_Phone_Marketing__c = '1234567890';
        acc1.R1_ACC_TXT_Identification_number__c = '1234567890';
        lstAcc.add(acc1);

        Account acc2 =  new Account();
        acc2.LastName = 'ClienteTest2';
        acc2.PersonEmail= 'test2@test.com';
        acc2.R1_ACC_PKL_Gender_description__c= 'M';
        acc2.R1_ACC_TLF_Phone_Marketing__c = '1234567892';
        acc2.R1_ACC_TXT_Identification_number__c = '1234567892';
        lstAcc.add(acc2);

        Account acc3 =  new Account();
        acc3.LastName = 'ClienteTest3';
        acc3.PersonEmail= 'test3@test.com';
        acc3.R1_ACC_PKL_Gender_description__c= 'M';
        acc3.R1_ACC_TLF_Phone_Marketing__c = '1234567893';
        acc3.R1_ACC_TXT_Identification_number__c = '1234567893';
        lstAcc.add(acc3);

        Account acc4 =  new Account();
        acc4.LastName = 'ClienteTest4';
        acc4.PersonEmail= 'test4@test.com';
        acc4.R1_ACC_PKL_Gender_description__c= 'M';
        acc4.R1_ACC_TLF_Phone_Marketing__c = '1234567894';
        acc4.R1_ACC_TXT_Identification_number__c = '1234567894';
        lstAcc.add(acc4);

        Account acc5 =  new Account();
        acc5.LastName = 'ClienteTest5';
        acc5.PersonEmail= 'test5@test.com';
        acc5.R1_ACC_PKL_Gender_description__c= 'M';
        acc5.R1_ACC_TLF_Phone_Marketing__c = '1234567895';
        acc5.R1_ACC_TXT_Identification_number__c = '1234567895';
        lstAcc.add(acc5);

        insert lstAcc;

        List<R2_CKI_info__c> lstPass = new List<R2_CKI_info__c>();

        R2_CKI_info__c pass1 = new R2_CKI_info__c();
        pass1.Name = 'Pasajero1';
        pass1.R2_CKI_TXT_Origin__c='Origen';
        pass1.R2_CKI_LOO_Account__c=lstAcc[0].Id;
        pass1.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass1);

        R2_CKI_info__c pass2 = new R2_CKI_info__c();
        pass2.Name = 'Pasajero2';
        pass2.R2_CKI_TXT_Origin__c='Origen';
        pass2.R2_CKI_LOO_Account__c=lstAcc[1].Id;
        pass2.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass2);

        R2_CKI_info__c pass3 = new R2_CKI_info__c();
        pass3.Name = 'Pasajero3';
        pass3.R2_CKI_TXT_Origin__c='Origen';
        pass3.R2_CKI_LOO_Account__c=lstAcc[2].Id;
        pass3.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass3);

        R2_CKI_info__c pass4 = new R2_CKI_info__c();
        pass4.Name = 'Pasajero4';
        pass4.R2_CKI_TXT_Origin__c='Origen';
        pass4.R2_CKI_LOO_Account__c=lstAcc[3].Id;
        pass4.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass4);

        R2_CKI_info__c pass5 = new R2_CKI_info__c();
        pass5.Name = 'Pasajero5';
        pass5.R2_CKI_TXT_Origin__c='Origen';
        pass5.R2_CKI_LOO_Account__c=lstAcc[4].Id;
        pass5.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass5);

        insert lstPass;


        R2_CLS_Flight_TriggerMethods.listaPasajeros(vuelo.ID);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

static testMethod void failGetPassengers(){

	R1_CLS_LogHelper.throw_exception = false;

        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='PasajerosVuelo';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='PasajerosVuelo';
        insert ep;

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;

        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.R1_FLG_TXT_Flight_number__c = '0111';
        vuelo.R1_FLG_TXT_Airport_depart_name__c = 'BAR';
        vuelo.Name = 'IB311020170629';
        vuelo.R1_FLG_TXT_Origin__c = 'Origen';
        vuelo.R1_FLG_TXT_Destination__c= 'Destination';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
        vuelo.R1_FLG_DAT_Flight_date_local__c =  Date.newInstance(2017, 7, 2);
        insert vuelo;

        List<Account> lstAcc = new List<Account>();

        Account acc1 =  new Account();
        acc1.LastName = 'ClienteTest1';
        acc1.PersonEmail= 'test1@test.com';
        acc1.R1_ACC_PKL_Gender_description__c= 'M';
        acc1.R1_ACC_TLF_Phone_Marketing__c = '1234567890';
        acc1.R1_ACC_TXT_Identification_number__c = '1234567890';
        lstAcc.add(acc1);

        Account acc2 =  new Account();
        acc2.LastName = 'ClienteTest2';
        acc2.PersonEmail= 'test2@test.com';
        acc2.R1_ACC_PKL_Gender_description__c= 'M';
        acc2.R1_ACC_TLF_Phone_Marketing__c = '1234567892';
        acc2.R1_ACC_TXT_Identification_number__c = '1234567892';
        lstAcc.add(acc2);

        Account acc3 =  new Account();
        acc3.LastName = 'ClienteTest3';
        acc3.PersonEmail= 'test3@test.com';
        acc3.R1_ACC_PKL_Gender_description__c= 'M';
        acc3.R1_ACC_TLF_Phone_Marketing__c = '1234567893';
        acc3.R1_ACC_TXT_Identification_number__c = '1234567893';
        lstAcc.add(acc3);

        Account acc4 =  new Account();
        acc4.LastName = 'ClienteTest4';
        acc4.PersonEmail= 'test4@test.com';
        acc4.R1_ACC_PKL_Gender_description__c= 'M';
        acc4.R1_ACC_TLF_Phone_Marketing__c = '1234567894';
        acc4.R1_ACC_TXT_Identification_number__c = '1234567894';
        lstAcc.add(acc4);

        Account acc5 =  new Account();
        acc5.LastName = 'ClienteTest5';
        acc5.PersonEmail= 'test5@test.com';
        acc5.R1_ACC_PKL_Gender_description__c= 'M';
        acc5.R1_ACC_TLF_Phone_Marketing__c = '1234567895';
        acc5.R1_ACC_TXT_Identification_number__c = '1234567895';
        lstAcc.add(acc5);

        insert lstAcc;

        List<R2_CKI_info__c> lstPass = new List<R2_CKI_info__c>();

        R2_CKI_info__c pass1 = new R2_CKI_info__c();
        pass1.Name = 'Pasajero1';
        pass1.R2_CKI_TXT_Origin__c='Origen';
        pass1.R2_CKI_LOO_Account__c=lstAcc[0].Id;
        pass1.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass1);

        R2_CKI_info__c pass2 = new R2_CKI_info__c();
        pass2.Name = 'Pasajero2';
        pass2.R2_CKI_TXT_Origin__c='Origen';
        pass2.R2_CKI_LOO_Account__c=lstAcc[1].Id;
        pass2.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass2);

        R2_CKI_info__c pass3 = new R2_CKI_info__c();
        pass3.Name = 'Pasajero3';
        pass3.R2_CKI_TXT_Origin__c='Origen';
        pass3.R2_CKI_LOO_Account__c=lstAcc[2].Id;
        pass3.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass3);

        R2_CKI_info__c pass4 = new R2_CKI_info__c();
        pass4.Name = 'Pasajero4';
        pass4.R2_CKI_TXT_Origin__c='Origen';
        pass4.R2_CKI_LOO_Account__c=lstAcc[3].Id;
        pass4.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass4);

        R2_CKI_info__c pass5 = new R2_CKI_info__c();
        pass5.Name = 'Pasajero5';
        pass5.R2_CKI_TXT_Origin__c='Origen';
        pass5.R2_CKI_LOO_Account__c=lstAcc[4].Id;
        pass5.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass5);

        insert lstPass;


        R2_CLS_Flight_TriggerMethods.listaPasajeros(vuelo.ID);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        //System.debug('##RP## Errores: ' + [SELECT CreatedById,CreatedDate,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,OwnerId,R1_LOG_ATXTL_MensajeError__c,R1_LOG_ATXT_Comentario__c,R1_LOG_TXT_Metodo__c,R1_LOG_TXT_Objeto__c,R1_LOG_TXT_RegAsociado__c FROM R1_Log__c]);
    }

static testMethod void failLogin(){
	R1_CLS_LogHelper.throw_exception = false;

        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='PasajerosVuelo';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='PasajerosVuelo';
        insert ep;

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'Mal_ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLoginMal';
        insert ep2;

        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.R1_FLG_TXT_Flight_number__c = '0111';
        vuelo.R1_FLG_TXT_Airport_depart_name__c = 'BAR';
        vuelo.Name = 'IB311020170629';
        vuelo.R1_FLG_TXT_Origin__c = 'Origen';
        vuelo.R1_FLG_TXT_Destination__c= 'Destination';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
        vuelo.R1_FLG_DAT_Flight_date_local__c =  Date.newInstance(2017, 7, 2);
        insert vuelo;

        List<Account> lstAcc = new List<Account>();

        Account acc1 =  new Account();
        acc1.LastName = 'ClienteTest1';
        acc1.PersonEmail= 'test1@test.com';
        acc1.R1_ACC_PKL_Gender_description__c= 'M';
        acc1.R1_ACC_TLF_Phone_Marketing__c = '1234567890';
        acc1.R1_ACC_TXT_Identification_number__c = '1234567890';
        lstAcc.add(acc1);

        Account acc2 =  new Account();
        acc2.LastName = 'ClienteTest2';
        acc2.PersonEmail= 'test2@test.com';
        acc2.R1_ACC_PKL_Gender_description__c= 'M';
        acc2.R1_ACC_TLF_Phone_Marketing__c = '1234567892';
        acc2.R1_ACC_TXT_Identification_number__c = '1234567892';
        lstAcc.add(acc2);

        Account acc3 =  new Account();
        acc3.LastName = 'ClienteTest3';
        acc3.PersonEmail= 'test3@test.com';
        acc3.R1_ACC_PKL_Gender_description__c= 'M';
        acc3.R1_ACC_TLF_Phone_Marketing__c = '1234567893';
        acc3.R1_ACC_TXT_Identification_number__c = '1234567893';
        lstAcc.add(acc3);

        Account acc4 =  new Account();
        acc4.LastName = 'ClienteTest4';
        acc4.PersonEmail= 'test4@test.com';
        acc4.R1_ACC_PKL_Gender_description__c= 'M';
        acc4.R1_ACC_TLF_Phone_Marketing__c = '1234567894';
        acc4.R1_ACC_TXT_Identification_number__c = '1234567894';
        lstAcc.add(acc4);

        Account acc5 =  new Account();
        acc5.LastName = 'ClienteTest5';
        acc5.PersonEmail= 'test5@test.com';
        acc5.R1_ACC_PKL_Gender_description__c= 'M';
        acc5.R1_ACC_TLF_Phone_Marketing__c = '1234567895';
        acc5.R1_ACC_TXT_Identification_number__c = '1234567895';
        lstAcc.add(acc5);

        insert lstAcc;

        List<R2_CKI_info__c> lstPass = new List<R2_CKI_info__c>();

        R2_CKI_info__c pass1 = new R2_CKI_info__c();
        pass1.Name = 'Pasajero1';
        pass1.R2_CKI_TXT_Origin__c='Origen';
        pass1.R2_CKI_LOO_Account__c=lstAcc[0].Id;
        pass1.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass1);

        R2_CKI_info__c pass2 = new R2_CKI_info__c();
        pass2.Name = 'Pasajero2';
        pass2.R2_CKI_TXT_Origin__c='Origen';
        pass2.R2_CKI_LOO_Account__c=lstAcc[1].Id;
        pass2.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass2);

        R2_CKI_info__c pass3 = new R2_CKI_info__c();
        pass3.Name = 'Pasajero3';
        pass3.R2_CKI_TXT_Origin__c='Origen';
        pass3.R2_CKI_LOO_Account__c=lstAcc[2].Id;
        pass3.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass3);

        R2_CKI_info__c pass4 = new R2_CKI_info__c();
        pass4.Name = 'Pasajero4';
        pass4.R2_CKI_TXT_Origin__c='Origen';
        pass4.R2_CKI_LOO_Account__c=lstAcc[3].Id;
        pass4.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass4);

        R2_CKI_info__c pass5 = new R2_CKI_info__c();
        pass5.Name = 'Pasajero5';
        pass5.R2_CKI_TXT_Origin__c='Origen';
        pass5.R2_CKI_LOO_Account__c=lstAcc[4].Id;
        pass5.R2_CKI_LOO_Flight__c = vuelo.ID;
        lstPass.add(pass5);

        insert lstPass;


        R2_CLS_Flight_TriggerMethods.listaPasajeros(vuelo.ID);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


static testMethod void exceptionTest(){
     	R2_CLS_Flight_TriggerMethods.listaPasajeros(null);
     	R2_CLS_Flight_TriggerMethods.getPassengerFromResiber(null, null, null, null);

    }
}