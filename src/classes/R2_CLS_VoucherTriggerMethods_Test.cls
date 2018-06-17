/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                  <Author>                         <Change Description>
	20/12/2017             	Jaime Ascanta          						Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_VoucherTriggerMethods_Test {

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void relateVoucher_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;
		Id rtAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;

		Account acc = new Account();
		acc.RecordTypeId = rtAcc;
		acc.LastName = 'ClienteTest';
		acc.PersonEmail = 'test@test.com';
		acc.R1_ACC_PKL_Gender_description__c = 'M';
		acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
		acc.R1_ACC_PKL_identification_Type__c = '02';
		acc.R1_ACC_TXT_Identification_number__c = '123456789';
		insert  acc;

		R1_Flight__c vuelo = new R1_Flight__c();
    	vuelo.Name = 'VueloTest';
    	vuelo.R1_FLG_TXT_Origin__c = 'MAD';
    	vuelo.R1_FLG_TXT_Destination__c = 'BCN';
    	vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
    	vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2018, 01, 20);
    	vuelo.R1_FLG_TXT_Flight_number__c = '1234';
		vuelo.R1_FLG_TXT_External_ID__c = 'IB123401202018MAD';
    	insert vuelo;


		R1_Incident__c inc = new R1_Incident__c();
		inc.R1_INC_LOO_Client__c = acc.Id;
		inc.R2_INC_LOO_Flight__c = vuelo.Id;
		inc.R2_INC_TXT_MI_Incident_External_ID__c = 'IB123401202018MADCNL1';
		insert inc;

		List<R2_Voucher__c> listVou = new List<R2_Voucher__c>();

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.R2_VOU_LOO_Client__c = acc.Id;
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CNL';
		listVou.add(vou);

		R2_Voucher__c vou2 = new R2_Voucher__c();
		vou2.R2_VOU_LOO_Client__c = acc.Id;
		vou2.RecordTypeId = rtHTR;
		vou2.R2_VOU_TXT_Origin__c = 'MAD';
		vou2.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou2.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou2.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou2.R2_VOU_TXT_Passenger_Reason__c = 'CN';
		listVou.add(vou2);

		R2_Voucher__c vou3 = new R2_Voucher__c();
		vou3.R2_VOU_LOO_Client__c = acc.Id;
		vou3.RecordTypeId = rtHTR;
		vou3.R2_VOU_TXT_Origin__c = 'MAD';
		vou3.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou3.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou3.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou3.R2_VOU_TXT_Passenger_Reason__c = 'OV';
		listVou.add(vou3);


		Test.startTest();

		insert listVou;

		List<Id> idsVouList = new List<Id>{vou.Id, vou2.Id, vou3.Id};
		Map<ID, R2_Voucher__c> mapVou = new Map<ID, R2_Voucher__c>([SELECT Id, R2_VOU_LOO_Flight__c, R2_VOU_LOO_Incidence__c FROM R2_Voucher__c WHERE Id IN:idsVouList ]);

		// case 1
		System.assertEquals(vuelo.Id, mapVou.get(vou.Id).R2_VOU_LOO_Flight__c);
		System.assertEquals(inc.Id, mapVou.get(vou.Id).R2_VOU_LOO_Incidence__c);

		// case 2
		System.assertEquals(vuelo.Id, mapVou.get(vou2.Id).R2_VOU_LOO_Flight__c);
		System.assertEquals(inc.Id, mapVou.get(vou2.Id).R2_VOU_LOO_Incidence__c);

		// case 3 - inc not exist (created incidence)
		String externalIdInc = 'IB123401202018MADDNB1';
		List<R1_Incident__c> listInc = [SELECT Id, R1_INC_LOO_Client__c, R2_INC_LOO_Flight__c, R2_INC_TXT_MI_Incident_External_ID__c 
										FROM R1_Incident__c 
										WHERE R2_INC_TXT_MI_Incident_External_ID__c=:externalIdInc];
										
		// System.assertNotEquals(0, listInc.size());
		System.assertEquals(vuelo.Id, mapVou.get(vou3.Id).R2_VOU_LOO_Flight__c);
		System.assertEquals(externalIdInc, listInc[0].R2_INC_TXT_MI_Incident_External_ID__c);

		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void generateFligthExternalId_test() {
		R1_CLS_LogHelper.throw_exception = false;


		String expectedResult = 'IB123401202018MAD';

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CNL';

		String externalid = '';

		Test.startTest();

		// case 1
		externalid = R2_CLS_VoucherTriggerMethods.generateFligthExternalId(vou);
		System.assertEquals(expectedResult, externalid);

		// case 2
		expectedResult = 'IB120001202018MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '12';
		externalid = R2_CLS_VoucherTriggerMethods.generateFligthExternalId(vou);
		System.assertEquals(expectedResult, externalid);

		//case 3 - Error
		vou.R2_VOU_PKL_Marketing_Company__c = '';
		externalid = R2_CLS_VoucherTriggerMethods.generateFligthExternalId(vou);
		System.assertEquals(null, externalid);

		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void getIdRtInc_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;

		Id idRTIndiv = [SELECT Id FROM recordType WHERE sObjectType = 'R1_Incident__c' AND DeveloperName = 'R2_Individual' LIMIT 1].Id;
		Id idRTMasiv = [SELECT Id FROM recordType WHERE sObjectType = 'R1_Incident__c' AND DeveloperName = 'Masiva' LIMIT 1].Id;

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		

		Test.startTest();

		Id idRT;

		// case 1-1
		vou.RecordTypeId = rtHTR;
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CN';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTMasiv, idRT);
		// case 1-2
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DV';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTMasiv, idRT);
		// case 1-3
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DL';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTMasiv, idRT);
		// case 1-4
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OV';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-5
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DE';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-6
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CI';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-7
		vou.R2_VOU_TXT_Passenger_Reason__c = 'TT';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-8
		vou.R2_VOU_TXT_Passenger_Reason__c = 'XC';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-9
		vou.R2_VOU_TXT_Passenger_Reason__c = 'ID';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 1-10
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OT';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);

		// case 2-1
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CNL';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTMasiv, idRT);
		// case 2-2
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 2-3
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OTB';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 2-4
		vou.R2_VOU_TXT_Passenger_Reason__c = 'AVV';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 2-5
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CVP';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 2-6
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNG';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);
		// case 2-7
		vou.R2_VOU_TXT_Passenger_Reason__c = 'RPA';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(idRTIndiv, idRT);


		// case 3 - error (id null)
		vou.R2_VOU_TXT_Passenger_Reason__c = 'TestError';
		idRT = R2_CLS_VoucherTriggerMethods.getIdRtInc(vou);
		System.assertEquals(null, idRT);


		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}



	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		12/01/2018             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void getDelayType_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		

		Test.startTest();

		String delayType;

		// case 1-1
		vou.RecordTypeId = rtHTR;
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CN';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('CNL', delayType);
		// case 1-2
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DV';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('DIV', delayType);
		// case 1-3
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OV';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('DNB', delayType);
		// case 1-4
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DL';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('DEP', delayType);
		// case 1-5
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OT';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('OTB', delayType);
		// case 1-6
		vou.R2_VOU_TXT_Passenger_Reason__c = 'TEST';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('TEST', delayType);

		// case 2-1
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CNL';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('CNL', delayType);
		// case 2-2
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('DNB', delayType);
		// case 2-3
		vou.R2_VOU_TXT_Passenger_Reason__c = 'OTB';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('OTB', delayType);
		// case 2-4
		vou.R2_VOU_TXT_Passenger_Reason__c = 'AVV';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('AVV', delayType);
		// case 2-5
		vou.R2_VOU_TXT_Passenger_Reason__c = 'CVP';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('CVP', delayType);
		// case 2-6
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNG';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('DNG', delayType);
		// case 2-7
		vou.R2_VOU_TXT_Passenger_Reason__c = 'RPA';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('RPA', delayType);
		// case 2-8
		vou.R2_VOU_TXT_Passenger_Reason__c = 'TEST';
		delayType = R2_CLS_VoucherTriggerMethods.getDelayType(vou);
		System.assertEquals('TEST', delayType);
		
		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void createIncNotFly_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;

		List<R2_Voucher__c> listVou = new List<R2_Voucher__c>();

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		listVou.add(vou);

		R2_Voucher__c vou2 = new R2_Voucher__c();
		vou2.RecordTypeId = rtDNB;
		vou2.R2_VOU_TXT_Origin__c = 'MAD';
		vou2.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou2.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou2.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou2.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		listVou.add(vou2);

		R2_Voucher__c vou3 = new R2_Voucher__c();
		vou3.RecordTypeId = rtHTR;
		vou3.R2_VOU_TXT_Origin__c = 'MAD';
		vou3.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou3.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou3.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou3.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		listVou.add(vou3);


		R2_Voucher__c vou4 = new R2_Voucher__c();
		vou4.RecordTypeId = rtHTR;
		vou4.R2_VOU_TXT_Origin__c = 'MAD';
		vou4.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou4.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou4.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou4.R2_VOU_TXT_Passenger_Reason__c = 'CN';
		listVou.add(vou4);

		Test.startTest();
		
		insert listVou;

		// case 1 - inc not exist (created incidence)
		String[] externalIdInc = new String[] {'IB123401202018MADDNB1', 'IB123401202018MADCNL1'};

		List<R1_Incident__c> listInc = [SELECT Id, R1_INC_LOO_Client__c, R2_INC_LOO_Flight__c, R2_INC_TXT_MI_Incident_External_ID__c 
										FROM R1_Incident__c 
										WHERE R2_INC_TXT_MI_Incident_External_ID__c IN: externalIdInc];
		
		System.assertEquals(2, listInc.size());
		Test.stopTest();

		Set<Id> idInc = new Set<Id>();
		for(R1_Incident__c inc : listInc ){ idInc.add(inc.Id);}

		List<R2_Voucher__c> listvouUpdated = [SELECT Id FROM R2_Voucher__c WHERE R2_VOU_LOO_Incidence__c IN:idInc];
		System.assertEquals(4, listvouUpdated.size());

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void createIncErrorExtIdDuplicate_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_MI_Incident_External_ID__c = 'IB123401202018MADDNB1';
		insert inc;

		List<R2_Voucher__c> listVou = new List<R2_Voucher__c>();

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';

		Test.startTest();

		insert vou;

		// case 1 - not create inc
		String externalIdInc = 'IB123401202018MADDNB1';
		List<R1_Incident__c> listInc = [SELECT Id, R1_INC_LOO_Client__c, R2_INC_LOO_Flight__c, R2_INC_TXT_MI_Incident_External_ID__c 
										FROM R1_Incident__c 
										WHERE R2_INC_TXT_MI_Incident_External_ID__c=:externalIdInc];
		
		System.assertEquals(1, listInc.size());

		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		20/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void notCreateIncExtIdEmpty_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Id rtDNB = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_DNB' LIMIT 1].Id;
		Id rtHTR = [SELECT Id FROM recordType WHERE sObjectType = 'R2_Voucher__c' AND DeveloperName = 'R2_RT_HTR' LIMIT 1].Id;

		List<R2_Voucher__c> listVou = new List<R2_Voucher__c>();

		R2_Voucher__c vou = new R2_Voucher__c();
		vou.RecordTypeId = rtDNB;
		vou.R2_VOU_TXT_Origin__c = 'MAD';
		vou.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		//vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		vou.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		listVou.add(vou);

		R2_Voucher__c vou2 = new R2_Voucher__c();
		vou2.RecordTypeId = rtDNB;
		vou2.R2_VOU_TXT_Origin__c = 'MAD';
		vou2.R2_VOU_TXT_Main_Flight_Number__c = '1234';
		vou2.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 20);
		//vou2.R2_VOU_PKL_Marketing_Company__c = 'IB';
		vou2.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
		listVou.add(vou2);

		Test.startTest();

		insert listVou;

		// case 1
		List<R1_Incident__c> listInc = [SELECT Id, R1_INC_LOO_Client__c, R2_INC_LOO_Flight__c, R2_INC_TXT_MI_Incident_External_ID__c 
										FROM R1_Incident__c ];
		
		System.assertEquals(0, listInc.size());

		Test.stopTest();

		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest static void exceptions_test() {
		R1_CLS_LogHelper.throw_exception = true;

		Test.startTest();

		R2_CLS_VoucherTriggerMethods.generateFligthExternalId(null);
		R2_CLS_VoucherTriggerMethods.getDelayType(null);
		R2_CLS_VoucherTriggerMethods.getIdRtInc(null);
		R2_CLS_VoucherTriggerMethods.relateVoucher(null);
		
		Test.stopTest();


	}
}