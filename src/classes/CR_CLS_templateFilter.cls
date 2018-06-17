/*---------------------------------------------------------------------------------------------------------------------
Author:         
Company:        Accenture
Description:    
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public class CR_CLS_templateFilter {

    public String errorMsg{get;set;}
    public String validationMsg{get;set;}
    public String idiomaSelected {get; set;}
    public String textoSelected {get; set;}
    public String p3_lkid{get;set;}
    public String p2_lkid{get;set;}
    public String p24{get;set;}
    public String p5{get;set;}
    public String selected{get;set;}
    
    private Integer counter=0;
    public Integer pagIni{get;set;}
    public Integer pagFin{get;set;}
    private Integer list_size = 25;
    private Integer total_size;

    public String query;
    public String espacio{get;set;}
    
     public List<SelectOption> idiomas {get; set;}
    
    public String companySelected {get; set;}
     public List<SelectOption> company {get; set;}
    
    public List<CustomObject> selectedObjects{get;set;}
    public List<CustomObject> listCustomObject{get;set;}
    public List<CustomObject> listCustomObjectParcial{get;set;}
    public List<EmailTemplate> emailTemplate{get;set;}
    public List<EmailTemplate> lstTemplate{get;set;}// = new List<EmailTemplate>();
    public List<EmailTemplate> lstTemplateparcial{get;set;}
    
    //Constructor
    //
    public CR_CLS_templateFilter(){

        p3_lkid = apexpages.currentpage().getparameters().get('p3_lkid');
        p2_lkid = apexpages.currentpage().getparameters().get('p2_lkid');
        p24 = apexpages.currentpage().getparameters().get('p24');
        p5 = apexpages.currentpage().getparameters().get('p5');
        System.debug('Se ha cogido el id de la url: '+ p3_lkid);
        selectedobjects = new List<CustomObject>();
        listCustomObject = new List<CustomObject>();
        //total_size = [SELECT count() FROM EmailTemplate];

       
       // List<Schema.PicklistEntry> lstIdiom = Case.R1_CAS_PKL_Idioma__c.getDescribe().getPicklistValues();     
       List<Schema.PicklistEntry> lstIdiom = new List<Schema.PicklistEntry>(); 
        this.idiomas = new List<SelectOption>();
        this.idiomas.add(new SelectOption('', '-- None --'));
        this.idiomas.add(new SelectOption('ES', 'Español'));
        this.idiomas.add(new SelectOption('DE', 'Aleman'));   
        this.idiomas.add(new SelectOption('CN','Chino'));  
        this.idiomas.add(new SelectOption('EN','Ingles'));  
       this.idiomas.add(new SelectOption('PT','Portugues'));
      this.idiomas.add(new SelectOption('FR','Francés'));
         this.idiomas.add(new SelectOption('IT','Italiano'));
       this.idiomas.add(new SelectOption('JP','Japonés'));
    
        for(Schema.PicklistEntry pickList : lstIdiom){
            System.debug('Paso por aqui');
            SelectOption selectOp = new SelectOption(pickList.getLabel(), pickList.getValue());
            this.idiomas.add(selectOp);
        }
        
        List<Schema.PicklistEntry> lstcompa = new List<Schema.PicklistEntry>(); 
        this.company = new List<SelectOption>();
        this.company.add(new SelectOption('', '-- None --'));
         this.company.add(new SelectOption('I0', 'I0'));
         this.company.add(new SelectOption('IB', 'IB'));
        this.company.add(new SelectOption('I2', 'I2'));
        for(Schema.PicklistEntry pickList : lstcompa){
            SelectOption selectOp = new SelectOption(pickList.getLabel(), pickList.getValue());
            this.company.add(selectOp);
        }
        //emailTemplate = [SELECT Name FROM EmailTemplate
                         //WHERE id = '00X58000000FPEHEA4']; 
        
            //if (emailTemplate.size() == 0 ){
            //    errorMsg = 'No hay documentos que cumplan los criterios';
            //    selectedObjects.clear();   
            //}else{
            //    //Metemos los valores necesarios en el objeto custom creado anteriormente
            //    //Tenemos que meter como parametro el tipo y el subtipo del Case
            //      for (EmailTemplate template : emailTemplate){
            //     listCustomObject.add(new CustomObject(template.Name, template.Name, false));
            //    }
            //}
    }
    
    //Objeto custom que recoge los valores necesarios para tratarlos posteriormente.
    public class CustomObject{
       
            public String templateName{get;set;}
            public String displayName{get;set;}
            public boolean seleccionado{get;set;}
            
            public CustomObject(String displayName, String templateName, boolean seleccionado){
                this.templateName = templateName;
                this.seleccionado = seleccionado;
                this.displayName = displayName;
            }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
    <Date>                     <Author>                         <Change Description>
    18/12/2017                 Ismael Yubero Moreno             Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public  void mostrarTemplate(){
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            listCustomObject.clear();
           
            System.debug('Se van a filtrar los templates por el idioma, la compañia y un texto ' + idiomaSelected);
         /*   if(idiomaSelected == 'Español'){
                idiomaSelected = 'ES';
            }else if(idiomaSelected == 'Aleman'){
                idiomaSelected = 'DE';
            }else if(idiomaSelected == 'Chino'){
                idiomaSelected = 'CN';
            }else if(idiomaSelected == 'Ingles'){
                idiomaSelected = 'EN';
            }else if(idiomaSelected == 'Portugues'){
                idiomaSelected = 'PT';
            }else if(idiomaSelected == 'Francés'){
                idiomaSelected = 'FR';
            }else if(idiomaSelected == 'Italiano'){
                idiomaSelected = 'IT';
            }else if(idiomaSelected == 'Japonés'){
                idiomaSelected = 'JP';
            }*/
            System.debug('Idioma elegido: ' +idiomaSelected);
            System.debug('Compañia elegido: ' +companySelected);
            System.debug('Texto a buscar: ' + textoSelected);
            String language =  null;
            String company =  null;
            String text =  null;
            if(idiomaSelected != null && idiomaSelected != ''){
                language = '% '+ idiomaSelected + ' I%';
            }
            if(companySelected != null && companySelected != ''){
                company = '% ' + companySelected +'%';
            }
            if(textoSelected != null && textoSelected != ''){
                text = '%'+ textoSelected +'%';
            }
            lstTemplate = new List<EmailTemplate>();
            lstTemplate.clear();

            if(language != null && language != '' && company != null && company != '' && text != null && text != ''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE Name LIKE :text AND Name LIKE :language AND Name LIKE :company order by Name];
                System.debug('Lista de Templates');
                System.debug(lstTemplate);
                
            }else if(language != null && language != '' && company != null && company !=''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :language AND Name LIKE :company order by Name];
                System.debug('Lista de Templates');
                System.debug(lstTemplate);
            }else if(language != null && language != '' && text != null && text !=''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :language AND Name LIKE :text order by Name];
                System.debug('Lista de Templates' + lstTemplate);
                System.debug(lstTemplate);
            }else if(text != null && text != '' && company != null && company !=''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :company AND Name LIKE :text order by Name];
                System.debug('Lista de Templates');
                System.debug(lstTemplate);
            }else if(language != null && language != ''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :language order by Name];
                System.debug('Lista de Templates');
                System.debug(lstTemplate.size());
            }else if(company != null && company != ''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :company order by Name];
                System.debug('Lista de Templates company');
                System.debug(lstTemplate.size());
            }else if(text != null && text != ''){
                lstTemplate =  [SELECT ID, Name FROM EmailTemplate WHERE  Name LIKE :text order by Name];
                System.debug('Lista de Templates');
                System.debug(lstTemplate);
            }else{
                //lstTemplate = new List<EmailTemplate>();
                 lstTemplate =  [SELECT ID, Name FROM EmailTemplate order by Name];
                SYstem.debug('se debe completar algun campo para realizar la busqueda');
            }
            
            total_size = lstTemplate.size();
            pagFin = total_size/25;
            pagFin++;
            espacio = ' / ';
            if(lstTemplate.size()!=0){
                for (EmailTemplate template : lstTemplate){
                      listCustomObject.add(new CustomObject(template.Name, template.Id, false));
                }                
                listCustomObjectParcial = new List<CustomObject>();
                system.debug(counter);
                system.debug(counter + list_size);
                pagIni = counter/list_size;
                pagIni++;
                for (Integer i = counter; i < counter + list_size && i < listCustomObject.size(); i++) {
                    listCustomObjectParcial.add(listCustomObject[i]);
                }
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No hay documentos que cumplan los criterios'));
             errorMsg = 'No hay documentos que cumplan los criterios';
                selectedObjects.clear();
            }
            System.debug('Se van a filtrar los templates por el idioma, la compañia y un texto ' + idiomaSelected);
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.mostrarTemplate()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    
    
     public void mostrarCasos(){ 
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            System.debug('Ejecuto Mostrar Casos ');
            query ='';
            if (idiomaSelected != null || companySelected != null ) {

                query += 'SELECT Name FROM EmailTemplate ';
               


                if (idiomaSelected != null && idiomaSelected != '') {
                 //   query += ' WHERE EmailTemplate.Name LIKE \'%'+idiomaSelected+'%\'';
                      if (companySelected != null && companySelected != ''){
                 //       query += ' AND EmailTemplate.Name LIKE \'%'+companySelected+'%\'';
                    }
                }else{
                    if (companySelected != null && companySelected != ''){
                   //     query += ' WHERE EmailTemplate.Name LIKE \'%'+companySelected+'%\'';
                    }
                }
                
            } else {
                query += 'SELECT Name FROM EmailTemplate LIMIT 1';
            }

            System.debug('mostrarCasos query->'+query);
            
            List<EmailTemplate> templateMostrados = Database.query(query);
  
            //casesToShow = new List<CaseTableItem>();
            
            if (!templateMostrados.isEmpty()) {
                for (EmailTemplate template : templateMostrados) {
                       listCustomObject.add(new CustomObject(template.Name, template.Name, false));
                 //   casesToShow.add(new CaseTableItem(template.Name));
                }
            }
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.mostrarCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    //Método que recoge en una lista los valores seleccionados.
    public PageReference getSelected(){   
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            System.debug('Se ha escogido el seleccionado');
            List<String> listMode = new List<String>();
            Integer principal = 0;
            selectedObjects.clear(); 
            for(CustomObject co : listCustomObject)  {  
                if(co.seleccionado == true) { 
                   selected = co.templateName;
                   //selectedObjects.add(co);  
                    
                }
            }
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.getSelected()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
        return null;        
    }
    
    
    
    //Metodo que permite al usuario volver a la ventana anterior.
    public PageReference GoBack(){
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            String caseID = '';
            if(caseID != null){
                return new PageReference('/'+caseID);
            }
            else{
                return null;
            }
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.GoBack()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
   }

       /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   go to the first page
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018           Sara Torres             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference Beginning() { //user clicked beginning
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            counter = 0;
            mostrarTemplate();
            
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.Beginning()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
        return null;
   }
 
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   go to the previous page
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018            Sara Torres             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference Previous() { //user clicked previous button
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            counter -= list_size;
            mostrarTemplate();
            
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.Previous()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
        return null;
   }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   go to the next page
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018           Sara Torres             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference Next() { //user clicked next button
       try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            system.debug('siguiente');
            counter += list_size;
            system.debug(counter);
            mostrarTemplate();
            
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.Next()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
        return null;
   }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   go to the last page
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018           Sara Torres             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference End() { //user clicked end
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            system.debug('end' + total_size);
            system.debug('end' + counter);
            if ( total_size < (counter + list_size)) {
                system.debug('if');
                counter = counter - (total_size - list_size - counter);
            }else if (math.mod(total_size, list_size) == 0) {
                system.debug('else if');
                counter = total_size - list_size;
            }
            else {
                system.debug('else');
                counter = total_size - math.mod(total_size, list_size);
                system.debug(counter);
            }
            mostrarTemplate();
        }catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('CR_CLS_templateFilter.End()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
        return null;
   }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   this will disable the previous and beginning buttons
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018          Sara Torres                Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   /*public Boolean getDisablePrevious() {
    
        if (counter>0){
            return false;
        }  
        else {
            return true;
        }
   }*/

   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   this will disable the next and end buttons
    
    History:
    
    <Date>                <Author>                <Description>
   09/01/2018          Sara Torres             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

   /*public Boolean getDisableNext() {
       system.debug('next');
       if (counter + list_size < total_size){
           return false;
       }else {
           return true;
       }
   }*/
}