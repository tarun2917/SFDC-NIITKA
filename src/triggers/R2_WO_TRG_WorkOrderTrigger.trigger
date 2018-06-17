/*---------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    Trigger for Work Order
    IN:
    OUT:
test_vishal
    History:
     <Date>                     <Author>                         <Change Description>
    25/10/2017                  Borja Gay                           Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

trigger R2_WO_TRG_WorkOrderTrigger on R2_Work_Order__c (before insert, after insert) {

    List<R2_Work_Order__c> news = trigger.new;
    List<R2_Work_Order__c> olds = trigger.old;

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);


    if (Trigger.isBefore) {
        if(trigger.isInsert){
            system.debug('tipo de la WO: ' + news[0].R2_WO_PKL_type__c);
            if(news[0].R2_WO_PKL_type__c != 'Amazon'){
                R2_CLS_Work_Order_TriggerMethods.procesarOT(news);
            }
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            if(news[0].R2_WO_PKL_type__c == 'Amazon'){
                //R2_CLS_WorkOrder_TriggerMethods.insertarGiftCard(news[0]);
            }
        }
    }
}