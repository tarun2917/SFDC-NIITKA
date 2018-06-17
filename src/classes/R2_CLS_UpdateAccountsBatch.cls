/*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Daniel Cadalso
Company:        Accenture
Description:    Batch that sets R2_ACC_CHK_Marketing_Cloud__c and R2_CON_CHK_Marketing_Cloud__pc to true if the account is person account and has the 
                the fields Phone and PersonEmail filled.

        

History: 
<Date>                     <Author>                     <Change Description>
01/12/2017                 Daniel Cadalso               Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  
global class R2_CLS_UpdateAccountsBatch implements Database.Batchable<Account>{
    global Id lastAccountId;
    global Integer MAX_SIZE = 200;
    global Map<String, List<Account>> mapaProcesables; 
    global R2_CLS_UpdateAccountsBatch(Integer maxSize, Id lastAccountId, List<Account> noProcesados){
        if(maxSize != null){
            this.MAX_SIZE = maxSize;
        }
        if(noProcesados == null){
            Integer labelLimit = 10000;
            try{
                labelLimit = Integer.valueOf(label.R2_BACTH_QueryLimit);
            }catch(Exception e){}
             
             String query = 'SELECT Id, PersonEmail, Phone, R2_ACC_CHK_Marketing_Cloud__c, R2_ACC_NUM_ICAR_ind_act_last_2_years__c FROM Account where IsPersonAccount = true AND ((R2_ACC_TXT_ICAR_Seg_maturity_level__c != \'Churned Customer\' AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c != null) OR (R2_ACC_NUM_ICAR_ind_ibcom__c = 1) OR (R2_ACC_TXT_ICAR_Seg_maturity_level__c = \'Active Direct Customer\' OR R2_ACC_TXT_ICAR_Seg_maturity_level__c = \'Active Third Party Customer\') ) '+(lastAccountId != null ? 'and Id > :lastAccountId' :' ')+ ' order by Id asc limit :labelLimit';
             this.mapaProcesables =  procesarTodo(Database.query(query));
        }else{

            this.mapaProcesables =  procesarTodo(noProcesados);
        }       
    }
    global Iterable<Account> start(Database.BatchableContext BC){
       
       return this.mapaProcesables.get('Procesados');
    }

    global void execute(Database.BatchableContext BC, List<Account> scope){
        for(Account cuenta:scope){
            if(cuenta.R2_ACC_NUM_ICAR_ind_act_last_2_years__c == 1 && (cuenta.PersonEmail != null || cuenta.Phone != null)){
                cuenta.R2_ACC_CHK_Marketing_Cloud__c = true;
                cuenta.R2_CON_CHK_Marketing_Cloud__pc = true;
            }else{
                cuenta.R2_ACC_CHK_Marketing_Cloud__c = false;
                cuenta.R2_CON_CHK_Marketing_Cloud__pc = false;
            }          
        }
        try{
            Database.update(scope, false);
        }catch(Exception e){
            System.abortJob(BC.getJobId());
        }
    }  
    global void finish(Database.BatchableContext BC){
        if(!mapaProcesables.get('Procesados').isEmpty()){
            if(this.mapaProcesables.get('No_procesados').isEmpty()){
                lastAccountId = mapaProcesables.get('Procesados')[mapaProcesables.get('Procesados').size() - 1].Id;
                Database.executeBatch(new R2_CLS_UpdateAccountsBatch(MAX_SIZE, lastAccountId, null));
            } else{
                Database.executeBatch(new R2_CLS_UpdateAccountsBatch(MAX_SIZE, lastAccountId, this.mapaProcesables.get('No_procesados')));
            } 
        }     
    }

    private Map<String, List<Account>> procesarTodo(List<Account> scope){
        Map<String, List<Account>> mapa = new Map<String, List<Account>>();
        mapa.put('Procesados', new List<Account>());
        mapa.put('No_procesados', new List<Account>());
        Integer cont = 0;
        for(Account cuenta:scope){
            if(cont < MAX_SIZE){
                mapa.get('Procesados').add(cuenta);
            }else{
                mapa.get('No_procesados').add(cuenta);
            }
            cont++;
        }
        return mapa;
    }
}*/

public class R2_CLS_UpdateAccountsBatch{}