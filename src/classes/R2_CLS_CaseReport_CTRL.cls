/*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
17/10/2017                  Rubén Pingarrón Jerez                   Initial Version
19/04/2018                  Jaime Ascanta                      Refactorizado el codigo para ordenar filas de la tabla
----------------------------------------------------------------------------------------------------------------------*/
public class R2_CLS_CaseReport_CTRL {

    public String orderbyFieldCas {get; set;}
    public String orderbyFieldTelex {get; set;}
    public String ordenacionSentido;

    public String categoriaSelected {get; set;}
    public String idiomaSelected {get; set;}
    public String ownerSelected {get; set;}
    public String totalPageSelected {get; set;}

    public List<CaseTableItem> casesToShow {get; set;}
    public List<TelexTableItem> telexToShow {get; set;}

    public List<SelectOption> categorias {get; set;}
    public List<SelectOption> idiomas {get; set;}
    public List<SelectOption> owners {get; set;}
    public List<SelectOption> totalPage {get; set;}


    static final Map<String, String> MAP_IDIOMA_VALUE = new Map<String, String>();
    static final Map<String, String> MAP_IDIOMA_LABEL = new Map<String, String>();
    static{
        Schema.DescribeFieldResult fieldResultIdiom = Case.R1_CAS_PKL_Idioma__c.getDescribe();
        List<Schema.PicklistEntry> lstIdiom = fieldResultIdiom.getPicklistValues();
		for(Schema.PicklistEntry pickList : lstIdiom){
			MAP_IDIOMA_VALUE.put(picklist.getValue(), picklist.getLabel());
			MAP_IDIOMA_LABEL.put(picklist.getLabel(), picklist.getValue());
		}
	}

    static final Map<String, String> MAP_QUEUE_NAME = new Map<String, String>();
    static final Map<String, String> MAP_QUEUE_ID = new Map<String, String>();
    static{
        List<QueueSobject> propietarios = [SELECT Id, QueueId, Queue.Name FROM QueueSobject WHERE Queue.Name LIKE 'SYR%' OR Queue.Name LIKE 'USR%' ORDER BY Queue.Name Asc];
		for(QueueSobject queue : propietarios){
			MAP_QUEUE_NAME.put(queue.Queue.Name, queue.QueueId);
			MAP_QUEUE_ID.put(queue.QueueId, queue.Queue.Name);
		}
	}


    public R2_CLS_CaseReport_CTRL(){
        //Ordenacion por defecto
        orderbyFieldCas = 'CreatedDate';
        orderbyFieldTelex = 'CreatedDate';
        ordenacionSentido = 'DESC';

        this.totalPage = new List<SelectOption>();
        this.totalPage.add(new SelectOption('10', '10'));
        this.totalPage.add(new SelectOption('20', '20'));
        this.totalPage.add(new SelectOption('50', '50'));
        this.totalPage.add(new SelectOption('100', '100'));
        this.totalPage.add(new SelectOption('200', '200'));
        this.totalPage.add(new SelectOption('500', '500'));
        this.totalPage.add(new SelectOption('1000', '1000'));
        //this.totalPage.add(new SelectOption('all', 'Todo'));

        Schema.DescribeFieldResult fieldResultCateg = Case.R2_CAS_PKL_Vip_Type__c.getDescribe();
        List<Schema.PicklistEntry> lstCateg = fieldResultCateg.getPicklistValues();
        this.categorias = new List<SelectOption>();
        this.categorias.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstCateg){
            SelectOption selectOp = new SelectOption(picklist.getValue(), picklist.getLabel());
            this.categorias.add(selectOp);
        }


        Schema.DescribeFieldResult fieldResultIdiom = Case.R1_CAS_PKL_Idioma__c.getDescribe();
        List<Schema.PicklistEntry> lstIdiom = fieldResultIdiom.getPicklistValues();
        this.idiomas = new List<SelectOption>();
        this.idiomas.add(new SelectOption('', '-- None --'));
        for(Schema.PicklistEntry pickList : lstIdiom){
            SelectOption selectOp = new SelectOption(picklist.getValue(), picklist.getLabel());
            this.idiomas.add(selectOp);
        }

