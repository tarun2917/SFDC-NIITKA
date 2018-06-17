/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    monitoring wt uses
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    08/05/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
public with sharing class CLS_INC_WT_Monitoring {
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    saving in database
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    08/05/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    @future
    public static void watchingWT(String servicio, String tipo) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug(':::WatchingWT:');
            String userId = UserInfo.getUserId();
            List<Track_WT__c> lstTrack = [SELECT Id, Name, CreatedBy.Id, INT_Usos__c, TXT_servicio__c, FOR_Key__c 
                                FROM Track_WT__c
                                WHERE CreatedBy.Id =:userId AND TXT_servicio__c =:servicio];
            
            if(lstTrack.isEmpty()){
                System.debug(':::Track existente:' + lstTrack);
                Track_WT__c newTrack = new Track_WT__c();
                newTrack.INT_Usos__c = 1;
                newTrack.TXT_servicio__c = servicio;
                newTrack.PKL_Tipo__c = tipo;
                System.debug(':::Insert track:' + newTrack);
                insert newTrack;
            }else{
                System.debug(':::Nuevo Track');
                lstTrack[0].INT_Usos__c += 1;
                System.debug(':::Update track:' + lstTrack);
                update lstTrack;
            }
        }catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('CLS_INC_WT_Monitoring.watchingWT', 'DML Exception', ex.getmessage()+', '+ex.getLineNumber(), 'Track_WT__c');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('CLS_INC_WT_Monitoring.watchingWT', '', ex.getmessage()+', '+ex.getLineNumber(), 'Track_WT__c');
        }
    }
}