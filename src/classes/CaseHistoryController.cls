/*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:  
IN:             
OUT:           

History: 
<Date>                     <Author>                         <Change Description>
20/09/2017             Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public with sharing class CaseHistoryController {
    
    public List<CaseHistoryItem> CHIlist  {get; set;}
    public List<Case> ListCases          	{get; set;}
    public List<Attachment> emailAdj		{get; set;}
    public Case aCase						{get; set;}
    public String caseID                  {get; set;}
    //public boolean showAll                {get; set;}
    //public Set<String> prefixSet          {get; set;}
    public String tipoSelected		    {get; set;}
    public List<SelectOption> lstNombreTipos 	{get; set;}
    public List<CaseHistoryItem> lstChiVisual  {get; set;}
    List<EmailMessage> emails 				{get; set;}
    public Static final Map<String, Schema.SObjectField> CaseFieldmap = Schema.SObjectType.Case.fields.getMap();
    public Static final List<Schema.PicklistEntry> fieldPicklistValues = CaseHistory.Field.getDescribe().getPicklistValues();
    
    
    
    public CaseHistoryController(){
        CHIlist= new List<CaseHistoryItem>();
        caseID = Apexpages.currentPage().getParameters().get('id'); 
        filtroTipo();
        
        if (caseID == null || caseID == '')
        {
            return;
        }
        
        ListCases = [select Id, CaseNumber, Description, R1_CAS_LOO_Incidences__c, R2_CAS_LOO_PIR__c, R1_CAS_LOO_Flight__c, 
                     LastModifiedDate, Account.Name, AccountId, Subject, Contact.Name, ContactId, OwnerId, Owner.Id, Owner.Name, RecordTypeId,
                     (Select Id, CreatedDate, LastModifiedDate,CreatedBy.Name, CreatedById, CommentBody From CaseComments),
                     (Select Id, CreatedById, CreatedBy.Name, CreatedDate, Field, OldValue, NewValue From Histories),
                     (Select Id, HasAttachment, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, TextBody, Subject, FromName, ToAddress, MessageDate From EmailMessages),
                     (Select Id, CreatedById, LastModifiedDate, Status, R2_CAS_PKL_Vip_Type__c, R1_CAS_PKL_Idioma__c, CreatedBy.Name, CreatedDate, ParentId, Subject, Owner.Name, OwnerId, Description From Cases),
                     (Select Id, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, Name, Owner.Name, OwnerId, R2_INC_ATXT_Reason_description__c From Incidencias1__r),
                     (Select Id, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, Name From Entidades_Comunicantes__r),
                     (Select Id, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, Name, Owner.Name, OwnerId From Attachments),
                     (Select Id, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, Name, Owner.Name, OwnerId From pago__r)
                     from Case where id = :caseID OR ParentID = :caseID];
        
        
        emails = [SELECT Id FROM EmailMessage WHERE ParentId =:caseID];
        Set<Id> emailsId = new Set<Id>();
        for(EmailMessage em : emails){
            emailsId.add(em.Id);
        }
        emailAdj = [SELECT Id, CreatedById, LastModifiedDate, CreatedBy.Name, CreatedDate, Name, Owner.Name, OwnerId FROM Attachment WHERE ParentId IN :emailsId];
        
        
        if(!ListCases.isEmpty()){
            for(Case caso : ListCases){
                if(caso.Id == caseID){
                    aCase = caso;
                    setupEmailAttachment(caso);
                }
                setupCaseComments(caso);
                setupHistories(caso);
                setupEmails(caso);
                setupCases(caso);
                setupIncidencias(caso);
                setupPagos(caso);
                //setupPIR(caso);
                setupEntidades(caso);
                setupAttachments(caso);
                
            }
            
            lstChiVisual = new List<CaseHistoryItem>();
            lstChiVisual.addAll(CHIlist);
            
        }
        System.debug('Listarchivos:' + emailAdj);
        System.debug('ListaCasos:' + ListCases.size());
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String returnFieldLabel(String fieldName){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            if(CaseHistoryController.CaseFieldmap.containsKey(fieldName)){
                return CaseHistoryController.CaseFieldmap.get(fieldName).getDescribe().getLabel();
            }else{
                for(Schema.PicklistEntry pickList : fieldPicklistValues){
                    if(pickList.getValue() == fieldName){
                        if(pickList.getLabel() != null){
                            return pickList.getLabel();
                        }else{
                            return pickList.getValue();
                        }
                        
                    }
                }
            }
            return '';
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.returnFieldLabel()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return '';
        }            
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupHistories(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<CaseHistory> cHistories = c.Histories;
            
            String tipo = 'Historial caso hijo';    
            String subject;
            
            
            for (CaseHistory ch:cHistories){ 
                String fieldLabel = CaseHistoryController.returnFieldLabel(String.valueOf(ch.Field));
                
                System.debug('Label' + ch.Field + 'chiOlvalue' + ch.OldValue);
                
                
                if(ch.OldValue==null && ch.NewValue==null)
                    subject = 'Campo '+fieldLabel+'--Modificado o Creado';
                else if(ch.OldValue==null)
                    subject = 'Campo '+fieldLabel+' cambió o se modificó a "'+ch.NewValue+'"';
                else if(ch.newValue==null)
                    subject = 'Campo '+fieldLabel+' cambió o se modificó a "'+ch.OldValue+'"';
                else
                    subject = 'Campo '+fieldLabel+' cambió el valor "'+ch.OldValue+'" a "'+ch.NewValue+'"';
                
                
                if(subject!=null){
                    if(caseID == c.Id){
                        tipo = 'Historial';
                    }
                    Id idObj;
                    try{
                        idObj = (Id)ch.OldValue;
                        
                    }catch(Exception exc){
                        CHIlist.add(new CaseHistoryItem(null, null, ch.CreatedDate, null, null, null, null, subject, ch.CreatedBy.Name, ch.CreatedById, null, tipo, null, null, null, null));
                    }     
                }         
            }   	
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupHistories()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupEmails(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<EmailMessage> emailMessages=c.EmailMessages;
            String subject='';
            for(EmailMessage em:emailMessages){
                subject='El '+em.MessageDate.format('dd/MM/yyyy')+' '+em.FromName+' escribió a '+em.ToAddress+'--'+em.Subject;
                CHIlist.add(new CaseHistoryItem(em.TextBody, em.HasAttachment, em.CreatedDate, em.LastModifiedDate, null, null, null, subject, em.CreatedBy.Name, em.CreatedById,  em.Id, 'Email', null, null, null, null));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupEmails()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
        
        
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupCaseComments(Case c){
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List <CaseComment> cComments = c.CaseComments;
            for(CaseComment cc: cComments){
                CHIlist.add(new CaseHistoryItem(cc.CommentBody, null, cc.CreatedDate, cc.LastModifiedDate, null, null, null, cc.CommentBody, cc.CreatedBy.Name, cc.CreatedById, null,'Comentario', null, null, null, null));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupCaseComments()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupCases(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<Case> casos = c.Cases;
            for(Case caso : casos){
                CHIlist.add(new CaseHistoryItem(null, null, caso.CreatedDate, caso.LastModifiedDate, caso.Status, caso.R2_CAS_PKL_Vip_Type__c, caso.R1_CAS_PKL_Idioma__c, caso.Subject, caso.CreatedBy.Name, caso.CreatedById, caso.Id, 'Caso Relacionado', null, caso.Owner.Name, '--  '+caso.Description, caso.OwnerId));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupCases()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupIncidencias(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            List<R1_Incident__c> incidencias = c.Incidencias1__r;
            for(R1_Incident__c inci : incidencias){
                CHIlist.add(new CaseHistoryItem(null, null, inci.CreatedDate, inci.LastModifiedDate, null, null, null, inci.Name, inci.CreatedBy.Name, inci.CreatedById, inci.Id, 'Incidencia', null, inci.Owner.Name, '--  '+inci.R2_INC_ATXT_Reason_description__c, inci.OwnerId));
            }   
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupIncidencias()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
        
        
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupPagos(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R2_Compensation__c> pagos = c.pago__r;
            for(R2_Compensation__c pago : pagos){
                CHIlist.add(new CaseHistoryItem(null, null, pago.CreatedDate, pago.LastModifiedDate, null, null, null, pago.Name, pago.CreatedBy.Name, pago.CreatedById, pago.Id, 'Pago', null, pago.Owner.Name, null, pago.OwnerId));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupPagos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupEntidades(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            List<R2_CLA_Claimant_Entity__c> entidades = c.Entidades_Comunicantes__r;
            for(R2_CLA_Claimant_Entity__c ent : entidades){
                CHIlist.add(new CaseHistoryItem(null, null, ent.CreatedDate, ent.LastModifiedDate, null, null, null, ent.Name, ent.CreatedBy.Name, ent.CreatedById, ent.Id, 'Entidad Comunicante', null, null, null, null));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupEntidades()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupAttachments(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<Attachment> attachments = c.Attachments;
            for(Attachment att : attachments){
                CHIlist.add(new CaseHistoryItem(null, null, att.CreatedDate, att.LastModifiedDate, null, null, null, att.Name, att.CreatedBy.Name, att.CreatedById, att.Id, 'Archivo expediente', null, att.Owner.Name, null, att.OwnerId));
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupAttachments()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void setupEmailAttachment(Case c){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            List<Attachment> attachments = emailAdj;
            for(Attachment att : attachments){
                CHIlist.add(new CaseHistoryItem(null, null, att.CreatedDate, att.LastModifiedDate, null, null, null, att.Name, att.CreatedBy.Name, att.CreatedById, att.Id, 'Archivo email', null, att.Owner.Name, null, att.OwnerId));
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.setupEmailAttachment()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    } 
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void filtroTipo(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            System.debug('chilist:' + CHIlist);
            lstNombreTipos = new List<SelectOption>();
            lstNombreTipos.add(new SelectOption('Todos','Todos'));
            lstNombreTipos.add(new SelectOption('Todos sin tipo Historial','Todos sin tipo Historial'));
            lstNombreTipos.add(new SelectOption('Email','Email'));
            lstNombreTipos.add(new SelectOption('Pago','Pago'));
            lstNombreTipos.add(new SelectOption('Caso Relacionado','Caso Relacionado'));
            lstNombreTipos.add(new SelectOption('Adjunto','Adjunto'));
            lstNombreTipos.add(new SelectOption('Comentario','Comentario'));
            lstNombreTipos.add(new SelectOption('Historial (Automaticas)','Historial (Automaticas)'));
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.filtroTipo()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void filtrarTipo(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            lstChiVisual = new List<CaseHistoryItem>();
            
            if(tipoSelected == 'Todos'){
                lstChiVisual.addAll(CHIlist);
            }else if(tipoSelected == 'Historial (Automaticas)'){
                for(CaseHistoryItem chi : CHIlist){
                    if(chi.itemTypeName == 'Historial' || chi.itemTypeName == 'Historial caso hijo'){
                        System.debug('tipoNameeee' + chi.itemTypeName);
                        lstChiVisual.add(chi);
                    }
                }
            }else if(tipoSelected == 'Todos sin tipo Historial'){
                for(CaseHistoryItem chi : CHIlist){
                    if(chi.itemTypeName != 'Historial' && chi.itemTypeName != 'Historial caso hijo'){
                        System.debug('tipoNameeee' + chi.itemTypeName);
                        lstChiVisual.add(chi);
                    }
                }
            }else if(tipoSelected == 'Adjunto'){
                for(CaseHistoryItem chi : CHIlist){
                    if(chi.itemTypeName == 'Archivo expediente' || chi.itemTypeName == 'Archivo email'){
                        System.debug('tipoNameeee' + chi.itemTypeName);
                        lstChiVisual.add(chi);
                    }
                }
            }else{
                for(CaseHistoryItem chi : CHIlist){
                    if(chi.itemTypeName == tipoSelected){
                        System.debug('tipoNameeee' + chi.itemTypeName);
                        lstChiVisual.add(chi);
                    }
                }
            }
            System.debug('chivisual' + lstChiVisual);
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CaseHistoryController.filtrarTipo()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        } 
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    
    IN:             
    OUT:            
    
    History: 
    <Date>                     <Author>                         <Change Description>
    20/09/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public Class CaseHistoryItem{
        public Datetime createdDate   {get; set;}
        public Date dueDate           {get; set;}
        public String subject         {get; set;}
        public String createdName     {get; set;} 
        public String createdId       {get; set;}
        public String mainId          {get; set;}
        public String itemType        {get; set;}
        public boolean isActivity     {get; set;}
        public String createModifyDateFix   {get; set;}
        public String dueDateFix      {get; set;}
        public String subjectSort     {get; set;}
        public String ownerName       {get; set;}
        public String taskDescription {get; set;}
        public String ownerId         {get; set;}
        public String itemTypeName    {get; set;}
        public Datetime lastModified  {get; set;}
        public String status 		  {get; set;}
        public String category		  {get; set;}
        public String language		  {get; set;}
        public Boolean attach		  {get; set;}
        public String body			  {get; set;}
        
        public CaseHistoryItem(String aBody, Boolean adjunto, Datetime aCreateDate, Datetime aLastModifiedDate, 
                               String aStatus, String aCategory, String aLanguage, String aSubject, String aCreatedName, 
                               String aCreatedId,  String aMainId, String aType, Date aDueDate, String aOwnerName, 
                               String aTaskDesc, String aOwnerId){
            body=aBody;
            attach=adjunto;
            createdDate=aCreateDate;
            subject=aSubject;
            createdName=aCreatedName;
            createdId=aCreatedId;
            status=aStatus;
            category=aCategory;
            language=aLanguage;
            if(aLastModifiedDate != null){
                lastModified=aLastModifiedDate;
                createModifyDateFix=lastModified.format('yyyy/MM/dd -- hh:mm:ss a');
            }else{
                createModifyDateFix=createdDate.format('yyyy/MM/dd -- hh:mm:ss a');
            }
            mainId=aMainId;
            itemType=getTypeImageMap(aType);
            itemTypeName=aType;
            dueDate=aDueDate;
            if(dueDate!=null){
                isActivity=true;
                dueDateFix=dueDate.format(); 
            }
            else 
                isActivity=false;
            ownerName=aOwnerName;
            taskDescription=aTaskDesc;
            ownerId=aOwnerId;
        }
        
        
        /*---------------------------------------------------------------------------------------------------------------------
        Author:         Rubén Pingarrón Jerez
        Company:        Accenture
        Description:    
        IN:             
        OUT:            
        
        History: 
        <Date>                     <Author>                         <Change Description>
        20/09/2017             Rubén Pingarrón Jerez                   Initial Version
        ----------------------------------------------------------------------------------------------------------------------*/
        //this needs to be updated.
        private String getTypeImageMap(String aType){
            if (aType=='History')
                return 'history.png';
            else if(aType=='Comment')
                return 'comment.gif';
            else if(aType=='Email')
                return 'mail.png';
            else
                return 'activity.png';
        }
    }
}