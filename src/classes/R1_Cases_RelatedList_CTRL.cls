public with sharing class R1_Cases_RelatedList_CTRL {

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Controller of multiple pages that show a table with cases information
    
    History:
    
    <Date>            <Author>          <Description>
    12/03/2017       Alvaro Garcia        Initial version
    26/04/2017       Ruben Pingarron      Add try catch of all Methods
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    private String accId;

    public static List<Case> lst_case {get; set;}
    public String url {get;set;}
    public Boolean shouldRedirect {get; set;}
    public Boolean shouldRedirectLink {get;set;}
    public Id rtId;
    public String total;
    public List <Schema.FieldSetMember> lst_fsCase;
    public String rtName {get; set;}
    public String rtDeveloperName;
    public String vfUrl;
    public Boolean todos {get;set;}
    public Integer tam_lst_case {get;set;}
    public String caseNumber_Field {get;set;}
    public String name_Field {get;set;}
    public String relation_sufix_Field {get;set;}

    //public Pagereference urlCase {get;set;}

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Controller of multiple pages that show a table with cases information
    
    History:
    
    <Date>            <Author>          <Description>
    12/03/2017       Alvaro Garcia     Initial version
    26/04/2017       Alvaro Garcia     Add try catch
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public R1_Cases_RelatedList_CTRL(ApexPages.StandardController stdController) {
        
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

        System.debug('accId : '+ accId);
    }

    public void init(List <Schema.FieldSetMember> lst_fsRTCase) {

        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            //List<String> lst_campos = new List<String>();

            String query = 'SELECT Id, CaseNumber, ';
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
            rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = :rtDeveloperName LIMIT 1].Id;
            query += ' FROM Case WHERE AccountId = :accId AND RecordTypeId = :rtId ORDER BY CreatedDate DESC';

            System.debug('!!!query: ' + query);
            lst_case = Database.query(query);
            
            tam_lst_case = lst_case.size();
            
            System.debug('!!!lst_case: ' + lst_case);
            System.debug('!!!tam_lst_case inicial: ' + tam_lst_case); 

            if (total == null) {
                List<Case> lst_casePartial = new List<Case>();
                for (Integer i = 0; i < 5 && i < lst_case.size(); i++) {
                    lst_casePartial.add(lst_case[i]);
                }
                lst_case = lst_casePartial;
            }
            //else if (total == 'all') {
            //    Integer numCases = Integer.valueOf(total);
            //    List<Case> lst_casePartial = new List<Case>();
            //    for (Integer i = 0; i < numCases && i < lst_case.size(); i++) {
            //        lst_casePartial.add(lst_case[i]);
            //    }
            //    lst_case = lst_casePartial; 
            //}
            
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
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Alvaro Garcia     Add try catch
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initComunicacionEntrante() {
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Comun_Entrante.getFields();

            //for (Schema.FieldSetMember fieldset : lst_fsCase) {
            //    if (String.ValueOf(fieldset.getType()) == 'REFERENCE' && String.ValueOf(fieldset.getFieldPath()) != 'RecordTypeId') {
            //        reference_Fields += fieldset + ';';
            //    }
            //}
            //System.debug('reference_Fields: ' + reference_Fields);
//String.valueOf(fsm.getType()

            rtName = 'Comunicaciones entrantes';
            rtDeveloperName = 'R1_Incoming_communications';
            vfUrl = 'R1_Comun_Entrante';

            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initComunicacionEntrante()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Asistencias
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initAsistencias() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Asistencia.getFields(); 
            rtName = 'Asistencia';
            rtDeveloperName = 'R1_Assistance';
            vfUrl = 'R1_Asistencia';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initAsistencias()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Vuelos en Obtencion
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initVuelos_Obtencion() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Vuelos_Obtencion.getFields(); 
            rtName = 'Vuelos en Obtención';
            rtDeveloperName = 'R1_Flights_in_obtaining';
            vfUrl = 'R1_Vuelos_Obtencion';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initVuelos_Obtencion()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Felicitacion
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initFelicitacion() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Felicitaciones.getFields(); 
            rtName = 'Felicitación';
            rtDeveloperName = 'R1_Congratulation';
            vfUrl = 'R1_Felicitaciones';
        
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initFelicitacion()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Programa Iberia Plus
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initIberia_Plus() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Prog_Iberia_Plus.getFields(); 
            rtName = 'Iberia Plus';
            rtDeveloperName = 'R1_Iberia_Plus_Program';
            vfUrl = 'R1_Prog_Iberia_Plus';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initIberia_Plus()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Vuelos en Redencion
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initVuelos_Redencion() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Vuelos_Redencion.getFields(); 
            rtName = 'Vuelos en Redención';
            rtDeveloperName = 'R1_Flights_in_redemption';
            vfUrl = 'R1_Vuelos_Redencion';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initVuelos_Redencion()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }   
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Iberia.com
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initIberia() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
                    
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Iberia.getFields(); 
            rtName = 'Iberia.com';
            rtDeveloperName = 'R1_Iberia_com';
            vfUrl = 'R1_Iberia_com';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initIberia()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }    
            
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Proactividad
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initProactividad() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
             
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Proactividad.getFields(); 
            rtName = 'Proactividad';
            rtDeveloperName = 'R1_Proactivity';
            vfUrl = 'R1_Proactividad';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initProactividad()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Call Pass Through JBA
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initCallPass() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
          
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Call_Pass_JBA.getFields(); 
            rtName = 'Call Pass Through JBA';
            rtDeveloperName = 'R1_Call_Pass_Througth_JBA';
            vfUrl = 'R1_Call_Pass_JBA';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initCallPass()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Reclamacion
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initReclamacion() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
          
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Reclamacion.getFields(); 
            rtName = 'Reclamación';
            rtDeveloperName = 'R1_Claims';
            vfUrl = 'R1_Reclamacion';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initReclamacion()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Transferidas
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initTransferidas() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Transferidas.getFields(); 
            rtName = 'Transferidas';
            rtDeveloperName = 'R1_Transferred';
            vfUrl = 'R1_Transferidas';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initTransferidas()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT HelpDesk
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initHelp_Desk() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
          
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Help_Desk.getFields(); 
            rtName = 'Help Desk OW';
            rtDeveloperName = 'R1_Help_Desk_OW';
            vfUrl = 'R1_Help_Desk';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initHelp_Desk()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Campañas 
    s
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initCampanas_Salientes() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Campanas_Salientes.getFields(); 
            rtName = 'Campañas salientes';
            rtDeveloperName = 'R1_Outbound_campaigns';
            vfUrl = 'R1_Camp_salientes';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initCampanas_Salientes()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Show information of the case with RT Salientes
    
    History:
    
    <Date>            <Author>          <Description>
    07/04/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initSalientes() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            List <Schema.FieldSetMember> lst_fsCase = Schema.SObjectType.Case.fieldSets.R1_FS_Campos_Caso_RT_Salientes.getFields(); 
            rtName = 'Salientes';
            rtDeveloperName = 'R1_Outgoing';
            vfUrl = 'R1_Salientes';
            
            init(lst_fsCase);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.initSalientes()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        } 
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:   Open the case to be edit
    
    History:
    
    <Date>            <Author>          <Description>
    25/03/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
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
    25/03/2017       Alvaro Garcia     Initial version
    26/04/2017       Ruben Pingarron      Add try catch 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public PageReference showAll() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
              
            url = '/apex/R1_ACC_VF_CasesList_' + vfUrl + '?Id=' + accId + '&total=all&todos=false' ;
            shouldRedirectLink = true;
            System.debug('url : '+ url);
            ApexPages.Pagereference p = new ApexPages.Pagereference(url);
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_Cases_RelatedList_CTRL.showAll()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'Account');
        }
        return null;
    }
}