public with sharing class R2_INFO_CKI_PasaList_CTRL {
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres Bermúdez
    Company:       Accenture
    Description:   controladora de la visual: R2_INFO_CKI_VF_PasaList.vfp, en cada uno de los vuelos mostramos una tabla con todos los pasajeros que tiene el vuelo,
					para cada uno de los pasajeros podemos crear incidencias. Sera una unica incidencia que clonaremos para todos los pasajeros que esten seleccionados
					con el checkbox a true.
    
    History:
    
    <Date>          	  <Author>        			  <Description>
	07/09/2017			Sara Torres Bermúdez			Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	private String vueloId;
    
    public List <Schema.FieldSetMember> lst_fsPasajeros;
    public String query;

    public String nombre {get; set;}

    public Boolean check {get; set;}
    public Boolean mostrarInc {get; set;}
    public Boolean refreshPag {get; set;}
    public Boolean displayPopup {get;set;}

    
    public R1_Incident__c incident {get; set;}
    
    // pruebas para el checkall:
    private Integer counter = 0;
    private Integer list_size = 25;
    public Integer total_size;

    public List<pasajeroswrapper> pasajerosListWP {get; set;}
    List<R2_CKI_Info__c> selectedPasajeros;
    
    public class pasajeroswrapper {
        public R2_CKI_Info__c pasajeros {get; set;}
        public Boolean selected {get; set;}
        //constructor del WP
        public pasajeroswrapper(R2_CKI_Info__c p){
            pasajeros = p;
            selected = false;
        }
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:  
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   07/09/2017			Sara Torres 			Initial Version
   20/09/2017           Alvaro Garcia           get the list of total passengers for the flight and fill the list of wrappers 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public R2_INFO_CKI_PasaList_CTRL(ApexPages.StandardController stdController) {
                
        vueloId = stdController.getId();
        mostrarInc = False;
        refreshPag = False;
        nombre = 'Pasajeros';
        total_size = [SELECT count() FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId];
        

        lst_fsPasajeros = Schema.SObjectType.R2_CKI_info__c.fieldSets.R2_FS_Campos_Info_CKI_RT_Pasajeros_Vuelo.getFields();

        String query = 'SELECT id, R2_CKI_LOO_Account__r.IsPersonAccount, ';
        for (Integer i = 0 ; i < lst_fsPasajeros.size(); i++) {
            if (i != lst_fsPasajeros.size() -1) {
                   query += lst_fsPasajeros[i].getFieldPath() + ', ';
            }else {
                query += lst_fsPasajeros[i].getFieldPath();
            }
        }
        query += ' FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId ORDER BY CreatedDate';

        List<R2_CKI_info__c> lst_Pasajeros = Database.query(query); //[SELECT Id, R2_CKI_LOO_Account__r.IsPersonAccount, R2_CKI_info__c.Name, R2_CKI_LOO_Account__r.Name, R2_CKI_TXT_Operative_company__c, 
                        //R2_CKI_NUM_Incident_code__c, R2_CKI_TEX_Ticket_number__c FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId ORDER BY CreatedDate];// ASC LIMIT :list_size OFFSET :counter];//Database.query(query);    
        

        if(pasajerosListWP == null) {
            pasajerosListWP = new List<pasajeroswrapper>();
            for(R2_CKI_Info__c pas : lst_Pasajeros){
                pasajerosListWP.add(new pasajeroswrapper(pas));
            }
        }

        //String query = 'SELECT id, R2_CKI_LOO_Account__r.IsPersonAccount, ';
        
        //for (Integer i = 0 ; i < lst_fsPasajeros.size(); i++) {
        //    if (i != lst_fsPasajeros.size() -1) {
        //           query += lst_fsPasajeros[i].getFieldPath() + ', ';
        //    }else {
        //        query += lst_fsPasajeros[i].getFieldPath();
        //    }
        //}

        //query += ' FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId ORDER BY CreatedDate ASC LIMIT :list_size OFFSET :counter]';
        //initPasajeros();
        //controllerWP();
 	}

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:  sacamos los valores del FieldSet para mostrarlos en la tabla
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   07/09/2017			Sara Torres 			Initial Version
   20/09/2017           Alvaro Garcia           modified to get the partial pasangers to show in the vf 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 
      public List<pasajeroswrapper> getPasajerosListParcial() {
      	try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            //nombre = 'Pasajeros';
            //lst_fsPasajeros = Schema.SObjectType.R2_CKI_info__c.fieldSets.R2_FS_Campos_Info_CKI_RT_Pasajeros_Vuelo.getFields();

            //String query = 'SELECT id, R2_CKI_LOO_Account__r.IsPersonAccount, ';
            //for (Integer i = 0 ; i < lst_fsPasajeros.size(); i++) {
            //    if (i != lst_fsPasajeros.size() -1) {
            //           query += lst_fsPasajeros[i].getFieldPath() + ', ';
            //    }else {
            //        query += lst_fsPasajeros[i].getFieldPath();
            //    }
            //}

            List<pasajeroswrapper> pasajerosListParcial = new List<pasajeroswrapper>();

            if (!pasajerosListWP.isEmpty()) {
                for (Integer i = counter; i < counter + list_size && i < pasajerosListWP.size(); i++) {
                    pasajerosListParcial.add(pasajerosListWP[i]);
                }
            }
            
            //query += ' FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId]';

            //List<R2_CKI_info__c> lst_pasajeros = [SELECT Id, R2_CKI_LOO_Account__r.IsPersonAccount, R2_CKI_info__c.Name, R2_CKI_LOO_Account__r.Name, R2_CKI_TXT_Operative_company__c, 
            //            R2_CKI_NUM_Incident_code__c, R2_CKI_TEX_Ticket_number__c FROM R2_CKI_info__c WHERE R2_CKI_LOO_Flight__c = :vueloId ORDER BY CreatedDate];// ASC LIMIT :list_size OFFSET :counter];//Database.query(query);
          
            //System.debug('lista de pasajeros, query: ' + lst_pasajeros);

            return pasajerosListParcial;

        }catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R2_INFO_CKI_PasaList_CTRL.getPasajerosListParcial()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'R2_CKI_Info__c');
		    return null;
        }
    }



     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:  creamos una primera incidencia que sera la que luego podamos clonar al resto de pasajeros
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   08/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void initIncidencia(){
        try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
         	//lst_fsIncidencia = Schema.SObjectType.R1_Incident__c.fieldSets.R2_FS_Campos_Incidencia_Masiva_Edicion.getFields();
            nombre = 'Incidencia Edit';
            
            incident = new R1_Incident__c();
            
            incident.R2_INC_LOO_Flight__c = vueloId;
		    Id rtIdInciIndiv = [SELECT Id FROM RecordType WHERE sObjectType = 'R1_Incident__c' AND Name = 'Incidencia Individual' LIMIT 1].Id;  
            incident.RecordTypeId = rtIdInciIndiv;     
         }catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R2_INFO_CKI_PasaList_CTRL.initIncidencia()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'R2_CKI_Info__c');
		}
    }
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:  creamos la incidencia si hay algun pasajero seleccionado, 
					para ello creamos una nueva lista que solo tenga los pasajeros que se va a crear la incidencia
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   08/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    
    public void crearIncidencia() {
		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            selectedPasajeros = new List<R2_CKI_Info__c>();

            for(pasajeroswrapper pasWP: pasajerosListWP){
                if(pasWP.selected){
                    mostrarInc = true;
                    selectedPasajeros.add(pasWP.pasajeros);
                }
            }
            if(selectedPasajeros.isEmpty()){
                displayPopup = true;
            }
            initIncidencia();
            system.debug('!!!se pone a true');

    	 }catch(Exception exc){
  			R1_CLS_LogHelper.generateErrorLog('R2_INFO_CKI_PasaList_CTRL.crearIncidencia()', ApexPages.currentPage().getParameters().get('Id'), exc.getmessage()+', '+exc.getLineNumber() , 'R2_CKI_Info__c');
		}
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   Una vez guardada la incidencia, mostramos de nuevo la tabla de pasajeros
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   18/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void refrescarVF(){
        try{
            mostrarInc = False;
            for(pasajeroswrapper pasWP: pasajerosListWP){
                pasWP.selected = False;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_IncidentTriggerMethods.refrescarVF()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:  Guardarmos la incidencia y la clonamos para todos los pasajeros con el check = true
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   15/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public void saveIncidencia(){
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            List<R1_Incident__c> lst_incidencia = new List<R1_Incident__c>();
            for(R2_CKI_info__c selecPasajeros: selectedPasajeros){
                R1_Incident__c incClone = incident.clone(false, false, false, false);
                incClone.R1_INC_LOO_II_Client__c = selecPasajeros.R2_CKI_LOO_Account__c;
                lst_incidencia.add(incClone); 
            }
            if (!lst_incidencia.isEmpty()) {
                insert lst_incidencia;
            }
             //refrescar toda la pagina
             refrescarVF();
         }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_IncidentTriggerMethods.saveIncidencia()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   cancelar la creaccion de la incidencia, volviendo a la tabla de pasajeros
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   14/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    
    public void cancelIncidencia(){
        mostrarInc = false;
    } 
   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   cerrar el pop up
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   18/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    // public void closePopup() {
    //    displayPopup = false;
    //}
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres
    Company:       Accenture
    Description:   volver a la misma url antes de dar al bton
    
    History:
    
    <Date>         	 	  <Author>        		  <Description>
   18/09/2017			Sara Torres 			Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	public void redirectPopup() {
    	displayPopup = false;
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