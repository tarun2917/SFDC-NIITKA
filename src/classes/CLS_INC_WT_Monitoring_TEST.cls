/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    monitoring test
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    09/05/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
 @isTest
private class CLS_INC_WT_Monitoring_TEST {
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    monitoring wt uses
    IN:
    OUT:
	It is Testing
    History:
     <Date>                     <Author>                         <Change Description>
    09/05/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
 	@isTest static void nuevoTrack_TEST() {
		R1_CLS_LogHelper.throw_exception = false;

		String userId = UserInfo.getUserId();
		String servicio = 'closeCAH';

		Test.startTest();
		CLS_INC_WT_Monitoring.watchingWT( servicio, 'Delayed');

		Test.stopTest();
		List<Track_WT__c> lstTrack = [SELECT Id, Name, CreatedBy.Id, INT_Usos__c, TXT_servicio__c, FOR_Key__c 
                            FROM Track_WT__c
                            WHERE CreatedBy.Id =:userId AND TXT_servicio__c =:servicio];
		System.assertEquals(1, lstTrack[0].INT_Usos__c);
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
 	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    monitoring wt uses
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    09/05/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
 	@isTest static void existenteTrack_TEST() {
		R1_CLS_LogHelper.throw_exception = false;

		String userId = UserInfo.getUserId();
        String servicio = 'closeCAH';

		Track_WT__c newTrack = new Track_WT__c();
	        newTrack.INT_Usos__c = 1;
	        newTrack.TXT_servicio__c = servicio;
	        newTrack.PKL_Tipo__c = 'Delayed';
	    insert newTrack;

		Test.startTest();
		CLS_INC_WT_Monitoring.watchingWT( 'closeCAH', 'Delayed');

		Test.stopTest();

		List<Track_WT__c> lstTrack = [SELECT Id, Name, CreatedBy.Id, INT_Usos__c, TXT_servicio__c, FOR_Key__c 
                            FROM Track_WT__c
                            WHERE CreatedBy.Id =:userId AND TXT_servicio__c =:servicio];
		System.assertEquals(2, lstTrack[0].INT_Usos__c);
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
}