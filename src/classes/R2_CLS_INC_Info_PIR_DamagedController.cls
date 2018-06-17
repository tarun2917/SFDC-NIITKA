/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Incident Information PIR controller
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    14/11/2017
    16/02/2018             Alvaro Garcia Tapia                     Added change to Prorrateos functionality (posibility of change flight and route)
 ----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_INC_Info_PIR_DamagedController {
    
    public Integer maletaSelect = 0;
    private Integer totalMaletas;
    //private Map<String, String> mapType;
    
    public Map<R2_Content_Baggage__c, Integer> mapPoscCont; 
    public Map<Integer, List<R2_Content_Baggage__c>> mapCont;
    public List<R2_Baggage__c> lstBagsInicial;
    public R2_Content_Baggage__c contUpdate;
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
    public R1_Incident__c incidencia {get;set;}
    
    public Integer numCont {get;set;}
    public String tipoCont {get;set;}
    public String desCont {get;set;}
    public String actionBag {get;set;}
    public Boolean verSaveUpdate {get;set;}
    public String wtContent {get;set;}
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
    
    public String fecha1 {get;set;}
    public String fecha2 {get;set;}
    public String fecha3 {get;set;}
    public String fecha4 {get;set;}
    public String fecha5 {get;set;}
    //---------------------------------------------------------------------------------------------------------------------------------//
    
    public Id incidenciaId{get;set;}
    public R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord registro{get;set;}
    public List<R2_CLS_WT_Wrappers_Modify_Damaged.WarningType> warnings{get;set;}
    public List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType> errors{get;set;}
    public String errorResponse{get;set;} //{errorResponse = '1';}
    public Boolean boolEnabled{get;set;}
    public Boolean boolCambiaEscala{get;set;}
    public Boolean boolReabrir{get;set;}
    public Boolean boolCloseEnabled{get;set;}
    public String newStation{get;set;}
    public String newAirline{get;set;}
    public Boolean boolUseOneBag {get;set;}
    ///////////Prorrateos ////////// 16/02/2018
    public Boolean boolModifyEnabled{get;set;}
    public String newFlight {get;set;}
    public String newRoute {get;set;}
    public String actFlight {get;set;}
    public String actRoute {get;set;}
    //////////////////////////////
    
    //los campos de la lista son los que no van a poder editarse
    private final Set<String> nonUpdateableFields = new Set<String> {'R2_INC_FOR_PIR__c', 'R2_INC_DAT_PIR_Claim_Date__c', 'R2_INC_DAT_PIR_Last_mapping_date__c',
            'R2_INC_DAT_PIR_Search_start_date__c', 'R2_PIR_DAT_PIR_Full_reintegration_date__c', 'R2_INC_TXT_PIR_Control_office__c',
            'R2_INC_NUM_PIR_Associated_Cases__c', 'R2_INC_DAT_PIR_Cancellation_date__c', 'R2_INC_DAT_PIR_Date_back_primary_search__c', 'R2_INC_DAT_PIR_Control_date__c',
            'R2_INC_DAT_PIR_Unsuccessful_search__c', 'R2_INC_DATH_PIR_Incidence_closed_date__c', 'R2_INC_TXT_PIR_Agent__c', 'R2_INC_TXT_PIR_Report_PIR__c',
            'R2_INC_TXT_PIR_VIP_Account__c', 'R2_INC_PKL_PIR_Status_incidence__c', 'R2_INC_DAT_PIR_Claims_Created_Date__c','R2_INC_TXT_PIR_Station_Code__c',
            'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_FOR_PIR_AR__c', 'R2_INC_TXT_PIR_Baggage_destination__c',
            'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c', 'R2_INC_TXT_PIR_Baggage_Weight_piece__c', 'R2_INC_TXT_PIR_Weight_lost_parts__c', 'R2_INC_TXT_PIR_flight_Number__c',
            'R2_INC_TXT_PIR_Route__c', 'R2_INC_TXT_PIR_Baggage_route__c'};
//R2_INC_TXT_PIR_Responsible_Scale__c, R2_INC_TXT_PIR_Stop_and_Operator_MS__c -> sí updateables de section 1

    private final Set<String> nonUpdateFieldsClosePIR = nonUpdateableFields.clone();
    {nonUpdateFieldsClosePIR.remove('R2_INC_TXT_PIR_Responsible_Scale__c');}
    {nonUpdateFieldsClosePIR.remove('R2_INC_TXT_PIR_Lost_reason__c');}//R2_INC_TXT_PIR_Lost_reason_causes__c

    private final Set<String> mandatoryFields = new Set<String> {'R2_INC_TXT_PIR_Stop_and_Operator_MS__c',
                                                                'R2_INC_TXT_PIR_Name__c' , 'R2_INC_TXT_PIR_Initial__c', 'R2_INC_TXT_PIR_Passenger_language__c',
                                                                'R2_INC_TXT_PIR_Ticket_number__c', 'R2_INC_TLF_Landline1__c',// 'R2_INC_TLF_PIR_Mobile_phone_number1__c',
                                                                 'R2_INC_EMA_PIR_Email1__c',  //'R2_INC_TLF_PIR_Temporal_phone__c',
                                                                 'R2_INC_TXT_PIR_Permanent_address1__c'
                                                                };
    private final Set<String> mandatoryFieldsClosePIR = mandatoryFields.clone();
    {mandatoryFieldsClosePIR.add('R2_INC_TXT_PIR_Responsible_Scale__c');}
    {mandatoryFieldsClosePIR.add('R2_INC_TXT_PIR_Lost_reason__c');}//R2_INC_TXT_PIR_Lost_reason_causes__c');}


    public class Field{
        public String label {get;set;}
        public String value {get;set;}
        public String oldValue {get;set;}
        public String name {get;set;}
        //public String isEnabled {get;set;} Hay que borrarlo
        public String type {get; set;}
        public Boolean disabled {get; set;}
        public Boolean required {get; set;}
        //public Boolean classRequired {get; set;}
        public String method {get;set;}
        public List<SelectOption> items {get;set;}
        public R1_Incident__c incident{get;set;}
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

    //popups added
    public List<R2_Auxiliar_Data_Incident__c> lstMG {get;set;}
    public List<R2_MG_Message__c> lstMG2 {get;set;}
    public List<R2_Auxiliar_Data_Incident__c> lstMR {get;set;}
    public List<R2_Auxiliar_Data_Incident__c> lstCR {get;set;}
    public List<R2_Auxiliar_Data_Incident__c> lstDY {get;set;}
    public List<R2_Auxiliar_Data_Incident__c> lstUC {get;set;}
    public List<R2_Auxiliar_Data_Incident__c> lstFF {get;set;}
    public String auxiliar{get;set;} 
    
    {incidenciaId = Apexpages.currentPage().getParameters().get('id');
    errorResponse = 'error interno';
    boolEnabled = false; boolCambiaEscala = false; boolReabrir = false; boolCloseEnabled = false; boolUseOneBag = false; newAirline = ''; newStation = ''; 
    boolModifyEnabled = false; newFlight = ''; newRoute = ''; actFlight = ''; actRoute = ''; ///Prorrateos 16/02/2018
    lstMG = new List<R2_Auxiliar_Data_Incident__c>(); lstMR =  new List<R2_Auxiliar_Data_Incident__c>(); lstCR =  new List<R2_Auxiliar_Data_Incident__c>(); lstDY =  new List<R2_Auxiliar_Data_Incident__c>();
    lstUC =  new List<R2_Auxiliar_Data_Incident__c>(); lstFF =  new List<R2_Auxiliar_Data_Incident__c>(); lstMG2 = new List<R2_MG_Message__c>(); auxiliar = '';
    incidentInformationSection1 = getIncidentInformation('1'); incidentInformationSection2 = getIncidentInformation('2');
    incidentInformationSection3 = getIncidentInformation('3'); incidentInformationSection4 = getIncidentInformation('4'); incidentInformationSection5 = getIncidentInformation('5');
    incidentInformationSection6 = getIncidentInformation('6'); incidentInformationSection7 = getIncidentInformation('7'); incidentInformationSection8 = getIncidentInformation('8');
    incidentInformationSection9 = getIncidentInformation('9'); incidentInformationSection10 = getIncidentInformation('10');}

    /*public void setKeyAux(String keyAux1){
        System.debug('##RP## keyAux: ' + keyAux);
        keyAux = keyAux1;
    }
    public void setValueAux(String valueAux){
        this.valueAux = valueAux;
    }*/


    //private Map<String, String> mapField;
    //public List<Field> incidentInformationSection1;

    public R2_CLS_INC_Info_PIR_DamagedController(ApexPages.StandardController controller){
        //incidenciaId = Apexpages.currentPage().getParameters().get('id');

        Id incID = controller.getId();
        lstBagsInicial =  [SELECT Id, Name, R2_BAG_TXT_Ticket_number__c, R2_BAG_FOR_Colour_Type_Description__c, R2_BAG_PKL_Type__c, R2_BAG_PKL_Colour__c, R2_BAG_ATXTE_Type__c, 
                           R2_BAG_TXT_Brand_Info__c, R2_BAG_CHK_Content_exists__c, R2_BAG_MSDT_Incident__c, R2_BAG_TXT_Damage_detail__c, R2_BAG_TXT_Aditional_damage_information__c, 
                           R2_BAG_NUM_Age__c, R2_BAG_DAT_Suitcase_delivery_date__c, R2_BAG_TXT_Value_and_coin__c, R2_BAG_DAT_Suitcase_receive_date__c, 
                           R2_BAG_TXT_bagNewRoute__c, R2_BAG_TXT_bagRoute__c, R2_BAG_TXT_BagFlight__c, R2_BAG_TXT_BagNewFlight__c, R2_BAG_DAT_Distribution_conf_date__c,
                           R2_BAG_DAT_Scheduled_delivery_date__c, R2_BAG_DAT_Distribution_date__c, R2_BAG_TXT_Comments__c, R2_BAG_TXT_RUSH_label__c, R2_BAG_CHK_Mixed__c, 
                           R2_BAG_CHK_Leather__c, R2_BAG_CHK_Metal__c, R2_BAG_CHK_Rigid__c, R2_BAG_CHK_Printed_fabric__c, R2_BAG_CHK_Single_object_in_box__c, R2_BAG_TXT_PIR_AR__c,
                           R2_BAG_CHK_Suitcase_allowed_cabin__c, R2_BAG_CHK_Combination_lock__c, R2_BAG_CHK_Retractable_handle__c, R2_BAG_CHK_External_pockets__c, R2_BAG_TXT_RecordType_PIR_AR__c,
                           R2_BAG_CHK_Wheels_or_bearing__c, R2_BAG_CHK_Safety_belt__c, R2_BAG_CHK_BagTag_Suspended__c, R2_BAG_PKL_Damage2_scale__c, R2_BAG_TXT_ROH_result__c,
                           R2_BAG_TXT_Damage1_coding__c, R2_BAG_PKL_Damage_1_Location__c, R2_BAG_PKL_Damage1_scale__c, R2_BAG_TXT_Damage2_coding__c, R2_BAG_PKL_Damage_2_Location__c,
                           R2_BAG_CHK_Suspended__c, R2_BAG_TXT_Brand_Info_Suspended__c,R2_BAG_CHK_BagContends_Suspended__c, R2_BAG_DATH_Bag_ReceivedFromCustoms__c,
                           R2_BAG_DATH_Bag_SentToCustoms__c, R2_BAG_TXT_Lock_Code__c, R2_BAG_TXT_ROH_FI__c, R2_BAG_TXT_ROH_SI01__c, R2_BAG_TXT_ROH_SI02__c, R2_BAG_CHK_Colour_Type_suspended__c, 
                           R2_BAG_CHK_UniqueID_Suspended__c, R2_BAG_TXT_UniqueID__c, R2_BAG_TXT_Storage_Location__c, R2_CB_TXT_Contents_Desc__c, R2_BAG_TXT_StationBagReceived__c,
                           R2_BAG_DAT_DateBagReceived__c, R2_BAG_CHK_RushTag_Suspended__c, R2_BAG_TXT_UnableToDeliver__c FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c = :incID ORDER BY CreatedDate ASC LIMIT 10];
        
        bagLst = lstBagsInicial;
        
        mapCont = new Map<Integer, List<R2_Content_Baggage__c>>();
        
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
        wtContent = 'false';
        verSaveUpdate = true;
        cargarVisual();
           //errorResponse = '1'; //si está a 1 no existen warnings y no se muestra
           //incidentInformationSection1 = getIncidentInformation('1');
    }

    //private String fieldsSection1 = 'R2_INC_TXT_PIR_Agent__c, R2_INC_DAT_PIR_Claim_Date__c, '+
    //  //  'R2_INC_DAT_PIR_Cancellation_date__c, R2_INC_DAT_PIR_Search_start_date__c, ' +
    //    //'R2_INC_DATH_PIR_Incidence_closed_date__c, R2_PIR_DAT_PIR_Full_reintegration_date__c, '+
    //    'R2_INC_DAT_PIR_Last_mapping_date__c, R2_INC_DAT_PIR_Control_date__c, R2_INC_DAT_PIR_Date_back_primary_search__c, '+
    //    'R2_INC_FOR_PIR_AR__c, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c, '+
    //    'R2_INC_TXT_PIR_AR_Reference_Number__c, R2_INC_DAT_PIR_Unsuccessful_search__c, R2_INC_TXT_PIR_Control_office__c, '+
    //    'R2_INC_TXT_PIR_Address_in_suitcase1__c, R2_INC_TXT_PIR_Address_in_suitcase2__c, R2_INC_TXT_PIR_Baggage_Weight_piece__c, '+
    //    'R2_INC_TXT_PIR_Delivery_address1__c, R2_INC_TXT_PIR_Delivery_address2__c, R2_INC_TXT_PIR_Baggage_Weight_delivered__c, '+
    //    'R2_INC_TXT_PIR_Delivery_local_informatio__c, R2_INC_TXT_PIR_Deliver_local_informatio2__c, R2_INC_ATXTL_PIR_Delivery_service__c, '+
    //    'R2_INC_TLF_PIR_Phone_number_suitcase1__c, R2_INC_TLF_PIR_Phone_number_suitcase2__c';

    //private String fieldsSection2 = 'R2_INC_TXT_PIR_Agent__c, R2_INC_DAT_PIR_Claim_Date__c, '+
    //    'R2_INC_DAT_PIR_Cancellation_date__c, R2_INC_DAT_PIR_Search_start_date__c, ' +
    //    'R2_INC_DATH_PIR_Incidence_closed_date__c, R2_PIR_DAT_PIR_Full_reintegration_date__c';

    //private String fieldsSection3 = 'R2_INC_TXT_PIR_Delivery_address1__c, R2_INC_TXT_PIR_Delivery_address2__c, R2_INC_TXT_PIR_Baggage_Weight_delivered__c, '+
    //    'R2_INC_TXT_PIR_Delivery_local_informatio__c, R2_INC_TXT_PIR_Deliver_local_informatio2__c, R2_INC_ATXTL_PIR_Delivery_service__c, '+
    //    'R2_INC_TLF_PIR_Phone_number_suitcase1__c, R2_INC_TLF_PIR_Phone_number_suitcase2__c';

    //public List<Field> getIncidentInformationSection1(){
    //    return getIncidentInformation('1');
    //}
    //public void setIncidentInformationSection1(List<Field> incidentInformationSection1){
    //    this.incidentInformationSection1 = incidentInformationSection1;
    //}
    //public List<Field> getIncidentInformationSection2(){
    //    return getIncidentInformation('2');
    //}
    //public List<Field> getIncidentInformationSection3(){
    //    return getIncidentInformation('3');
    //}
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getMG(){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug(':::getMG');
            //R2_ADI_ATXTL_MG_Message__c
            //List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_ATXTL_MG_Message__c, R2_ADI_PKL_Type__c
            //                                                    //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
            //                                                    //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
            //                                                    FROM R2_Auxiliar_Data_Incident__c
            //                                                    WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
            //                                                    AND R2_ADI_PKL_Type__c = 'MR'];
            List<R2_MG_Message__c> lstMensajes = [Select id, name, R2_MG_ATXT_Message__c, R2_MG_PKL_Type__c,  R2_MG_TXT_TX__c, R2_MG_TXT_XF__c, R2_MG_LOO_Incident__c, R2_MG_TXT_Copy_1__c,
                                         R2_MG_TXT_Copy_2__c,  R2_MG_TXT_Copy_3__c,  R2_MG_TXT_Copy_4__c, R2_MG_DAT_Reception_Date__c, R2_MG_TXT_Sequence_number__c, RecordType.DeveloperName, CreatedDate
                                    FROM R2_MG_Message__c
                                    WHERE R2_MG_LOO_Incident__c=:incidenciaId];

            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstMensajes ' + lstMensajes);
            //System.debug(':::resultado lstMensajes size ' + lstMensajes.size());
            //if(!lstRefreshADI.isEmpty()){
            //    for(Integer i = 0; i < lstRefreshADI.size(); i++){
            //        if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'MR'){
            //            lstMG.add(lstRefreshADI[i]);
            //        }
            //    }
            //}
            if(!lstMensajes.isEmpty()){
                lstMG2 = new List<R2_MG_Message__c>();
                for(Integer i = 0; i < lstMensajes.size(); i++){
                    lstMG2.add(lstMensajes[i]);
                }
            }
            //System.debug(':::getMG - lista - ' + lstRefreshADI);
            System.debug(':::getMG - lista - ' + lstMG2);
            auxiliar = JSON.serialize(lstMG2);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getMG', 'error en getMG', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getMR(){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug(':::getMR ');
            //R2_ADI_ATXTL_MR_Match__c
            List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_ATXTL_MR_Match__c, R2_ADI_PKL_Type__c, CreatedDate
                                                                //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
                                                                //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                                FROM R2_Auxiliar_Data_Incident__c
                                                                WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
                                                                AND R2_ADI_PKL_Type__c = 'MR'];
            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstRefreshADI size ' + lstRefreshADI.size());
            if(!lstRefreshADI.isEmpty()){
                lstMR = new List<R2_Auxiliar_Data_Incident__c>();
                for(Integer i = 0; i < lstRefreshADI.size(); i++){
                    if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'MR'){
                        lstMR.add(lstRefreshADI[i]);
                    }
                }
            }
            System.debug(':::getMG - lista - ' + lstRefreshADI);
            auxiliar = JSON.serialize(lstRefreshADI);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getMR', 'error en getMR', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getCR(){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            auxiliar = '';
            //System.debug(':::getCR ');
            //R2_ADI_TXT_CR_Remarks_Cost__c
            List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_PKL_Type__c, CreatedDate
                                                                //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
                                                                //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                                FROM R2_Auxiliar_Data_Incident__c
                                                                WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
                                                                AND R2_ADI_PKL_Type__c = 'CR'];
            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstRefreshADI size ' + lstRefreshADI.size());
            if(!lstRefreshADI.isEmpty()){
                lstCR = new List<R2_Auxiliar_Data_Incident__c>();
                for(Integer i = 0; i < lstRefreshADI.size(); i++){
                    if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'CR'){
                        lstCR.add(lstRefreshADI[i]);
                    }
                }
            }
            System.debug(':::getCR - lista - ' + lstRefreshADI);
            auxiliar = JSON.serialize(lstRefreshADI);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getCR', 'error en getCR', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getDY(){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            auxiliar = '';
            //System.debug(':::getDY ');
            //R2_ADI_ATXTL_DS_Delivery_service__c
            //R2_ADI_ATXTL_DY_Delivery_Info__c  -> ojoooo cual? -> este en principio
            List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_ATXTL_DY_Delivery_Info__c, R2_ADI_PKL_Type__c, CreatedDate
                                                                //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
                                                                //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                                FROM R2_Auxiliar_Data_Incident__c
                                                                WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
                                                                AND R2_ADI_PKL_Type__c = 'DY'];
            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstRefreshADI size ' + lstRefreshADI.size());
            if(!lstRefreshADI.isEmpty()){
                lstDY = new List<R2_Auxiliar_Data_Incident__c>();
                for(Integer i = 0; i < lstRefreshADI.size(); i++){
                    if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'DY'){
                        lstDY.add(lstRefreshADI[i]);
                    }
                }
            }
            System.debug(':::getDY - lista - ' + lstRefreshADI);
            auxiliar = JSON.serialize(lstRefreshADI);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getDY', 'error en getDY', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getUC(){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            auxiliar = '';
            //R2_ADI_TXT_UC_User_Comment__c
            List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_TXT_UC_User_Comment__c, R2_ADI_PKL_Type__c, CreatedDate
                                                                //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
                                                                //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                                FROM R2_Auxiliar_Data_Incident__c
                                                                WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
                                                                AND R2_ADI_PKL_Type__c = 'UC'];
            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstRefreshADI size ' + lstRefreshADI.size());
            if(!lstRefreshADI.isEmpty()){
                lstUC = new List<R2_Auxiliar_Data_Incident__c>();
                for(Integer i = 0; i < lstRefreshADI.size(); i++){
                    if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'UC'){
                        lstUC.add(lstRefreshADI[i]);
                    }
                }
            }
            System.debug(':::getUC - lista - ' + lstRefreshADI);
            auxiliar = JSON.serialize(lstRefreshADI);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getUC', 'error en getUC', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    22/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void getFF(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            auxiliar = '';
            //R2_ADI_TXT_FF_Observation__c
            List<R2_Auxiliar_Data_Incident__c> lstRefreshADI = [SELECT Id, R2_ADI_TXT_FF_Observation__c, R2_ADI_PKL_Type__c, CreatedDate
                                                                //, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c,
                                                                //R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                                FROM R2_Auxiliar_Data_Incident__c
                                                                WHERE R2_ADI_MSDT_Incident__c =:incidenciaId
                                                                AND R2_ADI_PKL_Type__c = 'FF'];
            //System.debug(':::resultado lista refresh adi ' + lstRefreshADI);
            //System.debug(':::resultado lstRefreshADI size ' + lstRefreshADI.size());
            if(!lstRefreshADI.isEmpty()){
                lstFF = new List<R2_Auxiliar_Data_Incident__c>();
                for(Integer i = 0; i < lstRefreshADI.size(); i++){
                    if(lstRefreshADI[i].R2_ADI_PKL_Type__c == 'FF'){
                        lstFF.add(lstRefreshADI[i]);
                    }
                }
            }
            System.debug(':::getFF - lista - ' + lstRefreshADI);
            auxiliar = JSON.serialize(lstRefreshADI);
            System.debug(':::auxiliar - ' + auxiliar);
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.getFF', 'error en getFF', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    public List<Field> getIncidentInformation(String section){
        
        R1_Incident__c result = new R1_Incident__c();
        R2_Auxiliar_Data_Incident__c result2 = new R2_Auxiliar_Data_Incident__c();
        String fields = '';
        String fields2 = '';
        String query = '';
        String query2 = '';
        if(section.equals('1')){
            fields = 'R2_INC_FOR_PIR__c, R2_INC_DAT_PIR_Claim_Date__c, R2_INC_DAT_PIR_Last_mapping_date__c, ' + //R2_ADI_FOR_XR_Record_Reference__c, ' +
            'R2_INC_LOO_Case__c, R2_INC_DAT_PIR_Search_start_date__c, R2_PIR_DAT_PIR_Full_reintegration_date__c, R2_INC_TXT_PIR_Control_office__c, ' + 
            'R2_INC_NUM_PIR_Associated_Cases__c, R2_INC_DAT_PIR_Cancellation_date__c, R2_INC_DAT_PIR_Date_back_primary_search__c, R2_INC_DAT_PIR_Control_date__c, '+
            //'RecordTypeId, 
            'R2_INC_DAT_PIR_Unsuccessful_search__c, R2_INC_TXT_PIR_Responsible_Scale__c, '+
            'R2_INC_DATH_PIR_Incidence_closed_date__c, R2_INC_TXT_PIR_Agent__c, R2_INC_TXT_PIR_Report_PIR__c, '+
            'R2_INC_TXT_PIR_VIP_Account__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_DAT_PIR_Claims_Created_Date__c, ' + 
            /*'R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, */'R2_INC_FOR_PIR_AR__c, R2_INC_TXT_PIR_Others_PIR_Associated_XR__c';//, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c';
            //fields2 = ;

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            //query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('2')){
            fields = 'R2_INC_TXT_PIR_Treatment__c, R2_INC_TXT_PIR_Name__c, R2_INC_TXT_PIR_Last_name__c, R2_INC_TXT_PIR_Last_name2__c, ' +
            'R2_INC_TXT_PIR_FF_Identificator__c, R2_INC_TXT_PIR_Initial__c, R2_INC_TXT_PIR_Initial2__c, R2_INC_TXT_PIR_Initial3__c, ' +
            'R2_INC_TXT_PIR_Passenger_language__c, R2_INC_TXT_PIR_Passenger_category__c, R2_INC_EMA_PIR_Email1__c, R2_INC_EMA_PIR_Email2__c, ' +
            'R2_INC_TXT_PIR_Delivery_address1__c, R2_INC_TXT_PIR_Delivery_address2__c, R2_INC_TXT_PIR_Delivery_local_informatio__c, R2_INC_TXT_PIR_Deliver_local_informatio2__c, ' +
            'R2_INC_TXT_PIR_PNR_locator__c, R2_INC_TXT_PIR_Ticket_number__c, R2_INC_PKL_PIR_Send_SMS_email__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
        }
        else if(section.equals('3')){
            //fields = fieldsSection3;
            fields = 'R2_INC_TXT_PIR_Permanent_address1__c, R2_INC_TLF_Landline1__c, R2_INC_TXT_PIR_Temporal_address1__c, R2_INC_TLF_PIR_Temporal_phone__c, ' +
            'R2_INC_TXT_PIR_Permanent_address2__c, R2_INC_TLF_Landline2__c, R2_INC_TXT_PIR_Temporal_address2__c, R2_INC_TLF_PIR_Temporal_phone2__c, ' +
            'R2_INC_TXT_PIR_Zip_code__c, R2_INC_TLF_PIR_Mobile_phone_number1__c, R2_INC_TXT_PIR_Temporal_Zip_Code__c, ' +
            'R2_INC_TLF_PIR_Mobile_phone_number2__c, R2_INC_DAT_PIR_Validity_temporal_address__c'; 

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
        }
        else if(section.equals('4')){
            //fields = fieldsSection3;
            fields = 'R2_INC_TXT_PIR_flight_Number__c, R2_INC_TXT_PIR_Route__c, R2_INC_TXT_PIR_Baggage_route__c';
            //fields2 = 'R2_INC_TXT_PIR_Route__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            //query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('5')){
            //fields = fieldsSection3;
            fields = 'R2_INC_TXT_PIR_Send_direction_FI__c, ' + /*R2_ADI_TXT_FF_Observation__c,*/ 'R2_INC_TXT_PIR_Control_information2__c, ' +
            'R2_INC_PKL_PIR_Copy_for_the_company_HC__c, '+ /*R2_ADI_TXT_UC_User_Comment__c,*/ 'R2_INC_TXT_PIR_Control_information1__c';
            fields2 = 'R2_ADI_TXT_FF_Observation__c, R2_ADI_TXT_UC_User_Comment__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('6')){
            //fields = fieldsSection3;
            //fields = 'R2_INC_TXT_PIR_Shared_code__c';//= 'R2_ADI_ATXTL_DY_Delivery_Info__c';
            fields2 = 'R2_ADI_ATXTL_DY_Delivery_Info__c';

            //query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('7')){
            //fields = fieldsSection3;
            fields = 'R2_INC_TXT_PIR_Baggage_Weight_piece__c, R2_INC_TXT_Last_Seen__c, R2_INC_TXT_PIR_Weight_lost_parts__c, R2_INC_TXT_PIR_Lost_content1__c, ' +
            'R2_INC_TXT_PIR_Baggage_Weight_delivered__c, R2_INC_TXT_PIR_Lost_content2__c, R2_INC_TXT_PIR_Address_in_suitcase1__c, ' +
            'R2_INC_TXT_PIR_Address_in_suitcase2__c, ' + /*R2_ADI_ATXTL_DS_Delivery_service__c,*/ 'R2_INC_TLF_PIR_Phone_number_suitcase1__c, R2_INC_TXT_Excess_Baggage__c, ' +
            'R2_INC_TLF_PIR_Phone_number_suitcase2__c, R2_INC_CHK_PIR_Limited_approval_label__c';//, R2_INC_TXT_PIR_Baggage_destination__c';
            fields2 = 'R2_ADI_ATXTL_DS_Delivery_service__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('8')){
            //fields = fieldsSection3;
            fields = /*R2_INC_TXT_PIR_Shared_code__c, */'R2_INC_CHK_PIR_Baggage_insurance__c, R2_INC_TXT_PIR_Lost_reason__c, R2_INC_CHK_PIR_Repair_suitcase__c, '+
            'R2_INC_TXT_PIR_Special_lost_reason__c, R2_INC_CHK_PIR_Replace_suitcase__c, R2_INC_TXT_PIR_Lost_reason_causes__c, '+
            /*'R2_ADI_TXT_CR_Remarks_Cost__c,*/ 'R2_INC_TXT_PIR_DO_Flight__c';
            fields2 = 'R2_ADI_TXT_CR_Remarks_Cost__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('9')){
            //fields = fieldsSection3;
            //fields = 'R2_INC_TXT_PIR_Shared_code__c';//'R2_ADI_ATXTL_MR_Match__c';
            fields2 = 'R2_ADI_ATXTL_MR_Match__c';

            //query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('10')){
            //fields = fieldsSection3;
            //fields = 'R2_INC_TXT_PIR_Shared_code__c';//'R2_ADI_ATXTL_MG_Message__c';
            fields2 = 'R2_ADI_ATXTL_MG_Message__c';

            //query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            if (fields != '') {
                System.debug('section:' + section + ' ,query: '+ query);
                result = Database.query(query);
            }
            if(fields2 != '') {
                System.debug('section :' + section + 'query: '+ query2);
                result2 = Database.query(query2);
            }
            
        }catch(Exception e){
            System.debug('No existe en la bbdd');
            System.debug(e);
        }
        return getIncidentFields(result, fields, result2, fields2);
    }

    public List<Field> getIncidentFields(R1_Incident__c pir, String fields, R2_Auxiliar_Data_Incident__c adi, String fields2){
        try{    
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get('R1_Incident__c');
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();

            List<Field> incidencias = new List<Field>();
            List<String> listFields = fields.split(', ');
            //for(String field : listFields){
            //    System.debug('!!!fieldTrim' + field);
            //    field = field.trim();
            //}
            System.debug(listFields);
            System.debug(pir);
            Field fieldObject;
            //mapField = new Map<String, String>();
            for(String field : listFields){
                 //disabled management
                fieldObject = new Field();
                if(boolCloseEnabled){
                    fieldObject.required = mandatoryFieldsClosePIR.contains(field);
                    fieldObject.disabled = nonUpdateFieldsClosePIR.contains(field);
                }
                ///Prorrateos 16/02/2018
                else if(boolModifyEnabled){ 
                    fieldObject.required = false;
                    fieldObject.disabled = true;
                ////////////////////////
                }else if(boolenabled){
                    fieldObject.required = mandatoryFields.contains(field);
                    fieldObject.disabled = nonupdateableFields.contains(field);
                }else{
                    fieldObject.required = false;
                    fieldObject.disabled = true;
                }

                //fulfilling field.attributes
                if (field != '' ) {
                    //fieldObject = new Field();

                    //System.debug('!!!!!field: '+field);

                    //System.debug('!!!!!pir.get(field): '+pir.get(field));
                    //if (pir.get(field) != null) {
                    //if (field.contains('_DATH_')) {   
                    //    fieldObject.value = String.valueOfGmt((Datetime)pir.get(field));      
                    //}
                    //else if (field.contains('_DAT_')) {    
                    //    fieldObject.value = String.valueOf((Date)pir.get(field));      
                    //}
                    //else if (field.contains('_CHK_')) { 
                    //    fieldObject.value = String.valueOf((Boolean)pir.get(field));      
                    //}
                    //else{
                    //    fieldObject.value = (String)pir.get(field);
                    //}       
                    //fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    //fieldObject.name = field;
                    if (field.contains('_DATH_')) {
                        fieldObject.value = String.valueOfGmt((Datetime)pir.get(field));
                        fieldObject.oldValue = String.valueOfGmt((Datetime)pir.get(field));
                        fieldObject.type = 'datetime';
                    }
                    else if (field.contains('_DAT_')) {
                        fieldObject.value = String.valueOf((Date)pir.get(field));
                        fieldObject.oldValue = String.valueOf((Date)pir.get(field));
                        fieldObject.type = 'date';
                    }
                    else if (field.contains('_CHK_')) {
                        fieldObject.value = String.valueOf((Boolean)pir.get(field));
                        fieldObject.oldValue = String.valueOf((Boolean)pir.get(field));
                        fieldObject.type = 'checkbox';
                    }else if (field.contains('_TLF_')) {
                        fieldObject.value = String.valueOf((String)pir.get(field));
                        fieldObject.oldValue = String.valueOf((String)pir.get(field));
                        fieldObject.type = 'tel';
                    }else if (field.contains('_PKL_') && field != 'R2_INC_PKL_PIR_Status_incidence__c') {
                        fieldObject.value = String.valueOf((String)pir.get(field));
                        fieldObject.oldValue = String.valueOf((String)pir.get(field));
                        fieldObject.type = 'picklist';
                    }else if (field.contains('_LOO_')) {
                        fieldObject.incident = pir;
                        fieldObject.type = 'lookup';
                    }else{
                        fieldObject.value = (String)pir.get(field);
                        fieldObject.oldValue = (String)pir.get(field);
                        fieldObject.type = 'text';
                    }
                    fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    fieldObject.name = field;
                    fieldObject.items = getItems(field);
                    if (field == 'R2_INC_DATH_PIR_Incidence_closed_date__c') {
                        fieldObject.incident = pir;
                    }

                    ///Prorrateos 16/02/2018
                    if(field == 'R2_INC_TXT_PIR_flight_Number__c') {
                        actFlight = (String)pir.get(field);
                    }
                    if(field == 'R2_INC_TXT_PIR_Route__c') {
                        actRoute = (String)pir.get(field);
                    }

                    //05/02/2018 - cambios de lógica para damaged, de momento unabled siempre y que modifiquen aparte, la integración va diferente        
                    //if(mandatoryFieldsClosePIR.contains(fieldObject.name)){
                    //    fieldObject.classRequired = true;
                    //}else{
                    //    fieldObject.classRequired = false;
                    //}


                    //if(boolEnabled){
                    //    System.debug('::::pintando boolEnabled');
                        //update enable/disable fields
                        //-> R2_INC_TXT_PIR_Stop_and_Operator_MS__c
                        //R2_INC_DAT_PIR_Claims_Created_Date__c

                        //System.debug('::::nonUpdateableFields.contains(fieldObject.name|||'+nonUpdateableFields.contains(fieldObject.name));
                        //System.debug('::::fieldObject.name'+field);
                        //System.debug('fieldObject.value'+fieldObject.value);
                        //System.debug('::::nonUpdateableFields!!!!'+nonUpdateableFields);
                        //System.debug(':::busca y encuentra arriba, play!'+fieldObject.name);
                    //    if(nonUpdateableFields.contains(fieldObject.name)){
                    //        System.debug('boolenabled = true y SI en nonUpdateableFields .> isEnabled = true');
                    //        fieldObject.isEnabled = 'true';
                    //    }else{
                    //        fieldObject.isEnabled = 'false';
                    //        System.debug('fieldObject = true y NOOOOOOOO nonupdateableFields .> isEnabled = false');
                    //    }
                    //}else if(boolCloseEnabled){
                    //    System.debug('::::pintando boolCloseEnabled');
                        //update enable/disable fields
                        //-> R2_INC_TXT_PIR_Stop_and_Operator_MS__c
                        //R2_INC_DAT_PIR_Claims_Created_Date__c

                        //System.debug('::::nonUpdateFieldsClosePIR.contains(fieldObject.name|||'+nonUpdateFieldsClosePIR.contains(fieldObject.name));
                        //System.debug('::::fieldObject.name'+field);
                        //System.debug('fieldObject.value'+fieldObject.value);
                        //System.debug('::::nonUpdateFieldsClosePIR!!!!'+nonUpdateFieldsClosePIR);
                        //System.debug(':::busca y encuentra arriba, play!'+fieldObject.name);
                        //if(nonUpdateFieldsClosePIR.contains(fieldObject.name)){
                        //    System.debug('boolenabled = true y SI en nonUpdateFieldsClosePIR .> isEnabled = true');
                        //    fieldObject.isEnabled = 'true';
                        //}else{
                        //    fieldObject.isEnabled = 'false';
                        //    System.debug('fieldObject = true y NOOOOOOOO nonUpdateFieldsClosePIR .> isEnabled = false');
                        //}
                        //05/02/2018 - cambios de lógica para damaged, de momento unabled siempre y que modifiquen aparte, la integración va diferente
                    //    fieldObject.isEnabled = 'true';
                    //}else{
                    //    fieldObject.isEnabled = 'true';
                    //    System.debug('fieldObject = false .> isEnabled = true');
                    //}
                    //System.debug(fieldObject);
                    incidencias.add(fieldObject);
                    //mapField.put(fieldObject.name, fieldObject.value);
                }
            }
            ////////////En Objeto ADI:
            Schema.SObjectType leadSchema2 = schemaMap.get('R2_Auxiliar_Data_Incident__c');
            Map<String, Schema.SObjectField> fieldMap2 = leadSchema2.getDescribe().fields.getMap();

            List<String> listFields2 = fields2.split(', ');
            if(!listFields2.isEmpty()){
                //for(String field2 : listFields2){
                //System.debug('!!!fieldTrim' + field2);

                //field2 = field2.trim();
                //}
                System.debug(listFields2);
                System.debug(adi);
                Field fieldObject2;
                //mapField = new Map<String, String>();
                for(String field : listFields2){
                    if (field != '' ) {
                        fieldObject2 = new Field();

                        //System.debug('!!!!!field2: '+field);

                        //System.debug('!!!!!adi.get(field2): '+adi.get(field2));
                        //if (adi.get(field2) != null) {
                        //if (field.contains('_DATH_')) {   
                        //    fieldObject2.value = String.valueOfGmt((Datetime)adi.get(field));      
                        //}
                        //else if (field.contains('_DAT_')) {    
                        //    fieldObject2.value = String.valueOf((Date)adi.get(field));      
                        //}
                        //else if (field.contains('_CHK_')) { 
                        //    fieldObject2.value = String.valueOf((Boolean)adi.get(field));      
                        //}
                        //else{
                        //    fieldObject2.value = (String)adi.get(field);
                        //}       
                        //fieldObject2.label = fieldMap2.get(field).getDescribe().getLabel();
                        //fieldObject2.name = field;

                        //if (field.contains('_DATH_')) {
                        //    fieldObject2.value = String.valueOfGmt((Datetime)adi.get(field));
                        //    fieldObject2.oldValue = String.valueOfGmt((Datetime)adi.get(field));
                        //}
                        //else if (field.contains('_DAT_')) {
                        //    fieldObject2.value = String.valueOf((Date)adi.get(field));
                        //    fieldObject2.oldValue = String.valueOf((Date)adi.get(field));
                        //}
                        //else if (field.contains('_CHK_')) {
                        //    fieldObject2.value = String.valueOf((Boolean)adi.get(field));
                        //    fieldObject2.oldValue = String.valueOf((Boolean)adi.get(field));
                        /*}else*/ if (field.contains('R2_ADI_TXT_CR_Remarks_Cost__c') //|| field.contains('R2_ADI_FOR_XR_Record_Reference__c')
                            || field.contains('R2_ADI_ATXTL_MG_Message__c') || field.contains('R2_ADI_ATXTL_MR_Match__c')
                            || field.contains('R2_ADI_TXT_FF_Observation__c') || field.contains('R2_ADI_TXT_UC_User_Comment__c')
                            || field.contains('R2_ADI_ATXTL_DS_Delivery_service__c') || field.contains('R2_ADI_TXT_DB_baggage_Destination__c')
                            || field.contains('R2_ADI_ATXTL_DY_Delivery_Info__c') ) {
                        fieldObject2.value = String.valueOf((String)adi.get(field));
                        fieldObject2.oldValue = String.valueOf((String)adi.get(field));
                        fieldObject2.type = 'button';

                            if (field.contains('R2_ADI_ATXTL_MG_Message__c')){
                                fieldObject2.method = 'leeMG';
                            }else if (field.contains('R2_ADI_ATXTL_MR_Match__c')){
                                fieldObject2.method = 'leeMR';
                            }else if (field.contains('R2_ADI_TXT_CR_Remarks_Cost__c')){
                                fieldObject2.method = 'leeCR';
                            }else if (field.contains('R2_ADI_TXT_FF_Observation__c')){
                                fieldObject2.method = 'leeFF';
                            }else if (field.contains('R2_ADI_TXT_UC_User_Comment__c')){
                                fieldObject2.method = 'leeUC';
                            }else if (field.contains('R2_ADI_ATXTL_DS_Delivery_service__c')){
                                fieldObject2.method = 'leeDY';
                            }else if (field.contains('R2_ADI_TXT_DB_baggage_Destination__c')){
                                //fieldObject2.method = '';
                            }
                        }
                        //else{
                        //    fieldObject2.value = (String)adi.get(field);
                        //    fieldObject2.oldValue = (String)adi.get(field);
                        //}

                        fieldObject2.label = fieldMap2.get(field).getDescribe().getLabel();
                        fieldObject2.name = field;


                        //if(boolEnabled){
                            //update enable/disable fields
                            //if(nonUpdateableFields.contains(fieldObject2.name)){
                                //fieldObject2.disabled = true;
                            //}else{
                                fieldObject2.disabled = false;
                            //}
                        //}else{
                        //    fieldObject2.disabled = true;
                        //}
                        //System.debug(fieldObject2);
                        incidencias.add(fieldObject2);
                        //mapField.put(fieldObject2.name, fieldObject2.value);
                    }
                    
                }
            }
            
            System.debug(incidencias);
            //System.debug('!!!!mapa fields: ' + mapField);
            return incidencias;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.getIncidentFields', '', ex.getmessage()+', '+ex.getLineNumber(), 'R1_Incident__c');
            return null;
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

    public String getIncidentHeader(){
        R1_Incident__c result = null;
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            String query = 'SELECT Id, Name, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            System.debug(query);
        
            result = Database.query(query);
            return 'PIR: '+result.Name+' : '+result.R2_INC_FOR_PIR__c;
        }catch(Exception e){
            System.debug('No existe en la bbdd, llamar a World Tracer , '+ e.getLineNumber() );
            System.debug(e);
            return 'PIR: ';
        }
        
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Create one dummy payment
    IN:             Id incidentId - Receives Id instead pick this.incidenciaId, in order to flexibility this method called from switchBoolCloseEnabled
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    17/01/2018             Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void insertDummyPayment(Id incidentId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            //Id resId;
            List<R2_Auxiliar_Data_Incident__c> coste = [SELECT Id, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c
                                                FROM R2_Auxiliar_Data_Incident__c
                                                WHERE R2_ADI_PKL_Type__c = 'CS' AND R2_ADI_MSDT_Incident__c = :incidentId LIMIT 1];
            System.debug(':::insertDummyPayment / hay coste?: ' + coste);

            //CREATING ONE DUMMY PAYMENT - 17/01/2018
            if (coste.isEmpty()) {
                System.debug(':::CREATING ONE DUMMY PAYMENT');
                R2_Auxiliar_Data_Incident__c pagoDummy = new R2_Auxiliar_Data_Incident__c();
                    pagoDummy.R2_ADI_NUM_CS_Amount__c = 0;
                    pagoDummy.R2_ADI_TXT_CS_Currency__c = 'EUR';
                    pagoDummy.R2_ADI_NUM_Decimal_Place__c = 1;
                    pagoDummy.R2_ADI_PKL_CS_Cost_Type__c = 'X';
                    pagoDummy.R2_ADI_PKL_Type__c = 'CS';
                    pagoDummy.R2_ADI_MSDT_Incident__c = incidentId; //this.incidenciaId;
                insert pagoDummy;
                System.debug(':::CREATED ONE DUMMY PAYMENT' + pagoDummy);
            }

        }catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.insertDummyPayment()', 'Error al insertar en SF el pago dummy', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.insertDummyPayment', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Crea pago dummy y rellena con dummmy el subwrapper
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    28/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   public void parseCS(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            System.debug(':::inicio de parseCS');
            
            //uno dummy en el wrapper también
            List<R2_Auxiliar_Data_Incident__c> lstCostes = [SELECT Id, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c
                                                FROM R2_Auxiliar_Data_Incident__c 
                                                WHERE R2_ADI_PKL_Type__c = 'CS' 
                                                    AND R2_ADI_MSDT_Incident__c = :incidenciaId 
                                                ];
            System.debug(':::lstCostes , size: ' + lstCostes.size() + ' /// lista: ' + lstCostes);

            //if si tal null modify - claim . passengerpayments . passengerpaymentsvalue - costType y ammount
            if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            if (requestWR.claim.passengerPayments == null) { requestWR.claim.passengerPayments = new R2_CLS_WT_Wrappers_Modify_Damaged.PassengerPayments(); }
            if (requestWR.claim.passengerPayments.passengerPaymentsValue == null){
                if(lstCostes.size() < 1) { 
                    System.debug(':::llamando a insertDummyPayment()');
                    insertDummyPayment(incidenciaId);
                }
                System.debug(':::llenando pago dummy en wrapper');
                requestWR.claim.passengerPayments.passengerPaymentsValue = new List<R2_CLS_WT_Wrappers_Modify_Damaged.PassengerPaymentsValue>(); 
                //requestWR.claim.passengerPayments.passengerPaymentsValue[0].costType = 'string';  
                R2_CLS_WT_Wrappers_Modify_Damaged.PassengerPaymentsValue pagoValue = new R2_CLS_WT_Wrappers_Modify_Damaged.PassengerPaymentsValue();
                    pagoValue.costType = lstCostes[0].R2_ADI_PKL_CS_Cost_Type__c; 
                    R2_CLS_WT_Wrappers_Modify_Damaged.Amount cantidad = new R2_CLS_WT_Wrappers_Modify_Damaged.Amount();
                        cantidad.amount = String.valueOf(lstCostes[0].R2_ADI_NUM_CS_Amount__c); 
                        R2_CLS_WT_Wrappers_Modify_Damaged.CurrencyCode curCode =  new R2_CLS_WT_Wrappers_Modify_Damaged.CurrencyCode();
                            curCode.currencyCodeValue = lstCostes[0].R2_ADI_TXT_CS_Currency__c;
                            curCode.decimalPlace = String.valueOf(lstCostes[0].R2_ADI_NUM_Decimal_Place__c);
                        cantidad.currencyCode = curCode;
                    pagoValue.amount = cantidad;
                requestWR.claim.passengerPayments.passengerPaymentsValue.add(pagoValue);
            }else{
                System.debug(':::ya hay passengerPaymentsValue, no se crea dummy en wrapper');
            }
            System.debug(':::requestWR' + requestWR);
            
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.parseCS', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    close pir damaged
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    31/01/2018             Alberto Puerto Collado                  Create one payment automatically - now managed on switchBoolCloseEnabled
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
    public void closeCAH(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            //Id resId;
            //primero modificamos para rellenar con pago dummy
            //modifyDPRpreClose();
            //modifyDPR();

            System.debug('ANTES DE MAPEO closeCAH');
            

            List<R1_Incident__c> inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c,
                                            R2_INC_TXT_PIR_Shared_code__c, R2_INC_NUM_Toiler_Kit_Female__c, R2_INC_NUM_Toiler_Kit_Male__c, R2_INC_DAT_PIR_Claims_Created_Date__c,
                                            R2_INC_DAT_PIR_Date_Notified__c, R2_INC_DAT_PIR_Questionnaire_Date__c, R2_INC_TXT_PIR_Responsible_Scale__c,R2_INC_TXT_PIR_Responsible_Terminal__c,
                                            R2_INC_CHK_PIR_Baggage_insurance__c, R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_TXT_PIR_Lost_reason_causes__c, R2_INC_TXT_PIR_Lost_reason__c,
                                            R2_INC_DAT_PIR_Unsuccessful_search__c, R2_INC_PKL_PIR_Copy_for_the_company_HC__c, R2_INC_TXT_PIR_Agent__c
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];

            List<R2_Auxiliar_Data_Incident__c> lstADIs = [SELECT Id, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_NUM_Decimal_Place__c, R2_ADI_PKL_CS_Cost_Type__c, 
                                                            R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_TXT_XR_Station_Code__c, R2_ADI_TXT_XR_Reference_Number__c
                                                            FROM R2_Auxiliar_Data_Incident__c 
                                                            WHERE R2_ADI_MSDT_Incident__c =:incidenciaId];// AND R2_ADI_NUM_CS_Amount__c != null ];
            System.debug('PIR::::: '+inci);  
            System.debug('Lista de ADIS del PIR::::: '+lstADIs);                                               
            // AssociatedRecord
            if(!inci.isEmpty()){
                R2_CLS_WT_Bags_Management.WR_CloseDamaged_CFI_Request requestWR = new R2_CLS_WT_Bags_Management.WR_CloseDamaged_CFI_Request();
                R2_CLS_WT_Bags_Management.AssociatedRecord record = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                List<R2_CLS_WT_Bags_Management.AssociatedRecord> lstRecord = new List<R2_CLS_WT_Bags_Management.AssociatedRecord>();
                //R2_CLS_WT_Bags_Management.RecordReference recordReference = new R2_CLS_WT_Bags_Management.RecordReference();
                //R2_CLS_WT_Bags_Management.DeliveryType deliveryInfo = new R2_CLS_WT_Bags_Management.DeliveryType();
                //R2_CLS_WT_Bags_Management.RecordIdentifier associated;
                //List<R2_CLS_WT_Bags_Management.RecordIdentifier> lstAssociated = new List<R2_CLS_WT_Bags_Management.RecordIdentifier>();
                //R2_CLS_WT_Bags_Management.RecordReference crossRecord; 
                //R2_CLS_WT_Bags_Management.NewRecordType recordType = new R2_CLS_WT_Bags_Management.NewRecordType();

                //CLAIMS WRAPPERS INSTANCES
                //R2_CLS_WT_Bags_Management.Amount amount;// = new R2_CLS_WT_Bags_Management.Amount();
                //R2_CLS_WT_Bags_Management.PassengerPayment passengerPayment;// = new R2_CLS_WT_Bags_Management.PassengerPayment();
                //R2_CLS_WT_Bags_Management.ClaimAmount claimAmount = new R2_CLS_WT_Bags_Management.ClaimAmount();
                //R2_CLS_WT_Bags_Management.PassengerPayments passengerPayments = new R2_CLS_WT_Bags_Management.PassengerPayments();
                //R2_CLS_WT_Bags_Management.PartnerCode partnerCode = new  R2_CLS_WT_Bags_Management.PartnerCode();
                //R2_CLS_WT_Bags_Management.ToilerKits toilerKits = new R2_CLS_WT_Bags_Management.ToilerKits();
                //R2_CLS_WT_Bags_Management.ExcessValue excessValue = new R2_CLS_WT_Bags_Management.ExcessValue();
                //R2_CLS_WT_Bags_Management.ClaimData claimData = new R2_CLS_WT_Bags_Management.ClaimData();
                //R2_CLS_WT_Bags_Management.Claim claim = new R2_CLS_WT_Bags_Management.Claim();
                //List<R2_CLS_WT_Bags_Management.PassengerPayment> lstPasgrs = new List<R2_CLS_WT_Bags_Management.PassengerPayment>();
                //List<R2_CLS_WT_Bags_Management.SupplementaryInfoType> lstSupplement = new List<R2_CLS_WT_Bags_Management.SupplementaryInfoType>();
                //Amount
                //for(Integer i = 0; i< lstADIs.size(); i++){
                //    if (lstADIs[i].R2_ADI_NUM_CS_Amount__c != null && lstADIs[i].R2_ADI_NUM_CS_Amount__c >= 0 && lstADIs[i].R2_ADI_TXT_CS_Currency__c != null && lstADIs[i].R2_ADI_PKL_CS_Cost_Type__c != null) {
                //        passengerPayment = new R2_CLS_WT_Bags_Management.PassengerPayment();
                //        amount = new R2_CLS_WT_Bags_Management.Amount();
                //        amount.amountValue = (Integer)lstADIs[i].R2_ADI_NUM_CS_Amount__c;   
                //        amount.currencyCode = lstADIs[i].R2_ADI_TXT_CS_Currency__c;  
                //        amount.decimalPlace = (Integer)lstADIs[i].R2_ADI_NUM_Decimal_Place__c ;
                //        passengerPayment.costType = lstADIs[i].R2_ADI_PKL_CS_Cost_Type__c;
                //        passengerPayment.seq = i + 1; 

                //        passengerPayment.amount = amount;
                //        lstPasgrs.add(passengerPayment);
                //    }
                //    //else if (lstADIs[i].R2_ADI_TXT_XR_Station_Code__c != null && lstADIs[i].R2_ADI_TXT_XR_Station_Code__c != ''){
                //    //    associated = new R2_CLS_WT_Bags_Management.RecordIdentifier();
                //    //    crossRecord = new R2_CLS_WT_Bags_Management.RecordReference();
                //    //    associated.recordType = inci[0].RecordType.DeveloperName;
                //    //    crossRecord.stationCode = lstADIs[i].R2_ADI_TXT_XR_Station_Code__c;
                //    //    crossRecord.airlineCode = lstADIs[i].R2_ADI_TXT_XR_Airline_Code__c;
                //    //    crossRecord.referenceNumber = lstADIs[i].R2_ADI_TXT_XR_Reference_Number__c;
                //    //    associated.recordReference = crossRecord;
                //    //    lstAssociated.add(associated);
                //    //}  
                //}

                //////Rellenar el lstSupplement
                
                //passengerPayments.passengerPayment = lstPasgrs;
                //ClaimAmount
                //claimAmout.amountUnknown = (amount.amount != null && amount.amount >= 0) ? false : true;
                //claimAmount.amount = amount;
                //PartnerCode
                //partnerCode.carrierCode = inci[0].R2_INC_TXT_PIR_Shared_code__c;
                //partnerCode.none = (partnerCode.carrierCode != null && partnerCode.carrierCode != '') ? false : true;
                //ToilerKits
                //toilerKits.male = (Integer)inci[0].R2_INC_NUM_Toiler_Kit_Male__c;
                //toilerKits.female = (Integer)inci[0].R2_INC_NUM_Toiler_Kit_Female__c;
                //ClaimData
                //claimData.claimAmount = claimAmout;
                //claimData.costRemarks = new List<String>();
                //claimData.payments = passengerPayments;
                //claimData.claimDate = inci[0].R2_INC_DAT_PIR_Claims_Created_Date__c;
                //claimData.notifiedDate = inci[0].R2_INC_DAT_PIR_Date_Notified__c;
                //claimData.questionnaireDate = inci[0].R2_INC_DAT_PIR_Questionnaire_Date__c;
                //claimData.faultStation = inci[0].R2_INC_TXT_PIR_Responsible_Scale__c; ///dentro del for 
                //claimData.faultTerminal = inci[0].R2_INC_TXT_PIR_Responsible_Terminal__c; //no puede ser nulo
                //claimData.insurance = inci[0].R2_INC_CHK_PIR_Baggage_insurance__c;
                //claimData.liabilityTagIndicator = inci[0].R2_INC_CHK_PIR_Limited_approval_label__c;
                //claimData.missingBags = '';
                //claimData.partnerCode = partnerCode;
                //Rellenamos los campos con los nuevos valores de station type y airline type
                //for (Field field :IncidentInformationSection1) {
                //    System.debug('field: '+ field);
                //    if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
                //        claimData.faultStation = field.value;
                //    }

                //    if (claimData.faultStation != null && claimData.faultStation != '') {
                //        break;
                //    }
                //}
                //for (Field field :IncidentInformationSection8) {
                //    System.debug('field: '+ field);
                //    if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
                //        claimData.lossReasonCode = field.value;
                //    }

                //    if (claimData.lossReasonCode != null && claimData.lossReasonCode != '') {
                //        break;
                //    }
                //}    
                
                //claimData.lossComments = inci[0].R2_INC_TXT_PIR_Lost_reason_causes__c;
                //claimData.lossReasonCode = inci[0].R2_INC_TXT_PIR_Lost_reason__c; ///dentro del for 
                //claimData.toilerkits = toilerKits;
                //claimData.excessValue = amount;
                //claimData.tracingFinalized = inci[0].R2_INC_DAT_PIR_Unsuccessful_search__c;
                //claimData.replacementBagIndicator = '';
                //claimData.repairBagIndicator = '';
            

            //AssociatedRecord
                record.stationCode = inci[0].R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                record.airlineCode = inci[0].R2_INC_TXT_PIR_Airline_Code__c;//'IB';
                record.referenceNumber = inci[0].R2_INC_TXT_PIR_Reference_Number__c;//'67894';
                lstRecord.add(record);
                //record.recordType = inci[0].RecordType.DeveloperName;
                //associatedRecord.recordType = inci[0].RecordType.DeveloperName;//'DELAYED';
                //associatedRecord.recordReference = '';
            

                //record.recordReference = recordReference;
                //record.recordType = inci[0].RecordType.DeveloperName;
                //NewRecordType
                //recordType.recordType = 'DELAYED';
                //recordType.recordReference = associatedRecord;

                //WR_CloseDelayed_CAH_Request
                requestWR.recordReference = lstRecord;
                //requestWR.claim = claimData;
                requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
                //requestWR.supplementalInfo = lstSupplement;
                //requestWR.crossReferenceRecord = lstAssociated;
                //requestWR.handledAirlineCopy = inci[0].R2_INC_PKL_PIR_Copy_for_the_company_HC__c;

                String jsonData = JSON.serialize(requestWR);

                System.debug('*** jsonData: ' + jsonData);

                jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
                System.debug('*** jsonData: ' + jsonData);
                errorResponse = R2_CLS_WT_Bags_Management.CloseDamaged_CFI(jsonData, 0);
                System.debug('respuesta de errores:::::::::'+errorResponse);
                if(errorResponse == '1'){
                    R1_CLS_Utilities.readRecord_WT(inci[0].RecordType.DeveloperName, inci[0].R2_INC_TXT_PIR_Station_Code__c, inci[0].R2_INC_TXT_PIR_Airline_Code__c, inci[0].R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);
                //    System.debug('cerrado correctamente en WT');
                //    refreshDAH();
                }
                //else{

                //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.closeCAH', '', 'Existen warnings al cerrar el pir delayed en WT', 'R2_Incident__c');
                //}
            }
            CLS_INC_WT_Monitoring.watchingWT( 'closeCAH', 'Damaged');
        }catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.closeCAH()', 'Error al insertar en SF el pago dummy', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.closeCAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    reassign pir damaged
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
    public void reassignRIB(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            //Id resId;
            System.debug('ANTES DE MAPEO reassignRIB'); //arreglar 
            R2_CLS_WT_Bags_Management.WR_ReassignDelayedBagWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_ReassignDelayedBagWebRequest();
            R2_CLS_WT_Bags_Management.AssociatedRecord associatedRecord = new R2_CLS_WT_Bags_Management.AssociatedRecord();
            R2_CLS_WT_Bags_Management.NewStationAirlineType newStationAirlineType = new R2_CLS_WT_Bags_Management.NewStationAirlineType();


            List<R1_Incident__c> inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];

            System.debug(inci);
            // AssociatedRecord
            if(!inci.isEmpty()){
                associatedRecord.stationCode = inci[0].R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                associatedRecord.airlineCode = inci[0].R2_INC_TXT_PIR_Airline_Code__c;//'IB';
                associatedRecord.referenceNumber = inci[0].R2_INC_TXT_PIR_Reference_Number__c;//'68177';
            }
            //associatedRecord.recordType = 'DELAYED';
            //associatedRecord.recordReference = '';
            //Rellenamos los campos con los nuevos valores de station type y airline type
            //for (Field field :IncidentInformationSection1) {
            //    if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
            //        newStationAirlineType.stationCode = field.value;
            //    }
            //    else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
            //        newStationAirlineType.airlineCode = field.value;
            //    }

            //    if ((newStationAirlineType.stationCode != null && newStationAirlineType.stationCode != '') && 
            //        (newStationAirlineType.airlineCode != null && newStationAirlineType.airlineCode != '')) {
            //        break;
            //    }
            //}
            newStationAirlineType.stationCode = newStation;
            newStationAirlineType.airlineCode = newAirline;


            // WR_ReopenDelayedBagWebRequest
            requestWR.recordReference = associatedRecord;
            requestWR.newStationAirline = newStationAirlineType;
            //requestWR.bagElements = bagType;
            String alias = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            requestWR.agentId = alias;

            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            errorResponse = R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse(jsonData, 0);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            //if(errorResponse == '1'){
            //    System.debug('Reasignado correctamente en WT');
            //    refreshDAH();
            //}else{

            //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.reassignRIB', '', 'Existen warnings al reabrir el pir delayed en WT', 'R2_Incident__c');
            //}
            CLS_INC_WT_Monitoring.watchingWT( 'reassignRIB', 'Damaged'); 
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.reassignRIB', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    generate report pir damaged
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    23/11/2017             Alberto Puerto Collado                  Initial Version
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
    public void informePIR(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            

            System.debug('ANTES DE MAPEO informePIR'); 
            R1_Incident__c inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];

            R2_CLS_WT_Bags_Management.WR_GenerateSummaryReport_PIRWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_GenerateSummaryReport_PIRWebRequest();
            requestWR.airlineVendorId = 'IB'; //Can be hard coded as IB for all calls to SITA
            requestWR.recordType = 'DAMAGED'; //Can be hard codes as DAMAGED for all calls to SITA, as this operation is specific for delayed bag files
            R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                ar.stationCode = inci.R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                ar.airlineCode = inci.R2_INC_TXT_PIR_Airline_Code__c;//'IB'; 
                ar.referenceNumber = inci.R2_INC_TXT_PIR_Reference_Number__c;
            requestWR.recordReference = ar;
            requestWR.languageCode = 'SP';
            requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            

            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            errorResponse = R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse(jsonData, 0);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            
            CLS_INC_WT_Monitoring.watchingWT( 'informePIR', 'Damaged');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.informePIR', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling Refresh damaged bag on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void refreshDAH(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            

            resetBooleanos();
            //refrescamos la visual con los nuevos datos refrescados desde WT
            incidentInformationSection1 = getIncidentInformation('1');
            incidentInformationSection2 = getIncidentInformation('2');
            incidentInformationSection3 = getIncidentInformation('3');
            incidentInformationSection4 = getIncidentInformation('4');
            incidentInformationSection5 = getIncidentInformation('5');
            incidentInformationSection6 = getIncidentInformation('6');
            incidentInformationSection7 = getIncidentInformation('7');
            incidentInformationSection8 = getIncidentInformation('8');
            incidentInformationSection9 = getIncidentInformation('9');
            incidentInformationSection10 = getIncidentInformation('10');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.refreshDAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Calling Read in WT and Refresh damaged bag on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    28/11/2017             Alvaro Garcia Tapia                  Initial Version
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
----------------------------------------------------------------------------------------------------------------------*/
    public void readRefreshDAH(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R1_Incident__c> inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];
            if(!inci.isEmpty()){
                Id test = R1_CLS_Utilities.readRecord_WT(inci[0].recordType.DeveloperName, inci[0].R2_INC_TXT_PIR_Station_Code__c, inci[0].R2_INC_TXT_PIR_Airline_Code__c, inci[0].R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);
            }

            //refrescamos la visual con los nuevos datos refrescados desde WT
            incidentInformationSection1 = getIncidentInformation('1');
            incidentInformationSection2 = getIncidentInformation('2');
            incidentInformationSection3 = getIncidentInformation('3');
            incidentInformationSection4 = getIncidentInformation('4');
            incidentInformationSection5 = getIncidentInformation('5');
            incidentInformationSection6 = getIncidentInformation('6');
            incidentInformationSection7 = getIncidentInformation('7');
            incidentInformationSection8 = getIncidentInformation('8');
            incidentInformationSection9 = getIncidentInformation('9');
            incidentInformationSection10 = getIncidentInformation('10');

            CLS_INC_WT_Monitoring.watchingWT( 'refreshDPR', 'Damaged');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.readRefreshDAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Calling Modify in WT and Refresh damaged bag on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                                <Change Description>
    21/12/2017             Alvaro Garcia Tapia                      Initial Version
    13/04/18                Alberto Puerto Collado                  Quick Fix: replace type instead type_z
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
    public void modifyDPR(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR = new R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku();
            System.debug('Llega hasta aqui??????????????????????????????');
            //String goodJson = '{   "additionalInfo":{      "customsInfo":"UPDATE CUSTOM",      "furtherInfo":"UPDATE FURTHER",      "miscellaneousInfo":null,      "supplementaryInfo":[         {            "seq":"1",            "supplimentInfoText":"UPDATE SUPPL"         }      ],      "userComments":[         {            "commentsText":"UPDATE COMMENTS",            "seq":"2"         }      ]   },   "agentId":"n433081",   "claim":{      "claimData":{         "claimAmount":{            "amount":{               "amountValue":"9500",               "currencyCode":"GBP",               "decimalPlace":"2"            }         },         "claimDate":"2017-03-14",         "costRemarks":[            {          "costRemarksText": "cost test",     "seq": "1"        }         ],         "excessValue":{            "amountValue":"200",            "currencyCode":"USD",            "decimalPlace":"1"         },         "faultStationCode":"MAD",         "faultTerminal":"T2",         "lossComments":"cmn:LossComments",         "lossReasonCode":"20",         "missingBags":"10",         "notifiedDate":"2017-03-14",         "partnerCode":{            "carrrierCode":"AB"         },         "passengerPayments":{            "passengerPaymentsValue":[               {                  "amount":{                     "amountValue":"2500",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               },               {                  "amount":{                     "amountValue":"1000",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               }            ]         },         "questionnaireDate":"2017-03-14",         "toiletKits":{            "toiletKitsFemale":"2"         }      }   },   "crossReferenceRecord":[      {         "recordReference":{            "airlineCode":"IB",            "referenceNumber":"98711",            "stationCode":"MAD"         },         "recordType":"DELAYED"      }   ],   "delayedBagGroup":{      "bagAddress":{         "addressLine":{            "addressLineDesc":"addressLine"         },         "country":{            "countryCode":"BN",            "countryName":"Country"         },         "postalCode":"BZ",         "state":{            "StateCode":"ST",            "stateDesc":"ES"         }      },      "bagDeliveryAddress":{         "deliveryAddress":{            "addressLine":{               "addressLineDesc":"AddressLineDesc"            },            "city":"city",            "country":{               "countryCode":"BN",               "countryName":"Country"            },            "postalCode":"BZ",            "state":{               "stateCode":"BN",               "stateDesc":"Desc"            }         },         "deliveryInfo":[            "cmn:DeliveryInfo"         ],         "deliveryService":[            "cmn:DeliveryService"         ],         "deliveryWeight":"20",         "localDlvInfo":[            {               "divInfo":"cmn:DivInfo",               "seq":"3"            }         ]      },      "bagLastSeen":"LHR",      "bagPhones":{         "phone":[            "84385361559440122333"         ]      },      "bagTagDestinations":{         "station":[            {               "stationValue":"MAD"            }         ]      },      "bagWeight":"10",      "baggageItinerary":{         "flightDateOrARNK":[            {               "flightDate":{                  "airlineCode":"IB",                  "date":"2017-09-12",                  "flightNumber":"3170"               }            }         ]      },      "contentsGender":"M",      "delayedBags":[         {            "associatedRecord":{               "recordReference":{                  "airlineCode":"IB",                  "referenceNumber":"987011",                  "stationCode":"MAD"               },               "recordType":"DELAYED"            },            "bagContents":{               "content":[                  {                     "category":"ALCOHOL",                     "description":"cmn:Description"                  },                  {                     "category":"Camisa",                     "description":"Azul"                  },                  {                     "category":"Ipad",                     "description":"Ipad Air Blanco"                  }               ]            },            "bagDelivery":{               "bagReceived":{                  "bagReceivedDate":"2017-09-12T09:05:50",                  "station":"MAD"               },               "deliveredTime":"2017-09-19T09:05:50",               "status":{                  "delivered":"cmn:Delivered",                  "outForDelivery":"cmn:OutForDelivery",                  "trackingUpdate":"cmn:TrackingUpdate",                  "unableToDeliver":"cmn:UnableToDeliver"               }            },            "bagDetails":"cmn:BagDetails",            "bagReceivedFromCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagSentToCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagTag":{               "airlineCode":"IB",               "licenseNumber":{                  "issuerCode":"123",                  "tagType":"2"               },               "tagSequence":"556985"            },            "brandInfo":{               "brandInfo":"MNA"            },            "colorTypeDesc":{               "colorCode":"WT",               "descriptor":{                  "materialElement":"X",                  "otherElement":[                     "W",                     "B"                  ]               },               "typeCode":"5"            },            "contentDescription":"cmn:ContentDescription",            "lockCode":"lock12",            "remarks":[               "cmn:Remarks"            ],            "storageLocation":"cmn:StorageLocation",            "uniqueId":{               "uniqueID":"2556-5698-4152"            }         }      ],      "excessBaggage":"ExcessBaggage",      "matchWindow":"2",      "missingWeight":"3"   },   "designatedLocator":"AMDI",   "handledAirlineCopyIndicator":"YES",   "passengers":{      "autoMessageOption":"MANUAL",      "contactInfo":{         "cellPhones":[            {               "phone":"1234567890"            }         ],         "emails":[            {               "email":"cmnEmail@mail.com"            },            {               "email":"cmnEmail@mail.com"            }         ],         "faxes":[            {               "fax":"cmn:Fax"            }         ],         "permanentAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "StateCode":"ST",               "stateDesc":"ES"            }         },         "permanentPhones":[            {               "phone":"1234567890"            }         ],         "temporaryAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "stateCode":"ST",               "stateDesc":"ES"            }         },         "temporaryPhones":[            {               "phone":"1234567890"            }         ]      },      "fareBasis":"Basis",      "frequentFlyerId":"XS123345678",      "initials":[         {            "initial":"a"         }      ],      "itinerary":{         "flightSegmentsorARNK":[            {               "flight":{                  "flightandDate":{                     "airlineCode":"XS",                     "date":"2017-11-11",                     "flightNumber":"413Q"                  },                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "arnk":{                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "flight":{                  "flightandDate":{                     "airlineCode":"IB",                     "date":"2017-11-11",                     "flightNumber":"413S"                  },                  "originDestination":{                     "destination":"MAD",                     "origin":"MAA"                  }               }            }         ]      },      "language":"English",      "names":[         {            "name":"nameExample"         }      ],      "numberOfPassengers":"2",      "passportInfo":"cmn:PassportInfo",      "pnr":"58624",      "pooledTicketNumber":"TicketNumber",      "status":"cmn:Status",      "ticketNumber":"1256984",      "title":"cmn:Title"   },   "refStationAirline":{      "stationAirline":"IB",      "stationCode":"MAD"   },   "teletypeAddresses":[      "ABCA9A9"   ]}';
            //goodJson = goodJson.replaceAll('"date"', '"rDate"');
            //System.debug('---> JSON good hc' + goodJson);
            //requestWR = (R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku) JSON.deserialize(goodJson, R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku.class);
            
            //parseBagSection(requestWR);
            String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

            parseBagDamagedInfo(requestWR);
            String pir = parseSection1(requestWR);
            parseSection2(requestWR);
            parseSection3(requestWR);
            parseSection4(requestWR);
            parseSection5(requestWR);
            parseSection6(requestWR);
            parseSection7(requestWR);
            parseSection8(requestWR);
            parseSection9(requestWR);
            parseSection10(requestWR);
            requestWR.agentId = agentId;

            List<String> pirAtributtes = pir.split('@');
            String airlineCode = pirAtributtes[0];
            String stationCode = pirAtributtes[1];
            String referenceNumber = pirAtributtes[2];

            //Si en algun momento se hace que los lookup se guarden al modificar en vez cada vez que se pone un nuevo valor
            //if (lookupValuesMap != null) {
            //    R1_Incident__c inc = new R1_Incident__c();
            //    inc.Id = incidenciaId;
            //    for (String key : lookupValuesMap.keySet()) {
            //        inc.put(key, lookupValuesMap.get(key)); 
            //    }
            //update inc;
            //}

            System.debug('WRAPPER_REQUEST:::'+requestWR);

            String wrapperJson = JSON.serialize(requestWR, true);
            System.debug('STRING_REQUEST:::'+requestWR);
            wrapperJson = wrapperJson.replaceAll('"rDate"', '"date"');
            wrapperJson = wrapperJson.replaceAll('"type_Z"', '"type"');//13/04/18 AlbertoPuerto added
            wrapperJson = wrapperJson.replaceAll('"delete_replace"', '"delete"');
            //String resultado = R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag(wrapperJson, 0);
            errorResponse = R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag(wrapperJson, 0);
            System.debug('REDOBLE DE TAMBORES........ ' + errorResponse);
            if(errorResponse == '1'){
                R1_CLS_Utilities.readRecord_WT('DAMAGED', stationCode, airlineCode, referenceNumber, agentId, 1);
            }
            //List<String> lstResultado = resultado.split('@splitMe@');
            
            //resp.record
            //R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord 
            //String success = lstResultado[0];
            //R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord resp = (R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord)JSON.deserialize(lstResultado[0],R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord.class);
            
            //resp.warnings
            //List<R2_CLS_WT_Wrappers_Modify_Damaged.WarningType>
            //warnings = (List<R2_CLS_WT_Wrappers_Modify_Damaged.WarningType>) JSON.deserialize(lstResultado[1], List<R2_CLS_WT_Wrappers_Modify_Damaged.WarningType>.class);
            //resp.errors
            //List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType> 
            //errors = (List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType>) JSON.deserialize(lstResultado[0], List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType>.class);
            //System.debug('::REGISTRO-> '+success+'#######WARNINGS-> '+warnings);
            //System.debug(registro.recordType);
            //if(success == '"true"'){
            //    errorResponse = '1'

                //avisar de warnings y después leer y cargar detalle de pir
                //leemos y cargamos
                //DEBUG|bigWP::::::::READ: EJEMPLO Leído:
                //{"recordId":{"recordType":"DAMAGED","
                                //recordReference":{"stationCode":"stationCode","referenceNumber":"referenceNumber","airlineCode":"airlinecode"}},"
                                //agentId":"agentId"}
                //ejemplo:R1_CLS_Utilities.readRecord_WT('DAMAGED', 'stationCode', 'airlinecode', 'referenceNumber', 'agentId', 1);
                //Id 
                //incidenciaId = R1_CLS_Utilities.readRecord_WT('DAMAGED', 
                //                                stationCode,
                //                                airlineCode, 
                //                                referenceNumber,
                //                                'agentId',
                //                                 1);
                //System.debug('ID del pir creado:'+incidenciaId);
                //abreNewRegistro(incidenciaId);
            //}else{
            //    errorResponse = '0';
            //    errors = (List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType>) JSON.deserialize(lstResultado[0], List<R2_CLS_WT_Wrappers_Modify_Damaged.ErrorType>.class);
            //    //informar de errors

            //}
            CLS_INC_WT_Monitoring.watchingWT( 'modifyDPR', 'Damaged');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.modifyDPR', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    modify the PIR, previous close it (we need dummy payments)
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    21/12/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void modifyDPRpreClose(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR = new R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku();
            System.debug(' modify pre close: ');

            String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            requestWR.agentId = agentId;

            String pir = parseSection1(requestWR);
            parseSection2(requestWR);
            parseSection3(requestWR);
            parseSection4(requestWR);
            parseSection5(requestWR);
            parseSection6(requestWR);
            parseSection7(requestWR);
            parseSection8(requestWR);
            parseSection9(requestWR);
            parseSection10(requestWR);
            parseCS(requestWR);

            List<String> pirAtributtes = pir.split('@');
            String airlineCode = pirAtributtes[0];
            String stationCode = pirAtributtes[1];
            String referenceNumber = pirAtributtes[2];

            System.debug('WRAPPER_REQUEST modifyDPRpreClose :::'+requestWR);

            String wrapperJson = JSON.serialize(requestWR, true);
            System.debug('STRING_REQUEST modifyDPRpreClose pre replace:::'+wrapperJson);
            wrapperJson = wrapperJson.replaceAll('"rDate"', '"date"');
            wrapperJson = wrapperJson.replaceAll('"delete_replace"', '"delete"');
            System.debug('STRING_REQUEST modifyDPRpreClose replaced:::'+wrapperJson);
            errorResponse = R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag(wrapperJson, 0);
            System.debug('REDOBLE DE TAMBORES modifyDPRpreClose........ ' + errorResponse);
            
           
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.modifyDPRpreClose', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

        private PageReference abreNewRegistro(Id idNew){
        return new PageReference('/'+idNew);
    }

    private Date parseDate(String fieldDate) {
        String[] dateItem = fieldDate.split('-');
        return Date.newinstance(Integer.valueOf(dateItem[2]), Integer.valueOf(dateItem[0]), Integer.valueOf(dateItem[1]));
    }

    private String parseSection1(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        String airlineCode = '';
        String stationCode = '';
        String numberPIR = '';
        for (Field field : incidentInformationSection1) {
            if (field.value == '' || field.value == null) { continue; }
            //if (field.value == null) { continue; }
            //if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
            //    requestWR.recordReference.stationCode = field.value;
            //    stationCode = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
            //    requestWR.recordReference.airlineCode = field.value;
            //    airlineCode = field.value;
            //}
            else if (field.name == 'R2_INC_FOR_PIR__c') {
                if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
                numberPIR = field.value;
            }
            //if(field.oldValue != field.value){
                if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
                    if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                    requestWR.claim.faultStationCode = field.value;
                }
                else if (field.name == 'R2_INC_DAT_PIR_Claims_Created_Date__c') {
                    if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                    //requestWR.claim.claimData.claimDate = parseDate(field.value);
                    requestWR.claim.claimDate = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c') {
                for (String record : field.value.split('/')) {
                    record = record.trim();
                    List<String> xr = record.split(' ');
                    if (xr.size() == 2) {
                        R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord associted = new R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord();
                        R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference reference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference();
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
                        if (requestWR.crossReferenceRecords == null) { requestWR.crossReferenceRecords = new R2_CLS_WT_Wrappers_Modify_Damaged.CrossReferenceRecords(); }
                        if (requestWR.crossReferenceRecords.crossReferenceRecord == null) { requestWR.crossReferenceRecords.crossReferenceRecord = new List<R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord>(); }
                        requestWR.crossReferenceRecords.crossReferenceRecord.add(associted);
                    }
                }
            }
            // else if (field.name == 'R2_INC_FOR_PIR_AR__c') {
            //  // TODO WIP
            // } NOT NECESSARY
            //else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
            //    if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            //    //requestWR.claim.claimData.claimDate = parseDate(field.value);
            //    requestWR.claim.claimDate = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
            //    requestWR.recordReference.stationCode = field.value;
            //    stationCode = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
            //    requestWR.recordReference.airlineCode = field.value;
            //    airlineCode = field.value;
            //}
            //else if (field.name == 'R2_INC_FOR_PIR__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
            //    numberPIR = field.value;
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Last_mapping_date__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_LOO_Case__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Search_start_date__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_PIR_DAT_PIR_Full_reintegration_date__c') {
            //    // TODO WIP
            //}
            else if (field.name == 'R2_INC_TXT_PIR_Control_office__c') {
                // TODO WIP
            }
            else if (field.name == 'R2_INC_NUM_PIR_Associated_Cases__c') {
                // TODO WIP
            }
            //else if (field.name == 'R2_INC_DAT_PIR_Cancellation_date__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Date_back_primary_search__c') {
            //    // TODO WIP
            //}
            else if (field.name == 'R2_INC_DAT_PIR_Control_date__c') {
                requestWR.lzControlDate = field.value;
            }
            //else if (field.name == 'RecordTypeId') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Unsuccessful_search__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DATH_PIR_Incidence_closed_date__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Agent__c') {
            //    //requestWR.agentId = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Report_PIR__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_VIP_Account__c') {
            //    // TODO WIP
            //}
            else if (field.name == 'R2_INC_PKL_PIR_Status_incidence__c') {
                // TODO WIP
            }
            else if (field.name == 'R2_INC_TXT_PIR_Stop_and_Operator_MS__c') {  //Descomentar si se deja de mostrar la estacion y escala
                // TODO WIP
                if (requestWR.recordReference == null) { requestWR.recordReference = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference(); }
                requestWR.recordReference.stationCode = field.value.substring(0,3);
                stationCode = field.value.substring(0,3);
                requestWR.recordReference.airlineCode = field.value.substring(3,5);
                airlineCode = field.value.substring(3,5);
            }
            //else if (field.name == 'R2_INC_TXT_PIR_AR_Station_Code__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_AR_Airline_Code__c') {
            //    // TODO WIP
            //}
        //}
        }
        if (requestWR.recordReference != null) {
            requestWR.recordReference.referenceNumber = numberPIR.substring(stationCode.length() + airlineCode.length());
        }
        return airlineCode + '@' + stationCode + '@' + requestWR.recordReference.referenceNumber;
    }

    private void parseSection2(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field :incidentInformationSection2) {
            if (field.value == '' || field.value == null) { continue; }
            //if (field.value == null) { continue; }
            //if(field.oldValue != field.value || filed.value != ''){
            if (field.name == 'R2_INC_TXT_PIR_Name__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Names primerNombre = new R2_CLS_WT_Wrappers_Modify_Damaged.Names();
                primerNombre.name = field.value;
                primerNombre.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Names>(); }
                requestWR.passenger.names.add(primerNombre);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Last_name__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Names primerApellido = new R2_CLS_WT_Wrappers_Modify_Damaged.Names();
                primerApellido.name = field.value;
                primerApellido.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Names>(); }
                requestWR.passenger.names.add(primerApellido);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Last_name2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Names segundoApellido = new R2_CLS_WT_Wrappers_Modify_Damaged.Names();
                segundoApellido.name = field.value;
                segundoApellido.seq = '3';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.names == null ) { requestWR.passenger.names = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Names>(); }
                requestWR.passenger.names.add(segundoApellido);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Treatment__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.title = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Initial__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Initials inicial1 = new R2_CLS_WT_Wrappers_Modify_Damaged.Initials();
                inicial1.initial = field.value;
                inicial1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Initials>(); }
                requestWR.passenger.initials.add(inicial1);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Initial2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Initials inicial2 = new R2_CLS_WT_Wrappers_Modify_Damaged.Initials();
                inicial2.initial = field.value;
                inicial2.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Initials>(); }
                requestWR.passenger.initials.add(inicial2);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Initial3__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Initials inicial3 = new R2_CLS_WT_Wrappers_Modify_Damaged.Initials();
                inicial3.initial = field.value;
                inicial3.seq = '3';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.initials == null ) { requestWR.passenger.initials = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Initials>(); }
                requestWR.passenger.initials.add(inicial3);
            }
            else if (field.name == 'R2_INC_EMA_PIR_Email1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone emailDireccion1 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                emailDireccion1.value = field.value;
                emailDireccion1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.emails == null ) { requestWR.passenger.contactInfo.emails = new R2_CLS_WT_Wrappers_Modify_Damaged.Emails(); }
                if (requestWR.passenger.contactInfo.emails.email == null ) { requestWR.passenger.contactInfo.emails.email = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.emails.email.add(emailDireccion1);
            }
            else if (field.name == 'R2_INC_EMA_PIR_Email2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone emailDireccion2 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                emailDireccion2.value = field.value;
                emailDireccion2.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }

                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.emails == null ) { requestWR.passenger.contactInfo.emails = new R2_CLS_WT_Wrappers_Modify_Damaged.Emails(); }
                if (requestWR.passenger.contactInfo.emails.email == null ) { requestWR.passenger.contactInfo.emails.email = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.emails.email.add(emailDireccion2);
            }
            else if (field.name == 'R2_INC_TXT_PIR_FF_Identificator__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.frequentFlyerId = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Passenger_language__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.language = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Ticket_number__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.ticketNumber = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_PNR_locator__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.pnr = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Passenger_category__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.status = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Delivery_address1__c') {
                // R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
                // addressLine.addressLineDesc = field.value;
                // addressLine.seq = '1';
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Modify_Damaged.Delivery(); }
                if (requestWR.damagedBagGroup.delivery.deliveryAddress == null) { requestWR.damagedBagGroup.delivery.deliveryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                if (requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine == null) { requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine(); }
                requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
                requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine.seq = '1';
            }
            else if (field.name == 'R2_INC_TXT_PIR_Delivery_address2__c') {
                // R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
                // addressLine.addressLineDesc = field.value;
                // addressLine.seq = '2';
                //if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                //if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Modify_Damaged.Delivery(); }
                //if (requestWR.damagedBagGroup.delivery.deliveryAddress == null) { requestWR.damagedBagGroup.delivery.deliveryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                //if (requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine == null) { requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine(); }
                //requestWR.damagedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Delivery_local_informatio__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo();
                addressLine.dlvInfo = field.value;
                addressLine.seq = '1';
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Modify_Damaged.Delivery(); }
                if (requestWR.damagedBagGroup.delivery.localDlvInfo == null) { requestWR.damagedBagGroup.delivery.localDlvInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo>(); }
                requestWR.damagedBagGroup.delivery.localDlvInfo.add(addressLine);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Deliver_local_informatio2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo();
                addressLine.dlvInfo = field.value;
                addressLine.seq = '2';
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Modify_Damaged.Delivery(); }
                if (requestWR.damagedBagGroup.delivery.localDlvInfo == null) { requestWR.damagedBagGroup.delivery.localDlvInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.LocalDlvInfo>(); }
                requestWR.damagedBagGroup.delivery.localDlvInfo.add(addressLine);
            }
            else if (field.name == 'R2_INC_PKL_PIR_Send_SMS_email__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                requestWR.passenger.autoMessageOption = field.value;
            }
            //}
        }
    }

    private void parseSection3(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field :incidentInformationSection3) {
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_INC_TXT_PIR_Permanent_address1__c') {
                //R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine direccionLinea1 = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
                //direccionLinea1.addressLineDesc = field.value;
                //direccionLinea1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                //if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new List<R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine>(); }
                //requestWR.passenger.contactInfo.temporaryAddress.addressLine.add(direccionLinea1);                
                if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine(); }
                requestWR.passenger.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
                requestWR.passenger.contactInfo.permanentAddress.addressLine.seq = '1';
            }
            else if (field.name == 'R2_INC_TLF_Landline1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone telefonoFijo1 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                telefonoFijo1.value = field.value;
                telefonoFijo1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.permanentPhones == null) { requestWR.passenger.contactInfo.permanentPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.permanentPhones.phone == null) { requestWR.passenger.contactInfo.permanentPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.permanentPhones.phone.add(telefonoFijo1);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Temporal_address1__c') {
                //R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine direccionLinea = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
                //direccionLinea.addressLineDesc = field.value;
                //direccionLinea.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.TemporaryAddress(); }
                //if (requestWR.passenger.contactInfo.temporaryAddress.addressLine == null) { requestWR.passenger.contactInfo.temporaryAddress.addressLine = new List<R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine>(); }
                //requestWR.passenger.contactInfo.temporaryAddress.addressLine.add(direccionLinea);
                if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine(); }
                requestWR.passenger.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
                requestWR.passenger.contactInfo.permanentAddress.addressLine.seq = '1';

            }
            else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone telefonoTemporal1 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                telefonoTemporal1.value = field.value;
                telefonoTemporal1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.temporaryPhones == null) { requestWR.passenger.contactInfo.temporaryPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.temporaryPhones.phone == null) { requestWR.passenger.contactInfo.temporaryPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.temporaryPhones.phone.add(telefonoTemporal1);
            }
            //else if (field.name == 'R2_INC_TXT_PIR_Permanent_address2__c') { //al modificar no permite meter una segunda direccion
            //    R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine direccionLinea2 = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
            //    direccionLinea2.addressLineDesc = field.value;
            //    direccionLinea2.seq = '2';
            //    if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
            //    if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
            //    if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
            //    if (requestWR.passenger.contactInfo.permanentAddress.addressLine == null) { requestWR.passenger.contactInfo.permanentAddress.addressLine = new List<R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine>(); }
            //    requestWR.passenger.contactInfo.temporaryAddress.addressLine.add(direccionLinea2);
            //}
            else if (field.name == 'R2_INC_TLF_Landline2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone telefonoFijo2 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                telefonoFijo2.value = field.value;
                telefonoFijo2.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.permanentPhones == null) { requestWR.passenger.contactInfo.permanentPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.permanentPhones.phone == null) { requestWR.passenger.contactInfo.permanentPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.permanentPhones.phone.add(telefonoFijo2);
            }
            //else if (field.name == 'R2_INC_TXT_PIR_Temporal_address2__c') { //al modificar no permite meter una segunda direccion
            //    R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine direccionLinea = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
            //    direccionLinea.addressLineDesc = field.value;
            //    direccionLinea.seq = '2';
            //    if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
            //    if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
            //    if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.TemporaryAddress(); }
            //    if (requestWR.passenger.contactInfo.temporaryAddress.addressLine == null) { requestWR.passenger.contactInfo.temporaryAddress.addressLine = new List<R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine>(); }
            //    requestWR.passenger.contactInfo.temporaryAddress.addressLine.add(direccionLinea);
            //}
            else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone telefonoTemporal2 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                telefonoTemporal2.value = field.value;
                telefonoTemporal2.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.temporaryPhones == null) { requestWR.passenger.contactInfo.temporaryPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.temporaryPhones.phone == null) { requestWR.passenger.contactInfo.temporaryPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.temporaryPhones.phone.add(telefonoTemporal2);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Zip_code__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.permanentAddress == null) { requestWR.passenger.contactInfo.permanentAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                requestWR.passenger.contactInfo.permanentAddress.postalCode = field.value;
            }
            else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone mobile1 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                mobile1.value = field.value;
                mobile1.seq = '1';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.cellPhones == null) { requestWR.passenger.contactInfo.cellPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.cellPhones.phone == null) { requestWR.passenger.contactInfo.cellPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.cellPhones.phone.add(mobile1);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Temporal_Zip_Code__c') {
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.TemporaryAddress(); }
                requestWR.passenger.contactInfo.temporaryAddress.postalCode = field.value;
            }
            else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.Phone mobile2 = new R2_CLS_WT_Wrappers_Modify_Damaged.Phone();
                mobile2.value = field.value;
                mobile2.seq = '2';
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.cellPhones == null) { requestWR.passenger.contactInfo.cellPhones = new R2_CLS_WT_Wrappers_Modify_Damaged.PermanentPhones(); }
                if (requestWR.passenger.contactInfo.cellPhones.phone == null) { requestWR.passenger.contactInfo.cellPhones.phone = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Phone>(); }
                requestWR.passenger.contactInfo.cellPhones.phone.add(mobile2);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Validity_temporary_addres__c') {
                List<String> auxLst = field.value.split('/');
                //creando formato de fecha de salesforce (yyyy-mm-dd)
                String dateStr;
                //creando formato de fecha EEUU (mm-dd-yyyy)
                if (UserInfo.getLocale() == 'en_US') {
                    dateStr = auxLst[2] + '-' + auxLst[0] + '-' + auxLst[1];
                }
                else {
                    //creando formato de fecha resto mundo (dd-mm-yyyy)
                    dateStr = auxLst[2] + '-' + auxLst[1] + '-' + auxLst[0];
                }
                if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                if (requestWR.passenger.contactInfo == null ) { requestWR.passenger.contactInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.ContactInfo(); }
                if (requestWR.passenger.contactInfo.temporaryAddress == null) { requestWR.passenger.contactInfo.temporaryAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.TemporaryAddress(); }
                requestWR.passenger.contactInfo.temporaryAddress.validityDate = dateStr;
            }
        }
    }

    private void parseSection4(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field : incidentInformationSection4) {
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
                if(field.value != null && field.value != '') {
                    Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
                    Integer i = 0;
                    System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
                    for (String key : dateFlightsMap.keySet()) {
                        for (String vuelo : dateFlightsMap.get(key)) {
                            if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                            if (requestWR.damagedBagGroup.baggageItinerary == null) { requestWR.damagedBagGroup.baggageItinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.BaggageItinerary(); }
                            if (requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK == null) { requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightDateOrARNK>(); }
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK.add(new R2_CLS_WT_Wrappers_Modify_Damaged.FlightDateOrARNK());
                            if (requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate == null) { requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightDate(); }
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.airlineCode = vuelo.substring(0,2);
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.flightNumber = vuelo.substring(2);
                            requestWR.damagedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.rDate = key;
                            i++;
                        }
                    }
                }
                // R2_CLS_WT_Wrappers_Modify_Damaged.Route route = new R2_CLS_WT_Wrappers_Modify_Damaged.Route();
                // route.route = field.value;
                // R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK fSegmentOARNK = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK();
                // fSegmentOARNK.additionalRoutes.add(route);
                // if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.passenger(); }
                // if (requestWR.damagedBagGroup.bagItinerary == null) { requestWR.damagedBagGroup.bagItinerary = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightDateOrARNK>(); }
                // if (requestWR.damagedBagGroup.bagItinerary.flightDate == null) { requestWR.damagedBagGroup.bagItinerary.flightDate = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightDate(); }
                // requestWR.damagedBagGroup.bagItinerary.flightSegmentsOrARNK.add(route);
                // FIXME Campo no encontrado BagTagDestinations?????? Itinerario no lleva ruta :S
            } else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
                if((field.value != null && field.value != '') || (boolModifyEnabled && newFlight != null && newFlight != '')) {
                    Map<String, List<String>> dateFlightsMap = new Map<String, List<String>>();
                    ///Prorrateos 16/02/2018
                    if (boolModifyEnabled && newFlight != null && newFlight != '') {
                        dateFlightsMap = R1_CLS_Utilities.helper_parseDate(newFlight);
                    }
                    /////////////////////////////
                    else {
                        dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
                    }
                    Integer i = 0;
                    for (String key : dateFlightsMap.keySet()) {
                        for (String vuelo : dateFlightsMap.get(key)) {
                            if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK>(); }
                            requestWR.passenger.itinerary.flightSegmentsOrARNK.add(new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK());
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight = new R2_CLS_WT_Wrappers_Modify_Damaged.Flight(); }
                            if (requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightDate(); }
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.airlineCode = vuelo.substring(0,2);
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.flightNumber = vuelo.substring(2);
                            requestWR.passenger.itinerary.flightSegmentsOrARNK[i].flight.flightandDate.rDate = key;
                            i++;
                        }
                    }
                }
                //if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.passenger(); }
                //if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.Itinerary(); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK>(); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK.isEmpty()) { requestWR.passenger.itinerary.flightSegmentsOrARNK.add(new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK()); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK[0].flight == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[0].flight = new R2_CLS_WT_Wrappers_Modify_Damaged.Flight(); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK[0].flight.flightandDate == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[0].flight.flightandDate = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightDate(); }
                //requestWR.passenger.itinerary.flightSegmentsOrARNK[0].flight.flightandDate.rDate = field.value;
            } else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
                if((field.value != null && field.value != '') || (boolModifyEnabled && newRoute != null && newRoute != '')) {
                    List<String> rutaLst = new List<String>();
                    ///Prorrateos 16/02/2018
                    if (boolModifyEnabled && newRoute != null && newRoute != '') {
                        rutaLst = newRoute.split('/');
                    }
                    ////////////////////
                    else {
                        rutaLst = field.value.split('/');
                    }
                    System.debug('rutaLst: ' + rutaLst);
                    //Integer i = 1;
                    for (Integer i = 1; i < rutaLst.size(); i++) {
                        if (i < 6) {
                            if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.flightSegmentsorARNK == null) { requestWR.passenger.itinerary.flightSegmentsorARNK = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsorARNK>(); }
                            if (requestWR.passenger.itinerary.flightSegmentsorARNK.size() < i) { requestWR.passenger.itinerary.flightSegmentsorARNK.add(new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsorARNK()); }
                            //if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight == null) { requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight = new R2_CLS_WT_Wrappers_Modify_Damaged.Flight(); }
                            //if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination == null) { requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination = new R2_CLS_WT_Wrappers_Modify_Damaged.OriginDestination(); }
                            //requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                            //requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight == null) {
                                if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk == null) { requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk = new R2_CLS_WT_Wrappers_Modify_Damaged.Arnk(); }
                                if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk.originDestination == null) { requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk.originDestination = new R2_CLS_WT_Wrappers_Modify_Damaged.OriginDestination(); }
                                requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk.originDestination.origin = rutaLst[i-1];
                                requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].arnk.originDestination.destination = rutaLst[i];
                            }
                            else {
                                if (requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination == null) { requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination = new R2_CLS_WT_Wrappers_Modify_Damaged.OriginDestination(); }
                                requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                                requestWR.passenger.itinerary.flightSegmentsorARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            }
                        }
                        else {
                            if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.Passenger(); }
                            if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.Itinerary(); }
                            if (requestWR.passenger.itinerary.additionalRoutes == null) { requestWR.passenger.itinerary.additionalRoutes = new List<String>(); }
                            requestWR.passenger.itinerary.additionalRoutes.add(rutaLst[i]);
                        }
                    }
                }
                //R2_CLS_WT_Wrappers_Modify_Damaged.Route route = new R2_CLS_WT_Wrappers_Modify_Damaged.Route();
                //route.route = field.value;
                //R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK fSegmentOARNK = new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK();
                //fSegmentOARNK.additionalRoutes.add(route);
                //if (requestWR.passenger == null) { requestWR.passenger = new R2_CLS_WT_Wrappers_Modify_Damaged.passenger(); }
                //if (requestWR.passenger.itinerary == null) { requestWR.passenger.itinerary = new R2_CLS_WT_Wrappers_Modify_Damaged.Itinerary(); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK = new List<R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK>(); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK.isEmpty()) { requestWR.passenger.itinerary.flightSegmentsOrARNK.add(new R2_CLS_WT_Wrappers_Modify_Damaged.FlightSegmentsOrARNK()); }
                //if (requestWR.passenger.itinerary.flightSegmentsOrARNK[0].additionalRoutes == null) { requestWR.passenger.itinerary.flightSegmentsOrARNK[0].additionalRoutes = new List<R2_CLS_WT_Wrappers_Modify_Damaged.Route>(); }
                //requestWR.passenger.itinerary.flightSegmentsOrARNK[0].additionalRoutes.add(route);
            }
        }
    }

    private void parseSection5(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field :incidentInformationSection5) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Send_direction_FI__c') {
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
                requestWR.additionalInfo.furtherInfo = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Control_information1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo supplementInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo();
                supplementInfo.supplimentInfoText = field.value;
                supplementInfo.seq = '1';
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
                if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo>(); }
                requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Control_information2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo supplementInfo = new R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo();
                supplementInfo.supplimentInfoText = field.value;
                supplementInfo.seq = '2';
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
                if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.SupplementaryInfo>(); }
                requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
            }
            else if (field.name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c') {
                requestWR.handledAirlineCopyIndicator = field.value;
            }
            //else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
            //    if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
            //    if (requestWR.additionalInfo.miscellaneousInfo == null) { requestWR.additionalInfo.miscellaneousInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.MiscellaneousInfo>(); }
            //    if (requestWR.additionalInfo.miscellaneousInfo.isEmpty()) { requestWR.additionalInfo.miscellaneousInfo.add(new R2_CLS_WT_Wrappers_Modify_Damaged.MiscellaneousInfo()); }
            //    requestWR.additionalInfo.miscellaneousInfo[0].miscInfoText = field.value;
            //    requestWR.additionalInfo.miscellaneousInfo[0].seq = '1';
            //}
            //else if (field.name == 'R2_ADI_TXT_UC_User_Comment__c') {
            //    if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
            //    if (requestWR.additionalInfo.userComments == null) { requestWR.additionalInfo.userComments = new List<R2_CLS_WT_Wrappers_Modify_Damaged.UserComments>(); }
            //    if (requestWR.additionalInfo.userComments.isEmpty()) { requestWR.additionalInfo.userComments.add(new R2_CLS_WT_Wrappers_Modify_Damaged.UserComments()); }
            //    requestWR.additionalInfo.userComments[0].commentsText = field.value;
            //    requestWR.additionalInfo.userComments[0].seq = '1';
            //}
        }
    }

    private void parseSection6(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        //for (Field field : incidentInformationSection6) {
        //    if (field.value == '' || field.value == null) { continue; }
            
        //}
    }

    private void parseSection7(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field : incidentInformationSection7) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_piece__c') {
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                requestWR.damagedBagGroup.baggageWeight = field.value;
            }
            //else if (field.name == 'R2_INC_TXT_Last_Seen__c') {
            //    if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
            //    requestWR.damagedBagGroup.bagLastseen = field.value;
            //}
            else if (field.name == 'R2_INC_TXT_PIR_Weight_lost_parts__c') {
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                requestWR.damagedBagGroup.missingWeight = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_content1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.LostContents contenido = new R2_CLS_WT_Wrappers_Modify_Damaged.LostContents();
                contenido.seq = '1';
                contenido.content = field.value;
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.lostContents == null) { requestWR.damagedBagGroup.lostContents = new List<R2_CLS_WT_Wrappers_Modify_Damaged.LostContents>(); }
                requestWR.damagedBagGroup.lostContents.add(contenido);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_content2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.LostContents contenido = new R2_CLS_WT_Wrappers_Modify_Damaged.LostContents();
                contenido.seq = '2';
                contenido.content = field.value;
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.lostContents == null) { requestWR.damagedBagGroup.lostContents = new List<R2_CLS_WT_Wrappers_Modify_Damaged.LostContents>(); }
                requestWR.damagedBagGroup.lostContents.add(contenido);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c') {
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.delivery == null) { requestWR.damagedBagGroup.delivery = new R2_CLS_WT_Wrappers_Modify_Damaged.Delivery(); }
                requestWR.damagedBagGroup.delivery.deliveryWeight = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase1__c') {
                if (field.oldValue != field.value) {
                    //solo se rellena si se ha modificado la maleta 1
                    if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                    if (requestWR.damagedBagGroup.bagAddress == null) { requestWR.damagedBagGroup.bagAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                    if (requestWR.damagedBagGroup.bagAddress.addressLine == null) { requestWR.damagedBagGroup.bagAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine(); }
                    requestWR.damagedBagGroup.bagAddress.addressLine.addressLineDesc = field.value;
                    requestWR.damagedBagGroup.bagAddress.addressLine.seq = '1';
                }
            }
            else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
                //no se rellena si ya se ha metido una direccion de maleta 1
                if (field.oldValue != field.value) {
                    if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                    if (requestWR.damagedBagGroup.bagAddress == null) { requestWR.damagedBagGroup.bagAddress = new R2_CLS_WT_Wrappers_Modify_Damaged.BagAddress(); }
                    if (requestWR.damagedBagGroup.bagAddress.addressLine == null) {
                        requestWR.damagedBagGroup.bagAddress.addressLine = new R2_CLS_WT_Wrappers_Modify_Damaged.AddressLine();
                        requestWR.damagedBagGroup.bagAddress.addressLine.addressLineDesc = field.value;
                        requestWR.damagedBagGroup.bagAddress.addressLine.seq = '2';
                    }
                }
            }
            else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase1__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones tel = new R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones();
                tel.phone = field.value;
                tel.seq = '1';
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.bagPhones == null) { requestWR.damagedBagGroup.bagPhones = new List<R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones>(); }
                requestWR.damagedBagGroup.bagPhones.add(tel);
            }
            else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase2__c') {
                R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones tel = new R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones();
                tel.phone = field.value;
                tel.seq = '2';
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                if (requestWR.damagedBagGroup.bagPhones == null) { requestWR.damagedBagGroup.bagPhones = new List<R2_CLS_WT_Wrappers_Modify_Damaged.BagPhones>(); }
                requestWR.damagedBagGroup.bagPhones.add(tel);
            }
            else if (field.name == 'R2_INC_TXT_Excess_Baggage__c') {
                if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup(); }
                requestWR.damagedBagGroup.excessBaggage = field.value;
            }
            else if (field.name == 'R2_INC_CHK_PIR_Limited_approval_label__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                requestWR.claim.liabilityTag = Boolean.valueOf(field.value);
            }
            //else if (field.name == 'R2_ADI_ATXTL_DS_Delivery_service__c') {
            //    // TODO WIP
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Baggage_destination__c') {
            //    List<String> destLst = field.value.split('/');
            //    for (Integer i = 0; i < destLst.size(); i++) {
            //        if (requestWR.damagedBagGroup == null) { requestWR.damagedBagGroup = new R2_CLS_WT_Wrappers_Modify_Delayed.DamagedBagGroup(); }
            //        if (requestWR.damagedBagGroup.bagTagDestinations == null) { requestWR.damagedBagGroup.bagTagDestinations = new R2_CLS_WT_Wrappers_Modify_Delayed.BagTagDestinations(); }
            //        if (requestWR.damagedBagGroup.bagTagDestinations.station == null) { requestWR.damagedBagGroup.bagTagDestinations.station = new List<R2_CLS_WT_Wrappers_Modify_Delayed.Station>(); }
            //        requestWR.damagedBagGroup.bagTagDestinations.station.add(new R2_CLS_WT_Wrappers_Modify_Delayed.Station());
            //        requestWR.damagedBagGroup.bagTagDestinations.station[i].stationValue = destLst[i];
            //    }
            //}
        }
    }

    private void parseSection8(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        for (Field field : incidentInformationSection8) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.partnerCode.carrierCode PartnerCodecarrierCode
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                if (requestWR.claim.partnerCode == null) { requestWR.claim.partnerCode = new R2_CLS_WT_Wrappers_Modify_Damaged.PartnerCode(); }
                requestWR.claim.partnerCode.carrierCode = field.value;
            }
            else if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                requestWR.claim.insurance = Boolean.valueOf(field.value);
                //if (field.value == 'true') {
                //    requestWR.claim.insurance = 'YES';
                //}
                //else {
                //    requestWR.claim.insurance = 'No';
                //}
                
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                requestWR.claim.lossReasonCode = field.value;
            }
            //else if (field.name == 'R2_INC_CHK_PIR_Repair_suitcase__c') { // seria de damage???
            //    if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            //    requestWR.claim.claimData.repairBagIndicator = field.value;
            //    // FIXME no mapeado!
            //}
            else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
                // if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                // requestWR.claim. = field.value ;
                // FIXME no encontrado
            }
            else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                requestWR.claim.replacementBag = Boolean.valueOf(field.value);
                //if (field.value == 'true') {
                //    requestWR.claim.replacementBag = 'YES';
                //}
                //else {
                //    requestWR.claim.replacementBag = 'No';
                //}
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_reason_causes__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                //comprobamos que no haya sido ya relleno por las maletas, para en ese caso no perder informacion
                if (requestWR.claim.lossComments != null) {
                    String aux = requestWR.claim.lossComments.replaceAll('/','');
                    if (aux != '') {
                        requestWR.claim.lossComments = field.value;
                    }
                }
                
                
                
            }
            //else if (field.name == 'R2_INC_TXT_PIR_DO_Flight__c') { // resp.claim.claimData.
                // if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
                // requestWR.claim. = field.value ;
                // FIXME no encontrado
            //}
            //else if (field.name == 'R2_ADI_TXT_CR_Remarks_Cost__c') { // resp.claim.claimData.
            //    // if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            //    // if (requestWR.claim.costRemarks == null) { requestWR.claim.costRemarks = new List<R2_CLS_WT_Wrappers_Modify_Damaged.R2_ADI_TXT_CR_Remarks_Cost__c>(); }
            //     R2_CLS_WT_Wrappers_Modify_Damaged.CostRemarks costRemark = new R2_CLS_WT_Wrappers_Modify_Damaged.CostRemarks();
            //     costRemark.CostRemark = field.value;
            //     costRemark.seq = String.valueof(requestWR.claim.costRemarks.size() + 1);
            //    // requestWR.claim.costRemarks.add(costRemark); // FIXME desccomentar cuando se implemente el wrapper
            //    // START FIXME eliminar cuando se implemente lo de arriba
            //    if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            //    if (requestWR.claim.costRemarks == null) { requestWR.claim.costRemarks = new List<R2_CLS_WT_Wrappers_Modify_Damaged.CostRemarks>(); }
            //    requestWR.claim.costRemarks.add(costRemark);
            //    // END FIXME eliminar cuando se implemente lo de arriba
            //}
        }
    }

    private void parseSection9(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        //for (Field field : incidentInformationSection9) {
        //    if (field.value == '' || field.value == null) { continue; }
        //    if (field.name == 'R2_ADI_ATXTL_MR_Match__c') {
        //        //R2_CLS_WT_Wrappers_Modify_Damaged.MatchInfoType matchInfo1 = new R2_CLS_WT_Wrappers_Modify_Damaged.MatchInfoType();
        //        //matchInfo1.matchInfoText = field.value;
        //        //matchInfo1.seq = '1';
        //        //if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
        //        //if (requestWR.additionalInfo.matchInfo == null) { requestWR.additionalInfo.matchInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.MatchInfoType>(); }
        //        //requestWR.additionalInfo.matchInfo.add(matchInfo1);
        //    }
        //}
    }

    private void parseSection10(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        //for (Field field : incidentInformationSection10) {
        //    System.debug(field.value);
        //    if (field.value == '' || field.value == null) { continue; }
        //    if (field.name == 'R2_ADI_ATXTL_MG_Message__c') {
        //        //R2_CLS_WT_Wrappers_Modify_Damaged.MessageInfoType messageInfo1 = new R2_CLS_WT_Wrappers_Modify_Damaged.MessageInfoType();
        //        //messageInfo1.messageInfoText = field.value;
        //        //messageInfo1.seq = '1';
        //        //if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_CLS_WT_Wrappers_Modify_Damaged.AdditionalInfo(); }
        //        //if (requestWR.additionalInfo.messageInfo == null) { requestWR.additionalInfo.messageInfo = new List<R2_CLS_WT_Wrappers_Modify_Damaged.MessageInfoType>(); }
        //        //requestWR.additionalInfo.messageInfo.add(messageInfo1);
        //    }
        //}
    }
    
    private void parseBagDamagedInfo(R2_CLS_WT_Wrappers_Modify_Damaged.WT_modify_damaged_heroku requestWR) {
        R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup damageBagGroup = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBagGroup();
        R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBags damageBags = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBags();
        List<R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBag> lstDamageBags = new List<R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBag>();
        System.debug('!!!bagLst: ' + bagLst);
        //requestWR.delayedBagGroup.delayedBags
        // for para rellenar los campos de maleta
        if(!bagLst.isEmpty()){
            String rc = '';
            for(Integer i = 0;i<bagLst.size();i++){
                R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBag damageBag = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedBag();
                R2_CLS_WT_Wrappers_Modify_Damaged.DamagedTypes lstDamagedTypes = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedTypes();
                List<R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType> lstDamageType = new List<R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType>();
                R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType damageType = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType();
                R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType damageType2 = new R2_CLS_WT_Wrappers_Modify_Damaged.DamagedType();
                R2_CLS_WT_Wrappers_Modify_Damaged.BagSentToCustoms sentCustoms = new R2_CLS_WT_Wrappers_Modify_Damaged.BagSentToCustoms();
                R2_CLS_WT_Wrappers_Modify_Damaged.BagSentToCustoms receiveCustoms = new R2_CLS_WT_Wrappers_Modify_Damaged.BagSentToCustoms();
                //R2_CLS_WT_Wrappers_Create_Damaged.BagContents bagCont = new R2_CLS_WT_Wrappers_Create_Damaged.BagContents();
                R2_CLS_WT_Wrappers_Modify_Damaged.ColorTypeDesc colorType = new R2_CLS_WT_Wrappers_Modify_Damaged.ColorTypeDesc();
                R2_CLS_WT_Wrappers_Modify_Damaged.Descriptor descrip = new R2_CLS_WT_Wrappers_Modify_Damaged.Descriptor();
                R2_CLS_WT_Wrappers_Modify_Damaged.BrandInfo brandInf = new R2_CLS_WT_Wrappers_Modify_Damaged.BrandInfo();
                R2_CLS_WT_Wrappers_Modify_Damaged.BagTag bagtag = new  R2_CLS_WT_Wrappers_Modify_Damaged.BagTag();        
                R2_CLS_WT_Wrappers_Modify_Damaged.LicenseNumber licens = new R2_CLS_WT_Wrappers_Modify_Damaged.LicenseNumber();
                R2_CLS_WT_Wrappers_Modify_Damaged.BagDelivery bagDeliv = new R2_CLS_WT_Wrappers_Modify_Damaged.BagDelivery();
                R2_CLS_WT_Wrappers_Modify_Damaged.Status delivStatus = new R2_CLS_WT_Wrappers_Modify_Damaged.Status();
                R2_CLS_WT_Wrappers_Modify_Damaged.BagReceived bagReceiv = new R2_CLS_WT_Wrappers_Modify_Damaged.BagReceived();
                R2_CLS_WT_Wrappers_Modify_Damaged.UniqueID uniq = new R2_CLS_WT_Wrappers_Modify_Damaged.UniqueID(); 
                R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord assoc = new R2_CLS_WT_Wrappers_Modify_Damaged.AssociatedRecord();
				R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference recordRefer = new R2_CLS_WT_Wrappers_Modify_Damaged.RecordReference();               
                List<String> otrosElem = new List<String>();
                
                rc += bagLst[i].R2_BAG_NUM_Age__c + 'YEAR-' + bagLst[i].R2_BAG_TXT_Value_and_coin__c + '/';

                if(bagLst[i].R2_BAG_PKL_Type__c!=null && bagLst[i].R2_BAG_PKL_Colour__c!=null){
                    if(bagLst[i].R2_BAG_PKL_Type__c=='22D' || bagLst[i].R2_BAG_PKL_Type__c=='22R'){
                        colorType.typeCode = '22';
                    }else{
                        colorType.typeCode = bagLst[i].R2_BAG_PKL_Type__c;
                    }
                    colorType.colorCode = bagLst[i].R2_BAG_PKL_Colour__c;
                    //colorType.suspended = bagLst[i].R2_BAG_CHK_Suspended__c;
                    
                    if(bagLst[i].R2_BAG_CHK_Metal__c){
                        descrip.mtrlElement = 'M';
                    }else if(bagLst[i].R2_BAG_CHK_Rigid__c){
                        descrip.mtrlElement = 'R';                    
                    }else if(bagLst[i].R2_BAG_CHK_Mixed__c){
                        descrip.mtrlElement = 'D';
                    }else if(bagLst[i].R2_BAG_CHK_Leather__c){
                        descrip.mtrlElement = 'L';
                    }else if(bagLst[i].R2_BAG_CHK_Printed_fabric__c){
                        descrip.mtrlElement = 'T';
                    }
                    
                    if(bagLst[i].R2_BAG_CHK_Retractable_handle__c){
                        if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('H');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Combination_lock__c){
                        if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('C');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Wheels_or_bearing__c){
                         if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('W');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Single_object_in_box__c){
                        if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('B');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Suitcase_allowed_cabin__c){
                        if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('K');
                        }
                    }
                    if(bagLst[i].R2_BAG_CHK_Safety_belt__c){
                        if((otrosElem.size()<3 && descrip.mtrlElement==null) || (otrosElem.size()<2 && descrip.mtrlElement!=null)){
                            otrosElem.add('S');
                        }
                    }
                    
                    if(otrosElem.size()==0 && descrip.mtrlElement==null){
                        otrosElem.add('X');
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(otrosElem.size()==1 && descrip.mtrlElement==null){
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(otrosElem.size()==2 && descrip.mtrlElement==null){
                        otrosElem.add('X'); 
                    }else if(descrip.mtrlElement!=null && otrosElem.size()==0){
                        otrosElem.add('X');
                        otrosElem.add('X');
                    }else if(descrip.mtrlElement!=null && otrosElem.size()==1){
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
                    if(bagLst[i].R2_BAG_DAT_DateBagReceived__c !=null){
                        bagReceiv.rDate = String.valueOf(bagLst[i].R2_BAG_DAT_DateBagReceived__c);
                        bagReceiv.station = bagLst[i].R2_BAG_TXT_StationBagReceived__c;
                        bagDeliv.bagReceived = bagReceiv;
                    }
                    
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
                
                if(!lstDamageType.isEmpty()){
                    lstDamagedTypes.damagedType = lstDamageType;
                    damageBag.damagedTypes = lstDamagedTypes;
                }
                
                if(incidencia.RecordType.DeveloperName=='DAMAGED' && incidencia.R2_INC_TXT_PIR_AR_Station_Code__c!=null && incidencia.R2_INC_TXT_PIR_AR_Station_Code__c!='' && incidencia.R2_INC_TXT_PIR_AR_Airline_Code__c!=null && incidencia.R2_INC_TXT_PIR_AR_Airline_Code__c!='' && incidencia.R2_INC_TXT_PIR_AR_Reference_Number__c!=null && incidencia.R2_INC_TXT_PIR_AR_Reference_Number__c!=''){
                    recordRefer.stationCode = bag.R2_BAG_TXT_PIR_AR__c.subString(0, 2);
                    recordRefer.airlineCode = bag.R2_BAG_TXT_PIR_AR__c.subString(2, 4);
                    recordRefer.referenceNumber = bag.R2_BAG_TXT_PIR_AR__c.subString(4);
                    assoc.recordType = bag.R2_BAG_TXT_RecordType_PIR_AR__c;
                    assoc.recordReference = recordRefer;

                    damageBag.associatedRecord = assoc;
                }
                
                
                damageBag.seq = String.valueOf(i+1);
                
                
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
            rc = rc.removeEnd('/');
            if (requestWR.claim == null) { requestWR.claim = new R2_CLS_WT_Wrappers_Modify_Damaged.Claim(); }
            requestWR.claim.lossComments = rc;
        }
        requestWR.damagedBagGroup = damageBagGroup;
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolEnabled: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    19/12/2017             Alberto Puerto Collado                  Initial Version
    16/02/2018              Alvaro Garcia Tapia                     Add boolean to check if prorrateo is not OK and only need to change the flight and the route
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolEnabled(){
        boolCambiaEscala  = false;
        boolReabrir = false;
        boolCloseEnabled = false;
        if(boolEnabled){
            boolEnabled = false;
            System.debug('switchBoolEnabled = true cambiado a ' + boolEnabled);
        }else{
            boolEnabled = true;
            System.debug('switchBoolEnabled = false cambiado a ' + boolEnabled);
        }
        ///Prorrateos 16/02/2018
        List<R2_Prorrateo__c> pro = [SELECT Id, R2_PRO_PKL_Status__c FROM R2_Prorrateo__c WHERE R2_PRO_LOO_PIR__c = :incidenciaId AND R2_PRO_PKL_Status__c = 'Prorrateo a Revisar' LIMIT 1];
        if (!pro.isEmpty()) {
            if(boolModifyEnabled){
                boolModifyEnabled = false;
                System.debug('switchboolModifyEnabled = true cambiado a ' + boolModifyEnabled);
            }else{
                boolModifyEnabled = true;
                System.debug('switchboolModifyEnabled = false cambiado a ' + boolModifyEnabled);
            }
        }
        ///////////////////////
        leerSecciones();
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolCambiaEscala: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/12/2017             Alberto Puerto Collado                  Initial Version
    16/02/2018             Alvaro Garcia Tapia                     Add Prorrateos
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolCambiaEscala(){
        boolEnabled  = false;
        boolReabrir = false;
        boolCloseEnabled = false;
        boolModifyEnabled = false; ///Prorrateos 16/02/2018
        if(boolCambiaEscala){
            boolCambiaEscala = false;
            System.debug('switch boolCambiaEscala = true cambiado a ' + boolCambiaEscala);
        }else{
            boolCambiaEscala = true;
            System.debug('switch boolCambiaEscala = false cambiado a ' + boolCambiaEscala);
        }
        leerSecciones();
        newStation = '';
        newAirline = '';
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolReabrir: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/12/2017             Alberto Puerto Collado                  Initial Version
    16/02/2018             Alvaro Garcia Tapia                     Add Prorrateos
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolReabrir(){
        boolEnabled  = false;
        boolCambiaEscala = false;
        boolCloseEnabled = false;
        boolModifyEnabled = false; ///Prorrateos 16/02/2018
        if(boolReabrir){
            boolReabrir = false;
            System.debug('switchBoolReabrir = true cambiado a ' + boolReabrir);
        }else{
            boolReabrir = true;
            System.debug('switchBoolReabrir = false cambiado a ' + boolReabrir);
        }
        leerSecciones();
        newStation = '';
        newAirline = '';
    }
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolCloseEnabled: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    17/01/2018             Alberto Puerto Collado                  Initial Version
    02/02/2018             Alberto Puerto Collado                  Create one payment automatically
    16/02/2018             Alvaro Garcia Tapia                     Add Prorrateos
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolCloseEnabled(){
        boolEnabled  = false;
        boolCambiaEscala = false;
        boolReabrir = false;
        boolModifyEnabled = false; ///Prorrateos 16/02/2018
        if(boolCloseEnabled){
            boolCloseEnabled = false;
            System.debug('switchboolCloseEnabled = true cambiado a ' + boolCloseEnabled);
        }else{
            boolCloseEnabled = true;
            System.debug('switchboolCloseEnabled = false cambiado a ' + boolCloseEnabled);
            modifyDPRpreClose();
            //insertDummyPayment(this.incidenciaId);
        }
        leerSecciones();
        newStation = '';
        newAirline = '';
    }
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    helper to read sections, called from several methods
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/12/2017             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
    public void leerSecciones(){
        incidentInformationSection1 = getIncidentInformation('1'); incidentInformationSection2 = getIncidentInformation('2');
        incidentInformationSection3 = getIncidentInformation('3'); incidentInformationSection4 = getIncidentInformation('4'); incidentInformationSection5 = getIncidentInformation('5');
        incidentInformationSection6 = getIncidentInformation('6'); incidentInformationSection7 = getIncidentInformation('7'); incidentInformationSection8 = getIncidentInformation('8');
        incidentInformationSection9 = getIncidentInformation('9'); incidentInformationSection10 = getIncidentInformation('10');
    }
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    helper: reset initial variables
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/12/2017             Alberto Puerto Collado                  Initial Version
    16/02/2018             Alvaro Garcia Tapia                     Add Prorrateos
 ----------------------------------------------------------------------------------------------------------------------*/
    public void resetBooleanos(){
        boolEnabled = false;
        boolCambiaEscala = false;
        boolReabrir = false;
        boolCloseEnabled = false;
        newStation = '';
        newAirline = '';
        boolModifyEnabled = false;///Prorrateos 16/02/2018
        newFlight = '';///Prorrateos 16/02/2018
        newRoute = '';///Prorrateos 16/02/2018
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    fill a map with the values of the lookup fields filled in the visual
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    01/02/2018             Alvaro Garcia Tapia                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
    public void getLookupField(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            R1_Incident__c inc = new R1_Incident__c();
            inc.Id = incidenciaId;
            for (Field auxField: incidentInformationSection1) {
                if (auxField.name.contains('_LOO_')) {
                    inc.put(auxField.Name, auxField.incident.get(auxField.Name));
                }
            }
            System.debug('inc: ' + inc);
            update inc;

            //POsibles mejoras futuras, pasando unicamente el valor a modificar
            //R1_Incident__c inc = new R1_Incident__c();
            //inc.Id = incidenciaId;
            //System.debug('api: ' + api);
            //System.debug('value: ' + value);
            //inc.put(api, value);
            //update inc;

            //Si en algun momento se hace que los lookup se guarden al modificar en vez cada vez que se pone un nuevo valor
            //if (lookupValuesMap == null) {
            //    lookupValuesMap = new Map<String,String>();
            //}
            //lookupValuesMap.put(api,value);

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Info_PIR_DamagedController.getLookupField', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }  
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

            incidencia = [SELECT ID, Name, RecordType.DeveloperName, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c, R2_INC_TXT_PIR_AR_Reference_Number__c FROM R1_Incident__c WHERE ID = :incidenciaID LIMIT 1];
           
           imgMaletaVacia = 'ImagenesMaletas/maleta-vacia.gif';
           imgMaletaON = 'ImagenesMaletas/maleta-on.gif';
           imgMaletaLlena = 'ImagenesMaletas/maleta-llena.gif';
            
           tipoCont = '';
           desCont = '';
           System.debug('!!!MaletaVacia: ' + imgMaletaVacia);
           //System.debug('!!!mapType: ' + mapType);
           
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
                    
                    if(bagLst.size()>=1){
                        verSaveUpdate = true;
                        bagMostrar(0);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta1 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=2){  
                        verSaveUpdate = true;
                        bagMostrar(1);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta2 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=3){
                        verSaveUpdate = true;
                        bagMostrar(2);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta3 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=4){
                        verSaveUpdate = true;
                        bagMostrar(3);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta4 = imgMaletaOn;
                        
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
                    
                    if(bagLst.size()>=5){
                        verSaveUpdate = true;
                        bagMostrar(4);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta5 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=6){
                        verSaveUpdate = true;
                        bagMostrar(5);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta6 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=7){
                        verSaveUpdate = true;
                        bagMostrar(6);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta7 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=8){
                        verSaveUpdate = true;
                        bagMostrar(7);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta8 = imgMaletaOn;
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
                    
                    if(bagLst.size()>=9){
                        verSaveUpdate = true;
                        bagMostrar(8);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta9 = imgMaletaOn;
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

                    if(bagLst.size()>=10){
                        verSaveUpdate = true;
                        bagMostrar(9);
                        getBagImageTipo();
                        getBagImageColor();
                        imgMaleta10 = imgMaletaOn;
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
            
            if(bag.R2_BAG_DATH_Bag_SentToCustoms__c!=null){
                fecha1 = String.valueOf(bag.R2_BAG_DATH_Bag_SentToCustoms__c.day()) + '/' + String.valueOf(bag.R2_BAG_DATH_Bag_SentToCustoms__c.month()) + '/' + String.valueOf(bag.R2_BAG_DATH_Bag_SentToCustoms__c.year()) + ' - ' + String.valueOf(bag.R2_BAG_DATH_Bag_SentToCustoms__c.time());
            }
            if(bag.R2_BAG_DAT_Suitcase_delivery_date__c!=null){
                fecha2 = String.valueOf(bag.R2_BAG_DAT_Suitcase_delivery_date__c);
            }
            if(bag.R2_BAG_DAT_Scheduled_delivery_date__c!=null){
                fecha3 = String.valueOf(bag.R2_BAG_DAT_Scheduled_delivery_date__c);
            }
			if(bag.R2_BAG_DAT_Distribution_conf_date__c!=null){
                fecha4 = String.valueOf(bag.R2_BAG_DAT_Distribution_conf_date__c);
            }
            if(bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c!=null){
                fecha5 = String.valueOf(bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c.day()) + '/' + String.valueOf(bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c.month()) + '/' + String.valueOf(bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c.year()) + ' - ' + String.valueOf(bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c.time());
            }
            
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
14/09/2017                 Rubén Pingarrón Jerez                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
    public void newBag(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            System.debug('LaBagNueva:' + bag);
            
            if(actionBag == 'save'){
                bag.R2_BAG_MSDT_Incident__c = incidenciaID;
                bagLst.add(bag);
                maletaSelect = totalMaletas;
                actionBag = 'save';    
				verSaveUpdate = true;     
                
            }else if(actionBag == 'update'){
                if(bag.R2_BAG_MSDT_Incident__c==null){
                    bag.R2_BAG_MSDT_Incident__c = incidenciaID;
                }
                bagLst.add(maletaSelect + 1, bag);
                bagLst.remove(maletaSelect);
                actionBag = 'update';
                
            }
            getBagImageTipo();
            getBagImageColor();
            cargarVisual();    
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_BagInformationController.newBag()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }

}