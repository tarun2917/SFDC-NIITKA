trigger R1_Flight_Trigger on R1_Flight__c (after update) {

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);

    if(trigger.isAfter){    

       if(trigger.isUpdate){
            if(trigger.new.size()==1){
                    if ( !( (objectByPass.contains('R1_Flight__c') || objectByPass.contains('All')) && bypass.R1_CHK_skip_trigger__c)) {
                             if( Trigger.oldMap.get(Trigger.new[0].id).R1_FLG_PKL_Message_Type__c != Trigger.newMap.get(Trigger.new[0].id).R1_FLG_PKL_Message_Type__c ){
                                List<R1_SIP_Status__c> status=[SELECT name,id,R1_SIS_PKL_Vip_lounge__c,R1_SIS_CHK_Control_flag__c FROM R1_SIP_Status__c WHERE R1_SIS_LOO_Flight__r.id=:trigger.new[0].id];
                                String sala='';
                                
                                if(status.size()!=0){
                                
                                    for(R1_SIP_Status__c estado : status){
                                        System.debug('entro');
                                        if(!estado.R1_SIS_CHK_Control_flag__c){
                                            sala=estado.R1_SIS_PKL_Vip_lounge__c;
                                            R1_CLS_SIPInt.actualizarVuelo(trigger.new[0].id,sala);
                                            
                                            if(!System.isQueueable()){
                                                
                                                List<R1_Flight__c> acceso=[Select id,R1_FLG_TXT_Carrier_code__c,R1_FLG_TXT_Flight_number__c,R1_FLG_TXT_External_ID__c,
                                                                           R1_FLG_DAT_Flight_date_local__c,R1_FLG_TXT_Airport_arrive__c, R1_FLG_TXT_Carrier_code_oper__c,
                                                                           R1_FLG_ATXTL_Message_text__c,R1_FLG_PKL_Message_type__c, R1_FLG_TXT_Flight_no_oper__c from R1_Flight__c WHERE id=:trigger.new[0].id];
                                                //System.debug('ID'+id);
                                                
                                                
                                                List<R1_Flight__c> lstVuelosSIP = [SELECT Id, R1_FLG_ATXTL_Message_text__c, R1_FLG_PKL_Message_type__c, R1_FLG_CHK_Controlled_by_SIP__c FROM R1_Flight__c 
                                                                                   WHERE R1_FLG_DAT_Flight_date_local__c = :acceso[0].R1_FLG_DAT_Flight_date_local__c
                                                                                   AND R1_FLG_TXT_Carrier_code_oper__c = :acceso[0].R1_FLG_TXT_Carrier_code_oper__c 
                                                                                   AND R1_FLG_TXT_Flight_no_oper__c = :acceso[0].R1_FLG_TXT_Flight_no_oper__c 
                                                                                   AND R1_FLG_CHK_Controlled_by_SIP__c = false
                                                                                   AND R1_FLG_TXT_Airport_arrive__c = :acceso[0].R1_FLG_TXT_Airport_arrive__c AND Id != :acceso[0].Id];
                                                
                                                if(!lstVuelosSIP.isEmpty()){
                                                    for(R1_Flight__c vuelo : lstVuelosSIP){
                                                        vuelo.R1_FLG_PKL_Message_type__c = acceso[0].R1_FLG_PKL_Message_type__c;
                                                        vuelo.R1_FLG_ATXTL_Message_text__c = acceso[0].R1_FLG_ATXTL_Message_text__c;
                                                    }
                                                    
                                                    System.enqueueJob(new R2_CLS_QueueableUpdateFlightsSIP(lstVuelosSIP));
                                                }    
                                                
                                            }
                                        }
                                        
                                    }
                                     
                                }else{
                                 
                                }
                               
                                                              }
                    }
                }
                else{}
        
            }
        
        
    }
}