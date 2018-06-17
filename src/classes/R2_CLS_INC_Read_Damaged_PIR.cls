/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call ReadDelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    12/11/2017    Ismael Yubero Moreno        Initial version
    12/12/2017    Alberto Puerto Collado      MinimalFix&Rename class
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_INC_Read_Damaged_PIR{

    // COMMON TYPES CLASSES
    //-------------------------------------------------------------------------------------------
    public class AddressLine{
        public String addressLineDesc;
        public String seq;
    }
    public class State{
        public String stateDesc;
        public String stateCode;
    }
    public class Country{
        public String countryName;
        public String countryCode;
    }
    public class LocalDivInfo{
        public String divInfo;
        public String seq;
    }
    public class BagPhones{
        public String phone;
        public String seq;
    }
    public class Descriptor{
        public String mtrlElement;//materialElement;
        public List<String> otherElement;//antes no list
    }
    public class LicenseNumber{
        public Integer tagType;
        public String issuerCode;
    }
    public class BrandInfo{
        public String brandInfo;
        public Boolean suspended;
    }
    public class Emails{
        public String email;
        public String seq;
    }
    public class EmailInfo{
        public String emailInfoText;
        public String seq;
    }
    public class Faxes{
        public String fax;
        public String seq;
    }
    public class AddressType{
        public List<AddressLine> addressLine; //antes AddressLine
        public String houseNumber;
        public String streetName;
        public String apartment;
        public String city;
        public State state;
        public String postalCode;
        public Country country;
        public String validityDate;
    }
    public class RefStationAirlineType{
        public String airlineCode;
        public String stationCode;
    }
    public class FlightDate{
        public String flightNumber;
        public String flightDate;
        public String airlineCode;
        public String dateReplace;
    }
    public class OriginDestination{
        public String origin;
        public String destination;
    }
    public class Flight{
        public FlightDate flightandDate;
        public OriginDestination originDestination;
    }
    public class FlightSegmentOrARNK{
        public Flight flight; //List<Flight>
        public Flight flightAmend; //List<Flight>
        public List<Route> additionalRoutes;
        public Arnk arnk;
    }
    public class Route{
        public String route;
    }
    public class FlightDateOrARNK{
        public FlightDate flightDate;
        public String arnk;
    }
    public class BaggageItinerary{
        public List<FlightDateOrARNK> flightDateOrARNK;
    }
    public class Itinerary{
        public List<FlightSegmentOrARNK> flightSegmentsorARNK; //no lista antes
        public List<String> additionalRoutes;
    }
    public class BagDeliveryAddress{
        public AddressType deliveryAddress;
        public String deliveryWeight;
        public String deliveryInfo;
        public String divInfo;
        public String deliveryService;
        //public String deliveredTime;
        public String rDate;//datetime - bagReceivedDate
        public String bagReceivedStationCode;

        public LocalDivInfo localDivInfo;
    }
    public class Status{
        public String outForDelivery;
        public String delivered;
        public String unableToDeliver;
        public String trackingUpdate;
    }
    public class BagReceived{
        public String rDate;//Datetime - bagReceivedDate
        public String station;
    }
    public class BagDelivery{
        public String delivered;
        public Status status;
        public BagReceived bagReceived;
        public String deliveredTime; //DateTime
    }

    public class BagTag{
        public String airlineCode;
        public LicenseNumber licenseNumber;
        public String tagSequence;
        public Boolean suspended;
    }
    public class AssociatedRecord{
        public String stationCode;
        public String airlineCode;
        public String referenceNumber; //Integer
        public String recordType;
        public AssociatedRecord recordReference;
    }

    public class BagElementDetailsType{
        public Boolean bagTag;
        public Boolean brandCode;
        public Boolean bagColourAndType;
        public Boolean bagContents;
        public Boolean bagUniqueId;
        public String sequence;
    }
    public class BagElementType{ //va a desaparecer fijo
        public List<BagElementDetailsType> bagElementDetails;
    }
    public class BagDetailsType{//no
        public String bagTag;
        public String brandCode;
        public String bagColourAndType;
        public String sequence;
    }
    public class BagDetails_Good{//no
        public String bagTag;
        public String bagUniqueId;
        public String bagContents;
        public String brandCode;
        public String bagColourAndType;
        public String sequence;
    }
    public class BagType{//no!!
        public List<BagDetailsType> bagDetails;
    }
    public class UniqueID{
         public String uniqueID;
         public Boolean suspended;
    }
    public class BagSentToCustoms{
         public String bagDate;//datetime
         public String timeZone;
    }
    public class BagReceivedFromCustoms{
         public String bagDate;//datetime
         public String timeZone;
    }
    public class BagContents{
         public Boolean suspended;
         public List<Content> content;
    }
    public class Content{
         public String category;
         public String description;
    }
    public class Remarks{
        public List<String> remark;
    }
    public class ItineraryBag {
        public FlightSegments flightSegments;
        public List<String> routes;
        public FlightSegments newFlightSegments;
        public List<String> newRoutes;
    }
    public class FlightSegments {
        public List<FlightSegment> flightSegment;
    }
    public class FlightSegment {
        public FlightDate flightDate;
        public Arnk arnk;
    }
    public class Arnk {
        public OriginDestination originDestination;
    }
    public class DelayedBag{
        //public String colourCode;
        //public String typeCode;
        //public String materialElement;
        //public String otherElement;
        public ColourAndTypeType colourAndType;
        public BagTag bagTag;
        public BrandInfo brandInfo;
        public BagDelivery bagDelivery;
        public String lockCode;
        public String storageLocation;
        public String bagDetails;
        public AssociatedRecord associatedRecord;

        public String colorTypeDesc;
        public String colorCode;
        public Boolean suspended;
        //public Descriptor descriptor;
        public UniqueID uniqueID;
        public BagSentToCustoms bagSentToCustoms;
        public BagReceivedFromCustoms bagReceivedFromCustoms;
        public BagContents bagContents;
        public String contentDescription;
        public Remarks remarks; //antes no lista
        public BaggageItinerary baggageItinerary;
    }
    
    public class DamagedType{
        public String location;
        public String type_z;
        public String amount;
    }
    
    public class DamagedTypes{
    	public List<DamagedType> damagedType;
    }   
    
    public class DamagedBag{
        //public String colourCode;
        //public String typeCode;
        //public String materialElement;
        //public String otherElement;
        public ColourAndTypeType colourAndType;
        public BagTag bagTag;
        public BagTag rushTag;
        public BrandInfo brandInfo;
        public BagDelivery bagDelivery;
        public String lockCode;
        public String storageLocation;
        public String bagDetails;
        public AssociatedRecord associatedRecord;
		public DamagedTypes damagedTypes;
        public String colorTypeDesc;
        public String colorCode;
        public Boolean suspended;
        //public Descriptor descriptor;
        public UniqueID uniqueID;
        public BagSentToCustoms bagSentToCustoms;
        public BagReceivedFromCustoms bagReceivedFromCustoms;
        public BagContents bagContents;
        public String contentDescription;
        public Remarks remarks;
        public ItineraryBag itinerary; //Duplicado porque ahora read es itinerary
    }
    public class Station{
        public String stationValue;
    }
    public class DelayedBagGroup{
        public AddressType bagAddress;
        public String bagWeight;
        public String contentsGender;
        public BagDeliveryAddress bagDeliveryAddress;
        public List<BagPhones> bagPhones;
        public List<DelayedBag> delayedBags;
        public String excessBaggage;
        public Boolean keysCollected; //String
        public String missingWeight;
        public String matchWindow;

        public List<FlightDateOrARNK> bagItinerary;
        public List<Station> bagTagDestinations;
        public String bagLastSeen;
    }
    public class ContactInfo{
        public AddressType permanentAddress;
        public AddressType temporaryAddress;
        public State state;
        public Country country;
        public List<BagPhones> permanentPhones;
        public List<BagPhones> cellPhones;
        public List<BagPhones> temporaryPhones;
        public List<Emails> emails;
        public List<Faxes> faxes;
        public String validityDate;
        public String zipCode;// enombela añadido falta en el wrapper
    }
    public class TicketNumber{
        public String ticketNumberValue;
    }
    public class PassengerType{
        public List<Names> names;//strings antes
        public String givenName;
        public List<Initials> initials;
        public String title;
        public ContactInfo contactInfo;

        public String frequentFlyerId;
        public String language;
        public String ticketNumber;
        // public TicketNumber ticketNumber; - ojo cambiado con el "ultimo" metodo
        public String pnr;
        public String numberOfPassengers;
        public String autoMessageOption;
        public String passportInfo;
        public Itinerary itinerary;

        //public String origin;
        //public String destination;
        //public String arnk;
        //public String route;
        public String status;
        public String pooledTicketNumber;
        public String fareBasis;
    }
    public class MiscellaneousInfo{
        public String miscInfoText;
        public String seq;
    }
    public class SupplementaryInfo{
        public String supplimentInfoText;
        public String seq;
    }
    public class UserComments{
        public String commentsText;
        public String seq;
    }
    public class AdditionalInfo{
        public List<MiscellaneousInfo> miscellaneousInfo;
        public String furtherInfo;
        public List<SupplementaryInfo> supplementaryInfo;
        public String customsInfo;
        public List<UserComments> userComments;
    }

// ******START CLAIMS WRAPPERS**********
    public class Amount{
        public Integer amountValue; //duplicado por servicio close DAH
        public Decimal amount;//value; //ojo discrepancias amount o amountValue
        public String currencyCode;
        public Integer decimalPlace;
    }
    public class PassengerPayment{
        public Integer seq;
        public String costType;
        public Amount amount;
        //public String currencyCode;
    }
    public class ClaimAmount{
        public Boolean amountUnknown;
        public Amount amount;
    }
    public class PassengerPayments{
        public List<PassengerPayment> passengerPayment; //duplicado por servicio close DAH
        public List<PassengerPayment> passengerPaymentsValue;
    }
    public class PartnerCode{
        public String carrierCode;
        public Boolean none;
    }
    public class ToilerKits{
        public Integer male;
        public Integer female;
    }
    public class ExcessValue{
        public Amount amount;
    }
    public class ClaimData{
        public ClaimAmount claimAmount;
        public List<String> costRemarks;
        public PassengerPayments payments;  //duplicado por servicio close DAH
        public PassengerPayments passengerPayments;
        public String claimDate;
        public String notifiedDate;
        public String questionnaireDate;
        public String faultStation;  //duplicado por servicio close DAH
        public String faultStationCode;
        public String faultTerminal;
        public Boolean insurance;
        public Boolean insuranceIndicator;
        public Boolean liabilityTagIndicator;
        public String missingBags;
        public PartnerCode partnerCode;
        public String lossComments;
        public String lossReasonCode;
        public ToilerKits toilerkits;
        public Amount excessValue;
        public String tracingFinalized;
        public Boolean replacementBagIndicator; //OJO no estan en excel entonces no esta mapeado
        public Boolean repairBagIndicator;//OJO no estan en excel entonces no esta mapeado
    }
    public class Claim{
        public ClaimData claimData;
    }
// ******END CLAIMS WRAPPERS**********
     public class InboxAddressType{
        public String stationCode;
        public String airlineCode;
        public String area;
    }
    public class WarningType{
        public String warningCode;
        public String warningDescription;
    }
    public class ErrorType{
        public String code;//errorCode;
        public String reason;//errorDescription;
    }
    public class NewStationAirlineType{
        public String airlineCode;
        public String stationCode;
    }
    public class NewRecordType{
        public String recordType;
        public AssociatedRecord recordReference;
    }

// REQUEST WRAPPERS
//---------------------------------------------------------------------------------------------
    public class WR_UpdateDelayedBagWebRequest{
        public String airlineVendorId;
        public String stationCode;
        public String stationAirline;
        public String referenceNumber;
        public DelayedBagGroup delayedBagGroup;
        public List<PassengerType> passengers;
        public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public String lzControlDate;
        public NewRecordType crossReferenceRecord;
        public AdditionalInfo additionalInfo;
        public Claim claim;
        public List<InboxAddressType> inboxAddresses;
        public String promptDate;
        public String promptText;
        public String agentId;
    }
    public class WR_SuspendDelayedBagWebRequest{//OK
        public AssociatedRecord recordReference;
        //public BagElementType bag; //ya no >.<
        public List<BagElementDetailsType> bag;
        public String agentId;
        public String airlineVendorId;
        public String recordtype;
    }
    public class WR_CloseDelayed_CAH_Request{
        public AssociatedRecord record; //RecordIdentifier
        public ClaimData claim;
        public DeliveryType deliveryInfo;
        public String agentId;
        public List<SupplementaryInfoType> supplementalInfo;
        public List<RecordIdentifier> crossReferenceRecord;
        public String handledAirlineCopy;
    }
    public class WR_ReopenDelayedBagWebRequest{ //OK
        public AssociatedRecord recordReference;
        public NewStationAirlineType newStationAirline;
        public BagType bagElements;
        public String agentId;
    }

    public class WR_ReinstateDelayedBagWebRequest{ //OK
        public AssociatedRecord recordReference;
        public BagElementType bag;
        public String agentId;
    }
    public class WR_ReassignDelayedBagWebRequest{//OK
        public AssociatedRecord recordReference;
        public NewStationAirlineType newStationAirline;
        public String agentId;
    }
    public class WR_GenerateDelayedBagWebRequest{ //OK
        public AssociatedRecord recordReference;
        public String agentId;
        public String languageCode;
    }
    public class WR_CreateDelayedBagWebRequest{ //OK
        public String airlineVendorId;
        public RefStationAirlineType refStationAirline;
        public String tracingOption;
        public DelayedBagGroup delayedBagGroup;
        public PassengerType passenger;
        public NewRecordType crossReferenceRecord;
        public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public AdditionalInfo additionalInfo;
        public Claim claim;
        public List<String> teletypeAddresses;
        public String agentId;
    }
    public class Warnings{
        public List<WarningType> warning;
    }
    //public class Errors{//sobre segun json no en xls
    //   public List<ErrorType> error;
    //}
    //DAMAGED REQUEST
    public class WR_CloseDamaged_CFI_Request{
        public AssociatedRecord record;
        public ClaimData claim;
        public String agentId;
    }
// ******************************************************RESPONSE DELAYED ********************************************************
    public class WR_DelayedBagWebResp{
        public String success;
        public List<WarningType> warnings;
        public List<errorType> errors;
    }
    public class WR_DelayedBagWebRespRecord{
        public String success;
        public NewRecordType record;
        public List<WarningType> warnings;
        public List<errorType> errors;///List<Errors>
    }
    public class WR_DelayedBagWebRespReport{
        public String success;
        public String reportOutput;
        public List<WarningType> warnings;
    }
//******************************************************RESPONSE DAMAGED ********************************************************
    //Create
    public class WPCreateDamagedBagWebResponse{
        public String success;
        public NewRecordType record;
        public Warnings warnings;
    }
    //Generate
    public class WPGenerateDamagedBagReportWebResponse{
        public String success;
        public String reportOutput;
        public List<WarningType> warnings;
    }
    //Reassign
    public class WPReassignDamagedBagWebResponse{
        public String success;
        public NewRecordType newRecord;
        public List<WarningType> warnings;
    }
    //Update
    public class WPUpdateDamagedBagWebResponse{
        public String success;
        public List<WarningType> warnings;
    }
    //Close
    public class WPCloseDamaged_CFI_Response{
        public String success;
        public List<WarningType> warnings;
    }

//****************************************************** ONHAND ********************************************************
     //Response
    public class WPRequestOnHandBagWebResponse{
        public String success;
        public List<WarningType> warnings;
    }
    //Request
    public class WPRequestOnHandBagWebRequest{
        public String airlineVendorId;
        public AssociatedRecord delayedBag; //WPBagRecordType
        public List<AssociatedRecord> onHandBags; // WPBagRecordType
        public List<AssociatedRecord> quickOnHandBags; // WPBagRecordType
        public List<BagTag> bagTags; //Bagtagtype
        public List<String> passengerName;
        public List<String> supplementaryText;
        public String storageLocation;
        public String furtherInfo;
        public List<String> teletypeAddress;
        public String agentId;
    }


//search
    public class Names {
        public String name;
        public String nameValue;
        public String seq;
    }
    public class Initials {
        public String initial;
        public String initialValue;
        public String seq;
    }
    public class SearchRetiredBagRecordType{
        public RecordIdentifier recordIdentifier; //antes String
        public String status;
        public Names names; //antes String
        public Initials initials; //antes String
        public List<BagType> originalBags; //BagType
        public BagType rushBags;
        public String createDate;
        public String lossReasonCode;
        public String furtherInfo;
        public String agentId;
    }

//SEARCH REQUEST
// ******* Search Retired Records Request V01 **********
public class Wp_SearchRetired_Request{
    public RecordType recordType;
    public String dateReplace;
    public Names name;
    public String agentId;
}
//SEARCH RESPONSE
public class Wp_SearchRetiredRecordsWeb_Response{
        public String success;
        public List<SearchRetiredBagRecordType> bagRecords; //SearchRetiredBagRecordType
        public WarningType warnings;
    }
   //RETRIEVE DELAYED
public class RecordHistory {
        public List<String> history;
}

//REQUEST
// ******* Retrieve Delayed Bag Retired Record Web Request V01 **********
    public class Wp_RetrieveDelayedBag_Request{
        public String airlineVendorId;
        public RecordType recordId;
        public String rDate;//reserved: Date;
        public String agentId;
    }
//RESPONSE
public class Wp_RetrieveDelayedBag_Response{
        public String success;//ok
        public List<WarningType> warnings;
        public DiaryInfoType diaryInfo;//ok wp_DiaryInfoType
        public BagGroupType  delayedBagGroup;//ok DelayedBagGroup
        public PassengerType passengers;//ok wp_PassengerType
        public AdditionalInfo additionalInfo; //wp_AdditionalInfoType
       // public Claim claim; //wp_ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<String> internetInfo;
        public List<String> smsInfo;
        public List<EmailInfo> emailInfo;
        public List<String> history;
        public List<String> matchHistory;
        public RecordHistory recordHistory; //ok
        public String recordStatus;//ok
    }


//REQUEST
    // ******* Retrieve Damaged Bag Retired Record Web Request V01 **********
    public class Wp_RetrieveDamagedBag_Request{
        public String airlineVendorId;
        public RecordType recordId; //BagRecordType
        public String rDate;//reserved: Date;
        public String agentId;
    }
//RESPONSE
// ******* Retrieve Damaged Bag Retired Record Web Response  V01 **********
    public class Wp_RetrieveDamagedBag_Response{
        public String success;
        public List<WarningType> warnings;
        public DiaryInfoType diaryInfo;
        public BagGroupType damagedBagGroup; //DamagedBagGroupType
        public PassengerType passengers;
        public AdditionalInfoType addditionalInfo;
        public Claim claim; //ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<String> internetInfo;
        public List<String> smsInfo;
        public List<EmailInfo> emailInfo;
        public List<String> history;
        public List<String> matchHistory;
        public String recordStatus;
    }

//****************************************************** STATION & COMMUNICATION ********************************************************
    public class ValuesType{
        public List<String> value;
    }

    public class SubPropertyType{
        public String subtypedescription;
        public ValuesType subtypevalues;
    }

    public class StationPropertyType{
        public String stationPropertyDescription;
        public List<SubPropertyType> stationPropertySubType;
    }

    public class StationType{
        public List<StationPropertyType> stationProperty;
        public String stationValue;
        public ValuesType stationValues;
    }
    public class StationConfig{
        public Handler handler;
        public List<Participancy> participancy;
        public DefaultAddress defaultAddress;
        public List<MatchDivryAttribs> matchDivryAttribs;
        public Options options;
        public StationConfigAttributes stationConfigAttributes;

    }
        public class Handler{
            public String current;
            public String newReplace;
            public String effectiveDate;
        }
        public class Participancy{
            public String module;
            public String status;
            public String access;
        }
        public class DefaultAddress{
            public String email;
            public String tty;
        }
        public class MatchDivryAttribs{
            public Integer seq;
            public String stationCode;
            public String airlineCode;
            public String tty;
            public String days;
        }
        public class Options{
            public String lzControlled;
            public String sitaRef;
        }
        public class StationConfigAttributes{
            public String stationCode;
            public String airlineCode;
            public String updateDate;
        }



// RESPONSE WRAPPERS
  //-------------------------------------------------------------------------------------------
    public class WR_MessageListWebResp{
        public String success;
        public List<WarningType> warnings;
        public List<errorType> errors;
    }
    public class WR_MessageWebResp{
        public String success;
        public WarningType warnings;
        public List<errorType> errors;
    }

    public class WR_StationWebResp{
        public String success;
        public StationType stations;
        public List<WarningType> warnings;
        public List<errorType> errors;
        public StationConfig stationConfig;

    }
    public class WR_ReadInboxMessageResp{
        public String success;
        public List<WarningType> warnings;
        public MessagesType messages;
        public List<errorType> errors;
    }
    public class MessagesType{
        public String messageCount;
        public List<ReadInboxMessageType> messages;
        public List<errorType> errors;
    }
    public class ReadInboxMessageType{
        public String dateTemp;
        public String sequenceNumber;
        public String message;
    }
    public class DestinationType{
        public String stationcode;
        public String airlinecode;
        public String area;
        public String sequence;
    }
    public class MessageDeliveryType{
        public String messagedeliverytime;
        public String messagedeliveryfromDate;
        public String messagedeliverytodate;
    }
    public class RecordIDType{
        public List<AssociatedRecord> Recordid; //BagRecordType
    }
    public class OriginType{
        public String teletypeaddress;
        public String chargeableairline;
    }
     // REQUEST WRAPPERS
 //---------------------------------------------------------------------------------------------
    public class WR_InboxMessageSend_PXFWebReq{
        public String airlinevendorid;
        public List<DestinationType> destinationinboxaddress;
        public String handledoption;
        public String originstation;
        public String message;
        public List<AssociatedRecord> records; // BagRecordType
        public MessageDeliveryType messagedelivery;
        public List<String> teletypeaddress;
        public String agentid;
        public String version;
    }

    public class WR_SendTeletypeMessageWebReq{
        public OriginType origin;
        public List<String> destinationteletypeaddress;
        public List<RecordIDType> copyto;
        public String message;
        public String agentid;
        public String airlinevendorid;
    }

    public class WR_DisplayStationListWebReq{
        public String status;
        public String airlinevendorid;
        public String airline;
        public String agentid;
    }

    public class ReferenceStationAirline{
        public String stationCode;
        public String airlineCode;
    }
    public class WR_DisplayStationScreenWebReq{
        //public String airlinevendorid;
        //public AssociatedRecord record;
        public ReferenceStationAirline referenceStationAirline;
        public String agentId;
    }
    public class WR_ReadInboxMessageReq{}

//****************************************************** SEARCH & RETRIEVE ********************************************************
//common search&rushSearch
    public class DateRangeType{
        public String fromDate;
        public String toDate;
    }
    public class ItineraryBagType{
        public String flightUnknown;
        public String airlineCode;
        public String flightNumber;
        public DateRangeType dateRange;
        public String route;
    }
    public class BagSearchType{
        public DateRangeType bagCreateDate;
        public DateRangeType bagControlDate;
        public BagTag bagTag; //BagTagType
        public ColourAndTypeType colourAndType;
        public String brandInfo;
        public Content contents; // BagContentType
    }
  /*  public class DescriptorType{
        public String materialElement;
        public String otherElement;
    }*/
    public class ColourAndTypeType{
        public Boolean suspended;
        public String colourCode;
        public String typeCode;
        public Descriptor descriptor;
    }
    public class NameExactType{
        public String name;
        public String exact;
    }
    //HEROKU SEARCH - extra
    public class RecordIdentifier {
        public String recordType;
        public RecordReference recordReference;
    }
    public class RecordReference {
        public String stationCode;
        public String airlineCode;
        public StationAirlineGroup stationAirlineGroup;
        public String referenceNumber;
    }
    public class StationAirlineGroup{
        public String stationCode;
        public String airlineCode;
    }
    public class ColourCode {
        public Boolean suspended;
        public String colorCode;
        public String typeCode;
    }
    public class OriginalBags {
        public BagTag bagTag;
        public ColourCode colourCode;
        public FlightDateOrARNK flightDateOrARNK;
    }
    public class BagRecords {
        public RecordIdentifier recordIdentifier;
        public String status;
        public List<String> names;
        public List<String> initials;
        public List<OriginalBags> originalBags; //OriginalBags
    }

    //REQUEST SEARCH & RUSH SEARCH
    public class WpReqSearch{
        public String bagType;
        public String searchType;
        public String refStationCode;
        public String refAirlineCode;
        public String recordStatus;
        public String HandledOption;
        public NameExactType name;
        public String missingStationCode;
        public String missingAirlineCode;
        public BagSearchType Bag;
        public String uniqueId;
        public ItineraryBagType Itinerary;
        public String status;
        public String frequentFlyerAirline;
        public String tempAddressInd;
        public InboxAddressType InboxAddress;
        public String teletypeAddress;
        public String email;
        public String agentId;
        public String phoneNumber;
        public String emailAddress;
        public String quickOnHandOption;
        public String searchByQoh;
    }

    public class WpReqSearchForward{
        public String recordType;
        public String searchType;
        public RefStationAirlineType RefStationAirLine;
        public String name;
        public String missingStationCode;
        public String missingAirlineCode;
        public DateRangeType DateRange;
        public BagTag rushBagTag; //BagTagType
        public BagTag bagTag; // BagTagType
        public String rushRouteStationCode;
        public String rushRouteAirlineCode;
        public FlightDate rushFlight; // FlightType
        public FlightDate originalFlight; // FlightType
        public String inboxAddressStationCode;
        public String inboxAddressAirlineCode;
        public String area;
        public String teletypeAddress;
        public String email;
        public String agenId;
        public String trainingIndicator;
    }

    //RESPONSE SEARCH & RUSH SEARCH
    public class WpResForward{
        public String success;
    }
    public class WpResSearch{
        public String success;
        public List<BagRecords> bagRecords; //BagRecordType //AssociatedRecord
        public List<WarningType> warnings;
    }

 //ONHAND
 public class AdditionalInfoType{
        public List<MiscellaneousInfo> miscellaneousInfo;  //List<MiscellaneousInfoType> miscellaneousInfo
        public String furtherInfo;
        public List<SupplementaryInfoType> supplementaryInfo;
        public String customsInfo;
        public List<UserComments> userComments;
        public List<DeliveryInfoType> deliveryInfo;
        public List<MessageInfoType> messageInfo;
        public List<MatchInfoType> matchInfo;

    }
    public class MatchInfoType{
        public String matchInfoText;
        public String seq;
    }
    public class MessageInfoType{
        public String messageInfoText;
        public String seq;
    }
    public class DeliveryInfoType{
        public String deliveryInfoText;
        public String seq;
    }
    public class SupplementaryInfoType{
        public String supplimentInfoText;
        public String seq;
    }
    public class UserCommentsType{
        public String commentsText;
        public String seq;
    }
    public class PartnerCodeType{
        public String carrierCode;
        public String none;
    }
    public class RecordHistoryType{
        public List<String> history;
        public String matchHistory;
    }
    public class AddressTypeBag{
        public List<AddressLine> addressLine;
        public String houseNumber;
        public String streetName;
        public String apartment;
        public String city;
        public State state;
        public String postalCode;
        public Country country;
    }
    public class BagGroupType{
        public AddressTypeBag bagAddress; //AddressType
        public String bagWeight;
        public String baggageWeight;//de inactive ia
        public String contentsGender;
        public DeliveryType delivery;
        public List<BagPhones> bagPhones; //bagPhones
        public List<DamagedBag> damagedBags;
        public List<DelayedBag> delayedBags; //BagType
        public BagType onHandBags;
        public String bagLastSeen;
        public BaggageItinerary bagItinerary;//BagItinerary bagItinerary;
        public String excessBaggage;
        public BagTagDestinationsType bagTagDestinations;
        public Boolean keysCollected;
        public String missingWeight;
        public String matchWindow;
        public List<String> lostContents;
        public String contentsDamageDesc;
    }
     public class DeliveryType{
        public AddressType  deliveryAddress;
        public String deliveredTime;
        public BagReceived bagReceived;
        public String deliveryWeight;
        public List<DlvInfoType>  localDeliveryInfo; //DlvInfoType
        public List<DeliveryServiceType>  deliveryService;
        public List<DlvInfoType>  localDivInfo; //para inactive de aqui hacia abajo
    }
    public class DlvInfoType{
        public String dlvInfo;//DvInfo;
        public String seq;
    }
    public class DeliveryServiceType{
        public String deliveryServiceDesc;
        public String seq;
    }
    public class BagTagDestinationsType{
        public List<StationType> station;
    }
    public class DiaryInfoType{
        public String createDate; //strings//dateTime
        public String suspendDate;//dateTime
        public String tracingDate;//dateTime
        public String closeDate;//dateTime
        public String reinstateDate;//dateTime
        public String rematchDate;//dateTime
        public String lzControlDate;//dateTime
        public String retiredDate;//dateTime
        public NewRecordType associateRecord;
        public List<NewRecordType> crossReferenceRecord; //
        public String disposalDate;
        public String controllingStation;
        public String tracingFinalizedDate;
        public String claimInvestigationDate;//Datetime
        public String inventoryReceivedDate;//Datetime
        public String tracingExtendedDate;//Datetime
    }
//ONHAND REQUEST
    public class WpReq_ReadOnHand_DOH{
        public String airlineVendorId;
        public NewRecordType recordId;
        public String agentId;
        public String history;
        public String recordAreas;
    }
//ONHAND RESPONSE
    //public class WpResOnHandBag{
    //    public String success;
    //    public List<WarningType> warnings; //WarningsType Warnings;
    //    public DiaryInfoType DiaryInfo;
    //    public BagGroupType OnHandBagGroup;
    //    public PassengerType Passengers;
    //    public PartnerCodeType partnerCode;
    //    public String handledAirlineCopyIndicator;
    //    public String designatedLocator;
    //    public String textInfo;
    //    public AdditionalInfoType additionalInfo;
    //    public String smsInfo;
    //    public List<EmailInfo> emailInfo;//String emailInfo;
    //    public RecordHistoryType recordHistory;
    //    public String recordStatus;
    //}
    //DELAYED Retrieve

//DELAYEDRetrieve REQUEST
    public class WpReq{
        public NewRecordType recordId;
        public String agentId;
        public String history;
        public String recordAreas;
    }
//DELAYEDRetrieve RESPONSE
    public class Wp_readDelayed_AHL_DAH{
        public String success;
        public List<WarningType> warnings; //WarningsType Warnings;
        public DiaryInfoType diaryInfo;
        public BagGroupType delayedBagGroup;
        public PassengerType passengers;
        public AdditionalInfoType additionalInfo;
        public Claim claim; //ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public String smsInfo;
        public List<EmailInfo> emailInfo;//String emailInfo;
        public RecordHistoryType recordHistory;
        public String recordStatus;
    }
    //DAMAGED Retrieve

//DAMAGEDRetrieve REQUEST == delayedRetrieve, comprobar de todas formas en el mapeo

//DAMAGEDRetrieve RESPONSE
    public class Wp_readDamaged_DPR_DDP{
        public String success;
        public List<WarningType> warnings; //WarningsType Warnings;
        public DiaryInfoType diaryInfo;
        public BagGroupType damagedBagGroup;
        public PassengerType passengers;
        public AdditionalInfoType additionalInfo;
        public Claim claim; //ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<SmsInfo> smsInfo;
        public List<EmailInfo> emailInfo;//String emailInfo;
        public RecordHistoryType recordHistory;
        public String recordStatus;
    }

    public class SmsInfo{
        public String seq;
        public String smsinfoText;
    }
    //WRAPPER universal para utilizar en caller universal :D
    public class WrapperBigBigOne_Request{
        public WpReq_ReadOnHand_DOH readOnHand_DOH;
        public WpReq regGen;
        public WpReqSearchForward searchForward;

        public String search; //WpReqSearch
        public String read;
        public String wrp_close_DAH;

    }

    final static Map<String,Id> map_RT = new Map<String,Id>();

    static{
        for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE sObjectType = 'R1_Incident__c']) {
            map_RT.put(rt.DeveloperName, rt.Id);
        }
    }

    
    public static Id ReadRecord_DPR_DDP (String wrapper, Integer intentos,  Boolean cambiarNumPIR){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Retrieves Delayed Bag
    IN:
    OUT:
    History:
    <Date>                     <Author>                         <Change Description>
    18/08/2017                 Ismael Yubero Moreno         Initial Version
    28/11/2017                 David Rufo Valero            Modify Version
    09/01/2018                 Alvaro Garcia Tapia          Adapt new system from II to manage Errors, 
    "        "                  "                "            now several errors will be reported with status 200 and success = false
    09/03/2018                 Alberto Puerto Collado       Added replaceAll for wrapper in order to evade \n & \r
    27/03/2018                 Alvaro Garcia Tapia        Added wrapper in catch
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
        System.debug('Wp_readDamaged_DPR_DDP - ReadRecord_DPR_DDP');
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}  //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;



            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            System.debug(' --> Token: ' +  token);
            System.debug(' --> Intentos: '+ intentos);
            if(token==null){
          if(intentos<3){
                           intentos = intentos+1;
                         R1_CLS_SendCustomerMDM.login();
                         return ReadRecord_DPR_DDP(wrapper, intentos, cambiarNumPIR);
          }else{
              R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
              return null;
              }
          }

            String wsMethod = 'R2_SearchBags';
            R1_CS_Endpoints__c r1CsEndpoints = R1_CS_Endpoints__c.getInstance(wsMethod);
            System.debug(r1CsEndpoints);
            if(r1CsEndpoints == null || !r1CsEndpoints.R1_CHK_Activo__c){
                return null;
            }

            HttpRequest req = new HttpRequest();
            String endPoint = r1CsEndpoints.R1_TXT_EndPoint__c + 'damaged-bags';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            // ************* SERIALIZE *********
            //WpReq wrp =  new WpReq();
            //String body = JSON.serialize(wrp);
            //String body = '{"recordId": {"recordType": "DAMAGED","recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "73042"}},"agentId": "12"}';

            //wrapper = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapper);
            wrapper = wrapper.replaceAll('\n',' - ').replaceAll('\r',' - ');
            //wrapper = wrapper.replaceAll('\\','');
            req.setBody(wrapper);

            System.debug('*** wrapper in body: '+ wrapper);

            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('Status' + res.getStatusCode());

            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                //***********TRANSFORMANDO DATETIME A SF FORMAT*********
                String bodyJson = res.getBody();
                bodyJson = bodyJson.replaceAll('"type":', '"type_z":');
                bodyJson = bodyJson.replaceAll('"date":', '"rDate":');
                bodyJson = R2_CLS_WT_Bags_Management.helper_fixerJson(bodyJson); 
                //bodyJson = bodyJson.replaceAll('(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1.000$3');
                System.debug('--> Body modificado: ' + bodyJson);

                Wp_readDamaged_DPR_DDP resp = (Wp_readDamaged_DPR_DDP) JSON.deserialize(bodyJson, Wp_readDamaged_DPR_DDP.class);
                if(resp.success == 'TRUE'){    
                    System.debug('Ha funcionado bien el deserialize');

                    //MAPEO DEL RESPONSE
                    R1_Incident__c pirResp = new R1_Incident__c();
                    //obligamos a que todos los valores tengan su valor por defecto para que al hacer el update lo que no se rellene en el mapeo se quede con valor predeterminado
                    R1_CLS_Utilities.resetObject(pirResp, 'R1_Incident__c', false);

                    pirResp.RecordTypeId = map_RT.get('DAMAGED');
                    List<R2_Auxiliar_Data_Incident__c> listaAuxInc = new List<R2_Auxiliar_Data_Incident__c>();
                    List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
                    List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();
                    if(resp.diaryInfo !=null){
                        pirResp.R2_INC_DAT_PIR_Claims_Created_Date__c = resp.diaryInfo.createDate != null ? Date.valueOf(resp.diaryInfo.createDate) : null;
                        pirResp.R2_INC_DAT_PIR_Cancellation_date__c = resp.diaryInfo.suspendDate != null ? Date.valueOf(resp.diaryInfo.suspendDate) : null;
                        pirResp.R2_INC_DAT_PIR_Search_start_date__c = resp.diaryInfo.tracingDate != null ? Date.valueOf(resp.diaryInfo.tracingDate) : null;
                        if (resp.diaryInfo.closeDate != null) {
                            String auxTime = resp.diaryInfo.closeDate.removeEnd('Z');
                            List<String> auxTimeLst = auxTime.split('[-:T]');
                            pirResp.R2_INC_DATH_PIR_Incidence_closed_date__c = Datetime.newInstanceGMT(Integer.ValueOf(auxTimeLst[0]), Integer.ValueOf(auxTimeLst[1]), Integer.ValueOf(auxTimeLst[2]), Integer.ValueOf(auxTimeLst[3]), Integer.ValueOf(auxTimeLst[4]), Integer.ValueOf(auxTimeLst[5]));//Datetime.valueOf(auxTime);
                        }
                        pirResp.R2_PIR_DAT_PIR_Full_reintegration_date__c = resp.diaryInfo.reinstateDate != null ? Date.valueOf(resp.diaryInfo.reinstateDate) : null;
                        pirResp.R2_INC_DAT_PIR_Last_mapping_date__c = resp.diaryInfo.rematchDate != null ? Date.valueOf(resp.diaryInfo.rematchDate) : null;
                        pirResp.R2_INC_DAT_PIR_Control_date__c = resp.diaryInfo.lzControlDate != null ? Date.valueOf(resp.diaryInfo.lzControlDate) : null;
                        pirResp.R2_INC_DAT_PIR_Date_back_primary_search__c = resp.diaryInfo.retiredDate != null ? Date.valueOf(resp.diaryInfo.retiredDate) : null;


                        //ASSOCIATE RECORDS (AR) -> crossReferenceRecord crear objeto y guardar -> lista de 0 a 5
                        //objeto tal new objeto();
                        if(resp.diaryInfo.associateRecord !=null){
                            pirResp.R2_INC_TXT_PIR_AR_RecordType__c = resp.diaryInfo.associateRecord.recordType;
                            if(resp.diaryInfo.associateRecord.recordReference != null){
                                pirResp.R2_INC_TXT_PIR_AR_Station_Code__c = resp.diaryInfo.associateRecord.recordReference.stationCode;
                                pirResp.R2_INC_TXT_PIR_AR_Airline_Code__c = resp.diaryInfo.associateRecord.recordReference.airlineCode;
                                pirResp.R2_INC_TXT_PIR_AR_Reference_Number__c = resp.diaryInfo.associateRecord.recordReference.referenceNumber;
                            }
                        }
                        if(resp.diaryInfo.crossReferenceRecord != null){
                            String xr = '';
                            for(Integer i=0; i<resp.diaryInfo.crossReferenceRecord.size(); i++){
                                if(resp.diaryInfo.crossReferenceRecord[i].recordReference != null){
                                    if (resp.diaryInfo.crossReferenceRecord[i].recordType == 'DELAYED') {
                                        xr += 'AHL' + ' ';
                                    }
                                    else if (resp.diaryInfo.crossReferenceRecord[i].recordType == 'DAMAGED') {
                                        xr += 'DPR' + ' ';
                                    }
                                    else if (resp.diaryInfo.crossReferenceRecord[i].recordType == 'ON-HAND') {
                                        xr += 'OHD' + ' ';
                                    }
                                    else if (resp.diaryInfo.crossReferenceRecord[i].recordType == 'RUSH') {
                                        xr += 'FWD' + ' ';
                                    }
                                    xr += resp.diaryInfo.crossReferenceRecord[i].recordReference.stationCode;
                                    xr += resp.diaryInfo.crossReferenceRecord[i].recordReference.airlineCode;
                                    xr += resp.diaryInfo.crossReferenceRecord[i].recordReference.referenceNumber +'/';
                                }
                            }
                            xr = xr.removeEnd('/');
                            pirResp.R2_INC_TXT_PIR_Others_PIR_Associated_XR__c = xr;
                            //for(Integer i=0; i<resp.diaryInfo.crossReferenceRecord.size(); i++){
                            //    if(resp.diaryInfo.crossReferenceRecord[i].recordReference != null){
                            //        R2_Auxiliar_Data_Incident__c xr = new R2_Auxiliar_Data_Incident__c();
                            //        xr.R2_ADI_TXT_XR_Station_Code__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.stationCode;
                            //        xr.R2_ADI_TXT_XR_Airline_Code__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.airlineCode;
                            //        xr.R2_ADI_TXT_XR_Reference_Number__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.referenceNumber;
                            //        xr.R2_ADI_PKL_Type__c = 'XR';
                            //        listaAuxInc.add(xr);
                            //    }
                            //}
                        }
                        pirResp.R2_INC_TXT_PIR_Control_office__c = resp.diaryInfo.controllingStation;
                        pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = resp.diaryInfo.tracingFinalizedDate != null ? Date.valueOf(resp.diaryInfo.tracingFinalizedDate) : null;
                    }
                    //Naranja claimInvestigationDate
                    //adressLine-> lista de 2
                    //baggrouptype
                    if(resp.damagedBagGroup != null){
                        if(resp.damagedBagGroup.bagAddress != null){
                            if(resp.damagedBagGroup.bagAddress.addressLine != null){
                                //for (AddressLine address : resp.damagedBagGroup.bagAddress.addressLine) {
                                //    if (address.seq == '1') {
                                //        pirResp.R2_INC_TXT_PIR_Address_in_suitcase1__c = address.addressLineDesc;
                                //    }
                                //    else if (address.seq == '2') {
                                //        pirResp.R2_INC_TXT_PIR_Address_in_suitcase2__c = address.addressLineDesc;
                                //    }
                                //}
                                pirResp.R2_INC_TXT_PIR_Address_in_suitcase1__c = resp.damagedBagGroup.bagAddress.addressLine[0].addressLineDesc;
                                if(resp.damagedBagGroup.bagAddress.addressLine.size() == 2){
                                    pirResp.R2_INC_TXT_PIR_Address_in_suitcase2__c = resp.damagedBagGroup.bagAddress.addressLine[1].addressLineDesc;
                                }
                            }
                            //city pirResp. = resp.delayedBagGroup.city;
                            if(resp.damagedBagGroup.bagAddress.state != null){
                                //State pirResp. = resp.damagedBagGroup.state.stateDesc;
                                //State pirResp. = resp.damagedBagGroup.state.stateCode;
                            }
                            //postalCode pirResp. = resp.damagedBagGroup.postalCode;
                            if(resp.damagedBagGroup.bagAddress.country != null){
                                //Country pirResp. = resp.damagedBagGroup.country.countryName;
                                //Country pirResp. = resp.damagedBagGroup.country.countryCode;
                            }
                        }
                        pirResp.R2_INC_TXT_PIR_Baggage_Weight_piece__c = resp.damagedBagGroup.bagWeight;
                        //DELIVERY
                        if(resp.damagedBagGroup.delivery != null){
                            if(resp.damagedBagGroup.delivery.deliveryAddress != null){
                                if(resp.damagedBagGroup.delivery.deliveryAddress.addressLine != null){
                                    for (AddressLine address : resp.damagedBagGroup.delivery.deliveryAddress.addressLine) {
                                        if (address.seq == '1') {
                                            pirResp.R2_INC_TXT_PIR_Delivery_address1__c = address.addressLineDesc;
                                        }
                                        else if (address.seq == '2') {
                                            pirResp.R2_INC_TXT_PIR_Delivery_address2__c = address.addressLineDesc;
                                        }
                                    }
                                    //pirResp.R2_INC_TXT_PIR_Delivery_address1__c = resp.damagedBagGroup.delivery.deliveryAddress.addressLine[0].addressLineDesc;
                                    //if(resp.damagedBagGroup.delivery.deliveryAddress.addressLine.size() == 2){
                                    //    pirResp.R2_INC_TXT_PIR_Delivery_address2__c = resp.damagedBagGroup.delivery.deliveryAddress.addressLine[1].addressLineDesc;
                                    //}
                                }
                            }
                            pirResp.R2_INC_TXT_PIR_Baggage_Weight_delivered__c = resp.damagedBagGroup.delivery.deliveryWeight;
                            if(resp.damagedBagGroup.delivery.localDeliveryInfo != null){
                                for (DlvInfoType dlv : resp.damagedBagGroup.delivery.localDeliveryInfo) {
                                    if (dlv.seq == '1') {
                                        pirResp.R2_INC_TXT_PIR_Delivery_local_informatio__c = dlv.dlvInfo;
                                    }
                                    else if (dlv.seq == '2') {
                                        pirResp.R2_INC_TXT_PIR_Deliver_local_informatio2__c = dlv.dlvInfo;
                                    }
                                }
                                //pirResp.R2_INC_TXT_PIR_Delivery_local_informatio__c = resp.damagedBagGroup.delivery.localDeliveryInfo[0].dlvInfo;
                                //if(resp.damagedBagGroup.delivery.localDeliveryInfo.size() == 2){
                                //    pirResp.R2_INC_TXT_PIR_Deliver_local_informatio2__c =  resp.damagedBagGroup.delivery.localDeliveryInfo[1].dlvInfo;
                                //}
                            }
                            //deliveryservice
                            if(resp.damagedBagGroup.delivery.deliveryService != null){
                                for(Integer i=0; i<resp.damagedBagGroup.delivery.deliveryService.size(); i++){ //10
                                    R2_Auxiliar_Data_Incident__c ds = new R2_Auxiliar_Data_Incident__c();
                                    ds.R2_ADI_ATXTL_DS_Delivery_service__c = resp.damagedBagGroup.delivery.deliveryService[i].deliveryServiceDesc;
                                    ds.R2_ADI_PKL_Type__c = 'DS';
                                    //R2_Auxiliar_Data_Incident__c.R2_ADI_ATXTL_DS_Delivery_service__c = resp.damagedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                    //pirResp.R2_INC_ATXTL_PIR_Delivery_service__c += resp.damagedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                    listaAuxInc.add(ds);
                                }
                            }
                        }
                        if(resp.damagedBagGroup.bagPhones != null){
                            for (BagPhones phone : resp.damagedBagGroup.bagPhones) {
                                if (phone.seq == '1') {
                                    pirResp.R2_INC_TLF_PIR_Phone_number_suitcase1__c = phone.phone;
                                }
                                else if (phone.seq == '2') {
                                    pirResp.R2_INC_TLF_PIR_Phone_number_suitcase2__c = phone.phone;
                                }
                            }
                            //pirResp.R2_INC_TLF_PIR_Phone_number_suitcase1__c = resp.damagedBagGroup.bagPhones[0].phone;
                            //if(resp.damagedBagGroup.bagPhones.size() == 2){
                            //    pirResp.R2_INC_TLF_PIR_Phone_number_suitcase2__c = resp.damagedBagGroup.bagPhones[1].phone;
                            //}
                        }
                        //public List<BagType> damagedBags; - de 0 a 10 R2_Baggage__c (pero en el excel pone de 0 a 2)
                        
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////mapeo de maletas/////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //6 delayed bags
                        if(resp.damagedBagGroup.damagedBags != null){
                            R2_Baggage__c bag;
                            List<String> lstLossComments = new List<String>();
                            if (resp.claim != null && resp.claim.claimData != null && resp.claim.claimData.lossComments != null) {
                                lstLossComments = resp.claim.claimData.lossComments.split('/');
                            }
                            
                            Integer contadorRC = 0;
                            for(DamagedBag bGroupType : resp.damagedBagGroup.damagedBags){
                                bag = new R2_Baggage__c();
                                //master detail a incidencia
                                bag.R2_BAG_MSDT_Incident__c = pirResp.Id;

                                if(bGroupType.colourAndType != null){
                                    bag.R2_BAG_CHK_Suspended__c = bGroupType.colourAndType.suspended != null ? bGroupType.colourAndType.suspended : false;
                                    bag.R2_BAG_PKL_Colour__c = bGroupType.colourAndType.colourCode;
                                    
                                    if (bGroupType.colourAndType.typeCode == '22') {
                                        if (bag.R2_BAG_CHK_Rigid__c) {
                                            bag.R2_BAG_PKL_Type__c = '22R';
                                        }
                                        else if (bag.R2_BAG_CHK_Mixed__c) {
                                            bag.R2_BAG_PKL_Type__c = '22D';
                                        }
                                        else {
                                            bag.R2_BAG_PKL_Type__c = '22';
                                        }
                                    }
                                    else {
                                        if (bGroupType.colourAndType.typeCode.length() == 1) {
                                            bag.R2_BAG_PKL_Type__c = '0' + bGroupType.colourAndType.typeCode;
                                        }
                                        else {
                                            bag.R2_BAG_PKL_Type__c = bGroupType.colourAndType.typeCode;
                                        }
                                    }

                                    //checkboxes de descriptor - material elements
                                    if(bGroupType.colourAndType.descriptor != null){
                                        if(bGroupType.colourAndType.descriptor.mtrlElement == 'M'){
                                            bag.R2_BAG_CHK_Metal__c = true;
                                        }else if(bGroupType.colourAndType.descriptor.mtrlElement == 'R'){
                                            bag.R2_BAG_CHK_Rigid__c = true;
                                        }else if(bGroupType.colourAndType.descriptor.mtrlElement == 'D'){
                                            bag.R2_BAG_CHK_Mixed__c = true;
                                        }else if(bGroupType.colourAndType.descriptor.mtrlElement == 'L'){
                                            bag.R2_BAG_CHK_Leather__c = true;
                                        }else if(bGroupType.colourAndType.descriptor.mtrlElement == 'T'){
                                            bag.R2_BAG_CHK_Printed_fabric__c = true;
                                        }
                                        //checkboxes de descriptor - other elements
                                        if(bGroupType.colourAndType.descriptor != null &&
                                                bGroupType.colourAndType.descriptor.otherElement != null){

                                            for(String des : bGroupType.colourAndType.descriptor.otherElement){
                                                if(des.equals('H')){
                                                    bag.R2_BAG_CHK_Retractable_handle__c = true;
                                                }else if(des.equals('C')){
                                                    bag.R2_BAG_CHK_Combination_lock__c = true;
                                                }else if(des.equals('W')){
                                                    bag.R2_BAG_CHK_Wheels_or_bearing__c = true;
                                                }else if(des.equals('B')){
                                                    bag.R2_BAG_CHK_Single_object_in_box__c = true;
                                                }else if(des.equals('K')){
                                                    bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
                                                }else if(des.equals('S')){
                                                    bag.R2_BAG_CHK_Safety_belt__c = true;
                                                }
                                            }
                                        }
                                    }
                                }// fin if bGroupType.colourAndType != null

                                //rellena el numero de la etiqueta de la maleta
                                if(bGroupType.bagTag != null){
                                    bag.R2_BAG_CHK_BagTag_Suspended__c = bGroupType.bagTag.suspended != null ? bGroupType.bagTag.suspended : false;
                                    String ticket = '';
                                    if (bGroupType.bagTag.airlinecode != null && bGroupType.bagTag.airlinecode != '') {
                                        bag.R2_BAG_TXT_Bag_Airline_Code__c = bGroupType.bagTag.airlinecode;
                                        ticket = bGroupType.bagTag.airlinecode;
                                    }
                                    else if(bGroupType.bagTag.licenseNumber != null){
                                       bag.R2_BAG_NUM_LN_TagType__c = Integer.valueOf(bGroupType.bagTag.licenseNumber.tagType);
                                       bag.R2_BAG_TXT_LN_Issuer_Code__c = bGroupType.bagTag.licenseNumber.issuerCode;
                                       ticket = bGroupType.bagTag.licenseNumber.issuerCode;
                                    }
                                    bag.R2_BAG_TXT_TagSequence__c = bGroupType.bagTag.tagSequence;
                                    ticket +=  bGroupType.bagTag.tagSequence;
                                    bag.R2_BAG_TXT_Ticket_number__c = ticket;
                                }

                                //rellena el numero de la etiqueta rush de la maleta
                                if(bGroupType.rushTag != null){
                                    bag.R2_BAG_CHK_RushTag_Suspended__c = bGroupType.rushTag.suspended != null ? bGroupType.rushTag.suspended : false;
                                    if (bGroupType.rushTag.airlinecode != null && bGroupType.rushTag.airlinecode != '') {
                                        bag.R2_BAG_TXT_Rush_Airline_Code__c = bGroupType.rushTag.airlinecode;
                                        bag.R2_BAG_TXT_RUSH_label__c = bGroupType.rushTag.airlinecode;
                                    }
                                    else if(bGroupType.rushTag.licenseNumber != null){
                                       bag.R2_BAG_NUM_LN_RushTagType__c = Integer.valueOf(bGroupType.rushTag.licenseNumber.tagType);
                                       bag.R2_BAG_TXT_LN_Rush_Issuer_Code__c = bGroupType.rushTag.licenseNumber.issuerCode;
                                       bag.R2_BAG_TXT_RUSH_label__c = bGroupType.rushTag.licenseNumber.issuerCode;
                                    }
                                    bag.R2_BAG_TXT_TagSequence__c = bGroupType.rushTag.tagSequence;
                                    bag.R2_BAG_TXT_RUSH_label__c += bGroupType.rushTag.tagSequence;
                                }

                                if(bGroupType.brandInfo != null){
                                    bag.R2_BAG_TXT_Brand_Info_Suspended__c = bGroupType.brandInfo.suspended != null ? bGroupType.brandInfo.suspended : false; //pone txt pero es chk
                                    bag.R2_BAG_TXT_Brand_Info__c = bGroupType.brandInfo.brandInfo;
                                } // fin if bGroupType.brandInfo

                                //bagDelivery
                                if(bGroupType.bagDelivery != null){
                                    if(bGroupType.bagDelivery.bagReceived != null){
                                        if (bGroupType.bagDelivery.bagReceived.rDate != null) {
                                            bag.R2_BAG_DAT_DateBagReceived__c = Date.ValueOf(bGroupType.bagDelivery.bagReceived.rDate); //bagReceivedDate; //ver replace o no de date en json de response
                                        }
                                        bag.R2_BAG_TXT_StationBagReceived__c = bGroupType.bagDelivery.bagReceived.station;
                                    }
                                    if(bGroupType.bagDelivery.status != null){
                                        bag.R2_BAG_TXT_OF__c = bGroupType.bagDelivery.status.outForDelivery;
                                        bag.R2_BAG_TXT_OD__c = bGroupType.bagDelivery.status.delivered;
                                        bag.R2_BAG_TXT_UP__c = bGroupType.bagDelivery.status.trackingUpdate;
                                        bag.R2_BAG_TXT_UnableToDeliver__c =  bGroupType.bagDelivery.status.unableToDeliver;
                                    }
                                    bag.R2_BAG_DAT_Suitcase_delivery_date__c = bGroupType.bagDelivery.deliveredTime != null ? Date.valueOf(bGroupType.bagDelivery.deliveredTime) : null;
                                } // fin if bGroupType.bagDelivery

                                bag.R2_BAG_TXT_Lock_Code__c = bGroupType.lockCode;

                                if(bGroupType.uniqueID != null){
                                    bag.R2_BAG_CHK_UniqueID_Suspended__c = bGroupType.uniqueID.suspended != null ? bGroupType.uniqueID.suspended : false;
                                    bag.R2_BAG_TXT_UniqueID__c = bGroupType.uniqueID.uniqueID;
                                }
                                if(bGroupType.bagSentToCustoms != null){
                                    bag.R2_BAG_DATH_Bag_SentToCustoms__c = bGroupType.bagSentToCustoms.bagDate != null ? Date.valueOf(bGroupType.bagSentToCustoms.bagDate) : null;
                                    bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = bGroupType.bagSentToCustoms.timeZone;
                                }
                                if(bGroupType.bagReceivedFromCustoms != null){
                                    bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = bGroupType.bagReceivedFromCustoms.bagDate != null ? Date.valueOf(bGroupType.bagReceivedFromCustoms.bagDate) : null;
                                    bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = bGroupType.bagReceivedFromCustoms.timeZone;
                                }
                                bag.R2_BAG_TXT_Storage_Location__c = bGroupType.storageLocation;
                                if(bGroupType.bagContents != null){
                                    bag.R2_BAG_CHK_BagContends_Suspended__c = bGroupType.bagContents.suspended != null ? bGroupType.bagContents.suspended : false;
                                }
                                //bag.R2_CB_TXT_Contents_Desc__c = bGroupType.contentDescription;
                                bag.R2_BAG_TXT_Aditional_damage_information__c = bGroupType.bagDetails;

                                if(bGroupType.remarks != null){
                                    bag.R2_BAG_TXT_Comments__c = '';
                                    for(String re:bGroupType.remarks.remark){
                                        bag.R2_BAG_TXT_Comments__c += bGroupType.remarks.remark + '; ';
                                    }
                                }
                                
                                if(bGroupType.damagedTypes != null){
                                    
                                    if(bGroupType.damagedTypes.damagedType.size()>=1){
                                        bag.R2_BAG_PKL_Damage_1_Location__c = bGroupType.damagedTypes.damagedType[0].location;
                                        bag.R2_BAG_TXT_Damage1_coding__c = bGroupType.damagedTypes.damagedType[0].type_z;
                                        bag.R2_BAG_PKL_Damage1_scale__c = bGroupType.damagedTypes.damagedType[0].amount;
                                    }
                                    if(bGroupType.damagedTypes.damagedType.size()==2){
                                        bag.R2_BAG_PKL_Damage_2_Location__c = bGroupType.damagedTypes.damagedType[1].location;
                                        bag.R2_BAG_TXT_Damage2_coding__c = bGroupType.damagedTypes.damagedType[1].type_z;
                                        bag.R2_BAG_PKL_Damage2_scale__c = bGroupType.damagedTypes.damagedType[1].amount;
                                    }

                                    //13/04/18 Alberto.Puerto -> TD in visual now is disabled, codificación/localización/magnitud daño 1 are three fields Required
                                    //                        -> Fulfilling in visual TD field:
                                    if(!bGroupType.damagedTypes.damagedType.isEmpty()){
                                        bag.R2_BAG_TXT_Damage_detail__c = bGroupType.damagedTypes.damagedType[0].location + '/' + bGroupType.damagedTypes.damagedType[0].type_z + bGroupType.damagedTypes.damagedType[0].amount;
                                        if(bGroupType.damagedTypes.damagedType.size() > 1){
                                            bag.R2_BAG_TXT_Damage_detail__c += '/' + bGroupType.damagedTypes.damagedType[1].location + '/' + bGroupType.damagedTypes.damagedType[1].type_z + bGroupType.damagedTypes.damagedType[1].amount;
                                        }
                                    }  
                                }
                                
                                
                                
                                //almcana las rutas y segmentos del vuelo de la maleta
                                if(bGroupType.itinerary != null){
                                    bag.R2_BAG_TXT_bagRoute__c = '';
                                    bag.R2_BAG_TXT_bagNewRoute__c = '';
                                    Map<String,String> vueloFechaMap = new Map<String,String>();
                                    if (bGroupType.itinerary.flightSegments != null) {
                                        if (bGroupType.itinerary.flightSegments.flightSegment != null) {
                                            for(Integer j = 0; j < bGroupType.itinerary.flightSegments.flightSegment.size(); j++){ //5
                                                //R2_Auxiliar_Data_Incident__c fd = new R2_Auxiliar_Data_Incident__c();
                                                if(bGroupType.itinerary.flightSegments.flightSegment[j].flightDate != null) {
                                                    String vuelo = bGroupType.itinerary.flightSegments.flightSegment[j].flightDate.airlinecode;
                                                    vuelo += bGroupType.itinerary.flightSegments.flightSegment[j].flightDate.flightNumber;
                                                    String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)bGroupType.itinerary.flightSegments.flightSegment[j].flightDate.flightDate);
                                                    vueloFechaMap.put(vuelo, fecha);
                                                }
                                                bag.R2_BAG_TXT_BagFlight__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);

                                                if (bGroupType.itinerary.flightSegments.flightSegment[j].arnk != null) {
                                                    if (bGroupType.itinerary.flightSegments.flightSegment[j].arnk.originDestination != null) {
                                                        if (j == 0) {
                                                            bag.R2_BAG_TXT_bagRoute__c = bGroupType.itinerary.flightSegments.flightSegment[j].arnk.originDestination.origin + '/';
                                                        }
                                                        bag.R2_BAG_TXT_bagRoute__c += bGroupType.itinerary.flightSegments.flightSegment[j].arnk.originDestination.destination + '/';
                                                    }

                                                }
                                            }
                                        }
                                    }
                                    if (bGroupType.itinerary.routes != null) {
                                        for (Integer j = 0; j < bGroupType.itinerary.routes.size(); j++) {
                                            bag.R2_BAG_TXT_bagRoute__c += bGroupType.itinerary.routes[j] + '/';
                                        }
                                    }
                                    bag.R2_BAG_TXT_bagRoute__c = bag.R2_BAG_TXT_bagRoute__c.removeEnd('/');
                                    Map<String,String> vueloFechaMapNew = new Map<String,String>();
                                    if (bGroupType.itinerary.newFlightSegments != null) {
                                        for(Integer j = 0; j < bGroupType.itinerary.newFlightSegments.flightSegment.size(); j++){ //5
                                            //R2_Auxiliar_Data_Incident__c fd = new R2_Auxiliar_Data_Incident__c();
                                            if(bGroupType.itinerary.newFlightSegments.flightSegment[j].flightDate != null) {
                                                String vuelo = bGroupType.itinerary.newFlightSegments.flightSegment[j].flightDate.airlinecode;
                                                vuelo += bGroupType.itinerary.newFlightSegments.flightSegment[j].flightDate.flightNumber;
                                                String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)bGroupType.itinerary.newFlightSegments.flightSegment[j].flightDate.flightDate);
                                                vueloFechaMapNew.put(vuelo, fecha);
                                            }
                                            bag.R2_BAG_TXT_BagNewFlight__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMapNew);

                                            if (bGroupType.itinerary.newFlightSegments.flightSegment[j].arnk != null) {
                                                if (bGroupType.itinerary.newFlightSegments.flightSegment[j].arnk.originDestination != null) {
                                                    if (j == 0) {
                                                        bag.R2_BAG_TXT_bagNewRoute__c = bGroupType.itinerary.newFlightSegments.flightSegment[j].arnk.originDestination.origin + '/';
                                                    }
                                                    bag.R2_BAG_TXT_bagNewRoute__c += bGroupType.itinerary.newFlightSegments.flightSegment[j].arnk.originDestination.destination + '/';
                                                }
                                            }
                                        }
                                    }
                                    if (bGroupType.itinerary.routes != null) {
                                        for (Integer j = 0; j < bGroupType.itinerary.routes.size(); j++) {
                                            bag.R2_BAG_TXT_bagRoute__c += bGroupType.itinerary.routes[j] + '/';
                                        }
                                    }
                                    bag.R2_BAG_TXT_bagNewRoute__c = bag.R2_BAG_TXT_bagNewRoute__c.removeEnd('/');
                                }
                                
                                if (lstLossComments.size() > contadorRC) {
                                    System.debug('lstLossComments: ' + lstLossComments);
                                    if (lstLossComments[contadorRC].substringBefore('YEAR') != null 
                                        && lstLossComments[contadorRC].substringBefore('YEAR').isNumeric()) {
                                        System.debug('lstLossComments[contadorRC].substringBefore(YEAR): ' + lstLossComments[contadorRC].substringBefore('YEAR'));
                                       bag.R2_BAG_NUM_Age__c = Integer.valueOf(lstLossComments[contadorRC].substringBefore('YEAR')); 
                                    }
                                    System.debug('lstLossComments[contadorRC].substringAfter(-): ' + lstLossComments[contadorRC].substringAfter('-'));
                                    bag.R2_BAG_TXT_Value_and_coin__c = lstLossComments[contadorRC].substringAfter('-');
    								contadorRC++;
                                }
                                listaBags.add(bag);
                            }
                        }

                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////Continua mapeo de PIR////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        if(resp.damagedBagGroup.bagItinerary != null){
                            Map<String,String> vueloFechaMap = new Map<String,String>();
                            if (resp.damagedBagGroup.bagItinerary.flightDateOrARNK != null) {
                                for(Integer i = 0; i < resp.damagedBagGroup.bagItinerary.flightDateOrARNK.size(); i++){ //5
                                    if(resp.damagedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate != null) {
                                        String vuelo = resp.damagedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.airlinecode;
                                        vuelo += resp.damagedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.flightNumber;
                                        String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resp.damagedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.flightDate);
                                        vueloFechaMap.put(vuelo, fecha);
                                    }
                                }
                                pirResp.R2_INC_TXT_PIR_Baggage_route__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);
                            }
                        }
                        pirResp.R2_INC_TXT_Excess_Baggage__c = resp.damagedBagGroup.excessBaggage;
                        if(resp.damagedBagGroup.bagTagDestinations != null){
                            if(resp.damagedBagGroup.bagTagDestinations.station != null){
                                String destination = '';
                                for(Integer u = 0; u < resp.damagedBagGroup.bagTagDestinations.station.size(); u++){ //2
                                    destination += resp.damagedBagGroup.bagTagDestinations.station[u].stationValue + '/';
                                }
                                pirResp.R2_INC_TXT_PIR_Baggage_destination__c = destination.removeEnd('/');
                            }
                        }
                        //if(resp.damagedBagGroup.bagTagDestinations != null){
                        //    if(resp.damagedBagGroup.bagTagDestinations.station != null){
                        //        for(Integer u=0; u<resp.damagedBagGroup.bagTagDestinations.station.size(); u++){ //2
                        //            R2_Auxiliar_Data_Incident__c db = new R2_Auxiliar_Data_Incident__c();
                        //            db.R2_ADI_TXT_DB_baggage_Destination__c = resp.damagedBagGroup.bagTagDestinations.station[u].stationValue;
                        //            listaAuxInc.add(db);
                        //        }
                        //    }
                        //}
                        pirResp.R2_INC_TXT_PIR_Weight_lost_parts__c = resp.damagedBagGroup.missingWeight;
                        //lostContents -> lista de dos
                        if(resp.damagedBagGroup.lostContents != null){
                            pirResp.R2_INC_TXT_PIR_Lost_content1__c = resp.damagedBagGroup.lostContents[0];
                            if(resp.damagedBagGroup.lostContents.size() == 2){
                                pirResp.R2_INC_TXT_PIR_Lost_content2__c = resp.damagedBagGroup.lostContents[1];
                            }
                        }
                    }

                    //Passengers
                    if(resp.passengers != null){
                        if(resp.passengers.names != null){
                            pirResp.R2_INC_TXT_PIR_Name__c = resp.passengers.names[0].name;
                            if (resp.passengers.names.size() >=2){
                                pirResp.R2_INC_TXT_PIR_Last_name__c = resp.passengers.names[1].name;
                            }
                            if (resp.passengers.names.size() >=3){
                                pirResp.R2_INC_TXT_PIR_Last_name2__c = resp.passengers.names[2].name;
                            }
                        }
                        if(resp.passengers.initials != null){
                            pirResp.R2_INC_TXT_PIR_Initial__c = resp.passengers.initials[0].initial;
                            if (resp.passengers.initials.size() >=2){
                                pirResp.R2_INC_TXT_PIR_Initial2__c = resp.passengers.initials[1].initial;
                            }
                            if (resp.passengers.initials.size() ==3){
                                pirResp.R2_INC_TXT_PIR_Initial3__c = resp.passengers.initials[2].initial;
                            }
                        }                
                        pirResp.R2_INC_TXT_PIR_Treatment__c = resp.passengers.title;
                        if(resp.passengers.contactInfo != null){
                            if(resp.passengers.contactInfo.permanentAddress != null){
                                //if(resp.passengers.contactInfo.permanentAddress.addressLine != null){
                                //    for (AddressLine addr : resp.passengers.contactInfo.permanentAddress.addressLine) {
                                //        if (addr.seq == '1') {
                                //            pirResp.R2_INC_TXT_PIR_Permanent_address1__c = addr.addressLineDesc;
                                //        }
                                //        else if (addr.seq == '2') {
                                //            pirResp.R2_INC_TXT_PIR_Permanent_address2__c = addr.addressLineDesc;
                                //        }
                                //    }
                                //}
                                if(resp.passengers.contactInfo.permanentAddress.addressLine != null){
                                    pirResp.R2_INC_TXT_PIR_Permanent_address1__c = resp.passengers.contactInfo.permanentAddress.addressLine[0].addressLineDesc;
                                    if(resp.passengers.contactInfo.permanentAddress.addressLine.size() == 2){
                                         pirResp.R2_INC_TXT_PIR_Permanent_address2__c = resp.passengers.contactInfo.permanentAddress.addressLine[1].addressLineDesc;
                                    }
                                }
                            //city y state no se usa
                            pirResp.R2_INC_TXT_PIR_Zip_code__c = resp.passengers.contactInfo.permanentAddress.postalCode;
                            }
                            if(resp.passengers.contactInfo.temporaryAddress != null){
                                if(resp.passengers.contactInfo.temporaryAddress.addressLine != null){
                                //    for (AddressLine addr : resp.passengers.contactInfo.temporaryAddress.addressLine) {
                                //        if (addr.seq == '1') {
                                //            pirResp.R2_INC_TXT_PIR_Temporal_address1__c = addr.addressLineDesc;
                                //        }
                                //        else if (addr.seq == '2') {
                                //            pirResp.R2_INC_TXT_PIR_Temporal_address2__c = addr.addressLineDesc;
                                //        }
                                //    }
                                
                                    pirResp.R2_INC_TXT_PIR_Temporal_address1__c = resp.passengers.contactInfo.temporaryAddress.addressLine[0].addressLineDesc;
                                    if(resp.passengers.contactInfo.temporaryAddress.addressLine.size() == 2){
                                         pirResp.R2_INC_TXT_PIR_Temporal_address2__c = resp.passengers.contactInfo.temporaryAddress.addressLine[1].addressLineDesc;
                                    }
                                }
                                pirResp.R2_INC_TXT_PIR_Temporal_Zip_Code__c = resp.passengers.contactInfo.temporaryAddress.postalCode;
                                pirResp.R2_INC_DAT_PIR_Validity_temporal_address__c = resp.passengers.contactInfo.temporaryAddress.validityDate != null ? Date.valueOf(resp.passengers.contactInfo.temporaryAddress.validityDate) : null;
                            }
                            //city y state no se usa
                            if(resp.passengers.contactInfo.permanentPhones != null){
                                //for (BagPhones phone : resp.passengers.contactInfo.permanentPhones) {
                                //    System.debug('!!!!!: ' + phone);
                                //    if (phone.seq == '1') {
                                //        pirResp.R2_INC_TLF_Landline1__c = phone.phone;
                                //    }
                                //    else if (phone.seq == '2') {
                                //        pirResp.R2_INC_TLF_Landline2__c = phone.phone;
                                //    }
                                //}
                                pirResp.R2_INC_TLF_Landline1__c = resp.passengers.contactInfo.permanentPhones[0].phone;
                                if(resp.passengers.contactInfo.permanentPhones.size() == 2){
                                     pirResp.R2_INC_TLF_Landline2__c = resp.passengers.contactInfo.permanentPhones[1].phone;
                                }
                            }
                            if(resp.passengers.contactInfo.cellPhones != null){
                                //for (BagPhones phone : resp.passengers.contactInfo.cellPhones) {
                                //    if (phone.seq == '1') {
                                //        pirResp.R2_INC_TLF_PIR_Mobile_phone_number1__c = phone.phone;
                                //    }
                                //    else if (phone.seq == '2') {
                                //        pirResp.R2_INC_TLF_PIR_Mobile_phone_number2__c = phone.phone;
                                //    }
                                //}
                                pirResp.R2_INC_TLF_PIR_Mobile_phone_number1__c = resp.passengers.contactInfo.cellPhones[0].phone;
                                if(resp.passengers.contactInfo.cellPhones.size() == 2){
                                     pirResp.R2_INC_TLF_PIR_Mobile_phone_number2__c = resp.passengers.contactInfo.cellPhones[1].phone;
                                }
                            }
                            if(resp.passengers.contactInfo.temporaryPhones != null){
                                //for (BagPhones phone : resp.passengers.contactInfo.temporaryPhones) {
                                //    if (phone.seq == '1') {
                                //        pirResp.R2_INC_TLF_PIR_Temporal_phone__c = phone.phone;
                                //    }
                                //    else if (phone.seq == '2') {
                                //        pirResp.R2_INC_TLF_PIR_Temporal_phone2__c = phone.phone;
                                //    }
                                //}
                                pirResp.R2_INC_TLF_PIR_Temporal_phone__c = resp.passengers.contactInfo.temporaryPhones[0].phone;
                                if(resp.passengers.contactInfo.temporaryPhones.size() == 2){
                                     pirResp.R2_INC_TLF_PIR_Temporal_phone2__c = resp.passengers.contactInfo.temporaryPhones[1].phone;
                                }
                            }
                            if(resp.passengers.contactInfo.emails != null){
                                //for (Emails email : resp.passengers.contactInfo.emails) {
                                //    if (email.seq == '1') {
                                //        pirResp.R2_INC_EMA_PIR_Email1__c = email.email;
                                //    }
                                //    else if (email.seq == '2') {
                                //        pirResp.R2_INC_EMA_PIR_Email2__c = email.email;
                                //    }
                                //}
                                pirResp.R2_INC_EMA_PIR_Email1__c = resp.passengers.contactInfo.emails[0].email;
                                if(resp.passengers.contactInfo.emails.size() == 2){
                                     pirResp.R2_INC_EMA_PIR_Email2__c = resp.passengers.contactInfo.emails[1].email;
                                }
                            }
                        }
                        //faxes 1 y 2 nada
                        //country - state y zip mapear y no mostrar
                        //
                        pirResp.R2_INC_TXT_PIR_FF_Identificator__c = resp.passengers.frequentFlyerId;
                        pirResp.R2_INC_TXT_PIR_Passenger_language__c = resp.passengers.language;
                        pirResp.R2_INC_TXT_PIR_Ticket_number__c = resp.passengers.ticketNumber;
                        pirResp.R2_INC_TXT_PIR_PNR_locator__c = resp.passengers.pnr;
                        //no passenger innecesario ya esta reflejado en otro lado
                        pirResp.R2_INC_PKL_PIR_Send_SMS_email__c = resp.passengers.autoMessageOption;
                        //passport info nada
                        //ITINERARY
                        String rutas = '';
                        Map<String,String> vueloFechaMap = new Map<String,String>();
                        if (resp.passengers.itinerary != null) {
                            if (resp.passengers.itinerary.flightSegmentsorARNK != null) {
                                for(Integer i = 0; i < resp.passengers.itinerary.flightSegmentsorARNK.size(); i++){ //5
                                    if(resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend != null) {
                                        if(resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.flightAndDate != null) {
                                            String vuelo = resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.flightAndDate.airlinecode;
                                            vuelo += resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.flightAndDate.flightNumber;
                                            String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.flightAndDate.flightDate);
                                            vueloFechaMap.put(vuelo, fecha);
                                        }
                                        if (resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.originDestination != null) {
                                            if (i == 0) {
                                                rutas += resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.originDestination.origin + '/';
                                            }
                                            rutas += resp.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.originDestination.destination + '/';
                                        }
                                    }
                                   //mapear ARNK!!
                                    if (resp.passengers.itinerary.flightSegmentsorARNK[i].arnk != null) {
                                        if (resp.passengers.itinerary.flightSegmentsorARNK[i].arnk.originDestination != null) {
                                            if (i == 0) {
                                                rutas += resp.passengers.itinerary.flightSegmentsorARNK[i].arnk.originDestination.origin + '/';
                                            }
                                            rutas += resp.passengers.itinerary.flightSegmentsorARNK[i].arnk.originDestination.destination + '/';
                                        }
                                    }
                                }
                                pirResp.R2_INC_TXT_PIR_flight_Number__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);

                                if (resp.passengers.itinerary.additionalRoutes != null) {
                                    for(Integer i = 0; i < resp.passengers.itinerary.additionalRoutes.size(); i++){ //13
                                        rutas += resp.passengers.itinerary.additionalRoutes[i] + '/'; //antes R2_ADI_TXT_OriginDestination_Destination__c
                                    }
                                }
                            }
                        }
                        pirResp.R2_INC_TXT_PIR_Route__c = rutas.removeEnd('/');
                        pirResp.R2_INC_TXT_PIR_Passenger_category__c = resp.passengers.status;
                        //pooledTktNumber (PB) no en siebel
                        //Farebasis (PF) no en siebel
                        pirResp.R2_INC_TXT_PIR_Given_Name__c = resp.passengers.givenName;
                    }

                    //additionalInfo
                    if(resp.additionalInfo != null) {
                        if (resp.additionalInfo.miscellaneousInfo != null) {
                            for(Integer i=0; i<resp.additionalInfo.miscellaneousInfo.size();i++){ //99
                                R2_Auxiliar_Data_Incident__c ff = new R2_Auxiliar_Data_Incident__c();
                                ff.R2_ADI_TXT_FF_Observation__c = resp.additionalInfo.miscellaneousInfo[i].miscInfoText;
                                ff.R2_ADI_NUM_seq__c = Integer.valueOf(resp.additionalInfo.miscellaneousInfo[i].seq);
                                ff.R2_ADI_PKL_Type__c = 'FF';
                                listaAuxInc.add(ff);
                            }
                        }
                        pirResp.R2_INC_TXT_PIR_Send_direction_FI__c = resp.additionalInfo.furtherinfo;
                        if(resp.additionalInfo.supplementaryInfo != null) {
                            for (SupplementaryInfoType supInf : resp.additionalInfo.supplementaryInfo) {
                                if (supInf.seq == '1') {
                                    pirResp.R2_INC_TXT_PIR_Control_information1__c = supInf.supplimentInfoText;
                                }
                                else if (supInf.seq == '2') {
                                    pirResp.R2_INC_TXT_PIR_Control_information2__c = supInf.supplimentInfoText;
                                }
                            }
                            //pirResp.R2_INC_TXT_PIR_Control_information1__c = resp.additionalInfo.supplementaryInfo[0].supplimentInfoText;
                            //if(resp.additionalInfo.supplementaryInfo.size() == 2){
                            //    pirResp.R2_INC_TXT_PIR_Control_information2__c = resp.additionalInfo.supplementaryInfo[1].supplimentInfoText;
                            //}
                        }
                        pirResp.R2_INC_TXT_PIR_Customs_Info_CI__c = resp.additionalInfo.customsinfo;
                        if (resp.additionalInfo.userComments != null) {
                            for(Integer i=0; i<resp.additionalInfo.userComments.size();i++){ //99
                                R2_Auxiliar_Data_Incident__c uc = new R2_Auxiliar_Data_Incident__c();
                                uc.R2_ADI_TXT_UC_User_Comment__c = resp.additionalInfo.userComments[i].commentsText;
                                uc.R2_ADI_NUM_seq__c = Integer.valueOf(resp.additionalInfo.userComments[i].seq);
                                uc.R2_ADI_PKL_Type__c = 'UC';
                                listaAuxInc.add(uc);
                            }
                        }
                        if (resp.additionalInfo.deliveryInfo != null) {
                            for(Integer i=0; i<resp.additionalInfo.deliveryInfo.size();i++){ //10
                                R2_Auxiliar_Data_Incident__c dy = new R2_Auxiliar_Data_Incident__c();
                                dy.R2_ADI_ATXTL_DY_Delivery_Info__c = resp.additionalInfo.deliveryInfo[i].deliveryInfoText;
                                dy.R2_ADI_NUM_seq__c = Integer.valueOf(resp.additionalInfo.deliveryInfo[i].seq);
                                dy.R2_ADI_PKL_Type__c = 'DY';
                                listaAuxInc.add(dy);
                            }
                        }
                        if (resp.additionalInfo.messageInfo != null) {
                            for(Integer i=0; i<resp.additionalInfo.messageInfo.size();i++){ //50
                                R2_Auxiliar_Data_Incident__c mg = new R2_Auxiliar_Data_Incident__c();
                                mg.R2_ADI_ATXTL_MG_Message__c = resp.additionalInfo.messageInfo[i].messageInfoText;
                                mg.R2_ADI_NUM_seq__c = Integer.valueOf(resp.additionalInfo.messageInfo[i].seq);
                                mg.R2_ADI_PKL_Type__c = 'MG';
                                listaAuxInc.add(mg);
                            }
                        }
                        if (resp.additionalInfo.matchInfo != null) {
                            for(Integer i=0; i<resp.additionalInfo.matchInfo.size();i++){ //50
                                R2_Auxiliar_Data_Incident__c mr = new R2_Auxiliar_Data_Incident__c();
                                mr.R2_ADI_ATXTL_MR_Match__c = resp.additionalInfo.matchInfo[i].matchInfoText;
                                mr.R2_ADI_NUM_seq__c = Integer.valueOf(resp.additionalInfo.matchInfo[i].seq);
                                mr.R2_ADI_PKL_Type__c = 'MR';
                                listaAuxInc.add(mr);
                            }
                        }
                    }

                    ////claim
                    if (resp.claim != null) {
                        if (resp.claim.claimData != null) {
                            if (resp.claim.claimData.costRemarks != null) {
                                for(Integer i=0; i<resp.claim.claimData.costRemarks.size(); i++){ //hasta 5
                                    R2_Auxiliar_Data_Incident__c cr = new R2_Auxiliar_Data_Incident__c();
                                    cr.R2_ADI_TXT_CR_Remarks_Cost__c = resp.claim.claimData.costRemarks[i];
                                    cr.R2_ADI_PKL_Type__c = 'CR';
                                    listaAuxInc.add(cr);
                                }
                            }
                            if (resp.claim.claimData.passengerPayments != null) {
                                if (resp.claim.claimData.passengerPayments.passengerPaymentsValue != null) {
                                    for(Integer i=0; i<resp.claim.claimData.passengerPayments.passengerPaymentsValue.size();i++){ //5
                                        R2_Auxiliar_Data_Incident__c cs = new R2_Auxiliar_Data_Incident__c();
                                        cs.R2_ADI_PKL_CS_Cost_Type__c = resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].costType;
                                        if (resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].amount != null) {
                                            cs.R2_ADI_NUM_CS_Amount__c = resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].amount.amount;
                                            cs.R2_ADI_TXT_CS_Currency__c = resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].amount.currencyCode;
                                            cs.R2_ADI_NUM_Decimal_Place__c = resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].amount.decimalPlace;
                                            cs.R2_ADI_PKL_Type__c = 'CS';
                                        }
                                        listaAuxInc.add(cs);
                                    }
                                }
                            }
                            //pirResp.R2_INC_DAT_PIR_Claims_Created_Date__c = resp.claim.claimData.claimDate != null ? Date.ValueOf(resp.claim.claimData.claimDate) : null;
                            pirResp.R2_INC_DAT_PIR_Date_Notified__c = resp.claim.claimData.notifiedDate != null ? Date.ValueOf(resp.claim.claimData.notifiedDate) : null;
                            pirResp.R2_INC_DAT_PIR_Questionnaire_Date__c = resp.claim.claimData.questionnaireDate != null ? Date.ValueOf(resp.claim.claimData.questionnaireDate) : null;
                            pirResp.R2_INC_TXT_PIR_Responsible_Scale__c =  resp.claim.claimData.faultStationCode;
                            pirResp.R2_INC_TXT_PIR_Responsible_Terminal__c = resp.claim.claimData.faultTerminal;
                            pirResp.R2_INC_CHK_PIR_Baggage_insurance__c = resp.claim.claimData.insurance != null ? resp.claim.claimData.insurance : false;
                            pirResp.R2_INC_CHK_PIR_Limited_approval_label__c = resp.claim.claimData.liabilityTagIndicator != null ? resp.claim.claimData.liabilityTagIndicator : false;
                            if (resp.claim.claimData.partnerCode != null) {
                                pirResp.R2_INC_TXT_PIR_Shared_code__c = resp.claim.claimData.partnerCode.carrierCode;
                            }
                            pirResp.R2_INC_TXT_PIR_Lost_reason_causes__c = resp.claim.claimData.lossComments;
                            pirResp.R2_INC_TXT_PIR_Lost_reason__c = resp.claim.claimData.lossReasonCode;
                            if (resp.claim.claimData.toilerkits != null) {
                                pirResp.R2_INC_NUM_Toiler_Kit_Male__c = resp.claim.claimData.toilerkits.male;
                                pirResp.R2_INC_NUM_Toiler_Kit_Female__c = resp.claim.claimData.toilerkits.female;
                            }
                            //toilerkits - determinar si checkbox o no - pendiente
                            //excess value (XV) no se muestra - guardar luego
                            if (resp.claim.claimData.tracingFinalized != null) {
                                pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = Date.valueOf(resp.claim.claimData.tracingFinalized);
                            }
                        }
                    }

                    pirResp.R2_INC_TXT_PIR_Designated_Locator__c = resp.designatedLocator;
                    pirResp.R2_INC_PKL_PIR_Copy_for_the_company_HC__c = resp.handledAirlineCopyIndicator;// != null ? resp.handledAirlineCopyIndicator : false;
                    pirResp.R2_INC_PKL_PIR_Status_incidence__c = resp.recordStatus;



                    //////////////////////////////////////////////////////////////////////////////////////////////////

                //DML ACTION
                    List<R1_Incident__c> damagedExiste = new List<R1_Incident__c>();
                        //System.debug('stationCode: '+resp.diaryInfo.associateRecord.recordReference.stationCode);
                        //System.debug('airlineCode: '+resp.diaryInfo.associateRecord.recordReference.airlineCode);
                        //System.debug('refnumb: '+resp.diaryInfo.associateRecord.recordReference.referenceNumber);
                        System.debug('stationCode: '+pirResp.R2_INC_TXT_PIR_AR_Station_Code__c);
                        System.debug('airlineCode: '+pirResp.R2_INC_TXT_PIR_AR_Airline_Code__c);
                        System.debug('refnumb: '+pirResp.R2_INC_TXT_PIR_AR_Reference_Number__c);
                        System.debug('RESP: '+resp);

                        WpReq wrapReq = (WpReq)JSON.deserialize(wrapper, WpReq.class); //reutilizado ya que el response no tiene la obligación de mostrar el AR...
                        System.debug('stationCode: '+wrapReq.recordId.recordReference.stationCode);
                        System.debug('airlineCode: '+wrapReq.recordId.recordReference.airlineCode);
                        System.debug('refnumb: '+wrapReq.recordId.recordReference.referenceNumber);
                        System.debug('cambiarNumPIR: '+ cambiarNumPIR);
                        if(pirResp.R2_INC_TXT_PIR_Station_Code__c == null){pirResp.R2_INC_TXT_PIR_Station_Code__c = wrapReq.recordId.recordReference.stationCode;}
                        if(pirResp.R2_INC_TXT_PIR_Airline_Code__c == null){pirResp.R2_INC_TXT_PIR_Airline_Code__c = wrapReq.recordId.recordReference.airlineCode;}
                        if(pirResp.R2_INC_TXT_PIR_Reference_Number__c == null){pirResp.R2_INC_TXT_PIR_Reference_Number__c = wrapReq.recordId.recordReference.referenceNumber;}
                        pirResp.R2_INC_TXT_PIR_Stop_and_Operator_MS__c = pirResp.R2_INC_TXT_PIR_Station_Code__c + pirResp.R2_INC_TXT_PIR_Airline_Code__c;


                    if (cambiarNumPIR){
                        damagedExiste = [SELECT Id FROM R1_Incident__c
                                                        WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_AR_Station_Code__c
                                                        AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_AR_Airline_Code__c
                                                        AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_AR_Reference_Number__c
                                                        AND RecordType.DeveloperName ='DAMAGED'
                                                        //AND CreatedDate=:created
                                                        //AND CreatedDate=:(String)resp.diaryInfo.createDate
                                                        LIMIT 1];
                    }
                    else {
                        damagedExiste = [SELECT Id FROM R1_Incident__c
                                                        WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_Station_Code__c
                                                        AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_Airline_Code__c
                                                        AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_Reference_Number__c
                                                        AND RecordType.DeveloperName ='DAMAGED'
                                                        //AND CreatedDate=:created
                                                        //AND CreatedDate=:(String)resp.diaryInfo.createDate
                                                        LIMIT 1];
                    }
                    //if(resp.diaryInfo != null && resp.diaryInfo.associateRecord != null && resp.diaryInfo.associateRecord.recordReference != null) {
                    //if(wrapReq != null && wrapReq.recordId != null && wrapReq.recordId.recordReference != null) {
                        //Datetime created = Datetime.newInstance(2017, 09, 12, 21, 20, 02);

                        //damagedExiste = [SELECT Id FROM R1_Incident__c
                        //                                WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_Station_Code__c
                        //                                AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_Airline_Code__c
                        //                                AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_Reference_Number__c
                        //                                AND RecordType.DeveloperName ='DELAYED'
                        //                                //AND CreatedDate=:created
                        //                                //AND CreatedDate=:(String)resp.diaryInfo.createDate
                        //                                LIMIT 1];
                    //}
                    System.debug('delayed Existe?? '+ damagedExiste);
                    //update or insert
                    if(!damagedExiste.isEmpty()){
                        pirResp.Id = damagedExiste[0].Id;
                        //lista de query de objetos relacionados y borrar
                        List<R2_Auxiliar_Data_Incident__c> lstADIs = [SELECT id FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c =:damagedExiste[0].Id];
                        List<R2_Baggage__c> lstBAGs = [SELECT id FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c =:damagedExiste[0].Id];
                        delete lstADIs;
                        delete lstBAGs;

                        update pirResp;
                        System.debug('pirResp UPDATEADO::::::::'+pirResp);
                    }else{
                        insert pirResp;
                        System.debug('pirResp INSERTADO:::::::'+pirResp);
                    }
                    //fulfillment of dependent objects
                    if(!listaAuxInc.isEmpty()){
                        for(Integer i=0; i<listaAuxInc.size(); i++){
                            listaAuxInc[i].R2_ADI_MSDT_Incident__c = pirResp.Id;
                        }
                        System.debug('Va a insertar la lista auxiliar');
                        insert listaAuxInc;
                        System.debug('listaAuxInc INSERTADO'+listaAuxInc);
                    }else System.debug('listaAuxInc VACIA '+listaAuxInc);

                    if(!listaBags.isEmpty()){
                        for(Integer i=0; i<listaBags.size(); i++){
                            listaBags[i].R2_BAG_MSDT_Incident__c = pirResp.Id;

                        }
                        System.debug('Va a insertar la lista de maletas');
                        insert listaBags;
                        System.debug('listaBags INSERTADO'+listaBags);
                        //Reubico aquí la inserción del contenido de la maleta para agrupar los dos campos con su msdt en un ciclo
                        for(Integer i=0; i<listaBags.size(); i++){
                            if(resp.damagedBagGroup.delayedBags != null){
                                if(resp.damagedBagGroup.delayedBags[i].bagReceivedFromCustoms != null){
                                    //List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();
                                    for(Integer o=0; o<resp.damagedBagGroup.delayedBags[i].bagContents.content.size(); o++){ //12
                                        R2_Content_Baggage__c contB = new R2_Content_Baggage__c();
                                        contB.R2_CB_TXT_Type__c = resp.damagedBagGroup.delayedBags[i].bagContents.content[o].category;
                                        contB.R2_CB_TXT_Description__c = resp.damagedBagGroup.delayedBags[i].bagContents.content[o].description;
                                        contB.R2_CB_MSDT_Baggage__c = listaBags[i].Id;
                                        listaContenidoB.add(contB);
                                    }
                                    insert listaContenidoB;
                                }
                            }
                        }
                    }else{System.debug('listaBags VACIA '+listaBags);}
                    //FALTA CONTENIDO MALETAS --> R2_Content_Baggage__c listaContenidoB  -> a R2_CB_MSDT_Baggage__c
    //INC-20171020-00151

                //////////////////////////////////////////////////////////////////////////////////////////////////
               


                    //System.debug('El dato que intento insertar es ' + pirResp);
                    //insert pirResp;
                    ////return resp;
                    return pirResp.Id;
                }
                else {
                    return null;
                }
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos += 1;
                    R1_CLS_SendCustomerMDM.login();
                    return ReadRecord_DPR_DDP(wrapper, intentos, cambiarNumPIR);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP()', '', 'No se puede conectar con Intelligence Integration', 'Error en el login');
                    return null;
                }
            }

            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_Read_Damaged_PIR.ReadRecord_DPR_DDP()', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            return null;
       }
    }
}