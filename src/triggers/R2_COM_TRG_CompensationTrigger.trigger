/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Trigger del objeto Pagos "R2_Compensation__c"
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                         <Change Description>
    22/08/2017              Ruben Pingarron Jerez           Initial Version
    14/12/2017              Alberto Puerto Collado          calculaAmountsExpedienteAsociadoOPs added / sumarOrdenEnviada removed
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    
trigger R2_COM_TRG_CompensationTrigger on R2_Compensation__c (before insert, after insert, after update, after delete) {
	
    List<R2_Compensation__c> news = trigger.new;
    List<R2_Compensation__c> olds = trigger.old;
    Set<Id> idPays = new Set<Id>();
    
    R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            R2_CLS_CompensationTriggerMethods.pagoToEC(news);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            R2_CLS_CompensationTriggerMethods.calcularPeriodoPresupuestario(news);
            R2_CLS_CompensationTriggerMethods.calculaIndemnizacion(news);
            R2_CLS_CompensationTriggerMethods.crearOPAvios(news[0].id);
        }
        
        if(Trigger.isUpdate){
            R2_CLS_CompensationTriggerMethods.calculaIndemnizacion(news);
            List<R2_Compensation__c> lstPagos = R2_CLS_CompensationTriggerMethods.filtrarPagosOrden(olds,news);
            if(!lstPagos.isEmpty()){
                List<R2_Payment_order__c> lstOP = R2_CLS_CompensationTriggerMethods.sumarImportesOP(lstPagos);           
                if(!lstOP.isEmpty()){
                    System.debug('Lista OP: '+ lstOP+' '+lstOP.size()+' '+lstOP.isEmpty());
                    System.debug('Entro en sumar orden');
                    //R2_CLS_CompensationTriggerMethods.sumarOrdenEnviada(lstOP); //comentada Alberto Puerto
                    R2_CLS_CompensationTriggerMethods.calculaAmountsExpedienteAsociadoOPs(lstOP); //Added Alberto Puerto
                }
            }
            /*if(news.size()==1){
                if(!System.isFuture()){
                   	R2_CLS_CompensationTriggerMethods.lanzarIniciarPago(news[0].Id);
                }
            }*/
        }  
        if(Trigger.isDelete){
            R2_CLS_CompensationTriggerMethods.calculaIndemnizacion(olds);
        }
    }  
    
}