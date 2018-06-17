/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   Clase que se ejecuta con el trigger de Task

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version   
    25/07/2017            David Barco               Add the mapUUIField method
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/


public with sharing class R1_CLS_TaskTriggerMethods {
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   Metodo que relaciona el caso con la tarea que le corresponde

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version           
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/


    public static void asignaCasos(List<Task> tareas){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            List<String> lstCalls = new List<String>();
            List<Task> lstTaskToProcess = new List<Task>();
            
            for(Task tarea : tareas){
                if(tarea.CallObject != null && tarea.CallObject != ''){
                      lstCalls.add(tarea.CallObject);
                      lstTaskToProcess.add(tarea);
                }
            }
            List<Case> casos = new List<Case>();
                
            if(!lstCalls.isEmpty()){
                String rtComEn = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Comunicaciones entrantes').getRecordTypeId();
                casos = [SELECT Id, R1_CAS_TXT_Call__c, createdById FROM Case WHERE R1_CAS_TXT_Call__c IN :lstCalls AND RecordTypeid = :rtComEn limit 1];
                
                if(!casos.isEmpty()){
                    for(Integer i = 0; i<lstTaskToProcess.size();i++){
                        for(Case caso : casos){
                            if(caso.R1_CAS_TXT_Call__c == lstTaskToProcess[i].CallObject && caso.CreatedById == lstTaskToProcess[i].CreatedById){
                                lstTaskToProcess[i].WhatId = caso.Id;
                                break;
                            }   
                        }   
                    }   
                }
            }
            
         }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_TaskTriggerMethods.asignaCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Task');
        }  
    }  

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   Método que mapea el campo UUI en los campos en los que se fracciona

    
    History: 
    
    <Date>                <Author>                <Change Description>
    25/07/2017            David Barco               Initial Version            
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void mapUUIField(List<Task> lstTareas){

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            for(Task tarea : lstTareas){

                if(tarea.CallDurationInSeconds != null ){
                    tarea.R1_TSK_TXT_Call_Duration__c = devuelveStringDate(tarea.CallDurationInSeconds);
                }
                
                if(tarea.thinkConnect__UUI__c != '' && tarea.thinkConnect__UUI__c != null){
                    String[] campos = tarea.thinkConnect__UUI__c.split('!');
                
                    tarea.R1_TSK_TXT_cidOriginal__c = campos[0]; //case comments   
                    if(campos[1] != null && campos[1] != ''){
                        Integer seg = Integer.valueOf(campos[1])-40;
                        tarea.R1_TSK_TXT_TimeInQueue__c = devuelveStringDate(seg);//tiempo de espera 
                    }else{
                        tarea.R1_TSK_TXT_TimeInQueue__c = '00:00:00';
                    }
                    tarea.R1_TSK_TXT_ClienteEncontCED__c = campos[2];                   
                    tarea.R1_TSK_TXT_ClienteEncontANI__c = campos[3];                   
                    tarea.R1_TSK_TXT_IdiomaLlamada__c = campos[4];  
                    tarea.R1_TSK_TXT_AgenciaLlamada__c = campos[5];                  
                    tarea.R1_TSK_TXT_clubFiesta__c = campos[6];                         
                    tarea.R1_TSK_TXT_idCliente__c = campos[7];                          
                    tarea.R1_TSK_TXT_numeroFF__c = campos[8];   
                    if(campos[9] != null && campos[9] != ''){                        
                        tarea.R1_TSK_NUM_numRegistros__c = Double.valueOf(campos[9]);
                    }      
                    tarea.R1_TSK_TXT_tipoTarjeta__c = campos[10];  
                    if(campos[11] != null && campos[11] != ''){              
                        tarea.R1_TSK_NUM_AgenciaPorANI__c = Double.valueOf(campos[11]);    
                    }
                    if(campos[12] != null && campos[12] != ''){
                        tarea.R1_TSK_NUM_AgenciaPorCED__c = Double.valueOf(campos[12]);    
                    }
                    if(campos[13] != null && campos[13] != '' && campos[13] != ' '){
                        String idAgente = campos[13];
                        tarea.R1_TSK_LOO_AgentePreferido__c = idAgente.deleteWhitespace();      
                    }
                    tarea.R1_TSK_TXT_ClienteEncontrado__c = campos[14];                 
                    tarea.R1_TSK_TXT_ColaVirtual__c = campos[15];                       
                    tarea.R1_TSK_TXT_grupoAgentes__c = campos[16];  

                    if(campos[17] != null && campos[17] != ''){
                        String numInfinita = campos[17];
                        numInfinita = numInfinita.deleteWhitespace();
                        if(numInfinita == '1'){
                            tarea.R1_TSK_TXT_NumInfinita__c = 'Infinita';    
                        }else if(numInfinita == '2'){
                            tarea.R1_TSK_TXT_NumInfinita__c = 'Infinita Prime';
                        }else if(numInfinita == '3'){
                            tarea.R1_TSK_TXT_NumInfinita__c = 'Oro Acompañante';
                        }else{
                            tarea.R1_TSK_TXT_NumInfinita__c = '';
                        }
                    }

                    tarea.R1_TSK_TXT_TipoLlamada__c = campos[18];                       
                    tarea.R1_TSK_TXT_ScriptName__c = campos[19];                        
                    tarea.R1_TSK_TXT_RVQID__c = campos[20];                             
                    tarea.R1_TSK_TXT_RTargetTypeSelected__c = campos[21];               
                    tarea.R1_TSK_TXT_RTargetRuleSelected__c = campos[22];               
                    tarea.R1_TSK_TXT_RTargetObjectSelected__c = campos[23];             
                    tarea.R1_TSK_TXT_RTargetObjSelDBID__c = campos[24];                 
                    tarea.R1_TSK_TXT_RTargetAgentSelected__c = campos[25];              
                    tarea.R1_TSK_TXT_RTargetPlaceSelected__c = campos[26];              
                    tarea.R1_TSK_TXT_RTenant__c = campos[27];                           
                    tarea.R1_TSK_TXT_Rstrategy_Name__c = campos[28];                    
                    tarea.R1_TSK_TXT_RStrategyDBID__c = campos[29];                     
                    tarea.R1_TSK_TXT_CBR_actual_volume__c = campos[30];                 
                    tarea.R1_TSK_TXT_CBR_Interaction_cost__c = campos[31];              
                    tarea.R1_TSK_TXT_CBR_contract_DBIDs__c = campos[32];                
                    tarea.R1_TSK_TXT_CBR_IT_path_DBIDs__c = campos[33];                 
                    tarea.R1_TSK_TXT_RRequestedSkillCombination__c = campos[34];        
                    tarea.R1_TSK_TXT_RRequestedSkills__c = campos[35];                  
                    tarea.R1_TSK_TXT_RtargetRequested__c = campos[36];                  
                    tarea.R1_TSK_TXT_CustomerSegment__c = campos[37];                   
                    tarea.R1_TSK_TXT_ServiceType__c = campos[38];                       
                    tarea.R1_TSK_TXT_ServiceObjective__c = campos[39]; 

                    //lineas para rellenar el campo R2_TSK_TXT_Service__c que guarda el servicio relacionado con el CS R1_CTI_Services__c
                    List<R1_CTI_Services__c> servicioCTI= [SELECT Id, R1_CTI_Service__c, R1_CTI_Phone__c FROM R1_CTI_Services__c  WHERE R1_CTI_Phone__c =: tarea.thinkConnect__DNIS__c LIMIT 1];
                    if(servicioCTI != null && !servicioCTI.isEmpty()){
                        tarea.R2_TSK_TXT_Service__c = servicioCTI[0].R1_CTI_Service__c;
                    }
                    //tarea.R2_TSK_TXT_Service__c
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_TaskTriggerMethods.mapUUIField()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Task');
        } 
    }  


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   Método que convierte a String en formato 00:00:00 una cantidad de segundos dada

    
    History: 
    
    <Date>                <Author>                <Change Description>
    28/07/2017            David Barco               Initial Version            
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String devuelveStringDate(Integer s){
        String fechaFormat = '';
        if(s < 0){
            fechaFormat += '00:00:00';
        }else{
            
            if(s >= 60){
                Integer hour,min,seg;

                hour=s/3600;
                if(hour < 10){
                    fechaFormat += '0'+hour+':';
                }else{
                    fechaFormat += hour+':';
                }

                min=(s-(3600*hour))/60;
                if(min < 10){
                    fechaFormat += '0'+min+':';
                }else{
                    fechaFormat += min+':';
                }

                seg=s-((hour*3600)+(min*60));
                if(seg < 10){
                    fechaFormat += '0'+seg;
                }else{
                    fechaFormat += seg;
                }
            }else{
                if(s < 10){
                    fechaFormat += '00:00:0'+s;
                }else{
                    fechaFormat += '00:00:'+s;
                }
            }
        }
        System.debug('======= Hora formateada --> ' + fechaFormat);
        return fechaFormat;
    }
}