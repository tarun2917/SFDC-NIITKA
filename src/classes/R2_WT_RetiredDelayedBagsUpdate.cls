/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage the World Tracer - bags records

    IN:
    OUT:

    History:

    <Date>              <Author>                                 <Description>
    17/10/2017    Alberto Puerto Collado        Merge all types of WorldTracer integration (6) on this onbagReceivedDatee
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_WT_RetiredDelayedBagsUpdate{
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
        public String rDate; //Date / string
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
        public Route additionalRoutes;
        public OriginDestination arnk;
    }
    public class Route{
        public List<String> route;
    }
    public class FlightDateOrARNK{
        public FlightDate flightDate;
        public String arnk;
    }
    public class BaggageItinerary{
        public List<FlightDateOrARNK> flightDateOrARNK;
    }
    public class Itinerary{
        public List<FlightSegmentOrARNK> flightSegmentOrARNK; //no lista antes
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
        /*public String stationCode;
        public String airlineCode;
        public String referenceNumber; //Integer*/
        public String recordType;
        public RecordReference recordReference;
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

    public class BagType{
        public List<DelayedBag> delayedBag;
    }

   public class DelayedBag{
      
        public ColourAndType colorTypeDesc;
        public BagTag bagTag;
        public BrandInfo brandInfo;
        public BagDelivery bagDelivery;
        public String lockCode;        
        public String storageLocation;
        public String bagDetails;
        public AssociatedRecord associatedRecord;
        //public ColourTypeAndCodeType colorTypeDesc;
        //public String colorCode;
        //public Boolean suspended;
        //public Descriptor descriptor;
        public UniqueID uniqueID;
        public BagSentToCustoms bagSentToCustoms;
        public BagReceivedFromCustoms bagReceivedFromCustoms;
        public BagContents bagContents;
        public String contentsDesc;
        public Remarks remarks;
       	public String seq;
        //public BaggageItinerary baggageItinerary;
    }

    public class ColourAndType{
        public Boolean suspended;
        public String colorCode;
        public String typeCode;
        public DescriptorType descriptor;
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
    //public class DelayedBag{
    //  //  public String colourCode;
    //    //public String typeCode;
    //  //  public String materialElement;
    //  //  public String otherElement;
    //    public ColourAndTypeType colourAndType;
    //    public BagTag bagTag;
    //    public BrandInfo brandInfo;
    //    public BagDelivery bagDelivery;
    //    public String lockCode;
    //    public String storageLocation;
    //    public String bagDetails;
    //    public AssociatedRecord associatedRecord;

    //    public Boolean colorTypeDesc;
    //    public String colorCode;
    //    public Boolean suspended;
    //    //public Descriptor descriptor;
    //    public UniqueID uniqueID;
    //    public BagSentToCustoms bagSentToCustoms;
    //    public BagReceivedFromCustoms bagReceivedFromCustoms;
    //    public BagContents bagContents;
    //    public String contentDescription;
    //    public Remarks remarks; //antes no lista
    //    public BaggageItinerary baggageItinerary;
    //}
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
        public String noofPassengers;
        public String autoMessageOption;
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
    public Class FurtherInfo{
        public String furtherInfoDesc;
    }
    
    public class AdditionalInfo{
        public List<MiscellaneousInfo> miscellaneousInfo;
        public FurtherInfo furtherInfo;
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
        public String seq;
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

    public class CostRemarksListType{
        public String costRemarksText;
        public String seq;
    }
    public class ClaimData{
        public ClaimAmount claimAmount;
        public List<CostRemarksListType> costRemarks;
        public PassengerPayments payments;  //duplicado por servicio close DAH
        public PassengerPayments passengerPayments;
        public Date claimDate;
        public Date notifiedDate;
        public Date dateNotified;
        public Date questionnaireDate;
        public String faultStation;  //duplicado por servicio close DAH
        public String faultStationCode;
        public String faultTerminal;
        public Boolean insurance;
        public Boolean insuranceIndicator; //bueno
        public Boolean liabilityTagIndicator;
        public Boolean liabilityTag;
        public String missingBags;
        public PartnerCode partnerCode;
        public String lossComments;
        public Integer lossReasonCode;
        public ToilerKits toilerkits;
        public Amount excessValue;
        public Date tracingFinalized;
        public String replacementBagIndicator; //OJO no estan en excel entonces no esta mapeado
        public String repairBagIndicator;//OJO no estan en excel entonces no esta mapeado
        public String replacementBag; 
        public String repairBag;
        public ToiletKits toiletKits;
    }
    public class ToiletKits {
        public String male;
        public String female;
    }
    public class Claim{
        public ClaimData claimData;
    }
// ******END CLAIMS WRAPPERS**********
     public class InboxAddressType{
        public ReferenceStationAirline stationAirline;
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
        //public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public String lzControlDate;
        public NewRecordType crossReferenceRecord;
        public AdditionalInfo additionalInfo;
        public Claim claim;
        public List<InboxAddressType> inboxAddresses;
        public String promptDate;
        public String promptText;
        public String agentID;
        public String rDate;
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
        public wp_DamagedBagType delayedBagGroup;
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
        //public wp_BagRecordType recordId;
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
        public Integer lossReasonCode;
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
        public String seq;
}
public class InitialsInactive {
        public String initial;
        public String seq;
}*/
//REQUEST
// ******* Retrieve Delayed Bag Retired Record Web Request V01 **********

public class Wp_UpdateRetiredDelayedBag_Request{
        public String airlineVendorId;
        public RecordReference recordReference;
        public DelayedBagGroupType delayedBagGroup;
        public PassengerType passengers;
        public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public AdditionalInfoType additionalInfo;
        public Claim claim;
        public String lzControlDate;
        public List<NewRecordType> crossReferenceRecords;
        public InboxAddressType inboxAddress;
        public DefinedPromptType definedPrompt;
        public String agentID;
        public String rDate;


}

public class DefinedPromptType{
    public String rdate;
    public String text;
}

    public class Wp_RetrieveDelayedBag_Request{
        public String airlineVendorId;
        public RecordType recordId;
        public String rDate;//reserved: Date;
        public String agentId;
    }
//RESPONSE
public class Wp_RetrieveDelayedBag_Response{
        public String success;
        public List<WarningType> warnings;
        public DiaryInfoType diaryInfo;
        public DelayedBagGroupType delayedBagGroup; //DamagedBagGroupType
        public PassengerType passengers;
        public AdditionalInfoType additionalInfo;
        public Claim claim; //ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<InternetInfo> internetInfo;
        public List<SmsInfo> smsInfo;
        public List<String> emailInfo;
        //public List<String> history;
        //public List<String> matchHistory;
        public RecordHistoryType recordHistory;
        public String recordStatus;
    }

public class InternetInfo{

    public String internetInfoText;
    public String seq;

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
    //public class Wp_RetrieveDamagedBag_Response{
    //    public String success;
    //    public List<WarningType> warnings;
    //    public DiaryInfoType diaryInfo;
    //    public DamagedBagGroupType damagedBagGroup; //DamagedBagGroupType
    //    public PassengerType passengers;
    //    public AdditionalInfoType additionalInfo;
    //    public Claim claim; //ClaimType
    //    public String designatedLocator;
    //    public String handledAirlineCopyIndicator;
    //    //public List<String> internetInfo;
    //    public List<SmsInfo> smsInfo;
    //    public List<String> emailInfo;
    //    //public List<String> history;
    //    //public List<String> matchHistory;
    //    public RecordHistoryType recordHistory;
    //    public String recordStatus;
    //}

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
            public String seq;
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
    public class DescriptorType{
        public String mtrlElement;
        public List<String> otherElement;
    }
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
        public FurtherInfo furtherInfo;
        public List<SupplementaryInfoType> supplementaryInfo;
        public CustomsInfoType customsInfo;
        public List<UserComments> userComments;
        public List<DeliveryInfoType> deliveryInfo;
        public List<MessageInfoType> messageInfo;
        public MatchInfoType matchInfo;

    }

    public class CustomsInfoType{
        public String customsInfoDesc;
    }
    public class FurtherInfoType{
        public String furtherInfoDesc;
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
        public AddressType bagAddress; //AddressType
        public String bagWeight;
        public String baggageWeight;//de inactive ia
        public String contentsGender;
        public DeliveryType delivery;
        public List<BagPhones> bagPhones; //bagPhones
        public List<BagType> delayedBags;
        //public List<DelayedBag> delayedBags; //BagType
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

    public class DelayedBagGroupType{
        public AddressType bagAddress; //AddressType
        public String baggageWeight;//de inactive ia
        public String contentsGender;
        public DeliveryType delivery;
        public List<BagPhones> bagPhones; //bagPhones
        public List<DelayedBag> delayedBags;        
        ////public BagType onHandBags;
        public String bagLastSeen;
        public BaggageItinerary baggageItinerary;//BagItinerary bagItinerary;
        public String excessBaggage;
        public BagTagDestinationsType bagTagDestinations;
        public Boolean keysCollected;
        public String missingWeight;
        public String matchWindow;
        public LostContentsType lostContents;
        public String contentsDamage;
    }

    public class LostContentsType{
        public List<ContentListType> content;
    }
    public class ContentListType{
        public String contentValue;
        public String seq;
    }
     public class DeliveryType{
        public AddressType  deliveryAddress;
        public String deliveredTime;
        public BagReceived bagReceived;
        public String deliveryWeight;
        public List<DlvInfoType>  localDeliveryInfo; //DlvInfoType 
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
        public String createDate; //strings//dateTime
        public String suspendDate;//dateTime
        public String tracingDate;//dateTime
        public String closeDate;//dateTime
        public String reinstateDate;//dateTime
        public String rematchDate;//dateTime
        public String lzControlDate;//dateTime
        public String retiredDate;//dateTime
        public NewRecordType associateRecord;
        public List<NewRecordType> crossReferenceRecords; //
        public Date disposalDate;
        public String controllingStation;
        public Date tracingFinalizedDate;
        public String claimInvestigationDate;//Datetime
        public String inventoryReceivedDate;//Datetime
        public String tracingExtendedDate;//Datetime
        public String dateInventoryReceived;
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


    final static Map<String,Id> map_RT = new Map<String,Id>();

    static{
        for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE sObjectType = 'R1_Incident__c']) {
            map_RT.put(rt.DeveloperName, rt.Id);
        }
    }

    /*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Sends a HTTPRequest

    IN:
    OUT:

    History:
    <Date>                     <Author>                   <Change Description>
    29/08/2017              Alberto Puerto Collado          Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String updateRetiredRecord_AHL_PDI(String wrapper, Integer contador) {
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('RETRIEVE DELAYED BAG UPDATE');
            System.debug('wrapper: ' + wrapper);
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
                    return updateRetiredRecord_AHL_PDI(wrapper, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()', 'updateRetiredRecord_AHL_PDI LOGIN error',
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
            req.setMethod('PUT');
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
            //String body = '{"recordId":{"recordType":"DELAYED","recordReference":{"airlineCode":"IB","referenceNumber":"67371","stationCode":"MAD"}},"date":"2017-01-11","agentId":"AGENT"}';
            String body = helper_fixerJson(wrapper);
            //body = body.replaceAll('"rDate":','"date":');
            System.debug(body);
            req.setBody(body);
            System.debug('Hasta aqui ha llegado!!!!!!!!!!!!!!!!!!!');
            //llamada
            Http http = new Http();
            HTTPResponse res;
            //system.debug('res previo send********'+res);
            res = http.send(req);
            system.debug('SEND********'+res.getStatusCode());
            //recogemos datos de response
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('antes de DESERIALIZE '+res.getBody());
                Wp_RetrieveDelayedBag_Response resp = (Wp_RetrieveDelayedBag_Response)JSON.deserialize(res.getBody(),Wp_RetrieveDelayedBag_Response.class);
                system.debug('RESP********'+resp);
                
            //////////////////////////////////////////////////////////////////////////////////////////////////

            

               
                
                return null;
            }
            else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return updateRetiredRecord_AHL_PDI(wrapper, contador);
            }
            else {
                if(res.getStatusCode() == 400){
                    R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()', 'updateRetiredRecord_AHL_PDI LOGIN error',
                        'Malformed request. Build correct request and try again, status code:'+res.getStatusCode(), 'R2_Baggage__c');
                }else if(res.getStatusCode() == 403){
                    R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()', 'updateRetiredRecord_AHL_PDI LOGIN error',
                        'The operation on the resource is not authorised. Insufficient permissions, status code:'+res.getStatusCode(), 'R2_Baggage__c');
                }else if(res.getStatusCode() == 500 || res.getStatusCode() == 502 || res.getStatusCode() == 503){
                    R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()', 'updateRetiredRecord_AHL_PDI LOGIN error',
                        'Server error, status code:'+res.getStatusCode(), 'R2_Baggage__c');
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()', 'updateRetiredRecord_AHL_PDI LOGIN error',
                        'No se puede conectar con MDM, status code:'+res.getStatusCode(), 'R2_Baggage__c');
                }
                return null;
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_RetiredDelayedBagsUpdate.updateRetiredRecord_AHL_PDI()',
                '__'+'__'+'__'+'__'
                , exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Fix Json, replace reserved values, convert date formats and delete null values from JSON

    IN:

    OUT:           Station and communication

    History:

    <Date>              <Author>            <Description>
    03/11/2017    Alberto Puerto Collado    Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String helper_fixerJson(String cadena){
        String fixed = cadena;
        fixed = fixed.replaceAll('"dateReplace":','"date":');
        fixed = fixed.replaceAll('"rDate":','"date":');
        fixed = fixed.replaceAll('"newReplace":','"new":');
        fixed = fixed.replaceAll('"typeChange":','"change":');
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