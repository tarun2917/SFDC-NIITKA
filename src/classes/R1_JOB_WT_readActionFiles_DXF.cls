/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Job for R2_CLS_InboxMessageRead

    IN:     

    OUT:    

    History:

    <Date>              <Author>                <Description>
    22/12/2017    Alberto Puerto Collado        Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
global with sharing class R1_JOB_WT_readActionFiles_DXF implements Schedulable {
    public R1_JOB_WT_readActionFiles_DXF (){

    }
    //normal job
    global void execute(SchedulableContext sc) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            System.abortJob(sc.getTriggerId());
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_JOB_WT_readActionFiles_DXF.execute', 'Error System.abortJob(sc.getTriggerId());', exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
        }            
        R2_CLS_InboxMessageRead.packAreasDXF(true);
    }
    ////extraordinary method, use it when we need to charge the last 7 days
    //global void executeSevenDays(SchedulableContext sc) {
    //    try{
    //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
    //        System.abortJob(sc.getTriggerId());
    //    }
    //    catch(Exception exc){
    //        R1_CLS_LogHelper.generateErrorLog('R1_JOB_WT_readActionFiles_DXF.executeSevenDays', 'Error System.abortJob(sc.getTriggerId());', exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
    //    }            
    //    R2_CLS_InboxMessageRead.packAreasDXF(false);
    //}
}