        this.owners = new List<SelectOption>();
        this.owners.add(new SelectOption('', '-- None --'));
        for(String nameOwn : MAP_QUEUE_ID.values()){
            SelectOption selectOp = new SelectOption(nameOwn, nameOwn);
            this.owners.add(selectOp);
        }

    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
    <Date>                     <Author>                         <Change Description>
    19/04/2018                  Jaime Ascanta                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void reRenderTables(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            if(ownerSelected=='SYR Action File'){
                mostrarMensajesTelex();
            }else{
                mostrarCasos();
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseReport_CTRL.reRenderTables()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
  Author:         Jaime Ascanta
  Company:        Accenture
  Description:

  History:
  <Date>                     <Author>                         <Change Description>
  19/14/2018                  Jaime Ascanta                    Initial Version
  ----------------------------------------------------------------------------------------------------------------------*/
  public void reorderTable(){
    try{
            if (R1_CLS_LogHelper.isRunningTest()) {throw new R1_CLS_LogHelper.R1_Exception('test');}
            if (ordenacionSentido == 'DESC') {
              ordenacionSentido = 'ASC';
            } else {
              ordenacionSentido = 'DESC';
            }

            reRenderTables();

        } catch(Exception exc) {
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_caseFilteredReport_CTRL.reorderTable()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
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
    17/10/2017                  Rubén Pingarrón Jerez            Initial Version
    19/04/2018                  Jaime Ascanta                    Refactorizado el codigo
    ----------------------------------------------------------------------------------------------------------------------*/
    public void mostrarCasos(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.System.debug('*** init mostrarCasos() ');
            System.System.debug('*** categoriaSelected: ' + categoriaSelected);
            System.System.debug('*** idiomaSelected: ' + idiomaSelected);
            System.System.debug('*** ownerSelected: ' + ownerSelected);
            System.System.debug('*** orderbyFieldCas: ' + orderbyFieldCas);
            System.System.debug('*** ordenacionSentido: ' + ordenacionSentido);

            if(ownerSelected!='SYR Action File'){

                List<Id> rtIds = new List<Id>();

                Id rtIdExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
                if(rtIdExp!=null) rtIds.add(rtIdExp);

                Id rtIdPro = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();
                if(rtIdPro!=null) rtIds.add(rtIdPro);

                String query = '';

                System.debug('*** rtIds ' +rtIds);

                if(categoriaSelected != null || idiomaSelected != null || ownerSelected != null){

                    query += 'SELECT Id, CaseNumber, Subject, Status, Origin, R2_CAS_PKL_Vip_Type__c, R1_CAS_FOR_Case_Number__c, R2_CAS_FOR_carrier_code_oper__c, R1_CAS_PKL_Idioma__c, RecordType.Name, CreatedDate, Owner.Name FROM Case WHERE RecordTypeId IN :rtIds';

                    if(categoriaSelected != null && categoriaSelected != ''){
                        query += ' AND R2_CAS_PKL_Vip_Type__c = :categoriaSelected ';
                    }

                    if(idiomaSelected != null && idiomaSelected != ''){
                        query += ' AND R1_CAS_PKL_Idioma__c = :idiomaSelected ';
                    }

                    if(ownerSelected != null && ownerSelected != ''){
                        if(MAP_QUEUE_NAME.containsKey(ownerSelected)){
                            String ownId = MAP_QUEUE_NAME.get(ownerSelected);
                            query += ' AND OwnerId = :ownId ';
                        }

                    }

                    if(orderbyFieldCas!=null){
                        query += ' ORDER BY '+orderbyFieldCas+' '+ordenacionSentido+' ';
                    }

                    if(totalPageSelected!=null && totalPageSelected!=''){
                        try{
                            Integer total = Integer.valueOf(totalPageSelected);
                            query += ' LIMIT '+total+' ';
                        }catch(Exception exc){
                            query += '';
                        }
                    }

                }

                System.debug('*** query: ' + query);

                System.debug('*** ownerSelected: ' + ownerSelected);

                List<Case> casosMostrados = query!='' ? Database.query(query) : null;

                System.debug('*** casosMostrados ' + casosMostrados);


                casesToShow = new List<CaseTableItem>();

                if(casosMostrados!=null && !casosMostrados.isEmpty()){
                    for(Case caso : casosMostrados){
                        CaseTableItem item = new CaseTableItem();
                        item.idCaso = caso.Id;
                        item.identificador = caso.R1_CAS_FOR_Case_Number__c;
                        item.fechaCreacion = Datetime.valueOf(caso.CreatedDate).format('dd/MM/yyyy hh:mm a');
                        item.asunto = caso.Subject;
                        item.tipo = caso.RecordType.Name;
                        item.owner = caso.Owner.Name;
                        item.canal = caso.Origin;
                        item.carrier = caso.R2_CAS_FOR_carrier_code_oper__c;
                        item.estado = caso.Status;
                        item.idioma = MAP_IDIOMA_VALUE.containsKey(caso.R1_CAS_PKL_Idioma__c) ? MAP_IDIOMA_VALUE.get(caso.R1_CAS_PKL_Idioma__c) : '';
                        item.categoria = caso.R2_CAS_PKL_Vip_Type__c;
                        casesToShow.add(item);
                    }
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseReport_CTRL.mostrarCasos()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }


    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
    <Date>                     <Author>                         <Change Description>
    19/04/2018                  Jaime Ascanta                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void mostrarMensajesTelex(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            System.System.debug('*** init mostrarMensajesTelex() ');
            System.System.debug('*** ownerSelected: ' + ownerSelected);
            System.System.debug('*** orderbyFieldTelex: ' + orderbyFieldTelex);
            System.System.debug('*** ordenacionSentido: ' + ordenacionSentido);

            if(ownerSelected=='SYR Action File'){

                String query = '';

                query += ' SELECT Id, Name, R2_MG_PKL_Type__c, RecordType.Name,  R2_MG_TXT_Area__c, R2_MG_ATXT_Message__c, R2_MG_TXT_TX__c, R2_MG_TXT_XF__c, R2_MG_HOU_DT_Hour__c FROM R2_MG_Message__c WHERE R2_MG_CHK_Processed__c = false ';

                if(ownerSelected != null && ownerSelected != ''){
                    if(MAP_QUEUE_NAME.containsKey(ownerSelected)){
                        String ownId = MAP_QUEUE_NAME.get(ownerSelected);
                        query += ' AND OwnerId = :ownId ';
                    }
                }

                if(orderbyFieldTelex!=null){
                    query += ' ORDER BY '+orderbyFieldTelex+' '+ordenacionSentido+' ';
                }

                if(totalPageSelected!=null && totalPageSelected!=''){
                    try{
                        Integer total = Integer.valueOf(totalPageSelected);
                        query += ' LIMIT '+total+' ';
                    }catch(Exception exc){
                        query += '';
                    }
                }

                System.debug('*** query: ' + query);

                List<R2_MG_Message__c> telexMostrados = query!='' ? Database.query(query) : null;

                telexToShow = new List<TelexTableItem>();

                if(telexMostrados!=null && !telexMostrados.isEmpty()){
                    for(R2_MG_Message__c msg : telexMostrados){
                        TelexTableItem item = new TelexTableItem();
                        item.idsf = msg.Id;
                        item.identificador = msg.Name;
                        item.type = msg.R2_MG_PKL_Type__c!=null ? msg.R2_MG_PKL_Type__c : '';
                        item.recordType = msg.RecordType.Name!=null ? msg.RecordType.Name : '';
                        item.area = msg.R2_MG_TXT_Area__c;
                        item.observaciones = msg.R2_MG_ATXT_Message__c;
                        item.xf = msg.R2_MG_TXT_XF__c;
                        item.tx = msg.R2_MG_TXT_TX__c;
                        item.dt = msg.R2_MG_HOU_DT_Hour__c!=null ? Datetime.valueOf(msg.R2_MG_HOU_DT_Hour__c).format('dd/MM/yyyy hh:mm a') : '';
                        telexToShow.add(item);
                    }
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_CaseReport_CTRL.mostrarMensajesTelex()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }


    public Class CaseTableItem{
        public String identificador {get; set;}
        public String asunto {get; set;}
        public String idioma {get; set;}
        public String categoria {get; set;}
        public String owner {get; set;}
        public String tipo {get; set;}
        public String estado {get; set;}
        public String fechaCreacion {get; set;}
        public String carrier {get; set;}
        public String canal {get; set;}
        public String idCaso {get; set;}
    }

    public Class TelexTableItem{
        public String idsf {get; set;}
        public String identificador {get; set;}
        public String type {get; set;}
        public String recordType {get; set;}
        public String area {get; set;}
        public String observaciones {get; set;}
        public String xf {get; set;}
        public String tx {get; set;}
        public String dt {get; set;}
    }

}