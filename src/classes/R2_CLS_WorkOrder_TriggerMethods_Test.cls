/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:                

    History: 
     <Date>                     <Author>                         <Change Description>
    17/10/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
public class R2_CLS_WorkOrder_TriggerMethods_Test {
    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Sara Torres Bermúdez
        Company:        Accenture
        Description:                
    
        History: 
         <Date>                     <Author>                         <Change Description>
        17/10/2017              Sara Torres Bermúdez                    Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void insertarGiftCard_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        
        Test.startTest();
        insert WO;
        R2_Work_Order__c ResulWO = [SELECT Id, R2_WO_TXT_AmazonId__c, R2_WO_TXT_OT__c, R2_WO_DATH_GiftCard_Expiracion__c, R2_WO_PKL_type__c, R2_WO_NUM_Amount_tot__c FROM R2_Work_Order__c WHERE id =: WO.Id];
        system.assertNotEquals(null, ResulWO);
        
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*---------------------------------------------------------------------------------------------------------------------
        Author:         Sara Torres Bermúdez
        Company:        Accenture
        Description:                
    
        History: 
         <Date>                     <Author>                         <Change Description>
        17/10/2017              Sara Torres Bermúdez                    Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_WorkOrder_TriggerMethods.insertarGiftCard(null);
    }

}