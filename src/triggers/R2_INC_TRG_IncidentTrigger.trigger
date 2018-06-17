/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
trigger R2_INC_TRG_IncidentTrigger on R1_Incident__c (before insert, after insert) {

    List<R1_Incident__c> news = trigger.new;
    List<R1_Incident__c> olds = trigger.old;

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            R2_CLS_IncidentTriggerMethods.rellenaExternalID(news);
        }
    }

     if(Trigger.isAfter){
        if(Trigger.isInsert){
            if(news[0].R2_INC_PKL_II_Type__c == 'Menús Preorder/A la carta' || news[0].R2_INC_PKL_II_Type__c == 'Menus Preorder A la carta'){
                R2_CLS_IncidentTriggerMethods.crearMotivoPreOrder(news);
                System.debug('Va a entrar por aqui porque es de tipo comida');
                R2_CLS_PreOrderMethods.auxCreateCaseExpediente(news);
                System.debug('#################');
            }
        }
    }

}