public class R2_CLS_QueueableAccountDelete implements Queueable , Database.AllowsCallouts{
  private List<String> accounts;
    
    public R2_CLS_QueueableAccountDelete(List<String> accounts){
        if(accounts!=null && !accounts.isEmpty()){
            this.accounts = accounts;
        }  
    }

    public void execute(QueueableContext context) {
        if(this.accounts!=null && !this.accounts.isEmpty()){
            R1_CLS_AccountTriggerMethods.borrarEnMKT(this.accounts);
        }
    }
  
}