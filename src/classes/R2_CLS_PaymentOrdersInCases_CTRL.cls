/*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:   	Controladora de la visual R2_CAS_VF_PaymentOrdersInCases
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
07/11/2017             Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_PaymentOrdersInCases_CTRL {
	
    public List<R2_Payment_order__c> ordersToShow {get;set;}
    public String casoId {get; set;}
    public String idApprove {get;set;} 
    public String idReject {get;set;}
    
    
    public R2_CLS_PaymentOrdersInCases_CTRL(ApexPages.StandardController sc){
       	casoId = sc.getId();      
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:   	Metodo que rellena la tabla de ordenes de pago de la visual
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
07/11/2017             Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void mostrarTabla(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            Set<Id> ordersId = new Set<Id>();
        	Set<Id> hijosId = new Set<Id>();
        
            
            List<Case> casosHijos = [SELECT Id FROM Case WHERE ParentId = :casoId];
            
            if(!casosHijos.isEmpty()){
                for(Case caso : casosHijos){
                    hijosId.add(caso.Id);
                }
            }
            
            List<R2_Compensation__c> lstPagos = [SELECT Id, R2_COM_LOO_Payment_Code__c FROM R2_Compensation__c WHERE R2_COM_LOO_Case__c IN :hijosId];
            
            if(!lstPagos.isEmpty()){
                for(R2_Compensation__c pago : lstPagos){
                    ordersId.add(pago.R2_COM_LOO_Payment_Code__c);
                }
            }
            
            ordersToShow = [SELECT Id, Name, R2_OPY_PCK_Status__c, R2_OPY_TXT_IBAN__c, R2_OPY_TXT_SWIFT__c, R2_OPY_LOO_CaseAccount__c,
                            R2_OPY_TXT_Remittance_Code__c, R2_OPY_DAT_Date_Issue_Remittance__c, R2_OPY_DAT_Payment_Date__c,
                            R2_OPY_FOR_Total_Amount__c FROM R2_Payment_order__c WHERE (Id IN :ordersId OR R2_OPY_LOO_File_associated__c = :casoId) AND (R2_OPY_PCK_Status__c != 'Borrador')];//Ready añadido
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PaymentOrdersInCases_CTRL.mostrarTabla()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Case');
        } 
    }
    public void mostrarTablaEscalada(){
        GroupMember groupSRYSupervisores = null;
        GroupMember groupUSRPagos = null;
        try{
            groupSRYSupervisores = [SELECT Group.Name FROM GroupMember WHERE UserOrGroupId =:UserInfo.getUserId() AND (Group.Name = 'Administradores' OR Group.Name = 'Claims - Agentes' OR Group.Name = 'Claims - Supervisores')];
            groupUSRPagos = [SELECT Group.Name FROM GroupMember WHERE UserOrGroupId =:UserInfo.getUserId() AND (Group.Name = 'Administradores' OR Group.Name = 'Claims - Agentes' OR Group.Name = 'Claims - Supervisores')];
            System.debug('groupSRYSupervisores!!!!!'+groupSRYSupervisores);
            System.debug('groupSRYSupervisores!!!!!'+groupUSRPagos);//Actualmente iguales
        }
        catch(Exception e){
            System.debug(e);
        }
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            Set<Id> ordersId = new Set<Id>();
        	Set<Id> hijosId = new Set<Id>();
        
            
            List<Case> casosHijos = [SELECT Id FROM Case WHERE ParentId = :casoId];
            
            if(!casosHijos.isEmpty()){
                for(Case caso : casosHijos){
                    hijosId.add(caso.Id);
                }
            }
            
            List<R2_Compensation__c> lstPagos = [SELECT Id, R2_COM_LOO_Payment_Code__c FROM R2_Compensation__c WHERE R2_COM_LOO_Case__c IN :hijosId];
            
            if(!lstPagos.isEmpty()){
                for(R2_Compensation__c pago : lstPagos){
                    ordersId.add(pago.R2_COM_LOO_Payment_Code__c);
                }
            }
            
            if(groupSRYSupervisores != null && groupUSRPagos != null){
                ordersToShow = [SELECT Id, Name, R2_OPY_PCK_Status__c, R2_OPY_TXT_IBAN__c, R2_OPY_TXT_SWIFT__c, 
                            R2_OPY_TXT_Remittance_Code__c, R2_OPY_DAT_Date_Issue_Remittance__c, R2_OPY_DAT_Payment_Date__c, R2_OPY_LOO_Submitter__c, R2_OPY_TXT_ApproverGroup__c,
                            R2_OPY_LOO_Submitter__r.Name, R2_OPY_DIV_Amount__c FROM R2_Payment_order__c WHERE (Id IN :ordersId OR R2_OPY_LOO_File_associated__c = :casoId) AND R2_OPY_PCK_Status__c = 'ESCALADO' AND R2_OPY_TXT_ApproverGroup__c = 'SYR Supervisores' ORDER BY Name DESC];
            
            }
            else if(groupSRYSupervisores != null && groupUSRPagos == null){
                ordersToShow = [SELECT Id, Name, R2_OPY_PCK_Status__c, R2_OPY_TXT_IBAN__c, R2_OPY_TXT_SWIFT__c, 
                            R2_OPY_TXT_Remittance_Code__c, R2_OPY_DAT_Date_Issue_Remittance__c, R2_OPY_DAT_Payment_Date__c, R2_OPY_LOO_Submitter__c, R2_OPY_TXT_ApproverGroup__c,
                            R2_OPY_LOO_Submitter__r.Name, R2_OPY_DIV_Amount__c FROM R2_Payment_order__c WHERE (Id IN :ordersId OR R2_OPY_LOO_File_associated__c = :casoId) AND R2_OPY_PCK_Status__c = 'ESCALADO' AND R2_OPY_TXT_ApproverGroup__c = 'USR Pagos' ORDER BY Name DESC];
            
            }
            else if(groupSRYSupervisores == null && groupUSRPagos != null){
                ordersToShow = [SELECT Id, Name, R2_OPY_PCK_Status__c, R2_OPY_TXT_IBAN__c, R2_OPY_TXT_SWIFT__c, 
                            R2_OPY_TXT_Remittance_Code__c, R2_OPY_DAT_Date_Issue_Remittance__c, R2_OPY_DAT_Payment_Date__c, R2_OPY_LOO_Submitter__c, R2_OPY_TXT_ApproverGroup__c,
                            R2_OPY_LOO_Submitter__r.Name, R2_OPY_DIV_Amount__c FROM R2_Payment_order__c WHERE (Id IN :ordersId OR R2_OPY_LOO_File_associated__c = :casoId) AND R2_OPY_PCK_Status__c = 'ESCALADO' AND (R2_OPY_TXT_ApproverGroup__c = 'SRY Supervisores' OR R2_OPY_TXT_ApproverGroup__c = 'USR Pagos') ORDER BY Name DESC];
            
            }
            else{
                ordersToShow = null;
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PaymentOrdersInCases_CTRL.mostrarTabla()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Case');
        } 
    }
    public void approve(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            System.debug('!!!!!!!!!!idApprove: '+idApprove);
            if(idApprove!=null){
                R2_Payment_order__c ordenPago = [SELECT Id, Name, R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id =:idApprove];
                ordenPago.R2_OPY_PCK_Status__c = 'ENVIADO A BANCO';
                update ordenPago;
                System.debug(ordenPago);
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PaymentOrdersInCases_CTRL.approve()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Case');
        } 
    }
    public void reject(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            System.debug('!!!!!!!!!!idReject: '+idReject);
            if(idReject!=null){
                R2_Payment_order__c ordenPago = [SELECT Id, Name, R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id =:idReject];
                //delete ordenPago;
                System.debug(ordenPago);
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PaymentOrdersInCases_CTRL.reject()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Case');
        } 
    }
    
}