public without sharing class R1_CLS_LogHelper {
    
    public static Boolean throw_exception = true;

    public class R1_Exception extends Exception {
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ricardo Pereira
    Company:        Accenture
    Description:    Custom exception
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Ricardo Pereira     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ricardo Pereira
    Company:        Accenture
    Description:    Method that creates the generateLog records with the given parameters
    
    IN:         String objetoAsociado: Nombre del Objeto en donde ocurrió el error
                String descriptionError: Contendrá una descripción completa del error.
                String metodoDelError: Clase y metodo donde ocurrió el error.
                String idRegistroAsociado: Id (o detalles) sobre el registro que produjo el error.

    OUT:           Void
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Ricardo Pereira     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/    
    public static void generateErrorLog(String metodoDelError, String idRegistroAsociado, String descriptionError, String objetoAsociado){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            //Create a new Register
            R1_Log__c log = new R1_Log__c(R1_LOG_ATXTL_MensajeError__c = descriptionError,
                                            R1_LOG_TXT_RegAsociado__c = idRegistroAsociado,
                                            R1_LOG_TXT_Objeto__c = objetoAsociado,
                                            R1_LOG_TXT_Metodo__c = metodoDelError);
            //Insert the register
            insert log;
            system.debug('LOG - '+log);
        }catch (exception e){
            
        }
            
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ricardo Pereira
    Company:        Accenture
    Description:    Wrapper class used to determine if it is necessary to throw an exception during the test execution
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Ricardo Pereira     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    public static Boolean isRunningTest() {
        return Test.isRunningTest() && throw_exception;
    }
}