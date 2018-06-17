public with sharing class R2_ACC_CLS_CasesList_CTRL {

	 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Controller of multiple pages that show a table with cases information
    
    History:
    
    <Date>            <Author>          <Description>
    25/09/2017       Alvaro Garcia     	  Initial version
    02/10/2017       Jaime Ascanta        added tabs
    03/10/2017       Jaime Ascanta        added pagination
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

	private String accId;

    public static List<Case> lst_case {get; set;}
    public String url {get;set;}
    public Boolean shouldRedirect {get; set;}
    public Boolean shouldRedirectLink {get;set;}
    public Id rtId;
    public String total;
    public List <Schema.FieldSetMember> lst_fsCase {get;set;}
    public String rtName {get; set;}
    public String rtDeveloperName;
    //public String vfUrl;
    public Boolean todos {get;set;}
    public Integer tam_lst_case {get;set;}
    public String caseNumber_Field {get;set;}
    public String name_Field {get;set;}
    public String relation_sufix_Field {get;set;}

    //Tabs
    public map<String,String> mapTab{get;set;}
    public String tab_selected {get;set;}
    public List<TabsWrapper> listTabs {get; set;}
    public TabsWrapper tabWrapperSelec {get; set;}

    //Pagination
    private Integer counter = 0;
    private Integer list_size = 5;
    public Integer total_size = 0;

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Controller of multiple pages that show a table with cases information
    
    History:
    
    <Date>            <Author>          <Description>
    25/09/2017       Alvaro Garcia     Initial version
    02/10/2017       Jaime Ascanta     set default tab
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public R2_ACC_CLS_CasesList_CTRL(ApexPages.StandardController stdController) {
        
        accId = stdController.getId();
        total = ApexPages.currentPage().getParameters().get('total');
        system.debug('todos= ' + ApexPages.currentPage().getParameters().get('todos'));
        todos = ApexPages.currentPage().getParameters().get('todos')!=null?false:true;
        system.debug('todos= ' + todos);
        system.debug('total: ' + total);
        shouldRedirect = false;
        shouldRedirectLink = false;
        tam_lst_case = 0;
        caseNumber_Field = '.CaseNumber';
        name_Field = '.Name';
        relation_sufix_Field = '__r.Name';

        //Tabs
        generateTabs();
        tab_selected = '1.expediente';//listTabs[0].name;
        //tabWrapperSelec = listTabs[0];

        System.debug('accId : '+ accId);
    }

    public void init(List <Schema.FieldSetMember> lst_fsRTCase) {

    	try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

	        //List<String> lst_campos = new List<String>();

	        String query = 'SELECT Id, CaseNumber, R1_CAS_FOR_Case_Number__c, ';
	        for (Integer i = 0 ; i <= lst_fsRTCase.size()-1; i++) {

                //Se mete en la query los nombres de los campos referentes a look up
                if (lst_fsRTCase[i].getFieldPath().left(lst_fsRTCase[i].getFieldPath().length()-2) == 'Parent') {
                    query += lst_fsRTCase[i].getFieldPath().left((lst_fsRTCase[i].getFieldPath()).length()-2) + '.CaseNumber' + ', ';
                }
                else if (lst_fsRTCase[i].getFieldPath().right(2) == 'Id') {
                    query += lst_fsRTCase[i].getFieldPath().left(lst_fsRTCase[i].getFieldPath().length()-2) + '.Name' + ',';
                }
                else if (lst_fsRTCase[i].getFieldPath().contains('_LOO_')) {
                    query += lst_fsRTCase[i].getFieldPath().left(lst_fsRTCase[i].getFieldPath().length()-3) + '__r.Name' + ',';
                }
	            
                //se rellena la query con todos los campos que se van a mostrar
	            if (i != lst_fsRTCase.size() -1) {
	               query += lst_fsRTCase[i].getFieldPath() + ', ';
	            }

	            else {
	                query += lst_fsRTCase[i].getFieldPath();
	            }

	            //lst_campos.add(lst_fsRTCase[i].getFieldPath());
	        }
	        System.debug('rtDeveloperName: ' + rtDeveloperName);
	        rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = :rtDeveloperName LIMIT 1].Id;
	        query += ' FROM Case WHERE AccountId = :accId AND RecordTypeId = :rtId ORDER BY CreatedDate DESC';

	        System.debug('!!!query: ' + query);
	        lst_case = Database.query(query);
            
            tam_lst_case = lst_case.size();

            //Pagination
            total_size = tam_lst_case;
	        
            System.debug('!!!lst_case: ' + lst_case);
            System.debug('!!!tam_lst_case inicial: ' + tam_lst_case); 

	        //if (total == null) {
	        //    List<Case> lst_casePartial = new List<Case>();
	        //    for (Integer i = 0; i < 5 && i < lst_case.size(); i++) {
	        //        lst_casePartial.add(lst_case[i]);
	        //    }
	        //    lst_case = lst_casePartial;
	        //}

	        if (total == null) {

	            List<Case> lst_casePartial = new List<Case>();
	            for (Integer i = counter; i < counter + list_size && i < total_size; i++) {
	                lst_casePartial.add(lst_case[i]);
	            }
	            lst_case = lst_casePartial;
	        }

	        
	       System.debug('!!!lst_case final: ' + lst_case);
           System.debug('!!!tam_lst_case final: ' + tam_lst_case); 
    	}
    	catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.init()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
		} 
		
    }

    //se crea un metodo por cada RT
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Comunicaciones entrantes
    
    History:
    
    <Date>            <Author>          <Description>
    28/09/2017       Alvaro Garcia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  //  public void initComunicacionEntrante() {
        
  //      try{
  //  		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

	 //       List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Comun_Entrante.getFields();

	 //       //rtName = 'Comunicaciones entrantes';
	 //       //rtDeveloperName = 'R1_Incoming_communications';
	 //       rtName = tabWrapperSelec.label;
	 //       rtDeveloperName = tabWrapperSelec.rtDevName;
	 //       //vfUrl = 'R1_Comun_Entrante';

	 //       init(lst_fsCase);
	 //   }
  //  	catch(Exception exc){
  //			R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initComunicacionEntrante()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
		//} 
  //  }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Comunicaciones entrantes
    
    History:
    
    <Date>            <Author>          <Description>
    27/09/2017       Alvaro Garcia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //public void initExpediente() {
        
    //    try{
    //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

    //        lst_fsCase = Schema.SObjectType.Case.fieldSets.R2_FS_Campos_Caso_RT_Expediente.getFields();

    //        rtName = 'Expediente';
    //        rtDeveloperName = 'R2_File';
    //        //vfUrl = 'R2_Expediente';

    //        init(lst_fsCase);
    //    }
    //    catch(Exception exc){
    //        R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initComunicacionEntrante()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
    //    } 
    //}

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Open the case to be edit
    
    History:
    
    <Date>            <Author>          <Description>
    28/09/2017       Alvaro Garcia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference newCase() {
		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            System.debug('accId : '+ accId);
            url = '/500/e?retURL=' + accId + '&def_account_id=' + accId + '&RecordType=' + rtId + '&ent=Case';
            shouldRedirect = true;
            System.debug('url : '+ url);
            ApexPages.Pagereference p = new ApexPages.Pagereference(url);
        }
    	catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.newCase()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
		}
        return null;
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show all the cases of the RecordType selected
    
    History:
    
    <Date>            <Author>          <Description>
    28/09/2017       Alvaro Garcia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference showAll() {
		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            url = '/apex/R2_ACC_VF_CasesList_R2_Expediente?Id=' + accId + '&total=all&todos=false&rtName=' + mapTab.get(tab_selected) + '&rtDeveloperName=' +  rtDeveloperName;
            shouldRedirectLink = true;
            System.debug('url : '+ url);
            ApexPages.Pagereference p = new ApexPages.Pagereference(url);
        }
    	catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.showAll()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
		}
        return null;
    }

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Jaime Ascanta
    Company:       Accenture
    Description:   hange tab
    
    History:
    
    <Date>            <Author>          <Description>
    02/10/2017       jaime ascanta     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void changeTab() {
        counter = 0;
        list_size = 5;
        total_size = 0;
        loadTabSelected();
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Jaime Ascanta
    Company:       Accenture
    Description:   load the selected tab
    
    History:
    
    <Date>            <Author>          <Description>
    02/10/2017       jaime ascanta     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void loadTabSelected() {
    	System.debug(tab_selected);
        if(tab_selected.equalsIgnoreCase('1.expediente')){
        	lst_fsCase = Schema.SObjectType.Case.fieldSets.R2_FS_Campos_Caso_RT_Expediente.getFields();
System.debug(lst_fsCase);
	        //rtName = 'Expediente';
    	    rtDeveloperName = 'R2_File';
	        rtName = mapTab.get(tab_selected);
	        System.debug('rtDeveloperName exp: ' + rtDeveloperName);
	        System.debug('rtName exp: ' + rtName);//tabWrapperSelec.label;

	        //rtDeveloperName = tabWrapperSelec.rtDevName;
	        //vfUrl = 'R1_Comun_Entrante';

	        init(lst_fsCase);
            //initExpediente();
        }else if(tab_selected.equalsIgnoreCase('2.comunicacion_entrante')){
        	lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Comun_Entrante.getFields();

	        //rtName = 'Comunicaciones entrantes';
	        rtDeveloperName = 'R1_Incoming_communications';
	        rtName = mapTab.get(tab_selected);
	        System.debug('rtDeveloperName inco: ' + rtDeveloperName);
	        System.debug('rtName inco: ' + rtName);//tabWrapperSelec.label;
	        //rtDeveloperName = tabWrapperSelec.rtDevName;
	        //vfUrl = 'R1_Comun_Entrante';

	        init(lst_fsCase);
            //initComunicacionEntrante();
        }//else if(tab_selected.equalsIgnoreCase('asistencia')){
        //    initAsistencias();
        //}else if(tab_selected.equalsIgnoreCase('vuelos_obtencion')){
        //    initVuelos_Obtencion();
        //}else if(tab_selected.equalsIgnoreCase('felicitacion')){
        //    initFelicitacion();
        //}else if(tab_selected.equalsIgnoreCase('iberia_plus')){
        //    initIberia_Plus();
        //}else if(tab_selected.equalsIgnoreCase('vuelos_redención')){
        //    initVuelos_Redencion();
        //}else if(tab_selected.equalsIgnoreCase('iberia_com')){
        //    initIberia();
        //}else if(tab_selected.equalsIgnoreCase('proactividad')){
        //    initProactividad();
        //}else if(tab_selected.equalsIgnoreCase('call_pass')){
        //    initCallPass();
        //}else if(tab_selected.equalsIgnoreCase('reclamacion')){
        //    initReclamacion();
        //}else if(tab_selected.equalsIgnoreCase('transferidas')){
        //    initTransferidas();
        //}else if(tab_selected.equalsIgnoreCase('help_desk')){
        //    initHelp_Desk();
        //}else if(tab_selected.equalsIgnoreCase('campanas_salientes')){
        //    initCampanas_Salientes();
        //}else if(tab_selected.equalsIgnoreCase('salientes')){
        //    initSalientes();
        //}
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Jaime Ascanta
    Company:       Accenture
    Description:   generate tabs
    
    History:
    
    <Date>            <Author>          <Description>
    02/10/2017       jaime ascanta     Initial version
    04/10/2017		 Alvaro Garcia		Change wrapper for map  
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void generateTabs() {
    	mapTab = new map<String,String>();
    	mapTab.put('1.expediente','Expediente');
    	mapTab.put('2.comunicacion_entrante','Comunicacion Entrante');
        //listTabs = new List<TabsWrapper>();
        //listTabs.add(new TabsWrapper('expediente', 'Expediente', 'R2_File'));
        //listTabs.add(new TabsWrapper('comunicacion_entrante', 'Comunicacion Entrante', 'R1_Incoming_communications'));
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Jaime Ascanta
    Company:       Accenture
    Description:   Wrapper for tab items
    
    History:
    
    <Date>            <Author>          <Description>
    02/10/2017       jaime ascanta     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public class TabsWrapper{
        public String name {get; set;}
        public String label {get; set;}
        public String rtDevName {get;set;}
        public TabsWrapper(){}
        public TabsWrapper(String name, String label, String rtDevName){
            this.name = name;
            this.label = label;
            this.rtDevName = rtDevName;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   go to the first page
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference Beginning() { //user clicked beginning
      counter = 0;
      loadTabSelected();
      return null;
   }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   go to the previous page
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      loadTabSelected();
      return null;
   }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   go to the next page
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   public PageReference Next() { //user clicked next button
      counter += list_size;
      loadTabSelected();
      return null;
   }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   go to the last page
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   public PageReference End() { //user clicked end
        if ( total_size < (counter + list_size)) {
            counter = counter - (total_size - list_size - counter);
        }
        else if (math.mod(total_size, list_size) == 0) {
            counter = total_size - list_size;
        }
        else {
            counter = total_size - math.mod(total_size, list_size);
        }
        loadTabSelected();
        return null;
   }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   this will disable the previous and beginning buttons
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   public Boolean getDisablePrevious() {
        if (counter>0){
            return false;
        }  
        else {
            return true;
        }
   }
   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   this will disable the next and end buttons
    
    History:
    
    <Date>                <Author>                <Description>
   20/09/2017           Alvaro Garcia             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
   public Boolean getDisableNext() { 
        if (counter + list_size < total_size){
            return false;
        }  
        else {
            return true;
        }
   }
}