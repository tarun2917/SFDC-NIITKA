/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_ATT_TriggersMethods {
 /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    public static void valorParentId(List<Attachment> news){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            system.debug('------------------1-----------------------------');

            
            List<Attachment> lstAtt = new List<Attachment>();
            List<Id> lstIds = new List<Id>();
            
            system.debug('------------------1-----------------------------DESPUES DE LAS LISTAS');

            if(!news.isEmpty()){
                for(Attachment attNew : news){
                    if(attNew.ParentId != null){
                        system.debug('--------------------2---------------------------!= NULL');
                        String str = (String.valueof(attNew.ParentId));
                        if(str.substring(0,3) == '02s'){
                            system.debug('--------------------3---------------------------');
                            lstAtt.add(attNew);
                            lstIds.add(attNew.ParentId);
                        }
                    } 
                }
            }
            system.debug('----------------------4-------------------------ANTES DEL IF');
            if(!lstIds.isEmpty() && !lstAtt.isEmpty()){
                List<EmailMessage> lstEmails = [SELECT Id, ParentId FROM EmailMessage WHERE Id IN :lstIds];
                system.debug('lista de mails: '+ lstEmails);
                
                if(!lstEmails.isEmpty()){
                    for(Attachment att : lstAtt){
                        system.debug('------------------------------------------------------------------ENTRO EN EL FOR()' + att);
                        for(EmailMessage ema : lstEmails){
                            system.debug('----  ParentId ------' + att.ParentId);
                            system.debug('---- ema ------' + ema.Id);
                            if(att.ParentId == ema.Id){
                                att.ParentId = ema.ParentId;
                                system.debug('---- ema ------' + ema.ParentId);
                            }
                        }
                    }
            	}
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_ATT_TriggersMethods.valorParentId', '', exc.getmessage()+', '+exc.getLineNumber(), 'Attachment');
        }
            
	}
}