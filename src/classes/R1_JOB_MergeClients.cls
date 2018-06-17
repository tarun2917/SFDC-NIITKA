global with sharing class R1_JOB_MergeClients implements Schedulable {

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:       	Alvaro García
    Company:       	Accenture
    Description: 	Job to active the process to merge the duplicated clients
    
    IN:				
	OUT:			

    History: 
     <Date>                     <Author>                <Change Description>
    08/05/2017                  Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

	public R1_JOB_MergeClients (){

	}

	global void execute(SchedulableContext sc) {

		try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
			
			System.abortJob(sc.getTriggerId());
		}
		catch(Exception exc){}
			
		Database.executeBatch(new R1_BTCH_MergeClients(0));

	}
}