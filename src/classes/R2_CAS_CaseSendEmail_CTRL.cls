/*---------------------------------------------------------------------------------------------------------------------
        Author:         Rubén Pingarrón Jerez
        Company:        Accenture
        Description:    Clase controladora de la visualForce 'R2_CAS_VF_CaseSendEmail'
        IN:             
        OUT:            

        History: 
         <Date>                     <Author>                         <Change Description>
        28/07/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public class R2_CAS_CaseSendEmail_CTRL {
        
    public String casoId {get; set;}
    public List<EmailMessage> mensajesMostrados {get; set;}
    public Boolean shouldRedirect {get; set;}
    public Boolean shouldRedirectLink {get; set;}
    public Case caso {get; set;}
    public Integer allCorreos {get;set;}
    public String perfilName {get;set;}
    public List<EmailMessage> ListCamposEmailsImprimir {get;set;}
    public List<emailswrapper> mensajesMostradosList {get; set;}
    public Integer contadorPaginas {get; set;}
    
    // vaiables para Imprimir Emails
    public List<EmailMessage> selectedEmails {get;set;}
    
    public class emailswrapper {
        public EmailMessage emails {get; set;}
        public Boolean selected {get; set;}
        //constructor del WP
        public emailswrapper(EmailMessage e){
            emails = e;
            selected = false;
        }
        
    }
    
    public Boolean displayPopUp {get;set;}
    public List<emailswrapper> emailsListWP {get; set;}
    public List <EmailMessage> lst_Emails;
    List<EmailMessage> selectedEmail;
    
    public R2_CAS_CaseSendEmail_CTRL(ApexPages.StandardController sc){
        // Sacamos el Id del caso en el que estamos en la vista detallada
        casoId = sc.getId();
        contadorPaginas = 0;
        system.debug('***Wrapper: '+ mensajesMostradosList);
        List<Profile> perfil = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        perfilName = perfil[0].Name;
        System.debug('admiiiin' + perfilName);
        
        If(casoId != null){
            caso = [SELECT Id, AccountId, R2_CAS_EMA_Email__c FROM Case WHERE Id = :casoId LIMIT 1];
        }
        
        allCorreos = 0;   
        shouldRedirect = true;
        shouldRedirectLink = true;           

         system.debug('.. caseid ' + casoId);
        // ListCamposEmailsImprimir = [SELECT Id, FromAddress, ToAddress, MessageDate, Subject, TextBody, ParentId FROM EmailMessage WHERE ParentId =: casoId ORDER BY MessageDate DESC];
        //system.debug(ListCamposEmailsImprimir[0].MessageDate);
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Rubén Pingarrón Jerez
        Company:        Accenture
        Description:    Metodo que pinta en la tabla de la VF los emails de un caso
        IN:             
        OUT:            

        History: 
         <Date>                     <Author>                         <Change Description>
        28/07/2017                 Rubén Pingarrón Jerez                   Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/
    public void mostrarEmails(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            // Query para los mensajes que se mostraran en la tabla
            Set<Id> casosIds = new Set<Id>();
            casosIds.add(casoId);
            if(casoId != null){
                List<Case> casos = [SELECT Id FROM Case WHERE ParentId = :casoId];
                if(!casos.isEmpty()){
                    for(Case caso : casos){
                        casosIds.add(caso.Id);
                    }
                }
            }
            //inicializamos la lista de datos que pasaremos a la visual
            mensajesMostradosList = new List<emailswrapper>();
            this.mensajesMostrados = [SELECT ID, Status, Subject, MessageDate, FromAddress, ToAddress, TextBody FROM EmailMessage WHERE ParentId IN :casosIds ORDER BY MessageDate DESC];
                // Query para contar el total de mensajes para el boton de "mostrar todos"
            //List<EmailMessage> lstMensajes = [SELECT ID FROM EmailMessage WHERE ParentId = :casoId];          
            allCorreos = this.mensajesMostrados.size();
            //rellenamos la lista de wrappers para la visual
            if(mensajesMostrados.size() > 0){
                Pattern bodyPattern = Pattern.compile('ref:_.*:ref');
                for(EmailMessage em: mensajesMostrados){
                    String strbody = (String.valueof(em.TextBody));
                    String str     = (String.valueof(em.Subject));
                    
                    String bodyKey = bodyPattern.matcher(strbody).replaceAll('');
                    em.TextBody = bodyKey;
                    String subjectKey1 = bodyPattern.matcher(str).replaceAll('');
                    subjectKey1 = subjectKey1.replace(']', '');
                    subjectKey1 = subjectKey1.replace('[', '');
                    em.Subject = subjectKey1;

                    mensajesMostradosList.add(new emailswrapper(em));
                }
            }            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CAS_CaseSendEmail_CTRL.mostrarEmails()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'EmailMessage');
        }    
    }
    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Sara Torres Bermúdez
        Company:        Accenture
        Description:    Metodo para guardar en una lista los emails que se han seleccionado para imprimir
        IN:             
        OUT:            

        History: 
         <Date>                     <Author>                         <Change Description>
        27/09/2017                 Sara Torres Bermúdez                  Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/

    public void recolectarCheck(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;   
            //imprimir Emails
            selectedEmails = new List<EmailMessage>();
            
            for(emailswrapper emaWP: mensajesMostradosList){
                if(emaWP.selected){
                    selectedEmails.add(emaWP.emails);
                }
            }
            
         }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CAS_CaseSendEmail_CTRL.imprimirEmails()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'EmailMessage');
        } 
    }
    public void recorrerEmailsSelected(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            
            for(emailswrapper emaCheck: mensajesMostradosList){
                emaCheck.selected = false;
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CAS_CaseSendEmail_CTRL.recorrerEmailsSelected()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'EmailMessage');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Sara Torres Bermúdez
        Company:        Accenture
        Description:    Metodo para abrir en una subtab un pdf para imprimir los emails seleccionados
        IN:             
        OUT:            

        History: 
         <Date>                     <Author>                         <Change Description>
        03/09/2017                 Sara Torres Bermúdez                  Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/
    public PageReference GotoPrint(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            //calculamos cuantos correos ha seleccionado para luego evitar una página de más en el pdf
            contadorPaginas = 0;
            
            for(emailswrapper ew : mensajesMostradosList){
                if(ew.selected){
                    contadorPaginas++;
                } 
            }
            
            
            
            //redireccionamos a la página de impresión
            PageReference pr = Page.R2_CAS_VF_CasePrintEmail;
            pr.setRedirect(false);
            return pr;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CAS_CaseSendEmail_CTRL.GotoPrint()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'EmailMessage');
            return null;
        }
    } 
}