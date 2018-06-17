/*---------------------------------------------------------------------------------------------------------------------
Author:
Company:        Accenture
Description:
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
17/10/2017                   UPH                              Initial Version
----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_caseFilteredReport_CTRL {
    //variables donde se guarda lo introducido por el usuario
    public String nombreCampanaSelected {get; set;}
    public String identificadorSelected {get; set;}
    public String respuestaSegmento1Selected {get; set;}
    public String respuestaSegmento2Selected {get; set;}
    public String resultadoSegmento1Selected {get; set;}
    public String resultadoSegmento2Selected {get; set;}
    public String motivoSegmento1Selected {get; set;}
    public String motivoSegmento2Selected {get; set;}
    public String respuestaS1yS2Selected {get; set;}
    public Date fechaCreacionSelected {get; set;}
    public String franjaHorariaSelected {get; set;}
	public String paisSeEncuentraSelected {get; set;}
	public String idiomaSelected {get; set;}
    public String aviosCashSelected {get; set;}
	public String nivelTarjetaSelected {get; set;}
	public String origenSegm1Selected {get; set;}
	public String destinoSegm1Selected {get; set;}
	public Date fechaVueloSegm1Selected {get; set;}
    public String dineroBus1Selected {get; set;}
    public String dineroTP1Selected {get; set;}
    public String aviosBus1Selected {get; set;}
    public String aviosTP1Selected {get; set;}
	public String origenSegm2Selected {get; set;}
	public String destinoSegm2Selected {get; set;}
	public Date fechaVueloSegm2Selected {get; set;}
    public String dineroBus2Selected {get; set;}
    public String dineroTP2Selected {get; set;}
    public String aviosBus2Selected {get; set;}
    public String aviosTP2Selected {get; set;}
    public String respuestaSelected {get; set;}
    public String dineroOtrosSelected {get; set;}
    public String aviosOtrosSelected {get; set;}
    public String estadoSelected {get; set;}

    public String localizadorResiber {get; set;} //R2_CAS_TXT_Resiber_Locator__c
    public String localizadorAmadeus {get; set;} //R2_CAS_TXT_Amadeus_Locator__c
    public String clienteCaso {get; set;} //??? ACCOUNT NAME standar


	//valores de las picklist
	public List<SelectOption> respuestaSegmento1 {get; set;}
    public List<SelectOption> respuestaSegmento2 {get; set;}
    public List<SelectOption> resultadoSegmento1 {get; set;}
    public List<SelectOption> resultadoSegmento2 {get; set;}
    public List<SelectOption> motivoSegmento1 {get; set;}
    public List<SelectOption> motivoSegmento2 {get; set;}
    public List<SelectOption> respuestaS1yS2 {get; set;}
    public List<SelectOption> paisSeEncuentra {get; set;}
    public List<SelectOption> idiomas {get; set;}
    public List<SelectOption> aviosCash {get; set;}
    public List<SelectOption> nivelTarjeta {get; set;}
    public List<SelectOption> franjaHorariaCombo {get; set;}
    public List<SelectOption> estadoPkCaso {get; set;}
    public List<SelectOption> respuesta {get; set;}

    public String estadoCaso {get; set;}

    public List<CaseTableItem> casesToShow {get; set;}

    public String query;
    public String ordenacionSentido;
    public String fieldNameAPI {get; set;}

    public Campaign campanha {get;set;}


    public R2_CLS_caseFilteredReport_CTRL(ApexPages.StandardController cont){
    	//el constructor carga las los valores para las listas desplegables (picklist)
    	System.debug(LoggingLevel.Info, 'ejecutando R2_CLS_caseFilteredReport_CTRL');
    	//nuevo filtrado de las picklist
    	Set<String> ResultadosS1 = new Set<String>();
    	Set<String> ResultadosS2 = new Set<String>();
    	Set<String> MotivosS1 = new Set<String>();
    	Set<String> MotivosS2 = new Set<String>();
    	Set<String> IdiomasFiltro = new Set<String>();
    	Set<String> PaisesFiltro = new Set<String>();
    	Set<String> EstadosFiltro = new Set<String>();
    	this.campanha = (Campaign)cont.getRecord();
    	//Filtrado dinámico
    	List<Case> casosPorCampanha = [select id,R2_CAS_PK_resul__c,R2_CAS_PK_Reason__c,R2_CAS_PK_resul_Seg2__c,R2_CAS_PK_Reason_Seg2__c,R2_CAS_LOO_Campaigns__c, R1_CAS_PKL_Idioma__c, R2_CAS_PKL_Country__c, Status from case where R2_CAS_LOO_Campaigns__c =: this.campanha.id ];
    	for (Case caso:casosPorCampanha){
    		if (caso.R2_CAS_PK_resul__c!=null && !ResultadosS1.contains(caso.R2_CAS_PK_resul__c)){
    			ResultadosS1.add(caso.R2_CAS_PK_resul__c);
    		}
    		if (caso.R2_CAS_PK_resul_Seg2__c!=null && !ResultadosS2.contains(caso.R2_CAS_PK_resul_Seg2__c)){
    			ResultadosS2.add(caso.R2_CAS_PK_resul_Seg2__c);
    		}
    		if (caso.R2_CAS_PK_Reason__c!=null && !MotivosS1.contains(caso.R2_CAS_PK_Reason__c)){
    			MotivosS1.add(caso.R2_CAS_PK_Reason__c);
    		}
    		if (caso.R2_CAS_PK_Reason_Seg2__c!=null && !MotivosS2.contains(caso.R2_CAS_PK_Reason_Seg2__c)){
    			MotivosS2.add(caso.R2_CAS_PK_Reason_Seg2__c);
    		}
    		if (caso.R2_CAS_PKL_Country__c!=null && !PaisesFiltro.contains(caso.R2_CAS_PKL_Country__c)){
    			PaisesFiltro.add(caso.R2_CAS_PKL_Country__c);
    		}
    		if (caso.R1_CAS_PKL_Idioma__c!=null && !IdiomasFiltro.contains(caso.R1_CAS_PKL_Idioma__c)){
    			IdiomasFiltro.add(caso.R1_CAS_PKL_Idioma__c);
    		}
    		if (caso.Status!=null && !EstadosFiltro.contains(caso.Status)){
    			EstadosFiltro.add(caso.Status);
    		}
    	}

        Schema.DescribeFieldResult fieldResultResp1 = Case.R2_CAS_PK_answer__c.getDescribe();
        List<Schema.PicklistEntry> lstResp = fieldResultResp1.getPicklistValues();
        this.respuestaSegmento1 = new List<SelectOption>();
        this.respuestaSegmento1.add(new SelectOption('', '-- None --'));
	    for(Schema.PicklistEntry pickList : lstResp){
			SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
			this.respuestaSegmento1.add(selectOp);
	    }
        Schema.DescribeFieldResult fieldResultResp2 = Case.R2_CAS_PK_answer_Seg2__c.getDescribe();
        List<Schema.PicklistEntry> lstResp2 = fieldResultResp2.getPicklistValues();
        this.respuestaSegmento2 = new List<SelectOption>();
        this.respuestaSegmento2.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstResp2){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.respuestaSegmento2.add(selectOp);
        }
        //filtrado dinamico de R2_CAS_PK_resul__c
        Schema.DescribeFieldResult fieldResultResult1 = Case.R2_CAS_PK_resul__c.getDescribe();
        List<Schema.PicklistEntry> lstResult = fieldResultResult1.getPicklistValues();
        this.resultadoSegmento1 = new List<SelectOption>();
        this.resultadoSegmento1.add(new SelectOption('', '-- None --'));
        for (String resultado1 : ResultadosS1){
	        for(Schema.PicklistEntry pickList : lstResult){
	        	if (resultado1.equals(pickList.getValue())){
		            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
		            this.resultadoSegmento1.add(selectOp);
	        	}
	        }
        }
        //filtrado dinamico de R2_CAS_PK_resul_Seg2__c
        Schema.DescribeFieldResult fieldResultResult2 = Case.R2_CAS_PK_resul_Seg2__c.getDescribe();
        List<Schema.PicklistEntry> lstResult2 = fieldResultResult2.getPicklistValues();
        this.resultadoSegmento2 = new List<SelectOption>();
        this.resultadoSegmento2.add(new SelectOption('', '-- None --'));
        if (!ResultadosS2.isEmpty()){
	        for (String resultado2 : ResultadosS2){
		        for(Schema.PicklistEntry pickList : lstResult2){
					if (resultado2.equals(pickList.getValue())){
			            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
			            this.resultadoSegmento2.add(selectOp);
					}
		        }
	        }
        }
		//filtrado dinamico de R2_CAS_PK_Reason__c
        List<Schema.PicklistEntry> motivoResult = Case.R2_CAS_PK_Reason__c.getDescribe().getPicklistValues();
        this.motivoSegmento1 = new List<SelectOption>();
        this.motivoSegmento1.add(new SelectOption('', '-- None --'));
        if (!MotivosS1.isEmpty()){
        for (String motivo1 : MotivosS1){
	        for(Schema.PicklistEntry pickList : motivoResult){
	        	if (motivo1.equals(pickList.getValue())){
		            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
		            this.motivoSegmento1.add(selectOp);
	        	}
	        }
        }
        }
        //filtrado dinamico de R2_CAS_PK_Reason_Seg2__c
        List<Schema.PicklistEntry> motivoResult2 = Case.R2_CAS_PK_Reason_Seg2__c.getDescribe().getPicklistValues();
        this.motivoSegmento2 = new List<SelectOption>();
        this.motivoSegmento2.add(new SelectOption('', '-- None --'));
        if (!MotivosS2.isEmpty()){
        for (String motivo2 : MotivosS2){
	        for(Schema.PicklistEntry pickList : motivoResult2){
	        	if (motivo2.equals(pickList.getValue())){
		            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
		            this.motivoSegmento2.add(selectOp);
	        	}
	        }
        }
        }
        //franja horaria de contacto R2_CAS_PKL_time_zone__c
        List<Schema.PicklistEntry> franjaHorariaResultResult = Case.R2_CAS_PKL_time_zone__c.getDescribe().getPicklistValues();
        this.franjaHorariaCombo = new List<SelectOption>();
        this.franjaHorariaCombo.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : franjaHorariaResultResult){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.franjaHorariaCombo.add(selectOp);
        }
        //filtrado dinamico de pais R2_CAS_PKL_Country__c
        //filtrado dinamico de idioma R1_CAS_PKL_Idioma__c

        List<Schema.PicklistEntry> respuestaResult = Case.R2_CAS_PK_answer_S1S2__c.getDescribe().getPicklistValues();
        this.respuestaS1yS2 = new List<SelectOption>();
        this.respuestaS1yS2.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : respuestaResult){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.respuestaS1yS2.add(selectOp);
        }
        List<Schema.PicklistEntry> paisResult = Case.R2_CAS_PKL_Country__c.getDescribe().getPicklistValues();
        this.paisSeEncuentra = new List<SelectOption>();
        this.paisSeEncuentra.add(new SelectOption('', '-- None --'));
        if (!PaisesFiltro.isEmpty()){
	        for (String pais : PaisesFiltro){
		        for(Schema.PicklistEntry pickList : paisResult){
		            if (pais.equals(pickList.getValue())){
			            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
			            this.paisSeEncuentra.add(selectOp);
		            }
		        }
	        }
        }
        List<Schema.PicklistEntry> lstIdiom = Case.R1_CAS_PKL_Idioma__c.getDescribe().getPicklistValues();
        this.idiomas = new List<SelectOption>();
        this.idiomas.add(new SelectOption('', '-- None --'));
        if (!IdiomasFiltro.isEmpty()){
	        for (String idioma : IdiomasFiltro){
		        for(Schema.PicklistEntry pickList : lstIdiom){
		        	if (idioma.equals(pickList.getValue())){
			            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
			            this.idiomas.add(selectOp);
		        	}
		        }
	        }
        }
        List<Schema.PicklistEntry> lstAviosCash = Case.R2_CAS_PK_Avios_Cash__c.getDescribe().getPicklistValues();
        this.aviosCash = new List<SelectOption>();
        this.aviosCash.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstAviosCash){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.aviosCash.add(selectOp);
        }
        List<Schema.PicklistEntry> lstrespuesta = Case.R2_CAS_PK_answer_S1S2__c.getDescribe().getPicklistValues();
        this.respuesta = new List<SelectOption>();
        this.respuesta.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstrespuesta){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.respuesta.add(selectOp);
        }
        List<Schema.PicklistEntry> lstNiveles = Account.R1_ACC_PKL_Card_Type__c.getDescribe().getPicklistValues();
        this.nivelTarjeta = new List<SelectOption>();
        this.nivelTarjeta.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstNiveles){
            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
            this.nivelTarjeta.add(selectOp);
        }
        //estadoPkCaso estadoSelected
        List<Schema.PicklistEntry> lstEstados = Case.Status.getDescribe().getPicklistValues();
        this.estadoPkCaso = new List<SelectOption>();
        this.estadoPkCaso.add(new SelectOption('', '-- None --'));
        if (!EstadosFiltro.isEmpty()){
	        for (String estado : EstadosFiltro){
		        for(Schema.PicklistEntry pickList : lstEstados){
		        	if (estado.equals(pickList.getValue())){
			            SelectOption selectOp = new SelectOption(pickList.getValue(), pickList.getLabel());
			            this.estadoPkCaso.add(selectOp);
		        	}
		        }
	        }
        }

    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         UPH
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	17/10/2017                   UPH                              Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    public void mostrarCasos(){
    	System.debug(LoggingLevel.Info, 'mostrarCasos Method');
        try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Id caseRecordType= [SELECT Id FROM RecordType WHERE SObjectType='Case' AND DeveloperName='R1_Outbound_campaigns'].Id;

            String campanhaId = this.campanha.id;

            query = '';

            if (clienteCaso!=null || nombreCampanaSelected != null || identificadorSelected != null || respuestaSegmento1Selected != null || respuestaSegmento2Selected != null || resultadoSegmento1Selected != null ||
                resultadoSegmento2Selected != null || motivoSegmento1Selected != null || motivoSegmento2Selected != null || respuestaS1yS2Selected != null || fechaCreacionSelected != null ||
                franjaHorariaSelected != null || paisSeEncuentraSelected != null || idiomaSelected != null || aviosCashSelected != null || nivelTarjetaSelected != null || origenSegm1Selected != null ||
                destinoSegm1Selected != null || fechaVueloSegm1Selected != null || dineroBus1Selected != null || dineroTP1Selected != null || aviosBus1Selected != null || aviosTP1Selected != null ||
                origenSegm2Selected != null || destinoSegm2Selected != null || fechaVueloSegm2Selected != null || dineroBus2Selected != null || dineroTP2Selected != null || aviosBus2Selected != null ||
                aviosTP2Selected != null || dineroOtrosSelected != null || aviosOtrosSelected != null || estadoSelected != null) {

                query += 'SELECT R2_CAS_LOO_Campaigns__r.Name, Id, CaseNumber, R1_CAS_FOR_Case_Number__c, R2_CAS_PK_answer__c, R2_CAS_PK_answer_Seg2__c, R2_CAS_PK_resul__c, ';
                query += 'R2_CAS_PK_resul_Seg2__c, R2_CAS_PK_Reason__c, R2_CAS_PK_Reason_Seg2__c, R2_CAS_PK_answer_S1S2__c, CreatedDate, R2_CAS_TXT_Contact_schedule__c, R2_CAS_PKL_time_zone__c, R2_CAS_PKL_Country__c, ';
                query += 'R1_CAS_PKL_Idioma__c, R2_CAS_PK_Avios_Cash__c, R1_CAS_FOR_Card_Type__c, R2_CAS_TXT_segment1_origin__c, R2_CAS_TXT_destination_segment1__c, R2_CAS_DAT_date_flight_segment1__c, ';
                query += 'R2_CAS_NUM_cash_bus_seg1__c, R2_CAS_NUM_cash_TP_seg1__c, R2_CAS_NUM_avios_bus_seg1__c, R2_CAS_NUM_avios_TP_seg1__c, R2_CAS_TXT_segment2_origin__c, ';
                query += 'R2_CAS_TXT_destination_segment2__c, R2_CAS_DAT_date_flight_segment2__c, R2_CAS_NUM_cash_bus_seg2__c, R2_CAS_NUM_cash_TP_seg2__c, R2_CAS_NUM_avios_bus_seg2__c, ';
                query += 'R2_CAS_NUM_avios_TP_seg2__c, R2_CAS_NUM_cash_bus_other__c, R2_CAS_NUM_avios_bus_others__c, R2_CAS_TXT_flight_number_segment1__c, R2_CAS_TXT_flight_number_segment2__c,Contact.Name, Status FROM Case WHERE RecordTypeId=:caseRecordType AND R2_CAS_LOO_Campaigns__c =: campanhaId ';

				if ( clienteCaso!= null &&  clienteCaso!= '') {
                    query += ' AND Contact.Name LIKE \'%'+clienteCaso+'%\'';
                }
                if (nombreCampanaSelected != null && nombreCampanaSelected != '') {
                    query += ' AND R2_CAS_LOO_Campaigns__r.Name LIKE \'%'+nombreCampanaSelected+'%\'';
                }
                if (identificadorSelected != null && identificadorSelected != '') {
                    query += ' AND CaseNumber LIKE \'%'+identificadorSelected+'%\'';
                }
                if (respuestaSegmento1Selected != null) {
                    query += ' AND R2_CAS_PK_answer__c = :respuestaSegmento1Selected';
                }
                if (respuestaSegmento2Selected != null) {
                    query += ' AND R2_CAS_PK_answer_Seg2__c = :respuestaSegmento2Selected';
                }
                if (resultadoSegmento1Selected != null) {
                    query += ' AND R2_CAS_PK_resul__c = :resultadoSegmento1Selected';
                }
                if (resultadoSegmento2Selected != null) {
                    query += ' AND R2_CAS_PK_resul_Seg2__c = :resultadoSegmento2Selected';
                }
                if (motivoSegmento1Selected != null) {
                    query += ' AND R2_CAS_PK_Reason__c = :motivoSegmento1Selected';
                }
                if (motivoSegmento2Selected != null) {
                    query += ' AND R2_CAS_PK_Reason_Seg2__c = :motivoSegmento2Selected';
                }
                if (respuestaS1yS2Selected != null) {
                    query += ' AND R2_CAS_PK_answer_S1S2__c = :respuestaS1yS2Selected';
                }
                if (fechaCreacionSelected != null) {
                    query += ' AND DAY_ONLY(CreatedDate) = :fechaCreacionSelected';
                }
                /*
                if (franjaHorariaSelected != null && franjaHorariaSelected != '') {
                    query += ' AND R2_CAS_TXT_Contact_schedule__c LIKE \'%'+franjaHorariaSelected+'%\'';
                }*/
                if (franjaHorariaSelected != null && franjaHorariaSelected != '') {
                    query += ' AND R2_CAS_PKL_time_zone__c =: franjaHorariaSelected';
                }
                if (paisSeEncuentraSelected != null) {
                    query += ' AND R2_CAS_PKL_Country__c = :paisSeEncuentraSelected';
                }
                if (idiomaSelected != null) {
                    query += ' AND R1_CAS_PKL_Idioma__c = :idiomaSelected';
                }
                if (aviosCashSelected != null) {
                    query += ' AND R2_CAS_PK_Avios_Cash__c = :aviosCashSelected';
                }
                if (nivelTarjetaSelected != null) {
                    query += ' AND R1_CAS_FOR_Card_Type__c = :nivelTarjetaSelected';
                }
                if (origenSegm1Selected != null && origenSegm1Selected != '') {
                    query += ' AND R2_CAS_TXT_segment1_origin__c LIKE \'%'+origenSegm1Selected+'%\'';
                }
                if (destinoSegm1Selected != null && destinoSegm1Selected != '') {
                    query += ' AND R2_CAS_TXT_destination_segment1__c LIKE \'%'+destinoSegm1Selected+'%\'';
                }
                if (fechaVueloSegm1Selected != null) {
                    query += ' AND R2_CAS_DAT_date_flight_segment1__c = :fechaVueloSegm1Selected';
                }
                if (dineroBus1Selected != null && dineroBus1Selected != '') {
                    query += ' AND R2_CAS_NUM_cash_bus_seg1__c = ' + dineroBus1Selected;
                }
                if (dineroTP1Selected != null && dineroTP1Selected != '') {
                    query += ' AND R2_CAS_NUM_cash_TP_seg1__c = ' + dineroTP1Selected;
                }
                if (aviosBus1Selected != null && aviosBus1Selected != '') {
                    query += ' AND R2_CAS_NUM_avios_bus_seg1__c = ' + aviosBus1Selected;
                }
                if (aviosTP1Selected != null && aviosTP1Selected != '') {
                    query += ' AND R2_CAS_NUM_avios_TP_seg1__c = ' + aviosTP1Selected;
                }
                if (origenSegm2Selected != null && origenSegm2Selected != '') {
                    query += ' AND R2_CAS_TXT_segment2_origin__c LIKE \'%'+origenSegm2Selected+'%\'';
                }
                if (destinoSegm2Selected != null && destinoSegm2Selected != '') {
                    query += ' AND R2_CAS_TXT_destination_segment2__c LIKE \'%'+destinoSegm2Selected+'%\'';
                }
				if (fechaVueloSegm2Selected != null) {
                    query += ' AND R2_CAS_DAT_date_flight_segment2__c = :fechaVueloSegm2Selected';
                }
                if (dineroBus2Selected != null && dineroBus2Selected != '') {
                    query += ' AND R2_CAS_NUM_cash_bus_seg2__c = ' + dineroBus2Selected;
                }
                if (dineroTP2Selected != null && dineroTP2Selected != '') {
                    query += ' AND R2_CAS_NUM_cash_TP_seg2__c = ' + dineroTP2Selected;
                }
                if (aviosBus2Selected != null && aviosBus2Selected != '') {
                    query += ' AND R2_CAS_NUM_avios_bus_seg2__c = ' + aviosBus2Selected;
                }
                if (aviosTP2Selected != null && aviosTP2Selected != '') {
                    query += ' AND R2_CAS_NUM_avios_TP_seg2__c = ' + aviosTP2Selected;
                }
                if (dineroOtrosSelected != null && dineroOtrosSelected != '') {
                    query += ' AND R2_CAS_NUM_cash_bus_other__c = ' + dineroOtrosSelected;
                }
                if (aviosOtrosSelected != null && aviosOtrosSelected != '') {
                    query += ' AND R2_CAS_NUM_avios_bus_others__c = ' + aviosOtrosSelected;
                }
                if (localizadorResiber !=null && localizadorResiber!=''){
                	query += ' AND R2_CAS_TXT_Resiber_Locator__c =:localizadorResiber';
                }
                if (localizadorAmadeus !=null && localizadorAmadeus!=''){
                	query += ' AND R2_CAS_TXT_Amadeus_Locator__c =:localizadorAmadeus';
                }
                if (estadoSelected != null && estadoSelected != '') {
                    query += ' AND Status =: estadoSelected';
                }

            }
            // else {
            //     query += 'SELECT R2_CAS_LOO_Campaigns__r.Name, Id, CaseNumber, R2_CAS_PK_answer__c, R2_CAS_PK_answer_Seg2__c, R2_CAS_PK_resul__c, R2_CAS_PK_resul_Seg2__c, R2_CAS_PK_Reason__c, ';
            //     query += 'R2_CAS_PK_Reason_Seg2__c, R2_CAS_PK_answer_S1S2__c, CreatedDate, R2_CAS_TXT_Contact_schedule__c, R2_CAS_PKL_Country__c, R1_CAS_PKL_Idioma__c, R2_CAS_PK_Avios_Cash__c, ';
            //     query += 'R1_CAS_FOR_Card_Type__c, R2_CAS_TXT_segment1_origin__c, R2_CAS_TXT_destination_segment1__c, R2_CAS_DAT_date_flight_segment1__c, R2_CAS_NUM_cash_bus_seg1__c, ';
            //     query += 'R2_CAS_NUM_cash_TP_seg1__c, R2_CAS_NUM_avios_bus_seg1__c, R2_CAS_NUM_avios_TP_seg1__c, R2_CAS_TXT_segment2_origin__c, R2_CAS_TXT_destination_segment2__c, ';
            //     query += 'R2_CAS_DAT_date_flight_segment2__c, R2_CAS_NUM_cash_bus_seg2__c, R2_CAS_NUM_cash_TP_seg2__c, R2_CAS_NUM_avios_bus_seg2__c, R2_CAS_NUM_avios_TP_seg2__c, R2_CAS_NUM_cash_bus_other__c, ';
            //     query += 'R2_CAS_NUM_avios_bus_others__c, R2_CAS_TXT_Resiber_Locator__c, R2_CAS_TXT_Amadeus_Locator__c, R2_CAS_TXT_flight_number_segment1__c, R2_CAS_TXT_flight_number_segment2__c, Contact.Name, Status FROM Case WHERE R2_CAS_LOO_Campaigns__c =: campanhaId LIMIT 0';
            // }

            System.debug('mostrarCasos query->'+query);
            System.debug(LoggingLevel.Info, 'mostrarCasos query->'+query);

            List<Case> casosMostrados = null;
            if(query!=''){
                casosMostrados = Database.query(query);
            }

            casesToShow = new List<CaseTableItem>();

            if (casosMostrados!=null && !casosMostrados.isEmpty()) {
                for (Case caso : casosMostrados) {
                    casesToShow.add(new CaseTableItem(caso.R2_CAS_LOO_Campaigns__r.Name, caso.Id, caso.R1_CAS_FOR_Case_Number__c, /*caso.R2_CAS_PK_answer__c, caso.R2_CAS_PK_answer_Seg2__c,*/
                        caso.R2_CAS_PK_resul__c, caso.R2_CAS_PK_resul_Seg2__c, /*caso.R2_CAS_PK_Reason__c, caso.R2_CAS_PK_Reason_Seg2__c,*/ caso.R2_CAS_PK_answer_S1S2__c, caso.CreatedDate,
                        caso.R2_CAS_TXT_Contact_schedule__c, caso.R2_CAS_PKL_Country__c, caso.R1_CAS_PKL_Idioma__c, caso.R2_CAS_PK_Avios_Cash__c, caso.R1_CAS_FOR_Card_Type__c,
                        caso.R2_CAS_TXT_segment1_origin__c, caso.R2_CAS_TXT_destination_segment1__c, caso.R2_CAS_DAT_date_flight_segment1__c, caso.R2_CAS_NUM_cash_bus_seg1__c, caso.R2_CAS_NUM_cash_TP_seg1__c,
                        caso.R2_CAS_NUM_avios_bus_seg1__c, caso.R2_CAS_NUM_avios_TP_seg1__c, caso.R2_CAS_TXT_segment2_origin__c, caso.R2_CAS_TXT_destination_segment2__c,
                        caso.R2_CAS_DAT_date_flight_segment2__c, caso.R2_CAS_NUM_cash_bus_seg2__c, caso.R2_CAS_NUM_cash_TP_seg2__c, caso.R2_CAS_NUM_avios_bus_seg2__c, caso.R2_CAS_NUM_avios_TP_seg2__c,
                        /*caso.R2_CAS_NUM_cash_bus_other__c, caso.R2_CAS_NUM_avios_bus_others__c, */ caso.R2_CAS_TXT_flight_number_segment1__c, caso.R2_CAS_TXT_flight_number_segment2__c,caso.Contact.Name));
                }
            }

            System.debug('mostrarCasos casosMostrados: ' + casosMostrados);
            System.debug('mostrarCasos casesToShow: ' + casesToShow);
            System.debug(LoggingLevel.Info, 'mostrarCasos casosMostrados: ' + casosMostrados);
            System.debug(LoggingLevel.Info, 'mostrarCasos casesToShow: ' + casesToShow);
        } catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_caseFilteredReport_CTRL.mostrarCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
	Author:         UPH
	Company:        Accenture
	Description:

	History:
	<Date>                     <Author>                         <Change Description>
	17/10/2017                   UPH                               Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	public void reorderTable(){
		try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            // List<Id> rtIds = new List<Id>();
            // List<RecordType> lstRts = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND (Name = 'Campañas salientes')];
            // if (!lstRts.isEmpty()) {
            //     for(RecordType rt : lstRts){
            //         rtIds.add(rt.Id);
            //     }
            // }

            Id caseRecordType= [SELECT Id FROM RecordType WHERE SObjectType='Case' AND DeveloperName='R1_Outbound_campaigns'].Id;

            String campanhaId = this.campanha.id;
            

            String queryOrdered = query;
            queryOrdered += 'ORDER BY '+fieldNameAPI;
            if (ordenacionSentido != ' ASC') {
            	ordenacionSentido = ' ASC';
            } else {
            	ordenacionSentido = ' DESC';
            }
            queryOrdered += ordenacionSentido;

            List<Case> casosMostrados = Database.query(query);

            casesToShow = new List<CaseTableItem>();

            if (!casosMostrados.isEmpty()) {
                for (Case caso : casosMostrados) {
                    casesToShow.add(new CaseTableItem(caso.R2_CAS_LOO_Campaigns__r.Name, caso.Id, caso.R1_CAS_FOR_Case_Number__c, /*caso.R2_CAS_PK_answer__c, caso.R2_CAS_PK_answer_Seg2__c,*/
                        caso.R2_CAS_PK_resul__c, caso.R2_CAS_PK_resul_Seg2__c, /*caso.R2_CAS_PK_Reason__c, caso.R2_CAS_PK_Reason_Seg2__c, */caso.R2_CAS_PK_answer_S1S2__c, caso.CreatedDate,
                        caso.R2_CAS_TXT_Contact_schedule__c, caso.R2_CAS_PKL_Country__c, caso.R1_CAS_PKL_Idioma__c, caso.R2_CAS_PK_Avios_Cash__c, caso.R1_CAS_FOR_Card_Type__c,
                        caso.R2_CAS_TXT_segment1_origin__c, caso.R2_CAS_TXT_destination_segment1__c, caso.R2_CAS_DAT_date_flight_segment1__c, caso.R2_CAS_NUM_cash_bus_seg1__c, caso.R2_CAS_NUM_cash_TP_seg1__c,
                        caso.R2_CAS_NUM_avios_bus_seg1__c, caso.R2_CAS_NUM_avios_TP_seg1__c, caso.R2_CAS_TXT_segment2_origin__c, caso.R2_CAS_TXT_destination_segment2__c,
                        caso.R2_CAS_DAT_date_flight_segment2__c, caso.R2_CAS_NUM_cash_bus_seg2__c, caso.R2_CAS_NUM_cash_TP_seg2__c, caso.R2_CAS_NUM_avios_bus_seg2__c, caso.R2_CAS_NUM_avios_TP_seg2__c,
                        /*caso.R2_CAS_NUM_cash_bus_other__c, caso.R2_CAS_NUM_avios_bus_others__c,*/ caso.R2_CAS_TXT_flight_number_segment1__c, caso.R2_CAS_TXT_flight_number_segment2__c,caso.Contact.Name));
                }
            }

            System.debug('reorderTable casosMostrados: ' + casosMostrados);
            System.debug('reorderTable casesToShow: ' + casesToShow);
        } catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_caseFilteredReport_CTRL.mostrarCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
	}

    /*---------------------------------------------------------------------------------------------------------------------
	Author:         UPH
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	17/10/2017                   UPH                               Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    public Class CaseTableItem{
    	public String nombreCampana {get; set;}
    	public String idCaso {get; set;}
        public String identificador {get; set;}
        public String respuestaSegmento1 {get; set;}
        public String respuestaSegmento2 {get; set;}
        public String resultadoSegmento1 {get; set;}
        public String resultadoSegmento2 {get; set;}
        public String motivoSegmento1 {get; set;}
        public String motivoSegmento2 {get; set;}
        public String respuestaS1yS2 {get; set;}
		public String fechaCreacion {get; set;}
		public String franjaHoraria {get; set;}
        public String paisSeEncuentra {get; set;}
        public String idioma {get; set;}
        public String aviosCash {get; set;}
		public String nivelTarjeta {get; set;}
        public String origenSegm1 {get; set;}
        public String destinoSegm1 {get; set;}
        public String fechaVueloSegm1 {get; set;}
        public String dineroBus1 {get; set;}
        public String dineroTP1 {get; set;}
        public String aviosBus1 {get; set;}
        public String aviosTP1 {get; set;}
        public String origenSegm2 {get; set;}
        public String destinoSegm2 {get; set;}
        public String fechaVueloSegm2 {get; set;}
        public String dineroBus2 {get; set;}
        public String dineroTP2 {get; set;}
        public String aviosBus2 {get; set;}
        public String aviosTP2 {get; set;}
        public String dineroOtros {get; set;}
        public String aviosOtros {get; set;}
        public String clienteCaso {get; set;}
        public String numeroVueloS1 {get; set;}
        public String numeroVueloS2 {get; set;}

        public CaseTableItem(String anombreCampana, String aId, String aIdent, /*String arespuestaSegmento1, String arespuestaSegmento2,*/ String aresultadoSegmento1, String aresultadoSegmento2, /*String amotivoSegmento1,
        	String amotivoSegmento2, */String arespuestaS1yS2, Datetime aCreateDate, String afranjaHoraria, String apaisSeEncuentra, String aIdioma, String aaviosCash, String anivelTarjeta, String aorigenSegm1, String adestinoSegm1,
        	Date afechaVueloSegm1, Decimal adineroBus1, Decimal adineroTP1, Decimal aaviosBus1, Decimal aaviosTP1, String aorigenSegm2, String adestinoSegm2, Date afechaVueloSegm2, Decimal adineroBus2, Decimal adineroTP2, Decimal aaviosBus2,
        	Decimal aaviosTP2, /*Decimal adineroOtros, Decimal aaviosOtros, */ String anumeroVueloS1, String anumeroVueloS2, String aclienteCaso){

        	nombreCampana=anombreCampana;
            idCaso=aId;
            identificador=aIdent;
            //respuestaSegmento1=arespuestaSegmento1;
            //respuestaSegmento2=arespuestaSegmento2;
            resultadoSegmento1=aresultadoSegmento1;
            resultadoSegmento2=aresultadoSegmento2;
            //motivoSegmento1=amotivoSegmento1;
        	//motivoSegmento2=amotivoSegmento2;
            respuestaS1yS2=arespuestaS1yS2;
            fechaCreacion=aCreateDate.format('dd/MM/yyyy -- hh:mm a');
            franjaHoraria=afranjaHoraria;
            paisSeEncuentra=apaisSeEncuentra;
            idioma=aIdioma;
            aviosCash=aaviosCash;
            nivelTarjeta=anivelTarjeta;
            origenSegm1=aorigenSegm1;
            destinoSegm1=adestinoSegm1;
            clienteCaso=aclienteCaso;
            numeroVueloS1=anumeroVueloS1;
            numeroVueloS2=anumeroVueloS2;
            if (afechaVueloSegm1 == null) {
            	fechaVueloSegm1 = '';
            } else {
            	fechaVueloSegm1=afechaVueloSegm1.format();
            }
            if (adineroBus1 == null) {
                dineroBus1 = '';
            } else {
                dineroBus1=adineroBus1.format();
            }
            if (adineroTP1 == null) {
                dineroTP1 = '';
            } else {
                dineroTP1=adineroTP1.format();
            }
            if (aaviosBus1 == null) {
                aviosBus1 = '';
            } else {
                aviosBus1=aaviosBus1.format();
            }
            if (aaviosTP1 == null) {
                aviosTP1 = '';
            } else {
                aviosTP1=aaviosTP1.format();
            }
            origenSegm2=aorigenSegm2;
			destinoSegm2=adestinoSegm2;
			if (afechaVueloSegm2 == null) {
				fechaVueloSegm2 = '';
			} else {
				fechaVueloSegm2=afechaVueloSegm2.format();
			}
            if (adineroBus2 == null) {
                dineroBus2 = '';
            } else {
                dineroBus2=adineroBus2.format();
            }
            if (adineroTP2 == null) {
                dineroTP2 = '';
            } else {
                dineroTP2=adineroTP2.format();
            }
            if (aaviosBus2 == null) {
                aviosBus2 = '';
            } else {
                aviosBus2=aaviosBus2.format();
            }
            if (aaviosTP2 == null) {
                aviosTP2 = '';
            } else {
                aviosTP2=aaviosTP2.format();
            }
            /*
            if (adineroOtros == null) {
                dineroOtros = '';
            } else {
                dineroOtros=adineroOtros.format();
            }
            if (aaviosOtros == null) {
                aviosOtros = '';
            } else {
                aviosOtros=aaviosOtros.format();
            }
            */
        }
    }
}