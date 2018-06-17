public class R2_CLS_BAG_BagSearch {
    public String recordTypeSearch {get;set;} //Delayed, Damage
    public Search searchParams {get;set;}{searchParams = new Search();}

    public R1_Incident__c pir {get;set;}
    public List<PIR> incidentList {get;set;}
    public String errorBusqueda {get;set;}
    public String auxTipo;
    public String idbag {get;set;}
    public String tipoBusqueda {get;set;}
    public String fechaFormatoCaller {get;set;}

    {errorBusqueda = ''; idbag = ''; tipoBusqueda = ''; incidentList = null; fechaFormatoCaller = null;}

    private String fieldsSearch = 'R2_INC_LOO_Case__c, R2_INC_DAT_PIR_Claim_Date__c, Id, R2_INC_TXT_PIR_Others_PIR_Associated_XR__c, '+
        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_PKL_PIR_Incidence_type__c, R2_INC_TXT_PIR_Name__c, '+
        'R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_TXT_PIR_BBDD_type__c';

    //columnas del search a mostrar
    //03/04/2018                  Alberto Puerto Collado      Fixed columns and FD displayed
    private String fieldsListDetail = 'R2_INC_PKL_PIR_Status_incidence__c, R2_INC_FOR_PIR__c, R2_INC_FOR_PIR_AR__c, '+
        'R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_flight_Number__c, ' + 
        'R2_INC_TXT_PIR_Name__c, R2_INC_TXT_PIR_Last_name__c, R2_INC_TXT_PIR_Last_name2__c, '+
        'R2_INC_DATH_PIR_Incidence_closed_date__c, R2_INC_TXT_PIR_Others_PIR_Associated_XR__c, R2_INC_PKL_PIR_Incidence_type__c, '+
        'R2_INC_LOO_Case__r.CaseNumber, R2_INC_TXT_PIR_Route__c, R2_INC_DAT_PIR_Claim_Date__c, '+
        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_TXT_PIR_Responsible_Scale__c, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Reference_Number__c, '+
        'R2_INC_TXT_PIR_AR_Airline_Code__c, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Reference_Number__c';

    public Search getSearch(){
        return searchParams;
    }
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Check Params - Validations

    IN:             
    OUT:

    History:
    <Date>                       <Author>                  <Change Description>
    11/12/2017                  Álvaro García Tapia         Initial Version
    10/04/2018                  Alberto Puerto Collado      Create Wrapper "WP_ValidaParams" and return it + check Date Format 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public class WP_ValidaParams{
        public Boolean resultado;
        public String error;
        public String code;
    }
    public WP_ValidaParams checkParams() {
        Boolean searchPIR = false;
        WP_ValidaParams validacion = new WP_ValidaParams();
            validacion.resultado = false;
        try{ 
            if(searchParams != null){
                if (!searchPIR && searchParams.nPIR != null && searchParams.nPIR != '') {
                    searchPIR = true;
                    validacion.resultado = true;
                }
                if (!searchPIR && searchParams.etiqueta != null && searchParams.etiqueta != ''
                    && searchParams.escala != null && searchParams.escala != ''
                    //&& searchParams.compania != null && searchParams.compania != ''
                    ) {
                    searchPIR = true;
                    validacion.resultado = true;
                }
                if (!searchPIR && searchParams.nombrePax != null && searchParams.nombrePax != ''
                    && searchParams.escala != null && searchParams.escala != ''
                    //&& searchParams.compania != null && searchParams.compania != ''
                    ) {
                    searchPIR = true;
                    validacion.resultado = true;
                }
                if (!searchPIR && searchParams.nombrePax != null && searchParams.nombrePax != ''
                    && searchParams.fechaCreacion != null && searchParams.fechaCreacion != '') {
                    searchPIR = true;
                    validacion.resultado = true;
                }

                //Date Format MMMYY : (JAN18, JAN/18...):
                fechaFormatoCaller = null;
                System.debug(':::Validando campo fecha');
                if (searchParams.fechaCreacion != null && searchParams.fechaCreacion != ''){
                    Boolean checkDate = Pattern.matches('[A-z]{3}[\\/]?[0-9]{2}', searchParams.fechaCreacion);
                    System.debug(':::El campo fecha tiene formato correcto? - '+ checkDate);
                    if(checkDate == true){
                        validacion.resultado = true;
                        //parse Date retrieved to correct format to call WT
                        String fechaModificada = formatDateMMMYY(searchParams.fechaCreacion);
                        System.debug(':::fechaModificada ' + fechaModificada);
                        if (fechaModificada != null){
                            fechaFormatoCaller = fechaModificada;
                        }else{
                            validacion.resultado = false;
                            validacion.error = 'Error en la transformación de la fecha al formato correcto, por favor consulte con el Administrador';
                            validacion.code = 'DATE';
                            errorBusqueda = validacion.error;
                        }
                    }else{
                        validacion.resultado = false;
                        validacion.error = 'Formato de fecha inválida ('+ searchParams.fechaCreacion + ') . Ejemplo de una fecha correcta: MAY18';
                        validacion.code = 'DATE';
                        errorBusqueda = validacion.error;
                    }
                }
            }
            //return searchPIR;
            return validacion;
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.checkParams', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            //return false;
            validacion.error = 'No se ha podido realizar la validación del formulario por favor consulte con su Administrador';
            return validacion;
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado 
    Company:        Accenture
    Description:    Change format of Date received, MonthYear(SSSNN) to YYYY-MM-DD

    IN:             String MAY18 || May/18 
    OUT:            String YYYY-MM-DD

    History:
    <Date>                       <Author>                  <Change Description>
    11/04/2018                  Alberto Puerto Collado      Initial Version 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String formatDateMMMYY(String fechaIN) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('formatDateMMMYY() para la fecha: ' + fechaIN);

            String fechaOUT = '';
            String mes = fechaIN.substring(0,3).toUpperCase();
            String year = fechaIN.substring(3);
            String day = '11'; //Dummy value, WT check only month/year, but in our communication with IntInt we have to send YYYY-MM-DD (DD is not valorated by WT)
            System.debug('mes y año: ' + mes  + ' ' + year);

            //year management:
            Date today = Date.today();
            String currentYear = String.valueOf(today.year());
            System.debug('currentYear: ' + currentYear);
            if(year > currentYear.substring(2)){
                year = Integer.valueOf(currentYear.substring(0,2)) - 1  + year;
            }else{
                year = Integer.valueOf(currentYear.substring(0,2)) + year;
            }
            fechaOUT = year;
            //Switch case for months:
            if(mes.contains('JAN') || mes.contains('ENE')){
                fechaOUT += '-01-' + day;
            }else if(mes.contains('FEB')){
                fechaOUT += '-02-' + day;
            }else if(mes.contains('MAR') ){
                fechaOUT += '-03-' + day;
            }else if(mes.contains('APR') || mes.contains('ABR')){
                fechaOUT += '-04-' + day;
            }else if(mes.contains('MAY') ){
                fechaOUT += '-05-' + day;
            }else if(mes.contains('JUN') ){
                fechaOUT += '-06-' + day;
            }else if(mes.contains('JUL') ){
                fechaOUT += '-07-' + day;
            }else if(mes.contains('AUG') || mes.contains('AGO')){
                fechaOUT += '-08-' + day;
            }else if(mes.contains('SEP') ){
                fechaOUT += '-09-' + day;
            }else if(mes.contains('OCT') ){
                fechaOUT += '-10-' + day;
            }else if(mes.contains('NOV') ){
                fechaOUT += '-11-' + day;
            }else if(mes.contains('DEC') || mes.contains('DIC')){
                fechaOUT += '-12-' + day;
            }
            System.debug(':::fechaOUT transformada ' + fechaOUT);
            return fechaOUT;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.formatDateMMMYY', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Method to format correctly the wrapper searchParams()

    IN:

    OUT:           

    History:

    <Date>              <Author>            <Description>
    10/04/2018    Alvaro Garcia Tapia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public String formatParam(String param) {

         try{
            param = param.trim();
            param = param.toUpperCase();
            return param;
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.formatParam', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Method to format correctly the wrapper searchParams()

    IN:

    OUT:           

    History:

    <Date>              <Author>            <Description>
    10/04/2018    Alvaro Garcia Tapia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public Search cleanParams(Search searchParams) {

         try{
            if(searchParams != null){
                if (searchParams.nPIR != null && searchParams.nPIR != '') {
                    searchParams.nPIR = formatParam(searchParams.nPIR);
                }
                if (searchParams.etiqueta != null && searchParams.etiqueta != '') {
                    searchParams.etiqueta = formatParam(searchParams.etiqueta);
                }
                if (searchParams.escala != null && searchParams.escala != '') {
                    searchParams.escala = formatParam(searchParams.escala);
                }
                if (searchParams.nombrePax != null && searchParams.nombrePax != '') {
                    searchParams.nombrePax = formatParam(searchParams.nombrePax);
                }
                if (searchParams.fechaCreacion != null && searchParams.fechaCreacion != '') {
                    searchParams.fechaCreacion = formatParam(searchParams.fechaCreacion);
                }
                if (searchParams.nExpediente != null && searchParams.nExpediente != '') {
                    searchParams.nExpediente = formatParam(searchParams.nExpediente);
                }
                if (searchParams.pirAsociado != null && searchParams.pirAsociado != '') {
                    searchParams.pirAsociado = formatParam(searchParams.pirAsociado);
                }
                if (searchParams.tipoIncidencia != null && searchParams.tipoIncidencia != '') {
                    searchParams.tipoIncidencia = formatParam(searchParams.tipoIncidencia);
                }
                if (searchParams.colorTipo != null && searchParams.colorTipo != '') {
                    searchParams.colorTipo = formatParam(searchParams.colorTipo);
                }
                if (searchParams.estadoIncidencia != null && searchParams.estadoIncidencia != '') {
                    searchParams.estadoIncidencia = formatParam(searchParams.estadoIncidencia);
                }
                if (searchParams.tipoBBDD != null && searchParams.tipoBBDD != '') {
                    searchParams.tipoBBDD = formatParam(searchParams.tipoBBDD);
                }
            }
            return searchParams;
        }
        catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.cleanParams', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }

    public void incidents(){
        CLS_INC_WT_Monitoring.watchingWT( 'SearchSalesforceDDBB', 'Salesforce'); 
        errorBusqueda = '';
        //if (!checkParams()) {
        WP_ValidaParams validacion = checkParams();
        System.debug(':::searchParams: '+searchParams);
        System.debug(':::validacion en incidents(): '+validacion);
        if (validacion.resultado == false) {
            if(validacion.code != 'DATE'){
               errorBusqueda = label.R2_LB_WT_Error_Search; 
            }        
            return ;
        }
        this.incidentList = null;
        System.debug('IR');
        System.debug(searchParams);
        String query = 'SELECT Id, RecordTypeId, RecordType.DeveloperName, '+fieldsListDetail+' FROM R1_Incident__c WHERE ';
        List<R1_Incident__c> pirResult = null;
        try{
            if(searchParams != null){
                searchParams = cleanParams(searchParams);
               /* if(searchParams.nExpediente != null && searchParams.nExpediente != ''){
                    query+='R2_INC_LOO_Case__c=\''+searchParams.nExpediente+'\' &&';
                }*/
                if(searchParams.fechaCreacion != null && searchParams.fechaCreacion != '' && fechaFormatoCaller != null){
                    //query+=' R2_INC_DAT_PIR_Claim_Date__c=\''+date.parse(searchParams.fechaCreacion)+'\' AND';
                    query+=' R2_INC_DAT_PIR_Claim_Date__c=\''+fechaFormatoCaller+'\' AND';//alberto.puerto replaced 12/94/18
                }
                if(searchParams.nPIR != null && searchParams.nPIR != ''){
                    query+=' R2_INC_FOR_PIR__c=\''+searchParams.nPIR+'\' AND';
                }
                if(searchParams.pirAsociado != null && searchParams.pirAsociado != ''){
                    query+=' R2_INC_FOR_PIR_AR__c =\''+searchParams.pirAsociado+'\' AND';
                }
                if(searchParams.escala != null && searchParams.escala != ''){//} && searchParams.compania != null && searchParams.compania != ''){
                    query+=' R2_INC_TXT_PIR_Station_Code__c=\''+searchParams.escala.subString(0,3)+'\' AND';
                    query+=' R2_INC_TXT_PIR_Airline_Code__c=\''+searchParams.escala.subString(3,5)+'\' AND';
                }
                if(searchParams.tipoIncidencia != null && searchParams.tipoIncidencia != ''){
                    query+=' R2_INC_PKL_PIR_Incidence_type__c=\''+searchParams.tipoIncidencia+'\' AND';
                }
                if(searchParams.nombrePax != null && searchParams.nombrePax != ''){
                    //query+='R2_INC_TXT_II_Passenger_name__c=\''+searchParams.nombrePax+'\' &&';
                    query+=' R2_INC_TXT_PIR_Name__c LIKE \'%'+searchParams.nombrePax+'%\' AND';
                }
                if(searchParams.etiqueta != null && searchParams.etiqueta != ''){
                    query+=' R2_INC_CHK_PIR_Limited_approval_label__c=\''+searchParams.etiqueta+'\' AND';
                }
                if(searchParams.estadoIncidencia != null && searchParams.estadoIncidencia != ''){
                    query+=' R2_INC_PKL_PIR_Status_incidence__c=\''+searchParams.estadoIncidencia+'\' AND';
                }
                if(searchParams.tipoBBDD != null && searchParams.tipoBBDD != ''){
                    query+=' R2_INC_TXT_PIR_BBDD_type__c=\''+searchParams.tipoBBDD+'\' AND';
                }
            }
        }
        catch(Exception e){
            System.debug('Campo erroneo');
            System.debug(e);
        }

        try{
            query = query.removeEnd('WHERE '); //controlar búsqueda en SF, requerir campos también para que no sea muy extenso
            query = query.removeEnd(' AND');
            System.debug(query);
            pirResult = Database.query(query);
        }
        catch(Exception e){
            System.debug(e);
        }
        try{
            System.debug(pirResult);
            this.incidentList = getPIRs(pirResult);
            System.debug('!!!!!!!!!!!!!!!!getPIRs RESULT!!!!!!!!!!!!!!!!'+this.incidentList);
        }
        catch(Exception e){
            System.debug('Lista de PIR vacía');
            System.debug(e);
        }
    }
    //public void compruebaFields(){
    //    if(searchParams.nPIR != null || searchParams.nPIR != ''){
    //        wpDAHByPIR();
    //    }else{
    //        wpDAH();
    //    }
    //}
    public void wpDAH(){
        //limpieza de componente
        this.errorBusqueda = '';
        this.incidentList = null;
        System.debug('Entro en wpDAH');
        this.auxTipo = 'NotInactive';
        this.recordTypeSearch = 'DELAYED';
        this.tipoBusqueda = 'DAH';
        System.debug(':::num PIR'+searchParams.nPIR);
        if(searchParams.nPIR != null && searchParams.nPIR != ''){
            searchRecordByPIR(this.recordTypeSearch);
        }else{
            wpSearching(this.recordTypeSearch);
        }
        searchParams = new Search();
        CLS_INC_WT_Monitoring.watchingWT( 'search_DAH', 'Delayed'); 
    }
    //public void wpDAHByPIR(){
    //    System.debug('Entro en wpDAH');
    //    this.auxTipo = 'NotInactive';
    //    this.recordTypeSearch = 'DELAYED';
    //    searchRecordByPIR(this.recordTypeSearch);
    //}
    public void wpDDP(){ 
        //limpieza de componente
        this.errorBusqueda = '';
        this.incidentList = null;
        System.debug('Entro en wpDDP');
        this.recordTypeSearch = 'DAMAGED';
        this.auxTipo = 'NotInactive';
        this.tipoBusqueda = 'DDP';
        System.debug(':::num PIR'+searchParams.nPIR);
        //wpSearching(this.recordTypeSearch);
        if(searchParams.nPIR != null && searchParams.nPIR != ''){
            searchRecordByPIR(this.recordTypeSearch);
        }else{
            wpSearching(this.recordTypeSearch);
        }
        searchParams = new Search();
        CLS_INC_WT_Monitoring.watchingWT( 'search_DDP', 'Damaged');
    }
    public void wpPDIAHL(){
        //limpieza de componente
        this.errorBusqueda = '';
        this.incidentList = null;
        System.debug('Entro en wpPDIAHL');
        this.recordTypeSearch = 'DELAYED';
        this.auxTipo = 'inactive';
        this.tipoBusqueda = 'PDI AHL';
        //wpRetiredSearching(this.recordTypeSearch);
        if(searchParams.nPIR != null && searchParams.nPIR != ''
            && searchParams.fechaCreacion != null && searchParams.fechaCreacion != ''){
            searchRecordByPIR_Inactive(this.recordTypeSearch, searchParams.fechaCreacion);
        }else{
            wpRetiredSearching(this.recordTypeSearch);
        }
        searchParams = new Search();
        CLS_INC_WT_Monitoring.watchingWT( 'search_PDI_AHL', 'Inactive Delayed'); 
    }
    public void wpPDIDPR(){
        //limpieza de componente
        this.errorBusqueda = '';
        this.incidentList = null;
        System.debug('Entro en wpPDIDPR');
        this.recordTypeSearch = 'DAMAGED';
        this.auxTipo = 'inactive';
        this.tipoBusqueda = 'PDI DPR';
        //wpRetiredSearching(this.recordTypeSearch);
        if(searchParams.nPIR != null && searchParams.nPIR != ''
            && searchParams.fechaCreacion != null && searchParams.fechaCreacion != ''){
            searchRecordByPIR_Inactive(this.recordTypeSearch, searchParams.fechaCreacion);
        }else{
            wpRetiredSearching(this.recordTypeSearch);
        }
        searchParams = new Search();
        CLS_INC_WT_Monitoring.watchingWT( 'search_PDI_DPR', 'Inactive Damaged'); 
    }
    public void wpSearching(String bagType){
        this.idbag = '';
        this.errorBusqueda = '';
        WP_ValidaParams validacion = checkParams();
        System.debug(':::searchParams: '+searchParams);
        System.debug(':::validacion para wpSearching: '+validacion);
        //if (!checkParams()) {
        if (validacion.resultado == false) {
            if(validacion.code != 'DATE'){
                System.debug(':::mostrando error con label generico error search');
                errorBusqueda = label.R2_LB_WT_Error_Search;
            }          
            return ;
        }
        this.incidentList = null;
        System.debug('wpSearching');
        System.debug(searchParams);
        R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
        R2_CLS_WT_Bags_Management.WpReqSearch requestSearch = new R2_CLS_WT_Bags_Management.WpReqSearch();
        requestSearch.bagType = bagType;
        requestSearch.searchType = 'SIMPLE';
        requestSearch.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;//'AgentId';
        String query = null;
        try{
            if (searchParams != null) {
                searchParams = cleanParams(searchParams);
                if(searchParams.nPIR != null && searchParams.nPIR != ''){
                    //requestSearch.refStationCode = searchParams.nPIR.substring(0,3);
                    //requestSearch.refAirlineCode = searchParams.nPIR.substring(3,5);
                }
                if(searchParams.fechaCreacion != null && searchParams.fechaCreacion != '' && fechaFormatoCaller != null){
                    R2_CLS_WT_Bags_Management.BagSearchType bagSearch = new R2_CLS_WT_Bags_Management.BagSearchType();
                    R2_CLS_WT_Bags_Management.DateRangeType createdDate = new R2_CLS_WT_Bags_Management.DateRangeType();
                    createdDate.fromDate =  fechaFormatoCaller;//searchParams.fechaCreacion; //alberto.puerto changed 12/04/18
                    bagSearch.bagCreateDate = createdDate;
                    requestSearch.bag = bagSearch;
                }/*
                if(searchParams.pirAsociado != null && searchParams.pirAsociado != ''){
                    query+='R2_INC_TXT_PIR_Others_PIR_Associated_XR__c=\''+searchParams.pirAsociado+'\' &&';
                }*/
                if(searchParams.escala != null && searchParams.escala != ''){// && searchParams.compania != null && searchParams.compania != ''){
                    R2_CLS_WT_Bags_Management.AssociatedRecord missingStation = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                    missingStation.stationCode = searchParams.escala.subString(0,3);
                    missingStation.airlineCode = searchParams.escala.subString(3,5);
                    requestSearch.missingStation = missingStation;
                    //requestSearch.refStationCode = searchParams.nPIR.substring(0,3);
                    //requestSearch.refAirlineCode = searchParams.nPIR.substring(3,5);
                }/*
                if(searchParams.tipoIncidencia != null && searchParams.tipoIncidencia != ''){
                    query+='R2_INC_PKL_PIR_Incidence_type__c=\''+searchParams.tipoIncidencia+'\' &&';
                }*/
                if(searchParams.nombrePax != null && searchParams.nombrePax != ''){
                    System.debug(searchParams.nombrePax);
                    R2_CLS_WT_Bags_Management.NameExactType name = new R2_CLS_WT_Bags_Management.NameExactType();
                    name.name = searchParams.nombrePax;
                    name.exact = 'true';
                    requestSearch.name = name;

                }
                if(searchParams.etiqueta != null && searchParams.etiqueta != ''){
                    R2_CLS_WT_Bags_Management.BagSearchType bagSearch = new R2_CLS_WT_Bags_Management.BagSearchType();
                    R2_CLS_WT_Bags_Management.BagTag bagTag = new R2_CLS_WT_Bags_Management.BagTag();
                    R2_CLS_WT_Bags_Management.LicenseNumber license = new R2_CLS_WT_Bags_Management.LicenseNumber();
                    if(searchParams.etiqueta.length() == 10) {
                        license.tagType = searchParams.etiqueta.substring(0, 1);
                        license.issuerCode = searchParams.etiqueta.substring(1, 4);
                        bagTag.licenseNumber = license;
                        bagTag.tagSequence = searchParams.etiqueta.substring(4);
                        bagSearch.bagTag = bagTag;
                        requestSearch.bag = bagSearch;
                    }
                    else {
                        if (searchParams.escala != null && searchParams.escala != '')
                        bagTag.tagSequence = searchParams.etiqueta;
                        bagTag.airlineCode = searchParams.escala.subString(3,5);
                        bagSearch.bagTag = bagTag;
                        requestSearch.bag = bagSearch;
                    }
                }/*
                if(searchParams.colorTipo != null && searchParams.colorTipo != ''){
                    query+='R2_INC_LOO_Case__c=\''+searchParams.colorTipo+'\' &&';
                }
                if(searchParams.estadoIncidencia != null && searchParams.estadoIncidencia != ''){
                    query+='R2_INC_PKL_PIR_Status_incidence__c=\''+searchParams.estadoIncidencia+'\' &&';
                }
                if(searchParams.tipoBBDD != null && searchParams.tipoBBDD != ''){
                    query+='R2_INC_TXT_PIR_BBDD_type__c=\''+searchParams.tipoBBDD+'\' &&';
                }*/


                System.debug('REQUESTSEARCH:::'+requestSearch);
                //bigWP.search = '{   "bagType": "DELAYED","searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"} ';
    			///////////////// {"searchType":"SIMPLE","Name":{"name":"MANI","exact":"true"},"bagType":"DELAYED","agentId":"AgentId"}
                //{"searchType":"SIMPLE""Name":{"name":"MANI","exact":"true"}"bagType":"DELAYED""agentId":"AgentId"}
                //{"searchType":"SIMPLE"{"Name":{"name":"MANI"{"exact":"true"}{"bagType":"DELAYED"{"agentId":"AgentId"}
                bigWP.search = JSON.serialize(requestSearch, true);

                System.debug('*** bigWP.search: ' + bigWP.search);

                //List<R1_Incident__c> response = R2_CLS_WT_Bags_Management.searchBags('{   "bagType": "DELAYED",   "searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"} ', 1);

                List<R1_Incident__c> response = R2_CLS_WT_Bags_Management.searchBags(bigWP.search, 0);

                System.debug(response);

                System.debug('*** response: ' + response);


            	if(response != null){
                    this.incidentList = getPIRs(response);
                    System.debug(this.incidentList);
                }else{
                    this.errorBusqueda = 'No hay resultados en WorldTracer para los criterios seleccionados.';
                }
            }
            else {

            }
        }catch(Exception e){
            System.debug(e);
        }
    }

    public void wpRetiredSearching(String bagType){
        this.idbag = '';
        this.errorBusqueda = '';
        WP_ValidaParams validacion = checkParams();
        System.debug(':::searchParams: '+searchParams);
        System.debug(':::validacion para wpSearching: '+validacion);
        //if (!checkParams()) {
        if (validacion.resultado == false) {
            if(validacion.code != 'DATE'){
                System.debug(':::mostrando error con label generico error search');
                errorBusqueda = label.R2_LB_WT_Error_Search;
            }          
            return ;
        }
        System.debug('Se va a sacar la listaaaaaaaaaaaaa');
        incidentList = null;
        System.debug('DAH');
        System.debug('Parametroooooooooooooos: '+searchParams);
        R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
        R2_CLS_WT_Bags_Management.WpReqSearchRetired requestSearch = new R2_CLS_WT_Bags_Management.WpReqSearchRetired();
        requestSearch.recordType = bagType;
        requestSearch.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;//'AgentId';
        String query = null;
        try{
            if(searchParams != null){
                searchParams = cleanParams(searchParams);
              /*if(searchParams.nExpediente != null && searchParams.nExpediente != ''){
                    query+='R2_INC_LOO_Case__c=\''+searchParams.nExpediente+'\' &&';
                }
                if(searchParams.fechaCreacion != null && searchParams.fechaCreacion != ''){
                    query+='R2_INC_DAT_PIR_Claim_Date__c=\''+date.parse(searchParams.fechaCreacion)+'\' &&';
                }*/
                if(searchParams.nPIR != null && searchParams.nPIR != ''){
                    //requestSearch.refStationCode = searchParams.nPIR.substring(0,3);
                    //requestSearch.refAirlineCode = searchParams.nPIR.substring(3,5);
                }
                if(searchParams.fechaCreacion != null && searchParams.fechaCreacion != '' && fechaFormatoCaller != null){
                    System.debug('Fecha de creaciooooooooooooon: '+ searchParams.fechaCreacion);
                    //R2_CLS_WT_Bags_Management.BagSearchType bagSearch = new R2_CLS_WT_Bags_Management.BagSearchType();
                    //R2_CLS_WT_Bags_Management.DateRangeType createdDate = new R2_CLS_WT_Bags_Management.DateRangeType();
                    //createdDate.fromDate =  searchParams.fechaCreacion;
                    //bagSearch.bagCreateDate = createdDate;
                    requestSearch.rDate = fechaFormatoCaller;//searchParams.fechaCreacion;//alberto.puerto added 18/04/18
                     System.debug(':::rDate con fechaFormatoCaller: '+ fechaFormatoCaller);
                }/*
                if(searchParams.pirAsociado != null && searchParams.pirAsociado != ''){
                    query+='R2_INC_TXT_PIR_Others_PIR_Associated_XR__c=\''+searchParams.pirAsociado+'\' &&';
                }*/
                if(searchParams.escala != null && searchParams.escala != ''){
                    R2_CLS_WT_Bags_Management.AssociatedRecord assRecord = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                    assRecord.stationCode = searchParams.escala.subString(0,3);
                    assRecord.airlineCode =  searchParams.escala.subString(3,5);

                    requestSearch.refStationAirline = assRecord;
                    
                }/*
                if(searchParams.tipoIncidencia != null && searchParams.tipoIncidencia != ''){
                    query+='R2_INC_PKL_PIR_Incidence_type__c=\''+searchParams.tipoIncidencia+'\' &&';
                }*/
                if(searchParams.nombrePax != null && searchParams.nombrePax != ''){
                    System.debug('Nombre Pasajeroooooooooooo:'+searchParams.nombrePax);
                    R2_CLS_WT_Bags_Management.SearchRetiredNameType name = new R2_CLS_WT_Bags_Management.SearchRetiredNameType();
                    name.name = searchParams.nombrePax;
                    requestSearch.name = name;

                }/*
                if(searchParams.etiqueta != null && searchParams.etiqueta != ''){
                    query+='R2_INC_CHK_PIR_Limited_approval_label__c=\''+searchParams.etiqueta+'\' &&';
                }
                if(searchParams.colorTipo != null && searchParams.colorTipo != ''){
                    query+='R2_INC_LOO_Case__c=\''+searchParams.colorTipo+'\' &&';
                }
                if(searchParams.estadoIncidencia != null && searchParams.estadoIncidencia != ''){
                    query+='R2_INC_PKL_PIR_Status_incidence__c=\''+searchParams.estadoIncidencia+'\' &&';
                }
                if(searchParams.tipoBBDD != null && searchParams.tipoBBDD != ''){
                    query+='R2_INC_TXT_PIR_BBDD_type__c=\''+searchParams.tipoBBDD+'\' &&';
                }*/
            }
            System.debug('REQUESTSEARCH:::'+requestSearch);
            //bigWP.search = '{   "bagType": "DELAYED","searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"} ';
            ///////////////// {"searchType":"SIMPLE","Name":{"name":"MANI","exact":"true"},"bagType":"DELAYED","agentId":"AgentId"}
            //{"searchType":"SIMPLE""Name":{"name":"MANI","exact":"true"}"bagType":"DELAYED""agentId":"AgentId"}
            //{"searchType":"SIMPLE"{"Name":{"name":"MANI"{"exact":"true"}{"bagType":"DELAYED"{"agentId":"AgentId"}
            bigWP.search = JSON.serialize(requestSearch, true);

            System.debug('*** bigWP.search: ' + bigWP.search);

            //List<R1_Incident__c> response = R2_CLS_WT_Bags_Management.searchBags('{   "bagType": "DELAYED",   "searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"} ', 1);


            List<R1_Incident__c> response = R2_WT_SearchRetiredRecord.search_RetiredRecords_bag(bigWP.search, 0, fechaFormatoCaller);//alberto.puerto 12/04/18 replaced instead searchParams.fechaCreacion);

            // if(this.recordTypeSearch == 'DELAYED' || this.recordTypeSearch == 'DAMAGED' ) {
            //   List<R1_Incident__c> response = R2_CLS_WT_Bags_Management.searchBags(bigWP.search, 0);
            // }else if(this.recordTypeSearch == 'INACTIVE'){
            //
            // }

            System.debug('*** response: ' + response);


            if(response != null)incidentList = getPIRs(response);
            System.debug(incidentList);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.wpRetiredSearching', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }


    private List<PIR> getPIRs(List<R1_Incident__c> pirList){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get('R1_Incident__c');
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        List<PIR> incidencias = new List<PIR>();
        List<String> listFields = fieldsListDetail.split(', ');
        System.debug(listFields);
        PIR pirObject = null;
        Field fieldObject = null;
        for(R1_Incident__c incident : pirList){
           // System.debug('incident');
            //System.debug(incident);
            pirObject = new PIR();
            pirObject.fields = new List<Field>();
            pirObject.pir = (String)incident.get('Id');
            for(String field : listFields){
                fieldObject = new Field();
                if(field.contains('__r.')){
                    String[] lookupField = field.split('__r.');
                    String lookup = lookupField[0]+'__c';
                    String relationship = lookupField[0]+'__r';
                    String relationshipField = lookupField[1];
                    if(incident.getSObject(relationship) != null){
                        fieldObject.value = String.valueof(incident.getSObject(relationship).get(relationshipField));
                        fieldObject.href = '/'+String.valueof(incident.get(lookup));
                    }
                    fieldObject.label = fieldMap.get(lookup).getDescribe().getLabel();
                    fieldObject.name = lookup;
                }
                //INCIDENCIA
                else if(field.contains('R2_INC_FOR_PIR__c')){ //uso como auxiliar para concatenar y mostrar
                    System.debug('debug FIELD::::::::'+field);
                    fieldObject.value = (String)incident.get('R2_INC_TXT_PIR_Station_Code__c')
                                        +(String)incident.get('R2_INC_TXT_PIR_Airline_Code__c')
                                        +(String)incident.get('R2_INC_TXT_PIR_Reference_Number__c');
                    fieldObject.label = fieldMap.get('R2_INC_FOR_PIR__c').getDescribe().getLabel();
                    fieldObject.name  = (String)incident.get('R2_INC_TXT_PIR_Station_Code__c')
                                        +'@'+(String)incident.get('R2_INC_TXT_PIR_Airline_Code__c')
                                        +'@'+(String)incident.get('R2_INC_TXT_PIR_Reference_Number__c')
                                        +'@'+'1278'
                                        +'@'+(String)incident.get('RecordTypeId') //SF RT
                                        +'@'+this.recordTypeSearch // WT RT DEV NAME
                                        +'@'+String.valueof(incident.get('R2_INC_DAT_PIR_Claim_Date__c'))
                                        +'@'+this.auxTipo;
                    fieldObject.href = 'LeerPIR';//'+pirObject.pir;
                    //fieldObject.action = readRecord(pirObject);
                    fieldObject.onclick = 'openPir';
                }
                ////INCIDENCIA ASOCIADA - AR  -> de momento no mostramos ni guardamos, no deberia venir en el search
                //else if(field.contains('R2_INC_FOR_PIR_AR__c')){ //uso como auxiliar para concatenar y mostrar
                //    fieldObject.value = (String)incident.get('R2_INC_TXT_PIR_AR_Station_Code__c')
                //                        +(String)incident.get('R2_INC_TXT_PIR_AR_Airline_Code__c')
                //                        +(String)incident.get('R2_INC_TXT_PIR_AR_Reference_Number__c');
                //    fieldObject.label = fieldMap.get('R2_INC_FOR_PIR_AR__c').getDescribe().getLabel();
                //    fieldObject.name  = (String)incident.get('R2_INC_TXT_PIR_AR_Station_Code__c')
                //                        +'@'+(String)incident.get('R2_INC_TXT_PIR_AR_Airline_Code__c')
                //                        +'@'+(String)incident.get('R2_INC_TXT_PIR_AR_Reference_Number__c')
                //                        +'@'+'1278';  //UserInfo.getUserId()
                //    fieldObject.href = 'LeerPIR';//'+pirObject.pir;
                //    //fieldObject.action = readRecord(pirObject);
                //}
                //VUELO: airline+refNumber+fecha // R2_INC_LOO_Flight__c o R2_INC_FOR_Flight_number__c
                else if(field.contains('R2_INC_LOO_Flight__r.R1_FLG_TXT_Flight_number__c')){ //uso como auxiliar para concatenar y mostrar
                    System.debug('debug FIELD::::::::'+field);
                    fieldObject.value =(String)incident.get('R2_ADI_TXT_BR_Flight_number__c')
                                        +(String)incident.get('R2_ADI_DAT_BR_Flight_Date__c')
                                        +(String)incident.get('R2_ADI_TXT_BR_Airline_Code__c');//'R2_INC_LOO_Flight__r.R1_FLG_TXT_Flight_number__c');
                    /*                   br.R2_ADI_TXT_BR_Flight_number__c = resp.bagRecords[i].originalBags[b].flightDateOrARNK.flightDate.flightNumber;
                                br.R2_ADI_DAT_BR_Flight_Date__c = resp.bagRecords[i].originalBags[b].flightDateOrARNK.flightDate.flightDate;
                                br.R2_ADI_TXT_BR_Airline_Code__c = resp.bagRecords[i].originalBags[b].flightDateOrARNK.flightDate.airlinecode;
                   */ fieldObject.label = fieldMap.get('R2_INC_LOO_Flight__r.R1_FLG_TXT_Flight_number__c').getDescribe().getLabel();
                    fieldObject.name = 'R2_INC_LOO_Flight__r.R1_FLG_TXT_Flight_number__c';
                    fieldObject.href = '/'+pirObject.pir;
                }
                //Nombre:
                else if(field.contains('R2_INC_TXT_PIR_Name__c')){ //uso como auxiliar para concatenar y mostrar
                    System.debug('debug FIELD::::::::'+field);
                    fieldObject.value =(String)incident.get('R2_INC_TXT_PIR_Name__c');//pirResp.R2_INC_TXT_PIR_Name__c = resp.bagRecords[i].names[0];
                    fieldObject.label = fieldMap.get('R2_INC_TXT_PIR_Name__c').getDescribe().getLabel();
                    fieldObject.name = 'R2_INC_TXT_PIR_Name__c';
                    //fieldObject.href = '/'+pirObject.pir;
                }
                else if(field.contains('_DAT_') || field.contains('_DATH_')){ //controlamos si entra una fecha
                    System.debug('debug FIELD::::::::'+field);
                    fieldObject.value = String.valueOf(incident.get(field));
                    System.debug('debug campo a campo::::::::'+fieldObject.value);
                    fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    fieldObject.name = field;
                }
                //TIPO DE INCIDENCIA
          /*      else if(field.contains('R2_INC_DATH_PIR_Incidence_closed_date__c')){ //uso como auxiliar para concatenar y mostrar
                    fieldObject.value = (String)incident.get('R2_INC_DATH_PIR_Incidence_closed_date__c');
                    fieldObject.label = fieldMap.get('RecordType.DeveloperName').getDescribe().getLabel();
                    fieldObject.name = 'R2_INC_DATH_PIR_Incidence_closed_date__c';
                    //fieldObject.href = '/'+pirObject.pir;
                }
*/
                /*else if(field.contains('R2_INC_FOR_PIR_AR__c')){
                    fieldObject.value = (String)incident.get(field);
                    fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    fieldObject.name = field;
                    fieldObject.href = '/'+pirObject.pir;
                }*/
                else{
                    System.debug('debug FIELD::::::::'+field);
                    fieldObject.value = (String)incident.get(field);
                    System.debug('debug campo a campo::::::::'+fieldObject.value);
                    fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    fieldObject.name = field;
                }
            //    System.debug('fieldObject');
              //  System.debug(fieldObject);
                pirObject.fields.add(fieldObject);
            }
            incidencias.add(pirObject);
        }        return incidencias;
    }

    // public PageReference readRecord(){//PIR pirObject){
    //     System.debug('PageReference readRecord()');
    //
    //
    //     System.debug('requestRead: '+ requestRead);
    //     String stationCode;
    //     String airlinecode;
    //     String referenceNumber;
    //     String agentId;
    //     System.debug('Variables antes: '+ stationCode + airlinecode + referenceNumber + agentId);
    //     try{
    //         System.debug('Entro al try');
    //         List<String> lstRequest = requestRead.split('@');
    //         System.debug('lista SPLIT:::::::: '+ lstRequest);
    //         stationCode = lstRequest.size() >= 1 ? lstRequest[0] : 'ss';
    //         airlinecode = lstRequest.size() >= 2 ? lstRequest[1] : 'aa';
    //         referenceNumber = lstRequest.size() >= 3 ? lstRequest[2] : 'rr';
    //         agentId = lstRequest.size() == 4 ? lstRequest[3] : 'aa';
    //
    //         //airlinecode = 'IB'; stationCode = 'MAD';
    //
    //         System.debug('Variables DESPUES:::::::::::: '+ stationCode + airlinecode + referenceNumber + agentId);
    //         Id idbag = R1_CLS_Utilities.readRecord_WT('DELAYED', stationCode, airlinecode, referenceNumber, agentId, 1);
    //         System.debug('***ID bag de readRecord_AHL_DAH:::'+idbag);
    //         if(idbag != null){
    //             PageReference pageRef = new PageReference('/'+idbag);//'/a0g0E000000hFfUQAU');//+resId);//pirObject.pir); //'/apex/demo2'
    //             pageRef.setRedirect(true);
    //             return pageRef;
    //         }else{
    //             R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecord: idbag es null', 'error, idbag es null','', 'R2_Incident__c');
    //             return null;
    //         }
    //
    //
    //     }catch(Exception ex){
    //         R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecord', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
    //         return null;
    //     }
    // }

    // public String readRecordId(){//PIR pirObject){
    //     System.debug('PageReference readRecordId()');
    //
    //
    //     System.debug('requestRead: '+ requestRead);
    //     String stationCode;
    //     String airlinecode;
    //     String referenceNumber;
    //     String agentId;
    //     System.debug('Variables antes: '+ stationCode + airlinecode + referenceNumber + agentId);
    //     try{
    //         System.debug('Entro al try');
    //         List<String> lstRequest = requestRead.split('@');
    //         System.debug('lista SPLIT:::::::: '+ lstRequest);
    //         stationCode = lstRequest.size() >= 1 ? lstRequest[0] : 'ss';
    //         airlinecode = lstRequest.size() >= 2 ? lstRequest[1] : 'aa';
    //         referenceNumber = lstRequest.size() >= 3 ? lstRequest[2] : 'rr';
    //         agentId = lstRequest.size() == 4 ? lstRequest[3] : 'aa';
    //
    //         airlinecode = 'IB'; stationCode = 'MAD';
    //
    //         System.debug('Variables DESPUES:::::::::::: '+ stationCode + airlinecode + referenceNumber + agentId);
    //         Id idbag = R1_CLS_Utilities.readRecord_WT('DELAYED', stationCode, airlinecode, referenceNumber, agentId, 1);
    //         System.debug('ID bag de readRecord_AHL_DAH:::'+idbag);
    //         return idbag;
    //         //if(idbag != null){
    //         //    PageReference pageRef = new PageReference('/'+idbag);//'/a0g0E000000hFfUQAU');//+resId);//pirObject.pir); //'/apex/demo2'
    //         //    pageRef.setRedirect(true);
    //         //    return pageRef;
    //         //}else{
    //         //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecord: idbag es null', 'error, idbag es null','', 'R2_Incident__c');
    //         //    return null;
    //         //}
    //
    //
    //     }catch(Exception ex){
    //         R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecordId', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
    //         return null;
    //     }
    // }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    method remote from get id incidence when are doing a search with with PIR number
    IN:
    OUT:
    
    History:
     <Date>                     <Author>                            <Change Description>
    18/12/2017                  Alvaro Garcia Tapia                     Initial Version
    26/12/2017                  Alberto Puerto Collado                   Read + errorBusqueda
    ----------------------------------------------------------------------------------------------------------------------*/
    //@RemoteAction
    public void searchRecordByPIR(String tipo){
        try{
        System.debug('searchRecordByPIR');
            String recordType;
            String stationCode;
            String airlinecode;
            String referenceNumber;
            String agentId;
            //String auxiliarTipo;

            searchParams = cleanParams(searchParams);
            stationCode = searchParams.nPIR.subString(0,3);
            airlinecode = searchParams.nPIR.subString(3,5);
            referenceNumber = searchParams.nPIR.subString(5);
            agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;//'AgenTest';
            recordType = tipo;
            //auxiliarTipo = lstRequest.size() == 6  ? lstRequest[5] : 'tt'; 

            System.debug('Variables DESPUÉS:::::::::::: '+ stationCode + ';' + airlinecode + ';' + referenceNumber + ';' + agentId + ';' + recordType);
            //sólo va a venir a search by PIR CON ACTIVOS!! nunca con inactivos ya que puede haber más de uno y por tanto devolvemos lista y no 1 con redirección
            //idbag = null;
            //if(auxiliarTipo == 'inactive'){
                //idbag = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 3);
            //}else{
                //idbag = 'a0g0E0000024KhV';
                //idbag = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);
            //}
            //Id idbag = R1_CLS_Utilities.readRetiredRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);
            idbag = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);
            if(idbag == null){
                this.errorBusqueda = 'Número de PIR: '+ stationCode + airlineCode + referenceNumber + ' no encontrado en ' + tipoBusqueda;
            }
            System.debug('***ID bag de bag:::'+ idbag);

            //return idbag;
            
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.searchRecordByPIR', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            //return null;
        }
    }
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    read PIR Inactive when tipo and date are fulfilled

    IN:
    OUT:
    
    History:
     <Date>                     <Author>                            <Change Description>
    30/01/2018                  Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void searchRecordByPIR_Inactive(String tipo, String fecha){
      try{
        System.debug('searchRecordByPIR_Inactive');
            String recordType;
            String stationCode;
            String airlinecode;
            String referenceNumber;
            String agentId;
            String createdDate;

            searchParams = cleanParams(searchParams);
            stationCode = searchParams.nPIR.subString(0,3);
            airlinecode = searchParams.nPIR.subString(3,5);
            referenceNumber = searchParams.nPIR.subString(5);
            agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;//'AgenTest';
            createdDate = fecha;
            recordType = tipo;


            System.debug('Variables DESPUÉS:::::::::::: '+ stationCode + ';' + airlinecode + ';' + referenceNumber + ';' + agentId + ';' + recordType + ';' + createdDate);
          
            //idbag = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);
            idbag = R1_CLS_Utilities.readRecord_WTInactive(recordType, stationCode, airlinecode, referenceNumber, agentId, 3, createdDate);
            if(idbag == null){
                this.errorBusqueda = 'Número de PIR: '+ stationCode + airlineCode + referenceNumber + ' no encontrado en ' + tipoBusqueda;
            }
            System.debug('***ID bag de bag:::'+ idbag);

        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.searchRecordByPIR_Inactive', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Jaime Ascanta
        Company:        Accenture
        Description:    method remote from get id incidence
        IN:
        OUT:

        History:
         <Date>                     <Author>                         <Change Description>
        29/11/2017                  Jaime Ascanta                       Initial Version
        29/11/2017                  Alberto Puerto Collado              split
        29/01/2018                  Alberto Puerto Collado              Read + RT  
        ----------------------------------------------------------------------------------------------------------------------*/
    @RemoteAction
    public static String readRecordId(String requestData){
      try{
            String recordType;
            String stationCode;
            String airlinecode;
            String referenceNumber;
            String agentId;
            String createdDate;
            String auxiliarTipo;

            System.debug(':::requestData:::: '+ requestData);

            List<String> lstRequest = requestData.split('@');
            stationCode = lstRequest.size() >= 1 ? lstRequest[0] : null;
            airlinecode = lstRequest.size() >= 2 ? lstRequest[1] : null;
            referenceNumber = lstRequest.size() >= 3 ? lstRequest[2] : null;
            String alias  = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            agentId = alias != null ? alias : 'AgentSearch';//lstRequest.size() >= 4 ? lstRequest[3] : 'agenTest';
            String recordTypeSF = lstRequest.size() >= 5 ? lstRequest[4] : null;
            String recordTypeWT = lstRequest.size() >= 6 ? lstRequest[5] : null;
            createdDate = lstRequest.size()>= 7 ? lstRequest[6] : null;
            auxiliarTipo = lstRequest.size() == 8  ? lstRequest[7] : null; 

          //ahora recordType es ID, query para transformar a developerName
            //System.debug('!!!recordTypeSF: ' + recordTypeSF);
            //if(recordTypeSF != ''){
            //System.debug('!!!recordTypeSF: ' + recordTypeSF);
            //if (String.isNotEmpty(recordTypeSF)) {
            List<RecordType> rtLst = [SELECT id, DeveloperName FROM RecordType WHERE id =:recordTypeSF LIMIT 1];
            if (!rtLst.isEmpty()) {
                recordType = rtLst[0].DeveloperName;
            }else{
                recordType = recordTypeWT;
            }
                //recordType = [SELECT id, DeveloperName FROM RecordType WHERE id =:recordTypeSF].DeveloperName;
            //}
          

            System.debug('Variables DESPUES:::::::::::: '+ stationCode + '-' + airlinecode + '-' + referenceNumber + '-' + agentId + '-' + recordType + '-' + createdDate);

            Id idBag = null;
            if(auxiliarTipo == 'inactive'){
                idbag = R1_CLS_Utilities.readRecord_WTInactive(recordType, stationCode, airlinecode, referenceNumber, agentId, 3, createdDate);
            }else{
                idbag = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);
            }
            //Id idbag = R1_CLS_Utilities.readRetiredRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 1);

            System.debug('***ID bag de bag:::'+idbag);

            return idbag;

        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecordIdRemote', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            return null;
        }
    }

    //public PageReference readRecord(){//PIR pirObject){
    //    System.debug('PageReference readRecord()');

    //    R1_Incident__c inc;
    //    Id resId;
    //    try{
    //        ////////////////////
    //      System.debug('ANTES DE MAPEO');
    //        R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
    //        System.debug('TRAS BIGWP');
    //        R2_CLS_WT_Bags_Management.WpReq requestRead = new R2_CLS_WT_Bags_Management.WpReq();
    //        System.debug('TRAS requestREAD');
    //            R2_CLS_WT_Bags_Management.NewRecordType rt = new R2_CLS_WT_Bags_Management.NewRecordType();
    //                R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
    //                ar.stationCode = inc.R2_INC_TXT_PIR_AR_Station_Code__c;//'MAD';
    //                ar.airlineCode = inc.R2_INC_TXT_PIR_AR_Airline_Code__c;//'IB'; //
    //                ar.referenceNumber = inc.R2_INC_TXT_PIR_AR_Reference_Number__c; //'67894'; //R2_INC_TXT_PIR_AR_Reference_Number__c
    //            rt.recordReference = ar;
    //            rt.recordType = 'DELAYED';
    //        requestRead.recordId = rt;
    //        requestRead.agentId = '1278'; //duda

    //        System.debug('ANTES DESERIALIZE'+requestRead);
    //        bigWP.read = JSON.serialize(requestRead);
    //        System.debug('bigWP::::::::READ:'+bigWP.read);
    //        Id idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0);


    //        //if(pirObject.fields = 'DELAYED'){
    //        //R2_CLS_WT_Bags_Management.Wp_readDelayed_AHL_DAH response = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(pirObject.pir,0);
    //        //System.debug('???????????Llamando a IDPIR READ DAH / idpir = '+idPir);
    //        //resId = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(idPir,0);//pirObject.pir,0);
    //    //}else if(pirObject.bagType = 'DAMAGED'){

    //    //}
    //        System.debug('?????????????????resID  = '+idbag);
    //        PageReference pageRef = new PageReference('/apex/'+idbag);//'/a0g0E000000hFfUQAU');//+resId);//pirObject.pir); //'/apex/demo2'
    //        pageRef.setRedirect(true);
    //        return pageRef;
    //    }catch(Exception ex){
    //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_BAG_BagSearch.readRecord', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
    //        return null;
    //    }
    //}
    //CLASSES
    public String idPir {get;set;}
    public String requestRead {get;set;}

    public class PIR{
        public String pir {get;set;}
        public List<Field> fields {get;set;}
    }
    public class Field{
        public String label {get;set;}
        public String value {get;set;}
        public String name {get;set;}
        public String href {get;set;}
        public String onclick {get;set;}
    }
    public class Search{
        public String nExpediente {get;set;}
        public String fechaCreacion {get;set;}
        public String nPIR {get;set;}
        public String pirAsociado {get;set;}
        public String escala {get;set;}
        public String tipoIncidencia {get;set;}
        public String nombrePax {get;set;}
        public String etiqueta {get;set;}
        public String colorTipo {get;set;}
        public String estadoIncidencia {get;set;}
        public String tipoBBDD {get;set;}
        //public String tipoRegistro {get;set;}

        //public String compania {get;set;}
        //public String estacion {get;set;}

    }
    public static List<String> splitEscala(String splitME){
        String comp = splitME.substring(0,2);
        String est = splitME.substring(2,4);

        List<String> lstSplitted = new List<String>();
        lstSplitted.add(comp);
        lstSplitted.add(est);

        return lstSplitted;
    }
}