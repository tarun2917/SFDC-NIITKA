public with sharing class R2_CLS_WT_Inactive_Bags_Management{

  // COMMON TYPES CLASSES
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
   public class Faxes{
       public String fax;
       public String seq;
   }

   public class AddressType{
     //cambio-> addressLine (de lista a objecto)
       public AddressLine addressLine; //antes AddressLine
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
       public String flightDate; //Date / string
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
       public OriginDestination arnk;
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
     //cambio-> flightSegmentOrARNK to flightSegmentsorARNK
       public List<FlightSegmentOrARNK> flightSegmentsorARNK;  //no lista antes
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
       public String recordReference;
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
   public class DelayedBag{
     //cambio-> colorTypeDesc (string a ColourAndTypeType)
     //cambio-> public String contentsDesc; (agregado)
     //cambio-> public String seq; (agregado)

        //  public String colourCode;
       //public String typeCode;
       //  public String materialElement;
       //  public String otherElement;
       public ColourAndTypeType colourAndType;
       public BagTag bagTag;
       public BrandInfo brandInfo;
       public BagDelivery bagDelivery;
       public String lockCode;
       public String storageLocation;
       public String bagDetails;
       public String contentsDesc;
       public AssociatedRecord associatedRecord;

       public ColourAndTypeType colorTypeDesc;
       //public String colorCode;
       //public Boolean suspended;
       //public Descriptor descriptor;
       public UniqueID uniqueID;
       public BagSentToCustoms bagSentToCustoms;
       public BagReceivedFromCustoms bagReceivedFromCustoms;
       public BagContents bagContents;
       //public String contentDescription;
       public Remarks remarks; //antes no lista
       public BaggageItinerary baggageItinerary;
       public String seq;
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
   }
   public class TicketNumber{
       public String ticketNumberValue;
   }
   public class PassengerType{
     //cambio-> noofPassengers (add)
     //cambio-> frequentFlyerId a frequentFlyerID
       public List<Names> names;//strings antes
       public String givenName;
       public List<Initials> initials;
       public String title;
       public ContactInfo contactInfo;

       public String frequentFlyerID;
       public String language;
       public String ticketNumber;
       // public TicketNumber ticketNumber; - ojo cambiado con el "ultimo" metodo
       public String pnr;
       public String noofPassengers;
       public String autoMessageOption;
       public String numberOfPassengers;
       public String passportInfo;
       public Itinerary itinerary;

       //public String origin;
      // public String destination;
      // public String arnk;
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
       public String supplimentInfoTextInfoText;
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
   public class SmsInfo{
       public String seq;
       public String smsinfoText;
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
      // public String currencyCode;
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
     //cambio-> liabilityTagIndicator a
       public ClaimAmount claimAmount;
       public List<CostRemarksListType> costRemarks;
       public PassengerPayments payments;  //duplicado por servicio close DAH
       public PassengerPayments passengerPayments;
       public Date claimDate;
       public Date notifiedDate;
       public Date questionnaireDate;
       public String faultStation;  //duplicado por servicio close DAH
       public String faultStationCode;
       public String faultTerminal;
       public Boolean insurance;
       public Boolean insuranceIndicator; //bueno
       public Boolean liabilityTag;
       public String missingBags;
       public PartnerCode partnerCode;
       public String lossComments;
       public String lossReasonCode;
       public ToilerKits toilerkits;
       public Amount excessValue;
       public Date tracingFinalized;
       public String replacementBagIndicator; //OJO no estan en excel entonces no esta mapeado
       public String repairBagIndicator;//OJO no estan en excel entonces no esta mapeado
   }
   public class Claim{
       public ClaimData claimData;
   }
   public class CostRemarksListType{
     //cambio-> se creo este wp
     public String costRemarksText;
     public String seq;
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

    ////DAMAGED REQUEST
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


   //****************************************************** INACTIVE ********************************************************
   //REQUESTs
   //REQUEST
       // ******* Update Delayed Bag Retired Record Web Request V01 **********
     /*  public class Wp_UpdateDelayedBag_Request{
           public String airlineVendorId;
           public wp_BagRecordType recordReference;
           public wp_DelayedBagType delayedBagGroup;
           public List<wp_PassengerType> passengers;
           public String designatedLocator;
           public wp_AdditionalInfoType additionalInfo;
           public wp_ClaimType claim;
           public String handledAirlineCopyIndicator;
           public String lzControlDate;
           public wp_BagRecordType crossReferenceRecord;
           public List<wp_InboxAddressType> inboxAddresses;
           public String promptDate;
           public String promptText;
           public String agentId;
           public String rDate; //OJO Date palabra reservada
       }
       // ******* Update Damaged Bag Retired Record Web Request V01 **********
       public class Wp_UpdateDamagedBag_Request{
           public String airlineVendorId;
           public wp_BagRecordType recordReference;
           public wp_DamagedBagType damagedBagGroup;
           public List<wp_PassengerType> passengers;
           public String designatedLocator;
           public wp_AdditionalInfoType additionalInfo;
           public wp_ClaimType claim;
           public String handledAirlineCopyIndicator;
           public String lzControlDate;
           public wp_BagRecordType crossReferenceRecord;
           public List<wp_InboxAddressType> inboxAddresses;
           public String promptDate;
           public String promptText;
           public String agentId;
       }
       // ******* Retrieve Delayed Bag Retired Record Web Request V01 **********
       public class Wp_RetrieveDelayedBag_Request{
           public String airlineVendorId;
           public wp_BagRecordType recordId;
           public String rDate;//reserved: Date;
           public String agentId;
       }
       // ******* Retrieve Damaged Bag Retired Record Web Request V01 **********
       public class Wp_RetrieveDamagedBag_Request{
           public String airlineVendorId;
           public wp_BagRecordType recordId;
           public String rDate;//reserved: Date;
           public String agentId;
       }
   */


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
           public List<String> matchHistory;
   }/*
   public class NamesInactive {
           public String name;
           public Integer seq;
   }
   public class InitialsInactive {
           public String initial;
           public Integer seq;
   }*/
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
     //cambio-> public Claim claim; (descomentada)
           public String success;//ok
           public List<WarningType> warnings;
           public DiaryInfoType diaryInfo;//ok wp_DiaryInfoType
           public BagGroupType  delayedBagGroup;//ok DelayedBagGroup
           public PassengerType passengers;//ok wp_PassengerType
           public AdditionalInfoType additionalInfo; //wp_AdditionalInfoType
           public Claim claim; //wp_ClaimType
           public String designatedLocator;
           public String handledAirlineCopyIndicator;
           public List<String> internetInfo;
           public List<SmsInfo> smsInfo;
           public List<String> emailInfo;
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
           //public List<PassengerType> passengers;
           public AdditionalInfoType addditionalInfo;
           public Claim claim; //ClaimType
           public String designatedLocator;
           public String handledAirlineCopyIndicator;
           public List<String> internetInfo;
           public List<SmsInfo> smsInfo;
           public List<String> emailInfo;
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
               public Date effectiveDate;
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
      //cambio-> supplementaryInfo a supplimentalInfo
           public List<MiscellaneousInfo> miscellaneousInfo;  //List<MiscellaneousInfoType> miscellaneousInfo
           public FurtherInfoType furtherInfo;
           public List<SupplementaryInfoType> supplimentalInfo;
           public CustomsInfoType customsInfo;
           public List<UserComments> userComments;
           public List<DeliveryInfoType> deliveryInfo;
           public List<MessageInfoType> messageInfo;
           public List<MatchInfoType> matchInfo;

       }

       public class FurtherInfoType{
         //cambio-> se ha reado este wp
         public String furtherInfoDesc;
       }
       public class CustomsInfoType{
         //cambio-> se ha reado este wp
         public String customsInfoDesc;
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
           public List<String> matchHistory;
       }
       public class AddressTypeBag{
         //cambio-> addressLine (de lista a objeto)
           public AddressLine addressLine;
           public String houseNumber;
           public String streetName;
           public String apartment;
           public String city;
           public State state;
           public String postalCode;
           public Country country;
       }
       public class BagGroupType{
         //cambio-> bagItinerary to baggageItinerary
           public AddressTypeBag bagAddress; //AddressType
           public String bagWeight;
           public String baggageWeight;//de inactive ia
           public String contentsGender;
           public DeliveryType delivery;
           public List<BagPhones> bagPhones; //bagPhones
           public List<BagType> damagedBags;
           public List<DelayedBag> delayedBags; //BagType
           public BagType onHandBags;
           public String bagLastSeen;
           public BaggageItinerary baggageItinerary;
           public String excessBaggage;
           public BagTagDestinationsType bagTagDestinations;
           public Boolean keysCollected;
           public String missingWeight;
           public String matchWindow;
           public List<String> lostContents;
           public String contentsDamageDesc;
       }
        public class DeliveryType{
          //cambio-> localDeliveryInfo a localDlvInfo
           public AddressType  deliveryAddress;
           public String deliveredTime;
           public BagReceived bagReceived;
           public String deliveryWeight;
           public List<DlvInfoType>  localDlvInfo; //DlvInfoType
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
         //cambio-> crossReferenceRecord a crossReferenceRecords
         //cambio-> inventoryReceivedDate to dateInventoryReceived
           public String createDate; //strings//dateTime
           public String suspendDate;//dateTime
           public String tracingDate;//dateTime
           public String closeDate;//dateTime
           public String reinstateDate;//dateTime
           public String rematchDate;//dateTime
           public String lzControlDate;//dateTime
           public String retiredDate;//dateTime
           public Date disposalDate;
           public Date tracingFinalizedDate;
           public String claimInvestigationDate;//Datetime
           public String dateInventoryReceived;//Datetime
           public String tracingExtendedDate;//Datetime
           public NewRecordType associateRecord;
           public List<NewRecordType> crossReferenceRecords; //
           public String controllingStation;

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
       public class WpResOnHandBag{
           public String success;
           public List<WarningType> warnings; //WarningsType Warnings;
           public DiaryInfoType DiaryInfo;
           public BagGroupType OnHandBagGroup;
           public PassengerType Passengers;
           public PartnerCodeType partnerCode;
           public String handledAirlineCopyIndicator;
           public String designatedLocator;
           public String textInfo;
           public AdditionalInfoType additionalInfo;
           public List<SmsInfo> smsInfo;
           public String emailInfo;
           public RecordHistoryType recordHistory;
           public String recordStatus;
       }
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
           public List<SmsInfo> smsInfo;
           public String emailInfo;
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
           public List<PassengerType> passengers;
           public AdditionalInfoType additionalInfo;
           public Claim claim; //ClaimType
           public String designatedLocator;
           public String handledAirlineCopyIndicator;
           public String smsInfo;
           public String emailInfo;
           public RecordHistoryType recordHistory;
           public String recordStatus;
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
       //WRAPPER universal para utilizar en caller universal :D
       public class WrapperBigBigOne_Response{
           public WpResSearch searchResponse;


       }

   /*----------------------------------------------------------------------------------------------------------------------------------------------
       Author:         Alberto Puerto Collado
       Company:        Accenture
       Description:    Enum metodos a igualar en variables del caller

       IN:
       OUT:

       History:
       <Date>                     <Author>                   <Change Description>
       10/10/2017              Alberto Puerto Collado          Initial Version
    ----------------------------------------------------------------------------------------------------------------------------------------------*/
       //enum
       public enum enumMethods {
           CREATE_DELAYEDBAG,
           UPDATE_DELAYEDBAG,
           GENERATE_DELAYEDBAG,
           SUSPEND_DELAYEDBAG,
           REOPEN_DELAYEDBAG,
           CLOSE_DELAYEDBAG,
           REINSTATE_DELAYEDBAG,
           REASSIGN_DELAYEDBAG,

           CREATE_DAMAGEDBAG,
           GENERATE_DAMAGEDBAG,
           REASSIGN_DAMAGEDBAG,
           CLOSE_DAMAGEDBAG,
           MODIFY_DAMAGEDBAG,

           BAG_SEARCH,
           RUSH_BAG_SEARCH,
           READRECORD_DAMAGED,
           READRECORD_ONHAND,
           READRECORD_DELAYED,

           INACTIVE_UPDATEDAMAGEBAG,
           INACTIVE_UPDATEDELAYEDBAG,
           INACTIVE_RETRIEVEDAMAGEBAG,
           INACTIVE_RETRIEVEDELAYEDBAG,
           INACTIVE_SEARCHRETIREDBAGS,

           ONHAND_REQUEST,

           INBOX_POST,
           TELETYPE,
           INBOX_PUT,
           STATIONS_LIST,
           STATIONS_SCREENS
       }

       final static Map<String,Id> map_RT = new Map<String,Id>();

       static{
           for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE sObjectType = 'R1_Incident__c']) {
               map_RT.put(rt.DeveloperName, rt.Id);
           }
       }


  /*----------------------------------------------------------------------------------------------------------------------------------------------
 Author:         Alberto Puerto Collado
 Company:        Accenture
 Description:    call_ReadRetiredRecord_AHL_PDI WORKING ON IT

 IN:
 OUT:

 History:
 <Date>                     <Author>                   <Change Description>
 29/08/2017              Alberto Puerto Collado          Initial Version
----------------------------------------------------------------------------------------------------------------------------------------------*/
@future(callout=true)
 public static void call_ReadRetiredRecord_AHL_PDI(){
      try{
         system.debug('Comienzo call_ReadRetiredRecord_AHL_PDI');
         ReadRetiredRecord_AHL_PDI(0);
         }catch(Exception exc){
             R1_CLS_LogHelper.generateErrorLog('R1_CLS_SMS_TriggerMethods__c.ReadRetiredRecord_AHL_PDI', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
         }
 }
 /*----------------------------------------------------------------------------------------------------------------------------------------------
 Author:         Alberto Puerto Collado
 Company:        Accenture
 Description:    Sends a HTTPRequest, jaime dev

 IN:
 OUT:

 History:
 <Date>                     <Author>                   <Change Description>
 29/08/2017              Alberto Puerto Collado          Initial Version
----------------------------------------------------------------------------------------------------------------------------------------------*/
 public static Wp_RetrieveDelayedBag_Response ReadRetiredRecord_AHL_PDI(Integer contador) {
     try{
         if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
         System.debug('RETRIEVE DELAYED BAG');
         string wsMethod = 'R2_InactiveBags';
         if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
             return null;
         }
         //Control de token
         String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
         if (token == null) {
             if(contador < 3){
                 R1_CLS_SendCustomerMDM.login();
                 contador += 1;
                 return ReadRetiredRecord_AHL_PDI(contador);
             }
             else{
                 R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()', 'ReadRetiredRecord_AHL_PDI LOGIN error',
                     'No se puede conectar con MDM', 'R2_Baggage__c');
                 return null;
             }
         }
         //llenado de Wp_RetrieveDelayedBag_Request
/*
retrieve delayed
{    "recordId": {      "recordType": "DELAYED",      "recordReference": {        "airlineCode": "IB",        "referenceNumber": "67371",        "stationCode": "MAD"      }    },    "date": "2017-01-11",    "agentId": "AGENT"  }
*/

         //request
         HttpRequest req = new HttpRequest();

         req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c+'/delayed-bags');
         //System.debug('ENDPOINT_____METHOD_______'+req.getEndpoint());
         req.setHeader('Authorization', 'Bearer ' + token);
         req.setMethod('POST');
         req.setHeader('Accept', 'application/json');
         req.setHeader('Content-Type', 'application/json');
         TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
         //system.debug('REQUEST********'+req);

         //req.setBody(JSON.serialize(Wp_RetrieveDelayedBag_Request.class));
         Wp_RetrieveDelayedBag_Request wrp = new Wp_RetrieveDelayedBag_Request();
         //llenado de wrp: (...)
         // ************* SERIALIZE *********
         //String body = JSON.serialize(wrp);
         String body = '{"recordId":{"recordType":"DELAYED","recordReference":{"airlineCode":"IB","referenceNumber":"67371","stationCode":"MAD"}},"date":"2017-01-11","agentId":"AGENT"}';
         body = body.replaceAll('"rDate":','"date":');
         System.debug(body);
         req.setBody(body);

         //llamada
         Http http = new Http();
         HTTPResponse res;
         //system.debug('res previo send********'+res);
         res = http.send(req);
         String bodyJson = helper_fixerJson(res.getBody());

         system.debug('SEND********'+res.getStatusCode());
         //recogemos datos de response
         if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
             System.debug('antes de DESERIALIZE '+ bodyJson);

             Wp_RetrieveDelayedBag_Response resp = (Wp_RetrieveDelayedBag_Response) JSON.deserialize(bodyJson, Wp_RetrieveDelayedBag_Response.class);

             system.debug('RESP********'+resp);


             R1_Incident__c pirResp = new R1_Incident__c();

             pirResp.RecordTypeId = map_RT.get('INACTIVE_DELAYED');//Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('DELAYED').getRecordTypeId();
             //query para ver si esta en sf o es insert
             //query por CreatedDate R2_INC_DAT_PIR_Claim_Date__c
             //          Record type demora/deterioro
             // (AR): R2_INC_FOR_PIR_AR__c (formula q concatena stationCode,airlineCode y ReferenceNumber)

             //lista R2_Auxiliar_Data_Incident__c
             List<R2_Auxiliar_Data_Incident__c> listaAuxInc = new List<R2_Auxiliar_Data_Incident__c>();
             //public List<BagType> delayedBags; - de 0 a 10 R2_Baggage__c
             List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
             List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();

             /********* diaryInfo *************/
                 if(resp.diaryInfo != null){
                    //------------------DESCOMENTAR
                     //pirResp.R2_INC_DAT_PIR_Claim_Date__c = resp.diaryInfo.createDate;
                     //pirResp.R2_INC_DAT_PIR_Cancellation_date__c = resp.diaryInfo.suspendDate;
                     //pirResp.R2_INC_DAT_PIR_Search_start_date__c = resp.diaryInfo.tracingDate;
                     //pirResp.R2_INC_DATH_PIR_Incidence_closed_date__c = resp.diaryInfo.closeDate;
                     //pirResp.R2_PIR_DAT_PIR_Full_reintegration_date__c = resp.diaryInfo.reinstateDate;
                     //pirResp.R2_INC_DAT_PIR_Last_mapping_date__c = resp.diaryInfo.rematchDate;
                     //pirResp.R2_INC_DAT_PIR_Control_date__c = resp.diaryInfo.lzControlDate;
                     //pirResp.R2_INC_DAT_PIR_Date_back_primary_search__c = resp.diaryInfo.retiredDate;
                     //resp.diaryInfo.disposalDate;
                     pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = resp.diaryInfo.tracingFinalizedDate;
                     //resp.diaryInfo.claimInvestigationDate;
                     //resp.diaryInfo.dateInventoryReceived;
                     //resp.diaryInfo.tracingExtendedDate;
                     pirResp.R2_INC_TXT_PIR_Control_office__c = resp.diaryInfo.controllingStation;

                     if(resp.diaryInfo.associateRecord != null){
                         if(resp.diaryInfo.associateRecord.recordReference != null){
                             pirResp.R2_INC_TXT_PIR_AR_Station_Code__c = resp.diaryInfo.associateRecord.recordReference.stationCode;
                             pirResp.R2_INC_TXT_PIR_AR_Airline_Code__c = resp.diaryInfo.associateRecord.recordReference.airlineCode;
                             pirResp.R2_INC_TXT_PIR_AR_Reference_Number__c = resp.diaryInfo.associateRecord.recordReference.referenceNumber;
                         }
                     }

                     if(resp.diaryInfo.crossReferenceRecords != null){
                         for(Integer i=0; i<resp.diaryInfo.crossReferenceRecords.size(); i++){
                             if(resp.diaryInfo.crossReferenceRecords[i].recordReference != null){
                                 R2_Auxiliar_Data_Incident__c xr = new R2_Auxiliar_Data_Incident__c();
                                 xr.R2_ADI_TXT_XR_Station_Code__c = resp.diaryInfo.crossReferenceRecords[i].recordReference.stationCode;
                                 xr.R2_ADI_TXT_XR_Airline_Code__c = resp.diaryInfo.crossReferenceRecords[i].recordReference.airlineCode;
                                 xr.R2_ADI_TXT_XR_Reference_Number__c = resp.diaryInfo.crossReferenceRecords[i].recordReference.referenceNumber;
                                 listaAuxInc.add(xr);
                             }
                         }
                     }

                 }
             //baggrouptype
                 if(resp.delayedBagGroup != null){
                     if(resp.delayedBagGroup.bagAddress != null){
                          //adressLine-> lista de 2
                         if(resp.delayedBagGroup.bagAddress.addressLine != null){
                             pirResp.R2_INC_TXT_PIR_Address_in_suitcase1__c = resp.delayedBagGroup.bagAddress.addressLine.addressLineDesc;
                         }
                         //city pirResp. = resp.delayedBagGroup.city;
                         if(resp.delayedBagGroup.bagAddress.state != null){
                             //State pirResp. = resp.delayedBagGroup.state.stateDesc;
                             //State pirResp. = resp.delayedBagGroup.state.stateCode;
                         }
                         //postalCode pirResp. = resp.delayedBagGroup.postalCode;
                         if(resp.delayedBagGroup.bagAddress.country != null){
                             //Country pirResp. = resp.delayedBagGroup.country.countryName;
                             //Country pirResp. = resp.delayedBagGroup.country.countryCode;
                         }

                     }

                     pirResp.R2_INC_TXT_PIR_Baggage_Weight_piece__c = resp.delayedBagGroup.baggageWeight;
                     //contentsGender nada
                     //DELIVERY
                     if(resp.delayedBagGroup.delivery != null){
                         if(resp.delayedBagGroup.delivery.deliveryAddress != null){
                             //adressLine-> lista de 2
                             if(resp.delayedBagGroup.delivery.deliveryAddress.addressLine != null){
                                 pirResp.R2_INC_TXT_PIR_Delivery_address1__c = resp.delayedBagGroup.delivery.deliveryAddress.addressLine.addressLineDesc;
                             }
                         //city pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.city;
                         //State pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.state.stateDesc;
                         //State pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.state.stateCode;
                         //postalCode pirResp. = resp.delayedBagGroup.deliveryAddress.deliverypostalCode;
                         //Country pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.country.countryName;
                         //Country pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.country.countryCode;
                         }
                         pirResp.R2_INC_TXT_PIR_Baggage_Weight_delivered__c = resp.delayedBagGroup.delivery.deliveryWeight;
                         if(resp.delayedBagGroup.delivery.localDivInfo != null){
                             pirResp.R2_INC_TXT_PIR_Delivery_local_informatio__c = resp.delayedBagGroup.delivery.localDivInfo[0].dlvInfo;
                                 if(resp.delayedBagGroup.delivery.localDivInfo.size() == 2){
                                     pirResp.R2_INC_TXT_PIR_Deliver_local_informatio2__c = resp.delayedBagGroup.delivery.localDivInfo[1].dlvInfo;
                                 }
                         }
                         //deliveryservice
                         if(resp.delayedBagGroup.delivery.deliveryService != null){
                             for(Integer i=0; i<resp.delayedBagGroup.delivery.deliveryService.size(); i++){ //10
                                 R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
                                 aux.R2_ADI_ATXTL_DS_Delivery_service__c = resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc;
                                 //R2_Auxiliar_Data_Incident__c.R2_ADI_ATXTL_DS_Delivery_service__c = resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                 //pirResp.R2_INC_ATXTL_PIR_Delivery_service__c += resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                 listaAuxInc.add(aux);
                             }
                         }
                     }
                     //5.
                     if(resp.delayedBagGroup.bagPhones != null){
                         pirResp.R2_INC_TLF_PIR_Phone_number_suitcase1__c = resp.delayedBagGroup.bagPhones[0].phone;
                         if(resp.delayedBagGroup.bagPhones.size() == 2){
                             pirResp.R2_INC_TLF_PIR_Phone_number_suitcase2__c = resp.delayedBagGroup.bagPhones[1].phone;
                         }
                     }

                     //6 delayed bags
                      if(resp.delayedBagGroup.delayedBags != null){


                          for(Integer i=0; i<resp.delayedBagGroup.delayedBags.size(); i++){ //10
                             R2_Baggage__c bag = new R2_Baggage__c();
                             //master detail a incidencia
                             bag.R2_BAG_MSDT_Incident__c = pirResp.Id;

                             if(resp.delayedBagGroup.delayedBags[i].colourAndType != null){
                                 bag.R2_BAG_CHK_Suspended__c = resp.delayedBagGroup.delayedBags[i].colourAndType.suspended != null ? resp.delayedBagGroup.delayedBags[i].colourAndType.suspended : false;
                                 bag.R2_BAG_PKL_Colour__c = resp.delayedBagGroup.delayedBags[i].colourAndType.colourCode;
                                 bag.R2_BAG_TXT_TypeCode__c = resp.delayedBagGroup.delayedBags[i].colourAndType.typeCode;
                                 //checkboxes de descriptor - material elements
                                 if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor != null){
                                     if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement != null){
                                         if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement == 'M'){
                                             bag.R2_BAG_CHK_Metal__c = true;
                                         }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement == 'R'){
                                             bag.R2_BAG_CHK_Rigid__c = true;
                                         }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement == 'D'){
                                             bag.R2_BAG_CHK_Mixed__c = true;
                                         }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement == 'L'){
                                             bag.R2_BAG_CHK_Leather__c = true;
                                         }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.mtrlElement == 'T'){
                                             bag.R2_BAG_CHK_Printed_fabric__c = true;
                                         }
                                     }
                                     if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement != null){
                                         //checkboxes de descriptor - other elements
                                         for(Integer y=0; y<resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement.size(); y++){ //////////////////////////check
                                             if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'H'){
                                                 bag.R2_BAG_CHK_Retractable_handle__c = true;
                                             }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'C'){
                                                 bag.R2_BAG_CHK_Combination_lock__c = true;
                                             }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'W'){
                                                 bag.R2_BAG_CHK_Wheels_or_bearing__c = true;
                                             }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'B'){
                                                 bag.R2_BAG_CHK_Single_object_in_box__c = true;
                                             }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'K'){
                                                 bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
                                             }else if(resp.delayedBagGroup.delayedBags[i].colourAndType.descriptor.otherElement[y] == 'S'){
                                                 bag.R2_BAG_CHK_Safety_belt__c = true;
                                             }
                                         }
                                     }

                                 }

                             }

                         if(resp.delayedBagGroup.delayedBags[i].bagTag != null){
                            bag.R2_BAG_CHK_BagTag_Suspended__c = resp.delayedBagGroup.delayedBags[i].bagTag.suspended != null ? resp.delayedBagGroup.delayedBags[i].bagTag.suspended : false;
                            bag.R2_BAG_TXT_Bag_Airline_Code__c = resp.delayedBagGroup.delayedBags[i].bagTag.airlinecode;
                            if(resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber != null){
                                bag.R2_BAG_NUM_LN_TagType__c = resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber.tagType;
                                bag.R2_BAG_TXT_LN_Issuer_Code__c = resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber.issuerCode;
                            }
                            bag.R2_BAG_TXT_TagSequence__c = resp.delayedBagGroup.delayedBags[i].bagTag.tagSequence;
                         }
                         if(resp.delayedBagGroup.delayedBags[i].brandInfo != null){
                             bag.R2_BAG_TXT_Brand_Info_Suspended__c = resp.delayedBagGroup.delayedBags[i].brandInfo.suspended; //raro txt y no chk
                             bag.R2_BAG_TXT_Brand_Info__c = resp.delayedBagGroup.delayedBags[i].brandInfo.brandInfo;
                         }

                         //bagDelivery
                         if(resp.delayedBagGroup.delayedBags[i].bagDelivery != null){
                             //if(resp.delayedBagGroup.delayedBags[i].bagDelivery.bagReceived != null){
                                 //date  bag. = resp.delayedBagGroup.delayedBags[i].brandInfo.bagReceived.rDate; //bagReceivedDate; //ver replace o no de date en json de response
                                //station bag. = resp.delayedBagGroup.delayedBags[i].brandInfo.bagReceived.station;
                             //}

                                //status
                             if(resp.delayedBagGroup.delayedBags[i].bagDelivery.status != null){
                                 bag.R2_BAG_TXT_OF__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.outForDelivery;
                                 bag.R2_BAG_TXT_OD__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.delivered;
                                 bag.R2_BAG_TXT_UP__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.trackingUpdate;
                             }///-----------------------COMENTADO TRATAR EL DATETIME
                             //bag.R2_BAG_DATH_DD__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.deliveredTime;
                         }

                         bag.R2_BAG_TXT_Lock_Code__c = resp.delayedBagGroup.delayedBags[i].lockCode;
                         if(resp.delayedBagGroup.delayedBags[i].uniqueID != null){
                             bag.R2_BAG_CHK_UniqueID_Suspended__c = resp.delayedBagGroup.delayedBags[i].uniqueID.suspended != null ? resp.delayedBagGroup.delayedBags[i].uniqueID.suspended : false;
                             bag.R2_BAG_TXT_UniqueID__c = resp.delayedBagGroup.delayedBags[i].uniqueID.uniqueID;
                         }
                         if(resp.delayedBagGroup.delayedBags[i].bagSentToCustoms != null){
                             //bag.R2_BAG_DATH_Bag_SentToCustoms__c = resp.delayedBagGroup.delayedBags[i].bagSentToCustoms.bagDate;
                             bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = resp.delayedBagGroup.delayedBags[i].bagSentToCustoms.timeZone;
                         }
                         if(resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms != null){
                             //bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms.bagDate;
                             bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms.timeZone;
                         }
                             bag.R2_BAG_TXT_Storage_Location__c = resp.delayedBagGroup.delayedBags[i].storageLocation;


                         if(resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms != null){
                             bag.R2_BAG_CHK_BagContends_Suspended__c = resp.delayedBagGroup.delayedBags[i].bagContents.suspended != null ? resp.delayedBagGroup.delayedBags[i].bagContents.suspended : false;
                             //bagContents nuevo objeto
                             //List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();
                         //trasladado al final, en inserciones
                             //for(Integer o=0; o<resp.delayedBagGroup.delayedBags[i].bagContents.content.size(); o++){ //12
                             //    R2_Content_Baggage__c contB = new R2_Content_Baggage__c();
                             //    contB.R2_CB_TXT_Type__c = resp.delayedBagGroup.delayedBags[i].bagContents.content[o].category;
                             //    contB.R2_CB_TXT_Description__c = resp.delayedBagGroup.delayedBags[i].bagContents.content[o].description;

                             //    listaContenidoB.add(contB);
                             //}
                         }
                         bag.R2_CB_TXT_Contents_Desc__c = resp.delayedBagGroup.delayedBags[i].contentsDesc; // antes era contentDescription
                         bag.R2_BAG_TXT_Aditional_damage_information__c = resp.delayedBagGroup.delayedBags[i].bagDetails;
                         if(resp.delayedBagGroup.delayedBags[i].remarks != null){
                             for(Integer r=0; r<resp.delayedBagGroup.delayedBags[i].remarks.remark.size(); r++){
                                 bag.R2_BAG_TXT_Comments__c += resp.delayedBagGroup.delayedBags[i].remarks.remark[r] + '; ';
                             }
                         }
                         //AR por cada maleta -> arreglar con lookup mejor
                             //station code
                             //airlinecode
                             //referencenumber

                         listaBags.add(bag);
                         }
                      }
                     pirResp.R2_INC_TXT_Last_Seen__c = resp.delayedBagGroup.bagLastseen;

                     //8.-baggage itinerary
                     if(resp.delayedBagGroup.baggageItinerary != null){
                         if(resp.delayedBagGroup.baggageItinerary.flightDateOrARNK != null){
                             for(Integer u=0; u<resp.delayedBagGroup.baggageItinerary.flightDateOrARNK.size(); u++){//5
                                 R2_Auxiliar_Data_Incident__c br = new R2_Auxiliar_Data_Incident__c();
                                 //br.R2_ADI_TXT_BR_Flight_number__c = resp.delayedBagGroup.baggageItinerary.flightDateOrARNK.flightDate.flightNumber;
                                 br.R2_ADI_TXT_BR_Flight_number__c = resp.delayedBagGroup.baggageItinerary.flightDateOrARNK[u].flightDate.flightNumber;
                                 //br.R2_ADI_DAT_BR_Flight_Date__c = resp.delayedBagGroup.baggageItinerary.flightDateOrARNK[u].flightDate.flightDate;
                                 br.R2_ADI_TXT_BR_Airline_Code__c = resp.delayedBagGroup.baggageItinerary.flightDateOrARNK[u].flightDate.airlinecode;
                                 br.R2_ADI_TXT_BR_ARNK__c = resp.delayedBagGroup.baggageItinerary.flightDateOrARNK[u].arnk;

                                 listaAuxInc.add(br);
                             }
                         }
                     }
                     pirResp.R2_INC_TXT_Excess_Baggage__c = resp.delayedBagGroup.excessBaggage;
                     if(resp.delayedBagGroup.bagTagDestinations != null){
                         if(resp.delayedBagGroup.bagTagDestinations.station != null){
                             for(Integer u=0; u<resp.delayedBagGroup.bagTagDestinations.station.size(); u++){ //2
                                 R2_Auxiliar_Data_Incident__c db = new R2_Auxiliar_Data_Incident__c();
                                 db.R2_ADI_TXT_DB_baggage_Destination__c = resp.delayedBagGroup.bagTagDestinations.station[u].stationValue;

                                 listaAuxInc.add(db);
                             }
                         }
                     }
                     //KeysCollected
                     pirResp.R2_INC_TXT_PIR_Weight_lost_parts__c = resp.delayedBagGroup.missingWeight;
                 }



                 //MatchWindow

             //PASSENGERS
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
                             if(resp.passengers.contactInfo.permanentAddress.addressLine != null){
                                 pirResp.R2_INC_TXT_PIR_Permanent_address1__c = resp.passengers.contactInfo.permanentAddress.addressLine.addressLineDesc;
                             }
                         //city y state no se usa
                         pirResp.R2_INC_TXT_PIR_Zip_code__c = resp.passengers.contactInfo.permanentAddress.postalCode;
                         }
                         if(resp.passengers.contactInfo.temporaryAddress != null){
                             if(resp.passengers.contactInfo.temporaryAddress.addressLine != null){
                                 pirResp.R2_INC_TXT_PIR_Temporal_address1__c = resp.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc;
                             }
                             pirResp.R2_INC_TXT_PIR_Temporal_Zip_Code__c = resp.passengers.contactInfo.temporaryAddress.postalCode;
                           if (resp.passengers.contactInfo.temporaryAddress.validityDate != null) {
                              pirResp.R2_INC_DAT_PIR_Validity_temporal_address__c = Date.valueOf(resp.passengers.contactInfo.temporaryAddress.validityDate);

                            }
                         }
                         //city y state no se usa
                         if(resp.passengers.contactInfo.permanentPhones != null){
                             pirResp.R2_INC_TLF_Landline1__c = resp.passengers.contactInfo.permanentPhones[0].phone;
                             if(resp.passengers.contactInfo.permanentPhones.size() == 2){
                                  pirResp.R2_INC_TLF_Landline2__c = resp.passengers.contactInfo.permanentPhones[1].phone;
                             }
                         }
                         if(resp.passengers.contactInfo.cellPhones != null){
                             pirResp.R2_INC_TLF_PIR_Mobile_phone_number1__c = resp.passengers.contactInfo.cellPhones[0].phone;
                             if(resp.passengers.contactInfo.cellPhones.size() == 2){
                                  pirResp.R2_INC_TLF_PIR_Mobile_phone_number2__c = resp.passengers.contactInfo.cellPhones[1].phone;
                             }
                         }
                         if(resp.passengers.contactInfo.temporaryPhones != null){
                             pirResp.R2_INC_TLF_PIR_Temporal_phone__c = resp.passengers.contactInfo.temporaryPhones[0].phone;
                             if(resp.passengers.contactInfo.temporaryPhones.size() == 2){
                                  pirResp.R2_INC_TLF_PIR_Temporal_phone2__c = resp.passengers.contactInfo.temporaryPhones[1].phone;
                             }
                         }
                         if(resp.passengers.contactInfo.emails != null){
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
                     if (resp.passengers.itinerary.flightSegmentsorARNK != null) {
                         for(Integer i=0; i<resp.passengers.itinerary.flightSegmentsorARNK.size();i++){ //5
                             R2_Auxiliar_Data_Incident__c fd = new R2_Auxiliar_Data_Incident__c();
                             if(resp.passengers.itinerary.flightSegmentsorARNK[i].flight != null) {
                                 if(resp.passengers.itinerary.flightSegmentsorARNK[i].flight.flightAndDate != null) {
                                     fd.R2_ADI_TXT_FD_Airline_Code__c = resp.passengers.itinerary.flightSegmentsorARNK[i].flight.flightAndDate.airlinecode;
                                     fd.R2_ADI_TXT_FD_Flight_number__c = resp.passengers.itinerary.flightSegmentsorARNK[i].flight.flightAndDate.flightNumber;
                                     //fd.R2_ADI_DAT_FD_Flight_Date__c = resp.passengers.itinerary.flightSegmentsorARNK[i].flight.flightAndDate.flightDate;
                                 }

                                 if (resp.passengers.itinerary.flightSegmentsorARNK[i].flight.originDestination != null) {
                                     fd.R2_ADI_TXT_OriginDestination_Origin__c = resp.passengers.itinerary.flightSegmentsorARNK[i].flight.originDestination.origin;
                                     fd.R2_ADI_TXT_OriginDestination_Destination__c = resp.passengers.itinerary.flightSegmentsorARNK[i].flight.originDestination.destination;
                                 }
                             }
                            //mapear ARNK!!
                            // fd.R2_ADI_DAT_FD_Flight_Date__c = resp.passengers.itinerary.flightSegmentsorARNK[i].arnk;
                           //  fd.R2_ADI_TXT_OriginDestination_Origin__c = resp.passengers.itinerary.flightSegmentsorARNK[i].arnk.originDestination.origin;
                           //  fd.R2_ADI_TXT_OriginDestination_Destination__c = resp.passengers.itinerary.flightSegmentsorARNK[i].arnk.originDestination.destination;
////////////////////////////////habra que cambiarlo por R2_INC_TXT_PIR_Route__c
                             if (resp.passengers.itinerary.flightSegmentsorARNK[i].additionalRoutes != null) {
                                 for(Integer j=0; j<resp.passengers.itinerary.flightSegmentsorARNK[i].additionalRoutes.size();j++){ //13
                                     fd.R2_ADI_TXT_RT_Route__c += resp.passengers.itinerary.flightSegmentsorARNK[i].additionalRoutes[j].route+' '; //antes R2_ADI_TXT_OriginDestination_Destination__c
                                 }
                             }
////////////////////////////////////
                             listaAuxInc.add(fd);
                         }
                     }
                     pirResp.R2_INC_TXT_PIR_Passenger_category__c = resp.passengers.status;
                     //pooledTktNumber (PB) no en siebel
                     //Farebasis (PF) no en siebel
                     pirResp.R2_INC_TXT_PIR_Given_Name__c = resp.passengers.givenName;
                 }

             //ADDITIONAL INFO
                 if(resp.additionalInfo != null) {
                     if (resp.additionalInfo.miscellaneousInfo != null) {
                     	for(Integer i=0; i<resp.additionalInfo.miscellaneousInfo.size();i++){ //99
                     		 R2_Auxiliar_Data_Incident__c ff = new R2_Auxiliar_Data_Incident__c();
                     		 ff.R2_ADI_TXT_FF_Observation__c = resp.additionalInfo.miscellaneousInfo[i].miscInfoText;

                     		 listaAuxInc.add(ff);
                     	}
                     }
                 	pirResp.R2_INC_TXT_PIR_Send_direction_FI__c = resp.additionalInfo.furtherinfo.furtherInfoDesc;
                     if(resp.additionalInfo.supplimentalInfo != null) {
                         pirResp.R2_INC_TXT_PIR_Control_information1__c = resp.additionalInfo.supplimentalInfo[0].supplimentInfoText;
                         if(resp.additionalInfo.supplimentalInfo.size() == 2){
                             pirResp.R2_INC_TXT_PIR_Control_information2__c = resp.additionalInfo.supplimentalInfo[1].supplimentInfoText;
                         }
                     }
                 	pirResp.R2_INC_TXT_PIR_Customs_Info_CI__c = resp.additionalInfo.customsinfo.customsInfoDesc;
                     if (resp.additionalInfo.userComments != null) {
                     	for(Integer i=0; i<resp.additionalInfo.userComments.size();i++){ //99
                     		 R2_Auxiliar_Data_Incident__c uc = new R2_Auxiliar_Data_Incident__c();
                     		 uc.R2_ADI_TXT_UC_User_Comment__c = resp.additionalInfo.userComments[i].commentsText;

                     		 listaAuxInc.add(uc);
                     	}
                     }
                     if (resp.additionalInfo.deliveryInfo != null) {
                     	for(Integer i=0; i<resp.additionalInfo.deliveryInfo.size();i++){ //10
                     		 R2_Auxiliar_Data_Incident__c dy = new R2_Auxiliar_Data_Incident__c();
                     		 dy.R2_ADI_ATXTL_DY_Delivery_Info__c = resp.additionalInfo.deliveryInfo[i].deliveryInfoText;

                     		 listaAuxInc.add(dy);
                     	}
                     }
                     if (resp.additionalInfo.messageInfo != null) {
                     	for(Integer i=0; i<resp.additionalInfo.messageInfo.size();i++){ //50
                     		 R2_Auxiliar_Data_Incident__c mg = new R2_Auxiliar_Data_Incident__c();
                     		 mg.R2_ADI_ATXTL_MG_Message__c = resp.additionalInfo.messageInfo[i].messageInfoText;

                     		 listaAuxInc.add(mg);
                     	}
                     }
                     if (resp.additionalInfo.matchInfo != null) {
                     	for(Integer i=0; i<resp.additionalInfo.matchInfo.size();i++){ //50
                     		 R2_Auxiliar_Data_Incident__c mr = new R2_Auxiliar_Data_Incident__c();
                     		 mr.R2_ADI_ATXTL_MR_Match__c = resp.additionalInfo.matchInfo[i].matchInfoText;

                     		 listaAuxInc.add(mr);
                     	}
                     }
                 }

             //CLAIM - linea 332 aprox
             	//1.- claim data (CA no lo pintan) - 3 campos
                 if (resp.claim != null) {
                     if (resp.claim.claimData != null) {
                         if (resp.claim.claimData.costRemarks != null) {
                         	for(Integer i=0; i<resp.claim.claimData.costRemarks.size(); i++){ //hasta 5
                         		 R2_Auxiliar_Data_Incident__c cr = new R2_Auxiliar_Data_Incident__c();
                         		 cr.R2_ADI_TXT_CR_Remarks_Cost__c = resp.claim.claimData.costRemarks[i].costRemarksText;

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
                                     }

                             		listaAuxInc.add(cs);
                             	}
                             }
                         }
                     	pirResp.R2_INC_DAT_PIR_Claims_Created_Date__c = resp.claim.claimData.claimDate;
                     	pirResp.R2_INC_DAT_PIR_Date_Notified__c =  resp.claim.claimData.notifiedDate;
                     	pirResp.R2_INC_DAT_PIR_Questionnaire_Date__c =  resp.claim.claimData.questionnaireDate;
                     	pirResp.R2_INC_TXT_PIR_Responsible_Scale__c =  resp.claim.claimData.faultStationCode;
                     	pirResp.R2_INC_TXT_PIR_Responsible_Terminal__c = resp.claim.claimData.faultTerminal;
                     	pirResp.R2_INC_CHK_PIR_Baggage_insurance__c = resp.claim.claimData.insurance != null ? resp.claim.claimData.insurance : false;
                         pirResp.R2_INC_CHK_PIR_Limited_approval_label__c = resp.claim.claimData.liabilityTag != null ? resp.claim.claimData.liabilityTag : false;
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
                     	pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = resp.claim.claimData.tracingFinalized;
                     }
                 }
             	//F-G-H
             	pirResp.R2_INC_TXT_PIR_Designated_Locator__c = resp.designatedLocator;
             	pirResp.R2_INC_PKL_PIR_Copy_for_the_company_HC__c = resp.handledAirlineCopyIndicator;// != null ? resp.handledAirlineCopyIndicator : false;
             	//Internet Info (IR) - no se guarda en siebel, choca con mg
             	//SMS Info (SM) - no se guarda en siebel
             	//Email Info (ER) - no se guarda en siebel



             system.debug('pirResp ********:' + pirResp);

             system.debug('pirResp Json serialize ********:' + JSON.serialize(pirResp));

             return resp;
         }
         else if (contador < 3 && res.getStatusCode() == 401) {
             R1_CLS_SendCustomerMDM.login();
             contador += 1;
             return ReadRetiredRecord_AHL_PDI(contador);
         }
         else {
             if(res.getStatusCode() == 400){
                 R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()', 'ReadRetiredRecord_AHL_PDI LOGIN error',
                     'Malformed request. Build correct request and try again, status code:'+res.getStatusCode(), 'R2_Baggage__c');
             }else if(res.getStatusCode() == 403){
                 R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()', 'ReadRetiredRecord_AHL_PDI LOGIN error',
                     'The operation on the resource is not authorised. Insufficient permissions, status code:'+res.getStatusCode(), 'R2_Baggage__c');
             }else if(res.getStatusCode() == 500 || res.getStatusCode() == 502 || res.getStatusCode() == 503){
                 R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()', 'ReadRetiredRecord_AHL_PDI LOGIN error',
                     'Server error, status code:'+res.getStatusCode(), 'R2_Baggage__c');
             }else{
                 R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()', 'ReadRetiredRecord_AHL_PDI LOGIN error',
                     'No se puede conectar con MDM, status code:'+res.getStatusCode(), 'R2_Baggage__c');
             }
             return null;
         }
     }catch(Exception exc){
         R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Inactive_Bags_Management.ReadRetiredRecord_AHL_PDI()',
             '__'+'__'+'__'+'__'
             , exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
         return null;
     }
 }


 /*-------------------------------------------------------------------------------------------------------------------------------------------------------
 Author:         Ismael Yubero Moreno
 Company:        Accenture
 Description:    Retrieves Delayed Bag

 IN:
 OUT:

 History:
 <Date>                       <Author>                  <Change Description>
 18/08/2017                  Ismael Yubero Moreno        Initial Version
 13/11/2017                  Alberto Puerto Collado      Structural changes
 --------------------------------------------------------------------------------------------------------------------------------------------------------*/
 //public static List<R1_Incident__c> searchBags (String wrapper, Integer intentos){ //WpReqSearch      List<R1_Incident__c>
 //    try{
 //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

 //        String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
 //        if(token ==null){
 //            if(intentos<3){
 //                intentos= intentos+1;
 //                R1_CLS_SendCustomerMDM.login();
 //                return searchBags(wrapper, intentos);
 //                //return searchBags(incidentId, intentos);
 //            }else{
 //                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', 'Error en login', 'Baggage');
 //                return null;
 //            }
 //        }

 //        string wsMethod = 'R2_SearchBagsInactive';

 //        if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
 //                return null;
 //        }


 //        HttpRequest req = new HttpRequest();
 //        String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'bags/search';
 //        req.setHeader('Authorization', 'Bearer ' + token);
 //        req.setEndpoint(endPoint);
 //        req.setMethod('POST');
 //        req.setHeader('Content-Type', 'application/json');
 //        TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
 //           req.setTimeout((Integer)timeOut.setTimeOut__c);

 //        //String body = JSON.serialize(wrp);
 //        //String body ='{   "bagType": "DELAYED",   "searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"}';
 //        //String body = JSON.serialize(wrapper);
 //        wrapper = helper_fixerJson(wrapper);
 //        String body = wrapper;

 //        System.debug('Body tras meter WRAPPER::::::: '+body);
 //        req.setBody(body);


 //        Http http = new Http();
 //        HTTPResponse res;


 //        res = http.send(req);
 //        System.debug('STATUS '+res.getStatusCode());
 //        if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
 //            System.debug('RESSSSSP ANTES deserializar '+res.getBody());
 //            WpResSearch resp = (WpResSearch)JSON.deserialize(res.getBody(),WpResSearch.class);
 //            System.debug('RESSSSSP deserializado__ '+resp);
 //           // return resp;

 //            List<R1_Incident__c> listaPIRs = new List<R1_Incident__c>();
 //            System.debug('tamaño bagRecords::::: '+resp.bagRecords.size());
 //            for(Integer i=0; i< resp.bagRecords.size() ;i++){
 //                R1_Incident__c pirResp = new R1_Incident__c();
 //                System.debug('resp.bagRecords[i].recordIdentifier.recordtype--->'+resp.bagRecords[i].recordIdentifier.recordtype);
 //                System.debug('bag I de '+i+'--->'+resp.bagRecords[i]);

 //                //pirResp.RecordType.DeveloperName = resp.bagRecords[i].recordIdentifier.recordtype;
 //                if(resp.bagRecords[i].recordIdentifier.recordReference != null){
 //                    pirResp.R2_INC_TXT_PIR_Station_Code__c = resp.bagRecords[i].recordIdentifier.recordReference.stationCode; //stationAirlineGroup
 //                    pirResp.R2_INC_TXT_PIR_Airline_Code__c = resp.bagRecords[i].recordIdentifier.recordReference.airlineCode;
 //                }
 //                pirResp.R2_INC_TXT_PIR_Reference_Number__c = resp.bagRecords[i].recordIdentifier.recordReference.referenceNumber;
 //                pirResp.R2_INC_PKL_PIR_Status_incidence__c = resp.bagRecords[i].status;
 //                //for(Integer n=0; n<resp.bagRecords[i].names.size() ;n++){
 //                    pirResp.R2_INC_TXT_PIR_Name__c = resp.bagRecords[i].names[0]; //.name;
 //                    //pirResp.R2_INC_TXT_PIR_Last_name__c = resp.bagRecords[i].names[1]; //.name;
 //                    //pirResp.R2_INC_TXT_PIR_Last_name2__c = resp.bagRecords[i].names[2]; //.name;
 //                //}
 //                //for(Integer n=0; n<resp.bagRecords[i].initials.size() ;n++){
 //                    //pirResp.R2_INC_TXT_PIR_Initial__c = resp.bagRecords[i].initials[0]; //.initial
 //                   // pirResp.R2_INC_TXT_PIR_Initial2__c = resp.bagRecords[i].initials[1].initial; //.initial
 //                   // pirResp.R2_INC_TXT_PIR_Initial3__c = resp.bagRecords[i].initials[2]; //.initial
 //                //}

 //                List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
 //                if(resp.bagRecords[i].originalBags != null){
 //                    //for(Integer b=0; b<resp.bagRecords[i].originalBags.size(); b++){
 //                        //R2_Baggage__c bag = new R2_Baggage__c();
 //                        //bag.R2_BAG_MSDT_Incident__c = pirResp.Id;
 //                        //bagTag 855 linea
 //                //Comentado el mapeo con bags ya que no se muestra la informacion en la busqueda
 //                     //   if(resp.bagRecords[i].originalBags[b].bagTag != null){
 //                     //     bag.R2_BAG_CHK_BagTag_Suspended__c = resp.bagRecords[i].originalBags[b].bagTag.suspended;
 //                        //    bag.R2_BAG_TXT_Bag_Airline_Code__c = resp.bagRecords[i].originalBags[b].bagTag.airlinecode;
 //                     //       if(resp.bagRecords[i].originalBags[b].bagTag.licenseNumber != null){
 //                     //           bag.R2_BAG_NUM_LN_TagType__c = resp.bagRecords[i].originalBags[b].bagTag.licenseNumber.tagType;
 //                     //           bag.R2_BAG_TXT_LN_Issuer_Code__c = resp.bagRecords[i].originalBags[b].bagTag.licenseNumber.issuerCode;
 //                     //       }
 //                        //     bag.R2_BAG_TXT_TagSequence__c = resp.bagRecords[i].originalBags[b].bagTag.tagSequence;
 //                     //   }
 //                        ////colourType
 //                     //   if(resp.bagRecords[i].originalBags[b] != null){
 //                     //      if(resp.bagRecords[i].originalBags[b].colourCode != null){
 //                     //       bag.R2_BAG_CHK_Suspended__c = resp.bagRecords[i].originalBags[b].colourCode.suspended;
 //                     //       bag.R2_BAG_PKL_Colour__c = resp.bagRecords[i].originalBags[b].colourCode.colorCode;
 //                     //       bag.R2_BAG_TXT_TypeCode__c = resp.bagRecords[i].originalBags[b].colourCode.typeCode;
 //                     //       }
 //                     //   }
 //                        //flightdate or arnk
 //                        if(resp.bagRecords[i].originalBags[0].flightDateOrARNK != null){
 //                            if(resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate != null){
 //                                //for(Integer u=0; u<resp.delayedBagGroup.bagItinerary.flightDateOrARNK.size(); u++){//5
 //                            R2_Auxiliar_Data_Incident__c br = new R2_Auxiliar_Data_Incident__c();

 //                            br.R2_ADI_TXT_BR_Flight_number__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightNumber;
 //                            //br.R2_ADI_DAT_BR_Flight_Date__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightDate;
 //                            br.R2_ADI_TXT_BR_Airline_Code__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.airlinecode;
 //                            br.R2_ADI_TXT_BR_ARNK__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.arnk;
 //                            //br.R2_ADI_MSDT_Incident__c = bag.Id;
 //                            //listaAuxInc.add(br);
 //                       // }
 //                            }
 //                        }
 //                    //}
 //                }
 //                // System.debug('RES UN PIR '+pirResp);
 //                listaPIRs.add(pirResp);
 //            }
 //             System.debug('LISTA PIRssssss '+listaPIRs);
 //            return listaPIRs;
 //        }else{
 //            if(intentos<3 && res.getStatusCode() == 401){
 //                intentos+=1;
 //                    R1_CLS_SendCustomerMDM.login();
 //                    return searchBags(wrapper, intentos);
 //                    //return searchBags(incidentId, intentos);
 //            }else{
 //                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', 'Error en searchBags', 'Baggage');
 //                return null;
 //            }
 //        }


 //    }catch(Exception exc){

 //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
 //        return null;
 //    }
 //}


