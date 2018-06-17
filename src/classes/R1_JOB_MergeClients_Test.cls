/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Apex test para la clase apex 'R1_JOB_MergeClients'
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_JOB_MergeClients_Test {
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion execute()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void execute_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Test.startTest();
        R1_JOB_MergeClients jobMerg = new R1_JOB_MergeClients();      
        String sch = '0 1 23 15 3 ?';    
        System.schedule('ScheduleTest', sch, jobMerg);
        //System.assertEquals([SELECT count() FROM R1_Log__c], 0);
        Test.stopTest();
        //List<R1_Log__c> logs = [SELECT Id FROM R1_Log__c];
        //System.debug('Logs:' + logs);
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        //System.assertEquals(logs.size(),0);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para cubrir los catch
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R1_JOB_MergeClients jobMerg = new R1_JOB_MergeClients();    
        String sch = '0 1 23 15 3 ?';    
        System.schedule('ScheduleTest', sch, jobMerg);
    }
}