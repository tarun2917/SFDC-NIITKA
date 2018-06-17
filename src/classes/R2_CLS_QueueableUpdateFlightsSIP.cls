public class R2_CLS_QueueableUpdateFlightsSIP implements Queueable , Database.AllowsCallouts{
	private List<R1_Flight__c> vuelos;
    
    public R2_CLS_QueueableUpdateFlightsSIP(List<R1_Flight__c> vuelosSIP){
        this.vuelos = vuelosSIP;
    }
    
    public void execute(QueueableContext context) {
        if(!this.vuelos.isEmpty()){
            
            update this.vuelos[0];
            
            this.vuelos.remove(0);
            
            if(!this.vuelos.isEmpty()){
                System.enqueueJob(new R2_CLS_QueueableUpdateFlightsSIP(this.vuelos));
            }
        
        }
    }
  
}