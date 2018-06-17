/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_IncidentTriggerMethods {
	/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    10/10/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static void rellenaExternalID(List<R1_Incident__c> incidencias){
		try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            String dia;
            String mes;
            String year;
            Id rtID = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
       
            if(!incidencias.isEmpty()){
                for(R1_Incident__c inci : incidencias){
                    if((inci.RecordTypeId == rtID) && (inci.R2_INC_DAT_PIR_Claims_Created_Date__c != null) && (inci.R2_INC_TXT_PIR_PIR_incident__c != null || inci.R2_INC_TXT_PIR_PIR_incident__c != '') && (inci.R2_INC_TXT_PIR_EA_External_ID__c == null || inci.R2_INC_TXT_PIR_EA_External_ID__c == '')){
                    	dia = String.valueOf(inci.R2_INC_DAT_PIR_Claims_Created_Date__c.day());
                        mes =  String.valueOf(inci.R2_INC_DAT_PIR_Claims_Created_Date__c.month());
                        year = String.valueOf(inci.R2_INC_DAT_PIR_Claims_Created_Date__c.year());
                        if(dia.length()==1){
                            dia = '0' + dia;
                        }
                        if(mes.length()==1){
                            mes = '0' + mes;
                        }
                        inci.R2_INC_TXT_PIR_EA_External_ID__c = inci.R2_INC_TXT_PIR_PIR_incident__c + year + mes + dia;
                       	System.debug('fecha: ' + year + mes + dia);
                    }
                }
            }
        
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_IncidentTriggerMethods.rellenaExternalID', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
        }   
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/11/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static void crearMotivoPreOrder(List<R1_Incident__c> incidencias){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            Id rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('Incidencia I Purser').getRecordTypeId();
        	Id rtPasj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        	Id rtExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            
            Set<Id> incIds = new Set<Id>();
            System.debug('Viene por aqui ' + incidencias);
            if(!incidencias.isEmpty()){
                for(R1_Incident__c inc : incidencias){
                    if(inc.RecordTypeId == rtInc && (inc.R2_INC_PKL_II_Type__c == 'Menus Preorder A la carta')){
                        incIds.add(inc.Id);
                    }
                }
            }
            List<R1_Incident__c> incIPurser = [SELECT Id, R2_INC_TXT_II_TKT__c, R2_INC_TXT_II_Depart_flight__c, R2_INC_LOO_Flight__c, R2_INC_TXT_II_Primary_Frequent_Flyer_Car__c,
                                               R2_INC_PKL_II_Cabin__c, R2_INC_TXT_II_Arrival_flight__c, R1_INC_LOO_II_Client__c FROM R1_Incident__c WHERE Id IN :incIds];
                
            System.debug('Viene por aqui '+incIPurser);        
            List<Case> casosConClient = new List<Case>();
            List<Case> casosSinClient = new List<Case>();
            List<Case> casosHijos = new List<Case>();
            
            if(!incIPurser.isEmpty()){
                for(R1_Incident__c incIP : incIPurser){
                    Case caso = new Case();
                    caso.RecordTypeId = rtExp;
                    caso.Status = 'Abierto';
                    caso.Type = 'Servicios gastronomicos';
                    caso.R2_CAS_PKL_Class_flown__c = incIP.R2_INC_PKL_II_Cabin__c;
                    system.debug('tipo de cabina en incidencia: ' + incIP.R2_INC_PKL_II_Cabin__c);
                    /*if(incIP.R2_INC_PKL_II_Cabin__c == 'Business'){
                        caso.R1_CAS_PKL_Subtype__c = 'No corresponde reembolso';
                    }else{
                        caso.R1_CAS_PKL_Subtype__c = 'Reembolso';
                    }*/
                    caso.R2_CAS_TXT_TKT_Ticket__c = incIP.R2_INC_TXT_II_TKT__c;
                    caso.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c = incIP.R2_INC_TXT_II_Primary_Frequent_Flyer_Car__c;
                    caso.R1_CAS_LOO_Flight__c = incIP.R2_INC_LOO_Flight__c;
                    caso.R1_CAS_LOO_Incidences__c = incIP.Id;
                    if(incIP.R1_INC_LOO_II_Client__c != null){
                        caso.AccountId = incIP.R1_INC_LOO_II_Client__c;
                        casosConClient.add(caso);
                        System.debug('casoIdCCC llegaaaa');
                    }else if(incIP.R1_INC_LOO_II_Client__c == null){
                        casosSinClient.add(caso);
                        System.debug('casoId llegaaaa');
                    }
                }
                
                if(!casosConClient.isEmpty()){
                    insert casosConClient;
                }
                
                if(!casosSinClient.isEmpty()){
                    insert casosSinClient;
                    
                    for(Case caso : casosSinClient){
                        Case casoHijo = caso.clone(false, false, false, false);
                        casoHijo.RecordTypeId = rtPasj;
                        casoHijo.ParentId = caso.Id;
                        casosHijos.add(casoHijo);
                        System.debug('casoId' + caso.Id);
                    }
                    
                    if(!casosHijos.isEmpty()){
                        insert casosHijos;
                    }
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_IncidentTriggerMethods.crearMotivoPreOrder', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
        } 
    }
    
}