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
    14/11/2017                               
 ----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_INC_InactiveDelayedController {
    
    private Integer maletaSelect = 0;
    private Integer totalMaletas;
    private Map<String, String> mapType;

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
    public R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord registro{get;set;}
    public List <R2_WT_RetiredDelayedBagsUpdate.WarningType> warnings{get;set;}
    public List <R2_WT_RetiredDelayedBagsUpdate.ErrorType> errors{get;set;}
    public String errorResponse{get;set;} //{errorResponse = '1';}
    public Boolean boolEnabled{get;set;}
    public Boolean boolCambiaEscala{get;set;}
    public Boolean boolReabrir{get;set;}
    public String newStation{get;set;} 
    public String newAirline{get;set;} 

    ///////////Prorrateos ////////// 16/02/2018
    public Boolean boolModifyEnabled{get;set;}
    public String newFlight {get;set;}
    public String newRoute {get;set;}
    public String actFlight {get;set;}
    public String actRoute {get;set;}
    //////////////////////////////

    private final Set<String> nonUpdateableFields = new Set<String> {'R2_INC_TXT_PIR_Last_name__c', 'R2_INC_TXT_PIR_Last_name2__c','R2_INC_TXT_PIR_Name__c','R2_INC_FOR_PIR__c', 'R2_INC_DAT_PIR_Claim_Date__c', 'R2_INC_DAT_PIR_Last_mapping_date__c','R2_INC_LOO_Case__c', 'R2_INC_DAT_PIR_Search_start_date__c', 'R2_PIR_DAT_PIR_Full_reintegration_date__c', 'R2_INC_TXT_PIR_Control_office__c','R2_INC_NUM_PIR_Associated_Cases__c', 'R2_INC_DAT_PIR_Cancellation_date__c', 'R2_INC_DAT_PIR_Date_back_primary_search__c', 'R2_INC_DAT_PIR_Control_date__c','R2_INC_DAT_PIR_Unsuccessful_search__c', 'R2_INC_DATH_PIR_Incidence_closed_date__c', 'R2_INC_TXT_PIR_Agent__c', 'R2_INC_TXT_PIR_Report_PIR__c', 'R2_INC_TXT_PIR_VIP_Account__c', 'R2_INC_PKL_PIR_Status_incidence__c', 'R2_INC_DAT_PIR_Claims_Created_Date__c','R2_INC_TXT_PIR_Station_Code__c', 'R2_INC_TXT_PIR_Airline_Code__c', 'R2_INC_FOR_PIR_AR__c'};
//R2_INC_TXT_PIR_Responsible_Scale__c, R2_INC_TXT_PIR_Stop_and_Operator_MS__c -> sí updateables de section 1


    public class Field{
        public String label {get;set;}
        public String value {get;set;}
        public String oldValue {get;set;}
        public String name {get;set;}
        public String isEnabled {get;set;}
        public String type {get; set;}
    }

    public List<R2_Auxiliar_Data_Incident__c> auxiliarDataLst{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> userCommentsUC{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> observationsFF{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> deliveryServiceDS{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> deliveryInformationDY{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> baggageDestinyDB{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> damageCostCR{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> messagesMG{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> matchMR{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> smsInfoSM{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> internetInfoIR{get;set;}
    public List<R2_Auxiliar_Data_Incident__c> emailInfoER{get;set;}

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
    
    {incidenciaId = Apexpages.currentPage().getParameters().get('id');
    auxiliarDataLst = [SELECT R2_ADI_TXT_UC_User_Comment__c, R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c, 
                                R2_ADI_ATXTL_ER_Email_Info__c, R2_ADI_ATXTL_IR_Internet_Info__c, R2_ADI_ATXTL_SM_SMS_Info__c, R2_ADI_ATXTL_MR_Match__c, 
                                R2_ADI_ATXTL_MG_Message__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_PKL_Type__c, R2_ADI_MSDT_Incident__c, 
                                R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_FOR_XR_Record_Reference__c, R2_ADI_TXT_XR_Reference_Number__c, R2_ADI_TXT_XR_Station_Code__c, 
                                R2_ADI_TXT_BR_ARNK__c, R2_ADI_TXT_BR_Airline_Code__c, R2_ADI_TXT_BR_Flight_number__c, R2_ADI_DAT_BR_Flight_Date__c 
                                FROM R2_Auxiliar_Data_Incident__c 
                                WHERE R2_ADI_MSDT_Incident__c = :incidenciaId];
    errorResponse ='test'; boolEnabled = false; boolCambiaEscala = false; boolReabrir = false; newStation = ''; newAirline = '';
    boolModifyEnabled = false; newFlight = ''; newRoute = ''; actFlight = ''; actRoute = ''; ///Prorrateos 16/02/2018
    incidentInformationSection1 = getIncidentInformation('1'); incidentInformationSection2 = getIncidentInformation('2');
    incidentInformationSection3 = getIncidentInformation('3'); incidentInformationSection4 = getIncidentInformation('4'); incidentInformationSection5 = getIncidentInformation('5');
    incidentInformationSection6 = getIncidentInformation('6'); incidentInformationSection7 = getIncidentInformation('7'); incidentInformationSection8 = getIncidentInformation('8');
    incidentInformationSection9 = getIncidentInformation('9'); incidentInformationSection10 = getIncidentInformation('10');userCommentsUC = userComments();
    observationsFF = observations(); deliveryServiceDS = deliveryService(); deliveryInformationDY = deliveryInformation(); baggageDestinyDB = baggageDestiny(); 
    damageCostCR = damageCost(); messagesMG = messages(); matchMR = match(); smsInfoSM = smsInfo(); internetInfoIR = internetInfo(); emailInfoER = emailInfo();}

    /*public void setKeyAux(String keyAux1){
        System.debug('##RP## keyAux: ' + keyAux);
        keyAux = keyAux1;
    }
    public void setValueAux(String valueAux){
        this.valueAux = valueAux;
    }*/


    //private Map<String, String> mapField;
    //public List<Field> incidentInformationSection1;

    public R2_CLS_INC_InactiveDelayedController(ApexPages.StandardController controller){
        Id incID = controller.getId();
        lstBagsInicial =  [SELECT Id, Name, R2_BAG_TXT_Ticket_number__c, R2_BAG_FOR_Colour_Type_Description__c, R2_BAG_PKL_Type__c, R2_BAG_PKL_Colour__c, R2_BAG_ATXTE_Type__c,
                           R2_BAG_TXT_Brand_Info__c, R2_BAG_CHK_Content_exists__c, R2_BAG_MSDT_Incident__c, R2_BAG_TXT_Damage_detail__c, R2_BAG_TXT_Aditional_damage_information__c,
                           R2_BAG_NUM_Age__c, R2_BAG_DAT_Suitcase_delivery_date__c, R2_BAG_TXT_Value_and_coin__c, R2_BAG_DAT_Suitcase_receive_date__c,
                           R2_BAG_TXT_bagNewRoute__c, R2_BAG_TXT_bagRoute__c, R2_BAG_TXT_BagFlight__c, R2_BAG_TXT_BagNewFlight__c, R2_BAG_DAT_Distribution_conf_date__c,
                           R2_BAG_DAT_Scheduled_delivery_date__c, R2_BAG_DAT_Distribution_date__c, R2_BAG_TXT_Comments__c, R2_BAG_TXT_RUSH_label__c, R2_BAG_CHK_Mixed__c,
                           R2_BAG_CHK_Leather__c, R2_BAG_CHK_Metal__c, R2_BAG_CHK_Rigid__c, R2_BAG_CHK_Printed_fabric__c, R2_BAG_CHK_Single_object_in_box__c, R2_BAG_TXT_PIR_AR__c,
                           R2_BAG_CHK_Suitcase_allowed_cabin__c, R2_BAG_CHK_Combination_lock__c, R2_BAG_CHK_Retractable_handle__c, R2_BAG_CHK_External_pockets__c, R2_BAG_TXT_RecordType_PIR_AR__c,
                           R2_BAG_CHK_Wheels_or_bearing__c, R2_BAG_CHK_Safety_belt__c, R2_BAG_CHK_BagTag_Suspended__c, R2_BAG_TXT_Damage2_scale__c, R2_BAG_TXT_ROH_result__c,
                           R2_BAG_TXT_Damage1_coding__c, R2_BAG_TXT_Damage_1_Location__c, R2_BAG_TXT_Damage1_scale__c, R2_BAG_TXT_Damage2_coding__c, R2_BAG_TXT_Damage_2_Location__c,
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
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of user comments
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> userComments() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            //auxiliarDataLst = [SELECT R2_ADI_TXT_UC_User_Comment__c, R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c, 
            //                    R2_ADI_ATXTL_ER_Email_Info__c, R2_ADI_ATXTL_IR_Internet_Info__c, R2_ADI_ATXTL_SM_SMS_Info__c, R2_ADI_ATXTL_MR_Match__c, 
            //                    R2_ADI_ATXTL_MG_Message__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_PKL_Type__c, R2_ADI_MSDT_Incident__c, 
            //                    R2_ADI_TXT_XR_Airline_Code__c, R2_ADI_FOR_XR_Record_Reference__c, R2_ADI_TXT_XR_Reference_Number__c, R2_ADI_TXT_XR_Station_Code__c, 
            //                    R2_ADI_TXT_BR_ARNK__c, R2_ADI_TXT_BR_Airline_Code__c, R2_ADI_TXT_BR_Flight_number__c, R2_ADI_DAT_BR_Flight_Date__c 
            //                    FROM R2_Auxiliar_Data_Incident__c 
            //                    WHERE R2_ADI_MSDT_Incident__c = :incidenciaId];
            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'UC') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.userComments', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of observations
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> observations() { 
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'FF') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.observations', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of delivery service
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> deliveryService() {   
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'DS') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.deliveryService', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of delivery information
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> deliveryInformation() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'DY') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.deliveryInformation', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of baggage destiny
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> baggageDestiny() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'DB') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.baggageDestiny', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of damage cost
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> damageCost() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'CR') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.damageCost', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of messages
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> messages() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'MG') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.messages', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of match
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> match() {
         try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'MR') {
                        resultLst.add(aux);
                    }
                }
            }
            System.debug('auxiliarDataLst: ' + auxiliarDataLst);
            System.debug('match: ' + resultLst);
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.match', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of internet Info
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> internetInfo() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'IR') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.internetInfo', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of sms info
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> smsInfo() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'SM') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.smsInfo', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
        }    
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Create a list with the record that has information of email Info
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    09/01/2018             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public List<R2_Auxiliar_Data_Incident__c> emailInfo() {
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            List<R2_Auxiliar_Data_Incident__c> resultLst = new List<R2_Auxiliar_Data_Incident__c>();
            if (!auxiliarDataLst.isEmpty()) {
                for (R2_Auxiliar_Data_Incident__c aux : auxiliarDataLst) {
                    if (aux.R2_ADI_PKL_Type__c == 'ER') {
                        resultLst.add(aux);
                    }
                }
            }
            return resultLst;            
        }
        catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.emailInfo', 'error al crear la lista con los comentarios de usuarios del objeto R2_Auxiliar_Data_Incident__c', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Auxiliar_Data_Incident__c');
            return null;
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
            /*'R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, */'R2_INC_FOR_PIR_AR__c';//, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c';
            fields2 = 'R2_ADI_FOR_XR_Record_Reference__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('2')){
            fields = 'R2_INC_TXT_PIR_Treatment__c, R2_INC_TXT_PIR_Name__c, R2_INC_TXT_PIR_Last_name__c, R2_INC_TXT_PIR_Last_name2__c, ' + 
            'R2_INC_TXT_PIR_FF_Identificator__c, R2_INC_TXT_PIR_Initial__c, R2_INC_TXT_PIR_Initial2__c, R2_INC_TXT_PIR_Initial3__c, ' +
            'R2_INC_TXT_PIR_Passenger_language__c, R2_INC_TXT_PIR_Passenger_category__c, R2_INC_EMA_PIR_Email1__c, R2_INC_EMA_PIR_Email2__c, ' +
            'R2_INC_TXT_PIR_Delivery_address1__c, R2_INC_TXT_PIR_Delivery_address2__c, R2_INC_TXT_PIR_Delivery_local_informatio__c, R2_INC_TXT_PIR_Deliver_local_informatio2__c, ' +
            'R2_INC_TXT_PIR_PNR_locator__c, R2_INC_TXT_PIR_Ticket_number__c, R2_INC_TXT_PIR_Send_SMS_email__c';

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
            fields = 'R2_INC_TXT_PIR_flight_Number__c, R2_INC_TXT_PIR_Route__c, R2_INC_TXT_PIR_Aditional_Route__c, R2_INC_TXT_PIR_Baggage_route__c';
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
            'R2_INC_TLF_PIR_Phone_number_suitcase2__c, R2_INC_CHK_PIR_Limited_approval_label__c';//, R2_ADI_TXT_DB_baggage_Destination__c';
            fields2 = 'R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_TXT_DB_baggage_Destination__c';

            query = 'SELECT Id, Name, '+fields+' FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
            query2 = 'SELECT Id, Name, '+fields2+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c=\''+ApexPages.currentPage().getParameters().get('id')+'\' LIMIT 1';
        }
        else if(section.equals('8')){
            //fields = fieldsSection3;
            fields = /*R2_INC_TXT_PIR_Shared_code__c, */'R2_INC_CHK_PIR_Baggage_insurance__c, R2_INC_TXT_PIR_Lost_reason__c, R2_INC_CHK_PIR_Repair_suitcase__c, '+
            'R2_INC_TXT_PIR_Special_lost_reason__c, R2_INC_CHK_PIR_Replace_suitcase__c, R2_INC_TXT_PIR_Lost_reason_causes__c, R2_INC_TXT_PIR_Washing_kit__c, '+
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
            System.debug('No existe en la bbdd, llamar a World Tracer');
            System.debug(e);
        }
        return getIncidentFields(result, fields, result2, fields2, boolEnabled);
    }

    //private String getType(Schema.DisplayType type) {
    //    if (type == Schema.DisplayType.Date) {
    //        return 'DATE';
    //    }else if (type == Schema.DisplayType.Integer) {
    //        return 'NUMBER';
    //    }else if (type == Schema.DisplayType.DateTime) {
    //        return 'DATETIME';
    //    }else if (type == Schema.DisplayType.Phone) {
    //        return 'TEL';
    //    }else if (type == Schema.DisplayType.Picklist) {
    //        return 'PICKLIST';
    //    }else if (type == Schema.DisplayType.Boolean) {
    //        return 'CHECKBOX';
    //    }else {
    //        return 'TEXT';
    //    }
    //}

    public List<Field> getIncidentFields(R1_Incident__c pir, String fields, R2_Auxiliar_Data_Incident__c adi, String fields2, Boolean boolEnabled){ //
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
            //recorremos los campos del objeto Incidencia
            for(String field : listFields){
                if (field != '' ) {
                    fieldObject = new Field();
                    System.debug('!!!!!field: '+field);

                    //emular el .type añadido --Nota. borrar después estas dos líneas
                    //fieldObject.type = getType(describeFieldResult.getType());

                    //System.debug('!!!!!pir.get(field): '+pir.get(field));
                    //if (pir.get(field) != null) {
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
                    }else if (field.contains('R2_ADI_FOR_XR_Record_Reference__c') || field.contains('R2_ADI_TXT_CR_Remarks_Cost__c')
                            || field.contains('R2_ADI_ATXTL_MG_Message__c') || field.contains('R2_ADI_ATXTL_MR_Match__c')
                            || field.contains('R2_ADI_TXT_FF_Observation__c') || field.contains('R2_ADI_TXT_UC_User_Comment__c')
                            || field.contains('R2_ADI_ATXTL_DS_Delivery_service__c') || field.contains('R2_ADI_TXT_DB_baggage_Destination__c') ) { 
                        fieldObject.value = String.valueOf((String)pir.get(field));    
                        fieldObject.oldValue = String.valueOf((String)pir.get(field)); 
                        fieldObject.type = 'button'; 
                    }else{
                        fieldObject.value = (String)pir.get(field);
                        fieldObject.oldValue = (String)pir.get(field);
                        fieldObject.type = 'text';
                    }      
                    fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
                    fieldObject.name = field;


                    if(boolEnabled){
                        //update enable/disable fields 
                        //-> R2_INC_TXT_PIR_Stop_and_Operator_MS__c 
                        //R2_INC_DAT_PIR_Claims_Created_Date__c
                        System.debug('::::nonUpdateableFields.contains(fieldObject.name|||'+nonUpdateableFields.contains(fieldObject.name));
                        System.debug('::::fieldObject.name'+field);
                        System.debug('fieldObject.value'+fieldObject.value);
                            System.debug('::::nonUpdateableFields!!!!'+nonUpdateableFields);
                            System.debug(':::busca y encuentra arriba, play!'+fieldObject.name);
                        if(nonUpdateableFields.contains(fieldObject.name)){
                            System.debug('boolenabled = true y SI en nonUpdateableFields .> isEnabled = true');
                            fieldObject.isEnabled = 'true';
                        }else{
                            fieldObject.isEnabled = 'false';
                            System.debug('fieldObject = true y NOOOOOOOO nonupdateableFields .> isEnabled = false');
                        } 
                    }else{
                        fieldObject.isEnabled = 'true';
                        System.debug('fieldObject = false .> isEnabled = true');
                    }
                    
                    
                    System.debug(fieldObject);
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
                //recorremos los campos del objeto ADI
                for(String field : listFields2){
                    if (field != '' ) {
                        fieldObject2 = new Field();
                        System.debug('!!!!!field2: '+field);
                        //System.debug('!!!!!adi.get(field2): '+adi.get(field2));
                        //if (adi.get(field2) != null) {
                        if (field.contains('_DATH_')) {   
                            fieldObject2.value = String.valueOfGmt((Datetime)adi.get(field));
                            fieldObject2.oldValue = String.valueOfGmt((Datetime)adi.get(field));      
                        }
                        else if (field.contains('_DAT_')) {    
                            fieldObject2.value = String.valueOf((Date)adi.get(field));
                            fieldObject2.oldValue = String.valueOf((Date)adi.get(field));      
                        }
                        else if (field.contains('_CHK_')) { 
                            fieldObject2.value = String.valueOf((Boolean)adi.get(field));
                            fieldObject2.oldValue = String.valueOf((Boolean)adi.get(field));
                        }
                        else{
                            fieldObject2.value = (String)adi.get(field);
                            fieldObject2.oldValue = (String)adi.get(field);
                        }      fieldObject2.label = fieldMap2.get(field).getDescribe().getLabel();
                        fieldObject2.name = field;


                        if(boolEnabled){
                            //update enable/disable fields 
                            if(nonUpdateableFields.contains(fieldObject2.name)){
                                fieldObject2.isEnabled = 'true';
                            }else{
                                fieldObject2.isEnabled = 'false';
                            } 
                        }else{
                            fieldObject2.isEnabled = 'true';
                        }
                        
                        System.debug(fieldObject2);
                        incidencias.add(fieldObject2);
                        //mapField.put(fieldObject2.name, fieldObject2.value);
                    }
                    
                }
            }
            
            System.debug(incidencias);
            //System.debug('!!!!mapa fields: ' + mapField);
            return incidencias;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.getIncidentFields', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    public String getIncidentHeader(){
        String query = 'SELECT Id, Name, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE Id=\''+ApexPages.currentPage().getParameters().get('id')+'\'';
        System.debug(query);
        R1_Incident__c result = null;
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            result = Database.query(query);
        }catch(Exception e){
            System.debug('No existe en la bbdd, llamar a World Tracer');
            System.debug(e);
        }
        return 'PIR: '+result.Name+' : '+result.R2_INC_FOR_PIR__c;
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    close pir delayed
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void closeCAH(){      
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            Id resId;        

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
                R2_CLS_WT_Bags_Management.WR_CloseDelayed_CAH_Request requestWR = new R2_CLS_WT_Bags_Management.WR_CloseDelayed_CAH_Request();
                R2_CLS_WT_Bags_Management.AssociatedRecord record = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                //R2_CLS_WT_Bags_Management.RecordReference recordReference = new R2_CLS_WT_Bags_Management.RecordReference();
                R2_CLS_WT_Bags_Management.DeliveryType deliveryInfo = new R2_CLS_WT_Bags_Management.DeliveryType();
                R2_CLS_WT_Bags_Management.RecordIdentifier associated;
                List<R2_CLS_WT_Bags_Management.RecordIdentifier> lstAssociated = new List<R2_CLS_WT_Bags_Management.RecordIdentifier>();
                R2_CLS_WT_Bags_Management.RecordReference crossRecord; 
                //R2_CLS_WT_Bags_Management.NewRecordType recordType = new R2_CLS_WT_Bags_Management.NewRecordType();

                //CLAIMS WRAPPERS INSTANCES
                R2_CLS_WT_Bags_Management.Amount amount;// = new R2_CLS_WT_Bags_Management.Amount();
                R2_CLS_WT_Bags_Management.PassengerPayment passengerPayment;// = new R2_CLS_WT_Bags_Management.PassengerPayment();
                R2_CLS_WT_Bags_Management.ClaimAmount claimAmount = new R2_CLS_WT_Bags_Management.ClaimAmount();
                R2_CLS_WT_Bags_Management.PassengerPayments passengerPayments = new R2_CLS_WT_Bags_Management.PassengerPayments();
                R2_CLS_WT_Bags_Management.PartnerCode partnerCode = new  R2_CLS_WT_Bags_Management.PartnerCode();
                R2_CLS_WT_Bags_Management.ToilerKits toilerKits = new R2_CLS_WT_Bags_Management.ToilerKits();
                R2_CLS_WT_Bags_Management.ExcessValue excessValue = new R2_CLS_WT_Bags_Management.ExcessValue();
                R2_CLS_WT_Bags_Management.ClaimData claimData = new R2_CLS_WT_Bags_Management.ClaimData();
                R2_CLS_WT_Bags_Management.Claim claim = new R2_CLS_WT_Bags_Management.Claim();
                List<R2_CLS_WT_Bags_Management.PassengerPayment> lstPasgrs = new List<R2_CLS_WT_Bags_Management.PassengerPayment>();
                List<R2_CLS_WT_Bags_Management.SupplementaryInfoType> lstSupplement = new List<R2_CLS_WT_Bags_Management.SupplementaryInfoType>();
                //Amount
                for(Integer i = 0; i< lstADIs.size(); i++){
                    if (lstADIs[i].R2_ADI_NUM_CS_Amount__c != null && lstADIs[i].R2_ADI_NUM_CS_Amount__c >= 0 && lstADIs[i].R2_ADI_TXT_CS_Currency__c != null && lstADIs[i].R2_ADI_PKL_CS_Cost_Type__c != null) {
                        passengerPayment = new R2_CLS_WT_Bags_Management.PassengerPayment();
                        amount = new R2_CLS_WT_Bags_Management.Amount();
                        amount.amountValue = (Integer)lstADIs[i].R2_ADI_NUM_CS_Amount__c;   
                        amount.currencyCode = lstADIs[i].R2_ADI_TXT_CS_Currency__c;  
                        amount.decimalPlace = (Integer)lstADIs[i].R2_ADI_NUM_Decimal_Place__c ;
                        passengerPayment.costType = lstADIs[i].R2_ADI_PKL_CS_Cost_Type__c;
                        passengerPayment.seq = i + 1; 

                        passengerPayment.amount = amount;
                        lstPasgrs.add(passengerPayment);
                    }
                    else if (lstADIs[i].R2_ADI_TXT_XR_Station_Code__c != null && lstADIs[i].R2_ADI_TXT_XR_Station_Code__c != ''){
                        associated = new R2_CLS_WT_Bags_Management.RecordIdentifier();
                        crossRecord = new R2_CLS_WT_Bags_Management.RecordReference();
                        associated.recordType = inci[0].RecordType.DeveloperName;
                        crossRecord.stationCode = lstADIs[i].R2_ADI_TXT_XR_Station_Code__c;
                        crossRecord.airlineCode = lstADIs[i].R2_ADI_TXT_XR_Airline_Code__c;
                        crossRecord.referenceNumber = lstADIs[i].R2_ADI_TXT_XR_Reference_Number__c;
                        associated.recordReference = crossRecord;
                        lstAssociated.add(associated);
                    }  
                }

                //////Rellenar el lstSupplement
                
                passengerPayments.passengerPayment = lstPasgrs;
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
                claimData.costRemarks = new List<String>();
                claimData.payments = passengerPayments;
                //claimData.claimDate = inci[0].R2_INC_DAT_PIR_Claims_Created_Date__c;
                //claimData.notifiedDate = inci[0].R2_INC_DAT_PIR_Date_Notified__c;
                //claimData.questionnaireDate = inci[0].R2_INC_DAT_PIR_Questionnaire_Date__c;
                //claimData.faultStation = inci[0].R2_INC_TXT_PIR_Responsible_Scale__c; ///dentro del for 
                claimData.faultTerminal = inci[0].R2_INC_TXT_PIR_Responsible_Terminal__c; //no puede ser nulo
                //claimData.insurance = inci[0].R2_INC_CHK_PIR_Baggage_insurance__c;
                //claimData.liabilityTagIndicator = inci[0].R2_INC_CHK_PIR_Limited_approval_label__c;
                //claimData.missingBags = '';
                //claimData.partnerCode = partnerCode;
                //Rellenamos los campos con los nuevos valores de station type y airline type
                for (Field field :IncidentInformationSection1) {
                    System.debug('field: '+ field);
                    if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
                        claimData.faultStation = field.value;
                    }

                    if (claimData.faultStation != null && claimData.faultStation != '') {
                        break;
                    }
                }
                for (Field field :IncidentInformationSection8) {
                    System.debug('field: '+ field);
                    if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
                        claimData.lossReasonCode = field.value;
                    }

                    if (claimData.lossReasonCode != null && claimData.lossReasonCode != '') {
                        break;
                    }
                }    
                
                claimData.lossComments = inci[0].R2_INC_TXT_PIR_Lost_reason_causes__c;
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
                //record.recordType = inci[0].RecordType.DeveloperName;
                //associatedRecord.recordType = inci[0].RecordType.DeveloperName;//'DELAYED';
                //associatedRecord.recordReference = '';
            

                //record.recordReference = recordReference;
                //record.recordType = inci[0].RecordType.DeveloperName;
                //NewRecordType
                //recordType.recordType = 'DELAYED';
                //recordType.recordReference = associatedRecord;

                //WR_CloseDelayed_CAH_Request
                requestWR.record = record;
                requestWR.claim = claimData;
                requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias; 
                requestWR.supplementalInfo = lstSupplement;
                requestWR.crossReferenceRecord = lstAssociated;
                requestWR.handledAirlineCopy = inci[0].R2_INC_PKL_PIR_Copy_for_the_company_HC__c;

                String jsonData = JSON.serialize(requestWR);

                System.debug('*** jsonData: ' + jsonData);

                jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
                System.debug('*** jsonData: ' + jsonData);
                errorResponse = R2_CLS_WT_Bags_Management.CloseDelayedBag(jsonData, 0);
                System.debug('respuesta de errores:::::::::'+errorResponse);
                if(errorResponse.equals('1')){
                    R1_CLS_Utilities.readRecord_WT(inci[0].RecordType.DeveloperName, inci[0].R2_INC_TXT_PIR_Station_Code__c, inci[0].R2_INC_TXT_PIR_Airline_Code__c, inci[0].R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);
                //    System.debug('cerrado correctamente en WT');
                //    refreshDAH();
                }
                //else{

                //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.closeCAH', '', 'Existen warnings al cerrar el pir delayed en WT', 'R2_Incident__c');
                //}
            }
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.closeCAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    reopen pir delayed
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void reopenRCB(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            Id resId;
        
            System.debug('ANTES DE MAPEO reopenRCB');
            R2_CLS_WT_Bags_Management.WR_ReopenDelayedBagWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_ReopenDelayedBagWebRequest();
            R2_CLS_WT_Bags_Management.AssociatedRecord associatedRecord = new R2_CLS_WT_Bags_Management.AssociatedRecord();
            R2_CLS_WT_Bags_Management.NewStationAirlineType newStationAirlineType = new R2_CLS_WT_Bags_Management.NewStationAirlineType();
            R2_CLS_WT_Bags_Management.BagType bagType = new R2_CLS_WT_Bags_Management.BagType();

            List<R1_Incident__c> inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];
            // AssociatedRecord
            if(!inci.isEmpty()){
                associatedRecord.stationCode = inci[0].R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                associatedRecord.airlineCode = inci[0].R2_INC_TXT_PIR_Airline_Code__c;//'IB';
                associatedRecord.referenceNumber = inci[0].R2_INC_TXT_PIR_Reference_Number__c;//'68177';
            }
            //associatedRecord.recordType = 'DELAYED';
            //associatedRecord.recordReference = '';

            //Rellenamos los campos con los nuevos valores de station type y airline type ->> COMENTADO, ahora recogemos valores de otro input
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
            //for (Field field :IncidentInformationSection1) {
            //    if (field.name == 'R2_INC_TXT_PIR_AR_Station_Code__c') {
            //        newStationAirlineType.stationCode = field.value;
            //    }
            //    else if (field.name == 'R2_INC_TXT_PIR_AR_Airline_Code__c') {
            //        newStationAirlineType.airlineCode = field.value;
            //    }

            //    if ((newStationAirlineType.stationCode != null && newStationAirlineType.stationCode != '') && 
            //        (newStationAirlineType.airlineCode != null && newStationAirlineType.airlineCode != '')) {
            //        break;
            //    }
            //}
            System.debug('!!!CAMBIADO newStationAirlineType::'+newStationAirlineType);
            // NewStationAirlineType
            //newStationAirlineType.stationCode = 'BCN';
            //newStationAirlineType.airlineCode = 'IB';
            

            // BagType
            bagType.bagDetails = new List <R2_CLS_WT_Bags_Management.BagDetailsType>();

            // WR_ReopenDelayedBagWebRequest
            requestWR.recordReference = associatedRecord;
            requestWR.newStationAirline = newStationAirlineType;
            //requestWR.bagElements = bagType;
            requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;//resId;

            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            String responseReOpen = '';
            
            responseReOpen = R2_CLS_WT_Bags_Management.ReopenDelayedBag(jsonData, 0);
            System.debug('respuesta de responseReOpen:::::::::'+responseReOpen);
            errorResponse = responseReOpen;

            System.debug('respuesta de errorResponse:::::::::'+errorResponse);
            //System.debug('respuesta de errores:::::::::'+errorResponse); 
            //System.debug('respuesta de incidentInformationSection1:::::::::'+incidentInformationSection1);
            //return errorResponse2;
            if(errorResponse.equals('1')){
                R1_CLS_Utilities.readRecord_WT(inci[0].RecordType.DeveloperName, inci[0].R2_INC_TXT_PIR_Station_Code__c, inci[0].R2_INC_TXT_PIR_Airline_Code__c, inci[0].R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);
            //    System.debug('cerrado correctamente en WT');
            //    refreshDAH();
            }
            //if(responseReOpen.equals('1')){
            //    System.debug('Reabierto correctamente en WT');
            //    refreshDAH();
            //}else{
            //    errorResponse = responseReOpen;
            //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.reopenRCB', '', 'Existen warnings al reabrir el pir delayed en WT', 'R2_Incident__c');
            //}
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.reopenRCB', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            //return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    reassign pir delayed
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void reassignRIB(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            Id resId;
       
            System.debug('ANTES DE MAPEO reassignRIB'); //arreglar 
            R2_CLS_WT_Bags_Management.WR_ReopenDelayedBagWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_ReopenDelayedBagWebRequest();
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

            //Rellenamos los campos con los nuevos valores de station type y airline type ->> COMENTADO, ahora recogemos valores de otro input
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
            //
            newStationAirlineType.stationCode = newStation;
            newStationAirlineType.airlineCode = newAirline;


            // WR_ReopenDelayedBagWebRequest
            requestWR.recordReference = associatedRecord;
            requestWR.newStationAirline = newStationAirlineType;
            //requestWR.bagElements = bagType;
            requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias; //resId;

            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            errorResponse = R2_CLS_WT_Bags_Management.ReassignDelayedBag(jsonData, 0);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            //if(errorResponse.equals('1')){
            //    System.debug('Reasignado correctamente en WT');
            //    refreshDAH();
            //}else{

            //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.reassignRIB', '', 'Existen warnings al reabrir el pir delayed en WT', 'R2_Incident__c');
            //}
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.reassignRIB', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    suspend pir delayed
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void suspendSUS(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            Id resId;
        
            System.debug('ANTES DE MAPEO suspendSUS');

            R1_Incident__c inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];
            List<R2_Baggage__c> lstBags = [SELECT Id, R2_BAG_CHK_BagTag_Suspended__c, R2_BAG_CHK_Suspended__c, R2_BAG_CHK_BagContends_Suspended__c, R2_BAG_CHK_UniqueID_Suspended__c,
                                                R2_BAG_TXT_Brand_Info_Suspended__c
                                            FROM R2_Baggage__c 
                                            WHERE Id=:incidenciaId LIMIT 1];                                

            R2_CLS_WT_Bags_Management.WR_SuspendDelayedBagWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_SuspendDelayedBagWebRequest();
            requestWR.airlineVendorId = 'IB'; //can be harcoded (IA instructions)
            requestWR.recordtype = inci.RecordType.DeveloperName; //'DELAYED'; //can be harcoded (IA instructions)
            R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                ar.stationCode = inci.R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                ar.airlineCode = inci.R2_INC_TXT_PIR_Airline_Code__c;//'IB';
                ar.referenceNumber = inci.R2_INC_TXT_PIR_Reference_Number__c;
            requestWR.recordReference = ar;
            List<R2_CLS_WT_Bags_Management.BagElementDetailsType> lstB = new List<R2_CLS_WT_Bags_Management.BagElementDetailsType>();
            for(Integer i = 0; i<lstBags.size() ;i++){
                R2_CLS_WT_Bags_Management.BagElementDetailsType bag = new R2_CLS_WT_Bags_Management.BagElementDetailsType();
                //bag.sequence = lstBags[i].R2_BAG_TXT_TagSequence__c; //dudas
                bag.bagTag = lstBags[i].R2_BAG_CHK_BagTag_Suspended__c;//true;
                bag.bagColourAndType = lstBags[i].R2_BAG_CHK_Suspended__c;
                bag.bagContents = lstBags[i].R2_BAG_CHK_BagContends_Suspended__c;
                bag.bagUniqueId = lstBags[i].R2_BAG_CHK_UniqueID_Suspended__c;
                bag.brandCode = lstBags[i].R2_BAG_TXT_Brand_Info_Suspended__c;    
                lstB.add(bag); 
            }
            requestWR.bag = lstB;
            requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias; 

             

            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            errorResponse = R2_CLS_WT_Bags_Management.SuspendDelayedBag(jsonData, 0);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            if(errorResponse.equals('1')){
                R1_CLS_Utilities.readRecord_WT(inci.RecordType.DeveloperName, inci.R2_INC_TXT_PIR_Station_Code__c, inci.R2_INC_TXT_PIR_Airline_Code__c, inci.R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);
            //    System.debug('Suspendido correctamente en WT');
            //    refreshDAH();
            }
            //else{

            //    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.suspendSUS', '', 'Existen warnings al suspender el pir delayed en WT', 'R2_Incident__c');
            //}
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.suspendSUS', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    generate report pir delayed
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    23/11/2017             Alberto Puerto Collado                  Initial Version
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
            requestWR.recordType = 'DELAYED'; //Can be hard codes as DELAYED for all calls to SITA, as this operation is specific for delayed bag files
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
            errorResponse = R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR(jsonData, 0);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.informePIR', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }
         /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    reinstate pir delayed (opposite of suspend)
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void reinstateCFD(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
        
            Id resId;
        
            System.debug('ANTES DE MAPEO reinstateCFD');

            R1_Incident__c inci = [SELECT Id, RecordType.DeveloperName, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c 
                                            FROM R1_Incident__c 
                                            WHERE Id=:incidenciaId LIMIT 1];
            List<R2_Baggage__c> lstBags = [SELECT Id, R2_BAG_CHK_BagTag_Suspended__c, R2_BAG_CHK_Suspended__c, R2_BAG_CHK_BagContends_Suspended__c, R2_BAG_CHK_UniqueID_Suspended__c,
                                                R2_BAG_TXT_Brand_Info_Suspended__c
                                            FROM R2_Baggage__c 
                                            WHERE Id=:incidenciaId];                                

            R2_CLS_WT_Bags_Management.WR_ReinstateDelayedBagWebRequest requestWR = new R2_CLS_WT_Bags_Management.WR_ReinstateDelayedBagWebRequest();
            R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                ar.stationCode = inci.R2_INC_TXT_PIR_Station_Code__c;//'MAD';
                ar.airlineCode = inci.R2_INC_TXT_PIR_Airline_Code__c;//'IB';
                ar.referenceNumber = inci.R2_INC_TXT_PIR_Reference_Number__c;
            
            List<R2_CLS_WT_Bags_Management.BagElementDetailsType> lstB = new List<R2_CLS_WT_Bags_Management.BagElementDetailsType>();
            for(Integer i = 0; i<lstBags.size() ;i++){
                R2_CLS_WT_Bags_Management.BagElementDetailsType bag = new R2_CLS_WT_Bags_Management.BagElementDetailsType();
                //bag.sequence = lstBags[i].R2_BAG_TXT_TagSequence__c; //dudas
                bag.bagTag = lstBags[i].R2_BAG_CHK_BagTag_Suspended__c;//true;
                bag.bagColourAndType = lstBags[i].R2_BAG_CHK_Suspended__c;
                bag.bagContents = lstBags[i].R2_BAG_CHK_BagContends_Suspended__c;
                bag.bagUniqueId = lstBags[i].R2_BAG_CHK_UniqueID_Suspended__c;
                bag.brandCode = lstBags[i].R2_BAG_TXT_Brand_Info_Suspended__c;    
                lstB.add(bag); 
            }
            requestWR.airlineVendorId = 'IB'; //can be harcoded (IA instructions)
            requestWR.recordtype = inci.RecordType.DeveloperName; //'DELAYED'; //can be harcoded (IA instructions)
            requestWR.recordReference = ar;
            requestWR.bag = lstB;
            requestWR.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias; 
 
            String jsonData = JSON.serialize(requestWR);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);
            errorResponse = R2_CLS_WT_Bags_Management.ReinstateDelayedBag(jsonData, 0, inci);
            System.debug('respuesta de errores:::::::::'+errorResponse);
            if(errorResponse.equals('1')){
                R1_CLS_Utilities.readRecord_WT(inci.RecordType.DeveloperName, inci.R2_INC_TXT_PIR_Station_Code__c, inci.R2_INC_TXT_PIR_Airline_Code__c, inci.R2_INC_TXT_PIR_Reference_Number__c, 'agentId', 1);

            //    System.debug('entra if '+errorResponse);
            //    errorResponse = '1';// + inci.Id;
                //return new ApexPages.Pagereference('/' + inci.Id);
            //    System.debug('Convertido correctamente en WT');
            //    refreshDAH();
            }
            //else{
            //    return null;
            ////    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.reinstateCFD', '', 'Existen warnings al convertir el pir delayed en WT', 'R2_Incident__c');
            //}
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.reinstateCFD', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            //return null;
        }

    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling Refresh delayed bag on WT
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.refreshDAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Calling Read in WT and Refresh delayed bag on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    28/11/2017             Alvaro Garcia Tapia                  Initial Version
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.readRefreshDAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Calling Modify in WT and Refresh delayed bag on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    01/12/2017             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public void modifyDAH(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

            System.debug('PASA POR AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII??????????????????????????');
            R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR = new R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request();

            //String goodJson = '{   "additionalInfo":{      "customsInfo":"UPDATE CUSTOM",      "furtherInfo":"UPDATE FURTHER",      "miscellaneousInfo":null,      "supplementaryInfo":[         {            "seq":"1",            "supplimentInfoText":"UPDATE SUPPL"         }      ],      "userComments":[         {            "commentsText":"UPDATE COMMENTS",            "seq":"2"         }      ]   },   "agentId":"n433081",   "claim":{      "claimData":{         "claimAmount":{            "amount":{               "amountValue":"9500",               "currencyCode":"GBP",               "decimalPlace":"2"            }         },         "claimDate":"2017-03-14",         "costRemarks":[            {          "costRemarksText": "cost test",     "seq": "1"        }         ],         "excessValue":{            "amountValue":"200",            "currencyCode":"USD",            "decimalPlace":"1"         },         "faultStationCode":"MAD",         "faultTerminal":"T2",         "lossComments":"cmn:LossComments",         "lossReasonCode":"20",         "missingBags":"10",         "notifiedDate":"2017-03-14",         "partnerCode":{            "carrrierCode":"AB"         },         "passengerPayments":{            "passengerPaymentsValue":[               {                  "amount":{                     "amountValue":"2500",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               },               {                  "amount":{                     "amountValue":"1000",                     "currencyCode":"GBP",                     "decimalPlace":"1"                  },                  "costType":"A"               }            ]         },         "questionnaireDate":"2017-03-14",         "toiletKits":{            "toiletKitsFemale":"2"         }      }   },   "crossReferenceRecord":[      {         "recordReference":{            "airlineCode":"IB",            "referenceNumber":"98711",            "stationCode":"MAD"         },         "recordType":"DELAYED"      }   ],   "delayedBagGroup":{      "bagAddress":{         "addressLine":{            "addressLineDesc":"addressLine"         },         "country":{            "countryCode":"BN",            "countryName":"Country"         },         "postalCode":"BZ",         "state":{            "StateCode":"ST",            "stateDesc":"ES"         }      },      "bagDeliveryAddress":{         "deliveryAddress":{            "addressLine":{               "addressLineDesc":"AddressLineDesc"            },            "city":"city",            "country":{               "countryCode":"BN",               "countryName":"Country"            },            "postalCode":"BZ",            "state":{               "stateCode":"BN",               "stateDesc":"Desc"            }         },         "deliveryInfo":[            "cmn:DeliveryInfo"         ],         "deliveryService":[            "cmn:DeliveryService"         ],         "deliveryWeight":"20",         "localDlvInfo":[            {               "divInfo":"cmn:DivInfo",               "seq":"3"            }         ]      },      "bagLastSeen":"LHR",      "bagPhones":{         "phone":[            "84385361559440122333"         ]      },      "bagTagDestinations":{         "station":[            {               "stationValue":"MAD"            }         ]      },      "bagWeight":"10",      "baggageItinerary":{         "flightDateOrARNK":[            {               "flightDate":{                  "airlineCode":"IB",                  "date":"2017-09-12",                  "flightNumber":"3170"               }            }         ]      },      "contentsGender":"M",      "delayedBags":[         {            "associatedRecord":{               "recordReference":{                  "airlineCode":"IB",                  "referenceNumber":"987011",                  "stationCode":"MAD"               },               "recordType":"DELAYED"            },            "bagContents":{               "content":[                  {                     "category":"ALCOHOL",                     "description":"cmn:Description"                  },                  {                     "category":"Camisa",                     "description":"Azul"                  },                  {                     "category":"Ipad",                     "description":"Ipad Air Blanco"                  }               ]            },            "bagDelivery":{               "bagReceived":{                  "bagReceivedDate":"2017-09-12T09:05:50",                  "station":"MAD"               },               "deliveredTime":"2017-09-19T09:05:50",               "status":{                  "delivered":"cmn:Delivered",                  "outForDelivery":"cmn:OutForDelivery",                  "trackingUpdate":"cmn:TrackingUpdate",                  "unableToDeliver":"cmn:UnableToDeliver"               }            },            "bagDetails":"cmn:BagDetails",            "bagReceivedFromCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagSentToCustoms":{               "bagDate":"2017-09-12T09:05:50",               "timeZone":"GMT"            },            "bagTag":{               "airlineCode":"IB",               "licenseNumber":{                  "issuerCode":"123",                  "tagType":"2"               },               "tagSequence":"556985"            },            "brandInfo":{               "brandInfo":"MNA"            },            "colorTypeDesc":{               "colorCode":"WT",               "descriptor":{                  "materialElement":"X",                  "otherElement":[                     "W",                     "B"                  ]               },               "typeCode":"5"            },            "contentDescription":"cmn:ContentDescription",            "lockCode":"lock12",            "remarks":[               "cmn:Remarks"            ],            "storageLocation":"cmn:StorageLocation",            "uniqueId":{               "uniqueID":"2556-5698-4152"            }         }      ],      "excessBaggage":"ExcessBaggage",      "matchWindow":"2",      "missingWeight":"3"   },   "designatedLocator":"AMDI",   "handledAirlineCopyIndicator":"YES",   "passengers":{      "autoMessageOption":"MANUAL",      "contactInfo":{         "cellPhones":[            {               "phone":"1234567890"            }         ],         "emails":[            {               "email":"cmnEmail@mail.com"            },            {               "email":"cmnEmail@mail.com"            }         ],         "faxes":[            {               "fax":"cmn:Fax"            }         ],         "permanentAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "StateCode":"ST",               "stateDesc":"ES"            }         },         "permanentPhones":[            {               "phone":"1234567890"            }         ],         "temporaryAddress":{            "addressLine":{               "addressLineDesc":"ddressLineDesc"            },            "country":{               "countryCode":"CO",               "countryName":"Country"            },            "state":{               "stateCode":"ST",               "stateDesc":"ES"            }         },         "temporaryPhones":[            {               "phone":"1234567890"            }         ]      },      "fareBasis":"Basis",      "frequentFlyerId":"XS123345678",      "initials":[         {            "initial":"a"         }      ],      "itinerary":{         "flightSegmentsorARNK":[            {               "flight":{                  "flightandDate":{                     "airlineCode":"XS",                     "date":"2017-11-11",                     "flightNumber":"413Q"                  },                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "arnk":{                  "originDestination":{                     "destination":"MAA",                     "origin":"LHR"                  }               }            },            {               "flight":{                  "flightandDate":{                     "airlineCode":"IB",                     "date":"2017-11-11",                     "flightNumber":"413S"                  },                  "originDestination":{                     "destination":"MAD",                     "origin":"MAA"                  }               }            }         ]      },      "language":"English",      "names":[         {            "name":"nameExample"         }      ],      "numberOfPassengers":"2",      "passportInfo":"cmn:PassportInfo",      "pnr":"58624",      "pooledTicketNumber":"TicketNumber",      "status":"cmn:Status",      "ticketNumber":"1256984",      "title":"cmn:Title"   },   "refStationAirline":{      "stationAirline":"IB",      "stationCode":"MAD"   },   "teletypeAddresses":[      "ABCA9A9"   ]}';
            //goodJson = goodJson.replaceAll('"date"', '"rDate"');
            //System.debug('---> JSON good hc' + goodJson);
            //requestWR =  R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request) JSON.deserialize(goodJson, R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request.class);
            System.debug('Por que no llega por aqui???????');
            //requestWR.agentId = 'agentId';
           	parseBagSection(requestWR);
            String alias = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
            requestWR.agentID = alias;
			requestWR.rDate = String.valueOf(incidencia.R2_INC_DAT_PIR_Claims_Created_Date__c);  //String.valueOf(Date.today());
            //requestWR = requestWR.replaceAll('"rDate"', '"date"');
            System.debug('0 ' + requestWR);
            String pir = parseSection1(requestWR);
            System.debug('1 ' + requestWR);
            parseSection2(requestWR);
            System.debug('2 ' + requestWR);
            parseSection3(requestWR);
            System.debug('3 ' + requestWR);
            parseSection4(requestWR);
            System.debug('4 ' + requestWR);
            parseSection5(requestWR);
            System.debug('5 ' + requestWR);
            parseSection6(requestWR);
            System.debug('6 ' + requestWR);
            parseSection7(requestWR);
            System.debug('7 ' + requestWR);
            parseSection8(requestWR);
            System.debug('8 ' + requestWR);
            parseSection9(requestWR);
            System.debug('9 ' + requestWR);
            parseSection10(requestWR);
            System.debug('10 ' + requestWR);

            //recooremos la informacion que esta en el objeto auxiliar, mediante las siguientes listas,para incorporarla en el wrapper que se envía a WT
            

            //NO SE QUE ES ESTO////////////////////////////////////


            for (Integer i = 1; i <= userCommentsUC.size(); i++) {
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.userComments == null) { requestWR.additionalInfo.userComments = new List <R2_WT_RetiredDelayedBagsUpdate.userComments>(); }
                requestWR.additionalInfo.userComments.add(new R2_WT_RetiredDelayedBagsUpdate.userComments());
                requestWR.additionalInfo.userComments[i-1].commentsText = userCommentsUC[i-1].R2_ADI_TXT_UC_User_Comment__c; //falta por poner el campo
                requestWR.additionalInfo.userComments[i-1].seq = '' + i;
            }
            for (Integer i = 1; i <= observationsFF.size(); i++) {
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.miscellaneousInfo == null) { requestWR.additionalInfo.miscellaneousInfo = new List <R2_WT_RetiredDelayedBagsUpdate.MiscellaneousInfo>(); }
                requestWR.additionalInfo.miscellaneousInfo.add(new R2_WT_RetiredDelayedBagsUpdate.MiscellaneousInfo());
                requestWR.additionalInfo.miscellaneousInfo[i-1].miscInfoText = observationsFF[i-1].R2_ADI_TXT_FF_Observation__c; //falta por poner el campo
                requestWR.additionalInfo.miscellaneousInfo[i-1].seq = '' + i;
            }           
            for (Integer i = 1; i <= deliveryServiceDS.size(); i++) {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.DeliveryType(); }
                if (requestWR.delayedBagGroup.delivery.deliveryService == null) { requestWR.delayedBagGroup.delivery.deliveryService = new List <R2_WT_RetiredDelayedBagsUpdate.DeliveryServiceType>(); }
                requestWR.delayedBagGroup.delivery.deliveryService.add(new R2_WT_RetiredDelayedBagsUpdate.DeliveryServiceType());
                requestWR.delayedBagGroup.delivery.deliveryService[i-1].deliveryServiceDesc = deliveryServiceDS[i-1].R2_ADI_ATXTL_DS_Delivery_service__c; //falta por poner el campo
                requestWR.delayedBagGroup.delivery.deliveryService[i-1].seq = '' + i;
            }
            for (Integer i = 1; i <= damageCostCR.size(); i++) {
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                if (requestWR.claim.claimData.costRemarks == null) { requestWR.claim.claimData.costRemarks = new List <R2_WT_RetiredDelayedBagsUpdate.CostRemarksListType>(); }
                requestWR.claim.claimData.costRemarks.add(new R2_WT_RetiredDelayedBagsUpdate.CostRemarksListType());
                requestWR.claim.claimData.costRemarks[i-1].costRemarksText = damageCostCR[i-1].R2_ADI_TXT_CR_Remarks_Cost__c; //falta por poner el campo
                requestWR.claim.claimData.costRemarks[i-1].seq = '' + i;
            }
            

