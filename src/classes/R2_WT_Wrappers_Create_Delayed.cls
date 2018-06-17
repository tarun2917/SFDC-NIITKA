public with sharing class R2_WT_Wrappers_Create_Delayed {
	public R2_WT_Wrappers_Create_Delayed() {
		
	}
    public class PermanentAddress {
        public AddressLine addressLine;
        public Country country;
        public State state;
        public String postalCode;
        public String city; //added
    }

    public class LicenseNumber {
        public String issuerCode;
        public String tagType;
    }

    public class Flight {
        public FlightDate flightandDate;
        public OriginDestination originDestination;
    }

    public class PassengerPayments {
        public List<PassengerPaymentsValue> passengerPaymentsValue;
    }

    public class ToiletKits {
        public String toiletKitsMale;
        public String toiletKitsFemale;
    }

    public class PassengerPaymentsValue {
        public Amount amount;
        public String costType;
    }

    public class CrossReferenceRecord {
        public RecordReference recordReference;
        public String recordType;
    }

    public class BagReceived {
        public String bagReceivedDate;
        public String station;
    }

    public class RecordReference {
        public String airlineCode;
        public String referenceNumber;
        public String stationCode;
    }

    public class ClaimData {
        public ClaimAmount claimAmount;
        public String claimDate;
        public List<String> costRemarks;
        public Amount excessValue;
        public String faultStationCode;
        public String faultTerminal;
        public String lossComments;
        public String lossReasonCode;
        public String missingBags;
        public String notifiedDate;
        public PartnerCode partnerCode;
        public PassengerPayments passengerPayments;
        public String questionnaireDate;
        public ToiletKits toiletKits;
        //added:
        public Boolean liabilityTag;
        public Boolean insurance;
        public String repairBagIndicator;
        public String replacementBagIndicator;
    }

    public class BagReceivedFromCustoms {
        public String bagDate;
        public String timeZone;
    }

    public class Itinerary {
        public List<FlightSegmentsorARNK> flightSegmentsorARNK;
        public AdditionalRoutes additionalroutes;//added
    }

    public class AdditionalRoutes{//added
        public List<String> route;
    }

    public class TemporaryAddress {
        public AddressLine addressLine;
        public Country country;
        public State_Z state;
        public String postalCode;
        public String city; //added
        public String validityDate;
    }

    public class ContactInfo {
        public List<CellPhones> cellPhones;
        public List<Emails> emails;
        public List<Faxes> faxes;
        public PermanentAddress permanentAddress;
        public List<CellPhones> permanentPhones;
        public TemporaryAddress temporaryAddress;
        public List<CellPhones> temporaryPhones;
    }

    public class Emails {
        public String email;
        public String seq;//no está en el xsd
    }

    public class Status {
        public String delivered;
        public String outForDelivery;
        public String trackingUpdate;
        public String unableToDeliver;
    }

    public class AdditionalInfo {
        public String customsInfo;
        public String furtherInfo;
        public List<MiscellaneousInfo> miscellaneousInfo;
        public List<SupplementaryInfo> supplementaryInfo;
        public List<UserComments> userComments;
        public List<MatchInfo> matchInfo;//added por xsd
        public List<MessageInfo> messageInfo;//added por xsd
        //public MatchInfo matchInfo;//added por xsd
        //public MessageInfo messageInfo;//added por xsd
    }

    public class MatchInfo{//added
        public String matchInfoText;
        public String seq;
    }

    public class MessageInfo{//added
        public String messageInfoText;
        public String seq;
    }

    public class UniqueId {
        public String uniqueID;
        public Boolean suspended; //added
    }

    public class AddressLine {
        public String addressLineDesc;
    }

    public class State_Z {
        public String stateCode;
        public String stateDesc;
    }

    public class BagAddress {
        public AddressLine addressLine;
        public Country country;
        public String postalCode;
        public State state;
        public String city; //added
    }

    public class Initials {
        public String initial;
        public String seq;//no está en el xsd
    }

    public class CellPhones {
        public String phone;
        public String seq; //no está en el xsd
    }

    public class Station {
        public String stationValue;
    }

    public class FlightDate {
        public String airlineCode;
        public String rDate;
        //public String flightDate;
        public String flightNumber;
    }

    public class BagTag {
        public String airlineCode;
        public LicenseNumber licenseNumber;
        public String tagSequence;
        public Boolean suspended; //added
    }

    public class Passengers {
        public String autoMessageOption;
        public ContactInfo contactInfo;
        public String fareBasis;
        public String frequentFlyerId;
        public List<Initials> initials;
        public Itinerary itinerary;
        public String language;
        public List<Names> names;
        public String numberOfPassengers;
        public String passportInfo;
        public String pnr;
        public String pooledTicketNumber;
        public String status;
        public String ticketNumber;
        public String title;
        public String givenName; //added
    }

    public class BrandInfo {
        public String brandInfo;
        public Boolean suspended;
    }

    public class OriginDestination {
        public String destination;
        public String origin;
    }

    public class State {
        public String stateCode;
        public String stateDesc;
    }

    public class Content {
        public String category;
        public String description;
    }

    public class BaggageItinerary {
        public List<FlightDateOrARNK> flightDateOrARNK;
    }

    public class Country {
        public String countryCode;
        public String countryName;
    }

    public class Descriptor {
        public String materialElement;
        public List<String> otherElement;
    }

    public class LocalDlvInfo {
        public String divInfo;
        public String seq;
    }

    public class BagDelivery {
        public BagReceived bagReceived;
        public String deliveredTime;
        public Status status;
    }

    public class BagPhones { //ojo aqui
        public List<String> phone;
        //public String phone;
        //public String seq;
    }

    public class SupplementaryInfo {
        public String seq;
        public String supplimentInfoText;
    }

    public class DeliveryAddress {
        public AddressLine addressLine;
        public String city;
        public Country country;
        public String postalCode;
        public State state;
    }

    public class PartnerCode {
        public String carrierCode;
        public Boolean none;
    }

    public class Names {
        public String name;
        public String seq;//no está en el xsd
    }

    public class Arnk {
        public OriginDestination originDestination;
    }

    public class ClaimAmount {
        public Amount amount;
        public String amountUnknown;//added 14/12/2017
    }

    public class BagTagDestinations {
        public List<Station> station;
    }

    public class UserComments {
        public String commentsText;
        public String seq;
    }

    public class Faxes {
        public String fax;
        public String seq;//no está en el xsd
    }

    public class Amount {
        public String amountValue;
        public String currencyCode;
        public String decimalPlace;
    }

    public class BagDeliveryAddress {
        public DeliveryAddress deliveryAddress;
        public List<String> deliveryInfo;
        public List<String> deliveryService;
        public String deliveryWeight;
        public List<LocalDlvInfo> localDlvInfo;
    }

    public class Create_Delayed_Heroku {
        public List<CrossReferenceRecord> crossReferenceRecord;
        public RefStationAirline refStationAirline;
        public String tracingOption;
        public DelayedBagGroup delayedBagGroup;
        public Passengers passengers;
        public String handledAirlineCopyIndicator;
		public String designatedLocator;
		public AdditionalInfo additionalInfo;
        public Claim claim;
        public List<String> teletypeAddresses;
        public String agentId;
        //
        public String airlineVendorId;

    }

    public class DelayedBagGroup {
        public String bagWeight;
        public String contentsGender;
        public BagPhones bagPhones;
        public BagAddress bagAddress;
        public BagDeliveryAddress bagDeliveryAddress;
        public List<DelayedBags> delayedBags;
        public String bagLastSeen;
        public BaggageItinerary baggageItinerary;
        public String excessBaggage;
        public BagTagDestinations bagTagDestinations;
        public String matchWindow;
        public String missingWeight;
        public Boolean keysCollected; //added
    }

    public class ColorTypeDesc {
        public String colorCode;
        public Descriptor descriptor;
        public String typeCode;
        public Boolean suspended;//added
    }

    public class FlightSegmentsorARNK {
        public Flight flight;
        public Arnk arnk;
    }

    public class MiscellaneousInfo {
        public String miscInfoText;
        public String seq;
    }

    public class DelayedBags {
        public CrossReferenceRecord associatedRecord;
        public BagContents bagContents;
        public BagDelivery bagDelivery;
        public String bagDetails;
        public BagReceivedFromCustoms bagReceivedFromCustoms;
        public BagReceivedFromCustoms bagSentToCustoms;
        public BagTag bagTag;
        public BrandInfo brandInfo;
        public ColorTypeDesc colorTypeDesc;
        public String contentDescription;
        public String lockCode;
        public List<String> remarks;
        public String storageLocation;
        public UniqueId uniqueId;
    }

    public class RefStationAirline {
        public String stationAirline;
        public String stationCode;
    }

    public class Claim {
        public ClaimData claimData;
    }

    public class BagContents {
        public List<Content> content;
        public Boolean suspended; //added
    }

    public class FlightDateOrARNK {
        public FlightDate flightDate;
        public String arnk; // added
    }

    public class WR_DelayedBagWebRespRecord{
        public String success;
        public NewRecordType record;
        public NewRecordType newRecord;  //duplicado para usarlo en la response de reassign
        public List<WarningType> warnings;
        public List<ErrorType> errors;///List<Errors>
    }
    public class NewRecordType{
        public String recordType;
        public AssociatedRecord recordReference;
    }
    public class WarningType{
        public String warningCode;
        public String warningDescription;
    }
    public class ErrorType{
        public String code;//errorCode;
        public String reason;//errorDescription;
        public String timeStamp; //added 11/01/2018 new field
        //napalm temporal esperando arreglos en II
        public String errorCode;
        public String errorDescription;
    }
    public class AssociatedRecord{ 
        public String stationCode;
        public String airlineCode;
        public String referenceNumber; //Integer
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call CreateDelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    18/08/2017    Ruben Pingarron Jerez     Initial version
    01/12/2017    Alberto Puerto Collado    Completed
    11/01/2018                  Alberto Puerto Collado          Adapt? - not neccesary, wrapper is returned - new system from II to manage Errors, 
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
  	public static WR_DelayedBagWebRespRecord CreateDelayedBag(String wrapper, Integer contador){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('Llega aqui???????????????????????????????????');
            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            String aux = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags/';
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags/');

            System.debug(aux);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return CreateDelayedBag(wrapper,contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDelayedBag', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            System.debug('header: Authorization, Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            System.debug('header: Accept, application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            System.debug('timeout: 8000');
            system.debug(req);

            //WR_CreateDelayedBagWebRequest wrp = new WR_CreateDelayedBagWebRequest();
            Create_Delayed_Heroku wrq = new Create_Delayed_Heroku();

			String body = wrapper; // <----------DESCOMENTAR PARA DESHARDCODEAR
            //body = R2_CLS_WT_Bags_Management.helper_fixerJson(body);
            req.setBody(body);
            System.debug('Request body: ' + body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            System.debug('STATUS CODE -> '+res.getStatusCode());

        //napalm temporal :: borrar cuando la gestión de errores de II venga con los mismos nombres again
            WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
            
            //System.debug('::::napalm antes -> '+ res.getBody());
            //String napalm = res.getBody();
            //napalm = napalm.replaceAll('"errorCode":', '"code":');
            //napalm = napalm.replaceAll('"errorDescription":', '"reason":');
            //System.debug(':::::napalm DESPUES -> '+ napalm);

            //WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(napalm,WR_DelayedBagWebRespRecord.class);
            
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               //WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
                System.debug(':::RESP' + resp);
                return resp;
                //if(resp.errors == null || resp.errors.isEmpty()){
                //    //return '1';
                //    String registroCreadoId = JSON.serialize(resp.record);
                //    String advertenciasAlCrear = JSON.serialize(resp.warnings);
                //    String respCreado = registroCreadoId + '@splitMe@' + advertenciasAlCrear; //facilitando la vida a la visual
                //    return respCreado;
                //}else{
             	  // return JSON.serialize(resp.errors);
                //}              
            }else {
                if(contador<3 && res.getStatusCode() == 401){
                    contador+=1;
                    R1_CLS_SendCustomerMDM.login();
                    CreateDelayedBag(wrapper,contador);
                    return null;
                }else{
                    if(contador<3){
                        //String warReturn = '';
                        //for(ErrorType error : resp.errors){
                        //    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        //}
                        //System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        //return warReturn;
                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDelayedBag', wrapper, 'Error en CreateDelayedBag, fallos de login', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }

}