trigger R2_FDB_FeedbackTrigger on R2_Feedback__c (before insert, after insert) {

    List<R2_Feedback__c> news = trigger.new;
    List<R2_Feedback__c> olds = trigger.old;

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            System.debug('Va a lanzar la operacion');
            R2_FDB_FeedbackTriggerMethods.feedbackAverageAux(news);
        }
    }
}