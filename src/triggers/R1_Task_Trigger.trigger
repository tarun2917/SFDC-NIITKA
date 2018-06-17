/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version
    25/07/2017            David Barco               Add the mapUUIField method in before insert
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

trigger R1_Task_Trigger on Task (before insert, before update) {

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    
    List<Task> news = trigger.new;
    List<Task> olds = trigger.old;
        
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            R1_CLS_TaskTriggerMethods.asignaCasos(news);
            R1_CLS_TaskTriggerMethods.mapUUIField(news);
        }
        
        if(Trigger.isUpdate){
            R1_CLS_TaskTriggerMethods.asignaCasos(news);
        }
    }
}