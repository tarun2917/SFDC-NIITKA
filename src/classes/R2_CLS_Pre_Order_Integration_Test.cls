/*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:    Test de la integracion de PreOrder           

	History: 
	 <Date>                     <Author>                         <Change Description>
	04/12/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    
@isTest
private class R2_CLS_Pre_Order_Integration_Test {
        /***
         * Solo simulamos en test la integacion de requestRefund ya que la otra integracion que hay en la misma clase: checkPreOrder, 
			se simula desde el test de la clase: R2_CLS_PreOrderMethods   
		***/
        
        static testMethod void requestRefund_Test(){
           R1_CLS_LogHelper.throw_exception = false;
           
           List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
           
           R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
           ep2.Name='PreOrderIni';
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
                     
           Test.startTest();

           String emdIdentifier = '123456';
           String resiberPNR = '9876';
           
           R2_CLS_Pre_Order_Integration.requestRefund(emdIdentifier, resiberPNR, 3);
           Test.stopTest();
           System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
       }
    
    static testMethod void requestRefund401_Test(){
           R1_CLS_LogHelper.throw_exception = false;
           
           List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
           
           R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
           ep2.Name='PreOrderIni';
           ep2.R1_CHK_Activo__c=true;
           ep2.R1_TXT_EndPoint__c='RequestRefund401';
           lst_ep.add(ep2);
           
           R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
           ep3.Name = 'ETL_Login';
           ep3.R1_CHK_Activo__c = true;
           ep3.R1_TXT_EndPoint__c = 'PruebaLogin';
           lst_ep.add(ep3);
                      
           insert lst_ep;
                      
           Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());           
           Test.startTest();

           String emdIdentifier = '123456';
           String resiberPNR = '9876';
           
           R2_CLS_Pre_Order_Integration.requestRefund(emdIdentifier, resiberPNR, 0);
           Test.stopTest();
           
           System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
       }
    
    static testMethod void requestRefundNoLogin_Test(){
           R1_CLS_LogHelper.throw_exception = false;
           
           List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
           
           R1_CS_Endpoints__c ep2=new R1_CS_Endpoints__c();
           ep2.Name='PreOrderIni';
           ep2.R1_CHK_Activo__c=true;
           ep2.R1_TXT_EndPoint__c='Reques';
           lst_ep.add(ep2);
           
           R1_CS_Endpoints__c ep3 = new R1_CS_Endpoints__c();
           ep3.Name = 'ETL_Login';
           ep3.R1_CHK_Activo__c = true;
           ep3.R1_TXT_EndPoint__c = 'PruebaLogin';
           lst_ep.add(ep3);
                      
           insert lst_ep;           
           Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());           
           Test.startTest();

           String emdIdentifier = '123456';
           String resiberPNR = '9876';
           
           R2_CLS_Pre_Order_Integration.requestRefund(emdIdentifier, resiberPNR, 0);

           Test.stopTest();
           
           System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
       }
   
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	04/12/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_Pre_Order_Integration.requestRefund(null, null, null);
    }
}