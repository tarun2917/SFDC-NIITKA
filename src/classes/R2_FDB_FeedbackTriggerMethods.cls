/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Clase de metodos para el trigger de Feedback
    IN:
    OUT:

    History:
    <Date>                  <Author>                         <Change Description>
    28/03/2018              Ismael Yubero Moreno          Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

public with sharing class R2_FDB_FeedbackTriggerMethods {
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
    <Date>                  <Author>                         <Change Description>
    28/03/2018              Ismael Yubero Moreno                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static void feedbackAverageAux(List<R2_Feedback__c> feedback){

        List<R1_Alert__c> lstAlert = [SELECT Id ,R1_ATA_DATH_Expiry_date__c, R2_ATA_CHK_Recurrent__c FROM R1_Alert__c WHERE id =: feedback[0].R2_FDB_MSDT_Alert__c LIMIT 1];
        System.debug('LLamada auxiliar para sacar la alerta');
        feedbackAverage(lstAlert[0]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
    <Date>                  <Author>                         <Change Description>
    28/03/2018              Ismael Yubero Moreno                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static void feedbackAverage(R1_Alert__c  alerta){

        // List<R1_Alert__c> lstAlert = [SELECT Id FROM R1_Alert__c WHERE id =: feedback[0].R2_FDB_MSDT_Alert__c LIMIT 1];

        List<R2_Feedback__c> lstFeedback = [SELECT id,R2_FDB_MSDT_Alert__c,R2_FDB_PKL_Type__c,CreatedDate FROM R2_Feedback__c WHERE R2_FDB_MSDT_Alert__c =: alerta.id];

        Integer contador = 0;
        System.debug('Saca la alerta relacionada con el feedback');
        // System.debug(lstAlert[0]);
        System.debug(lstFeedback);

        if(lstFeedback.size() != 0){
            alerta.R2_ATA_CHK_Notified__c = true;
        }
        
        for(Integer i = 0; i < lstFeedback.size(); i++){
            System.debug('por aqui ya no va a pasar');
            if(lstFeedback[i].R2_FDB_PKL_Type__c == 'Positivo'){
                System.debug('¿Viene por aqui?');
                contador = contador + 1;
            }else if( lstFeedback[i].R2_FDB_PKL_Type__c == 'Negativo'){
                contador = contador - 1;
            }
        }
        System.debug('contador ' +  contador);
        if(contador > 0){
            alerta.R2_ATA_PKL_Feedback_Summary__c = 'Positivo';
        }else if(contador < 0){
            alerta.R2_ATA_PKL_Feedback_Summary__c = 'Negativo';
        }else{
            alerta.R2_ATA_PKL_Feedback_Summary__c = 'Neutral';
        }
        System.debug('Se va a updatear la alerta');
        for(Integer i = 0; i < lstFeedback.size(); i++){
            System.debug('por aqui ya no va a pasar ' + alerta.R2_ATA_CHK_Recurrent__c);
            System.debug('por aqui ya no va a pasar ' +lstFeedback[i].CreatedDate);
             if(alerta.R1_ATA_DATH_Expiry_date__c < lstFeedback[i].CreatedDate || alerta.R2_ATA_CHK_Recurrent__c == false){
                System.debug('Va a cancelar la alerta');
                alerta.R2_ATA_CHK_Recurrent_feedback__c = true;
             }
            break;
        }
        update alerta;
    }
}