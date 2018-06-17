public class R1_CLS_CTI_VF_CTRL{
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay
    Company:        Accenture
    Description:    CTI VisualForce Controller Class.
    
    History:
    
    <Date>              <Author>            <Description>
    25/04/2017          Borja Gay          Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   
    String tlfLlamante = '';
    String tlfLlamado = '';
    String idLlamada = '';
    String tipoLlamada = '';
    String infoAdicional = '';
    String recordId = '';
    public String idc{get;set;}
    public String urlCaso{get;set;}
    public String servicio{get;set;}
    public List<Account> accDup {get;set;}
    public List<Account> acc {get;set;}
    public boolean noCliente {get;set;}
    public boolean internal {get;set;}
    public String timeInQueue {get;set;} //DBI 23/08/2017
    List<String> idreconocidos = new List<String>();
    List<String> idDup = new List<String>();
    
    /*---------------------------------------------------------------------------------------------------------------------
  Author:         Borja Gay Flores
  Company:        Accenture
  Description:    Constructor de la clase
  IN:             
  OUT:            

  History: 
   <Date>                     <Author>                         <Change Description>
  05/07/2017               Borja Gay Flores                       Initial Version
  23/08/2017                  David Barco Infante               Add the timeInQueue field in the VF (value in seconds)
  ----------------------------------------------------------------------------------------------------------------------*/ 
    
    public R1_CLS_CTI_VF_CTRL(ApexPages.StandardController controller) {
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            tlfLlamante = ApexPages.currentPage().getParameters().get('ani');
            tlfLlamado = ApexPages.currentPage().getParameters().get('dnis');
            idLlamada = ApexPages.currentPage().getParameters().get('cid');
            tipoLlamada = ApexPages.currentPage().getParameters().get('calltype');
            infoAdicional =ApexPages.currentPage().getParameters().get('uui');
            recordId = ApexPages.currentPage().getParameters().get('recordid');
            
            idc=ApexPages.currentPage().getParameters().get('tabid');
            noCliente=false;
            internal=false;
            
            if(recordId!=null && recordId!=''){
                idreconocidos = recordId.split(';');
                if(idreconocidos.size() == 1){
                    acc=[SELECT id, name, R1_ACC_PKL_identification_Type__c,R1_ACC_TXT_Identification_number__c,R1_ACC_FOR_Primary_FF_Card_CCPO__c,R1_ACC_PKL_Card_Type__c from Account where id=:idreconocidos[0] limit 1];
                }
                else{
                    System.debug('No Cliente');
                    noCliente=true;
                }
              
            }
            else{
                System.debug('No Cliente');
                noCliente=true;
            }
            servicio='';
            if(tlfLlamado!=null && tlfLlamado!=''){
                
                List<R1_CTI_Services__c> lst_ServicioCTI=[SELECT R1_CTI_Service__c FROM R1_CTI_Services__c WHERE R1_CTI_Phone__c=:tlfLlamado LIMIT 1];
                if(lst_ServicioCTI.size()!=0){
                    servicio=lst_ServicioCTI[0].R1_CTI_Service__c;
                  }
            }
             if(tipoLlamada=='Internal' && recordid==''){
             System.debug('Internal es true');
             internal=true;
             
             }
             else{
             internal=false;
             }

             //DBI 23/8/2017
             //Add value to timeInQueue for fill the new column in the visualforce R1_VF_CTI
             timeInQueue = '';
             if(infoAdicional != null && infoAdicional != ''){
                String[] campos = infoAdicional.split('!');
                Integer seg = Integer.valueOf(campos[1]);//tiempo de espera 
                Integer resta = seg-40;
                if(resta > 0){
                  timeInQueue = R1_CLS_TaskTriggerMethods.devuelveStringDate(resta);
                }else{
                  timeInQueue = R1_CLS_TaskTriggerMethods.devuelveStringDate(0);
                }
                
             }
        }catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_VF_CTRL__c.R1_CLS_VF_CTRL', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_CLS_VF_CTRL__c');
        }
    }
 
    /*---------------------------------------------------------------------------------------------------------------------
  Author:         Borja Gay Flores
  Company:        Accenture
  Description:    Metodo que asigna valor con la ID de un Caso a la variable urlCaso
  IN:             
  OUT:            

  History: 
   <Date>                     <Author>                         <Change Description>
  05/07/2017               Borja Gay Flores                       Initial Version
  ----------------------------------------------------------------------------------------------------------------------*/ 
    public void asignarCaso(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            if(internal==false && noCliente==false){
            if(recordId!=''){
             if(idreconocidos.size() == 1){  
            String url=cargarCaso();
            urlCaso=url;
            System.debug('Valor :'+urlCaso);
            }
            }
            else{
            System.debug('No Cliente Abajo');
            noCliente=true;
            }
            }
        }catch(Exception exc){
          R1_CLS_LogHelper.generateErrorLog('R1_CLS_VF_CTRL__c.asignarCaso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_CLS_VF_CTRL__c');
        }
    }
    
/*---------------------------------------------------------------------------------------------------------------------
  Author:         Borja Gay Flores
  Company:        Accenture
  Description:    Método que crea un caso con los datos de la llamada
  IN:             
  OUT: String "/"+id caso+"/e"            

  History: 
   <Date>                     <Author>                         <Change Description>
  05/07/2017               Borja Gay Flores                       Initial Version
  ----------------------------------------------------------------------------------------------------------------------*/ 
    public String cargarCaso (){      
       try{
           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            Case caso = new Case();
            caso.R1_CAS_TXT_Call__c=idLlamada;
            Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Comunicaciones entrantes').getRecordTypeId();  
            caso.recordTypeId=recordTypeId;
            caso.status='Cerrado';
            caso.Origin = 'Llamada';
            caso.AccountId = acc[0].id;
            caso.Type='Sin información';
            insert caso;
            System.debug('ID Caso: '+ caso.id );
            return '/'+caso.id+'/e';
       }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_VF_CTRL__c.cargarCaso', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_CLS_VF_CTRL__c');
          return '';
       }
        
    }

}