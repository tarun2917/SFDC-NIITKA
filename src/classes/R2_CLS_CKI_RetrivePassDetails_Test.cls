/*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	30/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R2_CLS_CKI_RetrivePassDetails_Test {
   /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	30/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void callButtonCustomer_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Retrieve_Passenger_Details';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='R2_Retrieve_Passenger_Details';
        lst_ep.add(ep);
        
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
         Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  
        
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
        
        R2_CKI_info__c pass =  R1_CLS_Utilities.helper_Passenger_constructor(vuelo.id, acc.id);
        insert pass;
 
		Test.startTest();
        String idPass = String.valueOf(pass.id);  
        R2_CLS_CKI_RetrivePassDetails.callButtonCustomer(pass.id);       
        Test.stopTest();
       
       //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
  /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	30/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void buttonCustomerError401_Test(){

		R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Retrieve_Passenger_Details';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAD-1AMDE/passengers';
        lst_ep.add(ep);
        
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  
        
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
        
        R2_CKI_info__c pass =  R1_CLS_Utilities.helper_Passenger_constructor(vuelo.id, acc.id);
        insert pass;
       
       Test.startTest();
        String idPass = String.valueOf(pass.id);  
        R2_CLS_CKI_RetrivePassDetails.callButtonCustomer(pass.id);       
        Test.stopTest();
        
        System.debug([SELECT R1_LOG_ATXTL_MensajeError__c FROM R1_Log__c]);
       
       //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
  
 /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	30/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
     static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_CKI_RetrivePassDetails.callButtonCustomer(null);
        R2_CLS_CKI_RetrivePassDetails.buttonCustomer(null, null, null, null, null, null, null);
    }
}