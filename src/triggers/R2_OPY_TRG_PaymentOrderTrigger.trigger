/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Trigger para manejar Casos 
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                            <Change Description>
    ??/??/2017             ??                                              Initial Version
    28/07/2018             Alberto Puerto Collado                     Added condition if(news[0].R2_OPY_CHK_Flag_Escalation_PBuilder__c == false) - changed to ProcessBuilderEscalation management
    ----------------------------------------------------------------------------------------------------------------------*/
    trigger R2_OPY_TRG_PaymentOrderTrigger on R2_Payment_order__c (before insert, before update, after insert, after update, after delete) {

    List<R2_Payment_order__c> news = trigger.new;
    List<R2_Payment_order__c> olds = trigger.old;
    
    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    
    if(news[0].R2_OPY_CHK_Flag_Escalation_PBuilder__c == false){
        if(Trigger.isBefore){
            System.debug('Trigger> Entra en is Before!');
            if(Trigger.isInsert){
                if(news.size()==1){
                    System.debug('Trigger.new: '+ news);
                    R2_CLS_Payment_Order_TriggerMethods.calcularTipoOP(news);
                    
                }
            }
            if(Trigger.isUpdate){
                if(news.size()==1){
                    if(news[0].R2_OPY_PKL_PaymentType__c == 'Seguimiento de Pagos' && (olds[0].R2_OPY_PCK_Status__c == 'Borrador' && news[0].R2_OPY_PCK_Status__c == 'Ready')){
                        System.enqueueJob(new R2_CLS_QueueablePayments(news));
                    }
                }
            }
        }
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                //R2_CLS_Payment_Order_TriggerMethods.calcularPeriodoPresupuestario(news);
            }
        }
    }   
}