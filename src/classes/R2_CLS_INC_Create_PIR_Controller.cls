public with sharing class R2_CLS_INC_Create_PIR_Controller {

    private Integer maletaSelect = 0;
    private Integer totalMaletas;
    //private Map<String, String> mapType;
    
    //public Map<R2_Content_Baggage__c, Integer> mapPoscCont; 
    public Map<Integer, List<R2_Content_Baggage__c>> mapCont;
    //public List<R2_Baggage__c> lstBagsInicial;
    //public R2_Content_Baggage__c contUpdate;
    public List<R2_Content_Baggage__c> lstContent {get;set;}
    public List<R2_Content_Baggage__c> lstContent1;
    public List<R2_Content_Baggage__c> lstContent2;
    public List<R2_Content_Baggage__c> lstContent3;
    public List<R2_Content_Baggage__c> lstContent4;
    public List<R2_Content_Baggage__c> lstContent5;
    public List<R2_Content_Baggage__c> lstContent6;
    public List<R2_Content_Baggage__c> lstContent7;
    public List<R2_Content_Baggage__c> lstContent8;
    public List<R2_Content_Baggage__c> lstContent9;
    public List<R2_Content_Baggage__c> lstContent10;
    public List<R2_Content_Baggage__c> lstContInicial {get;set;}
    public List<R2_Baggage__c> bagLst {get;set;}
    public R2_Baggage__c bag {get;set;}
   //public R1_Incident__c incidencia {get;set;}
    
    public Integer numCont {get;set;}
    public String tipoCont {get;set;}
    public String desCont {get;set;}
    public String actionBag {get;set;}
    public Boolean verSaveUpdate {get;set;}
    //public String incidenciaID {get;set;}
    
    public String imgMaletaVacia {get;set;}
    public String imgMaletaOn {get;set;}
    public String imgMaletaLlena {get;set;}
    
    public String imgMaleta1 {get;set;}
    public String imgMaleta2 {get;set;}
    public String imgMaleta3 {get;set;}
    public String imgMaleta4 {get;set;}
    public String imgMaleta5 {get;set;}
    public String imgMaleta6 {get;set;}
    public String imgMaleta7 {get;set;}
    public String imgMaleta8 {get;set;}
    public String imgMaleta9 {get;set;} 
    public String imgMaleta10 {get;set;}
    
    public String imgTipoMaleta {get;set;}
    public String imgColorMaleta {get;set;}
    
    public Boolean susCT {get;set;}
    public Boolean susTN {get;set;}
    public Boolean susBI {get;set;}
    public Boolean susCC {get;set;}
    public Boolean boolBorrar {get;set;}
    
////////////////////////77----------------------------------------------------------///////////////////////////////////////////////7
    
    
    public String errorResponse{get;set;} //{errorResponse = '1';}
    public R2_WT_Wrappers_Create_Delayed.NewRecordType registro{get;set;}
    public List<R2_WT_Wrappers_Create_Delayed.WarningType> warnings{get;set;}
    public List<R2_WT_Wrappers_Create_Delayed.ErrorType> errors{get;set;}
    public Id newId{get;set;}
    public List<String> lstRespuestas{get;set;} //cambiar por string personalizado según errores o no.. etc
    public String informeCrear{get;set;}
    public Boolean informeSuccess{get;set;}
    R2_WT_Wrappers_Create_Delayed.WR_DelayedBagWebRespRecord resultado {get;set;}

    public class Field{
        public String label {get;set;}
        public String value {get;set;}
        public String name {get;set;}
        //public String recordType {get;set;}
		public Boolean required {get; set;}
		public String type {get; set;}
        public Boolean disabled {get; set;}
        public List<SelectOption> items {get;set;}
		// public List<Schema.PicklistEntry> picklistValues {get; set;}
    }

    public List<Field> incidentInformationSection1{get;set;}
    public List<Field> incidentInformationSection2{get;set;}
    public List<Field> incidentInformationSection3{get;set;}
    public List<Field> incidentInformationSection4{get;set;}
    public List<Field> incidentInformationSection5{get;set;}
    public List<Field> incidentInformationSection6{get;set;}
    public List<Field> incidentInformationSection7{get;set;}
    public List<Field> incidentInformationSection8{get;set;}
    public List<Field> incidentInformationSection9{get;set;}
    public List<Field> incidentInformationSection10{get;set;}

	public String incidentHeader {get; set;}

	private final Set<String> mandatoryFields = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c','R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c', 
																'R2_INC_TXT_PIR_Ticket_number__c', 'R2_INC_TLF_Landline1__c', // 'R2_INC_TLF_PIR_Mobile_phone_number1__c', 
																/*'R2_INC_TXT_PIR_Permanent_address1__c',*/ 'R2_INC_EMA_PIR_Email1__c', 'R2_INC_TXT_PIR_flight_Number__c', 
																'R2_INC_TXT_PIR_Baggage_Weight_piece__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c', 'R2_INC_TXT_PIR_Route__c',
																'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Passenger_category__c'
																};//, 'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Route__c', 'R2_INC_PKL_PIR_Send_SMS_email__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c'};
    //los campos de la lista son los que van a poder editarse
    private final Set<String> nonDisabledFields = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c', 'R2_INC_TXT_PIR_Responsible_Scale__c', 'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 
    															'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c',  'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c', 
    															'R2_INC_TXT_PIR_Initial2__c', 'R2_INC_TXT_PIR_Initial3__c', 'R2_INC_TXT_PIR_Treatment__c', 'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_TLF_Landline1__c', 
    															'R2_INC_TXT_PIR_Temporal_address1__c', 'R2_INC_TLF_PIR_Temporal_phone__c', /*'R2_INC_TXT_PIR_Permanent_address2__c',*/ 'R2_INC_TLF_Landline2__c', 
    															/*'R2_INC_TXT_PIR_Temporal_address2__c',*/ 'R2_INC_TLF_PIR_Temporal_phone2__c', 'R2_INC_TXT_PIR_Zip_code__c', 'R2_INC_TLF_PIR_Mobile_phone_number1__c', 
    															'R2_INC_TXT_PIR_Temporal_Zip_Code__c', 'R2_INC_TLF_PIR_Mobile_phone_number2__c', /*'R2_INC_DAT_PIR_Validity_temporal_address__c',*/ 'R2_INC_TXT_PIR_Treatment__c', 
    															'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c', 'R2_INC_TXT_PIR_FF_Identificator__c', 'R2_INC_TXT_PIR_Initial__c', 
    															'R2_INC_TXT_PIR_Initial2__c', 'R2_INC_TXT_PIR_Initial3__c', 'R2_INC_TXT_PIR_Passenger_language__c', 'R2_INC_TXT_PIR_Passenger_category__c', 'R2_INC_EMA_PIR_Email1__c', 
    															'R2_INC_EMA_PIR_Email2__c',  'R2_INC_TXT_PIR_Delivery_address1__c', /*'R2_INC_TXT_PIR_Delivery_address2__c',*/ 'R2_INC_TXT_PIR_Delivery_local_informatio__c', 
    															'R2_INC_TXT_PIR_Deliver_local_informatio2__c', 'R2_INC_TXT_PIR_PNR_locator__c', 'R2_INC_TXT_PIR_Ticket_number__c', 'R2_INC_PKL_PIR_Send_SMS_email__c', 
    															'R2_INC_TXT_PIR_flight_Number__c', 'R2_INC_TXT_PIR_Route__c', 'R2_INC_TXT_PIR_Baggage_destination__c', 'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c',
    															'R2_INC_TLF_PIR_Phone_number_suitcase1__c', 'R2_INC_TLF_PIR_Phone_number_suitcase2__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c',
    															'R2_INC_TXT_PIR_Address_in_suitcase1__c', 'R2_INC_TXT_Excess_Baggage__c', 'R2_INC_CHK_PIR_Limited_approval_label__c', 'R2_INC_TXT_PIR_Send_direction_FI__c', 'R2_INC_TXT_PIR_Control_information2__c', 
    															'R2_INC_PKL_PIR_Copy_for_the_company_HC__c', 'R2_INC_TXT_PIR_Control_information1__c', 'R2_INC_TXT_PIR_Baggage_route__c', 'R2_INC_CHK_PIR_Baggage_insurance__c', 'R2_INC_TXT_PIR_Lost_reason__c', 
    															  'R2_INC_TXT_PIR_Washing_kit__c', 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c', 'R2_INC_TXT_PIR_Lost_reason_causes__c', 'R2_INC_TXT_Last_Seen__c' 
                                                                 }; //'R2_INC_TXT_PIR_Lost_reason_causes__c',

	private final Set<String> fieldsIncidentSection1 = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c', /*'R2_INC_FOR_PIR_AR__c',*/ /*'R2_INC_DAT_PIR_Claim_Date__c',*/ /*'R2_INC_DAT_PIR_Last_mapping_date__c', */
																		/*'R2_INC_LOO_Case__c', 'R2_INC_DAT_PIR_Search_start_date__c',*/ /*'R2_PIR_DAT_PIR_Full_reintegration_date__c','R2_INC_TXT_PIR_Control_office__c',*/  
																		/*'R2_INC_NUM_PIR_Associated_Cases__c', 'R2_INC_DAT_PIR_Cancellation_date__c',*/ /*'R2_INC_DAT_PIR_Date_back_primary_search__c',*/ /*'R2_INC_DAT_PIR_Control_date__c',*/ 
																		/*'RecordTypeId',*/ /*'R2_INC_DAT_PIR_Unsuccessful_search__c',*/ 'R2_INC_TXT_PIR_Responsible_Scale__c', /*'R2_INC_DATH_PIR_Incidence_closed_date__c',*/ 
																		/*'R2_INC_TXT_PIR_Agent__c', 'R2_INC_TXT_PIR_Report_PIR__c', 'R2_INC_TXT_PIR_VIP_Account__c', 'R2_INC_PKL_PIR_Status_incidence__c', 'R2_INC_DAT_PIR_Claims_Created_Date__c',*/
                                                                        'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c'
																		/*, 'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c'*/
																		};
	private final Set<String> fieldsAuxiliarSection1 = new Set<String> {/*'R2_ADI_FOR_XR_Record_Reference__c'*/};

	private final Set<String> fieldsIncidentSection2 = new Set<String> {'R2_INC_TXT_PIR_Treatment__c', 'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c',  
                                                                        'R2_INC_TXT_PIR_FF_Identificator__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Initial2__c', 'R2_INC_TXT_PIR_Initial3__c', 
                                                                        'R2_INC_TXT_PIR_Passenger_language__c', 'R2_INC_TXT_PIR_Passenger_category__c', 'R2_INC_EMA_PIR_Email1__c', 'R2_INC_EMA_PIR_Email2__c',  
                                                                        'R2_INC_TXT_PIR_Delivery_address1__c', /*'R2_INC_TXT_PIR_Delivery_address2__c',*/ 'R2_INC_TXT_PIR_Delivery_local_informatio__c', 'R2_INC_TXT_PIR_Deliver_local_informatio2__c', 
                                                                        'R2_INC_TXT_PIR_PNR_locator__c', 'R2_INC_TXT_PIR_Ticket_number__c', 'R2_INC_PKL_PIR_Send_SMS_email__c'};
	private final Set<String> fieldsAuxiliarSection2 = new Set<String> {};

	private final Set<String> fieldsIncidentSection3 = new Set<String> {'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_TLF_Landline1__c', 'R2_INC_TXT_PIR_Temporal_address1__c', 'R2_INC_TLF_PIR_Temporal_phone__c', /*'R2_INC_TXT_PIR_Permanent_address2__c',*/
																		'R2_INC_TLF_Landline2__c', /*'R2_INC_TXT_PIR_Temporal_address2__c',*/ 'R2_INC_TLF_PIR_Temporal_phone2__c', 'R2_INC_TXT_PIR_Zip_code__c', 'R2_INC_TLF_PIR_Mobile_phone_number1__c', 'R2_INC_TXT_PIR_Temporal_Zip_Code__c',
																		'R2_INC_TLF_PIR_Mobile_phone_number2__c' //, 'R2_INC_DAT_PIR_Validity_temporal_address__c'
																		};
	private final Set<String> fieldsAuxiliarSection3 = new Set<String> {};

	private final Set<String> fieldsIncidentSection4 = new Set<String> {'R2_INC_TXT_PIR_flight_Number__c', 'R2_INC_TXT_PIR_Route__c', 'R2_INC_TXT_PIR_Baggage_route__c'};
	private final Set<String> fieldsAuxiliarSection4 = new Set<String> {};//'R2_INC_TXT_PIR_Route__c'};

	private final Set<String> fieldsIncidentSection5 = new Set<String> {'R2_INC_TXT_PIR_Send_direction_FI__c', 'R2_INC_TXT_PIR_Control_information1__c', 'R2_INC_TXT_PIR_Control_information2__c', 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c'};
	private final Set<String> fieldsAuxiliarSection5 = new Set<String> {};//'R2_ADI_TXT_FF_Observation__c', 'R2_ADI_TXT_UC_User_Comment__c'};

	private final Set<String> fieldsIncidentSection6 = new Set<String> {};
	private final Set<String> fieldsAuxiliarSection6 = new Set<String> {};//'R2_ADI_ATXTL_DY_Delivery_Info__c'};

	private final Set<String> fieldsIncidentSection7 = new Set<String> {'R2_INC_TXT_Last_Seen__c', /*'R2_INC_TXT_PIR_Lost_content1__c', 'R2_INC_TXT_PIR_Lost_content2__c',*/ 'R2_INC_TXT_PIR_Address_in_suitcase1__c', 
															            /*'R2_INC_TXT_PIR_Address_in_suitcase2__c', */'R2_INC_TXT_Excess_Baggage__c', 'R2_INC_TLF_PIR_Phone_number_suitcase1__c', 'R2_INC_TLF_PIR_Phone_number_suitcase2__c', 
															            'R2_INC_TXT_PIR_Baggage_destination__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c', 
															            'R2_INC_CHK_PIR_Limited_approval_label__c'
																		};
	private final Set<String> fieldsAuxiliarSection7 = new Set<String> {};//'R2_ADI_ATXTL_DS_Delivery_service__c'};

	private final Set<String> fieldsIncidentSection8 = new Set<String> {'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_CHK_PIR_Baggage_insurance__c', 'R2_INC_TXT_PIR_Lost_reason__c', /*'R2_INC_TXT_PIR_Special_lost_reason__c', */ 
																		'R2_INC_TXT_PIR_Lost_reason_causes__c', 'R2_INC_TXT_PIR_Washing_kit__c' //, 'R2_INC_TXT_PIR_DO_Flight__c'
																		};
	private final Set<String> fieldsAuxiliarSection8 = new Set<String> {};//'R2_ADI_TXT_CR_Remarks_Cost__c'};

	private final Set<String> fieldsIncidentSection9 = new Set<String> {};
	private final Set<String> fieldsAuxiliarSection9 = new Set<String> {};//'R2_ADI_ATXTL_MR_Match__c'};

	private final Set<String> fieldsIncidentSection10 = new Set<String> {};
	private final Set<String> fieldsAuxiliarSection10 = new Set<String> {};//'R2_ADI_ATXTL_MG_Message__c'};

	private final List<Set<String>> listSectionIncidentFields = new List<Set<String>> {fieldsIncidentSection1, fieldsIncidentSection2, fieldsIncidentSection3, fieldsIncidentSection4, fieldsIncidentSection5, fieldsIncidentSection6, fieldsIncidentSection7, fieldsIncidentSection8, fieldsIncidentSection9, fieldsIncidentSection10};
	private final List<Set<String>> listSectionAuxiliarFields = new List<Set<String>> {fieldsAuxiliarSection1, fieldsAuxiliarSection2, fieldsAuxiliarSection3, fieldsAuxiliarSection4, fieldsAuxiliarSection5, fieldsAuxiliarSection6, fieldsAuxiliarSection7, fieldsAuxiliarSection8, fieldsAuxiliarSection9, fieldsAuxiliarSection10};

	private R1_Incident__c incident;
	private R2_Auxiliar_Data_Incident__c auxIncident;
	private String incidentId;

	public R2_CLS_INC_Create_PIR_Controller() {
        totalMaletas = 0;
        numCont = 0;
        
        bag = new R2_Baggage__c();
        bagLst = new List<R2_Baggage__c>();
        //bagLst.add(bag);
        mapCont = new Map<Integer, List<R2_Content_Baggage__c>>();
        //lstContent = new List<R2_Content_Baggage__c>();
        lstContent1 = new List<R2_Content_Baggage__c>();
        lstContent2 = new List<R2_Content_Baggage__c>();
        lstContent3 = new List<R2_Content_Baggage__c>();
        lstContent4 = new List<R2_Content_Baggage__c>();
        lstContent5 = new List<R2_Content_Baggage__c>();
        lstContent6 = new List<R2_Content_Baggage__c>();
        lstContent7 = new List<R2_Content_Baggage__c>();
        lstContent8 = new List<R2_Content_Baggage__c>();
        lstContent9 = new List<R2_Content_Baggage__c>();
        lstContent10 = new List<R2_Content_Baggage__c>();
        mapCont.put(0, lstContent1);
        mapCont.put(1, lstContent2);
        mapCont.put(2, lstContent3);
        mapCont.put(3, lstContent4);
        mapCont.put(4, lstContent5);
        mapCont.put(5, lstContent6);
        mapCont.put(6, lstContent7);
        mapCont.put(7, lstContent8);
        mapCont.put(8, lstContent9);
        mapCont.put(9, lstContent10);
        verSaveUpdate = false;
        cargarVisual();
        
        
 ////////////////////////77----------------------------------------------------------///////////////////////////////////////////////7       
        
        
		incidentId = ApexPages.currentPage().getParameters().get('incidentId');
        informeSuccess = false;
		if (incidentId != null && incidentId != '') {
			initializeObjects(incidentId);
			incidentHeader = 'Modify Delay Incident ' + incidentId;
		} else {
			incidentHeader = 'Crear nuevo PIR: Demora';
		}
		incidentInformationSection1 = getIncidentInformation(1); incidentInformationSection2 = getIncidentInformation(2);
	    incidentInformationSection3 = getIncidentInformation(3); incidentInformationSection4 = getIncidentInformation(4);
		incidentInformationSection5 = getIncidentInformation(5); incidentInformationSection6 = getIncidentInformation(6);
		incidentInformationSection7 = getIncidentInformation(7); incidentInformationSection8 = getIncidentInformation(8);
	    incidentInformationSection9 = getIncidentInformation(9); incidentInformationSection10 = getIncidentInformation(10);
	}

	private void initializeObjects(String incidentId) {
		Set<String> fieldsIncident = new Set<String>();
		for (Set<String> fieldSection : listSectionIncidentFields) {
			fieldsIncident.addAll(fieldSection);
		}
		System.debug(generateQueryString(fieldsIncident, 'R1_Incident__c', incidentId));

		Set<String> auxIncident = new Set<String>();
		for (Set<String> fieldSection : listSectionAuxiliarFields) {
			auxIncident.addAll(fieldSection);
		}
		System.debug(generateQueryString(auxIncident, 'R2_Auxiliar_Data_Incident__c', incidentId));
	}

	private String generateQueryString(Set<String> listOfFields, String objectName, String objectId) {
		String whereField = (objectName == 'R1_Incident__c')? 'Id' : 'R2_ADI_MSDT_Incident__c';
		String query = 'SELECT Id';
		for (String field : listOfFields){
			query += ', ' + field;
		}
		query += ' FROM ' + objectName;   
		query += ' WHERE ' + whereField + ' = \'' + objectId + '\' LIMIT 1';
		return query;
	}

    public List<Field> getIncidentInformation(Integer section){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            List<Field> fields = getFields('R1_Incident__c', listSectionIncidentFields[section-1]);
            fields.addAll(getFields('R2_Auxiliar_Data_Incident__c', listSectionAuxiliarFields[section-1]));
            return fields;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Create_PIR_Controller.getIncidentInformation()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
            return null;
        }  
    }

    public List<Field> getFields(String objectName, Set<String> listFields){
		List<Field> incidencias = new List<Field>();
        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(objectName);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        Field fieldObject;
        for(String field : listFields){
			Schema.DescribeFieldResult describeFieldResult = fieldMap.get(field).getDescribe();
            fieldObject = new Field();
            fieldObject.label = describeFieldResult.getLabel();
			fieldObject.required = mandatoryFields.contains(field);
			fieldObject.type = getType(describeFieldResult.getType());
            fieldObject.items = getItems(field);
            //if(nonDisabledFields.contains(field)){
            //    fieldObject.disabled = false;
            //}else{
            //    fieldObject.disabled = true;
            //}
            fieldObject.disabled = !nonDisabledFields.contains(field);

            // fieldObject.type = describeFieldResult.getType();
			// if (fieldObject.type == Schema.DisplayType.Picklist) {
			// 	fieldObject.picklistValues = describeFieldResult.getPicklistValues();
			// }
            fieldObject.name = field;
            incidencias.add(fieldObject);
            //System.debug(fieldObject.name + '####' +fieldObject.disabled);
        }
		return incidencias;
    }

	private String getType(Schema.DisplayType type) {
        if (type == Schema.DisplayType.Date) {
            return 'date';
        } else if (type == Schema.DisplayType.Integer) {
            return 'number';
        } else if (type == Schema.DisplayType.DateTime) {
            return 'datetime';
        } else if (type == Schema.DisplayType.Phone) {
            return 'tel';
        } else if (type == Schema.DisplayType.Boolean) {
            return 'checkbox';
        }else if (type == Schema.DisplayType.Picklist) {
            return 'picklist';
        }else {
            return 'text';
        }
    }

    private List<SelectOption> getItems(String name) {
        List<SelectOption> options = new List<SelectOption>();
        if (name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c'){
            options.add(new SelectOption('NO','NO'));
            options.add(new SelectOption('YES','YES'));
        }
        if (name == 'R2_INC_PKL_PIR_Send_SMS_email__c'){
            options.add(new SelectOption('','--Select Option--'));
            options.add(new SelectOption('SMS','SMS (S)'));
            options.add(new SelectOption('EMAIL','EMAIL (E)'));   
            options.add(new SelectOption('SMS_AND_EMAIL','SMS AND EMAIL (Y)'));
            options.add(new SelectOption('NO_MESSAGE','NO MESSAGE (N)'));  
//SMS, EMAIL, SMS_AND_EMAIL, NO_MESSAGE, MANUAL, MANUAL_SMS, MANUAL_EMAIL, MANUAL_SMS_AND_EMAIL 
        }
        return options;
    }


    /*---------------------------------------------------------------------------------------------------------------------
        Author:         Ulises Paniego Hidalgo
        Company:        Accenture - working on it
        Description:    create
        IN:
        OUT:

        History:
         <Date>                     <Author>                         <Change Description>
        23/11/2017             Ulises Paniego Hidalgo                  Initial Version
        24/11/2017             Miguel Nuñez Díaz-Montes                Wrappers & Mapping with visual 
        30/11/2017             Alberto Puerto Collado                  hago backup de la clase y testeo en siguiente método con nuevos wrappers hechos con kerokuapp de json que funciona
        09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT
    ----------------------------------------------------------------------------------------------------------------------*/
    public void createPIR(){
        try{
            R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR =  new R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku();

            //String goodJson = '{   "additionalInfo":{      "customsInfo":"UPDATE CUSTOM",      "furtherInfo":"UPDATE FURTHER",      "miscellaneousInfo":null,      "supplementaryInfo":[         {            "seq":"1",            "supplimentInfoText":"UPDATE SUPPL"         }      ],      "userComments":[         {            "commentsText":"UPDATE COMMENTS",            "seq":"2"         }      ]   },   "agentId":"n433081",   "claim":{      "claimData":{         "claimAmount":{            "amount":{               "amountValue":"9500",               "currencyCode":"GBP",               "decimalPlace":"2"            }         },         "claimDate":"2017-03-14",         "costRemarks":[            "cmn:CostRemarks"         ],         "excessValue":{            "amountValue":"200",            "currencyCode":"USD",            "decimalPlace":"1"         },         "faultStationCode":"MAD",         "faultTerminal":"T2",         "lossComments":"cmn:LossComments",         "lossReasonCode":"20",         "missingBags":"10",         "notifiedDate":"2017-03-14",         "partnerCode":{            "carrrierCode":"AB"         },         "passengerPayments":{            "passengerPaymentsValue":[               {                  "amount":{                     "amountValue":"2500",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               },               {                  "amount":{                     "amountValue":"1000",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               }            ]         },         "questionnaireDate":"2017-03-14",         "toiletKits":{            "toiletKitsFemale":"2"         }      }   },   "crossReferenceRecord":[      {         "recordReference":{            "airlineCode":"IB",            "referenceNumber":"98711",            "stationCode":"MAD"         },         "recordType":"DELAYED"      }   ],   "delayedBagGroup":{      "bagAddress":{         "addressLine":{            "addressLineDesc":"addressLine"         },         "country":{            "countryCode":"BN",            "countryName":"Country"         },         "postalCode":"BZ",         "state":{            "StateCode":"ST",            "stateDesc":"ES"         }      },      "bagDeliveryAddress":{         "deliveryAddress":{            "addressLine":{               "addressLineDesc":"AddressLineDesc"            },            "city":"city",            "country":{               "countryCode":"BN",               "countryName":"Country"            },            "postalCode":"BZ",            "state":{               "stateCode":"BN",               "stateDesc":"Desc"            }         },         "deliveryInfo":[            "cmn:DeliveryInfo"         ],         "deliveryService":[            "cmn:DeliveryService"         ],         "deliveryWeight":"20",         "localDlvInfo":[            {               "divInfo":"cmn:DivInfo",               "seq":"3"            }         ]      },      "bagLastSeen":"LHR",      "bagPhones":{         "phone":[            "84385361559440122333"         ]      },      "bagTagDestinations":{         "station":[            {               "stationValue":"MAD"            }         ]      },      "bagWeight":"10",      "baggageItinerary":{         "flightDateOrARNK":[            {               "flightDate":{                  "airlineCode":"IB",                  "date":"2017-09-12",                  "flightNumber":"3170"               }            }         ]      },      "contentsGender":"M",      "delayedBags":[         {            "associatedRecord":{               "recordReference":{                  "airlineCode":"IB",                  "referenceNumber":"987011",                  "stationCode":"MAD"               },               "recordType":"DELAYED"            },            "bagContents":{               "content":[                  {                     "category":"ALCOHOL",                     "description":"cmn:Description"                  },                  {                     "category":"Camisa",                     "description":"Azul"                  },                  {                     "category":"Ipad",                     "description":"Ipad Air Blanco"                  }               ]            },            "bagDelivery":{               "bagReceived":{                  "bagReceivedDate":"2017-09-12T09:05:50",                  "station":"MAD"               },               "deliveredTime":"2017-09-19T09:05:50",               "status":{                  "delivered":"cmn:Delivered",                  "outForDelivery":"cmn:OutForDelivery",                  "trackingUpdate":"cmn:TrackingUpdate",                  "unableToDeliver":"cmn:UnableToDeliver"               }            },            "bagDetails":"cmn:BagDetails",            "bagReceivedFromCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagSentToCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagTag":{               "airlineCode":"IB",               "licenseNumber":{                  "issuerCode":"123",                  "tagType":"2"               },               "tagSequence":"556985"            },            "brandInfo":{               "brandInfo":"MNA"            },            "colorTypeDesc":{               "colorCode":"WT",               "descriptor":{                  "materialElement":"X",                  "otherElement":[                     "W",                     "B"                  ]               },               "typeCode":"5"            },            "contentDescription":"cmn:ContentDescription",            "lockCode":"lock12",            "remarks":[               "cmn:Remarks"            ],            "storageLocation":"cmn:StorageLocation",            "uniqueId":{               "uniqueID":"2556-5698-4152"            }         }      ],      "excessBaggage":"ExcessBaggage",      "matchWindow":"2",      "missingWeight":"3"   },   "designatedLocator":"AMDI",   "handledAirlineCopyIndicator":"YES",   "passengers":{      "autoMessageOption":"MANUAL",      "contactInfo":{         "cellPhones":[            {               "phone":"1234567890"            }         ],         "emails":[            {               "email":"cmnEmail@mail.com"            },            {               "email":"cmnEmail@mail.com"            }         ],         "faxes":[            {               "fax":"cmn:Fax"            }         ],         "permanentAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "StateCode":"ST",               "stateDesc":"ES"            }         },         "permanentPhones":[            {               "phone":"1234567890"            }         ],         "temporaryAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "stateCode":"ST",               "stateDesc":"ES"            }         },         "temporaryPhones":[            {               "phone":"1234567890"            }         ]      },      "fareBasis":"Basis",      "frequentFlyerId":"XS123345678",      "initials":[         {            "initial":"a"         }      ],      "itinerary":{         "flightSegmentsorARNK":[            {               "flight":{                  "flightandDate":{                     "airlineCode":"XS",                     "date":"2017-11-11",                     "flightNumber":"413Q"                  },                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "arnk":{                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "flight":{                  "flightandDate":{                     "airlineCode":"IB",                     "date":"2017-11-11",                     "flightNumber":"413S"                  },                  "originDestination":{                     "destination":"MAD",                     "origin":"MAA"                  }               }            }         ]      },      "language":"English",      "names":[         {            "name":"nameExample"         }      ],      "numberOfPassengers":"2",      "passportInfo":"cmn:PassportInfo",      "pnr":"58624",      "pooledTicketNumber":"TicketNumber",      "status":"cmn:Status",      "ticketNumber":"1256984",      "title":"cmn:Title"   },   "refStationAirline":{      "stationAirline":"IB",      "stationCode":"MAD"   },   "teletypeAddresses":[      "ABCA9A9"   ]}';
            //ampliado 14/12/2017
            //String goodJson = '{"additionalInfo":{"customsInfo":"UPDATE CUSTOM","furtherInfo":"UPDATE FURTHER","matchInfo":{"matchInfoText":"MessageInfoText","seq":"1"},"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"supplementaryInfo":[{"seq":"1","supplimentInfoText":"UPDATE SUPPL"}],"userComments":[{"commentsText":"UPDATE COMMENTS","seq":"2"}]},"agentId":"n433081","claim":{"claimData":{"claimAmount":{"amount":{"amountValue":"9500","currencyCode":"GBP","decimalPlace":"2"}},"claimDate":"2017-03-14","costRemarks":["cmn:CostRemarks"],"excessValue":{"amountValue":"200","currencyCode":"USD","decimalPlace":"1"},"faultStationCode":"MAD","faultTerminal":"T2","insurance":true,"liabilityTag":true,"lossComments":"cmn:LossComments","lossReasonCode":"20","missingBags":"10","notifiedDate":"2017-03-14","partnerCode":{"carrrierCode":"AB"},"passengerPayments":{"passengerPaymentsValue":[{"amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"},{"amount":{"amountValue":"1000","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"}]},"questionnaireDate":"2017-03-14","toiletKits":{"toiletKitsFemale":"2"}}},"crossReferenceRecord":[{"recordReference":{"airlineCode":"IB","referenceNumber":"98711","stationCode":"MAD"},"recordType":"DELAYED"}],"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"addressLine"},"country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"StateCode":"ST","stateDesc":"ES"}},"bagDeliveryAddress":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc"},"city":"city","country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"stateCode":"BN","stateDesc":"Desc"}},"deliveryInfo":["cmn:DeliveryInfo"],"deliveryService":["cmn:DeliveryService"],"deliveryWeight":"20","localDlvInfo":[{"divInfo":"cmn:DivInfo","seq":"3"}]},"bagLastSeen":"LHR","bagPhones":{"phone":["84385361559440122333"]},"bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"bagWeight":"10","baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","date":"2017-09-12","flightNumber":"3170"}}]},"contentsGender":"M","delayedBags":[{"associatedRecord":{"recordReference":{"airlineCode":"IB","referenceNumber":"987011","stationCode":"MAD"},"recordType":"DELAYED"},"bagContents":{"content":[{"category":"Albornoz","description":"Rojo ejecutivo, de seda special selection"},{"category":"Camisa","description":"Azul"},{"category":"Ipad","description":"Ipad Air Blanco"},{"category":"Neceser","description":"NBA Style azul y amarillo, con un cepillo de dientes de gran valor sentimental"}]},"bagDelivery":{"bagReceived":{"bagReceivedDate":"2017-09-12T09:05:50","station":"MAD"},"deliveredTime":"2017-09-19T09:05:50","status":{"delivered":"cmn:Delivered","outForDelivery":"cmn:OutForDelivery","trackingUpdate":"cmn:TrackingUpdate","unableToDeliver":"cmn:UnableToDeliver"}},"bagDetails":"cmn:BagDetails","bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagTag":{"airlineCode":"IB","licenseNumber":{"issuerCode":"123","tagType":"2"},"suspended":false,"tagSequence":"556985"},"brandInfo":{"brandInfo":"MNA","suspended":false},"colorTypeDesc":{"colorCode":"WT","descriptor":{"materialElement":"X","otherElement":["W","B"]},"suspended":false,"typeCode":"5"},"contentDescription":"cmn:ContentDescription","lockCode":"lock12","remarks":["cmn:Remarks"],"storageLocation":"cmn:StorageLocation","uniqueId":{"uniqueID":"2556-5698-4152"}}],"excessBaggage":"ExcessBaggage","keysCollected":true,"matchWindow":"2","missingWeight":"3"},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","passengers":{"additionalRoutes":{"route":["MAD"]},"autoMessageOption":"MANUAL","contactInfo":{"cellPhones":[{"phone":"1234567890"}],"emails":[{"email":"cmnEmail@mail.com"},{"email":"cmnEmail@mail.com"}],"faxes":[{"fax":"cmn:Fax"}],"permanentAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"StateCode":"ST","stateDesc":"ES"}},"permanentPhones":[{"phone":"1234567890"}],"temporaryAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"stateCode":"ST","stateDesc":"ES"}},"temporaryPhones":[{"phone":"1234567890"}],"validityDate":"2018-02-20"},"fareBasis":"Basis","frequentFlyerId":"XS123345678","initials":[{"initial":"H"},{"initial":"T"},{"initial":"T"}],"itinerary":{"flightSegmentsorARNK":[{"flight":{"flightandDate":{"airlineCode":"XS","date":"2017-11-11","flightNumber":"413Q"},"originDestination":{"destination":"MAA","origin":"LHR"}}},{"arnk":{"originDestination":{"destination":"MAA","origin":"LHR"}}},{"flight":{"flightandDate":{"airlineCode":"IB","date":"2017-11-11","flightNumber":"413S"},"originDestination":{"destination":"MAD","origin":"MAA"}}}]},"language":"English","names":[{"name":"Howarang"},{"name":"Tekken"},{"name":"TaeKwonDo"}],"numberOfPassengers":"2","passportInfo":"cmn:PassportInfo","pnr":"58624","pooledTicketNumber":"TicketNumber","status":"cmn:Status","ticketNumber":"1256984","title":"cmn:Title"},"refStationAirline":{"stationAirline":"IB","stationCode":"MAD"},"teletypeAddresses":["ABCA9A9"]}';
            //ampliado 14/12/2017
            //String goodJson = '{"additionalInfo":{"customsInfo":"UPDATE CUSTOM","furtherInfo":"UPDATE FURTHER","matchInfo":[{"matchInfoText":"Matcheo de prueba","seq":"1"},{"matchInfoText":"MessageInfoText","seq":"2"}],"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"supplementaryInfo":[{"seq":"1","supplimentInfoText":"UPDATE SUPPL"}],"userComments":[{"commentsText":"UPDATE COMMENTS","seq":"2"}]},"agentId":"n433081","claim":{"claimData":{"claimAmount":{"amount":{"amountValue":"9500","currencyCode":"GBP","decimalPlace":"2"}},"claimDate":"2017-03-14","costRemarks":["cmn:CostRemarks"],"excessValue":{"amountValue":"200","currencyCode":"USD","decimalPlace":"1"},"faultStationCode":"MAD","faultTerminal":"T2","insurance":true,"liabilityTag":true,"lossComments":"cmn:LossComments","lossReasonCode":"20","missingBags":"10","notifiedDate":"2017-03-14","partnerCode":{"carrrierCode":"AB"},"passengerPayments":{"passengerPaymentsValue":[{"amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"},{"amount":{"amountValue":"1000","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"}]},"questionnaireDate":"2017-03-14","toiletKits":{"toiletKitsFemale":"2"}}},"crossReferenceRecord":[{"recordReference":{"airlineCode":"IB","referenceNumber":"98711","stationCode":"MAD"},"recordType":"DELAYED"}],"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"addressLine"},"country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"StateCode":"ST","stateDesc":"ES"}},"bagDeliveryAddress":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc"},"city":"city","country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"stateCode":"BN","stateDesc":"Desc"}},"deliveryInfo":["cmn:DeliveryInfo"],"deliveryService":["cmn:DeliveryService"],"deliveryWeight":"20","localDlvInfo":[{"divInfo":"cmn:DivInfo","seq":"3"}]},"bagLastSeen":"LHR","bagPhones":{"phone":["84385361559440122333"]},"bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"bagWeight":"10","baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","date":"2017-09-12","flightNumber":"3170"}}]},"contentsGender":"M","delayedBags":[{"associatedRecord":{"recordReference":{"airlineCode":"IB","referenceNumber":"987011","stationCode":"MAD"},"recordType":"DELAYED"},"bagContents":{"content":[{"category":"Albornoz","description":"Rojo ejecutivo, de seda special selection"},{"category":"Camisa","description":"Azul"},{"category":"Ipad","description":"Ipad Air Blanco"},{"category":"Neceser","description":"NBA Style azul y amarillo, con un cepillo de dientes de gran valor sentimental"}]},"bagDelivery":{"bagReceived":{"bagReceivedDate":"2017-09-12T09:05:50","station":"MAD"},"deliveredTime":"2017-09-19T09:05:50","status":{"delivered":"cmn:Delivered","outForDelivery":"cmn:OutForDelivery","trackingUpdate":"cmn:TrackingUpdate","unableToDeliver":"cmn:UnableToDeliver"}},"bagDetails":"cmn:BagDetails","bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagTag":{"airlineCode":"IB","licenseNumber":{"issuerCode":"123","tagType":"2"},"suspended":false,"tagSequence":"556985"},"brandInfo":{"brandInfo":"MNA","suspended":false},"colorTypeDesc":{"colorCode":"WT","descriptor":{"materialElement":"X","otherElement":["W","B"]},"suspended":false,"typeCode":"5"},"contentDescription":"cmn:ContentDescription","lockCode":"lock12","remarks":["cmn:Remarks"],"storageLocation":"cmn:StorageLocation","uniqueId":{"uniqueID":"2556-5698-4152"}}],"excessBaggage":"ExcessBaggage","keysCollected":true,"matchWindow":"2","missingWeight":"3"},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","passengers":{"additionalRoutes":{"route":["MAD"]},"autoMessageOption":"MANUAL","contactInfo":{"cellPhones":[{"phone":"1234567890"}],"emails":[{"email":"cmnEmail@mail.com"},{"email":"cmnEmail@mail.com"}],"faxes":[{"fax":"cmn:Fax"}],"permanentAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"StateCode":"ST","stateDesc":"ES"}},"permanentPhones":[{"phone":"1234567890"}],"temporaryAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"stateCode":"ST","stateDesc":"ES"}},"temporaryPhones":[{"phone":"1234567890"}],"validityDate":"2018-02-20"},"fareBasis":"Basis","frequentFlyerId":"XS123345678","initials":[{"initial":"H"},{"initial":"T"},{"initial":"T"}],"itinerary":{"flightSegmentsorARNK":[{"flight":{"flightandDate":{"airlineCode":"XS","date":"2017-11-11","flightNumber":"413Q"},"originDestination":{"destination":"MAA","origin":"LHR"}}},{"arnk":{"originDestination":{"destination":"MAA","origin":"LHR"}}},{"flight":{"flightandDate":{"airlineCode":"IB","date":"2017-11-11","flightNumber":"413S"},"originDestination":{"destination":"MAD","origin":"MAA"}}}]},"language":"English","names":[{"name":"Howarang"},{"name":"Tekken"},{"name":"TaeKwonDo"}],"numberOfPassengers":"2","passportInfo":"cmn:PassportInfo","pnr":"58624","pooledTicketNumber":"TicketNumber","status":"cmn:Status","ticketNumber":"1256984","title":"cmn:Title"},"refStationAirline":{"stationAirline":"IB","stationCode":"MAD"},"teletypeAddresses":["ABCA9A9"]}';
			//ampliado 10/01/2018
            //String goodJson = '{"additionalInfo":{"customsInfo":"UPDATE CUSTOM","furtherInfo":"UPDATE FURTHER","matchInfo":[{"matchInfoText":"Matcheo de prueba","seq":"1"},{"matchInfoText":"MessageInfoText","seq":"2"}],"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"supplementaryInfo":[{"seq":"1","supplimentInfoText":"UPDATE SUPPL"}],"userComments":[{"commentsText":"UPDATE COMMENTS","seq":"2"}]},"claim":{"claimData":{"claimDate":"2017-03-14","costRemarks":["cmn:CostRemarks"],"excessValue":{"amountValue":"200","currencyCode":"USD","decimalPlace":"1"},"faultTerminal":"T2","insurance":true,"liabilityTag":true,"lossComments":"cmn:LossComments","lossReasonCode":"20","missingBags":"10","notifiedDate":"2017-03-14","partnerCode":{"carrrierCode":"AB"},"passengerPayments":{"passengerPaymentsValue":[{"amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"},{"amount":{"amountValue":"1000","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"}]},"questionnaireDate":"2017-03-14","toiletKits":{"toiletKitsFemale":"2"}}},"crossReferenceRecord":[{"recordReference":{"airlineCode":"IB","referenceNumber":"98711","stationCode":"MAD"},"recordType":"DELAYED"}],"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"addressLine"},"country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"StateCode":"ST","stateDesc":"ES"}},"bagDeliveryAddress":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc"},"city":"city","country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"stateCode":"BN","stateDesc":"Desc"}},"deliveryInfo":["cmn:DeliveryInfo"],"deliveryService":["cmn:DeliveryService"],"deliveryWeight":"20"},"bagLastSeen":"LHR","bagPhones":{"phone":["84385361559440122333"]},"bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"bagWeight":"10","baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","date":"2017-09-12","flightNumber":"3170"}}]},"contentsGender":"M","delayedBags":[{"associatedRecord":{"recordReference":{"airlineCode":"IB","referenceNumber":"987011","stationCode":"MAD"},"recordType":"DELAYED"},"bagContents":{"content":[{"category":"Albornoz","description":"Rojo ejecutivo, de seda special selection"},{"category":"Camisa","description":"Azul"},{"category":"Ipad","description":"Ipad Air Blanco"},{"category":"Neceser","description":"NBA Style azul y amarillo, con un cepillo de dientes de gran valor sentimental"}]},"bagDelivery":{"bagReceived":{"bagReceivedDate":"2017-09-12T09:05:50","station":"MAD"},"deliveredTime":"2017-09-19T09:05:50","status":{"delivered":"cmn:Delivered","outForDelivery":"cmn:OutForDelivery","trackingUpdate":"cmn:TrackingUpdate","unableToDeliver":"cmn:UnableToDeliver"}},"bagDetails":"cmn:BagDetails","bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagTag":{"airlineCode":"IB","licenseNumber":{"issuerCode":"123","tagType":"2"},"suspended":false,"tagSequence":"556985"},"brandInfo":{"brandInfo":"MNA","suspended":false},"colorTypeDesc":{"colorCode":"WT","descriptor":{"materialElement":"X","otherElement":["W","B"]},"suspended":false,"typeCode":"5"},"contentDescription":"cmn:ContentDescription","lockCode":"lock12","remarks":["cmn:Remarks"],"storageLocation":"cmn:StorageLocation","uniqueId":{"uniqueID":"2556-5698-4152"}}],"excessBaggage":"ExcessBaggage","keysCollected":true,"matchWindow":"2","missingWeight":"3"},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","passengers":{"contactInfo":{"faxes":[{"fax":"cmn:Fax"}],"permanentAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"StateCode":"ST","stateDesc":"ES"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"stateCode":"ST","stateDesc":"ES"}},"validityDate":"2018-02-20"},"itinerary":{"flightSegmentsorARNK":[{"flight":{"flightandDate":{"airlineCode":"XS","date":"2017-11-11","flightNumber":"413Q"},"originDestination":{"destination":"MAA","origin":"LHR"}}},{"arnk":{"originDestination":{"destination":"MAA","origin":"LHR"}}},{"flight":{"flightandDate":{"airlineCode":"IB","date":"2017-11-11","flightNumber":"413S"},"originDestination":{"destination":"MAD","origin":"MAA"}}}]},"fareBasis":"Basis","frequentFlyerId":"XS123345678","numberOfPassengers":"2","passportInfo":"cmn:PassportInfo","pooledTicketNumber":"TicketNumber"},"refStationAirline":{"stationAirline":"IB","stationCode":"MAD"},"teletypeAddresses":["ABCA9A9"]}';
            //String goodJson = '{"additionalInfo":{"customsInfo":"UPDATE CUSTOM","furtherInfo":"UPDATE FURTHER","matchInfo":[{"matchInfoText":"Matcheo de prueba","seq":"1"},{"matchInfoText":"MessageInfoText","seq":"2"}],"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"userComments":[{"commentsText":"UPDATE COMMENTS","seq":"2"}]},"claim":{"claimData":{"claimDate":"2017-03-14","costRemarks":["cmn:CostRemarks"],"excessValue":{"amountValue":"200","currencyCode":"USD","decimalPlace":"1"},"insurance":true,"liabilityTag":true,"lossComments":"cmn:LossComments","lossReasonCode":"20","missingBags":"10","notifiedDate":"2017-03-14","partnerCode":{"carrrierCode":"AB"},"passengerPayments":{"passengerPaymentsValue":[{"amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"},{"amount":{"amountValue":"1000","currencyCode":"GBP","decimalPlace":"1"},"costType":"A"}]},"questionnaireDate":"2017-03-14","toiletKits":{"toiletKitsFemale":"2"}}},"crossReferenceRecord":[{"recordReference":{"airlineCode":"IB","referenceNumber":"98711","stationCode":"MAD"},"recordType":"DELAYED"}],"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"addressLine"},"country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"StateCode":"ST","stateDesc":"ES"}},"bagDeliveryAddress":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc"},"city":"city","country":{"countryCode":"BN","countryName":"Country"},"postalCode":"BZ","state":{"stateCode":"BN","stateDesc":"Desc"}},"deliveryInfo":["cmn:DeliveryInfo"],"deliveryService":["cmn:DeliveryService"],"deliveryWeight":"20"},"bagLastSeen":"LHR","bagWeight":"10","baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","date":"2017-09-12","flightNumber":"3170"}}]},"contentsGender":"M","delayedBags":[{"associatedRecord":{"recordReference":{"airlineCode":"IB","referenceNumber":"987011","stationCode":"MAD"},"recordType":"DELAYED"},"bagContents":{"content":[{"category":"Albornoz","description":"Rojo ejecutivo, de seda special selection"},{"category":"Camisa","description":"Azul"},{"category":"Ipad","description":"Ipad Air Blanco"},{"category":"Neceser","description":"NBA Style azul y amarillo, con un cepillo de dientes de gran valor sentimental"}]},"bagDelivery":{"bagReceived":{"bagReceivedDate":"2017-09-12T09:05:50","station":"MAD"},"deliveredTime":"2017-09-19T09:05:50","status":{"delivered":"cmn:Delivered","outForDelivery":"cmn:OutForDelivery","trackingUpdate":"cmn:TrackingUpdate","unableToDeliver":"cmn:UnableToDeliver"}},"bagDetails":"cmn:BagDetails","bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:50","timeZone":"GMT"},"bagTag":{"airlineCode":"IB","licenseNumber":{"issuerCode":"123","tagType":"2"},"suspended":false,"tagSequence":"556985"},"brandInfo":{"brandInfo":"MNA","suspended":false},"colorTypeDesc":{"colorCode":"WT","descriptor":{"materialElement":"X","otherElement":["W","B"]},"suspended":false,"typeCode":"5"},"contentDescription":"cmn:ContentDescription","lockCode":"lock12","remarks":["cmn:Remarks"],"storageLocation":"cmn:StorageLocation","uniqueId":{"uniqueID":"2556-5698-4152"}}],"excessBaggage":"ExcessBaggage","keysCollected":true,"matchWindow":"2","missingWeight":"3"},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","passengers":{"contactInfo":{"faxes":[{"fax":"cmn:Fax"}],"permanentAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"StateCode":"ST","stateDesc":"ES"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"country":{"countryCode":"CO","countryName":"Country"},"state":{"stateCode":"ST","stateDesc":"ES"}}},"fareBasis":"Basis","frequentFlyerId":"XS123345678","numberOfPassengers":"2","passportInfo":"cmn:PassportInfo","pooledTicketNumber":"TicketNumber"},"refStationAirline":{"stationAirline":"IB","stationCode":"MAD"},"teletypeAddresses":["ABCA9A9"]}';
            //goodJson = goodJson.replaceAll('"date"', '"rDate"');
            //System.debug('---> JSON good hc' + goodJson);
            //requestWR = (R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku) JSON.deserialize(goodJson, R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku.class);
            System.debug('!!!10 ' + requestWR);
       		System.debug('baglSTANTES ' + bagLst);
            parseBagInfo(requestWR);
            //System.debug('0 ' + requestWR.passengers.itinerary);
            parseSection1(requestWR);
            //System.debug('1 ' + requestWR.passengers.itinerary);
            parseSection2(requestWR);
            //System.debug('2 ' + requestWR.passengers.itinerary);
            parseSection3(requestWR);
            //System.debug('3 ' + requestWR.passengers.itinerary);
            parseSection4(requestWR);
            //System.debug('4 ' + requestWR.passengers.itinerary);
            parseSection5(requestWR);
            //System.debug('5 ' + requestWR.passengers.itinerary);
            parseSection6(requestWR);
            //System.debug('6 ' + requestWR.passengers.itinerary);
            parseSection7(requestWR);
            //System.debug('7 ' + requestWR.passengers.itinerary);
            parseSection8(requestWR);
            //System.debug('8 ' + requestWR.passengers.itinerary);
            parseSection9(requestWR);
            //System.debug('9 ' + requestWR.passengers.itinerary);
            parseSection10(requestWR);

        	//////////////////////////////////////FAXES harcodeo porque lo piden obligatorio, en espera de saber si es necesario
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            R2_WT_Wrappers_Create_Delayed.Faxes fax1 = new R2_WT_Wrappers_Create_Delayed.Faxes();
                    fax1.fax = 'faxTEST';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                    if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
                    if (requestWR.passengers.contactInfo.faxes == null ) { requestWR.passengers.contactInfo.faxes = new List<R2_WT_Wrappers_Create_Delayed.Faxes>(); }
                    requestWR.passengers.contactInfo.faxes.add(fax1);

            System.debug('!!!11 ' + requestWR);

            String alias = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            requestWR.agentId = alias;
            // R2_WT_Wrappers_Create_Delayed.NewRecordType nrt = new R2_WT_Wrappers_Create_Delayed.NewRecordType();
            // nrt.recordType = 'DELAYED';
            // R2_WT_Wrappers_Create_Delayed.AssociatedRecord ar = new R2_WT_Wrappers_Create_Delayed.AssociatedRecord();
            // ar.referenceNumber = '987011';
            // ar.stationCode = 'MAD';
            // ar.airlineCode = 'IB';
            // nrt.recordReference = ar;
            //
            // requestWR.delayedBagGroup.delayedBags[0].associatedRecord = nrt;

            System.debug(requestWR);

            System.debug('WRAPPER_REQUEST:::'+requestWR);
            //requestWR.claim.claimData.partnerCode.carrierCode = '11';
            //requestWR.delayedBagGroup.keysCollected = true;
            //requestWR.passengers.contactInfo.temporaryAddress.validityDate = '2018-02-20';

            String wrapperJson = JSON.serialize(requestWR);
            System.debug('STRING_REQUEST:::'+requestWR);
            wrapperJson = wrapperJson.replaceAll('"rDate"', '"date"');
            //String resultado = R2_WT_Wrappers_Create_Delayed.CreateDelayedBag(wrapperJson, 0);
            //R2_WT_Wrappers_Create_Delayed.WR_DelayedBagWebRespRecord 

            wrapperJson = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapperJson);
            wrapperJson = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapperJson);
            System.debug(':::FIXED? STRING_REQUEST:::'+wrapperJson);

            resultado = R2_WT_Wrappers_Create_Delayed.CreateDelayedBag(wrapperJson, 0);
            System.debug('REDOBLE DE TAMBORES........ ' + resultado);

            //List<String> lstResultado = resultado.split('@splitMe@');
            
            //resp.record
            //R2_WT_Wrappers_Create_Delayed.NewRecordType 
            //registro = (R2_WT_Wrappers_Create_Delayed.NewRecordType)JSON.deserialize(lstResultado[0],R2_WT_Wrappers_Create_Delayed.NewRecordType.class);
            //R2_WT_Wrappers_Create_Delayed.NewRecordType resp = (R2_WT_Wrappers_Create_Delayed.NewRecordType)JSON.deserialize(lstResultado[0],R2_WT_Wrappers_Create_Delayed.NewRecordType.class);
            
            //resp.warnings
            //List<R2_WT_Wrappers_Create_Delayed.WarningType>
            //warnings = (List<R2_WT_Wrappers_Create_Delayed.WarningType>) JSON.deserialize(lstResultado[1], List<R2_WT_Wrappers_Create_Delayed.WarningType>.class);
            //resp.errors
            //List<R2_WT_Wrappers_Create_Delayed.ErrorType> 
            //errors = (List<R2_WT_Wrappers_Create_Delayed.ErrorType>) JSON.deserialize(lstResultado[1], List<R2_WT_Wrappers_Create_Delayed.ErrorType>.class);
            //System.debug('::REGISTRO-> '+registro+'#######WARNINGS-> '+warnings+'#######ERRORS-> '+errors);
            
            System.debug('::REGISTRO-> '+resultado);
            if(resultado != null){
                if(resultado.success == 'YES' || resultado.success == 'TRUE'){//!resultado.contains('error') && !resultado.contains('reason') ){
                    //avisar de warnings y después leer y cargar detalle de pir
                    //leemos y cargamos
                    //DEBUG|bigWP::::::::READ: EJEMPLO Leído:
                    //{"recordId":{"recordType":"DELAYED","
                                    //recordReference":{"stationCode":"stationCode","referenceNumber":"referenceNumber","airlineCode":"airlinecode"}},"
                                    //agentId":"agentId"}
                    //ejemplo:R1_CLS_Utilities.readRecord_WT('DELAYED', 'stationCode', 'airlinecode', 'referenceNumber', 'agentId', 1);
                    newId = R1_CLS_Utilities.readRecord_WT(resultado.record.recordType, 
                                                    resultado.record.recordReference.stationCode,
                                                    resultado.record.recordReference.airlinecode, 
                                                    resultado.record.recordReference.referenceNumber,
                                                    'agentId',
                                                     1);
                    System.debug('ID del pir creado:'+newId);
                    //abreNewRegistro(newId);
                    //ajax_generaRespuesta();
                    CLS_INC_WT_Monitoring.watchingWT( 'create_Delayed_PIR', 'Delayed');
                }else{
                    //informar de errors
                    System.debug('ERRORES:'+errors);
                    CLS_INC_WT_Monitoring.watchingWT( 'create_Delayed_PIR_WTreturnsErrors', 'Delayed');
                }
                ajaxGeneraRespuesta();
            }else{
                informeCrear = 'Error en la llamada a WorldTracer, consulte con el Administrador.';
                CLS_INC_WT_Monitoring.watchingWT( 'create_Delayed_PIR_WTreturnsErrors', 'Delayed');             
            }

        }catch(Exception exc){
            System.debug('Error createPIR: '+exc.getMessage());
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Create_PIR_Controller.createPIR()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }

    }
    /*---------------------------------------------------------------------------------------------------------------------
        Author:        Alberto Puerto Collado  
        Company:        Accenture - working on it
        Description:    create answer from WT in order to display it
        IN:
        OUT:

        History:
         <Date>                     <Author>                         <Change Description>
        30/11/2017             Alberto Puerto Collado                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    private void ajaxGeneraRespuesta(){
        informeCrear = ''; //limpieza por si se crea más de un registro
        System.debug('Entrando en ajaxGeneraRespuesta');
        //if(errors != null){
        //    lstRespuestas.add(JSON.serialize(errors));
        //}else{
        //    lstRespuestas.add(JSON.serialize(registro));
        //    if(warnings != null){
        //        lstRespuestas.add(JSON.serialize(warnings));
        //    }
        //}
        //informeCrear;  -> usar este mejor personalizado
        if(resultado.success == 'YES' || resultado.success == 'TRUE'){
            System.debug('Pintando respuesta success y warnings');
            informeSuccess = true;
            informeCrear += '</br><label class="apartadoModal">Registro correctamente creado en WorldTracer ('+ resultado.record.recordReference.stationCode+resultado.record.recordReference.airlinecode+resultado.record.recordReference.referenceNumber +')</label></br>';
            informeCrear += 'Estación: '+ resultado.record.recordReference.stationCode +'</br>';
            informeCrear += 'Aerolínea: '+ resultado.record.recordReference.airlinecode +'</br>';
            informeCrear += 'Número de referencia: '+ resultado.record.recordReference.referenceNumber +'</br>';
	        if(resultado.warnings != null){
	            if(!resultado.warnings.isEmpty()){
	                for(Integer i=0; i<resultado.warnings.size(); i++){
	                    System.debug('Pintando warnings');
	                    informeCrear += '</br><label class="apartadoModal">Advertencias:</label></br>';
	                    informeCrear += resultado.warnings[i].warningCode + ' - ' + resultado.warnings[i].warningDescription + '\\n';
	                }
	            }
	        }       
        }else{
            System.debug('Pintando errores');
            informeSuccess = false;
            informeCrear += '</br><label class="apartadoModal">Error en los datos, por favor revíselos</label>';
            for(Integer i=0; i<resultado.errors.size(); i++){
                System.debug('Pintando errores en bucle');
                informeCrear += '</br>';
                String codigo = resultado.errors[i].code;
                if (codigo != null) {
                	codigo = codigo.toUpperCase();
	                if(!codigo.contains('UNKNOWN')){
	                    informeCrear += resultado.errors[i].code + ' - ';
	                }
	           	}
                informeCrear += resultado.errors[i].reason + '\\n';
            }
        }
        informeCrear = informeCrear.replaceAll('\"', '\'');
        System.debug(':::INFORMECREAR report: ' + informeCrear);
    }
    private PageReference abreNewRegistro(Id idNew){
        return new PageReference('/'+idNew);
    }

	private Date parseDate(String fieldDate) {
		String[] dateItem = fieldDate.split('-');
		return Date.newinstance(Integer.valueOf(dateItem[2]), Integer.valueOf(dateItem[0]), Integer.valueOf(dateItem[1]));
	}

	private void parseSection1(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field : incidentInformationSection1) {
            System.debug('!!!field: ' + field);
			if (field.value == '' || field.value == null) {	continue; }
			if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				requestWR.claim.claimData.faultStationCode = field.value;
			}
            else if (field.name == 'R2_INC_TXT_PIR_Stop_and_Operator_MS__c') {
				if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_WT_Wrappers_Create_Delayed.RefStationAirline(); }  
                requestWR.refStationAirline.stationCode = field.value.subString(0,3);
                requestWR.refStationAirline.stationAirline = field.value.subString(3,5);
			//}--------------------------------------------- o todo junto o por separado abajo --------------------
			//else if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_WT_Wrappers_Create_Delayed.RefStationAirline(); }  
   //             requestWR.refStationAirline.stationCode = field.value;
			//}
			//else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_WT_Wrappers_Create_Delayed.RefStationAirline(); }  
   //             requestWR.refStationAirline.stationAirline = field.value;
			}
			else if (field.name == 'R2_INC_DAT_PIR_Claims_Created_Date__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				//requestWR.claim.claimData.claimDate = parseDate(field.value);
                requestWR.claim.claimData.claimDate = String.valueOf(field.value);
			}
            else if (field.name == 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c') {
                for (String record : field.value.split('/')) {
                    record = record.trim();
                    List<String> xr = record.split(' ');
                    if (xr.size() == 2) {
                        R2_WT_Wrappers_Create_Delayed.CrossReferenceRecord associted = new R2_WT_Wrappers_Create_Delayed.CrossReferenceRecord();
                        R2_WT_Wrappers_Create_Delayed.RecordReference reference = new R2_WT_Wrappers_Create_Delayed.RecordReference();
                        if (xr[0] == 'AHL') {
                            associted.recordType = 'DELAYED';
                        }
                        else if (xr[0] == 'DPR') {
                            associted.recordType = 'DAMAGED';
                        }
                        else if (xr[0] == 'OHD') {
                            associted.recordType = 'ON-HAND';
                        }
                        reference.stationCode = xr[1].substring(0,3);
                        reference.airlineCode = xr[1].substring(3,5);
                        reference.referenceNumber = xr[1].substring(5);
                        associted.recordReference = reference;
                        if (requestWR.crossReferenceRecord == null) { requestWR.crossReferenceRecord = new List<R2_WT_Wrappers_Create_Delayed.CrossReferenceRecord>(); }
                        requestWR.crossReferenceRecord.add(associted);
                    }
                }
            }
			// else if (field.name == 'R2_INC_FOR_PIR_AR__c') {
			// 	// TODO WIP
			// } NOT NECESSARY
            //duplicado con R2_INC_DAT_PIR_Claim_Date__c ???
			//else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
			//	if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
			//	if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
			//	//requestWR.claim.claimData.claimDate = parseDate(field.value);
   //             requestWR.claim.claimData.claimDate = field.value;
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Last_mapping_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_LOO_Case__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Search_start_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_PIR_DAT_PIR_Full_reintegration_date__c') {
			//	// TODO WIP
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Control_office__c') {
				// TODO WIP
			}
			else if (field.name == 'R2_INC_NUM_PIR_Associated_Cases__c') {
				// TODO WIP
			}
			//else if (field.name == 'R2_INC_DAT_PIR_Cancellation_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Date_back_primary_search__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Control_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'RecordTypeId') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Unsuccessful_search__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DATH_PIR_Incidence_closed_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_TXT_PIR_Agent__c') {
			//	// TODO WIP
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Report_PIR__c') {
				// TODO WIP
			}
			else if (field.name == 'R2_INC_TXT_PIR_VIP_Account__c') {
				// TODO WIP
			}
			//else if (field.name == 'R2_INC_PKL_PIR_Status_incidence__c') {
			//	// TODO WIP
			//}
		}
	}

	private void parseSection2(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field :incidentInformationSection2) {
			if (field.value == '' || field.value == null) {	continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Name__c') {
				R2_WT_Wrappers_Create_Delayed.Names primerNombre = new R2_WT_Wrappers_Create_Delayed.Names();
				primerNombre.name = field.value;
				primerNombre.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.names == null ) { requestWR.passengers.names = new List<R2_WT_Wrappers_Create_Delayed.Names>(); }
				//if (requestWR.passengers.names[0] != null) { requestWR.passengers.names[0] = primerNombre; }
				//else { 
				requestWR.passengers.names.add(primerNombre); //}
			}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name__c') {
				R2_WT_Wrappers_Create_Delayed.Names primerApellido = new R2_WT_Wrappers_Create_Delayed.Names();
				primerApellido.name = field.value;
				primerApellido.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.names == null ) { requestWR.passengers.names = new List<R2_WT_Wrappers_Create_Delayed.Names>(); }
                //if (requestWR.passengers.names[1] != null) { requestWR.passengers.names[1] = primerApellido; }
				//else{
				requestWR.passengers.names.add(primerApellido);//}
			}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name2__c') {
				R2_WT_Wrappers_Create_Delayed.Names segundoApellido = new R2_WT_Wrappers_Create_Delayed.Names();
				segundoApellido.name = field.value;
				segundoApellido.seq = '3';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.names == null ) { requestWR.passengers.names = new List<R2_WT_Wrappers_Create_Delayed.Names>(); }
                //if (requestWR.passengers.names[2] != null) { requestWR.passengers.names[2] = segundoApellido; }
				//else{
					requestWR.passengers.names.add(segundoApellido);//}
			}
			else if (field.name == 'R2_INC_TXT_PIR_Treatment__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				requestWR.passengers.title = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial__c') {
				R2_WT_Wrappers_Create_Delayed.Initials inicial1 = new R2_WT_Wrappers_Create_Delayed.Initials();
				inicial1.initial = field.value;
				inicial1.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List<R2_WT_Wrappers_Create_Delayed.Initials>(); }
				//if (requestWR.passengers.initials[0] != null) { requestWR.passengers.initials[0] = inicial1; }
				//else {
				requestWR.passengers.initials.add(inicial1);// }
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial2__c') {
				R2_WT_Wrappers_Create_Delayed.Initials inicial2 = new R2_WT_Wrappers_Create_Delayed.Initials();
				inicial2.initial = field.value;
				inicial2.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List<R2_WT_Wrappers_Create_Delayed.Initials>(); }
                //if (requestWR.passengers.initials[1] != null) { requestWR.passengers.initials[1] = inicial2; }
				//else{
				requestWR.passengers.initials.add(inicial2);//}
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial3__c') {
				R2_WT_Wrappers_Create_Delayed.Initials inicial3 = new R2_WT_Wrappers_Create_Delayed.Initials();
				inicial3.initial = field.value;
				inicial3.seq = '3';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List<R2_WT_Wrappers_Create_Delayed.Initials>(); }
                //if (requestWR.passengers.initials[2] != null) { requestWR.passengers.initials[2] = inicial3; }
				//else{
				requestWR.passengers.initials.add(inicial3);//}
			}
			else if (field.name == 'R2_INC_EMA_PIR_Email1__c') {
				R2_WT_Wrappers_Create_Delayed.Emails emailDireccion1 = new R2_WT_Wrappers_Create_Delayed.Emails();
				emailDireccion1.email = field.value;
				emailDireccion1.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.emails == null ) { requestWR.passengers.contactInfo.emails = new List<R2_WT_Wrappers_Create_Delayed.Emails>(); }
				requestWR.passengers.contactInfo.emails.add(emailDireccion1);
			}
			else if (field.name == 'R2_INC_EMA_PIR_Email2__c') {
				R2_WT_Wrappers_Create_Delayed.Emails emailDireccion2 = new R2_WT_Wrappers_Create_Delayed.Emails();
				emailDireccion2.email = field.value;
				emailDireccion2.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.emails == null ) { requestWR.passengers.contactInfo.emails = new List<R2_WT_Wrappers_Create_Delayed.Emails>(); }
				requestWR.passengers.contactInfo.emails.add(emailDireccion2);
			}
			else if (field.name == 'R2_INC_TXT_PIR_FF_Identificator__c') {
                String valorFF = field.value;
                valorFF = valorFF.trim();
                valorFF = valorFF.replaceAll('_', ' ');
                valorFF = valorFF.replaceAll('[\\s]?', ' ');
                valorFF = valorFF.toUpperCase();
                if(valorFF != R2_CLS_WT_Bags_Management.NO_IBERIA_PLUS){
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                    requestWR.passengers.frequentFlyerId = field.value;
                }
			}
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_language__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				requestWR.passengers.language = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Ticket_number__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				requestWR.passengers.ticketNumber = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_PNR_locator__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				requestWR.passengers.pnr = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_category__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				requestWR.passengers.status = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_address1__c') {
				// R2_WT_Wrappers_Create_Delayed.AddressLine addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine();
				// addressLine.addressLineDesc = field.value;
				// addressLine.seq = ''+1;
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
				requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Delivery_address2__c') {
			//	// R2_WT_Wrappers_Create_Delayed.AddressLine addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine();
			//	// addressLine.addressLineDesc = field.value;
			//	// addressLine.seq = ''+2;
			//	if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
			//	requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_local_informatio__c') {
				R2_WT_Wrappers_Create_Delayed.LocalDlvInfo addressLine = new R2_WT_Wrappers_Create_Delayed.LocalDlvInfo();
				addressLine.divInfo = field.value;
				addressLine.seq = '1';
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo == null) { requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo = new List<R2_WT_Wrappers_Create_Delayed.LocalDlvInfo>(); }
				requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo.add(addressLine);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Deliver_local_informatio2__c') {
				R2_WT_Wrappers_Create_Delayed.LocalDlvInfo addressLine = new R2_WT_Wrappers_Create_Delayed.LocalDlvInfo();
				addressLine.divInfo = field.value;
				addressLine.seq = '2';
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo == null) { requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo = new List<R2_WT_Wrappers_Create_Delayed.LocalDlvInfo>(); }
				requestWR.delayedBagGroup.bagDeliveryAddress.localDlvInfo.add(addressLine);
			}
			else if (field.name == 'R2_INC_PKL_PIR_Send_SMS_email__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.passengers(); }
				requestWR.passengers.autoMessageOption = field.value;
			}
		}
	}

	private void parseSection3(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field :incidentInformationSection3) {
			if (field.value == '' || field.value == null) {	continue; }
			if (field.name == 'R2_INC_TXT_PIR_Permanent_address1__c') {
				// R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea1 = new R2_WT_Wrappers_Create_Delayed.AddressLine();
				// direccionLinea1.addressLineDesc = field.value;
				// direccionLinea1.seq = ''+1;
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.permanentAddress == null) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_Wrappers_Create_Delayed.PermanentAddress(); }
				if (requestWR.passengers.contactInfo.permanentAddress.addressLine == null) { requestWR.passengers.contactInfo.permanentAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
				requestWR.passengers.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
			}
			else if (field.name == 'R2_INC_TLF_Landline1__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones telefonoFijo1 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				telefonoFijo1.phone = field.value;
				telefonoFijo1.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.permanentPhones == null) { requestWR.passengers.contactInfo.permanentPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>(); }
				requestWR.passengers.contactInfo.permanentPhones.add(telefonoFijo1);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_address1__c') {
				// R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea = new R2_WT_Wrappers_Create_Delayed.AddressLine();
				// direccionLinea.addressLineDesc = field.value;
				// direccionLinea.seq = ''+1;
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.TemporaryAddress(); }
				if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
				requestWR.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;

			}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones telefonoTemporal1 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				telefonoTemporal1.phone = field.value;
				telefonoTemporal1.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.temporaryPhones == null) { requestWR.passengers.contactInfo.temporaryPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>(); }
				requestWR.passengers.contactInfo.temporaryPhones.add(telefonoTemporal1);
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Permanent_address2__c') {
			//	// R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea2 = new R2_WT_Wrappers_Create_Delayed.AddressLine();
			//	// direccionLinea2.addressLineDesc = field.value;
			//	// direccionLinea2.seq = ''+2;
			//	if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
			//	if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.contactInfo(); }
			//	if (requestWR.passengers.contactInfo.permanentAddress == null) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_Wrappers_Create_Delayed.PermanentAddress(); }
			//	if (requestWR.passengers.contactInfo.permanentAddress.addressLine == null) { requestWR.passengers.contactInfo.permanentAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
			//	requestWR.passengers.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TLF_Landline2__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones telefonoFijo2 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				telefonoFijo2.phone = field.value;
				telefonoFijo2.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.permanentPhones == null) { requestWR.passengers.contactInfo.permanentPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>(); }
				requestWR.passengers.contactInfo.permanentPhones.add(telefonoFijo2);
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Temporal_address2__c') {
			//	// R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea = new R2_WT_Wrappers_Create_Delayed.AddressLine();
			//	// direccionLinea.addressLineDesc = field.value;
			//	// direccionLinea.seq = ''+2;
			//	if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
			//	if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.contactInfo(); }
			//	if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.temporaryAddress(); }
			//	if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
			//	requestWR.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone2__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones telefonoTemporal2 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				telefonoTemporal2.phone = field.value;
				telefonoTemporal2.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.temporaryPhones == null) { requestWR.passengers.contactInfo.temporaryPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>();	}
				requestWR.passengers.contactInfo.temporaryPhones.add(telefonoTemporal2);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Zip_code__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.permanentAddress == null) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_Wrappers_Create_Delayed.PermanentAddress(); }
				requestWR.passengers.contactInfo.permanentAddress.postalCode = field.value;
			}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number1__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones mobile1 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				mobile1.phone = field.value;
				mobile1.seq = '1';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.cellPhones == null) { requestWR.passengers.contactInfo.cellPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>(); }
				requestWR.passengers.contactInfo.cellPhones.add(mobile1);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_Zip_Code__c') {
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.TemporaryAddress(); }
				requestWR.passengers.contactInfo.temporaryAddress.postalCode = field.value;
			}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number2__c') {
				R2_WT_Wrappers_Create_Delayed.CellPhones mobile2 = new R2_WT_Wrappers_Create_Delayed.CellPhones();
				mobile2.phone = field.value;
				mobile2.seq = '2';
				if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
				if (requestWR.passengers.contactInfo.cellPhones == null) { requestWR.passengers.contactInfo.cellPhones = new List<R2_WT_Wrappers_Create_Delayed.CellPhones>(); }
				requestWR.passengers.contactInfo.cellPhones.add(mobile2);
			}
			 //else if (field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c') {
			 //	List<String> auxLst = field.value.split('/');
    //            //creando formato de fecha de salesforce (yyyy-mm-dd)
    //            String dateStr;
    //            //creando formato de fecha EEUU (mm-dd-yyyy)
    //            if (UserInfo.getLocale() == 'en_US') {
    //                dateStr = auxLst[2] + '-' + auxLst[0] + '-' + auxLst[1];
    //            }
    //            else {
    //                //creando formato de fecha resto mundo (dd-mm-yyyy)
    //                dateStr = auxLst[2] + '-' + auxLst[1] + '-' + auxLst[0];
    //            }
			 //	if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
			 //	if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
			 //	if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
			 //	requestWR.passengers.contactInfo.temporaryAddress.validityDate = dateStr;
			 //} //FIXME echarle un ojo
		}
	}

	private void parseSection4(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field : incidentInformationSection4) {
			if (field.value == '' || field.value == null) {	continue; }
			if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
				if(field.value != null && field.value != '') {
					Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
					Integer i = 0;
					System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
					for (String key : dateFlightsMap.keySet()) {
						for (String vuelo : dateFlightsMap.get(key)) {
							if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
                            if (requestWR.delayedBagGroup.baggageItinerary == null) { requestWR.delayedBagGroup.baggageItinerary = new R2_WT_Wrappers_Create_Delayed.BaggageItinerary(); }
                            if (requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK == null) { requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightDateOrARNK>(); }
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightDateOrARNK());
                            if (requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate == null) { requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate = new R2_WT_Wrappers_Create_Delayed.FlightDate(); }
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.airlineCode = vuelo.substring(0,2);
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.flightNumber = vuelo.substring(2);
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.rDate = key;
                            i++;
						}
					}
                }
				// R2_WT_Wrappers_Create_Delayed.Route route = new R2_WT_Wrappers_Create_Delayed.Route();
				// route.route = field.value; 
				// R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK fSegmentOARNK = new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK();
				// fSegmentOARNK.additionalRoutes.add(route);
				// if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				// if (requestWR.delayedBagGroup.bagItinerary == null) { requestWR.delayedBagGroup.bagItinerary = new List<R2_WT_Wrappers_Create_Delayed.FlightDateOrARNK>(); }
				// if (requestWR.delayedBagGroup.bagItinerary.flightDate == null) { requestWR.delayedBagGroup.bagItinerary.flightDate = new R2_WT_Wrappers_Create_Delayed.FlightDate(); }
				// requestWR.delayedBagGroup.bagItinerary.flightSegmentsOrARNK.add(route);
				// FIXME Campo no encontrado BagTagDestinations?????? Itinerario no lleva ruta :S
			} else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
				if(field.value != null && field.value != '') {
					Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
					Integer i = 0;
					System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
					for (String key : dateFlightsMap.keySet()) {
						for (String vuelo : dateFlightsMap.get(key)) {
							if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK>(); }
                            requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK());
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight = new R2_WT_Wrappers_Create_Delayed.Flight(); }
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate = new R2_WT_Wrappers_Create_Delayed.FlightDate(); }
                            System.debug('!!!key: ' + key);
                            System.debug('!!!vuelo: ' + vuelo);
                            System.debug('!!!vuelo.substring(0,2): ' + vuelo.substring(0,2));
                            System.debug('!!!vuelo.substring(2): ' + vuelo.substring(2));
                            requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.airlineCode = vuelo.substring(0,2);
                            requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.flightNumber = vuelo.substring(2);
                            requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.rDate = key;
                            i++;
						}
					}
                    //List<String> vueloLst = field.value.split(';');
                    //System.debug('vueloLst: ' + vueloLst);
                    //for (Integer i = 0; i < vueloLst.size(); i++) {
                    //    System.debug('vueloLst[' + i + ']: '+ vueloLst[i]);
                    //    List<String> vueloFecha = vueloLst[i].split('/');
                    //    System.debug('vueloFecha: ' + vueloFecha);
                    //    if (vueloFecha.size() == 2) {
                    //        if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                    //        if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
                    //        if (requestWR.passengers.itinerary.flightSegmentsOrARNK == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK>(); }
                    //        //if (requestWR.passengers.itinerary.flightSegmentsOrARNK.isEmpty()) { requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.flightSegmentsOrARNK()); }
                    //        requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK());
                    //        if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight = new R2_WT_Wrappers_Create_Delayed.Flight(); }
                    //        if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate = new R2_WT_Wrappers_Create_Delayed.FlightDate(); }
                    //        requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.airlineCode = vueloFecha[0].substring(0,2);
                    //        requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.flightNumber = vueloFecha[0].substring(2);
                    //        requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.rDate = vueloFecha[1];
                    //        System.debug('requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate: ' + requestWR.passengers.itinerary.flightSegmentsOrARNK[i].flight.flightandDate);
                    //    }
                    //}
                }
				//if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				//if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK>(); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK.isEmpty()) { requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK()); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK[0].flight == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[0].flight = new R2_WT_Wrappers_Create_Delayed.Flight(); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK[0].flight.flightandDate == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[0].flight.flightandDate = new R2_WT_Wrappers_Create_Delayed.FlightDate(); }
				//requestWR.passengers.itinerary.flightSegmentsOrARNK[0].flight.flightandDate.rDate = field.value;
			} else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
				if(field.value != null && field.value != '') {
                    List<String> rutaLst = field.value.split('/');
                    System.debug('rutaLst: ' + rutaLst);
                    //Integer i = 1;
                    for (Integer i = 1; i < rutaLst.size(); i++) {
                        System.debug('rutaLst[' + i + ']: '+ rutaLst[i]);
                        if (i < 6) {
                            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK>(); }
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK.size() < i) { requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK()); }
                            //if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight = new R2_WT_Wrappers_Create_Delayed.Flight(); }
                            //if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination = new R2_WT_Wrappers_Create_Delayed.OriginDestination(); }
                            //requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                            //requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight == null) {
                                if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk = new R2_WT_Wrappers_Create_Delayed.Arnk(); }
                                if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination = new R2_WT_Wrappers_Create_Delayed.OriginDestination(); }
                                requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination.origin = rutaLst[i-1];
                                requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination.destination = rutaLst[i];
                            }
                            else {
                                if (requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination = new R2_WT_Wrappers_Create_Delayed.OriginDestination(); }
                                requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                                requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            }
                            System.debug('requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1]: ' + requestWR.passengers.itinerary.flightSegmentsOrARNK[i-1]);
                        }
                        else {
                            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
                            if (requestWR.passengers.itinerary.additionalRoutes == null) { requestWR.passengers.itinerary.additionalRoutes = new R2_WT_Wrappers_Create_Delayed.AdditionalRoutes(); }
                            if (requestWR.passengers.itinerary.additionalRoutes.route == null) { requestWR.passengers.itinerary.additionalRoutes.route = new List<String>(); }
                            requestWR.passengers.itinerary.additionalRoutes.route.add(rutaLst[i]);
                        }
                    }
                }
				//R2_WT_Wrappers_Create_Delayed.Route route = new R2_WT_Wrappers_Create_Delayed.Route();
				//route.route = field.value;
				//R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK fSegmentOARNK = new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK();
				//fSegmentOARNK.additionalRoutes.add(route);
				//if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
				//if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_Wrappers_Create_Delayed.Itinerary(); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK = new List<R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK>(); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK.isEmpty()) { requestWR.passengers.itinerary.flightSegmentsOrARNK.add(new R2_WT_Wrappers_Create_Delayed.FlightSegmentsOrARNK()); }
				//if (requestWR.passengers.itinerary.flightSegmentsOrARNK[0].additionalRoutes == null) { requestWR.passengers.itinerary.flightSegmentsOrARNK[0].additionalRoutes = new List<R2_WT_Wrappers_Create_Delayed.Route>(); }
				//requestWR.passengers.itinerary.flightSegmentsOrARNK[0].additionalRoutes.add(route);
			}
		}
	}

	private void parseSection5(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field :incidentInformationSection5) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Send_direction_FI__c') {
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
				requestWR.additionalInfo.furtherInfo = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information1__c') {
				R2_WT_Wrappers_Create_Delayed.SupplementaryInfo supplementInfo = new R2_WT_Wrappers_Create_Delayed.SupplementaryInfo();
				supplementInfo.supplimentInfoText = field.value;
				supplementInfo.seq = '1';
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
				if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_WT_Wrappers_Create_Delayed.SupplementaryInfo>(); }
				requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information2__c') {
				R2_WT_Wrappers_Create_Delayed.SupplementaryInfo supplementInfo = new R2_WT_Wrappers_Create_Delayed.SupplementaryInfo();
				supplementInfo.supplimentInfoText = field.value;
				supplementInfo.seq = '1';
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
				if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_WT_Wrappers_Create_Delayed.SupplementaryInfo>(); }
				requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
			}
			else if (field.name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c') {
				requestWR.handledAirlineCopyIndicator = field.value;
			}
			//else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
			//	if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
			//	if (requestWR.additionalInfo.miscellaneousInfo == null) { requestWR.additionalInfo.miscellaneousInfo = new List<R2_WT_Wrappers_Create_Delayed.MiscellaneousInfo>(); }
			//	if (requestWR.additionalInfo.miscellaneousInfo.isEmpty()) { requestWR.additionalInfo.miscellaneousInfo.add(new R2_WT_Wrappers_Create_Delayed.MiscellaneousInfo()); }
			//	requestWR.additionalInfo.miscellaneousInfo[0].miscInfoText = field.value;
			//	requestWR.additionalInfo.miscellaneousInfo[0].seq = '1';
			//}
			//else if (field.name == 'R2_ADI_TXT_UC_User_Comment__c') {
			//	if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
			//	if (requestWR.additionalInfo.userComments == null) { requestWR.additionalInfo.userComments = new List<R2_WT_Wrappers_Create_Delayed.UserComments>(); }
			//	if (requestWR.additionalInfo.userComments.isEmpty()) { requestWR.additionalInfo.userComments.add(new R2_WT_Wrappers_Create_Delayed.UserComments()); }
			//	requestWR.additionalInfo.userComments[0].commentsText = field.value;
			//	requestWR.additionalInfo.userComments[0].seq = '1';
			//}
		}
	}

	private void parseSection6(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		//for (Field field : incidentInformationSection6) {
		//	if (field.value == '' || field.value == null) { continue; }
		//}
	}

	private void parseSection7(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field : incidentInformationSection7) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_piece__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				System.debug('!!!field: ' + field);
				requestWR.delayedBagGroup.bagWeight = field.value;
				System.debug('!!!requestWR.delayedBagGroup: ' + requestWR.delayedBagGroup);
			}
			else if (field.name == 'R2_INC_TXT_Last_Seen__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				requestWR.delayedBagGroup.bagLastseen = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Weight_lost_parts__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				requestWR.delayedBagGroup.missingWeight = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
				requestWR.delayedBagGroup.bagDeliveryAddress.deliveryWeight = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase1__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagAddress == null) { requestWR.delayedBagGroup.bagAddress = new R2_WT_Wrappers_Create_Delayed.BagAddress(); }
				if (requestWR.delayedBagGroup.bagAddress.addressLine == null) { requestWR.delayedBagGroup.bagAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
				requestWR.delayedBagGroup.bagAddress.addressLine.addressLineDesc = field.value;
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
			//	// Solo deja rellenar una direccion de maleta
			//}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase1__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagPhones == null) { requestWR.delayedBagGroup.bagPhones = new R2_WT_Wrappers_Create_Delayed.BagPhones(); }
				if (requestWR.delayedBagGroup.bagPhones.phone == null) { requestWR.delayedBagGroup.bagPhones.phone = new List<String>(); }
				requestWR.delayedBagGroup.bagPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase2__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
				if (requestWR.delayedBagGroup.bagPhones == null) { requestWR.delayedBagGroup.bagPhones = new R2_WT_Wrappers_Create_Delayed.BagPhones(); }
				if (requestWR.delayedBagGroup.bagPhones.phone == null) { requestWR.delayedBagGroup.bagPhones.phone = new List<String>(); }
				requestWR.delayedBagGroup.bagPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_Excess_Baggage__c') {
				if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
                requestWR.delayedBagGroup.excessBaggage = field.value;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Limited_approval_label__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
                requestWR.claim.claimData.liabilityTag = Boolean.valueOf(field.value);
			}
			else if (field.name == 'R2_ADI_ATXTL_DS_Delivery_service__c') {
				// TODO WIP
			}
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_destination__c') {
				List<String> destLst = field.value.split('/');
				for (Integer i = 0; i < destLst.size(); i++) {
					if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
					if (requestWR.delayedBagGroup.bagTagDestinations == null) { requestWR.delayedBagGroup.bagTagDestinations = new R2_WT_Wrappers_Create_Delayed.BagTagDestinations(); }
					if (requestWR.delayedBagGroup.bagTagDestinations.station == null) { requestWR.delayedBagGroup.bagTagDestinations.station = new List<R2_WT_Wrappers_Create_Delayed.Station>(); }
					requestWR.delayedBagGroup.bagTagDestinations.station.add(new R2_WT_Wrappers_Create_Delayed.Station());
					requestWR.delayedBagGroup.bagTagDestinations.station[i].stationValue = destLst[i];
				}
			}
		}
	}

	private void parseSection8(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		for (Field field : incidentInformationSection8) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				if (requestWR.claim.claimData.partnerCode == null) { requestWR.claim.claimData.partnerCode = new R2_WT_Wrappers_Create_Delayed.PartnerCode(); }
				requestWR.claim.claimData.partnerCode.carrierCode = field.value;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				requestWR.claim.claimData.insurance = Boolean.valueof(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				requestWR.claim.claimData.lossReasonCode = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
				// if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				// if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				// requestWR.claim.claimData. = field.value ;
				// FIXME no encontrado
			}
			//else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
			//	if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
			//	if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
			//	requestWR.claim.claimData.replacementBagIndicator = field.value ;
			//	// FIXME no mapeado!
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_reason_causes__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				requestWR.claim.claimData.lossComments = field.value ;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Washing_kit__c') {
				List<String> kitLst = field.value.split('/');
				for (String kit : kitLst) {
					if (kit.contains('M')) {
						if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
						if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
						if (requestWR.claim.claimData.toiletKits == null) { requestWR.claim.claimData.toiletKits = new R2_WT_Wrappers_Create_Delayed.ToiletKits(); }
						requestWR.claim.claimData.toiletKits.toiletKitsMale = kit.remove('M');
					}
					else if (kit.contains('F')) {
						if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
						if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
						if (requestWR.claim.claimData.toiletKits == null) { requestWR.claim.claimData.toiletKits = new R2_WT_Wrappers_Create_Delayed.ToiletKits(); }
						requestWR.claim.claimData.toiletKits.toiletKitsFemale = kit.remove('F');
					}
				}
			}
			//else if (field.name == 'R2_INC_TXT_PIR_DO_Flight__c') { // resp.claim.claimData.
				// if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				// if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				// requestWR.claim.claimData. = field.value ;
				// FIXME no encontrado
			//}
			else if (field.name == 'R2_ADI_TXT_CR_Remarks_Cost__c') { // resp.claim.claimData.
				// if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				// if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				// if (requestWR.claim.claimData.costRemarks == null) { requestWR.claim.claimData.costRemarks = new List<R2_WT_Wrappers_Create_Delayed.R2_ADI_TXT_CR_Remarks_Cost__c>(); }
				// R2_WT_Wrappers_Create_Delayed.CostRemark costRemark = new R2_WT_Wrappers_Create_Delayed.CostRemark();
				// costRemark.CostRemarksText = field.value;
				// costRemark.seq = String.valueof(requestWR.claim.claimData.costRemarks.length + 1);
				// requestWR.claim.claimData.costRemarks.add(costRemark); // FIXME desccomentar cuando se implemente el wrapper
				// START FIXME eliminar cuando se implemente lo de arriba
				if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				if (requestWR.claim.claimData.costRemarks == null) { requestWR.claim.claimData.costRemarks = new List<String>(); }
				requestWR.claim.claimData.costRemarks.add(field.value);
				// END FIXME eliminar cuando se implemente lo de arriba
			}
		}
	}

	private void parseSection9(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		//for (Field field : incidentInformationSection9) {
		//	if (field.value == '' || field.value == null) { continue; }
		//	if (field.name == 'R2_ADI_ATXTL_MR_Match__c') {
		//		//R2_WT_Wrappers_Create_Delayed.MatchInfoType matchInfo1 = new R2_WT_Wrappers_Create_Delayed.MatchInfoType();
		//		//matchInfo1.matchInfoText = field.value;
		//		//matchInfo1.seq = ''+1;
		//		//if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
		//		//if (requestWR.additionalInfo.matchInfo == null) { requestWR.additionalInfo.matchInfo = new List<R2_WT_Wrappers_Create_Delayed.MatchInfoType>(); }
		//		//requestWR.additionalInfo.matchInfo.add(matchInfo1);
		//	}
		//}
	}

	private void parseSection10(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
		//for (Field field : incidentInformationSection10) {
		//	System.debug(field.value);
		//	if (field.value == '' || field.value == null) { continue; }
		//	if (field.name == 'R2_ADI_ATXTL_MG_Message__c') {
		//		//R2_WT_Wrappers_Create_Delayed.MessageInfoType messageInfo1 = new R2_WT_Wrappers_Create_Delayed.MessageInfoType();
		//		//messageInfo1.messageInfoText = field.value;
		//		//messageInfo1.seq = ''+1;
		//		//if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_Wrappers_Create_Delayed.AdditionalInfo(); }
		//		//if (requestWR.additionalInfo.messageInfo == null) { requestWR.additionalInfo.messageInfo = new List<R2_WT_Wrappers_Create_Delayed.MessageInfoType>(); }
		//		//requestWR.additionalInfo.messageInfo.add(messageInfo1);
		//	}
		//}
	}
/* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    ********************************************************* CONTENIDO DE MALETA - COMPONENTE DE LA VISUAL ***************************************************************************************************************************************************************************
    ************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    */
    private void parseBagInfo(R2_WT_Wrappers_Create_Delayed.Create_Delayed_Heroku requestWR) {
        R2_WT_Wrappers_Create_Delayed.DelayedBagGroup delayBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup();
        List<R2_WT_Wrappers_Create_Delayed.DelayedBags> lstDelayBags = new List<R2_WT_Wrappers_Create_Delayed.DelayedBags>();
        System.debug('!!!bagLst: ' + bagLst);
        //requestWR.delayedBagGroup.delayedBags
        // for para rellenar los campos de maleta
        if(!bagLst.isEmpty()){
            for(Integer i = 0;i<bagLst.size();i++){
                R2_WT_Wrappers_Create_Delayed.DelayedBags delayBags = new R2_WT_Wrappers_Create_Delayed.DelayedBags();
                R2_WT_Wrappers_Create_Delayed.BagReceivedFromCustoms sentCustoms = new R2_WT_Wrappers_Create_Delayed.BagReceivedFromCustoms();
                R2_WT_Wrappers_Create_Delayed.BagReceivedFromCustoms receiveCustoms = new R2_WT_Wrappers_Create_Delayed.BagReceivedFromCustoms();
                R2_WT_Wrappers_Create_Delayed.BagContents bagCont = new R2_WT_Wrappers_Create_Delayed.BagContents();
                R2_WT_Wrappers_Create_Delayed.ColorTypeDesc colorType = new R2_WT_Wrappers_Create_Delayed.ColorTypeDesc();
                R2_WT_Wrappers_Create_Delayed.Descriptor descrip = new R2_WT_Wrappers_Create_Delayed.Descriptor();
                R2_WT_Wrappers_Create_Delayed.BrandInfo brandInf = new R2_WT_Wrappers_Create_Delayed.BrandInfo();
                R2_WT_Wrappers_Create_Delayed.BagTag bagtag = new  R2_WT_Wrappers_Create_Delayed.BagTag();        
                R2_WT_Wrappers_Create_Delayed.LicenseNumber licens = new R2_WT_Wrappers_Create_Delayed.LicenseNumber();
                R2_WT_Wrappers_Create_Delayed.BagDelivery bagDeliv = new R2_WT_Wrappers_Create_Delayed.BagDelivery();
                R2_WT_Wrappers_Create_Delayed.Status delivStatus = new R2_WT_Wrappers_Create_Delayed.Status();
                R2_WT_Wrappers_Create_Delayed.BagReceived bagReceiv = new R2_WT_Wrappers_Create_Delayed.BagReceived();
                R2_WT_Wrappers_Create_Delayed.UniqueID uniq = new R2_WT_Wrappers_Create_Delayed.UniqueID();
                
                List<String> otrosElem = new List<String>();
                System.debug('Descripcion de maleta: ' +bagLst[i]);
                if(bagLst[i].R2_BAG_PKL_Type__c!=null && bagLst[i].R2_BAG_PKL_Colour__c!=null){
                    if(bagLst[i].R2_BAG_PKL_Type__c=='22D' || bagLst[i].R2_BAG_PKL_Type__c=='22R'){
                        colorType.typeCode = '22';
                    }else{
                        colorType.typeCode = bagLst[i].R2_BAG_PKL_Type__c;
                    }
                    colorType.colorCode = bagLst[i].R2_BAG_PKL_Colour__c;
                    //colorType.suspended = bagLst[i].R2_BAG_CHK_Suspended__c;
                    
                    if(bagLst[i].R2_BAG_CHK_Metal__c){
                        descrip.materialElement = 'M';
                    }else if(bagLst[i].R2_BAG_CHK_Rigid__c){
                        descrip.materialElement = 'R';                    
                    }else if(bagLst[i].R2_BAG_CHK_Mixed__c){
                        descrip.materialElement = 'D';
                    }else if(bagLst[i].R2_BAG_CHK_Leather__c){
                        descrip.materialElement = 'L';
                    }else if(bagLst[i].R2_BAG_CHK_Printed_fabric__c){
                        descrip.materialElement = 'T';
                    }
                    
                    System.debug('Tamaño otros: '+ otrosElem.size() +' y material element '+ descrip.materialElement);

                    if(bagLst[i].R2_BAG_CHK_Retractable_handle__c){
                        if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('H');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Combination_lock__c){
                        if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('C');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Wheels_or_bearing__c){
                         if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('W');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Single_object_in_box__c){
                        if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('B');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Suitcase_allowed_cabin__c){
                        if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('K');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Safety_belt__c){
                        if((otrosElem.size()<3 && descrip.materialElement==null) || (otrosElem.size()<2 && descrip.materialElement!=null)){
                            otrosElem.add('S');
                        }
                    }
                    
                    if(otrosElem.size()==0 && descrip.materialElement==null){
                        otrosElem.add('X');
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(otrosElem.size()==1 && descrip.materialElement==null){
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(otrosElem.size()==2 && descrip.materialElement==null){
                        otrosElem.add('X'); 
                    }else if(descrip.materialElement!=null && otrosElem.size()==0){
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(descrip.materialElement!=null && otrosElem.size()==1){
                        otrosElem.add('X');
                    }
                    
                    descrip.otherElement = otrosElem;
                    colorType.Descriptor = descrip;
                    delayBags.colorTypeDesc = colorType;
                }
                
                if(bagLst[i].R2_BAG_TXT_Ticket_number__c!=null && bagLst[i].R2_BAG_TXT_Ticket_number__c!=''){
                    
                    if(bagLst[i].R2_BAG_TXT_Ticket_number__c.length()==8){
                        bagtag.tagSequence = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(2);
                        bagtag.airlineCode = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(0,2);
                    }else if(bagLst[i].R2_BAG_TXT_Ticket_number__c.length()==9){
                        bagtag.tagSequence = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(3);
                        licens.issuerCode = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(0,3);
                    }

                    bagtag.licenseNumber = licens;
                    delayBags.BagTag = bagtag;
                } 
                
                if(bagLst[i].R2_BAG_TXT_Brand_Info__c!=null && bagLst[i].R2_BAG_TXT_Brand_Info__c!=''){
                    brandInf.brandInfo = bagLst[i].R2_BAG_TXT_Brand_Info__c;
                    //brandInf.suspended = bagLst[i].R2_BAG_TXT_Brand_Info_Suspended__c;
                    delayBags.BrandInfo = brandInf;
                }
                
                if(bagLst[i].R2_BAG_DAT_Suitcase_delivery_date__c!=null){
                    bagDeliv.deliveredTime = String.valueOf(bagLst[i].R2_BAG_DAT_Suitcase_delivery_date__c);
                    if(bagLst[i].R2_BAG_TXT_OF__c!=null && bagLst[i].R2_BAG_TXT_OF__c!=''){
                        delivStatus.outForDelivery = bagLst[i].R2_BAG_TXT_OF__c;
                    }
                    if(bagLst[i].R2_BAG_TXT_OD__c!=null && bagLst[i].R2_BAG_TXT_OD__c!=''){
                        delivStatus.delivered = bagLst[i].R2_BAG_TXT_OD__c;
                    }
                    if(bagLst[i].R2_BAG_TXT_UP__c !=null && bagLst[i].R2_BAG_TXT_UP__c!=''){
                        delivStatus.trackingUpdate = bagLst[i].R2_BAG_TXT_UP__c;
                    }
                    if(bagLst[i].R2_BAG_TXT_UnableToDeliver__c !=null && bagLst[i].R2_BAG_TXT_UnableToDeliver__c!=''){
                        delivStatus.unableToDeliver = bagLst[i].R2_BAG_TXT_UnableToDeliver__c;
                    }
                    if(bagLst[i].R2_BAG_DAT_DateBagReceived__c !=null){
                        bagReceiv.bagReceivedDate = String.valueOf(bagLst[i].R2_BAG_DAT_DateBagReceived__c);
                        bagReceiv.station = bagLst[i].R2_BAG_TXT_StationBagReceived__c;
                        bagDeliv.bagReceived = bagReceiv;
                    }
                    
                    bagDeliv.status = delivStatus; 
               		delayBags.BagDelivery = bagDeliv;
                }
                
                if(bagLst[i].R2_BAG_TXT_Lock_Code__c!=null && bagLst[i].R2_BAG_TXT_Lock_Code__c!=''){
                    delayBags.lockCode = bagLst[i].R2_BAG_TXT_Lock_Code__c;
                }
                
                if(bagLst[i].R2_BAG_TXT_UniqueID__c!=null && bagLst[i].R2_BAG_TXT_UniqueID__c!=''){
                    uniq.UniqueID = bagLst[i].R2_BAG_TXT_UniqueID__c;
                    //uniq.suspended = bagLst[i].R2_BAG_CHK_UniqueID_Suspended__c;
                    delayBags.UniqueID = uniq;
                }
                
                if(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c!=null){
                    sentCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=''){
                        sentCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c;
                    }
                    delayBags.bagSentToCustoms = sentCustoms;
                }
                
                
                if(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c!=null){
                    receiveCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=''){
                        receiveCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c;
                    }
                    delayBags.bagReceivedFromCustoms = receiveCustoms;
                }
                
                
                if(bagLst[i].R2_BAG_TXT_Storage_Location__c!=null && bagLst[i].R2_BAG_TXT_Storage_Location__c!=''){
                    delayBags.storageLocation = bagLst[i].R2_BAG_TXT_Storage_Location__c;
                }
                
                List<R2_WT_Wrappers_Create_Delayed.Content> lstCont = new List<R2_WT_Wrappers_Create_Delayed.Content>();
                
                // for para rellenar los campos de contenidos
                if(!mapCont.get(i).isEmpty()){
                    for(Integer z = 0;z < mapCont.get(i).size();z++){
                        R2_WT_Wrappers_Create_Delayed.Content cont = new R2_WT_Wrappers_Create_Delayed.Content();
                        if(mapCont.get(i)[z].R2_CB_TXT_Type__c!=null && mapCont.get(i)[z].R2_CB_TXT_Type__c!=''){
                            cont.category = mapCont.get(i)[z].R2_CB_TXT_Type__c;
                        }
                        if(mapCont.get(i)[z].R2_CB_TXT_Description__c!=null && mapCont.get(i)[z].R2_CB_TXT_Description__c!=''){
                            cont.description = mapCont.get(i)[z].R2_CB_TXT_Description__c;
                        }
                        lstCont.add(cont);
                        //bagCont.content.add(cont);
                    }
                    bagCont.content = lstCont;
                    //bagCont.suspended = bagLst[i].R2_BAG_CHK_BagContends_Suspended__c;
                    delayBags.bagContents = bagCont;
                }
                
                
                if(bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=null && bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=''){
                    delayBags.bagDetails = bagLst[i].R2_BAG_TXT_Aditional_damage_information__c;
                }
                
                if(bagLst[i].R2_CB_TXT_Contents_Desc__c!=null && bagLst[i].R2_CB_TXT_Contents_Desc__c!=''){
                    delayBags.contentDescription = bagLst[i].R2_CB_TXT_Contents_Desc__c;
                }

                
                if(bagLst[i].R2_BAG_TXT_Comments__c!=null && bagLst[i].R2_BAG_TXT_Comments__c!=''){
                    List<String> lstRemarks = new List<String>();
                    String cadenaRK = bagLst[i].R2_BAG_TXT_Comments__c;

                    String rk1 = null;
                    if(cadenaRK.length() <= 58){
                        rk1 = cadenaRK.substring(0);
                    }else{
                        rk1 = cadenaRK.substring(0, 58);
                    }
                    lstRemarks.add(rk1);

                    if(cadenaRK.length() > 58){
                        String rk2 = cadenaRK.substring(58, 116);
                        lstRemarks.add(rk2);
                    }
                    if(cadenaRK.length() > 116){
                        String rk3 = cadenaRK.substring(116, 174);
                        lstRemarks.add(rk3);
                    }
                    delayBags.remarks = lstRemarks;
                }
                
                lstDelayBags.add(delayBags); 
            }
            delayBagGroup.delayedBags = lstDelayBags;
        }
        requestWR.delayedBagGroup = delayBagGroup;
    }
    
	// PARSE 4
	// else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
	// 	R2_CLS_WT_Bags_Management.MiscellaneousInfo miscellInfo = new R2_CLS_WT_Bags_Management.MiscellaneousInfo();
	// 	miscellInfo.miscInfoText = field.value;
	// 	miscellInfo.seq = ''+1;
	// 	additionInfo.miscellaneousInfo.add(miscellInfo);
	// }
	// else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
	// 	R2_CLS_WT_Bags_Management.UserComments miscellInfo = new R2_CLS_WT_Bags_Management.UserComments();
	// 	miscellInfo.commentsText = field.value;
	// 	miscellInfo.seq = ''+1;
	// 	additionInfo.userComments.add(miscellInfo);
	// }
	// 
	// 
	//
	// 
	// 
	// 
	// 
	// 	 /*---------------------------------------------------------------------------------------------------------------------

    	 /*---------------------------------------------------------------------------------------------------------------------
	 /*---------------------------------------------------------------------------------------------------------------------

	 /*---------------------------------------------------------------------------------------------------------------------


	 /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que carga la pagina visual
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void cargarVisual(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            //incidencia = [SELECT ID, Name FROM R1_Incident__c WHERE ID = :incidenciaID LIMIT 1];
            
            imgMaletaVacia = 'ImagenesMaletas/maleta-vacia.gif';
            imgMaletaON = 'ImagenesMaletas/maleta-on.gif';
            imgMaletaLlena = 'ImagenesMaletas/maleta-llena.gif';
            
            tipoCont = '';
            desCont = '';
            boolBorrar = false;
            System.debug('!!!MaletaVacia: ' + imgMaletaVacia);
            
            
            if(!bagLst.isEmpty()){
                
                bagMostrar(maletaSelect);
                getBagImageMaleta();
                getBagImageTipo();
                getBagImageColor();
                
                if(maletaSelect == 0){
                    imgMaleta1 = imgMaletaOn;
                }else if(maletaSelect == 1){
                    imgMaleta2 = imgMaletaOn;
                }else if(maletaSelect == 2){
                    imgMaleta3 = imgMaletaOn;
                }else if(maletaSelect == 3){
                    imgMaleta4 = imgMaletaOn;
                }else if(maletaSelect == 4){
                    imgMaleta5 = imgMaletaOn;
                }else if(maletaSelect == 5){
                    imgMaleta6 = imgMaletaOn;
                }else if(maletaSelect == 6){
                    imgMaleta7 = imgMaletaOn;
                }else if(maletaSelect == 7){
                    imgMaleta8 = imgMaletaOn;
                }else if(maletaSelect == 8){
                    imgMaleta9 = imgMaletaOn;
                }else if(maletaSelect == 9){
                    imgMaleta10 = imgMaletaOn;
                }
                
                System.debug('bag' + bag);
                System.debug('Listabag' + bagLst);
            }else{
                bag = new R2_Baggage__c();
                lstContent = new List<R2_Content_Baggage__c>();
                getBagImageMaleta();
                getBagImageTipo();
                getBagImageColor();
                
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.cargarVisual()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }   
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que carga las imagenes pequeñas de maletas segun el numero de equipajes de la incidencia
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void getBagImageMaleta() {
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            if(!bagLst.isEmpty()){
                if(bagLst.size()>=1){
                    imgMaleta1 = imgMaletaLlena;    
                }
                if(bagLst.size()>=2){
                    imgMaleta2 = imgMaletaLlena;
                }else{
                    imgMaleta2 = imgMaletaVacia;
                }
                if(bagLst.size()>=3){
                    imgMaleta3 = imgMaletaLlena;
                }else{
                    imgMaleta3 = imgMaletaVacia;
                }
                if(bagLst.size()>=4){
                    imgMaleta4 = imgMaletaLlena;
                }else{
                    imgMaleta4 = imgMaletaVacia;
                }
                if(bagLst.size()>=5){
                    imgMaleta5 = imgMaletaLlena;
                }else{
                    imgMaleta5 = imgMaletaVacia;
                }
                if(bagLst.size()>=6){
                    imgMaleta6 = imgMaletaLlena;
                }else{
                    imgMaleta6 = imgMaletaVacia;
                }
                if(bagLst.size()>=7){
                    imgMaleta7 = imgMaletaLlena;
                }else{
                    imgMaleta7 = imgMaletaVacia;
                }
                if(bagLst.size()>=8){
                    imgMaleta8 = imgMaletaLlena;
                }else{
                    imgMaleta8 = imgMaletaVacia;
                }
                if(bagLst.size()>=9){
                    imgMaleta9 = imgMaletaLlena;
                }else{
                    imgMaleta9 = imgMaletaVacia;
                }
                if(bagLst.size()>=10){
                    imgMaleta10 = imgMaletaLlena;
                }else{
                    imgMaleta10 = imgMaletaVacia;
                }
            }else{
                imgMaleta1 = imgMaletaOn;
                imgMaleta2 = imgMaletaVacia;
                imgMaleta3 = imgMaletaVacia;
                imgMaleta4 = imgMaletaVacia;
                imgMaleta5 = imgMaletaVacia;
                imgMaleta6 = imgMaletaVacia;
                imgMaleta7 = imgMaletaVacia;
                imgMaleta8 = imgMaletaVacia;
                imgMaleta9 = imgMaletaVacia;
                imgMaleta10 = imgMaletaVacia;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.getBagImageMaleta()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que cambia la imagen a maletaOn cuando pinchas en una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void cargarImgMaletaOn(){
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            String idImg = Apexpages.currentPage().getParameters().get('imgParam');
            getBagImageMaleta();
            
            if(idImg=='img1'){       
                if(bagLst.size()>=0){
                    imgMaleta1 = imgMaletaOn;
                    if(bagLst.size()>=1){
                        verSaveUpdate = true;
                        bagMostrar(0);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                    
                }
            }else if(idImg=='img2'){    
                if(bagLst.size()>=1){
                    imgMaleta2 = imgMaletaOn;
                    if(bagLst.size()>=2){  
                        verSaveUpdate = true;
                        bagMostrar(1);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img3'){ 
                if(bagLst.size()>=2){
                    imgMaleta3 = imgMaletaOn;
                    if(bagLst.size()>=3){
                        verSaveUpdate = true;
                        bagMostrar(2);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img4'){   
                if(bagLst.size()>=3){
                    imgMaleta4 = imgMaletaOn;
                    if(bagLst.size()>=4){
                        verSaveUpdate = true;
                        bagMostrar(3);
                        getBagImageTipo();
                        getBagImageColor();
                        
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img5'){   
                if(bagLst.size()>=4){
                    imgMaleta5 = imgMaletaOn;
                    if(bagLst.size()>=5){
                        verSaveUpdate = true;
                        bagMostrar(4);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img6'){ 
                if(bagLst.size()>=5){
                    imgMaleta6 = imgMaletaOn;
                    if(bagLst.size()>=6){
                        verSaveUpdate = true;
                        bagMostrar(5);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img7'){     
                if(bagLst.size()>=6){
                    imgMaleta7 = imgMaletaOn;
                    if(bagLst.size()>=7){
                        verSaveUpdate = true;
                        bagMostrar(6);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img8'){  
                if(bagLst.size()>=7){
                    imgMaleta8 = imgMaletaOn;
                    if(bagLst.size()>=8){
                        verSaveUpdate = true;
                        bagMostrar(7);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img9'){    
                if(bagLst.size()>=8){
                    imgMaleta9 = imgMaletaOn;
                    if(bagLst.size()>=9){
                        verSaveUpdate = true;
                        bagMostrar(8);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }
            }else if(idImg=='img10'){
                if(bagLst.size()>=9){
                    imgMaleta10 = imgMaletaOn;
                    if(bagLst.size()>=10){
                        verSaveUpdate = true;
                        bagMostrar(9);
                        getBagImageTipo();
                        getBagImageColor();
                        
                    }else{
                        bag = new R2_Baggage__c();
                        lstContent = new List<R2_Content_Baggage__c>();
                        getBagImageTipo();
                        getBagImageColor();
                        verSaveUpdate = false;
                    }
                }        
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.cargarImgMaletaOn()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que carga la imagen del tipo de maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void getBagImageTipo() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            String csTypeBag = 'ImagenesMaletas/Ct' + bag.R2_BAG_PKL_Type__c + '.JPG';
            imgTipoMaleta = csTypeBag; 
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.getBagImageTipo()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }    
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que carga la imagen del color de la maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void getBagImageColor() {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            String colorBag = 'ImagenesMaletas/' + bag.R2_BAG_PKL_Colour__c + '.gif';
            imgColorMaleta = colorBag;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.getBagImageColor()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }   
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que carga los datos de la maleta en el formulario
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public void bagMostrar(Integer posicion){   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            
            bag = bagLst[posicion];
            totalMaletas = bagLst.size();
            maletaSelect = posicion;
            mostrarContenido();
            
            
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.bagMostrar()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        } 
    }
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
20/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
    public void mostrarContenido(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            //lstContInicial = [SELECT Id, R2_CB_TXT_Description__c, R2_BG_CHK_Select__c, R2_CB_TXT_Type__c FROM R2_Content_Baggage__c WHERE R2_CB_MSDT_Baggage__c = :bag.Id LIMIT 12];
            //lstContent.clear();
            lstContInicial = new List<R2_Content_Baggage__c>();
            if(!lstContInicial.isEmpty()){
                if(mapCont.get(maletaSelect).isEmpty()){
                    mapCont.get(maletaSelect).addAll(lstContInicial);   
                    lstContent = mapCont.get(maletaSelect);
                }else{
                    lstContent = mapCont.get(maletaSelect);
                }
            }else{
                lstContent = mapCont.get(maletaSelect);
            }
            System.debug('lstCont ' + mapCont.get(maletaSelect));
            
            numCont = lstContent.size();
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.mostrarContenido()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
20/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
    public void guardarContenido(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            if((tipoCont != '' && tipoCont != null) && (desCont != '' && desCont != null)){
                R2_Content_Baggage__c newContent = new R2_Content_Baggage__c();
                newContent.R2_CB_TXT_Type__c = tipoCont;
                newContent.R2_CB_TXT_Description__c = desCont;
                
                if(bag.Id==null){
                    mapCont.get(maletaSelect).add(newContent);
                    lstContent = mapCont.get(maletaSelect);
                }else{
                    newContent.R2_CB_MSDT_Baggage__c = bag.Id;
                    mapCont.get(maletaSelect).add(newContent);
                    lstContent = mapCont.get(maletaSelect);
                }
                
            }
            cargarVisual();
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.guardarContenido()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
    public void newBag(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            System.debug('LaBagNueva:' + bag);
            
            if(actionBag == 'save'){
                bagLst.add(bag);
                maletaSelect = totalMaletas;
                actionBag = 'save';    
				verSaveUpdate = true;       
                getBagImageTipo();
                getBagImageColor();
            }else if(actionBag == 'update'){
                bagLst.add(maletaSelect + 1, bag);
                bagLst.remove(maletaSelect);
                actionBag = 'update';
                getBagImageTipo();
                getBagImageColor();
            }
            
            cargarVisual();    
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.newBag()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
21/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/  
    public void updateContent(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            if(!lstContent.isEmpty()){
                for(Integer i = 0;i<lstContent.size();i++){
                    mapCont.get(maletaSelect).set(i, lstContent[i]);
                }
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.updateContent()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }     
    }
    

    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
21/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/  
    public void removeBag(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            bagLst.remove(maletaSelect);        
            bag = new R2_Baggage__c();
            lstContent = new List<R2_Content_Baggage__c>();
            boolBorrar = false;
            verSaveUpdate = false;
            getBagImageTipo();
            getBagImageColor();
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.removeBag()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }  
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
21/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/  
    public void deleteCont(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            
            if(!lstContent.isEmpty()){
                for(Integer i = 0;i<lstContent.size();i++){
                    if(lstContent[i].R2_BG_CHK_Select__c){
                        lstContent.remove(i);
                        i = i - 1;
                    }     
                }
                
                if(!lstContent.isEmpty()){
                    recargarLstCont(lstContent);
                }
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.deleteCont()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }  
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
21/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/  
    public void recargarLstCont(List<R2_Content_Baggage__c> lstCont){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            if(!lstCont.isEmpty()){     
                mapCont.put(maletaSelect, lstCont);
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.recargarLstCont()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }  
    }

    /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    Metodo que guarda una nueva maleta o actualiza una maleta
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
21/11/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/  
    public void switchBoolBorrar(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            if(boolBorrar){     
                boolBorrar = false;
            }else{
                boolBorrar = true;
            }
            
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.swichBoolBorrar()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }  
    }
}