/////////////////////////////////////////////Search Inactive////////////////////////////////////////////////////

public static List<R1_Incident__c> searchBags (String wrapper, Integer intentos){ //WpReqSearch      List<R1_Incident__c>    
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

           // WpReqSearch wrp =  new WpReqSearch();
            /*
            wrp.target =
            wrp.version =
            wrp.moduleId =
            wrp.pos =
            wrp.iataSource =
            wrp.airlineVendorId =
            wrp.bagType =
            wrp.searchType =
            wrp.refStationCode =
            wrp.refAirlineCode =
            wrp.recordStatus =
            wrp.handledOption =
            wrp.name =
            wrp.exact =
            wrp.missingStationCode =
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.                                                                                            SEARCH
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.
            wrp.

*/
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return searchBags(wrapper, intentos);
                    //return searchBags(incidentId, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', 'Error en login', 'Baggage');
                    return null;
                }
            }

            string wsMethod = 'R2_SearchBagsInactive';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }


            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'bags/search';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            //String body = JSON.serialize(wrp);
            //String body ='{   "bagType": "DELAYED",   "searchType": "SIMPLE",   "name": {      "name": "MANI",      "exact": "true"   },   "agentId": "AgentId"}';
            //String body = JSON.serialize(wrapper);
            wrapper = helper_fixerJson(wrapper);
            String body = wrapper;

            System.debug('Body tras meter WRAPPER::::::: '+body);
            req.setBody(body);


            Http http = new Http();
            HTTPResponse res;


            res = http.send(req);
            System.debug('STATUS '+res.getStatusCode());
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                System.debug('RESSSSSP ANTES deserializar '+res.getBody());
                WpResSearch resp = (WpResSearch)JSON.deserialize(res.getBody(),WpResSearch.class);
                System.debug('RESSSSSP deserializado__ '+resp);
               // return resp;

                List<R1_Incident__c> listaPIRs = new List<R1_Incident__c>();
                System.debug('tamaño bagRecords::::: '+resp.bagRecords.size());
                for(Integer i=0; i< resp.bagRecords.size() ;i++){
                    R1_Incident__c pirResp = new R1_Incident__c();
                    System.debug('resp.bagRecords[i].recordIdentifier.recordtype--->'+resp.bagRecords[i].recordIdentifier.recordtype);
                    System.debug('bag I de '+i+'--->'+resp.bagRecords[i]);

                    //pirResp.RecordType.DeveloperName = resp.bagRecords[i].recordIdentifier.recordtype;
                    if(resp.bagRecords[i].recordIdentifier.recordReference != null){
                        pirResp.R2_INC_TXT_PIR_Station_Code__c = resp.bagRecords[i].recordIdentifier.recordReference.stationCode; //stationAirlineGroup
                        pirResp.R2_INC_TXT_PIR_Airline_Code__c = resp.bagRecords[i].recordIdentifier.recordReference.airlineCode;
                    }
                    pirResp.R2_INC_TXT_PIR_Reference_Number__c = resp.bagRecords[i].recordIdentifier.recordReference.referenceNumber;
                    pirResp.R2_INC_PKL_PIR_Status_incidence__c = resp.bagRecords[i].status;
                    //for(Integer n=0; n<resp.bagRecords[i].names.size() ;n++){
                        pirResp.R2_INC_TXT_PIR_Name__c = resp.bagRecords[i].names[0]; //.name;
                        //pirResp.R2_INC_TXT_PIR_Last_name__c = resp.bagRecords[i].names[1]; //.name;
                        //pirResp.R2_INC_TXT_PIR_Last_name2__c = resp.bagRecords[i].names[2]; //.name;
                    //}
                    //for(Integer n=0; n<resp.bagRecords[i].initials.size() ;n++){
                        //pirResp.R2_INC_TXT_PIR_Initial__c = resp.bagRecords[i].initials[0]; //.initial
                       // pirResp.R2_INC_TXT_PIR_Initial2__c = resp.bagRecords[i].initials[1].initial; //.initial
                       // pirResp.R2_INC_TXT_PIR_Initial3__c = resp.bagRecords[i].initials[2]; //.initial
                    //}

                    List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
                    if(resp.bagRecords[i].originalBags != null){
                        //for(Integer b=0; b<resp.bagRecords[i].originalBags.size(); b++){
                            //R2_Baggage__c bag = new R2_Baggage__c();
                            //bag.R2_BAG_MSDT_Incident__c = pirResp.Id;
                            //bagTag 855 linea
                    //Comentado el mapeo con bags ya que no se muestra la informacion en la busqueda
                         //   if(resp.bagRecords[i].originalBags[b].bagTag != null){
                         //     bag.R2_BAG_CHK_BagTag_Suspended__c = resp.bagRecords[i].originalBags[b].bagTag.suspended;
                            //    bag.R2_BAG_TXT_Bag_Airline_Code__c = resp.bagRecords[i].originalBags[b].bagTag.airlinecode;
                         //       if(resp.bagRecords[i].originalBags[b].bagTag.licenseNumber != null){
                         //           bag.R2_BAG_NUM_LN_TagType__c = resp.bagRecords[i].originalBags[b].bagTag.licenseNumber.tagType;
                         //           bag.R2_BAG_TXT_LN_Issuer_Code__c = resp.bagRecords[i].originalBags[b].bagTag.licenseNumber.issuerCode;
                         //       }
                            //     bag.R2_BAG_TXT_TagSequence__c = resp.bagRecords[i].originalBags[b].bagTag.tagSequence;
                         //   }
                            ////colourType
                         //   if(resp.bagRecords[i].originalBags[b] != null){
                         //      if(resp.bagRecords[i].originalBags[b].colourCode != null){
                         //       bag.R2_BAG_CHK_Suspended__c = resp.bagRecords[i].originalBags[b].colourCode.suspended;
                         //       bag.R2_BAG_PKL_Colour__c = resp.bagRecords[i].originalBags[b].colourCode.colorCode;
                         //       bag.R2_BAG_TXT_TypeCode__c = resp.bagRecords[i].originalBags[b].colourCode.typeCode;
                         //       }
                         //   }
                            //flightdate or arnk
                            if(resp.bagRecords[i].originalBags[0].flightDateOrARNK != null){
                                if(resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate != null){
                                    //for(Integer u=0; u<resp.delayedBagGroup.bagItinerary.flightDateOrARNK.size(); u++){//5
                                R2_Auxiliar_Data_Incident__c br = new R2_Auxiliar_Data_Incident__c();

                                br.R2_ADI_TXT_BR_Flight_number__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightNumber;
                                //br.R2_ADI_DAT_BR_Flight_Date__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightDate;
                                br.R2_ADI_TXT_BR_Airline_Code__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.airlinecode;
                                br.R2_ADI_TXT_BR_ARNK__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.arnk;
                                //br.R2_ADI_MSDT_Incident__c = bag.Id;
                                //listaAuxInc.add(br);
                           // }
                                }
                            }
                        //}
                    }
                    // System.debug('RES UN PIR '+pirResp);
                    listaPIRs.add(pirResp);
                }
                 System.debug('LISTA PIRssssss '+listaPIRs);
                return listaPIRs;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return searchBags(wrapper, intentos);
                        //return searchBags(incidentId, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', 'Error en searchBags', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.searchBags()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
            return null;
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 public static String helper_fixerJson(String cadena){
   String fixed = cadena;
   fixed = fixed.replaceAll('"dateReplace":','"date":');
     fixed = fixed.replaceAll('"rDate":','"date":');
     fixed = fixed.replaceAll('"newReplace":','"new":');
     fixed = fixed.replaceAll('"current":','"currency":');
     fixed = fixed.replaceAll('(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1.000$3'); //convert date formats
   fixed = fixed.replaceAll('"+[a-zA-Z]+":null[,]?', '');//('[,]?"+[a-zA-Z]+":null', ''); //delete nulls
     fixed = fixed.replaceAll('[,]?"[a-zA-Z]+":\\[\\],}', '}'); //delete vacios
     fixed = fixed.replaceAll('"[a-zA-Z]+":\\[\\],', '');
     fixed = fixed.replaceAll('"[a-zA-Z]+":\\{\\},', '');
     fixed = fixed.replaceAll(',}', '}');
   return fixed;
 }

}