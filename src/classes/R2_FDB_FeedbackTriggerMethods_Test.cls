@isTest
public with sharing class R2_FDB_FeedbackTriggerMethods_Test {
	
	@isTest
	static void feedbackMesagge_Test(){

		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            
		Account acc = new Account();
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
			insert acc;

		R1_Alert__c alert = new R1_Alert__c();
		alert.R1_ATA_DATH_Expiry_date__c = date.newInstance(2018, 05, 19);
		alert.R1_ATA_DATH_Creation_date__c = date.newInstance(2018,05,16);
		alert.R1_ATA_LOO_Client__c = acc.ID;
		alert.Name = 'Description';
		alert.R2_ATA_PKL_Type__c = 'Otros';
		alert.R1_ATA_PKL_Alert_for__c = 'Todos';
		insert alert;

		R2_Feedback__C feedback  = new R2_Feedback__c();
		feedback.R2_FDB_MSDT_Alert__c = alert.id;
		feedback.R2_FDB_TXT_Comments__c = 'TestComentario';
		// feedback.CreatedDate =date.newInstance(2018, 04, 03);
		feedback.R2_FDB_PKL_Type__c = 'Negativo';

		insert feedback;
		system.debug(feedback);
		
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest
	static void feedbackMesagge_Test2(){

		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            
		Account acc = new Account();
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
			insert acc;

		R1_Alert__c alert = new R1_Alert__c();
		alert.R1_ATA_DATH_Expiry_date__c = date.newInstance(2018, 05, 19);
		alert.R1_ATA_DATH_Creation_date__c = date.newInstance(2018,05,16);
		alert.R1_ATA_LOO_Client__c = acc.ID;
		alert.Name = 'Description';
		alert.R2_ATA_PKL_Type__c = 'Otros';
		alert.R1_ATA_PKL_Alert_for__c = 'Todos';
		insert alert;

		R2_Feedback__C feedback  = new R2_Feedback__c();
		feedback.R2_FDB_MSDT_Alert__c = alert.id;
		feedback.R2_FDB_TXT_Comments__c = 'TestComentario';
		// feedback.CreatedDate =date.newInstance(2018, 04, 03);
		feedback.R2_FDB_PKL_Type__c = 'Negativo';

		insert feedback;
		system.debug(feedback);
		R2_Feedback__C feedback1  = new R2_Feedback__c();
		feedback1.R2_FDB_MSDT_Alert__c = alert.id;
		feedback1.R2_FDB_TXT_Comments__c = 'TestComentario';
		// feedback1.CreatedDate =date.newInstance(2018, 04, 03);
		feedback1.R2_FDB_PKL_Type__c = 'Positivo';

		insert feedback1;

		
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	@isTest
	static void feedbackMesagge_Test_Recurrent(){

		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            
		Account acc = new Account();
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
			insert acc;

		R1_Alert__c alert = new R1_Alert__c();
		alert.R1_ATA_DATH_Expiry_date__c = date.newInstance(2018, 05, 19);
		alert.R1_ATA_DATH_Creation_date__c = date.newInstance(2018,05,16);
		alert.R1_ATA_LOO_Client__c = acc.ID;
		alert.Name = 'Description';
		alert.R2_ATA_PKL_Type__c = 'Otros';
		alert.R1_ATA_PKL_Alert_for__c = 'Todos';
		insert alert;

		R2_Feedback__C feedback  = new R2_Feedback__c();
		feedback.R2_FDB_MSDT_Alert__c = alert.id;
		feedback.R2_FDB_TXT_Comments__c = 'TestComentario';
		// feedback.CreatedDate =date.newInstance(2018, 05, 03);
		feedback.R2_FDB_PKL_Type__c = 'Positivo';

		insert feedback;
		system.debug(feedback);
		
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
}