/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Job for R2_CLS_InboxTelex

    IN:     

    OUT:    

    History:

    <Date>              <Author>                <Description>
    02/03/2018    Alberto Puerto Collado        Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
global with sharing class R2_JOB_WT_readTelex implements Schedulable {

    public R2_JOB_WT_readTelex(){

    }
    //normal job
    global void execute(SchedulableContext sc) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            System.abortJob(sc.getTriggerId());
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_JOB_WT_readTelex.execute', 'Error System.abortJob(sc.getTriggerId());', exc.getmessage()+', '+exc.getLineNumber(), 'TELEX Integration');
        }            
        R2_CLS_InboxTelex.initGetTelex();
    }
}