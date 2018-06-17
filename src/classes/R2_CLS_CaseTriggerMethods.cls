/*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Clase de metodos para el trigger de casos
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
28/07/2017             Rubén Pingarrón Jerez                   Initial Version
03/10/2017             Jaime Ascanta                           asignaAccountToCaseRTIberiaCom
18/10/2017             Alvaro Garcia Tapia                     updateClaimantEntity
----------------------------------------------------------------------------------------------------------------------*/
global class R2_CLS_CaseTriggerMethods {
    public class wrpMailGenerico{
       public String Cola='';
       public String Idioma='';
       public String Categoria='';
       public String FechaCreacion='';
       public String FechaModificacion='';
       public String NivelTarjeta='';
       public String FechaVuelo='';
       public String CaseId='';
       public String CaseNumber='';
    }

    public class wrpMailJuridico{
        public String Cola='';
        public String Idioma='';
        public String Categoria='';
        public String FechaCreacion='';
        public String FechaModificacion='';
        //public String PaisJuzgado='';
        //public String FechaLimiteTipo='';
        //public String FechaLimiteJuridico='';
        public String CaseId='';
        public String CaseNumber='';
    }
    public class wrpMailC2C{
       public String Cola='';
       public String Idioma='';
       public String PNR='';
       public String Mercado = '';
       public String Nombre='';
       public String Canal = '';
       public String TelefonoContacto='';
       public String CaseId='';
       public String CaseNumber='';
    }
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Sara Torres Bermúdez
Company:        Accenture
Description:   Mapa para poder reutilizar la misma query
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
31/07/2017             Sara Torres Bermúdez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/

    static final map<String, Id> MAP_RT_NAME = new map<String, Id>();

    static{
        for(RecordType rt : [SELECT Id, name FROM RecordType WHERE SobjectType IN ('Case','RecordTypeId')]){

            MAP_RT_NAME.put(rt.name,rt.Id);
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay Flores
Company:        Accenture
Description:
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
25/09/2017             Borja Gay Flores                        Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static List<Case> filtrarCasosWeb(List<Case> lstCasos){
        List<Case> lstCasosWeb = new List<Case>();
        for(Case caso : lstCasos){
            if(caso.Origin == 'Web'){
                lstCasosWeb.add(caso);
            }
        }

        return lstCasosWeb;
    }
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay Flores
Company:        Accenture
Description:    Metodo para asignar al padre a una cola siendo de tipo pasaje o equipaje
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
25/09/2017             Borja Gay Flores                        Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static void insertarCasoPadreEnCola(List<Case> lstCasosWeb){
        try{
                if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
                system.debug('entro en insertar padre en cola 1');
                String idPasaje;
                String idEquipaje;
                Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
                List<Group> lstColas =  [SELECT id,Name from Group where Type = 'Queue' and Name in('SYR Gestión Pasaje','SYR Gestión Equipaje')];
                if(lstColas != null){
                    for(Group cola : lstColas){
                        if(cola.Name == 'SYR Gestión Pasaje'){
                            idPasaje = cola.id;
                        }
                        if(cola.Name =='SYR Gestión Equipaje'){
                            idEquipaje = cola.id;
                        }
                    }
                }

                for(Case caso : lstCasosWeb){
                    if(caso.RecordTypeId == rtIdExp){
                        if(caso.Type == 'Demora' || caso.Type == 'Deterioro' || caso.Type == 'Extravío' || caso.Type == 'Falta de contenido' ){
                            caso.OwnerId = idEquipaje;
                        }
                        else{
                            caso.OwnerId = idPasaje;
                        }
                    }
                }
            }


        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.insertarCasoPadreEnCola()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    public static void asignarOwnerADocumentosEscaneados(List<Case> lstCasos){
        try{
            String idAsignacion;
            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            List<Group> lstColas =  [SELECT id,Name from Group where Type = 'Queue' and Name in('SYR Asignación')];
            if(lstColas!= null){
                for(Case caso : lstCasos){
                    if(caso.Origin == 'Documentos escaneados' && caso.RecordTypeId == rtIdExp){
                        caso.OwnerId = lstColas[0].id;
                    }
                }
            }
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignarOwnerADocumentosEscaneados()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que crea un hijo a un caso padre
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
28/07/2017             Rubén Pingarrón Jerez                   Initial Version
27/03/2017             Jaime Ascanta                           agregada logica para casos proactivos
----------------------------------------------------------------------------------------------------------------------*/
    public static void asignarCasoHijoInsert(List<Case> lstCasos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            List<Case> lstCasosPadre = new List<Case>();

            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
            Id rtIdProac = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();

            if(!lstCasos.isEmpty()){
                for(Case caso : lstCasos){
                    //System.debug('CasoEntrante: '+ caso);
                    if( caso.RecordTypeId == rtIdExp && (caso.R1_CAS_LOO_Flight__c != null || (caso.R2_CAS_TXT_EA_Main_File__c != null && caso.R2_CAS_TXT_EA_Main_File__c != '')) && caso.AccountId != null ||
                        (caso.RecordTypeId == rtIdExp && caso.R2_CAS_CHK_Is_Proactive__c==true) ){
                        // Filtramos en una lista los casos a los que se le crearan hijos
                        lstCasosPadre.add(caso);
                        //System.debug('lstCasosPadre: '+ lstCasosPadre);
                    }
                }
            }

            List<Case> lstCasosHijo = new List<Case>();

            if(!lstCasosPadre.isEmpty()){
                List<Profile> perfil = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                String perfilName = perfil[0].Name;
                if(perfilName != 'Call Center CCPO'){
                    for(Case caso : lstCasosPadre){
                        // Por cada caso padre clonamos un caso hijo y lo relacionamos mediante el ParentId del hijo
                        Case casoHijo = caso.clone(false, false, false, false);
                        casoHijo.ParentId = caso.Id;
                        if((caso.Status == 'Cancelado') || (caso.Status == 'Cerrado') || (caso.Status == 'Cerrado Pendiente de Pago') || (caso.Status == 'Abierto a la espera de info de Iberia' ) || (caso.Status == 'Abierto a la espera de la info del cliente')){
                            casoHijo.Status = 'Cerrado';
                        }else{
                            casoHijo.Status = 'Abierto';
                        }
                        // Dependiendo del Type del caso padre el recordType del hijo sera uno u otro
                        if(caso.Type == 'Demora' || caso.Type == 'Deterioro' || caso.Type == 'Extravío' || caso.Type == 'Demora con deterioro' || caso.Type == 'Deterioro con falta de contenido' || caso.Type == 'Demora con deterioro y falta de contenido'){
                            casoHijo.RecordTypeId = rtIdEquip;
                        }else if (caso.R2_CAS_CHK_Is_Proactive__c == true){
                            casoHijo.R2_CAS_CHK_Is_Proactive__c = true;
                            casoHijo.RecordTypeId = rtIdPasaj;
                        }else{
                            casoHijo.RecordTypeId = rtIdPasaj;
                        }

                        lstCasosHijo.add(casoHijo);
                    }
                }
            }
            if(!lstCasosHijo.isEmpty()){
                insert lstCasosHijo;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignarCasoHijoInsert()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que crea un hijo a un caso padre
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
28/07/2017             Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static void asignarCasoHijoUpdate(List<Case> lstCasosNew, List<Case> lstCasosOld){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            List<Case> lstCasosParaUpdate = new List<Case>();

            List<Case> lstCasos = [SELECT Id, ParentId, RecordTypeId, Type, R2_CAS_TXT_EA_Main_File__c, R1_CAS_PKL_Subtype__c, Status, Origin, AccountId, R1_CAS_LOO_Flight__c,
                                   (SELECT Id FROM Cases) FROM Case WHERE Id IN :lstCasosNew];
            //System.debug('CasosUpdate: '+ lstCasos);

            //Id rtIdEquip = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
            //Id rtIdPasaj = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'Pasaje' LIMIT 1].Id;
            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();

            if(!lstCasos.isEmpty()){
                for(Case caso : lstCasos){
                    // Filtramos los casos que se les creara un hijo de todos los que se actualizan
                    if(caso.Cases.size()==0 && (caso.R1_CAS_LOO_Flight__c != null || (caso.R2_CAS_TXT_EA_Main_File__c != null && caso.R2_CAS_TXT_EA_Main_File__c != '') || (caso.R2_CAS_CHK_Is_Proactive__c = true)) && caso.AccountId != null && caso.RecordTypeId == rtIdExp){//añado caso.RTId == rtIdExp (alberto)
                        lstCasosParaUpdate.add(caso);
                    }
                }
            }

            List<Case> lstCasosHijo = new List<Case>();


            if(!lstCasosParaUpdate.isEmpty()){
                List<Profile> perfil = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                String perfilName = perfil[0].Name;

                for(Case caso : lstCasosParaUpdate){
                    if(perfilName != 'Call Center CCPO'){
                        // Creamos un hijo identico para caso padre igual que en el insert
                        Case casoHijo = caso.clone(false, false, false, false);

                        casoHijo.ParentId = caso.Id;
                        if((caso.Status == 'Cancelado') || (caso.Status == 'Cerrado') || (caso.Status == 'Cerrado Pendiente de Pago') || (caso.Status == 'Abierto a la espera de info de Iberia' ) || (caso.Status == 'Abierto a la espera de la info del cliente')){
                            casoHijo.Status = 'Cerrado';
                        }else{
                            casoHijo.Status = 'Abierto';
                        }
                        if(caso.Type == 'Demora' || caso.Type == 'Deterioro' || caso.Type == 'Extravío' || caso.Type == 'Demora con deterioro' || caso.Type == 'Deterioro con falta de contenido' || caso.Type == 'Demora con deterioro y falta de contenido'){
                            casoHijo.RecordTypeId = rtIdEquip;
                        }else{
                            casoHijo.RecordTypeId = rtIdPasaj;
                        }
                        lstCasosHijo.add(casoHijo);

                    }
                }
            }

            if(!lstCasosHijo.isEmpty()){
                insert lstCasosHijo;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignarCasoHijoUpdate()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Ismael Yubero
Company:       Accenture
Description:   Metodo que encuentra el caso padre de un caso hijo, y los relaciona


History:

<Date>                  <Author>                            <Change Description>
07/07/2017              Ismael Yubero                            Initial Version
28/07/2017             Rubén Pigarrón Jerez                     Initial Version
01/08/2017             Alberto Puerto Collado                   Cambios de status
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void asignaPadre(List<Case> casos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            List<Case> lstCasosSinPadre = new List<Case>();
            Set<Id> lstClientes = new Set<Id>();
            Set<Id> lstVuelos = new Set<Id>();
            Set<Date> lstFechas = new Set<Date>();

            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();

            if(!casos.isEmpty()){
                for(Case caso : casos){
                    // Filtramos los casos hijos que no tengan padre
                    if(caso.parentId == null && caso.RecordTypeId != rtIdExp){
                        lstClientes.add(caso.AccountId);
                        lstVuelos.add(caso.R1_CAS_LOO_Flight__c);
                        //lstFechas.add(caso.R2_CAS_FOR_Flight_date_local__c );
                        lstCasosSinPadre.add(caso);
                    }
                }
            }
            // Query que guarda en una lista los posibles padres de los hijos que han entrado
            List<Case> lstCasosPadres = [SELECT Id, RecordTypeId, AccountId, R1_CAS_LOO_Flight__c, R2_CAS_FOR_Flight_date_local__c, Status, Origin
                                         FROM Case WHERE RecordTypeId = :rtIdExp  AND (AccountID IN :lstClientes
                                                                                       AND R1_CAS_LOO_Flight__c IN :lstVuelos)//AND R2_CAS_FOR_Flight_date_local__c IN :lstFechas)];
                                         AND R1_CAS_LOO_Flight__c != null AND AccountId != null];//added 07/08 Alberto por si existen casos sin esos campos

            // System.debug('Size de LST CASOS PADRES->'+lstCasosPadres.size());
            //System.debug('LST CASOS PADRES->'+lstCasosPadres);

            //casos hijos
            if(!lstCasosPadres.isEmpty() && !lstCasosSinPadre.isEmpty()){
                for(Case caso : lstCasosSinPadre){
                    for(Integer i = 0; i < lstCasosPadres.size(); i++){
                        system.debug('---> ');
                        // Por cada caso hijo buscamos su padre en la lista de posibles padres y lo relacionamos mediante el ParentId del hijo
                        if(lstCasosPadres[i].AccountId == caso.AccountId && lstCasosPadres[i].R1_CAS_LOO_Flight__c == caso.R1_CAS_LOO_Flight__c){
                            //&& lstCasosPadres[i].R2_CAS_FOR_Flight_date_local__c == caso.R2_CAS_FOR_Flight_date_local__c){
                            caso.ParentId = lstCasosPadres[i].Id;
                            // --------------------------- aquiiii -------------------------------

                            // le tengo que pasar el hijo con el tipo que es, si es de tipo Equipaje o PAsaje
                            //Añadido 1 agosto 2017
                            //System.debug('Entro en PENULTIMO if de asignaPadre');
                            if(lstCasosPadres[i].Status != 'Trabajando' || lstCasosPadres[i].Status != 'Reabierto' || lstCasosPadres[i].Status != 'Abierto'){// && lstCasosPadres[i].Origin == 'Web'){ para todos los Origin al final
                                //  System.debug('Entro en ultimo if de asignaPadre || STATUS ORIGINAL '+lstCasosPadres[i].Status);
                                lstCasosPadres[i].Status = 'Reabierto';
                                //  System.debug('asignaPadre - STATUS padres CAMBIADO-> '+lstCasosPadres[i].Status);
                            }
                        }
                        break;
                    }
                }
                /*  system.debug('asignaPadre antes de llamar al metodo de cambiar las colas: ' + caso.OwnerId);
insertarCasoPadreEnCola(lstCasosPadres);
insertarCasoPadreEnCola(lstCasosSinPadre);
system.debug('asignaPadre he salido del metodo de cambiar las colas: ' + caso.OwnerId);*/
                update lstCasosPadres;
            }
            //casos padres
            if(!lstCasosSinPadre.isEmpty()){
                for(Integer i = 0; i < lstCasosSinPadre.size(); i++){
                    if((lstCasosSinPadre[i].recordTypeId == rtIdEquip || lstCasosSinPadre[i].recordTypeId == rtIdPasaj) && lstCasosSinPadre[i].ParentId == null){
                        lstCasosSinPadre[i].recordTypeId = rtIdExp;
                        //añadido 1 agosto 2017
                        //  System.debug('asigna hijo (newpadre) - status original-> '+lstCasosSinPadre[i].Status);
                        lstCasosSinPadre[i].Status = 'Abierto';
                        //  System.debug('asigna hijo (newpadre) - status cambiado-> '+lstCasosSinPadre[i].Status);
                    }
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_CAS_TriggerMethods.asignaPadre()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Alberto Puerto Collado
Company:       Accenture
Description:   Cada vez que entre un origin = web, y exista un caso tipo expediente cliente-vuelo-fecha, poner el caso que entra
como hijo del caso expediente y reabrir el caso expediente
El caso entra sin recordType, una vez se compruebe si es padre o hijo se le pone el correspondiente,
si fuera padre, el trigger que tenemos que crea hijos crearía al hijo correspondiente.
Id vuelo, idioma, tipo y account

NOTA: Es posible fusionarlo con asignaPadre?

History:

<Date>                       <Author>                    <Change Description>
31/07/2017             Alberto Puerto Collado               Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    /*public static void reabrirExpediente(List<Case> casos){
try{
if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
//solo entra un caso
if(!casos.isEmpty()){
if(casos[0].Origin =='Web'){
Id rtIdExp = MAP_RT_NAME.get('Expediente');

List<Case> lstCasosExpediente = [SELECT Id, RecordTypeId, AccountId, R1_CAS_LOO_Flight__c, R2_CAS_FOR_Flight_date_local__c, Status
FROM Case
WHERE recordTypeId = :rtIdExp
AND AccountId = :casos[0].AccountId
AND R1_CAS_LOO_Flight__c = :casos[0].R1_CAS_LOO_Flight__c
AND R2_CAS_FOR_Flight_date_local__c = :casos[0].R2_CAS_FOR_Flight_date_local__c]; //sólo saldra 0 o 1
System.debug('Lista Casos Expediente ->'+lstCasosExpediente);
if(!lstCasosExpediente.isEmpty()){
System.debug('LST CASOS EXPEDIENTE ----- llena');
if(lstCasosExpediente[0].Status != 'Trabajando'){
lstCasosExpediente[0].Status = 'Reabierto';
update lstCasosExpediente;
}
casos[0].parentId = lstCasosExpediente[0].id;
}else{
System.debug('LST CASOS EXPEDIENTE ----- Vacía');
casos[0].Status = 'Abierto';
casos[0].recordTypeId = rtIdExp;
}
}
}
}catch(Exception e){
R1_CLS_LogHelper.generateErrorLog('R1_CLS_CAS_TriggerMethods.reabrirExpediente()', '', e.getmessage()+', '+e.getLineNumber(), 'Case');
}
}*/

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:   Metodo para sacar en el padre, el total de rebotes de todos los hijos.


History:

<Date>                        <Author>                       <Change Description>
10/07/2017                  Sara Torres Bermúdez              Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static void CuentaCasos(List<Case> casos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Set<Id> setCasosHijos = new Set<Id>();
            List<Case> lstCasosParaActualizar = new List<Case>();

            if(!casos.isEmpty()){
                for(Case caso : casos){
                    if(caso.ParentId != null){
                        setCasosHijos.add(caso.ParentId);
                    }
                }
            }
            // nos interesan los que antes estaban a false y ahora estan a true, no todos.
            List<Case> lstCheck = [SELECT ParentId, R2_CAS_CHK_Rebound__c FROM Case WHERE parentId IN :setCasosHijos];

            Map<ID, Integer> mapRebote = new Map<ID, Integer>();
            Set<Id> parentId_set = new Set<Id>();

            if(!lstCheck.isEmpty()){
                for(Integer i = 0; i < lstCheck.size(); i++){
                    if (!mapRebote.containsKey(lstCheck[i].ParentId)){
                        parentId_set.add(lstCheck[i].ParentId);
                        mapRebote.put(lstCheck[i].ParentId, 0);
                    }
                    if (lstCheck[i].R2_CAS_CHK_Rebound__c){
                        mapRebote.put(lstCheck[i].ParentId, mapRebote.get(lstCheck[i].ParentId) +1);
                    }
                }
                List<Case> toUpdate = new List<Case>();
                //añadido 25/09
                List<Case> temp = [SELECT id, R2_CAS_NUM_Number_of_rebounds__c  FROM Case WHERE id IN :parentId_set];
                for (Case cPadre: temp) {
                    cPadre.R2_CAS_NUM_Number_of_rebounds__c = mapRebote.get(cPadre.Id);
                    toUpdate.add(cPadre);
                }
                /* antes de 25/09:
for (Id idpadre: parentId_set) {
Case temp = new Case(Id = idpadre, R2_CAS_NUM_Number_of_rebounds__c = mapRebote.get(idpadre));
toUpdate.add(temp);
}
*/
                if (!toUpdate.isEmpty()){
                    System.debug('CuentaCasos toUPDATE::::::' + toUpdate);
                    update toUpdate;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.CuentaCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:   Metodo para sacar en el padre, el total de rebotes de todos los hijos.
->Sólo update para que no actualice cuando new & old coincidan (R2_CAS_CHK_Rebound__c)


History:

<Date>                        <Author>                       <Change Description>
25/09/2017             Alberto Puerto Collado               Initial Version
25/09/2017             Rubén Pigarrón Jerez                 Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void CuentaCasosUpdate(List<Case> newcases, List<Case> oldCases){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Set<Id> setCasosHijos = new Set<Id>();
            List<Case> lstCasosParaActualizar = new List<Case>();

            if(!newcases.isEmpty() && !oldCases.isEmpty()){
                for(Integer i = 0; i < newcases.size(); i++){
                    if(newcases[i].R2_CAS_CHK_Rebound__c != oldCases[i].R2_CAS_CHK_Rebound__c && newcases[i].ParentId != null){
                        setCasosHijos.add(newcases[i].ParentId);
                    }
                }


                // nos interesan los que antes estaban a false y ahora estan a true, no todos.
                List<Case> lstCheck = [SELECT ParentId, R2_CAS_CHK_Rebound__c FROM Case WHERE parentId IN :setCasosHijos];

                Map<ID, Integer> mapRebote = new Map<ID, Integer>();
                Set<Id> parentId_set = new Set<Id>();

                if(!lstCheck.isEmpty()){
                    for(Integer i = 0; i < lstCheck.size(); i++){
                        if (!mapRebote.containsKey(lstCheck[i].ParentId)){
                            parentId_set.add(lstCheck[i].ParentId);
                            mapRebote.put(lstCheck[i].ParentId, 0);
                        }
                        if (lstCheck[i].R2_CAS_CHK_Rebound__c){
                            mapRebote.put(lstCheck[i].ParentId, mapRebote.get(lstCheck[i].ParentId) +1);
                        }
                    }
                    List<Case> toUpdate = new List<Case>();
                    //añadido 25/09
                    List<Case> temp = [SELECT id, R2_CAS_NUM_Number_of_rebounds__c  FROM Case WHERE id IN :parentId_set];
                    for (Case cPadre: temp) {
                        cPadre.R2_CAS_NUM_Number_of_rebounds__c = mapRebote.get(cPadre.Id);
                        toUpdate.add(cPadre);
                    }
                    /* antes de 25/09:
for (Id idpadre: parentId_set) {
Case temp = new Case(Id = idpadre, R2_CAS_NUM_Number_of_rebounds__c = mapRebote.get(idpadre));
toUpdate.add(temp);
}
*/
                    if (!toUpdate.isEmpty()){
                        System.debug('CuentaCasosUpdate- toUPDATE::::::' + toUpdate);
                        update toUpdate;
                    }
                }
            }


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.CuentaCasosUpdate()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

/*------------------------------------------------------------------------------------------------------------------------------------------------------
      Author:        Jaime Ascanta
      Company:       Accenture
Description:

History:
<Date>                        <Author>                       <Change Description>
03/10/2017                    Jaime Ascanta                  Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void asignaAccountToCaseRTIberiaCom(List<Case> casos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            //Case caseNew = casos[0];
            system.debug('---> asignaAccountToCaseRTIberiaCom ' + casos[0]);
            boolean crear = false;
            List<Group> lstColas = new List<Group>();
            lstColas = [SELECT id,Name from Group where Type='Queue' and Name = 'GDPR'];
            if(!lstColas.isEmpty()){
                List<RecordType> lstRT = new List<RecordType>();
                lstRT = [SELECT id,Name from RecordType where Name = 'GDPR'];
                if(!lstRT.isEmpty()){
                        if(casos[0].RecordTypeId == lstRT[0].id){
                            casos[0].OwnerId = lstColas[0].id;
                        }
                    }
            }
            if(casos[0].R2_CAS_TXT_Customer_Golden_Record__c != null && casos[0].R2_CAS_TXT_Customer_Golden_Record__c !=''){
                List<Account> lstAcc = new List<Account>();
                lstAcc = [SELECT Id FROM Account where R1_ACC_TXT_Id_Golden_record__c = :casos[0].R2_CAS_TXT_Customer_Golden_Record__c];
                if(lstAcc.isEmpty()){
                    crear = true;
                }
                else{
                casos[0].AccountId = lstAcc[0].Id;
                }
            }
            //List<Case> cas = [SELECT  id, Origin, R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c, R2_CAS_TXT_Identification_number__c, R2_CAS_PKL_Type_document__c FROM Case WHERE id =: casos[0].id];
            //system.debug('--> cas ' + cas);
            if(/*casos[0].Origin.equals('Web') && Comentado por Sara Torres el dia 27/11/2017 por error en FULL*/
                casos[0].Origin == 'Web' &&
                ( casos[0].R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c != null ||
                 (casos[0].R2_CAS_TXT_Identification_number__c != null && casos[0].R2_CAS_PKL_Type_document__c != null )  )  && ((casos[0].R2_CAS_TXT_Customer_Golden_Record__c =='' || casos[0].R2_CAS_TXT_Customer_Golden_Record__c ==null) || crear == true) ){

                     List<Account> lstAcc = [SELECT Id
                                             FROM Account
                                             WHERE
                                             (R1_ACC_TXT_Primary_FF_Card_CCPO__c != null
                                              AND R1_ACC_TXT_Primary_FF_Card_CCPO__c =:casos[0].R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c
                                              AND R1_ACC_CHK_Duplicate__c=false
                                              AND R1_ACC_CHK_Unsubscribe__c = false
                                             )
                                             OR (R1_ACC_TXT_Identification_number__c != null
                                                 /*AND R1_ACC_PKL_identification_Type__c != null*/
                                                 AND R1_ACC_TXT_Identification_number__c = :casos[0].R2_CAS_TXT_Identification_number__c
                                                 /*AND R1_ACC_PKL_identification_Type__c = :casos[0].R2_CAS_PKL_Type_document__c*/
                                                 AND R1_ACC_CHK_Duplicate__c=false
                                                 AND R1_ACC_CHK_Unsubscribe__c = false) LIMIT 1];

                     if(!lstAcc.isEmpty()){
                         casos[0].AccountId = lstAcc[0].Id;
                         System.debug('caso asignado a cuenta'+ lstAcc[0]);
                     }else{
                         Account acc = new Account();
                         acc.FirstName = casos[0].R2_CAS_TXT_PASS_Name_Passenger__c;
                         acc.LastName = casos[0].R2_CAS_TXT_PASS_LastName_Passenger__c;
                         acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = casos[0].R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c;
                         acc.R1_ACC_PKL_identification_Type__c = casos[0].R2_CAS_PKL_Type_document__c;
                         acc.R1_ACC_TXT_Identification_number__c = casos[0].R2_CAS_TXT_Identification_number__c;
                         if(casos[0].R2_CAS_TXT_Customer_Golden_Record__c != '' && casos[0].R2_CAS_TXT_Customer_Golden_Record__c != null){
                         acc.R1_ACC_TXT_Id_Golden_record__c = casos[0].R2_CAS_TXT_Customer_Golden_Record__c;
                         }
                         insert acc;
                         System.debug('cuenta creada: ' + acc);

                         casos[0].AccountId = acc.id;

                         System.debug('cuanta asignada a caso: ' + casos[0]);

                     }

                 }else{
                     System.debug('no es recorType=iberia.com, el nuevo caso no contine ninguno de los datos necesarios (R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c OR (R2_CAS_PKL_Type_document__c AND R2_CAS_TXT_Identification_number__c))  ');
                 }
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignaAccountToCaseRTIberiaCom()', '', e.getmessage()+', '+e.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:


History:

<Date>                        <Author>                       <Change Description>
21/08/2017                  Sara Torres Bermúdez              Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void rellenarCampoDescripcion(List<Case> lstCasosNew, List<Case> lstCasosOld){

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Boolean wkfActivo = false;

            if (!lstCasosNew.isEmpty() && !lstCasosOld.isEmpty()){
                for(Integer i = 0; i < lstCasosNew.size(); i++){
                    if (lstCasosNew[i].R2_CAS_CHK_Comprobar_cliente__c != lstCasosOld[i].R2_CAS_CHK_Comprobar_cliente__c ){
                        wkfActivo = True;
                    }
                }
            }
            if (wkfActivo){
                Set<Id> set_clientesCaso = new Set<Id>();
                Set<Id> set_vueloCaso = new Set<Id>();
                Set<Id> set_casosId = new Set<Id>();

                if (!lstCasosNew.isEmpty()){
                    for(Case caso : lstCasosNew){
                        set_clientesCaso.add(caso.AccountId);
                        set_vueloCaso.add(caso.R1_CAS_LOO_Flight__c);
                        set_casosId.add(caso.Id);
                    }

                }
                List<R2_CKI_info__c> lstPasajeros = [SELECT id, R2_CKI_NUM_Distance__c, R2_CKI_NUM_Delay_time__c, R2_CKI_PKL_Client_type__c, R2_CKI_PKL_Resident__c,
                                                     R2_CKI_PKL_Class_flown__c, R2_CKI_TXT_Client_value__c, R2_CKI_TXT_Frustration_value__c, R2_CKI_NUM_Incident_code__c,
                                                     R2_CKI_NUM_Advance_notice_time__c, R2_CKI_TXT_Operative_company__c, R2_CKI_CHK_Connection_lost__c,
                                                     R2_CKI_TXT_Airport_depart__c, R2_CKI_TXT_Airport_arrive__c, R2_CKI_CHK_Do_not_automate_fllag__c, R2_CKI_DIV_Compensation__c,
                                                     R2_CKI_NUM_Compensation_in_Avios__c
                                                     FROM R2_CKI_info__c
                                                     WHERE R2_CKI_LOO_Account__c IN :set_clientesCaso
                                                     AND R2_CKI_LOO_Flight__c IN :set_vueloCaso
                                                     AND R2_CKI_LOO_Flight__c != null
                                                     AND R2_CKI_LOO_Account__c != null LIMIT 1];

                if (!lstPasajeros.isEmpty() && !lstCasosNew.isEmpty()){
                    for(Case caso : lstCasosNew){
                        for (R2_CKI_info__c pasa: lstPasajeros){
                            if (caso.R1_CAS_ATXTL_Automation_variables__c != null || caso.R1_CAS_ATXTL_Automation_variables__c != ''){
                                caso.R1_CAS_ATXTL_Automation_variables__c =
                                    ' Distancia: '                        + pasa.R2_CKI_NUM_Distance__c            + ' Tiempo retraso (min): '    + pasa.R2_CKI_NUM_Delay_time__c            +
                                    ' \n Tipo de cliente VIP/ NO VIP: '   + pasa.R2_CKI_PKL_Client_type__c         + ' Residente: '               + pasa.R2_CKI_PKL_Resident__c              +
                                    ' \n Clase Volada Business/ Standard' + pasa.R2_CKI_PKL_Class_flown__c         + ' Valor Cliente (ICAR): '    + pasa.R2_CKI_TXT_Client_value__c          +
                                    ' \n Valor Frustración (ICAR): '      + pasa.R2_CKI_TXT_Frustration_value__c   + ' Código de Incidencia: '    + pasa.R2_CKI_NUM_Incident_code__c         +
                                    ' \n Tiempo antelación de aviso: '    + pasa.R2_CKI_NUM_Advance_notice_time__c + ' Compañía operadora: '      + pasa.R2_CKI_TXT_Operative_company__c     +
                                    ' \n Pérdida de conexión: '           + pasa.R2_CKI_CHK_Connection_lost__c     + ' Aeropuerto de origen: '    + pasa.R2_CKI_TXT_Airport_depart__c        +
                                    ' \n Aeropuerto de Llegada: '         + pasa.R2_CKI_TXT_Airport_arrive__c      + ' No automatizar flag: '     + pasa.R2_CKI_CHK_Do_not_automate_fllag__c +
                                    ' \n Indemnización: '                 + pasa.R2_CKI_DIV_Compensation__c        + ' Compensación en Avios: '   + pasa.R2_CKI_NUM_Compensation_in_Avios__c ;
                            }
                        }
                    }
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.rellenarCampoDescripcion()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }

    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:  Metodo para cambiar de estado al hijo cuando el padre tiene estado: "cerrado", "cancelado", o "cerrado pendiente de pago"


History:

<Date>                        <Author>                       <Change Description>
05/09/2017                  Sara Torres Bermúdez              Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    /* public static void cambiarEstadoAlHijo(List<Case> casos){
try{
if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

Id rtIdExp = MAP_RT_NAME.get('Expediente');

Set<Id> set_padres = new Set<Id>();

if (!casos.isEmpty()){
for (Case cas:casos){
if ((cas.recordTypeId == rtIdExp) && ((cas.Status == 'Cancelado') || (cas.Status == 'Cerrado') || (cas.Status == 'Cerrado Pendiente de Pago'))){
set_padres.add(cas.Id);
}
}
}

List<Case> lstHijos = [SELECT Id, Status ,parentID FROM Case WHERE parentID IN :set_padres];

if (!lstHijos.isEmpty()){
for(Case hijos:lstHijos){
if (hijos.Status != 'Cerrado'){
hijos.Status = 'Cerrado';
}
}
}
update(lstHijos);
}catch(Exception exc){
R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.cambiarEstadoAlHijo()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
}
}
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:   Metodo que cuando el caso padre sea web el hijo tenga el estado = abierto


History:

<Date>                        <Author>                       <Change Description>
05/09/2017                  Sara Torres Bermúdez              Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    /* public static void estadoHijoCuandoPadreEsWeb(List<Case> casos){
try{
if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

Id rtIdExp = MAP_RT_NAME.get('Expediente');

Set<Id> set_padres = new Set<Id>();

if (!casos.isEmpty()){
for (Case cas:casos){
if ((cas.recordTypeId == rtIdExp) && (cas.Origin == 'Web')){
set_padres.add(cas.Id);
}
}
system.debug('set_padres: ' + set_padres);
}
List<Case> lstHijos = [SELECT Id, Status ,parentID FROM Case WHERE parentID IN :set_padres];
if (!lstHijos.isEmpty()){
for(Case hijos:lstHijos){
if(hijos.Status != 'Abierto'){
hijos.Status = 'Abierto';
}
}
}
update(lstHijos);
}catch(Exception exc){
R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.estadoHijoCuandoPadreEsWeb()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
}
}*/

    /***********************/

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Sara Torres Bermúdez
Company:       Accenture
Description:


History:

<Date>                        <Author>                       <Change Description>
05/09/2017                  Sara Torres Bermúdez              Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static void cambiosEnElStatus(List<Case> casos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            Id rtIdPro = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();

            Set<Id> set_padres = new Set<Id>();

            if (!casos.isEmpty()){
                for (Case cas:casos){
                    if (cas.recordTypeId == rtIdExp || cas.recordTypeId == rtIdPro){
                        if((cas.Status == 'Cancelado') || (cas.Status == 'Cerrado') || (cas.Status == 'Cerrado Pendiente de Pago') || (cas.Status == 'Abierto a la espera de info de Iberia' ) || (cas.Status == 'Abierto a la espera de la info del cliente')){
                            set_padres.add(cas.Id);
                        }
                    }
                }
            }
            List<Case> lstHijos = [SELECT Id, Status ,parentID FROM Case WHERE parentID IN :set_padres];

            if (!lstHijos.isEmpty()){
                for(Case hijos:lstHijos){
                    if (hijos.Status != 'Cerrado'){
                        hijos.Status = 'Cerrado';
                    }
                }
            }
            update(lstHijos);
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.cambiosEnElStatus()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Alberto Puerto Collado
Company:       Accenture
Description:   update case.type picklist field when a case is inserted, from Case.R2_CAS_PKL_Type1__c value



History:

<Date>                        <Author>                       <Change Description>
22/09/2017                Alberto Puerto Collado                Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void actualizaType_fromType1(List<Case> casos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            if(!casos.isEmpty()){
                for(Case caso:casos){
                    //System.debug('method CASE.TYPE previous - ' + caso.Type);
                    //System.debug('method CASE.R2_CAS_PKL_Type1__c previous - ' + caso.R2_CAS_PKL_Type1__c);
                    if(caso.Type == null && caso.R2_CAS_PKL_Type1__c != null){
                        caso.Type = caso.R2_CAS_PKL_Type1__c;
                        //  System.debug('method CASE.TYPE after - ' + caso.Type);
                    }
                }
            }
            //update casos; //nada, es before insert


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.actualizaType_fromType1()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Jaime Ascanta
    Company:       Accenture
    Description:   Traduce el tipo y subtipo para casos proactivos de iberia conecta, los valores se extraen de un Custom Setting.



    History:

    <Date>                        <Author>                       <Change Description>
    16/04/2018                  Jaime Ascanta                      Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void typeAndSubtypeIberiaConect(List<Case> casos){
        try{
            //System.debug('*** init subtypesIberiaConect() ');
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

            Map<String, R2_CS_TypesIberiaConect__c> mapTypes = R2_CS_TypesIberiaConect__c.getAll();
            Map<String, R2_CS_SubtypesIberiaConect__c> mapSubtypes = R2_CS_SubtypesIberiaConect__c.getAll();

           //System.debug('*** mapSubtypes: ' + mapSubtypes);

            for(Case caso:casos){
                if(caso.RecordTypeId==rtIdExp && caso.R2_CAS_CHK_Is_Proactive__c==true){
                    String typeKey = caso.R2_CAS_PKL_Type1__c;

                    if(mapTypes.containsKey(typeKey)){
                        R2_CS_TypesIberiaConect__c typeCsObj = mapTypes.get(typeKey);
                        caso.R2_CAS_PKL_Type1__c = String.valueOf(typeCsObj.R2_TXT_Label__c);

                        String typeSubtypeKey = typeKey+'-'+caso.R1_CAS_PKL_Subtype__c;
                        if(mapSubtypes.containsKey(typeSubtypeKey)){
                            R2_CS_SubtypesIberiaConect__c subtypeCsObj = mapSubtypes.get(typeSubtypeKey);
                            caso.R1_CAS_PKL_Subtype__c = String.valueOf(subtypeCsObj.R2_TXT_Label__c);
                        }
                    }
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.typeAndSubtypeIberiaConect()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Jorge Ordás Matas
Company:       Accenture
Description:   si el proceso de aprobación finaizó actuamos en consecuencia



History:

<Date>                        <Author>                       <Change Description>
26/10/2017                Jorge Ordás Matas                 Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void gestionaAprobacion(List<Case> lstNew, List<Case> lstOld){
        try{
            //obtenemos la lista de tipos de registro de caso
            Id casoRT = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            /*List<RecordType> rtl = [select id, name from recordtype where sobjecttype='Case' and name='Expediente'];
if(rtl.size()>0){
casoRT = rtl.get(0).Id;
}*/
            Map<Id,R2_Payment_order__c> mapaId = new Map<Id,R2_Payment_order__c>(); //mapa para obtener la paridad OP-Expediente
            List<Id> lid = new List<id>();
            for(Case caso: lstNew){
                lid.add(caso.Id);
            }
            //recuperamos la lista de ordenes de pago asociados a estos expediente
            List<R2_Payment_order__c> polUpd = new List<R2_Payment_order__c>();
            List<R2_Payment_order__c> polDel = new List<R2_Payment_order__c>();
            List<R2_Payment_order__c> pol = [Select id, R2_OPY_LOO_File_associated__c, R2_OPY_PCK_Status__c, R2_OPY_PKL_PaymentType__c from R2_Payment_order__c where R2_OPY_LOO_File_associated__c IN :lid];
            for(R2_Payment_order__c po:pol){
                if(mapaId.containsKey(po.R2_OPY_LOO_File_associated__c)){
                    mapaId.put(po.R2_OPY_LOO_File_associated__c, po);
                }
            }


            Integer contador = 0;
            //recorremos los casos que llegan comprobado si lo que ha cambiado ha sido el campo de la aprobación
            for(Case c:lstNew){
                if(c.RecordTypeId == casoRT){
                    if(c.R2_CAS_PKL_Approval__c == 'Aprobado' && lstOld.get(contador).R2_CAS_PKL_Approval__c  != 'Aprobado' ){
                        c.R2_CAS_PKL_Approval__c  = '';
                        //ponemos la orden de pago a ready
                        R2_Payment_order__c poUpd = mapaId.get(c.Id);
                        //actualizamos los campos
                        poUpd.R2_OPY_PCK_Status__c = 'Ready';
                        poUpd.R2_OPY_PKL_PaymentType__c = ''; //hay que calcularlo
                        polUpd.add(poUpd);

                    }
                    else if(c.R2_CAS_PKL_Approval__c == 'Rechazado' && lstOld.get(contador).R2_CAS_PKL_Approval__c  != 'Rechazado' ){
                        //borramos la orden de pago
                        R2_Payment_order__c poDel = mapaId.get(c.Id);
                        polDel.add(poDel);
                    }

                }
                contador++;
            }
            //actualizamos las ordenes de pago almacenadas en polUpd y polDel
            Database.DeleteResult[] drList = Database.delete(polDel, false);
            Database.SaveResult[] srList = Database.update(polUpd, false);

        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_CAS_TriggerMethods.asignaAccountToCaseRTIberiaCom()', '', e.getmessage()+', '+e.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Alvaro Garcia Tapia
Company:       Accenture
Description:   check if exist a claimant entity for the new claimant entity inserted/updated in the case



History:

<Date>                        <Author>                       <Change Description>
18/10/2017                Alvaro Garcia Tapia                Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void updateClaimantEntity(List<Case> lstNew, List<Case> lstOld){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            if(!lstNew.isEmpty()){

                Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
                Id rtIdInfo = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Informativo').getRecordTypeId();

                //take the cases that compliment the condition to create/update the claimEntity
                Set<Id> setIdCaso = new Set<Id>();
                for(Integer i = 0; i < lstNew.size(); i++){

                    if((rtIdExp == lstNew[i].RecordTypeId || rtIdInfo == lstNew[i].RecordTypeId) && lstOld == null && (lstNew[i].R2_CAS_LOO_Claimant_Entity__c != null)) {
                        setIdCaso.add(lstNew[i].Id);
                    }
                    else if((rtIdExp == lstNew[i].RecordTypeId || rtIdInfo == lstNew[i].RecordTypeId) && lstOld != null && lstOld[i].R2_CAS_LOO_Claimant_Entity__c != lstNew[i].R2_CAS_LOO_Claimant_Entity__c && lstNew[i].R2_CAS_LOO_Claimant_Entity__c != null) {
                        setIdCaso.add(lstNew[i].Id);
                    }
                }

                System.debug('setIdCaso : ' + setIdCaso);
                List<R2_CLA_Claimant_Entity__c> lstClaimantEntity = new List<R2_CLA_Claimant_Entity__c>();

                if (!setIdCaso.isEmpty()) {
                    lstClaimantEntity = [SELECT Id, R2_CLA_LOO_Case__c, R2_CLA_LOO_Account__c FROM R2_CLA_Claimant_Entity__c WHERE R2_CLA_LOO_Case__c IN :setIdCaso];

                    Map<Id, Id> mapCaseSetId = new Map<Id, Id>();

                    Map<Id, Set<Id>> mapCaseSetIdClaim = new Map<Id, Set<Id>>();

                    //map with the case and its claimaintEntity
                    for (R2_CLA_Claimant_Entity__c claimaintEntity : lstClaimantEntity) {
                        mapCaseSetId.put(claimaintEntity.R2_CLA_LOO_Account__c, claimaintEntity.Id);

                        if (mapCaseSetIdClaim.containsKey(claimaintEntity.R2_CLA_LOO_Case__c)) {
                            Set<Id> setIdAccount = mapCaseSetIdClaim.get(claimaintEntity.R2_CLA_LOO_Case__c);
                            setIdAccount.add(claimaintEntity.R2_CLA_LOO_Account__c);
                            mapCaseSetIdClaim.put(claimaintEntity.R2_CLA_LOO_Case__c, setIdAccount);
                        }
                        else {
                            Set<Id> setIdAccount = new Set<Id>();
                            setIdAccount.add(claimaintEntity.R2_CLA_LOO_Account__c);
                            mapCaseSetIdClaim.put(claimaintEntity.R2_CLA_LOO_Case__c, setIdAccount);
                        }
                    }

                    //create a new claimaint if it does not exist already or update the one who already exist to change it last modify date
                    List<R2_CLA_Claimant_Entity__c> lstInsertClaim = new List<R2_CLA_Claimant_Entity__c>();
                    List<R2_CLA_Claimant_Entity__c> lstUpdateClaim = new List<R2_CLA_Claimant_Entity__c>();
                    for (Case newCase : lstNew) {
                        Set<Id> setIdEntity = new Set<Id>();
                        if (mapCaseSetIdClaim.containsKey(newCase.Id) && mapCaseSetIdClaim.get(newCase.Id).contains(newCase.R2_CAS_LOO_Claimant_Entity__c)) {
                            R2_CLA_Claimant_Entity__c claimEnt = new R2_CLA_Claimant_Entity__c();
                            claimEnt.Id = mapCaseSetId.get(newCase.R2_CAS_LOO_Claimant_Entity__c);
                            lstUpdateClaim.add(claimEnt);
                        }
                        else {
                            R2_CLA_Claimant_Entity__c claimEnt = new R2_CLA_Claimant_Entity__c();
                            claimEnt.R2_CLA_LOO_Case__c = newCase.Id;
                            claimEnt.R2_CLA_LOO_Account__c = newCase.R2_CAS_LOO_Claimant_Entity__c;
                            lstInsertClaim.add(claimEnt);
                        }
                    }

                    System.debug('lstUpdateClaim : ' + lstUpdateClaim);
                    System.debug('lstInsertClaim : ' + lstInsertClaim);
                    if (!lstUpdateClaim.isEmpty()) {
                        update lstUpdateClaim;
                    }

                    if (!lstInsertClaim.isEmpty()) {
                        insert lstInsertClaim;
                    }
                }
            }


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.updateClaimantEntity()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:
    Company:       Accenture
    Description:



    History:

    <Date>                        <Author>                       <Change Description>
    18/10/2017                                                      Initial Version
    12/04/2018                                                      refactorizado el codigo para eviar todos los en bloque.
    16/04/2018                                                      refactorizado el codigo para eviar solo a casos de tipo expediente.
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static void enviarASitel(List<Case> casos){
        try{
        System.debug('Entro en enviar');
        // email a enviar
        Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

        List<Case> listCasToSendEmail = new List<Case>();
        for(Case cas : casos){
            if(cas.RecordTypeId == rtIdExp){
                listCasToSendEmail.add(cas);
            }
        }

        if(!listCasToSendEmail.isEmpty()){

            List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();

            Map<String,Case> mapCasos = new Map<String,Case>();
            List<R2_CS_Sytel_Queues__c> lstColas = [SELECT Name,R2_Queue_TXT_Mail__c,R2_Queue_TXT_Type__c from R2_CS_Sytel_Queues__c];
            Map<String,String> mapMailGen = new Map<String,String>();
            Map<String,String>mapMailJur = new Map<String,String>();
            Map<String,String>mapMailC2C = new Map<String,String>();
            List<String> lstNombresGen = new List<String>();
            List<String> lstNombresJur = new List<String>();
            List<String> lstNombresC2C = new List<String>();
            List<String> lstIdCasos = new List<String>();
            List<Case> lstCasosGenericos = new List<Case>();
            List<Case> lstCasosJuridicos = new List<Case>();
            List<Case> lstCasosC2C = new List<Case>();
            Map<String,Group> mapColaJuridica = new Map<String,Group>();
            Map<String,Group> mapColaGenerica = new Map<String,Group>();
            Map<String,Group> mapColaC2C = new Map<String,Group>();
            for(R2_CS_Sytel_Queues__c col : lstColas){
                if(col.R2_Queue_TXT_Type__c=='Genérica'){
                    lstNombresGen.add(col.Name);
                    mapMailGen.put(col.Name,col.R2_Queue_TXT_Mail__c);
                }
                if(col.R2_Queue_TXT_Type__c=='Jurídica'){
                    lstNombresJur.add(col.Name);
                    mapMailJur.put(col.Name,col.R2_Queue_TXT_Mail__c);
                }
                if(col.R2_Queue_TXT_Type__c =='Click2Call'){
                    lstNombresC2C.add(col.Name);
                    mapMailC2C.put(col.Name,col.R2_Queue_TXT_Mail__c);
                }
            }
            if(!lstNombresGen.isEmpty()){
            mapColaGenerica = new Map<String,Group> ([SELECT id,Name from Group where Type='Queue' and Name in :lstNombresGen]);
            }
            if(!lstNombresJur.isEmpty()){
            mapColaJuridica = new Map<String,Group>([SELECT id,Name from Group where Type='Queue' and Name in :lstNombresJur]);
            }
            if(!lstNombresC2C.isEmpty()){
            mapColaC2C = new Map<String,Group>([SELECT id,Name from Group where Type='Queue' and Name in :lstNombresC2C]);
            }

            for(Case caso  : listCasToSendEmail){
                if(mapColaGenerica.containsKey(caso.OwnerId)){
                    lstCasosGenericos.add(caso);
                }
                else if(mapColaJuridica.containsKey(caso.OwnerId)){
                    lstCasosJuridicos.add(caso);
                }
                else if(mapColaC2C.containsKey(caso.OwnerId)){
                    lstCasosC2C.add(caso);
                }
                else{}
            }
            if(!lstCasosGenericos.isEmpty()){
                for(Case caso : lstCasosGenericos){
                    Messaging.SingleEmailMessage message = makeMailGenerico(caso,mapMailGen.get(mapColaGenerica.get(caso.OwnerId).Name),mapColaGenerica.get(caso.OwnerId).Name);
                    if(message!=null){
                    emailMessages.add(message);
                    }
                }
            }
            if(!lstCasosJuridicos.isEmpty()){
                for(Case caso : lstCasosJuridicos){
                    Messaging.SingleEmailMessage message = makeMailJuridico(caso,mapMailJur.get(mapColaJuridica.get(caso.OwnerId).Name),mapColaJuridica.get(caso.OwnerId).Name);
                    if(message!=null){
                    emailMessages.add(message);
                    }
                }
            }
            if(!lstCasosC2C.isEmpty()){
                for(Case caso : lstCasosC2C){
                    Messaging.SingleEmailMessage message = makeMailC2C(caso,mapMailC2C.get(mapColaC2C.get(caso.OwnerId).Name),mapColaC2C.get(caso.OwnerId).Name);
                    if(message!=null){
                    emailMessages.add(message);
                    }
                }
            }

            if(!emailMessages.isEmpty()){
                Messaging.SendEmailResult[] results = Messaging.sendEmail(emailMessages, false);
                System.debug('Resultado de evio de emails:' + results);
            }
        }


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.enviarASitel()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    public static Messaging.SingleEmailMessage makeMailGenerico(Case caso,String mail,String cola){
        try{

        Map<String,String> mapIdiomas = new Map<String,String>();
        Schema.DescribeFieldResult field =Case.R1_CAS_PKL_Idioma__c.getDescribe();
        for (Schema.PicklistEntry f : field.getPicklistValues()){
            mapIdiomas.put(f.getValue(),f.getLabel());

        }

        Datetime fechaTCreacion= caso.CreatedDate;
        System.debug('Fecha: '+caso.CreatedDate);
        String dia=''+fechaTCreacion.day();
        String mes=''+fechaTCreacion.month();
        Datetime fechaTModificacion= caso.LastModifiedDate;
        String diaM=''+fechaTModificacion.day();
        String mesM=''+fechaTModificacion.month();
        Date fechaVuelo= caso.R2_CAS_FOR_Flight_date_local__c;
        System.debug(caso.R2_CAS_FOR_Flight_date_local__c);
        String diaV='';
        String mesV='';
        String year = '';
        if(fechaVuelo != null){
        diaV=''+fechaVuelo.day();
        mesV=''+fechaVuelo.month();
        year = ''+fechaVuelo.year();
        if(dia.length()<2){
            dia='0'+dia;
        }
        if(mes.length()<2){
            mes='0'+mes;
        }
        if(diaM.length()<2){
            diaM='0'+diaM;
        }
        if(mesM.length()<2){
            mesM='0'+mesM;
        }
        if(diaV.length()<2){
            diaV='0'+diaV;
        }
        if(mesV.length()<2){
            mesV='0'+mesV;
        }
        }
        wrpMailGenerico wrp = new wrpMailGenerico();
        wrp.Cola=cola;
        wrp.Idioma=mapIdiomas.get(caso.R1_CAS_PKL_Idioma__c);
        if(wrp.Idioma == null){
            wrp.Idioma = '';
        }
        wrp.Categoria=caso.R2_CAS_PKL_Vip_Type__c;
        if(wrp.Categoria == null){
            wrp.Categoria = '';
        }
        wrp.FechaCreacion=fechaTCreacion.year()+'-'+mes+'-'+dia;
       if(wrp.FechaCreacion == null){
            wrp.FechaCreacion = '';
        }
        wrp.FechaModificacion=fechaTModificacion.year()+'-'+mesM+'-'+diaM;
        if(wrp.FechaModificacion == null || wrp.FechaModificacion == '--'){
            wrp.FechaModificacion = '';
        }
        wrp.NivelTarjeta=caso.R1_CAS_FOR_Card_Type__c;
        if(wrp.NivelTarjeta == null){
            wrp.NivelTarjeta = '';
        }
        wrp.FechaVuelo=year+'-'+mesv+'-'+diaV;
        if(wrp.FechaVuelo == null || wrp.FechaVuelo =='--'){
            wrp.FechaVuelo = '';
        }
        wrp.CaseId=caso.id;
        if(wrp.CaseId == null){
            wrp.CaseId = '';
        }
        wrp.CaseNumber=caso.R2_CAS_TXT_Case_Number__c;
        if(wrp.CaseNumber == null){
            wrp.CaseNumber = '';
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = new String[] {mail};
        message.optOutPolicy = 'FILTER';
        message.subject = 'Prueba EmailSend';
        message.plainTextBody = JSON.serialize(wrp);

        return message;

    }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.makeMailGenerico()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }

    public static Messaging.SingleEmailMessage makeMailJuridico(Case caso,String mail,String cola){
        try{

        Map<String,String> mapIdiomas = new Map<String,String>();
        Schema.DescribeFieldResult field =Case.R1_CAS_PKL_Idioma__c.getDescribe();
        for (Schema.PicklistEntry f : field.getPicklistValues()){
            mapIdiomas.put(f.getValue(),f.getLabel());

        }

        Datetime fechaTCreacion= caso.CreatedDate;
        String dia=''+fechaTCreacion.day();
        String mes=''+fechaTCreacion.month();
        Datetime fechaTModificacion= caso.LastModifiedDate;
        String diaM=''+fechaTModificacion.day();
        String mesM=''+fechaTModificacion.month();
        if(dia.length()<2){
            dia='0'+dia;
        }
        if(mes.length()<2){
            mes='0'+mes;
        }
        if(diaM.length()<2){
            diaM='0'+diaM;
        }
        if(mesM.length()<2){
            mesM='0'+mesM;
        }
        wrpMailJuridico wrp = new wrpMailJuridico();
        wrp.Cola=cola;
        wrp.Idioma=mapIdiomas.get(caso.R1_CAS_PKL_Idioma__c);
        if(wrp.Idioma == null){
            wrp.Idioma = '';
        }
        wrp.Categoria=caso.R2_CAS_PKL_Vip_Type__c;
        if(wrp.Categoria == null){
            wrp.Categoria = '';
        }
        wrp.FechaCreacion=fechaTCreacion.year()+'-'+mes+'-'+dia;
        if(wrp.FechaCreacion == null){
            wrp.FechaCreacion = '';
        }
        wrp.FechaModificacion=fechaTModificacion.year()+'-'+mesM+'-'+diaM;
        if(wrp.FechaModificacion == null){
            wrp.FechaModificacion = '';
        }
        //wrp.PaisJuzgado = '';
        //wrp.FechaLimiteTipo = null;
        //wrp.FechaLimiteJuridico = null;
        wrp.CaseId=caso.id;
        wrp.CaseNumber=caso.R2_CAS_TXT_Case_Number__c;
        if(wrp.CaseNumber == null){
            wrp.CaseNumber = '';
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = new String[] { mail};
        message.optOutPolicy = 'FILTER';
        message.subject = 'Prueba EmailSend';
        message.plainTextBody = JSON.serialize(wrp);

        return message;

    }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.makeMailJuridico()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }

    public static Messaging.SingleEmailMessage makeMailC2C(Case caso,String mail,String cola){
      try{

       Map<String,String> mapIdiomas = new Map<String,String>();
       Schema.DescribeFieldResult field =Case.R1_CAS_PKL_Idioma__c.getDescribe();
       for (Schema.PicklistEntry f : field.getPicklistValues()){
           mapIdiomas.put(f.getValue(),f.getLabel());

       }

       wrpMailC2C wrp = new wrpMailC2C();
       wrp.Cola=cola;
       wrp.Idioma=mapIdiomas.get(caso.R1_CAS_PKL_Idioma__c);
       if(wrp.Idioma == null){
           wrp.Idioma = '';
       }
       wrp.PNR=caso.R1_CAS_TXT_PNR__c;
       if(wrp.PNR == null){
           wrp.PNR = '';
       }
       wrp.Mercado= caso.R1_CAS_TXT_Market__c;
      if(wrp.Mercado == null){
           wrp.Mercado = '';
       }
       wrp.Nombre=caso.R2_CAS_TXT_Name__c;
       if(wrp.Nombre == null){
           wrp.Nombre = '';
       }
       wrp.Canal=caso.R1_CAS_FOR_Card_Type__c;
       if(wrp.Canal == null){
           wrp.Canal = '';
       }
       wrp.TelefonoContacto=caso.R2_CAS_TEL_contact_phone__c;
       if(wrp.TelefonoContacto == null){
           wrp.TelefonoContacto = '';
       }
       wrp.CaseId=caso.id;
       if(wrp.CaseId == null){
           wrp.CaseId = '';
       }
       wrp.CaseNumber=caso.R2_CAS_TXT_Case_Number__c;
       if(wrp.CaseNumber == null){
           wrp.CaseNumber = '';
       }
       Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       // Set recipients to two contact IDs.
       // Replace IDs with valid record IDs in your org.
       message.toAddresses = new String[] {mail};
       message.optOutPolicy = 'FILTER';
       message.subject = 'Prueba EmailSend';
       message.plainTextBody = JSON.serialize(wrp);
       System.debug(message);
       System.debug(JSON.serialize(wrp));

       return message;

   }catch(Exception exc){
           R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.makeMailC2C()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
           return null;
       }
   }

    public static List<Case> filtrarCasosActualizadosSitel(List<Case> antiguo, List<Case> nuevo){
        try{
        List<Case> lstCasos= new List<Case>();
        for(integer i=0;i<antiguo.size();i++){
            if(antiguo[i].OwnerId != nuevo[i].OwnerId){
                    lstCasos.add(nuevo[i]);
                }
        }

        return lstCasos;
    }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.filtrarCasosActualizadosSitel()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }
    public static void rellenarIdentificador(List<Case> casos){
        List<String> lstRT = new List<String>();
        List<String> lstIdCaso = new List<String>();
        for(Case caso : casos){
            lstRT.add(caso.RecordTypeId);
            lstIdCaso.add(caso.id);
        }
        Map<String,RecordType> mapRT = new Map<String,RecordType>([SELECT id, Name from RecordType where id IN :lstRT]);
        List<R2_CS_Case_RT_Identifier__c> lstIdentificadoresRT = [SELECT id, Name,R2_RTCase_TXT_Identifier__c,R2_RTCase_TXT_CSIdentifier__c,R2_RTCase_TXT_RTName__c,R2_RTCase_TXT_Type__c FROM R2_CS_Case_RT_Identifier__c];
        Map<String,R2_CS_Case_RT_Identifier__c> mapIdentificadoresRT = new Map<String,R2_CS_Case_RT_Identifier__c>();
        for(R2_CS_Case_RT_Identifier__c ident : lstIdentificadoresRT){
            mapIdentificadoresRT.put(ident.R2_RTCase_TXT_CSIdentifier__c,ident);

        }
        List<Case> lstCasosUpdate = [Select id,CaseNumber,RecordTypeId,Type from Case where id in :lstIdCaso];
        for(Case caso : lstCasosUpdate){
            System.debug(caso.CaseNumber);
            if(mapRT.containsKey(caso.RecordTypeId)){
                if(mapIdentificadoresRT.containsKey(mapRT.get(caso.RecordTypeId).Name+';'+caso.Type)){
                    caso.R2_CAS_TXT_Case_Number__c = mapIdentificadoresRT.get(mapRT.get(caso.RecordTypeId).Name+';'+caso.Type).R2_RTCase_TXT_Identifier__c+caso.CaseNumber;
                }
                else if(mapIdentificadoresRT.containsKey(mapRT.get(caso.RecordTypeId).Name+';')){
                    System.debug(mapIdentificadoresRT.get(mapRT.get(caso.RecordTypeId).Name+';').R2_RTCase_TXT_Identifier__c);
                    String identificador = mapIdentificadoresRT.get(mapRT.get(caso.RecordTypeId).Name+';').R2_RTCase_TXT_Identifier__c;
                    if(identificador == null){
                        identificador = '';
                    }
                    caso.R2_CAS_TXT_Case_Number__c = identificador+caso.CaseNumber;
                }
            }
        }
        update lstCasosUpdate;
    }
    public static List<Case> filtrarCasosActualizadosIdentificador(List<Case> antiguo, List<Case> nuevo){
        try{
            List<Case> lstCasos= new List<Case>();
            for(integer i=0;i<antiguo.size();i++){
                if(antiguo[i].RecordTypeId != nuevo[i].RecordTypeId || antiguo[i].type != nuevo[i].type){
                    lstCasos.add(nuevo[i]);
                }
            }

            return lstCasos;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.filtrarCasosActualizadosIdentificador()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }
    public static void formatearCasoIBConecta (List<Case> lstCasos){
        try{
            Id recordTypePro = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();
            Id recordTypeExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            for(Case caso : lstCasos){
                if(caso.RecordTypeId == recordTypePro){
                    caso.recordTypeId = recordTypeExp;
                    caso.R2_CAS_CHK_Is_Proactive__c = true;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.formatearCasoIBConecta()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    public static void crearVoucherIBConecta(List<Case> lstCasos){
        try{
            Id rtPagoAvios = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();
            Id rtPagoComInd = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();
            Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();
            Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            Id idOwnerPro = [SELECT Id FROM Group WHERE DeveloperName='R2_Proactive' LIMIT 1].Id;

            List<R2_Voucher__c> listVouInsert = new List<R2_Voucher__c>();
            List<R2_Compensation__c> listCompInsert = new List<R2_Compensation__c>();
            List<Id> lstIdCasNotVou = new List<Id>();

            for(Case cas : lstCasos){

                if( cas.R2_CAS_CHK_Is_Proactive__c == true &&
                    cas.RecordTypeId==rtIdPasaj &&
                    cas.OwnerId == idOwnerPro &&
                    cas.R2_CAS_TXT_IBConnectID__c != null &&
                    cas.R2_CAS_TXT_IBConnectID__c != ''){

                    if((cas.R2_CAS_NUM_MCO_Import__c == null || cas.R2_CAS_NUM_MCO_Import__c==0) &&
                        (cas.R2_CAS_DIV_Compensation_in_vouchers__c == null || cas.R2_CAS_DIV_Compensation_in_vouchers__c==0) &&
                        (cas.R1_CAS_NUM_Compensacion_en_Avios__c == null || cas.R1_CAS_NUM_Compensacion_en_Avios__c==0 ) ){

                            lstIdCasNotVou.add(cas.Id);

                    }else{
                        String formOfPayment = cas.R2_CAS_TXT_Payment_Way__c!=null ? String.valueOf(cas.R2_CAS_TXT_Payment_Way__c).toLowerCase() : '';

                        if( ( (cas.R2_CAS_DIV_Compensation_in_vouchers__c != null && cas.R2_CAS_DIV_Compensation_in_vouchers__c>0) ||
                              (cas.R2_CAS_NUM_MCO_Import__c != null && cas.R2_CAS_NUM_MCO_Import__c>0) ) &&
                            formOfPayment == 'dnb' ){

                            R2_Voucher__c vou = new R2_Voucher__c();
                            vou.R2_VOU_LOO_Case__c = cas.Id;
                            vou.RecordTypeId = recordTypeDNB;
                            vou.R2_VOU_LOO_Client__c = cas.AccountId;
                            vou.R2_VOU_LOO_Flight__c = cas.R1_CAS_LOO_Flight__c;

                            vou.R2_VOU_TXT_IBConecta__c = cas.R2_CAS_TXT_IBConnectID__c;
                            // passengerLastName
                            vou.R2_VOU_TXT_Surname__c = cas.R2_CAS_TXT_LastName__c;
                            // passengerFirstName
                            vou.R2_VOU_TXT_Name__c = cas.R2_CAS_TXT_Name__c;

                            // flightCompanyCode
                            vou.R2_VOU_PKL_Marketing_Company__c = R1_CLS_Utilities.splitFlyNumber(cas.R1_CAS_TXT_Vuelo__c, 1);
                            // flightNumber
                            vou.R2_VOU_TXT_Main_Flight_Number__c = R1_CLS_Utilities.splitFlyNumber(cas.R1_CAS_TXT_Vuelo__c, 2);

                            // flightDate
                            vou.R2_VOU_DAT_Flight_Date__c = cas.R1_CAS_Fecha_vuelo__c;
                            // flightSegmentDate
                            vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c = cas.R1_CAS_Fecha_vuelo__c;
                            // reservedFlightClass
                            vou.R2_VOU_TXT_Res_Class__c = 'A';
                            // assignedFlightClass
                            vou.R2_VOU_TXT_Passenger_Flight_Class__c = 'A';
                            // flightOriginCountry
                            vou.R2_VOU_PKL_Country__c = 'ES';
                            // flightDestinationCountry
                            vou.R2_VOU_PKL_Arrival_Country__c = 'ES';
                            // flightOriginAirport
                            vou.R2_VOU_TXT_Origin__c = cas.R2_CAS_TXT_Flight_Origin__c;
                            // flightDestinationAirport
                            vou.R2_VOU_TXT_Arrival__c = cas.R2_CAS_TXT_Flight_Desnity__c;
                            // ffnumber
                            vou.R2_VOU_TXT_Passenger_FF__c = cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c;
                            // paymentCurrency
                            vou.R2_VOU_PKL_Currency_Claimed__c = cas.R2_CAS_TXT_Coin__c;
                            // reason
                            vou.R2_VOU_TXT_Passenger_Reason__c = 'DNB'; //cas.R2_CAS_TXT_MotiveCode__c;
                            // account
                            // vou.R2_VOU_TXT_Account__c = '';
                            // creationType
                            vou.R2_VOU_PKL_Creation_Type__c = 'Automatic';

                            // campos  IBConecta identificados
                            vou.R2_VOU_TXT_ProfileId__c = cas.R2_CAS_TXT_ProfileId__c;
                            vou.R2_VOU_TXT_Ticket_Num__c = cas.R2_CAS_TXT_TKT_Ticket__c;
                            //vou.R2_VOU_PKL_Type__c = '';
                            vou.R2_VOU_TXT_AmadeusLocator__c = cas.R2_CAS_TXT_Amadeus_Locator__c;
                            vou.R2_VOU_TXT_ResiberLocator__c = cas.R1_CAS_TXT_PNR__c;
                            vou.R2_VOU_PKL_Service__c =  cas.R2_CAS_PKL_Type1__c;
                            vou.R2_VOU_PKL_Status__c = cas.Status=='Abierto' ? 'A' : cas.Status;

                            // Amounts
                            if(cas.R2_CAS_NUM_MCO_Import__c != null && cas.R2_CAS_NUM_MCO_Import__c>0){
                                vou.R2_VOU_DIV_Amount_Value_MCO__c = cas.R2_CAS_NUM_MCO_Import__c;
                            }

                            if(cas.R2_CAS_DIV_Compensation_in_vouchers__c != null && cas.R2_CAS_DIV_Compensation_in_vouchers__c>0){
                                vou.R2_VOU_DIV_Amount_Value_Cash__c = cas.R2_CAS_DIV_Compensation_in_vouchers__c;
                            }

                            if(cas.R1_CAS_NUM_Compensacion_en_Avios__c != null && cas.R1_CAS_NUM_Compensacion_en_Avios__c>0){
                                vou.R2_VOU_DIV_Amount_value_Avios__c = cas.R1_CAS_NUM_Compensacion_en_Avios__c;
                            }

                            listVouInsert.add(vou);

                        }
                        else if((   (cas.R2_CAS_DIV_Compensation_in_vouchers__c != null && cas.R2_CAS_DIV_Compensation_in_vouchers__c>0) ||
                                    (cas.R1_CAS_NUM_Compensacion_en_Avios__c != null && cas.R1_CAS_NUM_Compensacion_en_Avios__c>0) ) &&
                                (formOfPayment == 'avios' || formOfPayment == 'bono ib.com' || formOfPayment == 'cheque' || formOfPayment == 'transferencia') ){

                            String aux_ff = cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c!=null ? cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c : '';
                            aux_ff = aux_ff.toUpperCase();
                            if(aux_ff.contains('IB')) aux_ff = aux_ff.remove('IB');

                            R2_Compensation__c pago = new R2_Compensation__c();
                            pago.R2_COM_LOO_Case__c = cas.id;
                            pago.R2_COM_LOO_Client__c = cas.AccountId;

                            if(formOfPayment == 'avios'){
                                pago.RecordTypeId = rtPagoAvios;
                            }else{
                                pago.RecordTypeId = rtPagoComInd;
                            }

                            if(cas.R1_CAS_NUM_Compensacion_en_Avios__c > 0){
                                pago.R2_COM_DIV_Total_Amount__c = cas.R1_CAS_NUM_Compensacion_en_Avios__c;
                            }else if(cas.R2_CAS_DIV_Compensation_in_vouchers__c > 0){
                                pago.R2_COM_DIV_Total_Amount__c = cas.R2_CAS_DIV_Compensation_in_vouchers__c;
                            }else if(cas.R2_CAS_NUM_MCO_Import__c > 0){
                                pago.R2_COM_DIV_Total_Amount__c = cas.R2_CAS_NUM_MCO_Import__c;
                            }

                            pago.R2_COM_TXT_Frecuent_Flyer__c = aux_ff!='' ? aux_ff : null;                           
                            pago.R2_COM_PKL_Payment_method__c = cas.R2_CAS_TXT_Payment_Way__c;
                            pago.R2_COM_TXT_Passenger_Reason__c = cas.R2_CAS_TXT_MotiveCode__c;
                            pago.R2_COM_PKL_Type__c = cas.R2_CAS_TXT_Compensation_Type__c;
                            pago.R2_COM_PKL_Currency_Claimed__c = cas.R2_CAS_TXT_Coin__c;

                            listCompInsert.add(pago);

                            lstIdCasNotVou.add(cas.Id);

                        }
                    }
                }
            }

            if(!lstIdCasNotVou.isEmpty()){
                System.debug('*** notificando sendDNBNotVoucher ');
                //R2_CLS_DNBNumberNotification.sendDNBNotVoucher(lstIdCasNotVou);
            }

            if(!listCompInsert.isEmpty()){
                try{
                    insert listCompInsert;
                    System.debug('*** Compensaciones insertadas: ' + listCompInsert);
                }catch (DmlException exc){
                    System.debug('*** error al insertar Compensaciones: ' + exc.getmessage() );
                }
            }

            if(!listVouInsert.isEmpty()){
                try{
                    insert listVouInsert;
                    System.debug('*** vouchers insertados: ' + listVouInsert);
                }catch (DmlException exc){
                    System.debug('*** error al insertar vouchers: ' + exc.getmessage() );
                }
            }


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.crearVoucherIBConecta()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:        Ulises Paniego
Company:       Accenture
Description:   Si se actualiza alguno de los dos segmentos a 'Vuelo Completo' se actualiza el mismo segmento en todos los casos de la misma campaña



History:

<Date>                        <Author>                       <Change Description>
04/12/2017                  Ulises Paniego                    vueloCompleUpdate
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static Boolean casosMismaCamp = false;

    public static void vueloCompleUpdate(List<Case> nuevos, Map<Id, Case> viejos){
      try{
        Id rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campañas salientes').getRecordTypeId();

        //campaignsUpdated se rellena con las campañas que contienen casos que s ehan actualizado
        Set<Id> campaignsUpdated = new Set<Id>();
        //Mapa <Id de la campaña, Mapa<Numero de segmento, List <vuelo, compañia>>> Guarda los datos que hay que comparar de cada caso perteneciente a esa campaña
        Map<Id, Map<Integer, List<String>>> map_idCamp_Segment_vuelo_company = new Map<Id, Map<Integer, List<String>>>();
        for (Case caso:nuevos) {
            if(caso.RecordTypeId == rtId){
                //se comprueba si se pone a 'Vuelo Completo' la segmentación 1 o la 2
                if (viejos.get(caso.Id).R2_CAS_PK_resul__c != caso.R2_CAS_PK_resul__c && caso.R2_CAS_PK_resul__c == 'Vuelo Completo') {
                    if (caso.R2_CAS_LOO_Campaigns__c != null) {
                        //si la campaña no está vacia se guarda el número de vuelo y la compañia del segmento correspondiente
                        List<String> aux_vuelo_company = new List<String>();
                        aux_vuelo_company.add(caso.R2_CAS_TXT_flight_number_segment1__c);
                        aux_vuelo_company.add(caso.R2_CAS_TXT_company_segment1__c);
                        Map<Integer, List<String>> aux_Segment_vuelo_company;
                        if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c) != null) {
                            aux_Segment_vuelo_company = map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c);
                            aux_Segment_vuelo_company.put(1, aux_vuelo_company);
                        } else {
                            aux_Segment_vuelo_company = new Map<Integer, List<String>>();
                            aux_Segment_vuelo_company.put(1, aux_vuelo_company);
                        }
                        map_idCamp_Segment_vuelo_company.put(caso.R2_CAS_LOO_Campaigns__c, aux_Segment_vuelo_company);

                        campaignsUpdated.add(caso.R2_CAS_LOO_Campaigns__c);
                    }
                }
                if (viejos.get(caso.Id).R2_CAS_PK_resul_Seg2__c != caso.R2_CAS_PK_resul_Seg2__c && caso.R2_CAS_PK_resul_Seg2__c == 'Vuelo Completo') {
                    if (caso.R2_CAS_LOO_Campaigns__c != null) {
                        List<String> aux_vuelo_company = new List<String>();
                        aux_vuelo_company.add(caso.R2_CAS_TXT_flight_number_segment2__c);
                        aux_vuelo_company.add(caso.R2_CAS_TXT_company_segment2__c);
                        Map<Integer, List<String>> aux_Segment_vuelo_company;
                        if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c) != null) {
                            aux_Segment_vuelo_company = map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c);
                            aux_Segment_vuelo_company.put(2, aux_vuelo_company);
                        } else {
                            aux_Segment_vuelo_company = new Map<Integer, List<String>>();
                            aux_Segment_vuelo_company.put(2, aux_vuelo_company);
                        }
                        map_idCamp_Segment_vuelo_company.put(caso.R2_CAS_LOO_Campaigns__c, aux_Segment_vuelo_company);

                        campaignsUpdated.add(caso.R2_CAS_LOO_Campaigns__c);
                    }
                }
            }
        }
        //casosCampaign = seleccion de los casos pertenecientes las campañas
        List<Case> casosCampaign = new List<Case>();
        if (!campaignsUpdated.isEmpty()) {
            casosCampaign = [SELECT Id, R2_CAS_LOO_Campaigns__c,
                             R2_CAS_CHK_Segment1__c, R2_CAS_TXT_flight_number_segment1__c, R2_CAS_TXT_company_segment1__c, R2_CAS_PK_answer__c, R2_CAS_PK_resul__c,
                             R2_CAS_CHK_Segment2__c, R2_CAS_TXT_flight_number_segment2__c, R2_CAS_TXT_company_segment2__c, R2_CAS_PK_answer_Seg2__c, R2_CAS_PK_resul_Seg2__c
                             FROM Case WHERE R2_CAS_LOO_Campaigns__c IN :campaignsUpdated AND Id NOT IN :viejos.keySet()];
            System.debug('vueloCompleUpdate, casosCampaign->'+casosCampaign);
        }

        List<Case> updateCasos = new List<Case>();
        //se evaluan los casos que han sido seleccionados para saber cuales hay que actualizar
        Map<Id, List<Case>> map_idCamp_cases = new Map<Id, List<Case>>();
        for (Case caso:casosCampaign) {
            Boolean actualizarCaso = false;
            if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c) != null) {
                //se comprueba si tiene que comparar el segmento 1
                if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(1) != null /*&& caso.R2_CAS_CHK_Segment1__c*/ ) {
                    //se comprueba si tienen el mismo número de vuelo y misma compañia de segmento 1
                    if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(1).get(0) == caso.R2_CAS_TXT_flight_number_segment1__c &&
                        map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(1).get(1) == caso.R2_CAS_TXT_company_segment1__c) {
                            //se actualiza el R2_CAS_PK_answer__c y R2_CAS_PK_resul__c el del segmento 1
                            if( (caso.R2_CAS_PK_answer__c==null || caso.R2_CAS_PK_answer__c =='') ){
                                    caso.R2_CAS_PK_answer__c = 'Inscrito';
                                    caso.R2_CAS_PK_resul__c = 'Vuelo Completo';
                                    actualizarCaso = true;
                            }
                        }
                }
            }
            if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c) != null) {
                //se comprueba si tiene que comparar el segmento 2
                if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(2) != null /*&& caso.R2_CAS_CHK_Segment2__c*/ ) {
                    //se comprueba si tienen el mismo número de vuelo y misma compañia de segmento 2
                    if (map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(2).get(0) == caso.R2_CAS_TXT_flight_number_segment2__c &&
                        map_idCamp_Segment_vuelo_company.get(caso.R2_CAS_LOO_Campaigns__c).get(2).get(1) == caso.R2_CAS_TXT_company_segment2__c) {
                            //se actualiza el R2_CAS_PK_answer_Seg2__c y el R2_CAS_PK_resul_Seg2__c del segmento 2
                            if(caso.R2_CAS_PK_answer_Seg2__c == null || caso.R2_CAS_PK_answer_Seg2__c == '' ){
                                    caso.R2_CAS_PK_answer_Seg2__c = 'Inscrito';
                                    caso.R2_CAS_PK_resul_Seg2__c = 'Vuelo Completo';
                                    actualizarCaso = true;
                            }
                        }
                }
            }
            if (actualizarCaso) {
                updateCasos.add(caso);
            }
        }
        if (!updateCasos.isEmpty()) {
            System.debug('vueloCompleUpdate, updating->'+updateCasos);
            casosMismaCamp = true;
            update updateCasos;
        }

      }catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.vueloCompleUpdate()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
      }
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Alejandro Turiégano
Company:        Accenture
Description:    Method to calculate especified fields from the case to the associated campaign

IN:
OUT:

History:
<Date>                     <Author>                     <Change Description>
05/11/2017                 Alejandro Turiégano          Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static void calculaCamposCampanaUPG(List<Case> lst_news){

        List<Id> lstCamp1 = new List<Id>();
        List<Campaign> lstCamp = new List<Campaign>();
        List<Campaign> lstCampUpdate = new List<Campaign>();
        Double totalUGPSAvios1 = 0;
        Double totalUGPSEuros1 = 0;
        Double totalAvios1 = 0;
        Double totalEuros1 = 0;
        Double totalUGPSAvios2 = 0;
        Double totalUGPSEuros2 = 0;
        Double totalAvios2 = 0;
        Double totalEuros2 = 0;
        Double totalUGPSAvios = 0;
        Double totalUGPSEuros = 0;
        Double totalAvios = 0;
        Double totalEuros = 0;

        try{
            Id rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campañas salientes').getRecordTypeId();

            //Comprobamos que haya casos en la lista
            if(!lst_news.isEmpty()){
                for(Case c : lst_news){
                    if(c.RecordTypeId == rtId){
                        //Filtramos los casos y si procede guardamos el ID de la campaña asociada
                        String tipoMayus = c.Type!=null ? c.Type : '';
                        tipoMayus = tipoMayus.toUpperCase();
                        if(tipoMayus.contains('UPG') && (c.R2_CAS_PK_answer__c == 'Inscrito' || c.R2_CAS_PK_answer_Seg2__c == 'Inscrito') &&
                        (c.R2_CAS_PK_resul__c == 'Transformado' || c.R2_CAS_PK_resul_Seg2__c == 'Transformado') &&
                        (String.valueOf(c.R2_CAS_LOO_Campaigns__c) != '' || c.R2_CAS_LOO_Campaigns__c != null)){
                            lstCamp1.add(c.R2_CAS_LOO_Campaigns__c);
                        }
                    }
                }

                //Comprobamos que haya campañas en la lista
                if(!lstCamp1.isEmpty()){
                    //Recorremos las campañas implicadas
                    lstCamp = [SELECT Id, R2_CAM_NUM_Total_number_total_upgs_avios__c, R2_CAM_NUM_Total_number_total_upgs_euros__c, R2_CAM_NUM_Total_number_Avios__c, R2_CAM_NUM_Total_number_euros__c,
                               (SELECT Id, R2_CAS_PK_answer__c, R2_CAS_PK_resul__c, R2_CAS_PK_answer_Seg2__c, R2_CAS_PK_resul_Seg2__c, R2_CAS_NUM_number_upgs__c, R2_CAS_NUM_number_upgs_euros__c,
                                R2_CAS_NUM_number_upgs_bus_euros_S1__c, R2_CAS_NUM_number_upgs_TP_euros_S1__c, R2_CAS_NUM_number_upgs_bus_euros_S2__c, R2_CAS_NUM_number_upgs_TP_euros_S2__c,
                                R2_CAS_NUM_number_upgs_bus_S1__c, R2_CAS_NUM_number_upgs_bus_S2__c, R2_CAS_NUM_number_upgs_TP_S1__c, R2_CAS_NUM_number_upgs_TP_S2__c, R2_CAS_NUM_cash_bus_other__c,
                                R2_CAS_NUM_cash_bus_seg1__c, R2_CAS_NUM_cash_TP_seg1__c, R2_CAS_NUM_cash_bus_seg2__c, R2_CAS_NUM_cash_TP_seg2__c, R2_CAS_NUM_avios_bus_others__c, R2_CAS_NUM_avios_bus_seg1__c,
                                R2_CAS_NUM_avios_TP_seg1__c, R2_CAS_NUM_avios_bus_seg2__c, R2_CAS_NUM_avios_TP_seg2__c FROM Cases__r)
                               FROM Campaign where Id =:lstCamp1];

                    //Comprobamos que hay campañas asociadas a los casos
                    if(!lstCamp.isEmpty()){
                        //Recorremos las campañas, rellenamos los campos, y añadimos a la lista que actualizaremos
                        for (Campaign cam : lstCamp){
                            totalUGPSAvios = 0;
                            totalUGPSEuros = 0;
                            totalAvios = 0;
                            totalEuros = 0;
                            for(Case cs : cam.Cases__r){
                                totalUGPSAvios1 = 0;
                                totalUGPSEuros1 = 0;
                                totalAvios1 = 0;
                                totalEuros1 = 0;
                                totalUGPSAvios2 = 0;
                                totalUGPSEuros2 = 0;
                                totalAvios2 = 0;
                                totalEuros2 = 0;

                                //Filtramos los casos por segmentación para recoger los valores de la segmentación o no
                                //Segmentacion 1
                                if(cs.R2_CAS_PK_answer__c == 'Inscrito' && cs.R2_CAS_PK_resul__c == 'Transformado'){
                                    totalUGPSAvios1 = (cs.R2_CAS_NUM_number_upgs_bus_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_S1__c) + (cs.R2_CAS_NUM_number_upgs_TP_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_S1__c) ;
                                    totalUGPSEuros1 = (cs.R2_CAS_NUM_number_upgs_bus_euros_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_euros_S1__c) + (cs.R2_CAS_NUM_number_upgs_TP_euros_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_euros_S1__c);
                                    //totalAvios1 = (cs.R2_CAS_NUM_avios_bus_seg1__c==null?0:cs.R2_CAS_NUM_avios_bus_seg1__c) + (cs.R2_CAS_NUM_avios_TP_seg1__c==null?0:cs.R2_CAS_NUM_avios_TP_seg1__c);
                                    //totalEuros1 = (cs.R2_CAS_NUM_cash_bus_seg1__c==null?0:cs.R2_CAS_NUM_cash_bus_seg1__c) + (cs.R2_CAS_NUM_cash_TP_seg1__c==null?0:cs.R2_CAS_NUM_cash_TP_seg1__c);
                                    totalAvios1 = ((cs.R2_CAS_NUM_number_upgs_bus_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_S1__c) * (cs.R2_CAS_NUM_avios_bus_seg1__c==null?0:cs.R2_CAS_NUM_avios_bus_seg1__c)) +
                                     ((cs.R2_CAS_NUM_number_upgs_TP_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_S1__c) * (cs.R2_CAS_NUM_avios_TP_seg1__c==null?0:cs.R2_CAS_NUM_avios_TP_seg1__c));
                                    totalEuros1 = ((cs.R2_CAS_NUM_number_upgs_bus_euros_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_euros_S1__c) * (cs.R2_CAS_NUM_cash_bus_seg1__c==null?0:cs.R2_CAS_NUM_cash_bus_seg1__c)) +
                                     ((cs.R2_CAS_NUM_number_upgs_TP_euros_S1__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_euros_S1__c) * (cs.R2_CAS_NUM_cash_TP_seg1__c==null?0:cs.R2_CAS_NUM_cash_TP_seg1__c))
                                     /*+ ((cs.R2_CAS_NUM_number_upgs_euros__c==null?0:cs.R2_CAS_NUM_number_upgs_euros__c) * (cs.R2_CAS_NUM_cash_bus_other__c==null?0:cs.R2_CAS_NUM_cash_bus_other__c))*/ ;
                                }

                                //Segmentacion 2
                                if(cs.R2_CAS_PK_answer_Seg2__c == 'Inscrito' && cs.R2_CAS_PK_resul_Seg2__c == 'Transformado'){
                                    totalUGPSAvios2 = (cs.R2_CAS_NUM_number_upgs_bus_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_S2__c) + (cs.R2_CAS_NUM_number_upgs_TP_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_S2__c);
                                    totalUGPSEuros2 = (cs.R2_CAS_NUM_number_upgs_bus_euros_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_euros_S2__c) + (cs.R2_CAS_NUM_number_upgs_TP_euros_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_euros_S2__c);
                                    //totalAvios2 = (cs.R2_CAS_NUM_avios_bus_seg2__c==null?0:cs.R2_CAS_NUM_avios_bus_seg2__c) + (cs.R2_CAS_NUM_avios_TP_seg2__c==null?0:cs.R2_CAS_NUM_avios_TP_seg2__c);
                                    //totalEuros2 = (cs.R2_CAS_NUM_cash_bus_seg2__c==null?0:cs.R2_CAS_NUM_cash_bus_seg2__c) + (cs.R2_CAS_NUM_cash_TP_seg2__c==null?0:cs.R2_CAS_NUM_cash_TP_seg2__c);
                                    totalAvios2 = ((cs.R2_CAS_NUM_number_upgs_bus_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_S2__c) * (cs.R2_CAS_NUM_avios_bus_seg2__c==null?0:cs.R2_CAS_NUM_avios_bus_seg2__c)) +
                                     ((cs.R2_CAS_NUM_number_upgs_TP_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_S2__c) * (cs.R2_CAS_NUM_avios_TP_seg2__c==null?0:cs.R2_CAS_NUM_avios_TP_seg2__c));
                                    totalEuros2 = ((cs.R2_CAS_NUM_number_upgs_bus_euros_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_bus_euros_S2__c) * (cs.R2_CAS_NUM_cash_bus_seg2__c==null?0:cs.R2_CAS_NUM_cash_bus_seg2__c)) +
                                     ((cs.R2_CAS_NUM_number_upgs_TP_euros_S2__c==null?0:cs.R2_CAS_NUM_number_upgs_TP_euros_S2__c) * (cs.R2_CAS_NUM_cash_TP_seg2__c==null?0:cs.R2_CAS_NUM_cash_TP_seg2__c));
                                }

                                //Sumatorio total de los campos
                                totalUGPSAvios += (cs.R2_CAS_NUM_number_upgs__c==null?0:cs.R2_CAS_NUM_number_upgs__c) + totalUGPSAvios1 + totalUGPSAvios2;
                                totalUGPSEuros +=  (cs.R2_CAS_NUM_number_upgs_euros__c==null?0:cs.R2_CAS_NUM_number_upgs_euros__c) + totalUGPSEuros1 + totalUGPSEuros2;
                                //totalAvios += (cs.R2_CAS_NUM_avios_bus_others__c==null?0:cs.R2_CAS_NUM_avios_bus_others__c) + totalAvios1 + totalAvios2;
                                //totalEuros += (cs.R2_CAS_NUM_cash_bus_other__c==null?0:cs.R2_CAS_NUM_cash_bus_other__c) + totalEuros1 + totalEuros2;
                                totalAvios += ((cs.R2_CAS_NUM_number_upgs__c==null?0:cs.R2_CAS_NUM_number_upgs__c) * (cs.R2_CAS_NUM_avios_bus_others__c==null?0:cs.R2_CAS_NUM_avios_bus_others__c)) + totalAvios1 + totalAvios2;
                                totalEuros += ((cs.R2_CAS_NUM_number_upgs_euros__c==null?0:cs.R2_CAS_NUM_number_upgs_euros__c) * (cs.R2_CAS_NUM_cash_bus_other__c==null?0:cs.R2_CAS_NUM_cash_bus_other__c)) + totalEuros1 + totalEuros2;
                            }
                            //Mapeamos los campos de campaña con el sumatorio total0
                            cam.R2_CAM_NUM_Total_number_total_upgs_avios__c = totalUGPSAvios;
                            cam.R2_CAM_NUM_Total_number_total_upgs_euros__c = totalUGPSEuros;
                            cam.R2_CAM_NUM_Total_number_Avios__c = totalAvios;
                            cam.R2_CAM_NUM_Total_number_euros__c = totalEuros;
                            lstCampUpdate.add(cam);
                        }

                        //Comprobamos que la lista de campañas que vamos a actualizar no está vacía
                        if(!lstCampUpdate.isEmpty()){
                            update lstCampUpdate;
                        }
                    }
                }
            }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.calculaCamposCampañaUPG()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Daniel Cadalso
Company:        Accenture
Description:    Method to set the R2_CAS_PK_status_event__c field to 'Lista de espera' if the related campaign R2_CAM_RS_registered__c field is
bigger than 11.

IN: List<Case> news   (trigger.new)
OUT:

History:
<Date>                     <Author>                     <Change Description>
05/11/2017                 Daniel Cadalso               Initial Version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/

 /*   public static void comprobarCantidadInscritos(List<Case> news){
        try{
            Set<Id> setCampaigns = new Set<Id>();
            Map<Id, Campaign> relatedCampaigns;
            Double numInscritos;
            for(Case caso: news){
                if (caso.R2_CAS_LOO_Campaigns__c != null){
                    setCampaigns.add(caso.R2_CAS_LOO_Campaigns__c);
                }
            }

            relatedCampaigns = new Map<Id, Campaign>([SELECT Id, R2_CAM_RS_registered__c, R2_CAM_FOR_Over_Maximum_Number_Capaci__c from Campaign where id in :setCampaigns]);

            for(Case caso: news){
                if(caso.R2_CAS_LOO_Campaigns__c != null &&
                   relatedCampaigns.get(caso.R2_CAS_LOO_Campaigns__c) != null &&
                   relatedCampaigns.get(caso.R2_CAS_LOO_Campaigns__c).R2_CAM_RS_registered__c > relatedCampaigns.get(caso.R2_CAS_LOO_Campaigns__c).R2_CAM_FOR_Over_Maximum_Number_Capaci__c){
                       caso.R2_CAS_PK_answer_event__c = 'SI';
                       caso.R2_CAS_PK_status_event__c = 'Lista de espera';
                   }
                System.debug('AaA '+caso.R2_CAS_PK_answer_event__c + ' -- ' + caso.R2_CAS_PK_status_event__c);
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.comprobarCantidadInscritos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Raquel Sánchez
Company:        Accenture
Description:    Method to set Status and Assistant field to 'Campaing member' if is changed un 'Case'
bigger than 11.

IN: List<Case> news   (trigger.new)
OUT:

History:
<Date>                     <Author>                     <Change Description>
13/12/2017                 Raquel Sánchez               Initial Version
-----------------------------------------------------------------------------------------*/

    public static void asistentesUpdate(List<Case> lstCasosNew, List<Case> lstCasosOld){
        boolean asistente = false;
        boolean estado = false;
          boolean record = false;
        String CampaignId ='';
        List<Campaign> lstCampUpdate = new List<Campaign>();
        List<CampaignMember> lstCampMemberUpdate = new List<CampaignMember>();

        Id rtIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campañas salientes').getRecordTypeId();

        if (!lstCasosNew.isEmpty() && !lstCasosOld.isEmpty()){
            Set<Id> set_campa = new Set<Id>();
            Set<Id> set_casosId = new Set<Id>();

            for(Case caso : lstCasosNew){
                set_campa.add(caso.R2_CAS_LOO_Campaigns__c);
                set_casosId.add(caso.ContactId);
                System.debug('contactID................. ' + caso.ContactId);
                if (caso.RecordTypeId == rtIdCase){
                record = true;
                    System.debug('caso.RecordTypeId......... ' + caso.RecordTypeId);
            }
            }
            System.debug('record................. ' + record);

            if (record){
            lstCampMemberUpdate = [SELECT R2_CMM_NUM_over18__c, R2_CMM_NUM_minor__c,
                                   R2_CMM_PK_answer__c, R2_CMM_PK_answer_Seg2__c,
                                   R2_CMM_PK_result__c, R2_CMM_PK_result_Seg2__c,
                                   R2_CMM_PK_Reason__c, R2_CMM_PK_Reason_Seg2__c,
                                   R2_CMM_PK_status_event__c, R2_CMM_PK_answer_event__c,
                                   R2_CMM_PK_result_event__c

                                   FROM CampaignMember
                                   WHERE CampaignId = :set_campa
                                   AND ContactId = :set_casosId LIMIT 1];
            }
            if (!lstCampMemberUpdate.isEmpty() && !lstCasosNew.isEmpty()){
                list<CampaignMember> campupdate = new List <CampaignMember> ();
                for(Case caso : lstCasosNew){
                  //  for (CampaignMember campMember: lstCampMemberUpdate){

                        if (caso.RecordTypeId == rtIdCase ){
                            for(CampaignMember campM: lstCampMemberUpdate){
                                campM.R2_CMM_NUM_over18__c = caso.R2_CAS_NUM_over_18__c;
                                campM.R2_CMM_NUM_minor__c = caso.R2_CAS_NUM_minors_18__c;
                                campM.R2_CMM_PK_answer__c = caso.R2_CAS_PK_answer__c ;
                                campM.R2_CMM_PK_answer_Seg2__c = caso.R2_CAS_PK_answer_Seg2__c;
                                campM.R2_CMM_PK_result__c = caso.R2_CAS_PK_resul__c;
                                campM.R2_CMM_PK_result_Seg2__c  = caso.R2_CAS_PK_resul_Seg2__c;
                                campM.R2_CMM_PK_Reason__c  = caso.R2_CAS_PK_Reason__c;
                                campM.R2_CMM_PK_Reason_Seg2__c =  caso.R2_CAS_PK_Reason_Seg2__c;
                                campM.R2_CMM_PK_status_event__c = caso.R2_CAS_PK_status_event__c;
                                campM.R2_CMM_PK_answer_event__c  = caso.R2_CAS_PK_answer_event__c;
                                campM.R2_CMM_PK_result_event__c  = caso.R2_CAS_PK_result_event__c;
                                campupdate.add(campM);
                            }
                            //   update campupdate;
                        }

                  //  }
                }
            update campupdate;
            }
        }
    }

    webservice static void asignaExpedienteCCPO (String casoId){
        try{
            String camposCaso = R1_CLS_Utilities.dynamicQuery('Case');
            String query = camposCaso +' from Case where id =\'' + casoId+'\'';
            System.debug (query);
            List<Case> lstCasos = Database.query(query);
            List<Profile> perfil = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
            String perfilName = perfil[0].Name;
            Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            if(perfilName == 'Call Center CCPO'){
                Case exp = lstCasos[0].clone(false, false, false, false);
                exp.id = null;
                exp.RecordTypeId = rtIdExp;
                insert exp;
                lstCasos[0].ParentId=exp.id;
                update lstCasos[0];
            }
        }
        catch(Exception exc){
               R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignaExpedienteCCPO()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    
       /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Borja Gay Flores
    Company:       Accenture
    Description:



    History:

    <Date>                        <Author>                       <Change Description>
    22/09/2017                 Borja Gay Flores                     Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

   public static void asignaAttachmentAPadre(List<Case> olds, List<Case> news){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(olds[0].ParentId == null && news[0].ParentId != null){
                List<Case> lstExp = [SELECT id,Status from Case where id = :news[0].ParentId limit 1];
                List<Attachment> lstAtt = new List<Attachment>();
                lstAtt = [SELECT id,Name, Body from Attachment where ParentId = :news[0].id];
                List<Group> lstColas = new List<Group>();
                lstColas = [SELECT id,Name from Group where Type='Queue' and Name = 'SYR Asignación'];
                List<Attachment> lstAttNew =  new List<Attachment>();

                if(!lstAtt.isEmpty()){
                    System.debug('Entro en lstAtt');
                    for(Attachment att : lstAtt){
                        Attachment attNew = new Attachment(name = att.name, body = att.body, parentid = lstExp[0].id);
                        System.debug('Padre:' + attNew.ParentId);
                        lstAttNew.add(attNew);
                    }
                }
            lstExp[0].Status = 'Abierto';
            if(!lstColas.isEmpty()){
                lstExp[0].OwnerId = lstColas[0].id;
            }
            System.debug('LstAttNew:'+ lstAttNew);
            update lstExp;
            insert lstAttNew;
            delete lstAtt;

            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseTriggerMethods.asignaAttachmentAPadre()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }


}