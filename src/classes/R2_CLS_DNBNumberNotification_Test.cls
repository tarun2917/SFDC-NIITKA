@isTest
private class R2_CLS_DNBNumberNotification_Test
{
	@isTest
	static void sendDNB_Test(){

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
          insert vou;


				List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Send DNB';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='Send DNB';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Test.startTest();
        R2_CLS_DNBNumberNotification.sendDNB(vou.id);
        Test.stopTest();

        // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest
	static void exceptionTest(){
    R1_CLS_LogHelper.throw_exception = true;

		R2_CLS_DNBNumberNotification.sendDNB(null);
    	R2_CLS_DNBNumberNotification.makeRequestXML(null);
    	R2_CLS_DNBNumberNotification.makeResponseFromXML(null);
    	R2_CLS_DNBNumberNotification.sendDNBNumber(null, 0);
    	R2_CLS_DNBNumberNotification.sendDNBNotVoucher(null);
    
	}
}