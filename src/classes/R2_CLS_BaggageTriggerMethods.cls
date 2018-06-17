public class R2_CLS_BaggageTriggerMethods{ 

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture 
    Description:    Clase para asginar el importe correspondiente a una maleta perdida
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    13/11/2017             Sara Torres Bermudez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    public static String asignarImporteMaleta(List<R2_Baggage__c> ListMaletas){
         try{
             system.debug('asignarImporteMaleta');
             String valor = '';
             if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
             Set<Id> set_IncidenciaId = new Set<Id>();
             if(!ListMaletas.isEmpty()){
                 for(R2_Baggage__c maleId: ListMaletas){
                     if(maleId.R2_BAG_MSDT_Incident__c != null){
                         set_IncidenciaId.add(maleId.R2_BAG_MSDT_Incident__c);
                     }
                 }
             }
             if (!set_IncidenciaId.isEmpty()){
                List<R1_Incident__c> lst_inci = [SELECT id, R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c,R1_INC_LOO_Client__r.Id, R1_INC_LOO_Client__r.R1_ACC_PKL_Platinum_level_description__c, R1_INC_LOO_Client__r.R1_ACC_CHK_Flag_Iberia_Singular__c FROM R1_Incident__c WHERE Id IN :set_IncidenciaId];
                System.debug('Prueba cliente: '+ lst_inci[0].R1_INC_LOO_Client__r.R1_ACC_PKL_Platinum_level_description__c);
                System.debug('Prueba cliente: '+ lst_inci[0].R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                System.debug('Prueba cliente: '+ lst_inci[0].R1_INC_LOO_Client__r.R1_ACC_CHK_Flag_Iberia_Singular__c);
                System.debug('Prueba cliente: '+ lst_inci[0].R1_INC_LOO_Client__r.Id);
                Map<Id, R1_Incident__c> map_incidencia = new Map<Id, R1_Incident__c>(lst_inci);

                if(!lst_inci.isEmpty()){
                    for(R1_Incident__c inci: lst_inci){
                        if(inci.id != null){
                            map_incidencia.put(inci.id, inci);
                        }
                    }
                    system.debug('mapa de inci: ' + map_incidencia);
                    List<R2_CS_Baggage__c> lst_cs_bag = [SELECT id, R2_DIV_estimated_amount__c, Name FROM R2_CS_Baggage__c];
                    system.debug('lst_cs_Bag: ' + lst_cs_bag);
                    Map<String, R2_CS_Baggage__c> map_cs_bag = new Map<String, R2_CS_Baggage__c>(lst_cs_bag);
                    if (!lst_cs_bag.isEmpty()){
                        for(R2_CS_Baggage__c cs: lst_cs_bag){
                            //system.debug('voy a rellenar el mapa: ' + cs);
                            if(cs.Name != null){
                                //system.debug('tiene nombre');
                                map_cs_bag.put(cs.Name, cs);
                            }
                        }
                    }
                         
                    system.debug('mapa de maleta de CS: ' + map_cs_bag);
                    for(R2_Baggage__c maleta: ListMaletas){
                        System.debug('Este es el mapa de las maletas: '+ maleta.R2_BAG_MSDT_Incident__c);
                        System.debug('Este es el mapa de las maletas: '+ map_incidencia);
                        if(map_incidencia.containsKey(maleta.R2_BAG_MSDT_Incident__c)){
                            System.debug('Va a llegar aqui???');
                            R1_Incident__c inci =  map_incidencia.get(maleta.R2_BAG_MSDT_Incident__c);
                            system.debug('---> ' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                            system.debug('--!!!!!-> ' + maleta.R2_BAG_PKL_Type__c);
                                if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c != null){
                                    System.debug('Por aqui tampoco entra');
                                    if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c == 'Clasica'){
                                        if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c)){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            R2_CS_Baggage__c male1Clasica =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Clasica.R2_DIV_estimated_amount__c;
                                        } 
                                    }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c == 'No Iberia Plus'){
                                        if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto')){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto');
                                            
                                            R2_CS_Baggage__c male1Defecto =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto');
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Defecto.R2_DIV_estimated_amount__c;
                                        }
                                    }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c == 'Oro'){
                                        if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c)){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            R2_CS_Baggage__c male1Oro =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Oro.R2_DIV_estimated_amount__c;
                                        }
                                    }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c == 'Plata'){
                                        if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c)){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            R2_CS_Baggage__c male1Plata =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Plata.R2_DIV_estimated_amount__c;
                                        }
                                    }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c == 'Platino'){
                                        if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c)){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            R2_CS_Baggage__c male1Platino =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Card_Type__c);
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Platino.R2_DIV_estimated_amount__c;
                                        }
                                        /*
                                         ******* LO DEJAMOS COMENTADO, YA QUE DE MOMENTO NO TIENE VALOR PERO EN UN FUTURO LO PUEDE TENER ****
                
                                        }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Platinum_level_description__c == 'Infinita'){ // de momento no tiene importe pero lo dejamos preparado por si proximamente tuviera un valor
                                        }else if(inci.R1_INC_LOO_Client__r.R1_ACC_PKL_Platinum_level_description__c == 'Infinita Prime'){ // de momento no tiene importe pero lo dejamos preparado por si proximamente tuviera un valor
                                        }else if(inci.R1_INC_LOO_Client__r.R1_ACC_CHK_Flag_Iberia_Singular__c){ // de momento no tiene importe pero lo dejamos preparado por si proximamente tuviera un valor
                                        }
        								*/
                                    }
                                }else{
                                    System.debug('Se va a colar por el else' + map_cs_bag);
                                    if(map_cs_bag.containsKey(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto')){
                                            System.debug('Tipo de maleta');
                                            System.debug(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto');
                                            
                                            R2_CS_Baggage__c male1Defecto =  map_cs_bag.get(maleta.R2_BAG_PKL_Type__c + '&' + 'Defecto');
                                        	system.debug('maleta1 defecto' + male1Defecto);
                                            maleta.R2_BAG_DIV_Estimated_amount__c = male1Defecto.R2_DIV_estimated_amount__c;
                                        	system.debug('maleta importe: ' + maleta.R2_BAG_DIV_Estimated_amount__c);
                                    }else{
                                        System.debug(':::Error, el mapa del custom setting de baggage no contiene el name');
                                    }
                                }
                            system.debug('precio maleta ' + maleta.R2_BAG_DIV_Estimated_amount__c);
                            valor = String.Valueof(maleta.R2_BAG_DIV_Estimated_amount__c);
                        }
                    }
                } 
              }    
             return valor;
         }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.calcularImporteMaleta()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
             return null;
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture 
    Description:    Metodo para actualizar en un campo de ACcount el total de maletas que tiene un PIR con bono Amazon
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    29/1/2018             Sara Torres Bermudez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
   /* public static void totalMaletasEnPIR(List<R2_Baggage__c> ListMaletas){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
			// campo en workorder: R2_WO_PKL_type__c='Amazon'
			List<R1_Incident__c> lstinci = [SELECT id, Name, R2_INC_TXT_PIR_PIR_incident__c, R2_INC_DAT_PIR_Claim_Date__c FROM R1_Incident__c where R2_INC_LOO_PIR_Baggage__c =: ListMaletas[0].R2_BAG_MSDT_Incident__c LIMIT 1];
		    List<R2_Work_Order__c> lstWo = [SELECT id, R2_WO_LOO_Case__c, R2_WO_PKL_type__c, R2_WO_TXT_cod_amazon__c, R2_WO_TXT_AmazonId__c, R2_WO_TXT_Bags__c, R2_WO_TXT_PIR__c, R2_WO_DAT_Date_Creation_PIR__c FROM R2_Work_Order__c where R2_WO_TXT_Bags__c = :ListMaletas[0].Name AND R2_WO_TXT_PIR__c = : lstinci[0].R2_INC_TXT_PIR_PIR_incident__c AND R2_WO_DATH_GiftCard_Expiracion__c = :lstinci[0].R2_INC_DAT_PIR_Claim_Date__c LIMIT 1];
            List<Case> lstCase = [SELECT id, Account.id, R2_CAS_LOO_PIR__c FROM Case WHERE R2_CAS_LOO_PIR__c =: ListMaletas[0].R2_BAG_MSDT_Incident__c LIMIT 1];
            List<Account> lstAccount = [SELECT id, R2_ACC_NUM_num_maletas_web_sustitucion__c FROM Account WHERE id =: lstCase[0].Accountid LIMIT 1];
           

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.totalMaletasEnPIR()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
        }
    }*/
    
}