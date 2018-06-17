public with sharing class R2_CLS_INC_Create_PIR_Damaged_Controller{
	/*---------------------------------------------------------------------------------------------------------------------
	    Author:         Alberto Puerto Collado
	    Company:        Accenture
	    Description:    create pir damaged controller 
	    IN:
	    OUT:

	    History:
	     <Date>                     <Author>                         <Change Description>
	    11/12/2017             Alberto Puerto Collado                  Initial Version
	    ----------------------------------------------------------------------------------------------------------------------*/
   
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
    public R2_CLS_WT_Wrappers_Create_Damaged.Record registro{get;set;}
    public List<R2_CLS_WT_Wrappers_Create_Damaged.Warnings> warnings{get;set;}
    public List<R2_CLS_WT_Wrappers_Create_Damaged.Errors> errors{get;set;}
    public Id newId{get;set;}
    public List<String> lstRespuestas{get;set;} //cambiar por string personalizado según errores o no.. etc
    public String informeCrear{get;set;}
    R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedResponse resultado {get;set;}

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

	//private final Set<String> mandatoryFields = new Set<String> {'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_TXT_PIR_Name__c' , 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c'};//, 'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Route__c', 'R2_INC_PKL_PIR_Send_SMS_email__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c'};
	//private final Set<String> nonDisabledFields = new Set<String>  {'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c',  'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c', 'R2_INC_TXT_PIR_Initial2__c', 'R2_INC_TXT_PIR_Initial3__c', 'R2_INC_TXT_PIR_Treatment__c'};
    private final Set<String> nonDisabledFields = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c', 'R2_INC_TXT_PIR_Responsible_Scale__c', 'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 
    															'R2_INC_TXT_PIR_Passenger_language__c',  'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c', 
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
    															'R2_INC_CHK_PIR_Replace_suitcase__c', 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c', 'R2_INC_TXT_PIR_Lost_reason_causes__c',
    															'R2_INC_TXT_PIR_Lost_content1__c', 'R2_INC_TXT_PIR_Lost_content2__c', 'R2_INC_PKL_PIR_Send_SMS_email__c' 
                                                                 };
    private final Set<String> mandatoryFields = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c', 'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c', 
																'R2_INC_TXT_PIR_Ticket_number__c', 'R2_INC_TLF_Landline1__c', // 'R2_INC_TLF_PIR_Mobile_phone_number1__c', 
																'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_EMA_PIR_Email1__c', 'R2_INC_TXT_PIR_flight_Number__c', 
																'R2_INC_TXT_PIR_Baggage_Weight_piece__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c', 'R2_INC_TXT_PIR_Route__c',
																'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Lost_reason__c' , 'R2_INC_TXT_PIR_Passenger_category__c', 'R2_INC_PKL_PIR_Send_SMS_email__c'
																};// {'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_TXT_PIR_Name__c' , 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c'};//, 'R2_INC_TXT_PIR_Permanent_address1__c', 'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_TXT_PIR_Route__c', 'R2_INC_PKL_PIR_Send_SMS_email__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c'};
	//private final Set<String> nonDisabledFields = new Set<String> {};// {'R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_TXT_PIR_Name__c', 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c',  'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c', 'R2_INC_TXT_PIR_Initial2__c', 'R2_INC_TXT_PIR_Initial3__c', 'R2_INC_TXT_PIR_Treatment__c'};
   

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

	private final Set<String> fieldsIncidentSection7 = new Set<String> {/*'R2_INC_TXT_Last_Seen__c', */'R2_INC_TXT_PIR_Lost_content1__c', 'R2_INC_TXT_PIR_Lost_content2__c', 'R2_INC_TXT_PIR_Address_in_suitcase1__c', 
															            /*'R2_INC_TXT_PIR_Address_in_suitcase2__c', */'R2_INC_TXT_Excess_Baggage__c', 'R2_INC_TLF_PIR_Phone_number_suitcase1__c', 'R2_INC_TLF_PIR_Phone_number_suitcase2__c', 
															            'R2_INC_TXT_PIR_Baggage_destination__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c', 
															            'R2_INC_CHK_PIR_Limited_approval_label__c'
																		};
	private final Set<String> fieldsAuxiliarSection7 = new Set<String> {};//'R2_ADI_ATXTL_DS_Delivery_service__c'};

	private final Set<String> fieldsIncidentSection8 = new Set<String> {'R2_INC_TXT_PIR_Shared_code__c', 'R2_INC_CHK_PIR_Baggage_insurance__c', 'R2_INC_TXT_PIR_Lost_reason__c',/* 'R2_INC_TXT_PIR_Special_lost_reason__c', */'R2_INC_CHK_PIR_Replace_suitcase__c', 
																		'R2_INC_TXT_PIR_Lost_reason_causes__c' //, 'R2_INC_TXT_PIR_DO_Flight__c'
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

	public R2_CLS_INC_Create_PIR_Damaged_Controller() {
        
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
        
        
		System.debug('::Campos MANDATORY:::::'+mandatoryFields);
        System.debug('::Campos NO disabled'+nonDisabledFields);

		System.debug('CONSTRUCTOR');
		String incidentId = ApexPages.currentPage().getParameters().get('incidentId');
		if (incidentId != null && incidentId != '') {
			initializeObjects(incidentId);
			incidentHeader = 'Modify Delay Incident ' + incidentId;
		} else {
			incidentHeader = 'Crear nuevo PIR: Dañado';
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Create_PIR_Damaged_Controller.getIncidentInformation()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
            return null;
        } 
    }

    public List<Field> getFields(String objectName, Set<String> listFields){
        System.debug('::getFields::::'+objectName+'/////'+listFields);
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
            //selectOption('apiSalesForce', 'Label a mostrar')
            options.add(new SelectOption('NO','NO'));
            options.add(new SelectOption('YES','YES'));
        }
        if (name == 'R2_INC_PKL_PIR_Send_SMS_email__c'){
        	options.add(new SelectOption('','--Select Option--'));
            options.add(new SelectOption('SMS','SMS (S)'));
            options.add(new SelectOption('EMAIL','EMAIL (E)'));   
            options.add(new SelectOption('SMS_AND_EMAIL','SMS_AND_EMAIL (Y)'));
            options.add(new SelectOption('NO_MESSAGE','NO_MESSAGE (N)'));  
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
        11/12/2017             Alberto Puerto Collado                   Initial Version
        09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
    public void createPIR(){
        try{
            R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR = new R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest();

            //String goodJson = '{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127 ELMO AVE, POUGHKEEPSIE VA 30335"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420 HIGH STREET, DAYTON OH 45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM","seq":"1"}]},"bagPhones":{"phone":["770 850 4550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:33","status":{"outForDelivery":"123","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERS MISSING"],"contentsDamage":"CONTENTS DAMAGE"},"passenger":{"names":[{"name":"TINTIN","seq":"1"},{"name":"KAMINSKYA","seq":"2"}],"initials":[{"initial":"P","seq":"1"}],"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666 PALACE BLVD, LONDON GB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"Great Britain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400 PENNSYLVANIA LN, WASHINGTON OK 30339"},"validityDate":"2017-09-10"},"permanentPhones":{"phone":["770 850 4550"],"seq":"1"},"cellPhones":{"phone":["404 431 9238"]},"temporaryPhones":{"phone":["404 431 3980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","noOfpassenger":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","date":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}]},"designatedLocator":"1234","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Free misc"},{"miscInfoText":"Free misc One"}],"furtherInfo":"further info","supplementaryInfo":[{"supplimentInfoText":"Free supp info"},{"supplimentInfoText":"Free supp info One"}],"customsInfo":"customs info","userComments":[{"commentsText":"abcgd"}]},"claim":{"claimAmount":{"amount":{"amount":"5000","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OST REMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35.45","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-09-10","notifiedDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BAB"},"lossComments":"RL COMMENTS","lossReasonCode":"91","replacementBag":"true","repairBag":"false"},"agentId":"AGENT"}';
            
            
            //goodJson = goodJson.replaceAll('"rDate"', '"date"');
            //goodJson = goodJson.replace('"rDate"','"date"');
            //goodJson = goodJson.replace('"type_Z"','"type"');
            //goodJson = goodJson.replace('"date"','"rDate"');
            //goodJson = goodJson.replace('"type"','"type_Z"');
            //System.debug('---> JSON good hc' + goodJson);
            //requestWR = (R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest) JSON.deserialize(goodJson, R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest.class);
//DESCOMENTAR abajo
			parseBagDamagedInfo(requestWR);
            parseSection1(requestWR);
            parseSection2(requestWR);
            parseSection3(requestWR);
            parseSection4(requestWR);
            parseSection5(requestWR);
            parseSection6(requestWR);
            parseSection7(requestWR);
            parseSection8(requestWR);
            parseSection9(requestWR);
            parseSection10(requestWR);

            String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            requestWR.agentId = agentId;
//DESCOMENTAR arriba
             //R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType nrt = new R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType();
             //nrt.recordType = 'DELAYED';
             //R2_CLS_WT_Wrappers_Create_Damaged.AssociatedRecord ar = new R2_CLS_WT_Wrappers_Create_Damaged.AssociatedRecord();
             //ar.referenceNumber = '987011';
             //ar.stationCode = 'MAD';
             //ar.airlineCode = 'IB';
             //nrt.recordReference = ar;
            
             //requestWR.damagedBagGroup.delayedBags[0].associatedRecord = nrt;

            System.debug(requestWR);

            System.debug('WRAPPER_REQUEST:::'+requestWR);

            String wrapperJson = JSON.serialize(requestWR);
            System.debug('STRING_REQUEST:::'+requestWR);
            wrapperJson = wrapperJson.replaceAll('"rDate"', '"date"');
            wrapperJson = wrapperJson.replaceAll('"type_Z"','"type"');
            wrapperJson = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapperJson);
            wrapperJson = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapperJson);
            System.debug(':::FIXED? STRING_REQUEST:::'+wrapperJson);
            //String resultado = R2_CLS_WT_Wrappers_Create_Damaged.CreateDelayedBag(wrapperJson, 0);
            //R2_CLS_WT_Wrappers_Create_Damaged.WR_DelayedBagWebRespRecord 
            resultado = R2_CLS_WT_Wrappers_Create_Damaged.createDamagedPIR(wrapperJson, 0);
            System.debug('REDOBLE DE TAMBORES........ ' + resultado);

            //List<String> lstResultado = resultado.split('@splitMe@');
            
            //resp.record
            //R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType 
            //registro = (R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType)JSON.deserialize(lstResultado[0],R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType.class);
            //R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType resp = (R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType)JSON.deserialize(lstResultado[0],R2_CLS_WT_Wrappers_Create_Damaged.NewRecordType.class);
            
            //resp.warnings
            //List<R2_CLS_WT_Wrappers_Create_Damaged.WarningType>
            //warnings = (List<R2_CLS_WT_Wrappers_Create_Damaged.WarningType>) JSON.deserialize(lstResultado[1], List<R2_CLS_WT_Wrappers_Create_Damaged.WarningType>.class);
            //resp.errors
            //List<R2_CLS_WT_Wrappers_Create_Damaged.ErrorType> 
            //errors = (List<R2_CLS_WT_Wrappers_Create_Damaged.ErrorType>) JSON.deserialize(lstResultado[1], List<R2_CLS_WT_Wrappers_Create_Damaged.ErrorType>.class);
            //System.debug('::REGISTRO-> '+registro+'#######WARNINGS-> '+warnings+'#######ERRORS-> '+errors);
            
            if(resultado != null){
	            System.debug('::REGISTRO-> '+resultado.record+'#######WARNINGS-> '+resultado.warnings+'#######ERRORS-> '+resultado.errors);
	            if(resultado.success == 'YES' || resultado.success == 'TRUE'){//!resultado.contains('error') && !resultado.contains('reason') ){
	                //avisar de warnings y después leer y cargar detalle de pir
	                //leemos y cargamos
	                //DEBUG|bigWP::::::::READ: EJEMPLO Leído:
	                //{"recordId":{"recordType":"DELAYED","
	                                //recordReference":{"stationCode":"stationCode","referenceNumber":"referenceNumber","airlineCode":"airlinecode"}},"
	                                //agentId":"agentId"}
	                //ejemplo:R1_CLS_Utilities.readRecord_WT('DELAYED', 'stationCode', 'airlinecode', 'referenceNumber', 'agentId', 1);
	                //Id 
	                //newId = R1_CLS_Utilities.readRecord_WT(registro.recordType, 
	                //                                registro.recordReference.stationCode,
	                //                                registro.recordReference.airlinecode, 
	                //                                registro.recordReference.referenceNumber,
	                //                                'agentId',
	                //                                 1);
	                newId = R1_CLS_Utilities.readRecord_WT(resultado.record.recordType, 
	                                                resultado.record.recordReference.stationCode,
	                                                resultado.record.recordReference.airlinecode, 
	                                                resultado.record.recordReference.referenceNumber,
	                                                agentId,
	                                                 1);
	                System.debug('ID del pir creado:'+newId);
                    CLS_INC_WT_Monitoring.watchingWT( 'create_Damaged_PIR', 'Damaged'); 
	                //abreNewRegistro(newId);
	                //ajax_generaRespuesta();
	            }else{
	                //informar de errors
	                System.debug('ERRORES:'+resultado.errors);
                    CLS_INC_WT_Monitoring.watchingWT( 'create_Damaged_PIR_WTreturnsErrors', 'Damaged'); 
	            }
	            ajaxGeneraRespuesta();
            }else{
            	informeCrear = 'Error en la llamada a WorldTracer, consulte con el Administrador.';
                CLS_INC_WT_Monitoring.watchingWT( 'create_Damaged_PIR_WTreturnsErrors', 'Damaged'); 
            }

        }catch(Exception exc){
            System.debug('Error createPIR: '+exc.getMessage());
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Create_Damaged.createPIR()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }

    }
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
            informeCrear += '</br><label class="apartadoModal">Registro correctamente creado en WorldTracer ('+ resultado.record.recordReference.stationCode+resultado.record.recordReference.airlinecode+resultado.record.recordReference.referenceNumber +')</label></br>';
            informeCrear += 'Estación: '+ resultado.record.recordReference.stationCode +'</br>';
            informeCrear += 'Aerolínea: '+ resultado.record.recordReference.airlinecode +'</br>';
            informeCrear += 'Número de referencia: '+ resultado.record.recordReference.referenceNumber +'</br>';
            //if(!resultado.warnings.isEmpty()){  ///Descomentar cuando arreglen los warnings
            //    for(Integer i=0; i<resultado.warnings.size(); i++){
            //        System.debug('Pintando warnings');
            //        informeCrear += '</br><label class="apartadoModal">Advertencias:</label></br>';
            //        informeCrear += resultado.warnings[i].warningCode + ' - ' + resultado.warnings[i].warningDescription + '\\n';
            //    }
            //}
            if (resultado.warnings != null) {   ///Borrar cuando arreglen los warnings
	            if(!resultado.warnings.warning.isEmpty()){
	                for(Integer i=0; i<resultado.warnings.warning.size(); i++){
	                    System.debug('Pintando warnings');
	                    informeCrear += '</br><label class="apartadoModal">Advertencias:</label></br>';
	                    informeCrear += resultado.warnings.warning[i].warningCode + ' - ' + resultado.warnings.warning[i].warningDescription + '\\n';
	                }
	            }   
	        }    
        }else{
            System.debug('Pintando errores');
            informeCrear += '</br><label class="apartadoModal">Error en los datos, por favor revíselos</label>';
            for(Integer i=0; i<resultado.errors.size(); i++){
                System.debug('Pintando errores en bucle');
                //informeCrear += '</br>'+ resultado.errors[i].code + ' - ' + resultado.errors[i].reason + '\\n';
                informeCrear += '</br>';
                String codigo = resultado.errors[i].code;
                codigo = codigo.toUpperCase();
                if(!codigo.contains('UNKNOWN')){
                    informeCrear += resultado.errors[i].code + ' - ';
                }
                informeCrear += resultado.errors[i].reason + '\\n';
            }
        }
        
    }
    private PageReference abreNewRegistro(Id idNew){
        return new PageReference('/'+idNew);
    }

	private Date parseDate(String fieldDate) {
		String[] dateItem = fieldDate.split('-');
		return Date.newinstance(Integer.valueOf(dateItem[2]), Integer.valueOf(dateItem[0]), Integer.valueOf(dateItem[1]));
	}

	private void parseSection1(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field : incidentInformationSection1) {
			if (field.value == '' || field.value == null) {	continue; }

			else if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				//if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_CLS_WT_Wrappers_Create_Damaged.ClaimData(); }
				//requestWR.claim.claimData.faultStationCode = field.value;
				requestWR.claim.faultStationCode = field.value;
			}
            else if (field.name == 'R2_INC_TXT_PIR_Stop_and_Operator_MS__c') {
				if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_CLS_WT_Wrappers_Create_Damaged.RefStationAirline(); }  
                requestWR.refStationAirline.stationCode = field.value.subString(0,3);
                requestWR.refStationAirline.airlineCode = field.value.subString(3,5);
			//}--------------------------------------------- o todo junto o por separado abajo --------------------
			//else if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_CLS_WT_Wrappers_Create_Damaged.RefStationAirline(); }  
   //             requestWR.refStationAirline.stationCode = field.value;
			//}
			//else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_CLS_WT_Wrappers_Create_Damaged.RefStationAirline(); }  
   //             requestWR.refStationAirline.stationAirline = field.value;
			}
			else if (field.name == 'R2_INC_DAT_PIR_Claims_Created_Date__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				//if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_CLS_WT_Wrappers_Create_Damaged.ClaimData(); }
				//requestWR.claim.claimData.claimDate = parseDate(field.value);
                requestWR.claim.claimDate = String.valueOf(field.value);//parse
			}
			else if (field.name == 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c') {
                for (String record : field.value.split('/')) {
                    record = record.trim();
                    List<String> xr = record.split(' ');
                    if (xr.size() == 2) {
                        R2_CLS_WT_Wrappers_Create_Damaged.CrossReferenceRecord associted = new R2_CLS_WT_Wrappers_Create_Damaged.CrossReferenceRecord();
                        R2_CLS_WT_Wrappers_Create_Damaged.RecordReference reference = new R2_CLS_WT_Wrappers_Create_Damaged.RecordReference();
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
                        if (requestWR.crossReferenceRecords == null) { requestWR.crossReferenceRecords = new R2_CLS_WT_Wrappers_Create_Damaged.CrossReferenceRecords(); }
                        if (requestWR.crossReferenceRecords.crossReferenceRecord == null) { requestWR.crossReferenceRecords.crossReferenceRecord = new List<R2_CLS_WT_Wrappers_Create_Damaged.CrossReferenceRecord>(); }
                        requestWR.crossReferenceRecords.crossReferenceRecord.add(associted);
                    }
                }
            }
			// else if (field.name == 'R2_INC_FOR_PIR_AR__c') {
			// 	// TODO WIP
			// } NOT NECESSARY
			//else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
			//	if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
			//	//if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_CLS_WT_Wrappers_Create_Damaged.ClaimData(); }
			//	//requestWR.claim.claimData.claimDate = parseDate(field.value);
   //            // requestWR.claim.claimData.claimDate = field.value;
   //             requestWR.claim.claimDate = field.value;
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
			
			//else if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_CLS_WT_Wrappers_Create_Damaged.RefStationAirline(); }  
   //             requestWR.refStationAirline.stationCode = field.value;
			//}
			//else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
			//	// TODO WIP
   //             if (requestWR.refStationAirline == null) { requestWR.refStationAirline = new R2_CLS_WT_Wrappers_Create_Damaged.RefStationAirline(); }  
   //             requestWR.refStationAirline.airlineCode = field.value;
			//}
		}
	}

	private void parseSection2(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field :incidentInformationSection2) {
			if (field.value == '' || field.value == null) {	continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Name__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Names primerNombre = new R2_CLS_WT_Wrappers_Create_Damaged.Names();
				primerNombre.name = field.value;
				primerNombre.seq = '1';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Create_Damaged.Names>(); }
				//requestWR.passenger.names.add(primerNombre);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.names[0] != null) { requestWR.passenger.names[0] = primerNombre; }
				//else {
					requestWR.passenger.names.add(primerNombre);// }
				//System.debug('requestWR.passenger.names: ' + requestWR.passenger.names);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Names primerApellido = new R2_CLS_WT_Wrappers_Create_Damaged.Names();
				primerApellido.name = field.value;
				primerApellido.seq = '2';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Create_Damaged.Names>(); }
				//requestWR.passenger.names.add(primerApellido);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.names.size() >= 2 && requestWR.passenger.names[1] != null) { requestWR.passenger.names[1] = primerApellido; }
				//else {
					requestWR.passenger.names.add(primerApellido);// }
				//System.debug('requestWR.passenger.names: ' + requestWR.passenger.names);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name2__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Names segundoApellido = new R2_CLS_WT_Wrappers_Create_Damaged.Names();
				segundoApellido.name = field.value;
				segundoApellido.seq = '3';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Create_Damaged.Names>(); }
				//requestWR.passenger.names.add(segundoApellido);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.names.size() == 3 && requestWR.passenger.names[2] != null) { requestWR.passenger.names[2] = segundoApellido; }
				//else {
					requestWR.passenger.names.add(segundoApellido);// }
				//System.debug('requestWR.passenger.names: ' + requestWR.passenger.names);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Treatment__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				requestWR.passenger.title = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Initials inicial1 = new R2_CLS_WT_Wrappers_Create_Damaged.Initials();
				inicial1.initial = field.value;
				inicial1.seq = '1';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Create_Damaged.Initials>(); }
				//requestWR.passenger.initials.add(inicial1);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.initials[0] != null) { requestWR.passenger.initials[0] = inicial1; }
				//else {
					requestWR.passenger.initials.add(inicial1);// }
				//System.debug('requestWR.passenger.initials: ' + requestWR.passenger.initials);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial2__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Initials inicial2 = new R2_CLS_WT_Wrappers_Create_Damaged.Initials();
				inicial2.initial = field.value;
				inicial2.seq = '2';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Create_Damaged.Initials>(); }
				//requestWR.passenger.initials.add(inicial2);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.initials.size() >= 2 && requestWR.passenger.initials[1] != null) { requestWR.passenger.initials[1] = inicial2; }
				//else {
					requestWR.passenger.initials.add(inicial2); //}
				//System.debug('requestWR.passenger.initials: ' + requestWR.passenger.initials);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Initial3__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.Initials inicial3 = new R2_CLS_WT_Wrappers_Create_Damaged.Initials();
				inicial3.initial = field.value;
				inicial3.seq = '3';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Create_Damaged.Initials>(); }
				//requestWR.passenger.initials.add(inicial3);  //descomentar cuando no haya goodJson
				//if (requestWR.passenger.initials.size() == 3 && requestWR.passenger.initials[2] != null) { requestWR.passenger.initials[2] = inicial3; }
				//else {
				requestWR.passenger.initials.add(inicial3);// }
				//System.debug('requestWR.passenger.initials: ' + requestWR.passenger.initials);
			}
			else if (field.name == 'R2_INC_EMA_PIR_Email1__c') { //revisar emails cuando el json este mejor porque vaya tela.. 
				//R2_CLS_WT_Wrappers_Create_Damaged.Emails emailDireccion1 = new R2_CLS_WT_Wrappers_Create_Damaged.Emails();
				//emailDireccion1.email = field.value;
				//emailDireccion1.seq = ''+1;
				//if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				//if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.contactInfo(); }
				//if (requestWR.passenger.contactInfo.emails == null ) { requestWR.passenger.contactInfo.emails = new List<R2_CLS_WT_Wrappers_Create_Damaged.Emails>(); }
				//requestWR.passenger.contactInfo.emails.add(emailDireccion1);
				//String emailDireccion1 = new new R2_CLS_WT_Wrappers_Create_Damaged.Emails();
				String emailDireccion1 = field.value;
				//emailDireccion1.seq = ''+2;
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.contactInfo(); }
				if (requestWR.passenger.contactInfo.emails == null ) { requestWR.passenger.contactInfo.emails = new R2_CLS_WT_Wrappers_Create_Damaged.Emails(); }
				if (requestWR.passenger.contactInfo.emails.email == null ) { requestWR.passenger.contactInfo.emails.email  = new List<String>(); }
				
				requestWR.passenger.contactInfo.emails.email.add(emailDireccion1);
			}
			else if (field.name == 'R2_INC_EMA_PIR_Email2__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.Emails emailDireccion2 = new R2_CLS_WT_Wrappers_Create_Damaged.Emails();
				//emailDireccion2.email = field.value;
				//String emailDireccion2 = new new R2_CLS_WT_Wrappers_Create_Damaged.Emails();
				String emailDireccion2 = field.value;
				//emailDireccion2.seq = ''+2;
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.contactInfo(); }
				if (requestWR.passenger.contactInfo.emails == null ) { requestWR.passenger.contactInfo.emails = new R2_CLS_WT_Wrappers_Create_Damaged.Emails(); }
				if (requestWR.passenger.contactInfo.emails.email == null ) { requestWR.passenger.contactInfo.emails.email  = new List<String>(); }
				
				requestWR.passenger.contactInfo.emails.email.add(emailDireccion2);
			}
			else if (field.name == 'R2_INC_TXT_PIR_FF_Identificator__c') {
				String valorFF = field.value;
                valorFF = valorFF.trim();
                valorFF = valorFF.replaceAll('_', ' ');
                valorFF = valorFF.replaceAll('[\\s]?', ' ');
                valorFF = valorFF.toUpperCase();
                if(valorFF != R2_CLS_WT_Bags_Management.NO_IBERIA_PLUS){
                    if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
                    requestWR.passenger.frequentFlyerId = field.value;
                }
			}
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_language__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				requestWR.passenger.language = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Ticket_number__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				requestWR.passenger.ticketNumber = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_PNR_locator__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				requestWR.passenger.pnr = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_category__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				requestWR.passenger.status = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_address1__c') {
				// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
				// addressLine.addressLineDesc = field.value;
				// addressLine.seq = ''+1;
				//if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.damagedBagGroup(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress == null) { requestWR.damagedBagGroup.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.DeliveryAddress(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				//requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				//if (requestWR.damagedBagGroup.delivery.bagDeliveryAddress == null) { requestWR.damagedBagGroup.delivery.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				if (requestWR.damagedBagGroup.delivery.deliveryAddress == null) { requestWR.damagedBagGroup.delivery.deliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagAddress(); }
				if (requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine == null) { requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
				/* con un campo se rellena todo esto: 
					public class DeliveryAddress {
					public AddressLine_Z addressLine {get;set;} 
					public State state {get;set;} 
					public String postalCode {get;set;} 
					public Country country {get;set;}
	}*/
			}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_address2__c') { //solo 1 address!! <- se borrará este si se confirma
				// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
				// addressLine.addressLineDesc = field.value;
				// addressLine.seq = ''+2;
				//if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.damagedBagGroup(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress == null) { requestWR.damagedBagGroup.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.DeliveryAddress(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				//requestWR.damagedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				//if (requestWR.damagedBagGroup.delivery.bagDeliveryAddress == null) { requestWR.damagedBagGroup.delivery.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				if (requestWR.damagedBagGroup.delivery.deliveryAddress == null) { requestWR.damagedBagGroup.delivery.deliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagAddress(); }
				if (requestWR.damagedBagGroup.delivery.deliveryAddress == null) { requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
				//requestWR.damagedBagGroup.delivery.deliveryAddress.add(addressLine);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_local_informatio__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo localDeliveryInfo = new R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo();
				localDeliveryInfo.dlvInfo = field.value;
				localDeliveryInfo.seq = '1';
				//if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress == null) { requestWR.damagedBagGroup.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				//if (requestWR.damagedBagGroup.bagDeliveryAddress.localDlvInfo == null) { requestWR.damagedBagGroup.bagDeliveryAddress.localDlvInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo>(); }
				//requestWR.damagedBagGroup.bagDeliveryAddress.localDlvInfo.add(localDeliveryInfo);
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				//if (requestWR.damagedBagGroup.delivery.bagDeliveryAddress == null) { requestWR.damagedBagGroup.delivery.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				if (requestWR.damagedBagGroup.delivery.localDlvInfo == null) { requestWR.damagedBagGroup.delivery.localDlvInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo>(); }
				requestWR.damagedBagGroup.delivery.localDlvInfo.add(localDeliveryInfo);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Deliver_local_informatio2__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo localDeliveryInfo = new R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo();
				localDeliveryInfo.dlvInfo = field.value;
				localDeliveryInfo.seq = '2';
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				//if (requestWR.damagedBagGroup.delivery.bagDeliveryAddress == null) { requestWR.damagedBagGroup.delivery.bagDeliveryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagDeliveryAddress(); }
				if (requestWR.damagedBagGroup.delivery.localDlvInfo == null) { requestWR.damagedBagGroup.delivery.localDlvInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.LocalDlvInfo>(); }
				requestWR.damagedBagGroup.delivery.localDlvInfo.add(localDeliveryInfo);
			}
			else if (field.name == 'R2_INC_PKL_PIR_Send_SMS_email__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				requestWR.passenger.autoMessageOption = field.value;
			}
		}
	}

	private void parseSection3(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field :incidentInformationSection3) {
			if (field.value == '' || field.value == null) {	continue; }
			if (field.name == 'R2_INC_TXT_PIR_Permanent_address1__c') {
				// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine direccionLinea1 = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
				// direccionLinea1.addressLineDesc = field.value;
				// direccionLinea1.seq = ''+1;
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagAddress(); }
				if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				requestWR.passenger.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
			}
			else if (field.name == 'R2_INC_TLF_Landline1__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telefonoFijo1 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telefonoFijo1.phone = field.value;
				//telefonoFijo1.seq = '1';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.permanentPhones == null) { requestWR.passenger.contactInfo.permanentPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.passenger.contactInfo.permanentPhones.phone == null) { requestWR.passenger.contactInfo.permanentPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.permanentPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_address1__c') {
				// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine direccionLinea = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
				// direccionLinea.addressLineDesc = field.value;
				// direccionLinea.seq = ''+1;
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.TemporaryAddress(); }
				if (requestWR.passenger.contactInfo.temporaryAddress.addressLine == null) { requestWR.passenger.contactInfo.temporaryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				requestWR.passenger.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;

			}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telefonoTemporal1 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telefonoTemporal1.phone = field.value;
				//telefonoTemporal1.seq = '1';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.temporaryPhones == null) { requestWR.passenger.contactInfo.temporaryPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.passenger.contactInfo.temporaryPhones.phone == null) { requestWR.passenger.contactInfo.temporaryPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.temporaryPhones.phone.add(field.value);
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Permanent_address2__c') {
			//	// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine direccionLinea2 = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
			//	// direccionLinea2.addressLineDesc = field.value;
			//	// direccionLinea2.seq = ''+2;
			//	if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
			//	if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
			//	if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagAddress(); }
			//	if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
			//	requestWR.passenger.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TLF_Landline2__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telefonoFijo2 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telefonoFijo2.phone = field.value;
				//telefonoFijo2.seq = '2';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.permanentPhones == null) { requestWR.passenger.contactInfo.permanentPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.passenger.contactInfo.permanentPhones.phone == null) { requestWR.passenger.contactInfo.permanentPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.permanentPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_address2__c') {
				// R2_CLS_WT_Wrappers_Create_Damaged.AddressLine direccionLinea = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine();
				// direccionLinea.addressLineDesc = field.value;
				// direccionLinea.seq = ''+2;
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.temporaryAddress(); }
				if (requestWR.passenger.contactInfo.temporaryAddress.addressLine == null) { requestWR.passenger.contactInfo.temporaryAddress.addressLine = new R2_CLS_WT_Wrappers_Create_Damaged.AddressLine(); }
				requestWR.passenger.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;
			}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone2__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telefonoTemporal2 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telefonoTemporal2.phone = field.value;
				//telefonoTemporal2.seq = '2';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.temporaryPhones == null) { requestWR.passenger.contactInfo.temporaryPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();	}
				if (requestWR.passenger.contactInfo.temporaryPhones.phone == null) { requestWR.passenger.contactInfo.temporaryPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.temporaryPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Zip_code__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Create_Damaged.BagAddress(); }
				requestWR.passenger.contactInfo.permanentAddress.postalCode = field.value;
			}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number1__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones mobile1 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//mobile1.phone = field.value;
				//mobile1.seq = '1';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.cellPhones == null) { requestWR.passenger.contactInfo.cellPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.passenger.contactInfo.cellPhones.phone == null) { requestWR.passenger.contactInfo.cellPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.cellPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_Zip_Code__c') {
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.TemporaryAddress(); }
				requestWR.passenger.contactInfo.temporaryAddress.postalCode = field.value;
			}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number2__c') { //ojo a los phones, diferencias con delayed
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones mobile2 = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//mobile2.phone = field.value;
				//mobile2.seq = '2';
				if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
				if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.ContactInfo(); }
				if (requestWR.passenger.contactInfo.cellPhones == null) { requestWR.passenger.contactInfo.cellPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.passenger.contactInfo.cellPhones.phone == null) { requestWR.passenger.contactInfo.cellPhones.phone = new List<String>(); }
				requestWR.passenger.contactInfo.cellPhones.phone.add(field.value);
			}
			// else if (field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c') {
				//List<String> auxLst = field.value.split('/');
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
			// 	if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
			// 	if (requestWR.passenger.contactInfo == null) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Create_Damaged.contactInfo(); }
			// 	if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Create_Damaged.DeliveryAddress(); }
			// 	requestWR.passenger.contactInfo.temporaryAddress.validityDate = dateStr;
			// } FIXME echarle un ojo
		}
	}

	private void parseSection4(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field : incidentInformationSection4) {
			if (field.value == '' || field.value == null) {	continue; }
			if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
				if(field.value != null && field.value != '') {
					Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
					Integer i = 0;
					System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
					for (String key : dateFlightsMap.keySet()) {
						for (String vuelo : dateFlightsMap.get(key)) {
							if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
                            if (requestWR.damagedBagGroup.baggageItinerary == null) { requestWR.damagedBagGroup.baggageItinerary = new R2_CLS_WT_Wrappers_Create_Damaged.BaggageItinerary(); }
                            if (requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK == null) { requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK = new List<R2_CLS_WT_Wrappers_Create_Damaged.FlightDateOrARNK>(); }
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK.add(new R2_CLS_WT_Wrappers_Create_Damaged.FlightDateOrARNK());
                            if (requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate == null) { requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate = new R2_CLS_WT_Wrappers_Create_Damaged.FlightDate(); }
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.airlineCode = vuelo.substring(0,2);
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.flightNumber = vuelo.substring(2);
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.rDate = key;
                            i++;
						}
					}
                }
				// R2_CLS_WT_Wrappers_Create_Damaged.Route route = new R2_CLS_WT_Wrappers_Create_Damaged.Route();
				// route.route = field.value;
				// R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK fSegmentOARNK = new R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK();
				// fSegmentOARNK.additionalRoutes.add(route);
				// if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.passenger(); }
				// if (requestWR.damagedBagGroup.bagItinerary == null) { requestWR.damagedBagGroup.bagItinerary = new List<R2_CLS_WT_Wrappers_Create_Damaged.FlightDateOrARNK>(); }
				// if (requestWR.damagedBagGroup.bagItinerary.flightDate == null) { requestWR.damagedBagGroup.bagItinerary.flightDate = new R2_CLS_WT_Wrappers_Create_Damaged.FlightDate(); }
				// requestWR.damagedBagGroup.bagItinerary.flightSegmentsOrARNK.add(route);
				// FIXME Campo no encontrado BagTagDestinations?????? Itinerario no lleva ruta :S
			} else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
				if(field.value != null && field.value != '') {
					Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
					Integer i = 0;
					for (String key : dateFlightsMap.keySet()) {
						for (String vuelo : dateFlightsMap.get(key)) {
							if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Create_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK = new List<R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK>(); }
                            requestWR.passenger.itinerary.flightSegmentsOrARNK.add(new R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK());
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight = new R2_CLS_WT_Wrappers_Create_Damaged.Flight(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate = new R2_CLS_WT_Wrappers_Create_Damaged.FlightDate(); }
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.airlineCode = vuelo.substring(0,2);
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.flightNumber = vuelo.substring(2);
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.rDate = key;
                            i++;
						}
					}
                }
			} else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
				if(field.value != null && field.value != '') {
                    List<String> rutaLst = field.value.split('/');
                    System.debug('rutaLst: ' + rutaLst);
                    //Integer i = 1;
                    for (Integer i = 1; i < rutaLst.size(); i++) {
                        System.debug('rutaLst[' + i + ']: '+ rutaLst[i]);
                        if (i < 6) {
                            if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Create_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK = new List<R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK>(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK.size() < i) { requestWR.passenger.itinerary.flightSegmentsOrARNK.add(new R2_CLS_WT_Wrappers_Create_Damaged.FlightSegmentsOrARNK()); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].flight == null) {
                                if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk = new R2_CLS_WT_Wrappers_Create_Damaged.Arnk(); }
                                if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination = new R2_CLS_WT_Wrappers_Create_Damaged.OriginDestination(); }
                                requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination.origin = rutaLst[i-1];
                                requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].arnk.originDestination.destination = rutaLst[i];
                            }
                            else {
                                if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination = new R2_CLS_WT_Wrappers_Create_Damaged.OriginDestination(); }
                                requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                                requestWR.passenger.itinerary.flightSegmentsOrARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            }
                        }
                        else {
                            if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Create_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Create_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.additionalRoutes == null) { requestWR.passenger.itinerary.additionalRoutes = new List<String>(); }
                            requestWR.passenger.itinerary.additionalRoutes.add(rutaLst[i]);
                        }
                    }
                }
			}
		}
	}

	private void parseSection5(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field :incidentInformationSection5) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Send_direction_FI__c') {
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
				requestWR.additionalInfo.furtherInfo = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information1__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo supplementInfo = new R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo();
				supplementInfo.supplimentInfoText = field.value;
				supplementInfo.seq = '1';
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
				if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo>(); }
				requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information2__c') {
				R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo supplementInfo = new R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo();
				supplementInfo.supplimentInfoText = field.value;
				supplementInfo.seq = '2';
				if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
				if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.SupplementaryInfo>(); }
				requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
			}
			else if (field.name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c') {
				requestWR.handledAirlineCopyIndicator = field.value;
			}
			//else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
			//	if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
			//	if (requestWR.additionalInfo.miscellaneousInfo == null) { requestWR.additionalInfo.miscellaneousInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.MiscellaneousInfo>(); }
			//	if (requestWR.additionalInfo.miscellaneousInfo.isEmpty()) { requestWR.additionalInfo.miscellaneousInfo.add(new R2_CLS_WT_Wrappers_Create_Damaged.MiscellaneousInfo()); }
			//	requestWR.additionalInfo.miscellaneousInfo[0].miscInfoText = field.value;
			//	requestWR.additionalInfo.miscellaneousInfo[0].seq = '1';
			//}
			//else if (field.name == 'R2_ADI_TXT_UC_User_Comment__c') {
			//	if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
			//	if (requestWR.additionalInfo.userComments == null) { requestWR.additionalInfo.userComments = new List<R2_CLS_WT_Wrappers_Create_Damaged.UserComments>(); }
			//	if (requestWR.additionalInfo.userComments.isEmpty()) { requestWR.additionalInfo.userComments.add(new R2_CLS_WT_Wrappers_Create_Damaged.UserComments()); }
			//	requestWR.additionalInfo.userComments[0].commentsText = field.value;
			//	requestWR.additionalInfo.userComments[0].seq = '1';
			//}
		}
	}

	private void parseSection6(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		//for (Field field : incidentInformationSection6) {
		//	if (field.value == '' || field.value == null) { continue; }
		//}
	}

	private void parseSection7(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field : incidentInformationSection7) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_piece__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				requestWR.damagedBagGroup.baggageWeight = field.value;
			}
			else if (field.name == 'R2_INC_TXT_Last_Seen__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				requestWR.damagedBagGroup.bagLastseen = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Weight_lost_parts__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				requestWR.damagedBagGroup.missingWeight = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_content1__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.lostContents == null) { requestWR.damagedBagGroup.lostContents = new List<String>(); }
				requestWR.damagedBagGroup.lostContents.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_content2__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.lostContents == null) { requestWR.damagedBagGroup.lostContents = new List<String>(); }
				requestWR.damagedBagGroup.lostContents.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				requestWR.damagedBagGroup.delivery.deliveryWeight = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase1__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Create_Damaged.Delivery(); }
				requestWR.damagedBagGroup.delivery.deliveryWeight = field.value;
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
			//	// Solo deja rellenar una direccion de maleta
			//}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase1__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telef = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telef.phone = field.value;
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.bagPhones == null) { requestWR.damagedBagGroup.bagPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.damagedBagGroup.bagPhones.phone == null) { requestWR.damagedBagGroup.bagPhones.phone = new List<String>(); }
				requestWR.damagedBagGroup.bagPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase2__c') {
				//R2_CLS_WT_Wrappers_Create_Damaged.BagPhones telef = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones();
				//telef.phone = field.value;
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				if (requestWR.damagedBagGroup.bagPhones == null) { requestWR.damagedBagGroup.bagPhones = new R2_CLS_WT_Wrappers_Create_Damaged.BagPhones(); }
				if (requestWR.damagedBagGroup.bagPhones.phone == null) { requestWR.damagedBagGroup.bagPhones.phone = new List<String>(); }
				requestWR.damagedBagGroup.bagPhones.phone.add(field.value);
			}
			else if (field.name == 'R2_INC_TXT_Excess_Baggage__c') {
				if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup(); }
				requestWR.damagedBagGroup.excessBaggage = field.value;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Limited_approval_label__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.liabilityTag = field.value;
			}
		}
	}

	private void parseSection8(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		for (Field field : incidentInformationSection8) {
			if (field.value == '' || field.value == null) { continue; }
			else if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				if (requestWR.claim.partnerCode == null) { requestWR.claim.partnerCode = new R2_CLS_WT_Wrappers_Create_Damaged.PartnerCode(); }
				requestWR.claim.partnerCode.carrierCode = field.value;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.insurance = Boolean.valueof(field.value);
			}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.lossReasonCode = field.value;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Repair_suitcase__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.repairBag = field.value;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
				// if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				// requestWR.claim. = field.value ;
			}
			else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.replacementBag = field.value ;
			}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_reason_causes__c') {
				if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				requestWR.claim.lossComments = field.value ;
			}
			else if (field.name == 'R2_INC_TXT_PIR_DO_Flight__c') { // resp.claim.
				// if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				// requestWR.claim. = field.value ;
				// FIXME no encontrado
			}
			else if (field.name == 'R2_ADI_TXT_CR_Remarks_Cost__c') { // resp.claim.
				// if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				// if (requestWR.claim.costRemarks == null) { requestWR.claim.costRemarks = new List<R2_CLS_WT_Wrappers_Create_Damaged.R2_ADI_TXT_CR_Remarks_Cost__c>(); }
				// R2_CLS_WT_Wrappers_Create_Damaged.CostRemark costRemark = new R2_CLS_WT_Wrappers_Create_Damaged.CostRemark();
				// costRemark.CostRemarksText = field.value;
				// costRemark.seq = String.valueof(requestWR.claim.costRemarks.length + 1);
				// requestWR.claim.costRemarks.add(costRemark); // FIXME desccomentar cuando se implemente el wrapper
				// START FIXME eliminar cuando se implemente lo de arriba

				//if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
				//if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged(); }
				//if (requestWR.claim.costRemarks == null) { requestWR.claim.costRemarks = new List<String>(); }
				//requestWR.claim.costRemarks.add(field.value);

				// END FIXME eliminar cuando se implemente lo de arriba
			}
		}
	}

	private void parseSection9(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		//for (Field field : incidentInformationSection9) {
		//	if (field.value == '' || field.value == null) { continue; }
		//	if (field.name == 'R2_ADI_ATXTL_MR_Match__c') {
		//		//R2_CLS_WT_Wrappers_Create_Damaged.MatchInfoType matchInfo1 = new R2_CLS_WT_Wrappers_Create_Damaged.MatchInfoType();
		//		//matchInfo1.matchInfoText = field.value;
		//		//matchInfo1.seq = ''+1;
		//		//if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
		//		//if (requestWR.additionalInfo.matchInfo == null) { requestWR.additionalInfo.matchInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.MatchInfoType>(); }
		//		//requestWR.additionalInfo.matchInfo.add(matchInfo1);
		//	}
		//}
	}

	private void parseSection10(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
		//for (Field field : incidentInformationSection10) {
		//	System.debug(field.value);
		//	if (field.value == '' || field.value == null) { continue; }
		//	if (field.name == 'R2_ADI_ATXTL_MG_Message__c') {
		//		//R2_CLS_WT_Wrappers_Create_Damaged.MessageInfoType messageInfo1 = new R2_CLS_WT_Wrappers_Create_Damaged.MessageInfoType();
		//		//messageInfo1.messageInfoText = field.value;
		//		//messageInfo1.seq = ''+1;
		//		//if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Create_Damaged.AdditionalInfo(); }
		//		//if (requestWR.additionalInfo.messageInfo == null) { requestWR.additionalInfo.messageInfo = new List<R2_CLS_WT_Wrappers_Create_Damaged.MessageInfoType>(); }
		//		//requestWR.additionalInfo.messageInfo.add(messageInfo1);
		//	}
		//}
	}
    
    private void parseBagDamagedInfo(R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR) {
        R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup damageBagGroup = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBagGroup();
        R2_CLS_WT_Wrappers_Create_Damaged.DamagedBags damageBags = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBags();
        List<R2_CLS_WT_Wrappers_Create_Damaged.DamagedBag> lstDamageBags = new List<R2_CLS_WT_Wrappers_Create_Damaged.DamagedBag>();
        System.debug('!!!bagLst: ' + bagLst);
        //requestWR.delayedBagGroup.delayedBags
        // for para rellenar los campos de maleta
        if(!bagLst.isEmpty()){
            String rc = '';
            for(Integer i = 0;i<bagLst.size();i++){
                R2_CLS_WT_Wrappers_Create_Damaged.DamagedTypes lstDamagedTypes = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedTypes();
                List<R2_CLS_WT_Wrappers_Create_Damaged.DamagedType> lstDamageType = new List<R2_CLS_WT_Wrappers_Create_Damaged.DamagedType>();
                R2_CLS_WT_Wrappers_Create_Damaged.DamagedType damageType = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedType();
                R2_CLS_WT_Wrappers_Create_Damaged.DamagedType damageType2 = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedType();   
                R2_CLS_WT_Wrappers_Create_Damaged.DamagedBag damageBag = new R2_CLS_WT_Wrappers_Create_Damaged.DamagedBag();
                R2_CLS_WT_Wrappers_Create_Damaged.BagSentToCustoms sentCustoms = new R2_CLS_WT_Wrappers_Create_Damaged.BagSentToCustoms();
                R2_CLS_WT_Wrappers_Create_Damaged.BagSentToCustoms receiveCustoms = new R2_CLS_WT_Wrappers_Create_Damaged.BagSentToCustoms();
                //R2_CLS_WT_Wrappers_Create_Damaged.BagContents bagCont = new R2_CLS_WT_Wrappers_Create_Damaged.BagContents();
                R2_CLS_WT_Wrappers_Create_Damaged.ColorTypeDesc colorType = new R2_CLS_WT_Wrappers_Create_Damaged.ColorTypeDesc();
                R2_CLS_WT_Wrappers_Create_Damaged.Descriptor descrip = new R2_CLS_WT_Wrappers_Create_Damaged.Descriptor();
                R2_CLS_WT_Wrappers_Create_Damaged.BrandInfo brandInf = new R2_CLS_WT_Wrappers_Create_Damaged.BrandInfo();
                R2_CLS_WT_Wrappers_Create_Damaged.BagTag bagtag = new  R2_CLS_WT_Wrappers_Create_Damaged.BagTag();        
                R2_CLS_WT_Wrappers_Create_Damaged.LicenseNumber licens = new R2_CLS_WT_Wrappers_Create_Damaged.LicenseNumber();
                R2_CLS_WT_Wrappers_Create_Damaged.BagDelivery bagDeliv = new R2_CLS_WT_Wrappers_Create_Damaged.BagDelivery();
                R2_CLS_WT_Wrappers_Create_Damaged.Status delivStatus = new R2_CLS_WT_Wrappers_Create_Damaged.Status();
                //R2_CLS_WT_Wrappers_Create_Damaged.BagReceived bagReceiv = new R2_CLS_WT_Wrappers_Create_Damaged.BagReceived();
                R2_CLS_WT_Wrappers_Create_Damaged.UniqueID uniq = new R2_CLS_WT_Wrappers_Create_Damaged.UniqueID();
                
                rc += bagLst[i].R2_BAG_NUM_Age__c + 'YEAR-' + bagLst[i].R2_BAG_TXT_Value_and_coin__c + '/';

                List<String> otrosElem = new List<String>();
                
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
                    damageBag.colorTypeDesc = colorType;
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
                    damageBag.BagTag = bagtag;
                } 
                
                if(bagLst[i].R2_BAG_TXT_Brand_Info__c!=null && bagLst[i].R2_BAG_TXT_Brand_Info__c!=''){
                    brandInf.brandInfo = bagLst[i].R2_BAG_TXT_Brand_Info__c;
                    //brandInf.suspended = bagLst[i].R2_BAG_TXT_Brand_Info_Suspended__c;
                    damageBag.BrandInfo = brandInf;
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
                    /*if(bagLst[i].R2_BAG_DAT_DateBagReceived__c !=null){
                        bagReceiv.bagReceivedDate = String.valueOf(bagLst[i].R2_BAG_DAT_DateBagReceived__c);
                        bagReceiv.station = bagLst[i].R2_BAG_TXT_StationBagReceived__c != null ? bagLst[i].R2_BAG_TXT_StationBagReceived__c : null;
                        bagDeliv.bagReceived = bagReceiv;
                    }*/
                    
                    bagDeliv.status = delivStatus; 
               		damageBag.BagDelivery = bagDeliv;
                }
                
                if(bagLst[i].R2_BAG_TXT_Lock_Code__c!=null && bagLst[i].R2_BAG_TXT_Lock_Code__c!=''){
                    damageBag.lockCode = bagLst[i].R2_BAG_TXT_Lock_Code__c;
                }
                
                if(bagLst[i].R2_BAG_TXT_UniqueID__c!=null && bagLst[i].R2_BAG_TXT_UniqueID__c!=''){
                    uniq.uniqueIDType = bagLst[i].R2_BAG_TXT_UniqueID__c;
                    //uniq.suspended = bagLst[i].R2_BAG_CHK_UniqueID_Suspended__c;
                    damageBag.UniqueID = uniq;
                }
                
                if(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c!=null){
                    sentCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=''){
                        sentCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c;
                    }
                    damageBag.bagSentToCustoms = sentCustoms;
                }
                
                
                if(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c!=null){
                    receiveCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=''){
                        receiveCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c;
                    }
                    damageBag.bagReceivedFromCustoms = receiveCustoms;
                }
                
                
                if(bagLst[i].R2_BAG_TXT_Storage_Location__c!=null && bagLst[i].R2_BAG_TXT_Storage_Location__c!=''){
                    damageBag.storageLocation = bagLst[i].R2_BAG_TXT_Storage_Location__c;
                }
                /*
                List<R2_CLS_WT_Wrappers_Create_Damaged.Content> lstCont = new List<R2_CLS_WT_Wrappers_Create_Damaged.Content>();
                
                // for para rellenar los campos de contenidos
                if(!mapCont.get(i).isEmpty()){
                    for(Integer z = 0;z < mapCont.get(i).size();z++){
                        R2_CLS_WT_Wrappers_Create_Damaged.Content cont = new R2_CLS_WT_Wrappers_Create_Damaged.Content();
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
                    damageBag.bagContents = bagCont;
                }
				*/                
                
                if(bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=null && bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=''){
                    damageBag.bagDetails = bagLst[i].R2_BAG_TXT_Aditional_damage_information__c;
                }
                
                if(bagLst[i].R2_BAG_TXT_Damage1_coding__c!=null && bagLst[i].R2_BAG_TXT_Damage1_coding__c!='' && bagLst[i].R2_BAG_PKL_Damage_1_Location__c!=null && bagLst[i].R2_BAG_PKL_Damage_1_Location__c!='' && bagLst[i].R2_BAG_PKL_Damage1_scale__c!=null && bagLst[i].R2_BAG_PKL_Damage1_scale__c!=''){
                    damageType.location = bagLst[i].R2_BAG_PKL_Damage_1_Location__c;
                    damageType.type_Z = bagLst[i].R2_BAG_TXT_Damage1_coding__c;
                    damageType.amount = bagLst[i].R2_BAG_PKL_Damage1_scale__c;
                    lstDamageType.add(damageType);
                }
                
                if(bagLst[i].R2_BAG_TXT_Damage2_coding__c!=null && bagLst[i].R2_BAG_TXT_Damage2_coding__c!='' && bagLst[i].R2_BAG_PKL_Damage_2_Location__c!=null && bagLst[i].R2_BAG_PKL_Damage_2_Location__c!='' && bagLst[i].R2_BAG_PKL_Damage2_scale__c!=null && bagLst[i].R2_BAG_PKL_Damage2_scale__c!=''){
                    damageType2.location = bagLst[i].R2_BAG_PKL_Damage_2_Location__c;
                    damageType2.type_Z = bagLst[i].R2_BAG_TXT_Damage2_coding__c;
                    damageType2.amount = bagLst[i].R2_BAG_PKL_Damage2_scale__c;
                    lstDamageType.add(damageType2);
                }
                //13/04/18 Alberto.Puerto -> TD in visual now is disabled, codificación/localización/magnitud daño 1 are three fields Required
                //                        -> Fulfilling in visual TD field:
                if(!lstDamageType.isEmpty()){
                    bagLst[i].R2_BAG_TXT_Damage_detail__c = lstDamageType[0].location + '/' + lstDamageType[0].type_Z + lstDamageType[0].amount;
                    if(lstDamageType.size() > 1){
                        bagLst[i].R2_BAG_TXT_Damage_detail__c += '/' + lstDamageType[1].location + '/' + lstDamageType[1].type_Z + lstDamageType[1].amount;
                    }
                }
                //System.debug(':::bagLst[i].R2_BAG_TXT_Damage_detail__c - ' + bagLst[i].R2_BAG_TXT_Damage_detail__c);

                
                if(!lstDamageType.isEmpty()){
                    lstDamagedTypes.damagedType = lstDamageType;
                    damageBag.damagedTypes = lstDamagedTypes;
                }
                
                /*if(bagLst[i].R2_CB_TXT_Contents_Desc__c!=null && bagLst[i].R2_CB_TXT_Contents_Desc__c!=''){
                    damageBag.contentDescription = bagLst[i].R2_CB_TXT_Contents_Desc__c;
                }
				*/
				/*List<String> lstRemarks = new List<String>();                
                if(bagLst[i].R2_BAG_TXT_Comments__c!=null && bagLst[i].R2_BAG_TXT_Comments__c!=''){
                    lstRemarks.add(bagLst[i].R2_BAG_TXT_Comments__c);
                    damageBag.remarks = lstRemarks;
                }
                */
                
               	
                
                lstDamageBags.add(damageBag); 
            }
            damageBags.damagedBag = lstDamageBags;
            damageBagGroup.damagedBags = damageBags;
            if(rc != null && rc != ''){
            	rc = rc.removeEnd('/');
	            if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Create_Damaged.Claim(); }
	            requestWR.claim.lossComments = rc;
            }   
        }
        requestWR.damagedBagGroup = damageBagGroup;
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
	// 	 /*---------------------------------------------------------------------------------------------------------------------
	 /*---------------------------------------------------------------------------------------------------------------------

	 /*---------------------------------------------------------------------------------------------------------------------

	 /*---------------------------------------------------------------------------------------------------------------------
Author:         Rubén Pingarrón Jerez
Company:        Accenture
Description:    
IN:             
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
13/04/2018                  Alberto Puerto Collado                  Added refresh of parseBagDamagedInfo in order to display readOnly field "TD" after save bag
----------------------------------------------------------------------------------------------------------------------*/
    public void cargarVisual(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
            //incidencia = [SELECT ID, Name FROM R1_Incident__c WHERE ID = :incidenciaID LIMIT 1];

            //13/04/18 added Alberto.Puerto
            R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest requestWR = new R2_CLS_WT_Wrappers_Create_Damaged.WpCreateDamagedRequest();
            parseBagDamagedInfo(requestWR);

            
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
14/09/2017                  Rubén Pingarrón Jerez                    Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
    public void newBag(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            

            System.debug('LaBagNueva:' + bag);
            informeCrear = '';
            if(actionBag == 'save'){
                bagLst.add(bag);
                maletaSelect = totalMaletas;   
				verSaveUpdate = true;     
                getBagImageTipo();
                getBagImageColor();
            }else if(actionBag == 'update'){
                bagLst.add(maletaSelect + 1, bag);
                bagLst.remove(maletaSelect);
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
}