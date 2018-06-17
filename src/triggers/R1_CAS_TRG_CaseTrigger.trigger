/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

trigger R1_CAS_TRG_CaseTrigger on Case (before insert) {
    if (Trigger.isBefore) {
        if(trigger.isInsert){
            R1_CAS_CaseTriggerMethods.creaEntitlement(trigger.new);
        }
    }
}