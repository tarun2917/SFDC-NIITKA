@isTest
private class R2_CLS_VOU_VoucherIntegration_TEST {

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
 Author:        Jaime Ascanta
 Company:       Accenture
 Description:
 History:
 <Date>                        <Author>                       <Change Description>
 16/01/2018                Jaime Ascanta                      Initial Version
 --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 @isTest static void createDNB_test(){
		 R1_CLS_LogHelper.throw_exception = false;

		 			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();

				 	R2_Voucher__c vou = new R2_Voucher__c();
					vou.RecordTypeId = recordTypeDNB;
					vou.R2_VOU_TXT_Surname__c = 'CAMPOS';
					vou.R2_VOU_TXT_Second_Surname__c = 'GALLEGO';
					vou.R2_VOU_TXT_Name__c = 'PEPE';
					vou.R2_VOU_TXT_Carrier_code_oper__c = 'IB';
					vou.R2_VOU_TXT_CIA_ID__c = '110';
					vou.R2_VOU_TXT_Main_Flight_Number__c = '4587';
					vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 30);
					vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c = Date.newInstance(2018, 01, 30);
					vou.R2_VOU_TXT_Res_Class__c = 'G';
					vou.R2_VOU_TXT_Passenger_Flight_Class__c = 'G';
					vou.R2_VOU_PKL_Country__c = 'ES';
					vou.R2_VOU_PKL_Arrival_Country__c = 'ES';
					vou.R2_VOU_TXT_Passenger_Airport_Depart__c = 'VLC';
					vou.R2_VOU_TXT_Passenger_Airport_Arrival__c = 'MAD';
					vou.R2_VOU_TXT_CIA_FF__c = 'IB';
					vou.R2_VOU_TXT_Passenger_FF__c = 'NOIBERIAPLUS';
					vou.R2_VOU_PKL_Currency_Claimed__c = 'EUR';
					vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
					vou.R2_VOU_TXT_Comments__c = 'TEST';
					vou.R2_VOU_TXT_DNB_Budget__c = 'CENTRO';
					vou.R2_VOU_TXT_Account__c = 'CUENTA';
					vou.R2_VOU_PKL_Creation_Type__c = 'A';
					vou.R2_VOU_DIV_Amount_Value_Cash__c = 80;
					vou.R2_VOU_DIV_Amount_Value_MCO__c = 50;

				 List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
				 R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
				 ep.Name='CreateUpdateDNB';
				 ep.R1_CHK_Activo__c=true;
				 ep.R1_TXT_EndPoint__c='create_dnb';
				 lst_ep.add(ep);

				 R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
				 ep2.Name = 'ETL_Login';
				 ep2.R1_CHK_Activo__c = true;
				 ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
				 lst_ep.add(ep2);

				 insert lst_ep;

				 Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

				 

				 Test.startTest();

                insert vou;

                List<R2_Voucher__c> listVou = [SELECT id, R2_VOU_TXT_Voucher__c FROM R2_Voucher__c WHERE Id=: vou.Id];
                System.assertEquals(1, listVou.size() );

				Test.stopTest();


