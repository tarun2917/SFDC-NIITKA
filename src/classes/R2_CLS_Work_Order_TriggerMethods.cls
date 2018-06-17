/*---------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay
Company:        Accenture 
Description:    Methods for Work Order
IN:             
OUT:            

History: 
 <Date>                     <Author>                         <Change Description>
25/10/2017                  Borja Gay                           Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_Work_Order_TriggerMethods{
/*---------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay
Company:        Accenture 
Description:    Method to process Work Order
IN:             
OUT:            

History: 
 <Date>                     <Author>                         <Change Description>
25/10/2017                  Borja Gay                           Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public static void procesarOT(List<R2_Work_Order__c> ot){
    try{
        Map<string,R2_Work_Order__c> mapOT = new Map<String, R2_Work_Order__c>();
        Map<string,R2_Work_Order__c> mapOTNuevas = new Map<String,R2_Work_Order__c>();
        Map<String,Case> mapCasoExistente = new Map<String,case>();
        Map<String,Case> mapCasoPadre = new Map<String,case>();
        Map<String,Case> mapCasoHijo = new Map<String,case>();
        Map<string,R1_Incident__c> mapPir = new Map<string,R1_Incident__c>();
        Map<string,string> mapPirExistente = new Map<String,String>();
        Map<string,string> mapExpedientesExist = new Map<String,String>();
        List<Case> lstCasoExistente = new List<Case>();
        List<Case> lstCasoPadre=new List<Case>();
        List<Case> lstCasoHijo = new List<Case>();
        List<Case> lstCasoHijoUpdate = new List<Case>();
        List<R1_Incident__c> lstPirNuevo= new List<R1_Incident__c>();
        List<R1_Incident__c> lstPir= new List<R1_Incident__c>();
        String diaPIR;
        String mesPIR;
        String extIdPir;
        String keyOt;
        String rtPir = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR DPR').getRecordTypeId();
        String rtEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        for(R2_Work_Order__c wo : ot){
            if(wo.R2_WO_PKL_type__c =='' || wo.R2_WO_PKL_type__c == null){
                diaPIR = String.valueOf(wo.R2_WO_DAT_Date_Creation_PIR__c.day());
                if(diaPIR.length()==1){
                    diaPIR = '0' + diaPIR;
                }
                mesPIR = String.valueOf(wo.R2_WO_DAT_Date_Creation_PIR__c.month());
                if(mesPIR.length()==1){
                    mesPIR = '0' + mesPIR;
                }
                extIdPIR = wo.R2_WO_TXT_PIR__c + String.valueOf(wo.R2_WO_DAT_Date_Creation_PIR__c.year()) + mesPIR + diaPIR;
                mapOT.put(wo.R2_WO_TXT_OT__c+','+wo.R2_WO_TXT_main_file__c+','+extIdPir, wo);
                mapPirExistente.put(wo.R2_WO_TXT_OT__c+','+wo.R2_WO_TXT_main_file__c+','+extIdPir,extIdPir);
                mapExpedientesExist.put(wo.R2_WO_TXT_OT__c+','+wo.R2_WO_TXT_main_file__c+','+extIdPir,wo.R2_WO_TXT_main_file__c);
            }
            else{}
        }
        lstCasoExistente = [SELECT id,Parentid, Parent.R2_CAS_TXT_EA_Main_File__c,R2_CAS_LOO_PIR__c,R2_CAS_LOO_PIR__r.R2_INC_TXT_PIR_EA_External_ID__c FROM Case where Parent.R2_CAS_TXT_EA_Main_File__c IN :mapExpedientesExist.values() AND R2_CAS_LOO_PIR__r.R2_INC_TXT_PIR_EA_External_ID__c In :mapPirExistente.values()];

        for(Case caso : lstCasoExistente){
            mapCasoExistente.put(caso.Parent.R2_CAS_TXT_EA_Main_File__c+caso.R2_CAS_LOO_PIR__r.R2_INC_TXT_PIR_EA_External_ID__c,caso);
        }
        System.debug('Mapa OT: '+mapOt);
        for(String idKey : mapOt.keySet()){
            List<String> keyCasos = idKey.split(',');

            if(mapCasoExistente.containsKey(keyCasos[1]+keyCasos[2])){
                R2_Work_Order__c wo = mapOt.get(idKey);
                wo.R2_WO_LOO_Case__c = mapCasoExistente.get(keyCasos[1]+keyCasos[2]).id;
                mapOt.remove(idKey);
                System.debug('Mapa OT Nuevo: '+mapOt);
            }
        }
        if(!mapOT.isEmpty()){
            System.debug('Entro aqui');
            lstPir=[SELECT id,R2_INC_TXT_PIR_PIR_incident__c,R2_INC_DAT_PIR_Claims_Created_Date__c,R2_INC_TXT_PIR_EA_External_ID__c FROM R1_Incident__c where R2_INC_TXT_PIR_EA_External_ID__c IN :mapPirExistente.values()];
            System.debug('PIR:'+lstPir);
            for(R1_Incident__c inc : lstPir){
                mapPir.put(inc.R2_INC_TXT_PIR_EA_External_ID__c,inc);

            }
            for(String idKey : mapOT.keySet()){
                R2_Work_Order__c wo = mapOt.get(idKey);
                if(!mapCasoPadre.containsKey(wo.R2_WO_TXT_main_file__c)){
                Case casoPadre = new Case();
                casoPadre.RecordTypeId=rtEquip;
                casoPadre.Status = 'Abierto';
                casoPadre.Type = 'Deterioro';
                casoPadre.R2_CAS_PKL_Vip_Type__c = 'Estandar';
                casoPadre.Origin = 'EuropeAssistance';
                if(wo.R2_WO_LOO_Client__c != null){
                casoPadre.AccountId = wo.R2_WO_LOO_Client__c;
                casoPadre.R2_CAS_TXT_LastName__c = wo.R2_WO_LOO_Client__r.LastName;
                casoPadre.R2_CAS_TXT_Name__c = wo.R2_WO_LOO_Client__r.FirstName;
                }
                casoPadre.R2_CAS_TXT_EA_Main_File__c = wo.R2_WO_TXT_main_file__c;
                System.debug('Hago Padre');
                lstCasoPadre.add(casoPadre);
                mapCasoPadre.put(wo.R2_WO_TXT_main_file__c,casoPadre);
                }
                List<String> keyPir = idKey.split(',');
                if(!mapPir.containsKey(keyPir[2])){
                    R1_Incident__c pir  = new R1_Incident__c();
                    pir.RecordTypeId = rtPir;
                    pir.R2_INC_TXT_PIR_PIR_incident__c = wo.R2_WO_TXT_PIR__c;
                    pir.R2_INC_TXT_PIR_Station_Code__c = wo.R2_WO_TXT_PIR__c.SubString(0,3);
                    pir.R2_INC_TXT_PIR_Airline_Code__c  = wo.R2_WO_TXT_PIR__c.SubString(3,5);
                    pir.R2_INC_TXT_PIR_Reference_Number__c =  wo.R2_WO_TXT_PIR__c.SubString(5);
                    pir.R2_INC_DAT_PIR_Claims_Created_Date__c =wo.R2_WO_DAT_Date_Creation_PIR__c;
                    pir.R2_INC_DAT_PIR_Claim_Date__c = wo.R2_WO_DAT_Date_Creation_PIR__c;
                    System.debug('Hago PIR');
                    lstPirNuevo.add(pir);
                    mapPir.put(keyPir[2],pir);
                }
            }
        }
        insert lstCasoPadre;
        System.debug('Insertado Padre: '+lstCasoPadre);
        insert lstPirNuevo;
        System.debug('Insertados: '+lstPirNuevo);
        System.debug('Mapa PIR: '+mapPir);
        lstCasoHijo=[SELECT id,Parentid, Parent.R2_CAS_TXT_EA_Main_File__c,R2_CAS_LOO_PIR__c,R2_CAS_LOO_PIR__r.R2_INC_TXT_PIR_EA_External_ID__c FROM Case where Parentid IN :lstCasoPadre];
        System.debug('Casos: '+lstCasoHijo + lstCasoHijo.size());
        if(!lstCasoHijo.isEmpty()){
            for(Case hijo : lstCasoHijo){
                mapCasoHijo.put(hijo.Parent.R2_CAS_TXT_EA_Main_File__c,hijo);
            }
            System.debug('Entro en Loop Final');
            for(String idKey : mapOt.keyset()){
                R2_Work_Order__c wo = mapOt.get(idKey);
                System.debug('WO: '+wo);
                System.debug('Mapa Hijos: '+mapCasoHijo);
                System.debug('Mapa PIR: '+mapPir);
                List<String> keyCasos = idKey.split(',');
                System.debug('KEYS: '+keyCasos);
                if(mapCasoHijo.containsKey(keyCasos[1])){
                    Case hijo = mapCasoHijo.get(keyCasos[1]);
                    wo.R2_WO_LOO_Case__c=hijo.id;
                    hijo.R2_CAS_LOO_PIR__c= mapPir.get(keyCasos[2]).id;
                    lstCasoHijoUpdate.add(hijo);
                }
            }
        }
        update mapCasoHijo.values();
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Work_Order_TriggerMethods.procesarOT()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Work_Order__c');
        }
    }
}