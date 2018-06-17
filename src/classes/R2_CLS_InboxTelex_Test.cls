/*---------------------------------------------------------------------------------------------------------------------
Author:         Alberto Puerto Collado
Company:        Accenture
Description:    R2_CLS_InboxTelex class
IN:             
OUT:            

History: 
 <Date>                     <Author>                         <Change Description>
02/03/2018             Alberto Puerto Collado                  Initial Version
----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_InboxTelex_Test {
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Class to test Inbox Message TELEX

    IN:		
    OUT:         

    History:

    <Date>              <Author>           		<Description>
    06/03/2018    Alberto Puerto Collado   		Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    @isTest
    public static void initGetTelex_test(){
    	R1_CLS_LogHelper.throw_exception = false;

		// endpoint
		List<R1_CS_Endpoints__c> lstEndPoints = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lstEndPoints.add(epLogin);

		R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
		ep.Name='R2_ReadTelex';
		ep.R1_CHK_Activo__c = true;
		ep.R1_TXT_EndPoint__c = 'R2_ReadTelex';
		lstEndPoints.add(ep);

		insert lstEndPoints;

		//timeOut
		TimeOut_Integrations__c timOut = new TimeOut_Integrations__c();
		timOut.Name = 'WorldTracer';
		timOut.setTimeOut__c = 8000;
		insert timOut;


		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		
		Test.startTest();

		R2_CLS_InboxTelex.initGetTelex();

		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Exception test management

    IN:		
    OUT:         

    History:

    <Date>              <Author>           		<Description>
    06/03/2018    Alberto Puerto Collado   		Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R2_CLS_InboxTelex.initGetTelex();
    }
}