		 // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
 }


 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
 Author:        Jaime Ascanta
 Company:       Accenture
 Description:
 History:
 <Date>                        <Author>                       <Change Description>
 16/01/2018                Jaime Ascanta                      Initial Version
 --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 @isTest static void updateDNB_test(){
    R1_CLS_LogHelper.throw_exception = false;

         Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();

         R2_Voucher__c vou = new R2_Voucher__c();
         vou.RecordTypeId = recordTypeDNB;
         vou.R2_VOU_TXT_Surname__c = 'CAMPOS';
         vou.R2_VOU_TXT_Second_Surname__c = 'GALLEGO';
         vou.R2_VOU_TXT_Name__c = 'PEPE';
         vou.R2_VOU_TXT_Carrier_code_oper__c = 'IB';
         vou.R2_VOU_TXT_CIA_ID__c = '110';
         vou.R2_VOU_TXT_Main_Flight_Number__c = '4587';
         vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_TXT_Res_Class__c = 'G';
         vou.R2_VOU_TXT_Passenger_Flight_Class__c = 'G';
         vou.R2_VOU_PKL_Country__c = 'ES';
         vou.R2_VOU_PKL_Arrival_Country__c = 'ES';
         vou.R2_VOU_TXT_Passenger_Airport_Depart__c = 'VLC';
         vou.R2_VOU_TXT_Passenger_Airport_Arrival__c = 'MAD';
         vou.R2_VOU_TXT_CIA_FF__c = 'IB';
         vou.R2_VOU_TXT_Passenger_FF__c = 'NOIBERIAPLUS';
         vou.R2_VOU_PKL_Currency_Claimed__c = 'EUR';
         vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
         vou.R2_VOU_TXT_Comments__c = 'TEST';
         vou.R2_VOU_TXT_DNB_Budget__c = 'CENTRO';
         vou.R2_VOU_TXT_Account__c = 'CUENTA';
         vou.R2_VOU_PKL_Creation_Type__c = 'A';
         vou.R2_VOU_DIV_Amount_Value_Cash__c = 80;
         vou.R2_VOU_DIV_Amount_Value_MCO__c = 50;

         vou.R2_VOU_TXT_Voucher__c = '123456789';
         vou.R2_VOU_PKL_Status__c = 'Abierto';

         insert vou;


        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='CreateUpdateDNB';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='create_dnb';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Test.startTest();

           List<R2_Voucher__c> vouList = [SELECT Id,R2_VOU_TXT_Name__c FROM R2_Voucher__c WHERE Id=:vou.Id];
           System.assert(vouList.size()>0);
           vouList[0].R2_VOU_TXT_Name__c = 'NameUpdate';
           update vouList[0];

        Test.stopTest();

    // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
 }


 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
 Author:        Jaime Ascanta
 Company:       Accenture
 Description:
 History:
 <Date>                        <Author>                       <Change Description>
 16/01/2018                Jaime Ascanta                      Initial Version
 --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 @isTest static void updateDNBAmount_test(){
    R1_CLS_LogHelper.throw_exception = false;

         Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();

         R2_Voucher__c vou = new R2_Voucher__c();
         vou.RecordTypeId = recordTypeDNB;
         vou.R2_VOU_TXT_Surname__c = 'CAMPOS';
         vou.R2_VOU_TXT_Second_Surname__c = 'GALLEGO';
         vou.R2_VOU_TXT_Name__c = 'PEPE';
         vou.R2_VOU_TXT_Carrier_code_oper__c = 'IB';
         vou.R2_VOU_TXT_CIA_ID__c = '110';
         vou.R2_VOU_TXT_Main_Flight_Number__c = '4587';
         vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_TXT_Res_Class__c = 'G';
         vou.R2_VOU_TXT_Passenger_Flight_Class__c = 'G';
         vou.R2_VOU_PKL_Country__c = 'ES';
         vou.R2_VOU_PKL_Arrival_Country__c = 'ES';
         vou.R2_VOU_TXT_Passenger_Airport_Depart__c = 'VLC';
         vou.R2_VOU_TXT_Passenger_Airport_Arrival__c = 'MAD';
         vou.R2_VOU_TXT_CIA_FF__c = 'IB';
         vou.R2_VOU_TXT_Passenger_FF__c = 'NOIBERIAPLUS';
         vou.R2_VOU_PKL_Currency_Claimed__c = 'EUR';
         vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
         vou.R2_VOU_TXT_Comments__c = 'TEST';
         vou.R2_VOU_TXT_DNB_Budget__c = 'CENTRO';
         vou.R2_VOU_TXT_Account__c = 'CUENTA';
         vou.R2_VOU_PKL_Creation_Type__c = 'A';
         vou.R2_VOU_DIV_Amount_Value_Cash__c = 80;
         vou.R2_VOU_DIV_Amount_Value_MCO__c = 50;
         vou.R2_VOU_TXT_Voucher__c = '123456789';
         vou.R2_VOU_PKL_Status__c = 'Abierto';
         insert vou;


        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='UpdateDNBAmount';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='update_amounts_dnb';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Test.startTest();

        List<R2_Voucher__c> listVou = [SELECT id, R2_VOU_TXT_Voucher__c,R2_VOU_TXT_Surname__c,R2_VOU_DIV_Amount_Value_Cash__c,R2_VOU_DIV_Amount_Value_MCO__c FROM R2_Voucher__c WHERE Id=: vou.Id];
        System.assert(listVou.size()>0);
        listVou[0].R2_VOU_DIV_Amount_Value_Cash__c = 10;
        listVou[0].R2_VOU_DIV_Amount_Value_MCO__c = 15;
        update listVou[0];

        Test.stopTest();

    // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
 }

 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
 Author:        Jaime Ascanta
 Company:       Accenture
 Description:
 History:
 <Date>                        <Author>                       <Change Description>
 16/01/2018                Jaime Ascanta                      Initial Version
 --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 @isTest static void cancelDNB_test(){
    R1_CLS_LogHelper.throw_exception = false;

         Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();

         R2_Voucher__c vou = new R2_Voucher__c();
         vou.RecordTypeId = recordTypeDNB;
         vou.R2_VOU_TXT_Surname__c = 'CAMPOS';
         vou.R2_VOU_TXT_Second_Surname__c = 'GALLEGO';
         vou.R2_VOU_TXT_Name__c = 'PEPE';
         vou.R2_VOU_TXT_Carrier_code_oper__c = 'IB';
         vou.R2_VOU_TXT_CIA_ID__c = '110';
         vou.R2_VOU_TXT_Main_Flight_Number__c = '4587';
         vou.R2_VOU_DAT_Flight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c = Date.newInstance(2018, 01, 30);
         vou.R2_VOU_TXT_Res_Class__c = 'G';
         vou.R2_VOU_TXT_Passenger_Flight_Class__c = 'G';
         vou.R2_VOU_PKL_Country__c = 'ES';
         vou.R2_VOU_PKL_Arrival_Country__c = 'ES';
         vou.R2_VOU_TXT_Passenger_Airport_Depart__c = 'VLC';
         vou.R2_VOU_TXT_Passenger_Airport_Arrival__c = 'MAD';
         vou.R2_VOU_TXT_CIA_FF__c = 'IB';
         vou.R2_VOU_TXT_Passenger_FF__c = 'NOIBERIAPLUS';
         vou.R2_VOU_PKL_Currency_Claimed__c = 'EUR';
         vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB';
         vou.R2_VOU_TXT_Comments__c = 'TEST';
         vou.R2_VOU_TXT_DNB_Budget__c = 'CENTRO';
         vou.R2_VOU_TXT_Account__c = 'CUENTA';
         vou.R2_VOU_PKL_Creation_Type__c = 'A';
         vou.R2_VOU_DIV_Amount_Value_Cash__c = 80;
         vou.R2_VOU_DIV_Amount_Value_MCO__c = 50;
         vou.R2_VOU_TXT_Voucher__c = '123456789';
         vou.R2_VOU_PKL_Status__c = 'A';
         insert vou;


        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='CancelDNB';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='cancel_amounts_dnb';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Test.startTest();

        List<R2_Voucher__c> listVou = [SELECT id, R2_VOU_TXT_Voucher__c,R2_VOU_TXT_Surname__c,R2_VOU_PKL_Status__c FROM R2_Voucher__c WHERE Id=: vou.Id];
        System.assertEquals(1, listVou.size() );
        
        listVou[0].R2_VOU_PKL_Status__c = 'X';

        update listVou[0];

        Test.stopTest();

    // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
 }


}