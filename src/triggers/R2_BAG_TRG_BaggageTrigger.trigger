trigger R2_BAG_TRG_BaggageTrigger on R2_Baggage__c (before insert, before update) {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture 
    Description:    Trigger que lanza metodo para asignar un importe a una maleta dañada
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    13/11/2017             Sara Torres Bermudez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
	List<R2_Baggage__c> news = trigger.new;
    List<R2_Baggage__c> olds = trigger.old;
    
    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            R2_CLS_BaggageTriggerMethods.asignarImporteMaleta(news);
            //R2_CLS_BaggageTriggerMethods.totalMaletasEnPIR(news);
		}
        if(Trigger.isUpdate){
            R2_CLS_BaggageTriggerMethods.asignarImporteMaleta(news);
            //R2_CLS_BaggageTriggerMethods.totalMaletasEnPIR(news);
		}
    }

}