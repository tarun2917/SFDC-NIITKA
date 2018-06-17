/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Trigger para manejar Casos
    IN:
    OUT:

    History:
     <Date>                     <Author>                            <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                      Initial Version
    28/07/2017             Alberto Puerto Collado                     asignaAccountToCase
    31/07/2017             Alberto Puerto Collado                     reabrirExpediente
    31/07/2017             Sara Torres Bermúdez                      asociarCasoAVuelo
    31/07/2017             Sara Torres Bermúdez                      CuentaCasos
    22/08/2017             Sara Torres Bermúdez                      rellenarCampoDescripcion
    22/09/2017             Alberto Puerto Collado                     actualizaType_fromType1
    26/09/2017             Rubén Pingarrón Jerez                      insertarCasoPadreEnCola
    03/10/2017             Jaime Ascanta                              asignaAccountToCaseRTIberiaCom
    04/12/2017             Ulises Paniego                             vueloCompleUpdate
    06/12/2017             Daniel Cadalso                             comprobarCantidadInscritos
    07/12/2017             Alejandro Turiegano                        calculaCamposCampanaUPG
    13/12/2017             Raquel Sanchez                             asistentesUpdate
    04/04/2018             Alberto Puerto Collado                     enable calculaCamposCampanaUPG
    ----------------------------------------------------------------------------------------------------------------------*/
trigger R2_CAS_TRG_CaseTrigger on Case (before insert, before update, after insert, after update, after delete, after undelete) {

    List<Case> news = trigger.new;
    List<Case> olds = trigger.old;

    Map<Id, Case> oldMap = trigger.oldMap;

    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);


    if(Trigger.isBefore){
        if(Trigger.isInsert){
            //Ibconecta
            //R2_CLS_CaseTriggerMethods.formatearCasoIBConecta(news);
            //R2_CLS_CaseTriggerMethods.typeAndSubtypeIberiaConect(news);
            R2_CLS_CaseTriggerMethods.actualizaType_fromType1(news);
            R2_CLS_CaseTriggerMethods.asignaPadre(news);
            R2_CLS_CaseTriggerMethods.asignarOwnerADocumentosEscaneados(news);
            List<Case> lstCasosWeb = R2_CLS_CaseTriggerMethods.filtrarCasosWeb(news);
            if(lstCasosWeb != null){
                R2_CLS_CaseTriggerMethods.insertarCasoPadreEnCola(lstCasosWeb);
            }

            //R2_CLS_CaseTriggerMethods.comprobarCantidadInscritos(news);

            if(trigger.new.size()==1){
                // R2_CLS_CaseTriggerMethods.reabrirExpediente(news);
                //R2_CLS_CaseTriggerMethods.asociarCasoAVuelo(news);
                //R2_CLS_CaseTriggerMethods.asignaAccountToCase(news);
                R2_CLS_CaseTriggerMethods.asignaAccountToCaseRTIberiaCom(news);
            }

        }
        if(Trigger.isUpdate){
            R2_CLS_CaseTriggerMethods.rellenarCampoDescripcion(news, olds);
            //R2_CLS_CaseTriggerMethods.cambiarEstadoAlHijo(news);
            //R2_CLS_CaseTriggerMethods.cambiosEnElStatus(news);
            R2_CLS_CaseTriggerMethods.gestionaAprobacion(news, olds);
            R2_CLS_CaseTriggerMethods.asignaAttachmentAPadre(olds,news);
            List<Case> lstCasos=R2_CLS_CaseTriggerMethods.filtrarCasosActualizadosSitel(olds,news);
            if(!lstCasos.isEmpty()){
                R2_CLS_CaseTriggerMethods.enviarASitel(lstCasos);
            }
        }
     }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            R2_CLS_CaseTriggerMethods.asignarCasoHijoInsert(news);
            R2_CLS_CaseTriggerMethods.CuentaCasos(news);
            //R2_CLS_CaseTriggerMethods.estadoHijoCuandoPadreEsWeb(news);
            //R2_CLS_CaseTriggerMethods.cambiosEnElStatus(news);
            R2_CLS_CaseTriggerMethods.updateClaimantEntity(news, null);
            R2_CLS_CaseTriggerMethods.rellenarIdentificador(news);
            R2_CLS_CaseTriggerMethods.calculaCamposCampanaUPG(news);
           //metodo que llama a la integración de PreOrder para saber si hay reembolso.
            //system.debug('--> triger map ' + trigger.newMap.keySet());
            if(news[0].Type == 'Servicios gastronomicos'){
                R2_CLS_PreOrderMethods.comprobacionesParaReembolso(trigger.newMap.keySet());
            }
            
            //Ibconecta
            //R2_CLS_CaseTriggerMethods.crearVoucherIBConecta(news);

            R2_CLS_CaseTriggerMethods.enviarASitel(news);
        }
        if(Trigger.isUpdate){
            R2_CLS_CaseTriggerMethods.asistentesUpdate(news, olds);
            R2_CLS_CaseTriggerMethods.asignarCasoHijoUpdate(news, olds);
            R2_CLS_CaseTriggerMethods.CuentaCasosUpdate(news, olds);
            List<Case> lstCasos=R2_CLS_CaseTriggerMethods.filtrarCasosActualizadosIdentificador(olds,news);
            if(!lstCasos.isEmpty()){
                R2_CLS_CaseTriggerMethods.rellenarIdentificador(lstCasos);
            }
            R2_CLS_CaseTriggerMethods.updateClaimantEntity(news, olds);
            // 05/03/2018 -> hemos pasado el metodo: cambiosEnElStatus de Before Update a After Update.
            R2_CLS_CaseTriggerMethods.cambiosEnElStatus(news);

            //if (!R2_CLS_CaseTriggerMethods.casosMismaCamp) {
            //    R2_CLS_CaseTriggerMethods.vueloCompleUpdate(news, oldMap);
            //}
            R2_CLS_CaseTriggerMethods.calculaCamposCampanaUPG(news);
        }
         if(Trigger.isDelete){
            R2_CLS_CaseTriggerMethods.CuentaCasos(olds);
        }
         if(Trigger.isUndelete){
            R2_CLS_CaseTriggerMethods.CuentaCasos(news);
        }
    }

}