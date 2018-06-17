/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Clase de metodos para el trigger de Alert
    IN:
    OUT:

    History:
    <Date>                  <Author>                         <Change Description>
    16/04/2018              Ismael Yubero Moreno          Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

public with sharing class R2_CLS_Alert_TriggerMethods {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
    <Date>                  <Author>                         <Change Description>
    16/04/2018              Ismael Yubero Moreno                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    public static void queryCliente(R1_Alert__c alert){

        System.debug('Viene por aqui a meter el cliente!!!!!');
        String ff = alert.R1_ATA_TXT_Frecuent_flyer__c;
        List<Account> lstAccount = new List<Account>();
        if(alert.R1_ATA_LOO_Client__c != null){
            System.debug('Viene por el if');
            alert.R1_ATA_LOO_Client__c = alert.R1_ATA_LOO_Client__c;
        }else{
            System.debug('Viene por el else');
            lstAccount = [SELECT id, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Primary_FF_Card_CCPO__c, R1_ACC_TXT_Identification_number__c from Account where   (R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c != null AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c != '' AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c =: ff AND R1_ACC_CHK_Duplicate__c=false AND R1_ACC_CHK_Unsubscribe__c = false ) OR ((R1_ACC_PKL_identification_Type__c != null AND R1_ACC_PKL_identification_Type__c =: alert.R2_ATA_PKL_Document_type__c ) AND(R1_ACC_TXT_Identification_number__c != null AND R1_ACC_TXT_Identification_number__c =: alert.R2_ATA_TXT_Document_number__c) AND R1_ACC_CHK_Duplicate__c=false AND R1_ACC_CHK_Unsubscribe__c = false) OR (R1_ACC_TXT_Id_Golden_record__c!= null AND R1_ACC_TXT_Id_Golden_record__c=:alert.R2_ATA_TXT_Golden_record__c) LIMIT 1];
            System.debug(lstAccount);
            alert.R1_ATA_LOO_Client__c =lstAccount[0].id;
        
        }
        // )OR((R1_ACC_TXT_Primary_FF_Card_CCPO__c != null AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c =: ff AND R1_ACC_CHK_Duplicate__c=false AND R1_ACC_CHK_Unsubscribe__c = false ) OR ((R1_ACC_PKL_identification_Type__c != null AND R1_ACC_PKL_identification_Type__c =: alert.R2_ATA_PKL_Document_type__c ) AND(R1_ACC_TXT_Identification_number__c != null AND R1_ACC_TXT_Identification_number__c =: alert.R2_ATA_TXT_Document_number__c) AND R1_ACC_CHK_Duplicate__c=false AND R1_ACC_CHK_Unsubscribe__c = false))

        // alert.R1_ATA_TXT_Frecuent_flyer__c =  lstAccount[0].R1_ACC_FOR_Primary_FF_Card_CCPO__c;
        // alert.R2_ATA_PKL_Document_type__c = lstAccount[0].R1_ACC_PKL_identification_Type__c;
        // alert.R2_ATA_TXT_Document_number__c =  lstAccount[0].R1_ACC_TXT_Identification_number__c;
    
        System.debug('LLamada auxiliar para sacar la alerta');
    }
}