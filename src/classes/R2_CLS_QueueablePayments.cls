public class R2_CLS_QueueablePayments implements Queueable , Database.AllowsCallouts{
  private List<R2_Payment_order__c> pagos;
    
    public R2_CLS_QueueablePayments(List<R2_Payment_order__c> pago){
        if(pago!=null && !pago.isEmpty()){
            this.pagos = pago.clone();
        }  
    }

    public void execute(QueueableContext context) {
        if(this.pagos!=null && !this.pagos.isEmpty()){
            R2_CLS_Payment_Order_TriggerMethods.enviarASeguimientoPagos(this.pagos[0].Id);
			this.pagos.remove(0);
            if(this.pagos!=null && !this.pagos.isEmpty()){
                System.enqueueJob(new R2_CLS_QueueablePayments(this.pagos));
            }
        }
    }
  
}