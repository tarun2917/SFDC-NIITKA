trigger R2_ALT_AlertTrigger on R1_Alert__c (before insert) {
    List<R1_Alert__c> news = trigger.new;
	List<R1_Alert__c> olds = trigger.old;
		
		
	if(Trigger.isBefore){
        if(Trigger.isInsert){
            R2_CLS_Alert_TriggerMethods.queryCliente(news[0]);
        }
	}	
}