//deliveryInformationDY //a la espera de que nos lo pongan como lista
//baggageDestinyDB // parece que se hizo finalmente en un campo de incidencia
//messagesMG //a la espera de que nos lo pongan como lista
//matchMR //a la espera de que nos lo pongan como lista
//smsInfoSM //no estan ni en xsd ni en la visual force
//internetInfoIR //no estan ni en xsd ni en la visual force
//emailInfoER //no estan ni en xsd ni en la visual force

            List<String> pirAtributtes = pir.split('@');
            String airlineCode = pirAtributtes[0];
            String stationCode = pirAtributtes[1];
            String referenceNumber = pirAtributtes[2];


            System.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
            System.debug(airlinecode);
            System.debug(stationCode);
            System.debug(referenceNumber);

          
            

            // R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord nrt = new R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord();
            // nrt.recordType = 'DELAYED';
            // R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord ar = new R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord();
            // ar.referenceNumber = '987011';
            // ar.stationCode = 'MAD';
            // ar.airlineCode = 'IB';
            // nrt.recordReference = ar;
            //
            // requestWR.delayedBagGroup.delayedBags[0].associatedRecord = nrt;

            System.debug('WRAPPER_REQUEST:::'+requestWR);

            String wrapperJson = JSON.serialize(requestWR, true);
            
            wrapperJson = wrapperJson.replaceAll('"rDate"', '"date"');
            wrapperJson = wrapperJson.replaceAll('"delete_replace"', '"delete"');
            System.debug('STRING_REQUEST:::'+wrapperJson);
            //String resultado = R2_WT_RetiredDelayedBagsUpdate.UpdateDelayedBag(wrapperJson, 0);
            errorResponse = R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI(wrapperJson, 0);
            System.debug('REDOBLE DE TAMBORES........ ' + errorResponse);
            if(errorResponse.equals('1')){
                R1_CLS_Utilities.readRecord_WT('DELAYED', stationCode, airlineCode, referenceNumber, 'agentId', 1);
            }
            //List<String> lstResultado = resultado.split('@splitMe@');
            
            //resp.record
            // R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord 
            //String success = lstResultado[0];
            // R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord resp =  R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord)JSON.deserialize(lstResultado[0] R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord.class);
            
            //resp.warnings
            //List R2_WT_RetiredDelayedBagsUpdate.WarningType>
            //warnings = (List R2_WT_RetiredDelayedBagsUpdate.WarningType>) JSON.deserialize(lstResultado[1], List R2_WT_RetiredDelayedBagsUpdate.WarningType>.class);
            //resp.errors
            //List R2_WT_RetiredDelayedBagsUpdate.ErrorType> 
            //errors = (List R2_WT_RetiredDelayedBagsUpdate.ErrorType>) JSON.deserialize(lstResultado[0], List R2_WT_RetiredDelayedBagsUpdate.ErrorType>.class);
            //System.debug('::REGISTRO-> '+success+'#######WARNINGS-> '+warnings);
            //System.debug(registro.recordType);
            //if(success == '"true"'){
            //    errorResponse = '1'

                //avisar de warnings y después leer y cargar detalle de pir
                //leemos y cargamos
                //DEBUG|bigWP::::::::READ: EJEMPLO Leído:
                //{"recordId":{"recordType":"DELAYED","
                                //recordReference":{"stationCode":"stationCode","referenceNumber":"referenceNumber","airlineCode":"airlinecode"}},"
                                //agentId":"agentId"}
                //ejemplo:R1_CLS_Utilities.readRecord_WT('DELAYED', 'stationCode', 'airlinecode', 'referenceNumber', 'agentId', 1);
                //Id 
                //incidenciaId = R1_CLS_Utilities.readRecord_WT('DELAYED', 
                //                                stationCode,
                //                                airlineCode, 
                //                                referenceNumber,
                //                                'agentId',
                //                                 1);
                //System.debug('ID del pir creado:'+incidenciaId);
                //abreNewRegistro(incidenciaId);
            //}else{
            //    errorResponse = '0';
            //    errors = (List R2_WT_RetiredDelayedBagsUpdate.ErrorType>) JSON.deserialize(lstResultado[0], List R2_WT_RetiredDelayedBagsUpdate.ErrorType>.class);
            //    //informar de errors

            //}
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.modifyDAH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
        }
    }

        private PageReference abreNewRegistro(Id idNew){
        return new PageReference('/'+idNew);
    }

    private Date parseDate(String fieldDate) {
        String[] dateItem = fieldDate.split('-');
        return Date.newinstance(Integer.valueOf(dateItem[2]), Integer.valueOf(dateItem[0]), Integer.valueOf(dateItem[1]));
    }

    private String parseSection1(R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        String airlineCode = '';
        String stationCode = '';
        String numberPIR = '';

        for (Field field : incidentInformationSection1) {
            System.debug('!!!field: ' + field);
            if (field.value == '' || field.value == null) { continue; }
            //if (field.value == null) { continue; }
            //if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
            //    requestWR.recordReference.stationCode = field.value;
            //    stationCode = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
            //    requestWR.recordReference.airlineCode = field.value;
            //    airlineCode = field.value;
            //}
            else if (field.name == 'R2_INC_FOR_PIR__c') {
                if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
                numberPIR = field.value;
            }
            //if(field.oldValue != field.value){
            else if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
                System.debug('!!!escala resp: ' + field.value);
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                requestWR.claim.claimData.faultStationCode = field.value;
            }
            else if (field.name == 'R2_INC_DAT_PIR_Claims_Created_Date__c') {  // Duplicado, recibe el mismo valor que R2_INC_DAT_PIR_Claim_Date__c
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                //requestWR.claim.claimData.claimDate = parseDate(field.value);
                requestWR.claim.claimData.claimDate = Date.valueOf(field.value);
            }
            // else if (field.name == 'R2_INC_FOR_PIR_AR__c') {
            //  // TODO WIP
            // } NOT NECESSARY
            //else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
            //    if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
            //    if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
            //    //requestWR.claim.claimData.claimDate = parseDate(field.value);
            //    requestWR.claim.claimData.claimDate = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Station_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
            //    requestWR.recordReference.stationCode = field.value;
            //    stationCode = field.value;
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Airline_Code__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
            //    requestWR.recordReference.airlineCode = field.value;
            //    airlineCode = field.value;
            //}
            //else if (field.name == 'R2_INC_FOR_PIR__c') {
            //    if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
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
                if (requestWR.recordReference == null) { requestWR.recordReference = new R2_WT_RetiredDelayedBagsUpdate.RecordReference(); }
                requestWR.recordReference.stationCode = field.value.substring(0,3);
                stationCode = field.value.substring(0,3);
                requestWR.recordReference.airlineCode = field.value.substring(3,5);
                airlineCode = field.value.substring(3,5);
            }
            //}
        }
        if (requestWR.recordReference != null) {
            requestWR.recordReference.referenceNumber = numberPIR.substring(stationCode.length() + airlineCode.length());
            requestWR.recordReference.referenceNumber =  numberPIR.substring(5,10);
            requestWR.recordReference.stationCode =  numberPIR.substring(0,3);
            requestWR.recordReference.airlinecode =  numberPIR.substring(3,5);
            System.debug('requestWRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR '+ requestWR.recordReference.referenceNumber);
        }
        System.debug('!!!requestWRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR' + requestWR);
        return airlineCode + '@' + stationCode + '@' + requestWR.recordReference.referenceNumber;
    }

    private void parseSection2 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        Set<String> possibleEmptyFields = new Set<String>();
        possibleEmptyFields.add('R2_INC_TXT_PIR_Last_name__c');

            
        for (Field field :incidentInformationSection2) {
            Boolean nextField = false;
            System.debug('!!!field.name' + field.name);
            System.debug('!!!field.value' + field.value);
            System.debug('!!!field.oldValue' + field.oldValue);
            System.debug('!!!possibleEmptyFields.contains(field.name)' + possibleEmptyFields.contains(field.name));
            System.debug('!!!possibleEmptyFields' + possibleEmptyFields);
            if ((field.value == '' && field.oldValue == field.value) || 
                (!possibleEmptyFields.contains(field.name) && field.value == '' && field.oldValue != field.value)) { nextField = true; }
            System.debug('!!!nextField' + nextField);
            if (nextField || field.value == null) { continue; }
            //if (field.value == '' || field.value == null) { continue; }
            //if (field.value == null) { continue; }
            //if(field.oldValue != field.value || filed.value != ''){
                if (field.name == 'R2_INC_TXT_PIR_Treatment__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.title = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Initial__c') {
                    R2_WT_RetiredDelayedBagsUpdate.Initials inicial1 = new R2_WT_RetiredDelayedBagsUpdate.Initials();
                    inicial1.initial = field.value;
                    inicial1.seq = '1';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List <R2_WT_RetiredDelayedBagsUpdate.Initials>(); }
                    requestWR.passengers.initials.add(inicial1);
                }
                else if (field.name == 'R2_INC_TXT_PIR_Initial2__c') {
                    R2_WT_RetiredDelayedBagsUpdate.Initials inicial2 = new R2_WT_RetiredDelayedBagsUpdate.Initials();
                    inicial2.initial = field.value;
                    inicial2.seq = '2';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List <R2_WT_RetiredDelayedBagsUpdate.Initials>(); }
                    requestWR.passengers.initials.add(inicial2);
                }
                else if (field.name == 'R2_INC_TXT_PIR_Initial3__c') {
                    R2_WT_RetiredDelayedBagsUpdate.Initials inicial3 = new R2_WT_RetiredDelayedBagsUpdate.Initials();
                    inicial3.initial = field.value;
                    inicial3.seq = '3';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    if (requestWR.passengers.initials == null ) { requestWR.passengers.initials = new List <R2_WT_RetiredDelayedBagsUpdate.Initials>(); }
                    requestWR.passengers.initials.add(inicial3);
                }
                else if (field.name == 'R2_INC_EMA_PIR_Email1__c') {
                    R2_WT_RetiredDelayedBagsUpdate.Emails emailDireccion1 = new R2_WT_RetiredDelayedBagsUpdate.Emails();
                    emailDireccion1.email = field.value;
                    emailDireccion1.seq = '1';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                    if (requestWR.passengers.contactInfo.emails == null ) { requestWR.passengers.contactInfo.emails = new List <R2_WT_RetiredDelayedBagsUpdate.Emails>(); }
                    requestWR.passengers.contactInfo.emails.add(emailDireccion1);
                }
                else if (field.name == 'R2_INC_EMA_PIR_Email2__c') {
                    R2_WT_RetiredDelayedBagsUpdate.Emails emailDireccion2 = new R2_WT_RetiredDelayedBagsUpdate.Emails();
                    emailDireccion2.email = field.value;
                    emailDireccion2.seq = '2';
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                    if (requestWR.passengers.contactInfo.emails == null ) { requestWR.passengers.contactInfo.emails = new List <R2_WT_RetiredDelayedBagsUpdate.Emails>(); }
                    requestWR.passengers.contactInfo.emails.add(emailDireccion2);
                }
                else if (field.name == 'R2_INC_TXT_PIR_FF_Identificator__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.frequentFlyerId = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Passenger_language__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.language = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Ticket_number__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.ticketNumber = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_PNR_locator__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.pnr = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Passenger_category__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.status = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Delivery_address1__c') {
                    // R2_WT_RetiredDelayedBagsUpdate.AddressLine addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
                    // addressLine.addressLineDesc = field.value;
                    // addressLine.seq = ''+1;
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.DeliveryType(); }
                    if (requestWR.delayedBagGroup.delivery.deliveryAddress == null) { requestWR.delayedBagGroup.delivery.deliveryAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                    if (requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); }
                    requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
                    requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine.seq = '1';
                }
                else if (field.name == 'R2_INC_TXT_PIR_Delivery_address2__c') {
                    // R2_WT_RetiredDelayedBagsUpdate.AddressLine addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
                    // addressLine.addressLineDesc = field.value;
                    // addressLine.seq = ''+2;
                    //if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroup(); }
                    //if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.Delivery(); }
                    //if (requestWR.delayedBagGroup.delivery.deliveryAddress == null) { requestWR.delayedBagGroup.delivery.deliveryAddress = new R2_WT_RetiredDelayedBagsUpdate.BagAddress(); }
                    //if (requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); }
                    //requestWR.delayedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc = field.value;
                }
                else if (field.name == 'R2_INC_TXT_PIR_Delivery_local_informatio__c') {
                    system.debug('R2_INC_TXT_PIR_Delivery_local_informatio__c: ' + field.value);
                    R2_WT_RetiredDelayedBagsUpdate.DlvInfoType localDlvInfo = new R2_WT_RetiredDelayedBagsUpdate.DlvInfoType();
                    localDlvInfo.dlvInfo = field.value;
                    localDlvInfo.seq = '1';
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.DeliveryType(); }
                    if (requestWR.delayedBagGroup.delivery.localDlvInfo == null) { requestWR.delayedBagGroup.delivery.localDlvInfo = new List <R2_WT_RetiredDelayedBagsUpdate.DlvInfoType>(); }
                    requestWR.delayedBagGroup.delivery.localDlvInfo.add(localDlvInfo);
                }
                else if (field.name == 'R2_INC_TXT_PIR_Deliver_local_informatio2__c') {
                    system.debug('R2_INC_TXT_PIR_Delivery_local_informatio2__c: ' + field.value);
                    R2_WT_RetiredDelayedBagsUpdate.DlvInfoType localDlvInfo = new R2_WT_RetiredDelayedBagsUpdate.DlvInfoType();
                    localDlvInfo.dlvInfo = field.value;
                    localDlvInfo.seq = '2';
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.DeliveryType(); }
                    if (requestWR.delayedBagGroup.delivery.localDlvInfo == null) { requestWR.delayedBagGroup.delivery.localDlvInfo = new List <R2_WT_RetiredDelayedBagsUpdate.DlvInfoType>(); }
                    requestWR.delayedBagGroup.delivery.localDlvInfo.add(localDlvInfo);
                }
                else if (field.name == 'R2_INC_TXT_PIR_Send_SMS_email__c') {
                    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                    requestWR.passengers.autoMessageOption = field.value;
                }
            //}
        }
    }

    private void parseSection3 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field :incidentInformationSection3) {
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_INC_TXT_PIR_Permanent_address1__c') {
                // R2_WT_RetiredDelayedBagsUpdate.localDlvInfo direccionLinea1 = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
                //direccionLinea1.addressLineDesc = field.value;
                //direccionLinea1.seq = ''+1;
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo.permanentAddress == null ) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                //if (requestWR.passengers.contactInfo.permanentAddress.addressLine == null) { requestWR.passengers.contactInfo.permanentAddress.addressLine = new List R2_WT_RetiredDelayedBagsUpdate.AddressLine>(); }
                //requestWR.passengers.contactInfo.temporaryAddress.addressLine.add(direccionLinea1);                
                if (requestWR.passengers.contactInfo.permanentAddress.addressLine == null) { requestWR.passengers.contactInfo.permanentAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); }
                requestWR.passengers.contactInfo.permanentAddress.addressLine.addressLineDesc = field.value;
                requestWR.passengers.contactInfo.permanentAddress.addressLine.seq = '1';
            }
            else if (field.name == 'R2_INC_TLF_Landline1__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones telefonoFijo1 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                telefonoFijo1.phone = field.value;
                telefonoFijo1.seq = '1';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.permanentPhones == null) { requestWR.passengers.contactInfo.permanentPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.permanentPhones.add(telefonoFijo1);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Temporal_address1__c') {
                // R2_WT_RetiredDelayedBagsUpdate.AddressLine direccionLinea = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
                //direccionLinea.addressLineDesc = field.value;
                //direccionLinea.seq = ''+1;
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                //if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new List R2_WT_RetiredDelayedBagsUpdate.AddressLine>(); }
                //requestWR.passengers.contactInfo.temporaryAddress.addressLine.add(direccionLinea);
                if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); }
                requestWR.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;
                requestWR.passengers.contactInfo.temporaryAddress.addressLine.seq = '1' ;

            }
            else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones telefonoTemporal1 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                telefonoTemporal1.phone = field.value;
                telefonoTemporal1.seq = '1';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.temporaryPhones == null) { requestWR.passengers.contactInfo.temporaryPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.temporaryPhones.add(telefonoTemporal1);
            }
            //else if (field.name == 'R2_INC_TXT_PIR_Permanent_address2__c') { //al modificar no permite meter una segunda direccion
            //    R2_WT_RetiredDelayedBagsUpdate.AddressLine direccionLinea2 = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
            //    direccionLinea2.addressLineDesc = field.value;
            //    direccionLinea2.seq = ''+2;
            //    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
            //    if (requestWR.passengers.passengerType == null) { requestWR.passengers.passengerType = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
            //    if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.passengerType.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
            //    if (requestWR.passengers.contactInfo.permanentAddress == null) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_RetiredDelayedBagsUpdate.BagAddress(); }
            //    if (requestWR.passengers.contactInfo.permanentAddress.addressLine == null) { requestWR.passengers.contactInfo.permanentAddress.addressLine = new List R2_WT_RetiredDelayedBagsUpdate.AddressLine>(); }
            //    requestWR.passengers.contactInfo.temporaryAddress.addressLine.add(direccionLinea2);
            //}
            else if (field.name == 'R2_INC_TLF_Landline2__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones telefonoFijo2 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                telefonoFijo2.phone = field.value;
                telefonoFijo2.seq = '2';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.permanentPhones == null) { requestWR.passengers.contactInfo.permanentPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.permanentPhones.add(telefonoFijo2);
            }
            //else if (field.name == 'R2_INC_TXT_PIR_Temporal_address2__c') { //al modificar no permite meter una segunda direccion
            //    R2_WT_RetiredDelayedBagsUpdate.AddressLine direccionLinea = new R2_WT_RetiredDelayedBagsUpdate.AddressLine();
            //    direccionLinea.addressLineDesc = field.value;
            //    direccionLinea.seq = '2';
            //    if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
            //    if (requestWR.passengers.passengerType == null) { requestWR.passengers.passengerType = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
            //    if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
            //    if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_RetiredDelayedBagsUpdate.TemporaryAddress(); }
            //    if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new List R2_WT_RetiredDelayedBagsUpdate.AddressLine>(); }
            //    requestWR.passengers.contactInfo.temporaryAddress.addressLine.add(direccionLinea);
            //}
            else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone2__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones telefonoTemporal2 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                telefonoTemporal2.phone = field.value;
                telefonoTemporal2.seq = '2';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.temporaryPhones == null) { requestWR.passengers.contactInfo.temporaryPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.temporaryPhones.add(telefonoTemporal2);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Zip_code__c') {
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.permanentAddress == null) { requestWR.passengers.contactInfo.permanentAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                requestWR.passengers.contactInfo.permanentAddress.postalCode = field.value;
            }
            else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number1__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones mobile1 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                mobile1.phone = field.value;
                mobile1.seq = '1';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.cellPhones == null) { requestWR.passengers.contactInfo.cellPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.cellPhones.add(mobile1);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Temporal_Zip_Code__c') {
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                requestWR.passengers.contactInfo.temporaryAddress.postalCode = field.value;
            }
            else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number2__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones mobile2 = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                mobile2.phone = field.value;
                mobile2.seq = '2';
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.cellPhones == null) { requestWR.passengers.contactInfo.cellPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.passengers.contactInfo.cellPhones.add(mobile2);
            }
            else if (field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c') {
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
                if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.passengerType(); }
                if (requestWR.passengers.contactInfo == null ) { requestWR.passengers.contactInfo = new R2_WT_RetiredDelayedBagsUpdate.ContactInfo(); }
                if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                requestWR.passengers.contactInfo.temporaryAddress.validityDate = dateStr;
            } 
        }
    }

    private void parseSection4 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection4) {
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
                if(field.value != null && field.value != '') {
                    Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
                    Integer i = 0;
                    System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
                    for (String key : dateFlightsMap.keySet()) {
                        for (String vuelo : dateFlightsMap.get(key)) {
                            if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                            if (requestWR.delayedBagGroup.baggageItinerary == null) { requestWR.delayedBagGroup.baggageItinerary = new R2_WT_RetiredDelayedBagsUpdate.BaggageItinerary(); }
                            if (requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK == null) { requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK = new List <R2_WT_RetiredDelayedBagsUpdate.FlightDateOrARNK>(); }
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightDateOrARNK());
                            if (requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate == null) { requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate = new R2_WT_RetiredDelayedBagsUpdate.FlightDate(); }
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.airlineCode = vuelo.substring(0,2);
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.flightNumber = vuelo.substring(2);
                            requestWR.delayedBagGroup.baggageItinerary.flightDateOrARNK[i].flightDate.rDate = key;
                            i++;
                        }
                    }
                }
                // R2_WT_RetiredDelayedBagsUpdate.Route route = new R2_WT_RetiredDelayedBagsUpdate.Route();
                // route.route = field.value;
                // R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK fSegmentOARNK = new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK();
                // fSegmentOARNK.additionalRoutes.add(route);
                // if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.passengerType(); }
                // if (requestWR.delayedBagGroup.bagItinerary == null) { requestWR.delayedBagGroup.bagItinerary = new List R2_WT_RetiredDelayedBagsUpdate.FlightDateOrARNK>(); }
                // if (requestWR.delayedBagGroup.bagItinerary.flightDate == null) { requestWR.delayedBagGroup.bagItinerary.flightDate = new R2_WT_RetiredDelayedBagsUpdate.FlightDate(); }
                // requestWR.delayedBagGroup.bagItinerary.flightSegmentsorARNK.add(route);
                // FIXME Campo no encontrado BagTagDestinations?????? Itinerario no lleva ruta :S
            } else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
                if(field.value != null && field.value != '') {
                    Map<String, List<String>> dateFlightsMap = R1_CLS_Utilities.helper_parseDate(field.value);
                    Integer i = 0;
                    System.debug('!!!dateFlightsMap: ' + dateFlightsMap);
                    for (String key : dateFlightsMap.keySet()) {
                        for (String vuelo : dateFlightsMap.get(key)) {
                            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                            if (requestWR.passengers.itinerary.flightSegmentOrARNK == null) { requestWR.passengers.itinerary.flightSegmentOrARNK = new List <R2_WT_RetiredDelayedBagsUpdate.flightSegmentOrARNK>(); }
                            requestWR.passengers.itinerary.flightSegmentOrARNK.add(new R2_WT_RetiredDelayedBagsUpdate.flightSegmentOrARNK());
                            if (requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight == null) { requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight = new R2_WT_RetiredDelayedBagsUpdate.Flight(); }
                            if (requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight.flightandDate == null) { requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight.flightandDate = new R2_WT_RetiredDelayedBagsUpdate.FlightDate(); }
                            System.debug('!!!key: ' + key);
                            System.debug('!!!vuelo: ' + vuelo);
                            System.debug('!!!vuelo.substring(0,2): ' + vuelo.substring(0,2));
                            System.debug('!!!vuelo.substring(2): ' + vuelo.substring(2));
                            requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight.flightandDate.airlineCode = vuelo.substring(0,2);
                            requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight.flightandDate.flightNumber = vuelo.substring(2);
                            requestWR.passengers.itinerary.flightSegmentOrARNK[i].flight.flightandDate.rDate = key;
                            i++;
                        }
                    }
                }
                //if(field.value != null && field.value != '') {
                //    List<String> vueloLst = field.value.split(';');
                //    System.debug('vueloLst: ' + vueloLst);
                //    for (Integer i = 0; i < vueloLst.size(); i++) {
                //        System.debug('vueloLst[' + i + ']: '+ vueloLst[i]);
                //        List<String> vueloFecha = vueloLst[i].split('/');
                //        System.debug('vueloFecha: ' + vueloFecha);
                //        if (vueloFecha.size() == 2) {
                //            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.passengers(); }
                //            if (requestWR.passengers.passengerType == null) { requestWR.passengers.passengerType = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                //            if (requestWR.passengers.passengerType.itinerary == null) { requestWR.passengers.passengerType.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                //            if (requestWR.passengers.passengerType.itinerary.flightSegmentOrARNK == null) { requestWR.passengers.passengerType.itinerary.flightSegmentOrARNK = new List R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK>(); }
                //            //if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK.isEmpty()) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK()); }
                //            requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK());
                //            if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight == null) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight = new R2_WT_RetiredDelayedBagsUpdate.Flight(); }
                //            if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate == null) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate = new R2_WT_RetiredDelayedBagsUpdate.FlightDate(); }
                //            requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate.airlineCode = vueloFecha[0].substring(0,2);
                //            requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate.flightNumber = vueloFecha[0].substring(2);
                //            requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate.rDate = vueloFecha[1];
                //            System.debug('requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate: ' + requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[i].flight.flightandDate);
                //        }
                //    }
                //}
                
                //if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.passengers(); }
                //if (requestWR.passengers.passengerType == null) { requestWR.passengers.passengerType = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                //if (requestWR.passengers.passengerType.itinerary == null) { requestWR.passengers.passengerType.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                //if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK == null) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK = new List R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK>(); }
                //if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK.isEmpty()) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK()); }
                //if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[0].flight == null) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[0].flight = new R2_WT_RetiredDelayedBagsUpdate.Flight(); }
                //if (requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[0].flight.flightandDate == null) { requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[0].flight.flightandDate = new R2_WT_RetiredDelayedBagsUpdate.FlightDate(); }
                //requestWR.passengers.passengerType.itinerary.flightSegmentsorARNK[0].flight.flightandDate.rDate = field.value;
            } else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
                if(field.value != null && field.value != '') {
                    List<String> rutaLst = field.value.split('/');
                    System.debug('rutaLst: ' + rutaLst);
                    //Integer i = 1;
                    for (Integer i = 1; i < rutaLst.size(); i++) {
                        System.debug('rutaLst[' + i + ']: '+ rutaLst[i]);
                        if (i < 6) {
                            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                            if (requestWR.passengers.itinerary.flightSegmentorARNK == null) { requestWR.passengers.itinerary.flightSegmentorARNK = new List <R2_WT_RetiredDelayedBagsUpdate.FlightSegmentorARNK>(); }
                            if (requestWR.passengers.itinerary.flightSegmentorARNK.size() < i) { requestWR.passengers.itinerary.flightSegmentorARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentorARNK()); }
                            //if (requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight == null) { requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight = new R2_WT_RetiredDelayedBagsUpdate.Flight(); }
                            //if (requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight.originDestination == null) { requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight.originDestination = new R2_WT_RetiredDelayedBagsUpdate.OriginDestination(); }
                            //requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                            //requestWR.passengers.passengerType.itinerary.flightSegmentorARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            if (requestWR.passengers.itinerary.flightSegmentorARNK[i-1].flight == null) {
                                if (requestWR.passengers.itinerary.flightSegmentorARNK[i-1].arnk == null) { requestWR.passengers.itinerary.flightSegmentorARNK[i-1].arnk = new R2_WT_RetiredDelayedBagsUpdate.OriginDestination(); }
                                requestWR.passengers.itinerary.flightSegmentorARNK[i-1].arnk.origin = rutaLst[i-1];
                                requestWR.passengers.itinerary.flightSegmentorARNK[i-1].arnk.destination = rutaLst[i];
                            }
                            else {
                                if (requestWR.passengers.itinerary.flightSegmentorARNK[i-1].flight.originDestination == null) { requestWR.passengers.itinerary.flightSegmentorARNK[i-1].flight.originDestination = new R2_WT_RetiredDelayedBagsUpdate.OriginDestination(); }
                                requestWR.passengers.itinerary.flightSegmentorARNK[i-1].flight.originDestination.origin = rutaLst[i-1];
                                requestWR.passengers.itinerary.flightSegmentorARNK[i-1].flight.originDestination.destination = rutaLst[i];
                            }
                            System.debug('requestWR.passengers.itinerary.flightSegmentorARNK[i-1]: ' + requestWR.passengers.itinerary.flightSegmentorARNK[i-1]);
                        }
                        else {
                            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
                            if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                            if (requestWR.passengers.itinerary.flightSegmentorARNK[i-1].additionalRoutes == null) { requestWR.passengers.itinerary.flightSegmentorARNK[i-1].additionalRoutes = new R2_WT_RetiredDelayedBagsUpdate.Route(); }
                            if (requestWR.passengers.itinerary.flightSegmentorARNK[i-1].additionalRoutes.route == null) { requestWR.passengers.itinerary.flightSegmentorARNK[i-1].additionalRoutes.route = new List<String>(); }
                            requestWR.passengers.itinerary.flightSegmentorARNK[i-1].additionalRoutes.route.add(rutaLst[i]);
                        }
                    }
                }
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Aditional_Route__c'){
            //    if(field.value != null && field.value != '') {
            //        List<String> rutaLst = field.value.split('/');
            //        System.debug('rutaLst: ' + rutaLst);
            //        for (Integer i = 0; i < rutaLst.size(); i++) {
            //            System.debug('rutaLst[' + i + ']: '+ rutaLst[i]);
            //            if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.passengers(); }
            //            if (requestWR.passengers.passengerType == null) { requestWR.passengers.passengerType = new R2_WT_RetiredDelayedBagsUpdate.PassengerType(); }
            //            if (requestWR.passengers.itinerary == null) { requestWR.passengers.passengerType.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
            //            if (requestWR.passengers.passengerType.itinerary.additionalRoutes == null) { requestWR.passengers.passengerType.itinerary.additionalRoutes = new R2_WT_RetiredDelayedBagsUpdate.AdditionalRoutes(); }
            //            if (requestWR.passengers.passengerType.itinerary.additionalRoutes.route == null) { requestWR.passengers.passengerType.itinerary.additionalRoutes.route = new List<String>(); }
            //            requestWR.passengers.passengerType.itinerary.additionalRoutes.route.add(rutaLst[i]);
            //            System.debug('requestWR.passengers.passengerType.itinerary.additionalRoutes: ' + requestWR.passengers.passengerType.itinerary.additionalRoutes);
            //        }
            //    }
                
                /// R2_WT_RetiredDelayedBagsUpdate.Route route = new R2_WT_RetiredDelayedBagsUpdate.Route();
                //route.route = field.value;
                /// R2_WT_RetiredDelayedBagsUpdate.FlightSegmentorARNK fSegmentOARNK = new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentorARNK();
                //fSegmentOARNK.additionalRoutes.add(route);
                //if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_RetiredDelayedBagsUpdate.passengers(); }
                //if (requestWR.passengers.itinerary == null) { requestWR.passengers.itinerary = new R2_WT_RetiredDelayedBagsUpdate.Itinerary(); }
                //if (requestWR.passengers.itinerary.flightSegmentorARNK == null) { requestWR.passengers.itinerary.flightSegmentorARNK = new List R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK>(); }
                //if (requestWR.passengers.itinerary.flightSegmentsorARNK.isEmpty()) { requestWR.passengers.itinerary.flightSegmentsorARNK.add(new R2_WT_RetiredDelayedBagsUpdate.FlightSegmentsorARNK()); }
                //if (requestWR.passengers.itinerary.flightSegmentsorARNK[0].additionalRoutes == null) { requestWR.passengers.itinerary.flightSegmentsorARNK[0].additionalRoutes = new List R2_WT_RetiredDelayedBagsUpdate.Route>(); }
                //requestWR.passengers.itinerary.flightSegmentsorARNK[0].additionalRoutes.add(route);
            }
        }
    }

    private void parseSection5 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field :incidentInformationSection5) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Send_direction_FI__c') {
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.furtherInfo == null) { requestWR.additionalInfo.furtherInfo = new R2_WT_RetiredDelayedBagsUpdate.FurtherInfo(); }
                requestWR.additionalInfo.furtherInfo.furtherInfoDesc = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Control_information1__c') {
                R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType supplementInfo = new R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType();
                supplementInfo.supplimentInfoText = field.value;
                supplementInfo.seq = '1';
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List <R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType>(); }
                requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
            }
            else if (field.name == 'R2_INC_TXT_PIR_Control_information2__c') {
                R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType supplementInfo = new R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType();
                supplementInfo.supplimentInfoText = field.value;
                supplementInfo.seq = '2';
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.supplementaryInfo == null) { requestWR.additionalInfo.supplementaryInfo = new List <R2_WT_RetiredDelayedBagsUpdate.SupplementaryInfoType>(); }
                requestWR.additionalInfo.supplementaryInfo.add(supplementInfo);
            }
            else if (field.name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c') {
                //requestWR.handledAirlineCopyIndicator = field.value;
            }
            //else if (field.name == 'R2_ADI_TXT_FF_Observation__c') {
            //    if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfo(); }
            //    if (requestWR.additionalInfo.miscellaneousInfo == null) { requestWR.additionalInfo.miscellaneousInfo = new List R2_WT_RetiredDelayedBagsUpdate.MiscellaneousInfo>(); }
            //    if (requestWR.additionalInfo.miscellaneousInfo.isEmpty()) { requestWR.additionalInfo.miscellaneousInfo.add(new R2_WT_RetiredDelayedBagsUpdate.MiscellaneousInfo()); }
            //    requestWR.additionalInfo.miscellaneousInfo[0].miscInfoText = field.value;
            //    requestWR.additionalInfo.miscellaneousInfo[0].seq = '1';
            //}
            //else if (field.name == 'R2_ADI_TXT_UC_User_Comment__c') {
            //    if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfo(); }
            //    if (requestWR.additionalInfo.userComments == null) { requestWR.additionalInfo.userComments = new List R2_WT_RetiredDelayedBagsUpdate.userComments>(); }
            //    if (requestWR.additionalInfo.userComments.isEmpty()) { requestWR.additionalInfo.userComments.add(new R2_WT_RetiredDelayedBagsUpdate.userComments()); }
            //    requestWR.additionalInfo.userComments[0].commentsText = field.value;
            //    requestWR.additionalInfo.userComments[0].seq = '1';
            //}
        }
    }

    private void parseSection6 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection6) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                if (requestWR.claim.claimData.partnerCode == null) { requestWR.claim.claimData.partnerCode = new R2_WT_RetiredDelayedBagsUpdate.PartnerCode(); }
                requestWR.claim.claimData.partnerCode.carrierCode = field.value;
            }
        }
    }

    private void parseSection7 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection7) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_piece__c') {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                requestWR.delayedBagGroup.baggageWeight = field.value;
            }
            else if (field.name == 'R2_INC_TXT_Last_Seen__c') {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                requestWR.delayedBagGroup.bagLastseen = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Weight_lost_parts__c') {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                requestWR.delayedBagGroup.missingWeight = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_content1__c') {
                //No esta en los xsd de modificar, no es posible modificar estos campos
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_content2__c') {
                //No esta en los xsd de modificar, no es posible modificar estos campos
            }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c') {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                if (requestWR.delayedBagGroup.delivery == null) { requestWR.delayedBagGroup.delivery = new R2_WT_RetiredDelayedBagsUpdate.DeliveryType(); }
                requestWR.delayedBagGroup.delivery.deliveryWeight = field.value;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase1__c') {
                if (field.oldValue != field.value) {
                    //solo se rellena si se ha modificado la maleta 1
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.bagAddress == null) { requestWR.delayedBagGroup.bagAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                    if (requestWR.delayedBagGroup.bagAddress.addressLine == null) { requestWR.delayedBagGroup.bagAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); }
                    requestWR.delayedBagGroup.bagAddress.addressLine.addressLineDesc = field.value;
                    requestWR.delayedBagGroup.bagAddress.addressLine.seq = '1';
                }
            }
            else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
                //no se rellena si ya se ha metido una direccion de maleta 1
                if (field.oldValue != field.value) {
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.bagAddress == null) { requestWR.delayedBagGroup.bagAddress = new R2_WT_RetiredDelayedBagsUpdate.AddressType(); }
                    if (requestWR.delayedBagGroup.bagAddress.addressLine == null) { 
                        requestWR.delayedBagGroup.bagAddress.addressLine = new R2_WT_RetiredDelayedBagsUpdate.AddressLine(); 
                        requestWR.delayedBagGroup.bagAddress.addressLine.addressLineDesc = field.value;
                        requestWR.delayedBagGroup.bagAddress.addressLine.seq = '2';
                    }
                }
            }
            else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase1__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones tel = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                tel.phone = field.value;
                tel.seq = '1';
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                if (requestWR.delayedBagGroup.bagPhones == null) { requestWR.delayedBagGroup.bagPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.delayedBagGroup.bagPhones.add(tel);
            }
            else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase2__c') {
                R2_WT_RetiredDelayedBagsUpdate.BagPhones tel = new R2_WT_RetiredDelayedBagsUpdate.BagPhones();
                tel.phone = field.value;
                tel.seq = '2';
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                if (requestWR.delayedBagGroup.bagPhones == null) { requestWR.delayedBagGroup.bagPhones = new List <R2_WT_RetiredDelayedBagsUpdate.BagPhones>(); }
                requestWR.delayedBagGroup.bagPhones.add(tel);
            }
            else if (field.name == 'R2_INC_TXT_Excess_Baggage__c') {
                if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                requestWR.delayedBagGroup.excessBaggage = field.value;
            }
            else if (field.name == 'R2_INC_CHK_PIR_Limited_approval_label__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                requestWR.claim.claimData.liabilityTag = Boolean.valueOf(field.value);
            }
            else if (field.name == 'R2_ADI_ATXTL_DS_Delivery_service__c') {
                // TODO WIP
            }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_destination__c') {
                List<String> destLst = field.value.split('/');
                for (Integer i = 0; i < destLst.size(); i++) {
                    if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType(); }
                    if (requestWR.delayedBagGroup.bagTagDestinations == null) { requestWR.delayedBagGroup.bagTagDestinations = new R2_WT_RetiredDelayedBagsUpdate.BagTagDestinationsType(); }
                    if (requestWR.delayedBagGroup.bagTagDestinations.station == null) { requestWR.delayedBagGroup.bagTagDestinations.station = new List <R2_WT_RetiredDelayedBagsUpdate.StationType>(); }
                    requestWR.delayedBagGroup.bagTagDestinations.station.add(new R2_WT_RetiredDelayedBagsUpdate.StationType());
                    requestWR.delayedBagGroup.bagTagDestinations.station[i].stationValue = destLst[i];
                } 
            }
        }
    }

    private void parseSection8 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection8) {
            if (field.value == '' || field.value == null) { continue; }
            else if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                requestWR.claim.claimData.insurance = Boolean.valueOf(field.value);
                //if (field.value == 'true') {
                //    requestWR.claim.claimData.insurance = 'YES';
                //}
                //else {
                //    requestWR.claim.claimData.insurance = 'No';
                //}
                
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                requestWR.claim.claimData.lossReasonCode = Integer.valueOf(field.value);
            }
            //else if (field.name == 'R2_INC_CHK_PIR_Repair_suitcase__c') { // seria de damage???
            //    if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
            //    if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
            //    requestWR.claim.claimData.repairBagIndicator = field.value;
            //    // FIXME no mapeado!
            //}
            else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
                // if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                // if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                // requestWR.claim.claimData. = field.value ;
                // FIXME no encontrado
            }
            //solo deberia reemplazarse en damaged
            //else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
            //    if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
            //    if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
            //    requestWR.claim.claimData.replacementBag = field.value ;
            //    //if (field.value == 'true') {
            //    //    requestWR.claim.claimData.replacementBag = 'YES';
            //    //}
            //    //else {
            //    //    requestWR.claim.claimData.replacementBag = 'No';
            //    //}
            //}
            else if (field.name == 'R2_INC_TXT_PIR_Lost_reason_causes__c') {
                if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                requestWR.claim.claimData.lossComments = field.value ;
            }
            else if (field.name == 'R2_INC_TXT_PIR_Washing_kit__c') {
                List<String> kitLst = field.value.split('/');
                for (String kit : kitLst) {
                    if (kit.contains('M')) {
                        if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                        if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                        if (requestWR.claim.claimData.toiletKits == null) { requestWR.claim.claimData.toiletKits = new R2_WT_RetiredDelayedBagsUpdate.ToiletKits(); }
                        requestWR.claim.claimData.toiletKits.male = kit.remove('M');
                    }
                    else if (kit.contains('F')) {
                        if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                        if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                        if (requestWR.claim.claimData.toiletKits == null) { requestWR.claim.claimData.toiletKits = new R2_WT_RetiredDelayedBagsUpdate.ToiletKits(); }
                        requestWR.claim.claimData.toiletKits.female = kit.remove('F');
                    }
                }
                // if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                // if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                // requestWR.claim.claimData. = field.value ;
                // FIXME es toilerkit pero va a postuat
            }
            //else if (field.name == 'R2_INC_TXT_PIR_DO_Flight__c') { // resp.claim.claimData.
                // if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                // if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                // requestWR.claim.claimData. = field.value ;
                // FIXME no encontrado
            //}
            else if (field.name == 'R2_ADI_TXT_CR_Remarks_Cost__c') { // resp.claim.claimData.
                // if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
                // if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
                // if (requestWR.claim.claimData.costRemarks == null) { requestWR.claim.claimData.costRemarks = new List R2_WT_RetiredDelayedBagsUpdate.R2_ADI_TXT_CR_Remarks_Cost__c>(); }
            // R2_WT_RetiredDelayedBagsUpdate.CostRemarks costRemark = new R2_WT_RetiredDelayedBagsUpdate.CostRemarks();
            // costRemark.CostRemarksText = field.value;
            // costRemark.seq = String.valueof(requestWR.claim.claimData.costRemarks.size() + 1);
                //// requestWR.claim.claimData.costRemarks.add(costRemark); // FIXME desccomentar cuando se implemente el wrapper
                //// START FIXME eliminar cuando se implemente lo de arriba
            //if (requestWR.claim == null) { requestWR.claim = new R2_WT_RetiredDelayedBagsUpdate.Claim(); }
            //if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_RetiredDelayedBagsUpdate.ClaimData(); }
            //if (requestWR.claim.claimData.costRemarks == null) { requestWR.claim.claimData.costRemarks = new List R2_WT_RetiredDelayedBagsUpdate.CostRemarks>(); }
            //requestWR.claim.claimData.costRemarks.add(costRemark);
                // END FIXME eliminar cuando se implemente lo de arriba
            }
        }
    }

    private void parseSection9 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection9) {
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_ADI_ATXTL_MR_Match__c') {
                R2_WT_RetiredDelayedBagsUpdate.MatchInfoType matchInfo1 = new R2_WT_RetiredDelayedBagsUpdate.MatchInfoType();
                matchInfo1.matchInfoText = field.value;
                matchInfo1.seq = ''+1;
                if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfoType(); }
                if (requestWR.additionalInfo.matchInfo == null) { requestWR.additionalInfo.matchInfo = new R2_WT_RetiredDelayedBagsUpdate.MatchInfoType(); }
                requestWR.additionalInfo.matchInfo.matchInfoText = field.value;
                requestWR.additionalInfo.matchInfo.seq = '1';
            }
        }
    }

    private void parseSection10 (R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR) {
        for (Field field : incidentInformationSection10) {
            System.debug(field.value);
            if (field.value == '' || field.value == null) { continue; }
            if (field.name == 'R2_ADI_ATXTL_MG_Message__c') {
                // R2_WT_RetiredDelayedBagsUpdate.MessageInfoType messageInfo1 = new R2_WT_RetiredDelayedBagsUpdate.MessageInfoType();
                //messageInfo1.messageInfoText = field.value;
                //messageInfo1.seq = ''+1;
                //if (requestWR.additionalInfo == null) { requestWR.additionalInfo = new  R2_WT_RetiredDelayedBagsUpdate.AdditionalInfo(); }
                //if (requestWR.additionalInfo.messageInfo == null) { requestWR.additionalInfo.messageInfo = new List R2_WT_RetiredDelayedBagsUpdate.MessageInfoType>(); }
                //requestWR.additionalInfo.messageInfo.add(messageInfo1);
            }
        }
    }
    
    private void parseBagSection(R2_WT_RetiredDelayedBagsUpdate.Wp_UpdateRetiredDelayedBag_Request requestWR){

        R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType delayBagGroup = new R2_WT_RetiredDelayedBagsUpdate.DelayedBagGroupType();
        //R2_CLS_WT_Inactive_Bags_Management.DelayedBag lstDelayBags = new R2_CLS_WT_Inactive_Bags_Management.DelayedBag();
        List<R2_WT_RetiredDelayedBagsUpdate.DelayedBag> delayBagLst = new List<R2_WT_RetiredDelayedBagsUpdate.DelayedBag>();
        System.debug('!!!bagLst: ' + bagLst);
        //requestWR.delayedBagGroup.delayedBags
        if(bagLst != null && !bagLst.isEmpty()){
        // for para rellenar los campos de maleta
            for(Integer i = 0;i<bagLst.size();i++){
                R2_WT_RetiredDelayedBagsUpdate.BagSentToCustoms sentCustoms = new R2_WT_RetiredDelayedBagsUpdate.BagSentToCustoms();
                R2_WT_RetiredDelayedBagsUpdate.bagReceivedFromCustoms receiveCustoms = new R2_WT_RetiredDelayedBagsUpdate.bagReceivedFromCustoms();
                R2_WT_RetiredDelayedBagsUpdate.BagContents bagCont = new R2_WT_RetiredDelayedBagsUpdate.BagContents();
                R2_WT_RetiredDelayedBagsUpdate.ColourAndType colorType = new R2_WT_RetiredDelayedBagsUpdate.ColourAndType();
                R2_WT_RetiredDelayedBagsUpdate.DescriptorType descrip = new R2_WT_RetiredDelayedBagsUpdate.DescriptorType();
                R2_WT_RetiredDelayedBagsUpdate.BrandInfo brandInf = new R2_WT_RetiredDelayedBagsUpdate.BrandInfo();
                R2_WT_RetiredDelayedBagsUpdate.BagTag bagtag = new  R2_WT_RetiredDelayedBagsUpdate.BagTag();
                R2_WT_RetiredDelayedBagsUpdate.LicenseNumber licens = new R2_WT_RetiredDelayedBagsUpdate.LicenseNumber();
                R2_WT_RetiredDelayedBagsUpdate.BagDelivery bagDeliv = new R2_WT_RetiredDelayedBagsUpdate.BagDelivery();
                R2_WT_RetiredDelayedBagsUpdate.Status delivStatus = new R2_WT_RetiredDelayedBagsUpdate.Status();
                R2_WT_RetiredDelayedBagsUpdate.BagReceived bagReceiv = new R2_WT_RetiredDelayedBagsUpdate.BagReceived();
                R2_WT_RetiredDelayedBagsUpdate.UniqueID uniq = new R2_WT_RetiredDelayedBagsUpdate.UniqueID();
                R2_WT_RetiredDelayedBagsUpdate.DelayedBag delayBag = new R2_WT_RetiredDelayedBagsUpdate.DelayedBag();
                R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord assoc = new R2_WT_RetiredDelayedBagsUpdate.AssociatedRecord();
                R2_WT_RetiredDelayedBagsUpdate.RecordReference recordRefer = new R2_WT_RetiredDelayedBagsUpdate.RecordReference();
				R2_WT_RetiredDelayedBagsUpdate.Remarks remark = new R2_WT_RetiredDelayedBagsUpdate.Remarks();
                List<String> otrosElem = new List<String>();

                if(bagLst[i].R2_BAG_PKL_Type__c!=null && bagLst[i].R2_BAG_PKL_Colour__c!=null){
                    colorType.typeCode = bagLst[i].R2_BAG_PKL_Type__c;
                    colorType.colorCode = bagLst[i].R2_BAG_PKL_Colour__c;
                    if(bagLst[i].R2_BAG_CHK_Suspended__c){
                        colorType.suspended = bagLst[i].R2_BAG_CHK_Suspended__c;
                    }

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
                    delayBag.colorTypeDesc = colorType;
                }

                if(bagLst[i].R2_BAG_TXT_Ticket_number__c!=null && bagLst[i].R2_BAG_TXT_Ticket_number__c!=''){

                    if(bagLst[i].R2_BAG_TXT_Ticket_number__c.length()==8){
                        bagtag.tagSequence = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(2);
                        bagtag.airlineCode = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(0,2);
                    }else if(bagLst[i].R2_BAG_TXT_Ticket_number__c.length()==9){
                        bagtag.tagSequence = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(3);
                        licens.issuerCode = bagLst[i].R2_BAG_TXT_Ticket_number__c.subString(0,3);
                    }
                    if(bagLst[i].R2_BAG_CHK_BagTag_Suspended__c){
                        bagtag.suspended = bagLst[i].R2_BAG_CHK_BagTag_Suspended__c;
                    }
                    bagtag.licenseNumber = licens;
                    delayBag.BagTag = bagtag;
                }

                if(bagLst[i].R2_BAG_TXT_Brand_Info__c!=null && bagLst[i].R2_BAG_TXT_Brand_Info__c!=''){
                    brandInf.brandInfo = bagLst[i].R2_BAG_TXT_Brand_Info__c;
                    if(bagLst[i].R2_BAG_TXT_Brand_Info_Suspended__c){
                        brandInf.suspended = bagLst[i].R2_BAG_TXT_Brand_Info_Suspended__c;
                    }
                    delayBag.BrandInfo = brandInf;
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
               		delayBag.BagDelivery = bagDeliv;
                }

                if(bagLst[i].R2_BAG_TXT_Lock_Code__c!=null && bagLst[i].R2_BAG_TXT_Lock_Code__c!=''){
                    delayBag.lockCode = bagLst[i].R2_BAG_TXT_Lock_Code__c;
                }

                if(bagLst[i].R2_BAG_TXT_UniqueID__c!=null && bagLst[i].R2_BAG_TXT_UniqueID__c!=''){
                    uniq.UniqueID = bagLst[i].R2_BAG_TXT_UniqueID__c;
                    //uniq.suspended = bagLst[i].R2_BAG_CHK_UniqueID_Suspended__c;
                    delayBag.UniqueID = uniq;
                }

                if(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c!=null){
                    sentCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_SentToCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c!=''){
                        sentCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c;
                    }
                    delayBag.bagSentToCustoms = sentCustoms;
                }


                if(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c!=null){
                    receiveCustoms.bagDate = String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.date()) + 'T' + String.valueOf(bagLst[i].R2_BAG_DATH_Bag_ReceivedFromCustoms__c.time());
                    if(bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=null && bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c!=''){
                        receiveCustoms.timeZone = bagLst[i].R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c;
                    }
                    delayBag.bagReceivedFromCustoms = receiveCustoms;
                }


                if(bagLst[i].R2_BAG_TXT_Storage_Location__c!=null && bagLst[i].R2_BAG_TXT_Storage_Location__c!=''){
                    delayBag.storageLocation = bagLst[i].R2_BAG_TXT_Storage_Location__c;
                }

                List<R2_WT_RetiredDelayedBagsUpdate.Content> lstCont = new List<R2_WT_RetiredDelayedBagsUpdate.Content>();

                // for para rellenar los campos de contenidos
                if(!mapCont.get(i).isEmpty()){
                    for(Integer z = 0;z < mapCont.get(i).size();z++){
                         R2_WT_RetiredDelayedBagsUpdate.Content cont = new R2_WT_RetiredDelayedBagsUpdate.Content();
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
                    if(bagLst[i].R2_BAG_CHK_BagContends_Suspended__c){
                        bagCont.suspended = bagLst[i].R2_BAG_CHK_BagContends_Suspended__c;
                    }
                    //bagCont.suspended = bagLst[i].R2_BAG_CHK_BagContends_Suspended__c;
                    delayBag.bagContents = bagCont;
                }


                if(bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=null && bagLst[i].R2_BAG_TXT_Aditional_damage_information__c!=''){
                    delayBag.bagDetails = bagLst[i].R2_BAG_TXT_Aditional_damage_information__c;
                }

                if(bagLst[i].R2_CB_TXT_Contents_Desc__c!=null && bagLst[i].R2_CB_TXT_Contents_Desc__c!=''){
                    delayBag.contentsDesc= bagLst[i].R2_CB_TXT_Contents_Desc__c;
                }

				List<String> lstRemarks = new List<String>();
                if(bagLst[i].R2_BAG_TXT_Comments__c!=null && bagLst[i].R2_BAG_TXT_Comments__c!=''){
                    lstRemarks.add(bagLst[i].R2_BAG_TXT_Comments__c);
                    remark.remark = lstRemarks;
                    delayBag.remarks = remark;
                }


                // AssociatedRecord mapeado con datos de la incidencia relacionada a las maletas
                if(incidencia.RecordType.DeveloperName=='DELAYED' && incidencia.R2_INC_TXT_PIR_AR_Station_Code__c!=null && incidencia.R2_INC_TXT_PIR_AR_Station_Code__c!='' && incidencia.R2_INC_TXT_PIR_AR_Airline_Code__c!=null && incidencia.R2_INC_TXT_PIR_AR_Airline_Code__c!='' && incidencia.R2_INC_TXT_PIR_AR_Reference_Number__c!=null && incidencia.R2_INC_TXT_PIR_AR_Reference_Number__c!=''){
                  recordRefer.stationCode = bag.R2_BAG_TXT_PIR_AR__c.subString(0, 2);
                  recordRefer.airlineCode = bag.R2_BAG_TXT_PIR_AR__c.subString(2, 4);
                  recordRefer.referenceNumber = bag.R2_BAG_TXT_PIR_AR__c.subString(4);
                  assoc.recordType = bag.R2_BAG_TXT_RecordType_PIR_AR__c;
                  assoc.recordReference = recordRefer;

                //    // seq no esta mapeado no se con que mapearlo

                  delayBag.associatedRecord = assoc;
               }

                delayBag.seq = String.valueOf(i+1);

               	delayBagLst.add(delayBag);
            }
            //lstDelayBags.delayedBag = delayBagLst;
        }
        delayBagGroup.delayedBags = delayBagLst;
      	requestWR.delayedBagGroup = delayBagGroup;
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
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolEnabled(){
        boolCambiaEscala  = false;
        boolReabrir = false;
        if(boolEnabled){
            boolEnabled = false;
            System.debug('switchBoolEnabled = true cambiado a ' + boolEnabled);
        }else{
            boolEnabled = true;
            System.debug('switchBoolEnabled = false cambiado a ' + boolEnabled);
        }
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
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolCambiaEscala(){
        boolEnabled  = false;
        boolReabrir = false;
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
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolReabrir(){
        boolEnabled  = false;
        boolCambiaEscala = false;
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
    Description:    helper to read sections, called from several methods
    IN:             
    O
UT:            

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
 ----------------------------------------------------------------------------------------------------------------------*/
    public void resetBooleanos(){ 
        boolEnabled = false;
        boolCambiaEscala = false;
        boolReabrir = false;
        newStation = '';
        newAirline = '';
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

            incidencia = [SELECT ID, Name, RecordType.DeveloperName, R2_INC_DAT_PIR_Claims_Created_Date__c, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c, R2_INC_TXT_PIR_AR_Reference_Number__c FROM R1_Incident__c WHERE ID = :incidenciaID LIMIT 1];

           imgMaletaVacia = 'ImagenesMaletas/maleta-vacia.gif';
           imgMaletaON = 'ImagenesMaletas/maleta-on.gif';
           imgMaletaLlena = 'ImagenesMaletas/maleta-llena.gif';

           tipoCont = '';
           desCont = '';
           System.debug('!!!MaletaVacia: ' + imgMaletaVacia);
           System.debug('!!!mapType: ' + mapType);

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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.cargarVisual()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.getBagImageMaleta()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.cargarImgMaletaOn()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.getBagImageTipo()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.getBagImageColor()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            mostrarContenido();

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.bagMostrar()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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

            lstContInicial = [SELECT Id, R2_CB_TXT_Description__c, R2_BG_CHK_Select__c, R2_CB_TXT_Type__c FROM R2_Content_Baggage__c WHERE R2_CB_MSDT_Baggage__c = :bag.Id LIMIT 12];
            //lstContent.clear();
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.mostrarContenido()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.guardarContenido()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.newBag()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
                    lstContent[i].R2_BG_CHK_Select__c = false;
                    lstContent.set(i, lstContent[i]);
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.updateContent()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
                    if(lstContent[i].R2_BG_CHK_Select__c && lstContent[i].Id==null){
                        lstContent.remove(i);
                        i = i - 1;
                    }else if(lstContent[i].R2_BG_CHK_Select__c && lstContent[i].Id!=null){
                        lstContent[i].R2_BG_CHK_Select__c = false;

                    }
                }
                wtContent = 'false';
                if(!lstContent.isEmpty()){
                    recargarLstCont(lstContent);
                }
            }


        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.deleteCont()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.recargarLstCont()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
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
    public void contWT(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

           if(!lstContent.isEmpty()){
                for(Integer i = 0;i<lstContent.size();i++){
                    if(lstContent[i].R2_BG_CHK_Select__c && lstContent[i].Id!=null){
                        wtContent = 'true';
                        break;
                    }
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_InactiveDelayedController.recargarLstCont()', '', exc.getmessage()+', '+exc.getLineNumber() , 'R1_Incident__c');
        }
    }
}