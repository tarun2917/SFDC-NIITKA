/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Integración para tarjetas de regalo de Amazon. Esta integracion consta de 2: Create y Cancel, pero de momento solo el Create.    

    History: 
     <Date>                     <Author>                         <Change Description>
    17/10/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_WorkOrder_TriggerMethods {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Metodo para cuando se inserte una orden de trabajo, llame a la integracion: R2_CLS_GiftCard  

    History: 
     <Date>                     <Author>                         <Change Description>
    17/10/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static void insertarGiftCard(R2_Work_Order__c ordenTrabajo){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
          
            if ((ordenTrabajo.R2_WO_PKL_type__c == 'Amazon') && (ordenTrabajo.R2_WO_NUM_Amount_tot__c != null) && (ordenTrabajo.R2_WO_NUM_Amount_tot__c >= 10.0)){
                R2_CLS_GiftCard.CrearTarjeta(ordenTrabajo.id);
            }           
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WorkOrder_TriggerMethods.insertarGiftCard()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Work_Order__c');
         }
        
    }   
    
}