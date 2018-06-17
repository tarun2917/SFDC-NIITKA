/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage the World Tracer - bags records

    IN:
    OUT:

    History:f

    <Date>              <Author>                                 <Description>
    17/10/2017    Alberto Puerto Collado        Merge all types of WorldTracer integration (6) on this onbagReceivedDatee
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_WT_Bags_Management{
    //CONSTANTES
    public static final String NO_IBERIA_PLUS = 'NO IBERIA PLUS';

     // COMMON TYPES CLASSES
  //-------------------------------------------------------------------------------------------
    public class AddressLine{
        public String addressLineDesc;
        public String seq;
    }
    public class State{
        public String stateDesc;
        public String stateName; //duplicado para response de OnHandBag
        public String stateCode; // FIXME!!!!!!!
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
    public class BagPhonesCREATED{ // FIXME
        public List<String> phone;
    }
    public class Descriptor{
        public String mtrlElement;//materialElement;
        public String materialElement;//materialElement; FIXME for created
        public List<String> otherElement;//antes no list
    }
    public class LicenseNumber{
        public String tagType;
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
    public class InternetInfo{
        public String internetInfoText;
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
        public String stationAirline; // FIXME creado para created
        public String stationCode;
    }

    public class FlightDate{
        public String flightNumber;
        public String flightDate; //Date / string
		public String rDate; // FIXME
        public String airlineCode;
        public String stationCode;
        public String dateReplace;
    }
    public class OriginDestination{
        public String origin;
        public String destination;
    }

    public class OriginDestin{
        public OriginDestination originDestination;
    }

    public class Flight{
        public FlightDate flightandDate;
        public OriginDestination originDestination;
    }

    public class FlightSegmentOrARNK{
        public Flight flight; //List<Flight>
        public Flight flightAmend; //List<Flight>
        public List<Route> additionalRoutes;
        public OriginDestin arnk;
    }
    public class Route{
        public String route;
    }
    public class RouteOHD{
        public List<String> route;
    }
    public class FlightDateOrARNK{
        public FlightDate flightDate;
        public String arnk;
    }
    public class BaggageItinerary{
        public List<FlightDateOrARNK> flightDateOrARNK;
    }
    public class BaggageItineraryDOH{
        public List<FlightSegment> flightDateOrARNK;
    }
    public class Itinerary{
        public List<FlightSegmentOrARNK> flightSegmentsorARNK; //no lista antes // antes flightSegmentOrARNK
        public List<String> additionalRoutes;
    }
    public class ItineraryCREATED{
        public List<FlightSegmentOrARNK> flightSegmentsorARNK; //no lista antes
    }
    public class ItineraryBag {
        public FlightSegments flightSegments;
        public List<String> routes;
        public FlightSegments newFlightSegments;
        public List<String> newRoutes;
    }
    public class ItineraryBagOHD {
        public FlightSegments flightSegments;
        public RouteOHD routes;
        public FlightSegments newFlightSegments;
        public RouteOHD newRoutes;
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
    public class BagDeliveryAddress{
        public AddressType deliveryAddress;
        public String deliveryWeight;
        public String deliveryInfo;
        public String divInfo;
        public String deliveryService;
        //public String deliveredTime;
        public String rDate;//datetime - bagReceivedDate
        public String bagReceivedStationCode;

        public List<LocalDivInfo> localDivInfo;

    }
	public class BagDeliveryAddressCREATED{
		public AddressTypeCREATED deliveryAddress;
		public String deliveryWeight;
		public List<String> deliveryInfo;
		public List<String> deliveryService;
		//public String deliveredTime;
		public String rDate;//datetime - bagReceivedDate
		public String bagReceivedStationCode;
		public List<LocalDivInfo> localDlvInfo;
	}
    public class Status{
        public String outForDelivery;
        public String delivered;
        public String unableToDeliver;
        public String trackingUpdate;
    }
    public class BagReceived{
		public String bagReceivedDate; // FIXME AÑADIDO
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


    public class AssociatedRecord{ //son 3, sobran dos
        public String stationCode;
        public String airlineCode;
        public String referenceNumber; //Integer
        //public String recordType;
        //public String recordReference;
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
         public String uniqueId;
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
      //  public String colourCode;
        //public String typeCode;
      //  public String materialElement;
      //  public String otherElement;
        public ColourAndTypeType colourAndType;
        public BagTag bagTag;
        public BagTag rushTag;
        public BrandInfo brandInfo;
        public BagDelivery bagDelivery;
        public String lockCode;
        public String storageLocation;
        public String bagDetails;
        public NewRecordType associatedRecord; //public AssociatedRecord associatedRecord;

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
        public ItineraryBag itinerary; //Duplicado porque ahora read es itinerary
    }

    public class DelayedBagCREATED {
      //  public String colourCode;
        //public String typeCode;
      //  public String materialElement;
      //  public String otherElement;
        public ColourAndTypeType colourAndType;
        public BagTag bagTag;
        public BagTag rushTag;
        public BrandInfo brandInfo;
        public BagDelivery bagDelivery;
        public String lockCode;
        public String storageLocation;
        public String bagDetails;
        public NewRecordType associatedRecord; // FIXME ojo estos nombres

        public ColorTypeDesc colorTypeDesc;
        public String colorCode;
        public Boolean suspended;
        //public Descriptor descriptor;
        public UniqueID uniqueID;
        public BagSentToCustoms bagSentToCustoms;
        public BagReceivedFromCustoms bagReceivedFromCustoms;
        public BagContents bagContents;
        public String contentDescription;
        public List<String> remarks; //antes no lista // FIXME otra vez
        public BaggageItinerary baggageItinerary;
        public ItineraryBag itinerary; //Duplicado porque ahora read es itinerary
    }

    public class Station{
        public String stationValue;
    }
    public class StationListCREATED {
        public List<StationITEMCREATED> station;
    }
    public class StationITEMCREATED {
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

    public class DelayedBagGroupCREATED{ // FIXME ojo
        public AddressTypeCREATED bagAddress;
        public String bagWeight;
        public String contentsGender;
        public BagDeliveryAddressCREATED bagDeliveryAddress;
        public BagPhonesCREATED bagPhones;
        public List<DelayedBagCREATED> delayedBags;
        public String excessBaggage;
        public Boolean keysCollected; //String
        public String missingWeight;
        public String matchWindow;

        public List<FlightDateOrARNK> bagItinerary;
        public StationListCREATED bagTagDestinations;
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
        public String zipCode;
    }
    public class ContactInfoOHD{
        public AddressType permanentAddress;
        public AddressType temporaryAddress;
        public Country country;
        public List<BagPhones> permanentPhones;
        public List<BagPhones> cellPhones;
        public List<BagPhones> temporaryPhones;
        public List<Emails> emails;
        public List<Faxes> faxes;
        public String validityDate;
        public String state;
        public String zipCode;
    }
    public class ContactInfoCREATED {
        public AddressTypeCREATED permanentAddress;
        public AddressTypeCREATED temporaryAddress;
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
        public String numberOfPassengers;
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
        public PassengerPayments passengerPayments;
    }
    public class PassengerTypeOHD{
        public List<Names> names;//strings antes
        public String givenName;
        public List<Initials> initials;
        public String title;
        public ContactInfoOHD contactInfo;

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
       // public String destination;
       // public String arnk;
        //public String route;
        public String status;
        public String pooledTicketNumber;
        public String fareBasis;
        public PassengerPayments passengerPayments;
    }
    public class PassengerTypeCREATED {
        public List<Names> names;//strings antes
        public String givenName;
        public List<Initials> initials;
        public String title;
        public ContactInfoCREATED contactInfo;

        public String frequentFlyerId;
        public String language;
        public String ticketNumber;
        // public TicketNumber ticketNumber; - ojo cambiado con el "ultimo" metodo
        public String pnr;
        public String numberOfPassengers;
        public String autoMessageOption;
        public String passportInfo;
        public ItineraryCREATED itinerary;

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
        public String currencyCodeValue; //duplicado por servicio read DAH
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
        public String carrierCode; //FIXME ojo
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
        public List<String> costRemarks; // FIXME esto deberia ser una list de CostMark!
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
        public Boolean liabilityTagIndicator;
        public String missingBags;
        public PartnerCode partnerCode;
        public String lossComments;
        public String lossReasonCode;
        public ToilerKits toilerkits;
        public String toiletKitsMale;
        public String toiletKitsFemale;
        public Amount excessValue;
        public Date tracingFinalized;
        public String replacementBagIndicator; //OJO no estan en excel entonces no esta mapeado
        public String repairBagIndicator;//OJO no estan en excel entonces no esta mapeado
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
        public String timeStamp; //added 11/01/2018 new field
        //napalm temporal esperando arreglos en II
        //public String errorCode;
        //public String errorDescription;
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
         public String airlineVendorID;
         public AssociatedRecord recordReference;
         public DelayedBagGroup delayedBagGroup;
         public List<PassengerType> passengers;
         public String handledAirlineCopyIndicator;
         public String designatedLocator;
         public AdditionalInfoType additionalInfo;
         public Claim claim;
         public String lzControlDate;
         public NewRecordType crossReferenceRecord;
         public List<InboxAddressType> inboxAddresses;
         public DefinedPromptType definedPrompt;
         public String agentID;
     }
     public class DefinedPromptType{
       public String rDate;
       public String text;
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
        public String airlinevendorid;
        public String recordType;
    }

    public class WR_ReopenDelayedBagWebRequest{ //OK
        public AssociatedRecord recordReference;
        public NewStationAirlineType newStationAirline;
        public BagType bagElements;
        public String agentId;
        public String airlinevendorid;
        public String recordType;
    }

    public class WR_ReinstateDelayedBagWebRequest{ //OK
        public AssociatedRecord recordReference;
        public List<BagElementDetailsType> bag;
        public String agentId;
        public String airlinevendorid;
        public String recordType;
    }

    public class WR_ReassignDelayedBagWebRequest{//OK
        public AssociatedRecord recordReference;
        public NewStationAirlineType newStationAirline;
        public String agentId;
        public String airlinevendorid;
        public String recordType;
    }

    public class WR_GenerateSummaryReport_PIRWebRequest{ //OK
        public AssociatedRecord recordReference;
        public String agentId;
        public String languageCode;
        public String airlinevendorid;
        public String recordType;
    }

    public class WR_CreateDelayedBagWebRequest{ //OK
        public String airlineVendorId;
        public RefStationAirlineType refStationAirline;
        public String tracingOption;
        public DelayedBagGroupCREATED delayedBagGroup;
        public PassengerTypeCREATED passengers; // FIXME no tenia S!
        public List<NewRecordType> crossReferenceRecord;
        public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public AdditionalInfoType additionalInfo;
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
        public List<AssociatedRecord> recordReference;
        //public ClaimData claim;
        public String agentId;
    }
    public class WPCreateDamagedBagWebRequest{
    public RefStationAirlineType refStationAirline;
    public DamagedBagGroupType damagedBagGroup;
    public PassengerType passenger;
    public CrossReferenceRecords crossReferenceRecords;
    public string handledAirlineCopyIndicator;
    public string designatedLocator;
    public AdditionalInfo additionalInfo;
    public string messageInfo;
    public ClaimData claim;
    public string teleTypeAddresses;
    public string agentId;
    public AssociatedDelayRecord associatedDelayRecord;
}

public class DamagedBagGroupType{
    public AddressType bagAddress;
    public string baggageWeight;
    public string contentsGender;
    public BagDeliveryAddress delivery;
    public List<BagPhones> bagPhones;
    public List<DamagedBag> damagedBags;
    public BaggageItinerary baggageItinerary;
    public String excessBaggage;
    public string missingWeight;
    public string lostContents;
    public string contentsDamage;
}
public class DamagedBag{
    public ColorTypeDesc colorTypeDesc;
    public BagTag bagTag;
    public BrandInfo brandInfo;
    public BagDelivery bagDelivery;
    public String lockCode;
    public String uniqueId;
    public BagSentToCustoms bagSentToCustoms;
    public string storageLocation;
    public string bagDetails;
    public DamagedTypes damagedType;
    public AssociatedRecord associatedRecord;
}
public class ColorTypeDesc{
    public boolean suspended;
    public string colorCode;
    public string typeCode;
    public Descriptor descriptor;
}

public class DamagedTypes{
    public List<DamagedType> damagedType;
}
public class DamagedType{
    public string location;
    public string typeChange;
    public string amount;
}
public class CrossReferenceRecords{
    public List<CrossReferenceRecord> crossReferenceRecord;
}
public class CrossReferenceRecord{
    public string recordType;
    public RecordReference recordReference;
}

public class AssociatedDelayRecord{
    public AssociatedRecord recordReference;
    public List<String> bagIds;
}
// ******************************************************RESPONSE DELAYED ********************************************************
    public class WR_DelayedBagWebResp{
        public String success;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }

    public class WR_DelayedBagWebRespRecord{
        public String success;
        public NewRecordType record;
        public NewRecordType newRecord;  //duplicado para usarlo en la response de reassign
        public List<WarningType> warnings;
        public List<ErrorType> errors;///List<Errors>
    }

    public class WR_DelayedBagWebRespReport{
        public String success;
        public String reportOutput;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }
//******************************************************RESPONSE DAMAGED ********************************************************
    //Create
    public class WPCreateDamagedBagWebResponse{
        public String success;
        public AssociatedRecord record; //AssociatedRecord //NewRecordType
        public List<WarningType> warnings;
        public List<ErrorType> errors;
        //public Warnings warnings;
    }
    //Generate
    public class WPGenerateDamagedBagReportWebResponse{
        public String success;
        public String reportOutput;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }
    //Reassign
    public class WPReassignDamagedBagWebResponse{
        public String success;
        public NewRecordType newRecord;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }
    //Update
    public class WPUpdateDamagedBagWebResponse{
        public String success;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }
    //Close
    public class WPCloseDamaged_CFI_Response{
        public String success;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
    }


//****************************************************** ONHAND ********************************************************
     //Response
    public class WPRequestOnHandBagWebResponse{
        public String success;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
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
        public String success;//ok
        public List<WarningType> warnings;
        public DiaryInfoType diaryInfo;//ok wp_DiaryInfoType
        public BagGroupType  delayedBagGroup;//ok DelayedBagGroup
        public PassengerType passengers;//ok wp_PassengerType
        public AdditionalInfo additionalInfo; //wp_AdditionalInfoType
       // public Claim claim; //wp_ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<InternetInfo> internetInfo;
        public List<SmsInfo> smsInfo;
        public List<EmailInfo> emailInfo;//21/02 antes list  string
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
        public List<PassengerType> passengers;
        public AdditionalInfoType addditionalInfo;
        public Claim claim; //ClaimType
        public String designatedLocator;
        public String handledAirlineCopyIndicator;
        public List<InternetInfo> internetInfo;
        public List<SmsInfo> smsInfo;
        public List<EmailInfo> emailInfo; //antes list string
        public List<String> history;
        public List<String> matchHistory;
        public String recordStatus;
    }

//****************************************************** STATION & COMMUNICATION ********************************************************
    public class ValuesType{
        public List<String> value;
    }

    public class SubPropertyType{
        public String stationPropertySubTypeDescription;
        public ValuesType values;
        //public String subtypedescription;
        //public ValuesType subtypevalues;
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
        public String stationCode;
        public String airlineCode;
        public String area;
        //public String sequence;
    }
    //public class DestinationInboxAdress{//borrar again -.-
    //    public List<DestinationType> destinationInboxAddress;
    //}
    public class MessageDeliveryType{
        //public String messagedeliverytime;
        //public String messagedeliveryfromDate;
        //public String messagedeliverytodate;
        public String rTime;
        public String fromDate;
        public String toDate;
    }
    public class RecordIDType{
        //public List<AssociatedRecord> recordID; //BagRecordType
    	public List<NewRecordType> recordID;
    }
    public class OriginType{
        public String teletypeAddress;
        public String chargeableairline;
    }
     // REQUEST WRAPPERS
 //---------------------------------------------------------------------------------------------
    public class WR_InboxMessageSend_PXFWebReq{
        public String airlineVendorId;
        public List<DestinationType> destinationInboxAddress;
        //public DestinationInboxAdress destination;
        //public String handledOption;
        public String originStation;
        public String message;
        public List<NewRecordType> recordId;
        //public List<AssociatedRecord> records; // BagRecordType
        public MessageDeliveryType messageDelivery;
        public List<String> teletypeAddress;
        public String agentId;
        //public String version;
    }

    public class WR_SendTeletypeMessageWebReq{
        public OriginType origin;
        public List<String> destinationTeletypeAddress;
        public RecordIDType copyTo; //List<RecordIDType>
        public String message;
        public String agentId;
    }

    public class WR_DisplayStationListWebReq{
        public String status;
        public String airlineVendorId;
        public String airline;
        public String agentId;
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
        public List<Content> contents; // BagContentType
        public String uniqueId;
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
        public AssociatedRecord referenceStationAirline;  // StationCode & AirlineCode
        //public String refStationCode;
        //public String refAirlineCode;
        public String recordStatus;
        public String handledOption;
        public NameExactType name;
        public AssociatedRecord missingStation;  // StationCode & AirlineCode
        //public String missingStationCode;
        //public String missingAirlineCode;
        public BagSearchType bag;
        //public UniqueId uniqueId;
        public ItineraryBagType itinerary;
        public String status;
        public String frequentFlyerAirline;
        public String tempAddressInd;
        public InboxAddressType inboxAddress;
        public List<String> teletypeAddress;
        public String email;
        public String agentId;
        public String phoneNumber;
        public String emailAddress;
        public SearchByQOH quickOnHandOption;
        //public String searchByQoh;
    }


    public class SearchRetiredNameType{
        public String name;
    }

    //REQUEST SEARCH & RUSH SEARCH
    public class WpReqSearchRetired {
        public String recordType;
        public String searchType;
        public AssociatedRecord refStationAirline;  // StationCode & AirlineCode
        public String rDate;
        public SearchRetiredNameType name;
        public String agentId;
    }

    public class SearchByQOH {
        public String searchByQOH;
    }

    public class WpReqSearchForward{
        public String recordType;
        public String searchType;
        public RefStationAirlineType referenceStationAirLine;
        public String name;
        public MissingStation missingStation;//new
        public DateRangeType dateRange;
        public BagTag rushBagTag; //BagTagType
        public BagTag bagTag; // BagTagType
        public MissingStation rushRoute;//new
        public WrapFlights flight;//new
        public InboxAddressType inboxAddress;
        public String area;
        public List<String> teletypeAddress;//new
        public String email;
        public String agentId;
        // public String trainingIndicator;
    }
    public class MissingStation{
        public String stationCode;
        public String airlineCode;
    }
    public class WrapFlights{
        public FlightDate rushFlight; // FlightType
        public FlightDate originalFlight;
    }

     public class WpReq_ROH_forward{
        //public String airlineVendorID;
        public AssociatedRecord delayedBag;
        public OnHandBags onHandBags; // OnHandBag AssociatedRecord
        public List<String> passengerName;
        public List<String> supplimentaryText;
        //public String storageLocation;
        public String furtherInfo;
        //public List<teleTypeAddresses> teleTypeAddress;
        public String agentId;
     }
     public class OnHandBags{
        public List<OnHandBag> onHandBag;
     }
     public class OnHandBag{
        public String stationCode;
        public String airlineCode;
        public String referenceNumber;
     }


    //RESPONSE SEARCH & RUSH SEARCH
    public class WpResForward{
        public String success;
        public List<WarningType> warnings;
        public List<errorType> errors;
    }
    public class WpResSearch{
        public String success;
        public List<BagRecords> bagRecords; //BagRecordType //AssociatedRecord
        public List<WarningType> warnings;
        public List<errorType> errors;
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
        public String validityDate;
    }
    public class AddressTypeCREATED {
        public AddressLine addressLine;
        public String houseNumber;
        public String streetName;
        public String apartment;
        public String city;
        public State state;
        public String postalCode;
        public Country country;
    }
    public class AddressTypeBagCREATED {
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
        public AddressTypeBag bagAddress; //AddressType
        public String bagWeight;
        public String baggageWeight;//de inactive ia
        public String contentsGender;
        public DeliveryType delivery;
        public List<BagPhones> bagPhones; //bagPhones
        public List<BagType> damagedBags;
        public List<DelayedBag> delayedBags; //BagType
        public BagType onHandBags; //-----
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
    public class BagGroupTypeOHD{
        public AddressTypeBag bagAddress; //AddressType
        public String bagWeight;
        public String baggageWeight;//de inactive ia
        public String contentsGender;
        public DeliveryType delivery;
        public List<BagPhones> bagPhones; //bagPhones
        public List<BagType> damagedBags;
        public List<DelayedBag> delayedBags; //BagType
        public OnHandBagReq onHandBags; //-----
        public String bagLastSeen;
        public BaggageItineraryDOH bagItinerary;//BagItinerary bagItinerary;
        public String excessBaggage;
        public BagTagDestinationsType bagTagDestinations;
        public Boolean keysCollected;
        public String missingWeight;
        public String matchWindow;
        public List<String> lostContents;
        public String contentsDamageDesc;
    }
    public class OnHandBagReq{
        public ColourAndTypeType colourAndType;
        public BagTag bagTag;
        public BagTag rushTag;
        public BrandInfo bradInfo;
        public BagDelivery bagDelivery;
        public String lockCode;
        public UniqueID uniqueId;
        public BagSentToCustoms bagSentToCustoms;
        public BagSentToCustoms bagReceivedFromCustoms;
        public String storageLocation;
        public BagContents bagContents;
        public DamagedTypes damagedTypes;
        public String contentsDesc;
        public String bagDetails;
        public Remarks remarks;
        public NewRecordType associateRecord;
        public ItineraryBagOHD itinerary;
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
        public Date disposalDate;
        public String controllingStation;
        public Date tracingFinalizedDate;
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
    public class WpResOnHandBag{
        public String success;
        public List<WarningType> warnings; //WarningsType Warnings;
        public DiaryInfoType diaryInfo;
        public BagGroupTypeOHD onHandBagGroup;
        public PassengerTypeOHD passengers;
        public PartnerCodeType partnerCode;
        public String handledAirlineCopyIndicator;
        public String designatedLocator;
        public String textInfo;
        public AdditionalInfoType additionalInfo;
        public List<SmsInfo> smsInfo;
        public List<EmailInfo> emailInfo;//String emailInfo;
        public RecordHistoryType recordHistory;
        public String recordStatus;
        public List<String> errors;
    }
    //DELAYED Retrieve

//DELAYEDRetrieve REQUEST
    public class WpReq{
        public NewRecordType recordId;
        public String agentId;
        public String history;
        public String recordAreas;
        public String rDate;
        public String airlineVendorId;
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
        public List<EmailInfo> emailInfo;//String emailInfo;
        public RecordHistoryType recordHistory;
        public String recordStatus;
        public List<InternetInfo> internetInfo;
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
        public List<EmailInfo> emailInfo;//String emailInfo;
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
    //public enum enumMethods {
    //    CREATE_DELAYEDBAG,
    //    UPDATE_DELAYEDBAG,
    //    GENERATE_DELAYEDBAG,
    //    SUSPEND_DELAYEDBAG,
    //    REOPEN_DELAYEDBAG,
    //    CLOSE_DELAYEDBAG,
    //    REINSTATE_DELAYEDBAG,
    //    REASSIGN_DELAYEDBAG,

    //    CREATE_DAMAGEDBAG,
    //    GENERATE_DAMAGEDBAG,
    //    REASSIGN_DAMAGEDBAG,
    //    CLOSE_DAMAGEDBAG,
    //    MODIFY_DAMAGEDBAG,

    //    BAG_SEARCH,
    //    RUSH_BAG_SEARCH,
    //    READRECORD_DAMAGED,
    //    READRECORD_ONHAND,
    //    READRECORD_DELAYED,

    //    INACTIVE_UPDATEDAMAGEBAG,
    //    INACTIVE_UPDATEDELAYEDBAG,
    //    INACTIVE_RETRIEVEDAMAGEBAG,
    //    INACTIVE_RETRIEVEDELAYEDBAG,
    //    INACTIVE_SEARCHRETIREDBAGS,

    //    ONHAND_REQUEST,

    //    INBOX_POST,
    //    TELETYPE,
    //    INBOX_PUT,
    //    STATIONS_LIST,
    //    STATIONS_SCREENS
    //}

    final static Map<String,Id> map_RT = new Map<String,Id>();

    static{
        for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE sObjectType = 'R1_Incident__c']) {
            map_RT.put(rt.DeveloperName, rt.Id);
        }
    }

    /*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    calling several methods, depends on parameters - WORKING ON IT falta saber qué paso además del contador a las funciones
                    y borrar los callers individuales cuando éste esté probado.
    IN:
    OUT:

    History:
    <Date>                     <Author>                   <Change Description>
    10/10/2017              Alberto Puerto Collado          Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
   //@future(callout=true)
   // public static void caller_param_bag(String aux, String idNumber, String wrapper){
   //     try{
   //         //delete spaces + trim + upperCase
   //         aux = aux.trim();
   //         aux = aux.replaceAll('(\\s+)', '_');
   //         aux = aux.toUpperCase();

   //         WrapperBigBigOne_Request big = (WrapperBigBigOne_Request)JSON.deserialize(wrapper, WrapperBigBigOne_Request.class);

   //         //DELAYED
   //         if(aux.toUpperCase() == enumMethods.CREATE_DELAYEDBAG.name()){
   //             CreateDelayedBag(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.UPDATE_DELAYEDBAG.name()){
   //             UpdateDelayedBag(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.GENERATE_DELAYEDBAG.name()){
   //             GenerateSummaryReport_PIR(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.REOPEN_DELAYEDBAG.name()){
   //             ReopenDelayedBag(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.SUSPEND_DELAYEDBAG.name()){
   //             SuspendDelayedBag(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.CLOSE_DELAYEDBAG.name()){
   //             CloseDelayedBag(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.REINSTATE_DELAYEDBAG.name()){
   //             ReinstateDelayedBag(idNumber, 0, null); // null es el registro de incidencia
   //         }else if(aux.toUpperCase() == enumMethods.REASSIGN_DELAYEDBAG.name()){
   //             ReassignDelayedBag(idNumber, 0);
   //         }
   //         //DAMAGED
   //         else if(aux.toUpperCase() == enumMethods.CREATE_DAMAGEDBAG.name()){
   //             CreateDamagedBagResponse(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.GENERATE_DAMAGEDBAG.name()){
   //             GenerateDamagedBagReportResponse('',0);
   //         }else if(aux.toUpperCase() == enumMethods.REASSIGN_DAMAGEDBAG.name()){
   //             ReassignDamagedBagResponse('', 0);
   //         }else if(aux.toUpperCase() == enumMethods.CLOSE_DAMAGEDBAG.name()){
   //             CloseDamaged_CFI(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.MODIFY_DAMAGEDBAG.name()){
   //             UpdateDamagedBagResponse(0);
   //         }
   //         //SEARCH&RETRIEVE
   //         else if(aux.toUpperCase() == enumMethods.BAG_SEARCH.name()){
   //             searchBags(big.search, 0); //search_RetiredRecords_bag
   //         }else if(aux.toUpperCase() == enumMethods.RUSH_BAG_SEARCH.name()){
   //             rushBagSearch(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.READRECORD_DAMAGED.name()){
   //             ReadRecord_DPR_DDP(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.READRECORD_ONHAND.name()){
   //             //ReadRecord_OHD_DOH(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.READRECORD_DELAYED.name()){
   //             readRecord_AHL_DAH(idNumber, 0, false);
   //         }
   //         //INACTIVE
   //         else if(aux.toUpperCase() == enumMethods.INACTIVE_UPDATEDAMAGEBAG.name()){
   //             //update_Damaged_bag(0);
   //         }else if(aux.toUpperCase() == enumMethods.INACTIVE_UPDATEDELAYEDBAG.name()){
   //             //update_Delayed_bag(0);
   //         }else if(aux.toUpperCase() == enumMethods.INACTIVE_RETRIEVEDAMAGEBAG.name()){
   //             //retrieve_Damaged_bag(0);
   //         }else if(aux.toUpperCase() == enumMethods.INACTIVE_RETRIEVEDELAYEDBAG.name()){
   //             //ReadRetiredRecord_AHL_PDI(0);
   //         }else if(aux.toUpperCase() == enumMethods.INACTIVE_SEARCHRETIREDBAGS.name()){
   //             //search_RetiredRecords_bag(0);
   //         }
   //         //ONHAND
   //         else if(aux.toUpperCase() == enumMethods.ONHAND_REQUEST.name()){
   //             RequestOnhandBagResponse(0);
   //         }
   //         //STATION&COMMUNICATION
   //         else if(aux.toUpperCase() == enumMethods.INBOX_POST.name()){
   //             InboxMessageSend_PXF(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.INBOX_PUT.name()){
   //             InboxMessageRead_DXF(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.TELETYPE.name()){
   //             SendTeletypeMessage(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.STATIONS_LIST.name()){
   //             DisplayStationList(idNumber, 0);
   //         }else if(aux.toUpperCase() == enumMethods.STATIONS_SCREENS.name()){
   //             DisplayStationScreen(idNumber, 0);
   //         }
   //     }catch(Exception exc){
   //         R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.caller_param_bag', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
   //     }
   // }
    /*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    helper auxiliar para ir probando mapeos

    IN:
    OUT:

    History:
    <Date>                     <Author>                   <Change Description>
    02/10/2017              Alberto Puerto Collado          Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
    //public static R1_Incident__c helper_queryPIR(String id) {
    //    //List<R2_Baggage__c> lstBags = [SELECT id, name,R2_BAG_MSDT_Incident__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c,
    //    //                                    R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c
    //    //                                    FROM R2_Baggage__c ];
    //    //return lstBags;

    //    R1_Incident__c pir = [SELECT id, RecordTypeId, RecordType.DeveloperName, R2_INC_TXT_PIR_AR_Station_Code__c, R2_INC_TXT_PIR_AR_Airline_Code__c, R2_INC_TXT_PIR_AR_Reference_Number__c, R2_INC_TXT_PIR_Agent__c, R2_INC_DAT_PIR_Claim_Date__c, R2_INC_DAT_PIR_Cancellation_date__c, R2_INC_DAT_PIR_Search_start_date__c, R2_INC_DATH_PIR_Incidence_closed_date__c, R2_PIR_DAT_PIR_Full_reintegration_date__c, R2_INC_DAT_PIR_Last_mapping_date__c, R2_INC_DAT_PIR_Control_date__c, R2_INC_DAT_PIR_Date_back_primary_search__c, R2_INC_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c

    //                                    FROM R1_Incident__c WHERE id =:id LIMIT 1];
    //    //Schema.SObjectType.Account.getRecordTypeInfosById().get(a.recordtypeid).getname();
    //    //Schema.SObjectType.Account.getRecordTypeInfosByName().get('nombre').getRecordTypeId();
    //    return pir;
    //}
    /*----------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    mapping wrappers with fields - map_Req & mapping_Request - pruebass

    IN:
    OUT:

    History:
    <Date>                     <Author>                   <Change Description>
    25/10/2017              Alberto Puerto Collado          Initial Version
 ----------------------------------------------------------------------------------------------------------------------------------------------*/
    //public class Map_Req{
    //    //contiene todos los wrappers padre, y relleno en mapping_Request()

    //}
    //public static Map_Req mapping_Request(){
    //    Map_Req mapeoR = new Map_Req();


    //    return mapeoR;
    //}
    /* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    ********************************************************* DELAYED ***************************************************************************************************************************************************************************
    ************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    */

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call CreateDelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    18/08/2017    Ruben Pingarron Jerez     Initial version
    20/11/2017    Alberto Puerto Collado    Structural changes
    09/01/2018    Alvaro Garcia Tapia       Adapt new system from II to manage Errors,
    "        "     "                 "       now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String SuspendDelayedBag(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'delayed-bags/suspend');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return SuspendDelayedBag(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SuspendDelayedBag', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_SuspendDelayedBagWebRequest wrp = new WR_SuspendDelayedBagWebRequest();
            /*
public class WR_SuspendDelayedBagWebRequest{
        public AssociatedRecord recordReference;
        public BagElementType bag;
        public String agentId;
    }
            */
            //query de bags para mapear - bag de prueba
            //R2_Baggage__c bag = helper_queryPIR()[0];
                //*********RecordReference**********
            //AssociatedRecord recRef = new AssociatedRecord();
               // recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
                //recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
                //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c

            //wrp.recordReference = recRef;
                //*********Bag**********
            //en el txt de ejemplo DelayedBagReinstatedRequest está vacío
               //*********AgentId**********
           // wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            //String body ='{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127 ELMO AVE, POUGHKEEPSIE VA 30335"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420 HIGH STREET, DAYTON OH 45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM","seq":"1"}]},"bagPhones":{"phone":["770 850 4550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:33","status":{"outForDelivery":"123","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERS MISSING"],"contentsDamage":"CONTENTS DAMAGE"},"passenger":{"names":{"name":["OLGA"],"seq":"1"},"initials":{"initial":["OK"],"seq":"1"},"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666 PALACE BLVD, LONDON GB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"Great Britain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400 PENNSYLVANIA LN, WASHINGTON OK 30339"},"validityDate":"2017-09-10"},"permanentPhones":{"phone":["770 850 4550"],"seq":"1"},"cellPhones":{"phone":["404 431 9238"]},"temporaryPhones":{"phone":["404 431 3980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","noOfPassengers":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","date":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}]},"designatedLocator":"1234","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Free misc"},{"miscInfoText":"Free misc One"}],"furtherInfo":"further info","supplementaryInfo":[{"supplimentInfoText":"Free supp info"},{"supplimentInfoText":"Free supp info One"}],"customsInfo":"customs info","userComments":[{"commentsText":"abcgd"}]},"claim":{"claimAmount":{"amount":{"amount":"5000","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OST REMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35.45","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-09-10","notifiedDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BAB"},"lossComments":"RL COMMENTS","lossReasonCode":"91","replacementBag":"true","repairBag":"false"},"agentId":"AGENT"}';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            WR_DelayedBagWebResp resp = (WR_DelayedBagWebResp)JSON.deserialize(res.getBody(),WR_DelayedBagWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_DelayedBagWebResp resp = (WR_DelayedBagWebResp)JSON.deserialize(res.getBody(),WR_DelayedBagWebResp.class);
                System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    //String stations =  JSON.serialize(resp.stations);
                    return '1';
                   //return JSON.serialize(resp.stations);
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    ReopenDelayedBag(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                }
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SuspendDelayedBag', wrapper, 'Error en SuspendDelayedBag', 'R2_Baggage__c');
                return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SuspendDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }

    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to reinstate a DelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    18/08/2017    Ruben Pingarron Jerez     Initial version
    23/11/2017     Alvaro Garcia Tapia      modify entry params
    09/01/2018    Alvaro Garcia Tapia       Adapt new system from II to manage Errors,
    "        "     "                 "       now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String ReinstateDelayedBag(String wrapper, Integer intentos, R1_Incident__c incindent){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'delayed-bags/reinstate');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return ReinstateDelayedBag(wrapper,intentos, incindent);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReinstateDelayedBag', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_ReinstateDelayedBagWebRequest wrp = new WR_ReinstateDelayedBagWebRequest();
            // *********************************WR_ReinstateDelayedBagWebRequest****************
/*
public class WR_ReinstateDelayedBagWebRequest{
        public AssociatedRecord record;
        public BagElementType bag;
        public String agentId;
    }
*/
            //query de bags para mapear - bag de prueba
            //R2_Baggage__c bag = helper_queryPIR()[0];
                //*********RecordReference**********
            AssociatedRecord recRef = new AssociatedRecord();
               // recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
               // recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
                //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c

            wrp.recordReference = recRef;
                //*********Bag**********
            //en el txt de ejemplo DelayedBagReinstatedRequest está vacío
               //*********AgentId**********
         //f   wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            String body = wrapper;
            //String body ='{"recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "67697"},"agentId": "ABC"}';
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            System.debug(res.getStatusCode());
            WR_DelayedBagWebResp resp = (WR_DelayedBagWebResp)JSON.deserialize(res.getBody(),WR_DelayedBagWebResp.class);
            System.debug(resp);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               // WR_DelayedBagWebResp resp = (WR_DelayedBagWebResp)JSON.deserialize(res.getBody(),WR_DelayedBagWebResp.class);
                System.debug('Resp: '+ resp);

                if(resp.errors == null || resp.errors.isEmpty()){
                    System.debug('sin errores: ');
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    ReinstateDelayedBag(wrapper,intentos, incindent);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReinstateDelayedBag', wrapper, 'Error en CloseDelayedBag', 'R2_Baggage__c');
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReinstateDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to Close a DelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    18/08/2017    Ruben Pingarron Jerez     Initial version
    09/01/2018    Alvaro Garcia Tapia       Adapt new system from II to manage Errors,
    "        "     "                 "       now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String CloseDelayedBag(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags/close');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return CloseDelayedBag(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDelayedBag', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_CloseDelayed_CAH_Request wrp = new WR_CloseDelayed_CAH_Request();
                //AssociatedRecord ar =
         /*
 public class WR_CloseDelayed_CAH_Request{
        public AssociatedRecord record;
        public ClaimData claim;
        public String agentId;
    }
         */
            // *********************************WR_ReinstateDelayedBagWebRequest****************
            //query de bags para mapear - bag de prueba
           // R2_Baggage__c bag = helper_queryPIR()[0];
                //*********RecordReference**********
            //AssociatedRecord recRef = new AssociatedRecord();
              //  recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
             //   recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
                //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c

            //wrp.record = recRef;
            //    //*********Claim**********
            //ClaimData cla = new ClaimData();
            //    PassengerPayments pasPayS2 = new PassengerPayments();
            //        List<PassengerPayment> lstPasPay2 = new List<PassengerPayment>();
            //        //FALTA QUERY O SABER COMO RELLENO LA LISTA DE lstPasPay con:
            //        PassengerPayment passPaymB = new PassengerPayment();
            //            passPaymB.costType = '';
            //            Amount amPasPay2 = new Amount();
            //                //amPasPay2.amountValue = 1; //int
            //                amPasPay2.currencyCode = '';
            //                amPasPay2.decimalPlace = 2; //decimal
            //        passPaymB.amount = amPasPay2;
            //    pasPayS2.passengerPaymentsValue = lstPasPay2;
            //cla.passengerPayments = pasPayS2;
            //cla.faultStationCode = ''; // distinto de wrapper de ejemplo faultStation
            //cla.lossReasonCode = '';
               //*********AgentId**********
         //   wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            //String body = '{   "record": {      "stationCode": "MAD",      "airlineCode": "IB",      "referenceNumber": "68154"   },   "claim": {      "payments": {         "passengerPayment": [{            "costType": "A",            "amount": {               "amountValue": "2500",               "currencyCode": "GBP",               "decimalPlace": "1"}}]},"faultStation": "MAD","lossReasonCode": "11"},"agentId" :"n433081"}';

            String body = wrapper; // ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ACTIVAR
            System.debug('!!!body: ' + body);
            body = helper_fixerJson(body);
            body = body.replaceAll('"[a-zA-Z]+":\\[\\]', '');
            body = body.replaceAll('"[a-zA-Z]+":\\{\\}', '');
            //body = body.replaceAll('"[a-zA-Z]+":\\{,', '{');
            body = body.replaceAll('\\{,', '{');

            //body = body.replaceAll('"current":','"currency":');
            //body = '{"record":{"stationCode":"DUS","referenceNumber":"13713","airlineCode":"IB"},"handledAirlineCopy":"YES","claim":{"payments":{"passengerPayment":[{"costType":"A","amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"}}]},"lossReasonCode":"das","faultStation":"BCN"},"agentId":"12345"}';
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            //WR_DelayedBagWebRespRecord en lugar de WR_DelayedBagWebResp
            WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               // WR_DelayedBagWebResp resp = (WR_DelayedBagWebResp)JSON.deserialize(res.getBody(),WR_DelayedBagWebResp.class);
                System.debug('Resp: '+ resp);
            //    return resp;
            //}else {
            //    if(intentos<3 && res.getStatusCode() == 401){
            //        intentos+=1;
            //        R1_CLS_SendCustomerMDM.login();
            //        return CloseDelayedBag(wrapper,intentos);
            //    }
            //    else{
            //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDelayedBag', wrapper, 'Error en CloseDelayedBag', 'R2_Baggage__c');
            //        return null;
            //    }
            //}
            //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    CloseDelayedBag(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDelayedBag', wrapper, 'Error en CloseDelayedBag', 'R2_Baggage__c');
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call ReopenDelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>                <Description>
    18/08/2017      Ruben Pingarron Jerez       Initial version
    14/11/2017      Alberto Puerto Collado      Complete
    09/01/2018      Alvaro Garcia Tapia         Adapt new system from II to manage Errors,
    "        "      "                 "          now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String ReopenDelayedBag(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('!!!Entré en REOPENdb: ' );
            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }


            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    ReopenDelayedBag(wrapper,intentos);
                    return null;
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReopenDelayedBag', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }
            System.debug('Ha funcionado el login '+ token);
            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'delayed-bags/reopen');
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

           // WR_ReopenDelayedBagWebRequest wrp = new WR_ReopenDelayedBagWebRequest();

           // //query de bags para mapear - bag de prueba
           //// R2_Baggage__c bag = helper_queryPIR()[0];
           //     //*********RecordReference**********
           // AssociatedRecord cloRef = new AssociatedRecord();
           //     cloRef.stationCode = 'MAD';//bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
           //     cloRef.airlineCode = 'IB';//bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
           //     cloRef.referenceNumber = '67999';//bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c
           //     //cloRef.recordType = '';
           //     //cloRef.recordReference = '';
           // wrp.closedRecord = cloRef;
           // //BagDetailsType det = new BagDetailsType();
           // //det.bagTag = '';
           // //det.brandCode='';
           // //det.bagColourAndType='';
           // //det.sequence = '';
           // //List<BagDetailsType> lstDet = new List<BagDetailsType>();
           // //lstDet.add(det);
           // //BagType maleta = new BagType();

           // //    maleta.bagDetails = lstDet;
           // //wrp.bagElement = maleta;
           // //    //*********newStationAirline**********
           // NewStationAirlineType newStatAir = new NewStationAirlineType();
           // newStatAir.airlineCode = 'IB';
           // newStatAir.stationCode = 'BCN';
           // wrp.newStationAirline = newStatAir;
           //     //*********BAG**********
           // //vacíos
           //    //*********AgentId**********
           // wrp.agentId = 'Agent';//bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            //**************SERIALIZE************
            //String body = JSON.serialize(wrp);
            //String body = '{    "recordReference": {      "stationCode": "MAD",      "airlineCode": "IB",      "referenceNumber": "68154"    },    "newStationAirline":{                "stationCode": "BCN",                "airlineCode": "IB"    },    "agentId": "Agent"  } ';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            //System.debug('Return string simple para pruebas');
            //return 'Se ha reabierto el pir y se muestra por pantalla';
            HTTPResponse res;

            res = http.send(req);
            System.debug('Este es el status: ' +res.getStatusCode());

            WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
                System.debug(':::::RESSSSSP ' +resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    R1_CLS_Utilities.readRecord_WT(resp.newRecord.recordType, resp.newRecord.recordReference.stationCode, resp.newRecord.recordReference.airlineCode, resp.newRecord.recordReference.referenceNumber, 'test', 2);
                    System.debug('sin errores: ');
                    return '1';
                }
                return JSON.serialize(resp.errors);
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    ReopenDelayedBag(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReopenDelayedBag', wrapper, 'Error en ReopenDelayedBag', 'R2_Baggage__c');
                    return 'error distinto de 2XX';
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReopenDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call ReassignDelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>                    <Description>
    18/08/2017    Ruben Pingarron Jerez             Initial version
    15/11/2017    Alvaro Garcia Tapia               change method to correct funcionality
    09/01/2018    Alvaro Garcia Tapia               Adapt new system from II to manage Errors,
    "        "     "                 "               now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String ReassignDelayedBag(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;


            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }


            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags/reassign');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return ReassignDelayedBag(wrapper, intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDelayedBag', wrapper, 'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            req.setBody(wrapper);

            //WR_ReassignDelayedBagWebRequest wrp = new WR_ReassignDelayedBagWebRequest();
 /*
public class WR_ReassignDelayedBagWebRequest{
        public AssociatedRecord recordReference;
        public NewStationAirlineType newStationAirline;
        public String agentId;
    }
 */
            //query de bags para mapear - bag de prueba
           // R2_Baggage__c bag = helper_queryPIR()[0];
                //*********RecordReference**********
            //AssociatedRecord recRef = new AssociatedRecord();
           //     recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
            //    recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
                //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c
            //wrp.recordReference = recRef;
                //*********newStationAirline**********
            //NewStationAirlineType newStatAir = new NewStationAirlineType();
            //newStatAir.airlineCode = '';
            //newStatAir.stationCode = '';
            //wrp.newStationAirline = newStatAir;
                //*********BAG**********
            //vacíos
               //*********AgentId**********
        //    wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            //**************SERIALIZE************
            //String body = JSON.serialize(wrp);
            //String body = '{ "recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "67632"},"newStationAirline": {"airlineCode": "IB","stationCode": "BCN"},"agentId": "1234567"}';
            //String body = wrapper;

            System.debug(req);
            System.debug('*** request body: '+ req.getBody());

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            System.debug('*** response code -> '+res.getStatusCode());
			      System.debug('*** response body -> '+res.getBody());

            WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               // WR_DelayedBagWebRespRecord resp = (WR_DelayedBagWebRespRecord)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespRecord.class);
                System.debug('*** response wp: '+resp);
            //    return resp;
            //}else {
            //    if(intentos<3 && res.getStatusCode() == 401){
            //        intentos+=1;
            //        R1_CLS_SendCustomerMDM.login();
            //        return ReassignDelayedBag(id,intentos);
            //    }
            //    else{
            //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDelayedBag', id, 'Error en ReassignDelayedBag', 'R2_Baggage__c');
            //        return null;
            //    }
            //}

                if(resp.errors == null || resp.errors.isEmpty()){
                    R1_CLS_Utilities.readRecord_WT(resp.newRecord.recordType, resp.newRecord.recordReference.stationCode, resp.newRecord.recordReference.airlineCode, resp.newRecord.recordReference.referenceNumber, 'test', 2);
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    ReassignDelayedBag(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDelayedBag', wrapper, 'Error en Reasignar escala', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDelayedBag', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to call GenerateSummaryReport_PIR()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>            <Description>
    18/08/2017    Ruben Pingarron Jerez     Initial version
    23/11/2017    Alberto Puerto Collado    Structural changes
    09/01/2018    Alvaro Garcia Tapia       Adapt new system from II to manage Errors,
    "        "    "                    "      now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String GenerateSummaryReport_PIR(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DelayedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'delayed-bags/report');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return GenerateSummaryReport_PIR(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR', wrapper, 'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            //WR_GenerateSummaryReport_PIRWebRequest wrp = new WR_GenerateSummaryReport_PIRWebRequest();
            //query de bags para mapear - bag de prueba
            //R2_Baggage__c bag = helper_queryPIR()[0];
                //*********RecordReference**********
            //AssociatedRecord recRef = new AssociatedRecord();
        //        recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
        //        recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
                //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c
            //wrp.recordReference = recRef;
                //*********LanguageCode**********
            //vacío
               //*********AgentId**********
        //    wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            //**************SERIALIZE************
            //String body = JSON.serialize(wrp);
            //String body = '{"recordReference":{ "stationCode": "MAD","airlineCode": "IB","referenceNumber": "67999"},"agentId": "aBC"}';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            WR_DelayedBagWebRespReport resp = (WR_DelayedBagWebRespReport)JSON.deserialize(res.getBody(),WR_DelayedBagWebRespReport.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    //String stations =  JSON.serialize(resp.stations);
                   // return '1';
                   if(resp.warnings == null){
                        return JSON.serialize(resp.reportOutput) + '\\n \\n';
                    }else{
                        return JSON.serialize(resp.reportOutput) + '\\n \\n' + JSON.serialize(resp.warnings);
                    }
                   //return JSON.serialize(resp.reportOutput) + '\\n \\n' + JSON.serialize(resp.warnings);
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    GenerateSummaryReport_PIR(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR', wrapper, 'Error en ReopenDelayedBag', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateSummaryReport_PIR', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }
    /* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
        ********************************************************* DAMAGED ***************************************************************************************************************************************************************************
        ************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
    */

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    18/08/2017              Sara Torres Bermúdez                    Initial Version
    25/11/2017              Alberto Puerto Collado                  Completed: params, return... etc
    ----------------------------------------------------------------------------------------------------------------------*/
    //public static String CreateDamagedBagResponse(String wrapper,Integer contador) {
    //     try{
    //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
    //        System.debug('vamos a probar el create');
    //        string wsMethod = 'R2_DamagedBags';
    //        if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
    //            return null;
    //        }

    //        HttpRequest req = new HttpRequest();
    //        //req.setEndpoint(endPoint);
    //        //system.debug(endPoint + parametersEndPoint);
    //        req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/damaged-bags/');
    //        String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

    //        System.debug('!!!token: ' + token);

    //       if (token == null) {
    //            if(contador < 3){
    //                R1_CLS_SendCustomerMDM.login();
    //                contador += 1;
    //                return CreateDamagedBagResponse(wrapper,contador);
    //            }
    //            else{
    //                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDamagedBagResponse', wrapper, 'Error en login', 'R2_Baggage__c');
    //                return null;
    //            }
    //        }
    //        System.debug('ha funcionado el login');

    //        //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
    //        req.setHeader('Authorization', 'Bearer ' + token);
    //        req.setMethod('POST');
    //        req.setHeader('Accept', 'application/json');
    //        req.setHeader('Content-Type', 'application/json');
    //        req.setTimeout(3700);
    //        system.debug(req);


    //        req.setHeader('Content-Type', 'application/json');
    //        //sin warnings
    //        //String body = '{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"1"}]},"bagPhones":{"phone":["7708504550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-09-20T00:18:33","status":{"outForDelivery":"stringout","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-10-09"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERSMISSING"],"contentsDamage":"CONTENTSDAMAGE"},"passenger":{"names":{"name":["OLGA","KAMINSKYA"]},"initials":{"initial":["OK"]},"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666PALACEBLVD,LONDONGB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"GreatBritain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400PENNSYLVANIALN,WASHINGTONOK30339"},"validityDate":"2017-10-09"},"permanentPhones":{"phone":["7708504550"]},"cellPhones":{"phone":["4044319238"]},"temporaryPhones":{"phone":["4044313980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pNR":"YW8CD","noOfPassengers":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-02-23"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"arnk":{"originDestination":{"origin":"MAD","destination":"BCN"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Freemisc"},{"miscInfoText":"FreemiscOne"}],"furtherInfo":"furtherinfo","supplementaryInfo":[{"supplimentInfoText":"Freesuppinfo"},{"supplimentInfoText":"FreesuppinfoOne"}],"customsInfo":"customsinfo"},"claim":{"claimAmount":{"amount":{"amount":"555","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OSTREMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-10-09","notifiedDate":"2017-10-09","questionnaireDate":"2017-10-09","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BA"},"lossComments":"RLCOMMENTS","lossReasonCode":"91","replacementBag":"false","repairBag":"false"},"agentId":"AGENT"}}';
    //        //con warnings

    //        //ejemplo IA
    //        //String body = '{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"1"}]},"bagPhones":{"phone":["7708504550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-03-02T00:18:33","status":{"outForDelivery":"stringout","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-04-04"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERSMISSING"],"contentsDamage":"CONTENTSDAMAGE"},"passenger":{"names":{"name":["OLGA","KAMINSKYA"]},"initials":{"initial":["OK"]},"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666PALACEBLVD,LONDONGB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"GreatBritain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400PENNSYLVANIALN,WASHINGTONOK30339"},"validityDate":"2017-04-04"},"permanentPhones":{"phone":["7708504550"]},"cellPhones":{"phone":["4044319238"]},"temporaryPhones":{"phone":["4044313980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pNR":"YW8CD","noOfPassengers":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-04-04"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"arnk":{"originDestination":{"origin":"MAD","destination":"BCN"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-04-04"},"originDestination":{"origin":"ATL","destination":"TPA"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Freemisc"},{"miscInfoText":"FreemiscOne"}],"furtherInfo":"furtherinfo","supplementaryInfo":[{"supplimentInfoText":"Freesuppinfo"},{"supplimentInfoText":"FreesuppinfoOne"}],"customsInfo":"customsinfo"},"claim":{"claimAmount":{"amount":{"amount":"555","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OSTREMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-10-09","notifiedDate":"2017-10-09","questionnaireDate":"2017-10-09","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BA"},"lossComments":"RLCOMMENTS","lossReasonCode":"91","replacementBag":"false","repairBag":"false"},"agentId":"AGENT"}}';
    //        String body = wrapper;   // <--------------PARA DESHARDCODEAR
    //        body = helper_fixerJson(body);

    //        System.debug('Este el el body del request: '+body);
    //        req.setBody(body);

    //         //llamada
    //         Http http = new Http();

    //         HTTPResponse res;

    //         res = http.send(req);
    //         System.debug('!!!body: ' + res.getBody());
    //         System.debug('Status:  '+ res.getStatusCode());

    //         if(!System.Test.isRunningTest()) {
    //             res = http.send(req);
    //         }

    //        //obtenemos los datos WR_DelayedBagWebRespRecord
    //        WpCreateDamagedBagWebResponse resp = (WpCreateDamagedBagWebResponse)JSON.deserialize(res.getBody(),WpCreateDamagedBagWebResponse.class);
    //        if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
    //            System.debug('!!!ressssssssss: ' + res.getBody());
    //            //WpCreateDamagedBagWebResponse resp = (WpCreateDamagedBagWebResponse)JSON.deserialize(res.getBody(),WpCreateDamagedBagWebResponse.class); ->
    //            System.debug('!!!resp: ' + resp);
    //            //return resp;
    //            if(resp.errors == null || resp.errors.isEmpty()){
    //                //return '1';
    //                String registroCreadoId = JSON.serialize(resp.record);
    //                String advertenciasAlCrear = JSON.serialize(resp.warnings);
    //                String respCreado = registroCreadoId + '@splitMe@' + advertenciasAlCrear; //facilitando la vida a la visual
    //                return respCreado;
    //            }else{
    //            	return JSON.serialize(resp.errors);
    //            }
    //        }else {
    //            if(contador<3 && res.getStatusCode() == 401){
    //                contador+=1;
    //                R1_CLS_SendCustomerMDM.login();
    //                CloseDelayedBag(wrapper,contador);
    //                return null;
    //            }else{
    //                if(contador<3){
    //                    String warReturn = '';
    //                    for(ErrorType error : resp.errors){
    //                        warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
    //                    }
    //                    System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
    //                    return warReturn;
    //                }
    //                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDamagedBagResponse', wrapper, 'Error en CreateDamagedBagResponse, fallos de login', 'R2_Baggage__c');
    //                return null;
    //            }
    //        }
    //    }catch(Exception exc){
    //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CreateDamagedBagResponse', wrapper, exc.getmessage()+', '+exc.getLineNumber(), '');
    //        return null;
    //    }
    //}

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    18/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    //public static WPUpdateDamagedBagWebResponse UpdateDamagedBagResponse(Integer contador) {
    //     try{
    //        if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

    //        string wsMethod = 'R2_DamagedBags';
    //        if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
    //            return null;
    //        }

    //        HttpRequest req = new HttpRequest();
    //        //req.setEndpoint(endPoint);
    //        //system.debug(endPoint + parametersEndPoint);
    //        req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/damaged-bags/');
    //        String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

    //        System.debug('!!!token: ' + token);

    //       if (token == null) {
    //            if(contador < 3){
    //                R1_CLS_SendCustomerMDM.login();
    //                contador += 1;
    //                return UpdateDamagedBagResponse(contador);
    //            }
    //            else{
    //                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.UpdateDamagedBagResponse', '','Error en login', 'R2_Baggage__c');
    //                return null;
    //            }
    //        }

    //        //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
    //        req.setHeader('Authorization', 'Bearer ' + token);
    //        req.setMethod('PUT');
    //        req.setHeader('Accept', 'application/json');
    //        req.setHeader('Content-Type', 'application/json');
    //        req.setTimeout(3700);
    //        system.debug(req);

    //        String body = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"73145"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"","seq":"1"},"state":{"stateDesc":"Middlesex","stateCode":"MD"},"postalCode":"UPDATE","country":{"countryName":"UK","countryCode":"UK"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"1"}]},"bagPhones":[{"phone":"7708504222","seq":"1"}],"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"3","descriptor":{"mtrlElement":"D","otherElement":["H","H"]}},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"lockCode":"ULock","uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"storageLocation":"STORE","bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"SIDE","type":"05","amount":"MA"},{"location":"TOP","type":"02","amount":"MI"}]},"associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"478956"}},"seq":"1"},{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"3","descriptor":{"mtrlElement":"T","otherElement":["H","H"]}},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag03","seq":"2"}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"45","date":"2017-10-10"}}]},"excessBaggage":"UEXCESSTKT","missingWeight":"2KG","lostContents":[{"content":"TROUSERSMISSINGUPDATE","seq":"1"}],"contentsDamage":"CONTENTSUPDATEDAMAGE"},"passenger":{"name":[{"name":"KANE","seq":"1"},{"name":"BALE","seq":"2"}],"initials":[{"initial":"HA","seq":"1"},{"initial":"CH","seq":"2"}],"title":"MR","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"89,GREENLANE","seq":"1"},"state":{"stateDesc":"TEXAS","stateCode":"TX"},"postalCode":"TX56925","country":{"countryName":"GBR","countryCode":"UK"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"90,MAINAVENUE","seq":"1"},"state":{"stateDesc":"CALIFORNIA","stateCode":"CL"},"postalCode":"CF5634","country":{"countryName":"US","countryCode":"US"}},"permanentPhones":{"phone":[{"value":"9988776666","seq":"1"}]},"cellPhones":{"phone":[{"value":"1122336644","seq":"1"}]},"temporaryPhones":{"phone":[{"value":"456896523","seq":"1"}]},"emails":{"email":[{"value":"test_dummy@ib.com","seq":"1"}]},"faxes":{"fax":[{"value":"0704123456","seq":"1"}]}},"frequentFlyerID":"GH8967D","language":"TAMIL","ticketNumber":"1E23RS12345","pNR":"7PYJD","numberOfPassengers":"3","autoMessageOption":"MANUAL_SMS","passportInfo":"J140336","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-10-10"},"originDestination":{"origin":"BCN","destination":"TPA"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"55","date":"2017-10-10"},"originDestination":{"origin":"MAD","destination":"RSW"}}}],"additionalRoutes":["ABC","CEF","GHI","ZMG"]},"status":"U","pooledTktNumber":"UPOOLTKT","fareBasis":"U123","givenName":"KP"},"handledAirlineCopyIndicator":"FULL","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"UPDATEMISCL","seq":"1"}],"furtherInfo":"UPDATEFURTHER","supplementaryInfo":[{"supplimentInfoText":"UPDATESUPPL","seq":"1"}],"customsInfo":"UPDATECUSTOM","userComments":[{"commentsText":"UPDATECOMMENTS","seq":"2"}],"deliveryInfo":"UPDATEDELIVERY"},"claim":{"claimAmount":{"amount":{"amount":"6000","currencyCode":{"currencyCodeValue":"GBP"}}},"costRemarks":[{"costRemark":"OSTUPDATED","seq":"1"}],"passengerPayments":{"passengerPaymentsValue":[{"costType":"D","amount":{"amount":"40","currencyCode":{"currencyCodeValue":"INR"}}}]},"faultStationCode":"MAD","faultTerminal":"TQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"XS"},"lossComments":"UPDCOMMENTS","lossReasonCode":"90","replacementBagIndicator":"true","repairBagIndicator":"true"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordType":"DAMAGED","recordReference":{"stationCode":"ATL","airlineCode":"XS","referenceNumber":"23568"}}]},"agentId":"TEST"}';
    //         //req.setBody(JSON.serialize(WPUpdateDamagedBagWebRequest.class));
    //         req.setBody(body);
    //         System.debug('Request:' + req.getBody());
    //         Http http = new Http();

    //         HTTPResponse res;

    //         res = http.send(req);
    //         System.debug('!!!body: ' + res.getBody());

    //         if(!System.Test.isRunningTest()) {
    //             res = http.send(req);
    //         }

    //        //obtenemos los datos
    //        if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
    //            WPUpdateDamagedBagWebResponse resp = (WPUpdateDamagedBagWebResponse)JSON.deserialize(res.getBody(),WPUpdateDamagedBagWebResponse.class);
    //            System.debug('!!!resp: ' + resp);
    //            return resp;
    //        }else if (contador < 3 && res.getStatusCode() == 401) {
    //            R1_CLS_SendCustomerMDM.login();
    //            contador += 1;
    //            return UpdateDamagedBagResponse(contador);
    //        }else {
    //            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.UpdateDamagedBagResponse', '','Error en UpdateDamagedBagResponse', 'R2_Baggage__c');
    //            return null;
    //        }
    //        return null;
    //    }catch(Exception exc){
    //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.UpdateDamagedBagResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
    //        return null;
    //    }
    //}

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    18/08/2017              Sara Torres Bermúdez                    Initial Version
    04/12/2017              Alvaro Garcia Tapia                     Change method to correct funcionality
     09/01/2018             Alvaro Garcia Tapia                     Adapt new system from II to manage Errors,
    "        "              "                    "                    now several errors will be reported with status 200 and error != null
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String GenerateDamagedBagReportResponse(String wrapper, Integer intentos) {
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            string wsMethod = 'R2_DamagedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c+ '/damaged-bags/report');
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return GenerateDamagedBagReportResponse(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse', '','Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);
            String body = wrapper;
             //String body = '{   "recordReference": { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "72636"   },   "agentId": "AgentIdId"}';
             //req.setBody(JSON.serialize(WPGenerateDamagedBagReportWebRequest.class));
            req.setBody(body);
            System.debug('body antes de send:' + req.getBody());
            Http http = new Http();

            HTTPResponse res;

            res = http.send(req);
            System.debug('!!!body: ' + res.getBody());

            if(!System.Test.isRunningTest()) {
                res = http.send(req);
            }

            WPGenerateDamagedBagReportWebResponse resp = (WPGenerateDamagedBagReportWebResponse)JSON.deserialize(res.getBody(),WPGenerateDamagedBagReportWebResponse.class);

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    //String stations =  JSON.serialize(resp.stations);
                   // return '1';
                   return JSON.serialize(resp.reportOutput) + '\\n \\n' + JSON.serialize(resp.warnings);
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    GenerateDamagedBagReportResponse(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse', wrapper, 'Error en ReopenDelayedBag', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.GenerateDamagedBagReportResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    18/08/2017              Sara Torres Bermúdez                    Initial Version
    04/12/2017              Alvaro Garcia Tapia                     change method to correct funcionality
    09/01/2018              Alvaro Garcia Tapia                     Adapt new system from II to manage Errors,
    "        "              "                    "                    now several errors will be reported with status 200 and error != null
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String ReassignDamagedBagResponse(String wrapper, Integer intentos) {
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            string wsMethod = 'R2_DamagedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/damaged-bags/reassign');
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return ReassignDamagedBagResponse(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse', '','Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);
            String body = wrapper;
            //String body = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"72636"},"newStationAirline":{"stationCode":"BCN","airlineCode":"IB"},"agentId":"Agent"}';
            req.setBody(body);
             //req.setBody(JSON.serialize(WPReassignDamagedBagWebRequest.class));
            System.debug('Request:' + req.getBody());
            Http http = new Http();

            HTTPResponse res;

            res = http.send(req);
            System.debug('!!!body: ' + res.getBody());

            WPReassignDamagedBagWebResponse resp = (WPReassignDamagedBagWebResponse)JSON.deserialize(res.getBody(),WPReassignDamagedBagWebResponse.class);

            //obtenemos los datos
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
            System.debug('RESSSSSP: '+resp);
                System.debug('RESPONSE BODY: '+ res.getBody());
            //    return resp;
            //}else {
            //    if(intentos<3 && res.getStatusCode() == 401){
            //        intentos+=1;
            //        R1_CLS_SendCustomerMDM.login();
            //        return ReassignDamagedBagResponse(id,intentos);
            //    }
            //    else{
            //        R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse', id, 'Error en ReassignDelayedBag', 'R2_Baggage__c');
            //        return null;
            //    }
            //}

                if(resp.errors == null || resp.errors.isEmpty()){
                    R1_CLS_Utilities.readRecord_WT(resp.newRecord.recordType, resp.newRecord.recordReference.stationCode, resp.newRecord.recordReference.airlineCode, resp.newRecord.recordReference.referenceNumber, 'test', 2);
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    ReassignDamagedBagResponse(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse', wrapper, 'Error en Reasignar escala', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.ReassignDamagedBagResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

//@future(Callout = true)
//    public static void CallCloseDamaged_CFI(String id){
//        try{
//            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
//            CloseDamaged_CFI(id, 0);

//        }catch(Exception exc){
//            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CallCloseDelayedBag', id, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
//        }

//    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Method to Close a DelayedBag()

    IN:

    OUT:           DelayedBags

    History:

    <Date>              <Author>                        <Description>
    18/08/2017      Ruben Pingarron Jerez               Initial version
    04/12/2017      Alvaro Garcia Tapia                 change method to correct funcionality
    09/01/2018      Alvaro Garcia Tapia                 Adapt new system from II to manage Errors,
    "        "      "                    "                now several errors will be reported with status 200 and error != null
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String CloseDamaged_CFI(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DamagedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'damaged-bags/close');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return CloseDamaged_CFI(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDamaged_CFI', wrapper ,'Error en login', 'R2_Baggage__c');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            //airlinevendorId R2_INC_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c

            //query
         //   R1_Incident__c pir = helper_queryPIR(wrapper);
         //   //WRAPPER de request
            WR_CloseDamaged_CFI_Request wrp = new WR_CloseDamaged_CFI_Request();
         //     //wrp.airlineVendorId = wrp.R2_INC_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;
         //       NewRecordType wr_rt = new NewRecordType();
         //       wr_rt.recordType = pir.RecordType.DeveloperName;
         //           AssociatedRecord wr_ar = new AssociatedRecord();
         //               wr_ar.stationCode = pir.R2_INC_TXT_PIR_AR_Station_Code__c;
         //               wr_ar.airlineCode = pir.R2_INC_TXT_PIR_AR_Airline_Code__c;
         //               wr_ar.referenceNumber = pir.R2_INC_TXT_PIR_AR_Reference_Number__c;
         //       wr_rt.recordReference = wr_ar;
         ////   wrp.recordId = wr_rt;
         //   wrp.agentId = pir.R2_INC_TXT_PIR_Agent__c;
            //wrp.history = nada
            //wrp.recordAreas = nada+

            //// *********************************WR_ReinstateDelayedBagWebRequest****************
            ////query de bags para mapear - bag de prueba
            //R2_Baggage__c bag = helper_queryPIR()[0];
            //    //*********RecordReference**********
            //AssociatedRecord recRef = new AssociatedRecord();
            //    recRef.stationCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Airport_depart__c; //R1_Flight__c.R1_FLG_TXT_Airport_depart__c
            //    recRef.airlineCode = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Carrier_code__c;//R1_Flight__c.R1_FLG_TXT_Carrier_code__c
            //    //recRef.referenceNumber = bag.R2_BAG_MSDT_Incident__r.R1_INC_LOO_Case__r.R1_CAS_LOO_Flight__r.R1_FLG_TXT_Flight_number__c;//R1_Flight__c.R1_FLG_TXT_Flight_number__c

            //wrp.record = recRef;
            //    //*********Claim**********
            //ClaimData cla = new ClaimData();
            //    PassengerPayments pasPayS2 = new PassengerPayments();
            //        List<PassengerPayment> lstPasPay2 = new List<PassengerPayment>();
            //        //FALTA QUERY O SABER COMO RELLENO LA LISTA DE lstPasPay con:
            //        PassengerPayment passPaymB = new PassengerPayment();
            //            passPaymB.costType = '';
            //            Amount amPasPay2 = new Amount();
            //                amPasPay2.amountValue = 1; //int
            //                amPasPay2.currencyCode = '';
            //                amPasPay2.decimalPlace = 2; //decimal
            //        passPaymB.amount = amPasPay2;
            //    pasPayS2.passengerPaymentsValue = lstPasPay2;
            //cla.passengerPayments = pasPayS2;
            //cla.faultStationCode = ''; // distinto de wrapper de ejemplo faultStation
            //cla.lossReasonCode = '';
            //   //*********AgentId**********
            //wrp.agentId = bag.R2_BAG_MSDT_Incident__r.R2_INC_TXT_PIR_Agent__c; // R1_Incident__c.R2_INC_TXT_PIR_Agent__c

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            String body = wrapper;
            //String body = '{"recordReference":[{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"72636"}],"agentId":"AGENT"}';
            body = helper_fixerJson(body);
            //body = body.replaceAll('"current":','"currency":');
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            System.debug('STATUSSSSSSSSSScode:: '+res.getStatusCode());
             WPCloseDamaged_CFI_Response resp = (WPCloseDamaged_CFI_Response)JSON.deserialize(res.getBody(),WPCloseDamaged_CFI_Response.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('!!!resp ANTES DESERIALIZE: ' + res.getBody());

                if(resp.errors == null || resp.errors.isEmpty()){
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
                //return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    CloseDamaged_CFI(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDamaged_CFI', wrapper, 'Error en CloseDamaged_CFI', 'R2_Baggage__c');
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.CloseDamaged_CFI', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'R2_Baggage__c');
            return null;
        }
    }
/* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    ********************************************************* SEARCH AND RETRIEVE ***************************************************************************************************************************************************************************
    ************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    */
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Retrieves Delayed Bag

    IN:
    OUT:

    History:
    <Date>                     <Author>                             <Change Description>
    18/08/2017                 Ismael Yubero Moreno             Initial Version
    09/01/2018                 Alberto Puerto Collado           Adapt new system from II to manage Errors,
    "        "                 "                    "           now several errors will be reported with status 200 and success = false
    05/02/2018                 Alberto Puerto Collado           Structural changes, added wrapper param, change return type... etc
    07/03/2018                 Alberto Puerto Collado           Name fixed RetrieveOHD
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String RetrieveOHD (String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return RetrieveOHD(wrapper, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RetrieveOHD()', '', 'Error en login', 'Baggage');
                    return null;
                }
            }

            string wsMethod = 'R2_OnhandBagManager';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }


            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c; //+ 'onhand-bags/request';//forward-bags/search';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            // ************* SERIALIZE *********
            System.debug(':::wrapper ' + wrapper);
            String body = JSON.serialize(wrapper);
            System.debug(':::body ' + body);
            //body = body.replaceAll('\"','\'');
            body = body.replaceAll('\\\\','');
            body = body.replaceAll('^\"(.*)\"$', '$1');
            System.debug(':::body sin escapes' + body);
            //String body = '{    "recordType":"RUSH",   "searchType":"ADVANCED",   "referenceStationAirLine":{       "stationCode":"MAD",      "airlineCode":"IB"   },   "missingStation":{"stationCode":"MAD","airlineCode":"IB"   },   "rushBagTag":{   "tagSequence":"456789",      "licenseNumber":{"tagType":"1","issuerCode":"124"   }   },   "bagTag":{       "tagSequence":"456789",      "licenseNumber":{"tagType":"1","issuerCode":"124"      }   },   "rushRoute":{"stationCode":"MAD","airlineCode":"IB"   },"flight":{"originalFlight":{"airlineCode":"IB","flightNumber":"31","date":"2017-10-09"}   },   "inboxAddress":{ "stationCode":"MAD","airlineCode":"IB","area":"AP"},   "agentId":"Test"}';
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;
            res = http.send(req);
            System.debug('STATUS '+res.getStatusCode());

            System.debug('RESSSSSP ANTESS '+res.getBody());
            WpResForward resp = (WpResForward)JSON.deserialize(res.getBody(),WpResForward.class);
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){ 
                System.debug('RESSSSSP '+resp);
                if(resp.errors == null || resp.errors.isEmpty()){
                    System.debug('sin errores: ');
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    RetrieveOHD(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RetrieveOHD()', '', 'Error en RetrieveOHD', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RetrieveOHD()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
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
    <Date>                     <Author>                             <Change Description>
    18/08/2017                 Ismael Yubero Moreno             Initial Version
    09/01/2018                 Alberto Puerto Collado           Adapt new system from II to manage Errors,
    "        "                 "                    "           now several errors will be reported with status 200 and success = false
    05/02/2018                 Alberto Puerto Collado           Structural changes, added wrapper param, change return type... etc
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String rushBagSearch (String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return rushBagSearch(wrapper, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.rushBagSearch()', '', 'Error en login', 'Baggage');
                    return null;
                }
            }

            string wsMethod = 'R2_SearchBags'; 

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }


            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'forward-bags/search';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            // ************* SERIALIZE *********
            System.debug(':::wrapper ' + wrapper);
            String body = JSON.serialize(wrapper);
            System.debug(':::body ' + body);
            //body = body.replaceAll('\"','\'');
            body = body.replaceAll('\\\\','');
            body = body.replaceAll('^\"(.*)\"$', '$1');
            System.debug(':::body sin escapes' + body);
            //String body = '{    "recordType":"RUSH",   "searchType":"ADVANCED",   "referenceStationAirLine":{       "stationCode":"MAD",      "airlineCode":"IB"   },   "missingStation":{"stationCode":"MAD","airlineCode":"IB"   },   "rushBagTag":{   "tagSequence":"456789",      "licenseNumber":{"tagType":"1","issuerCode":"124"   }   },   "bagTag":{       "tagSequence":"456789",      "licenseNumber":{"tagType":"1","issuerCode":"124"      }   },   "rushRoute":{"stationCode":"MAD","airlineCode":"IB"   },"flight":{"originalFlight":{"airlineCode":"IB","flightNumber":"31","date":"2017-10-09"}   },   "inboxAddress":{ "stationCode":"MAD","airlineCode":"IB","area":"AP"},   "agentId":"Test"}';
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;
            res = http.send(req);
            System.debug('STATUS '+res.getStatusCode());

            System.debug('RESSSSSP ANTESS '+res.getBody());
            WpResForward resp = (WpResForward)JSON.deserialize(res.getBody(),WpResForward.class);
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){ 
                System.debug('RESSSSSP '+resp);
                if(resp.errors == null || resp.errors.isEmpty()){
                    System.debug('sin errores: ');
                    return '1';
                }
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                }
                System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    rushBagSearch(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.rushBagSearch()', '', 'Error en rushBagSearch', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.rushBagSearch()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
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
    09/01/2018                  Alberto Puerto Collado          Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    03/04/2018                  Alberto Puerto Collado      fixed fields FD and others of pirResp
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static List<R1_Incident__c> searchBags (String wrapper, Integer intentos){ //WpReqSearch      List<R1_Incident__c>
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

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

            string wsMethod = 'R2_SearchBags';

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
                if(resp.success == 'TRUE'){
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
                            if(resp.bagRecords[i].names.size() == 2){
                                pirResp.R2_INC_TXT_PIR_Last_name__c = resp.bagRecords[i].names[1]; //.name; 
                            }
                            if(resp.bagRecords[i].names.size() == 3){
                                pirResp.R2_INC_TXT_PIR_Last_name2__c = resp.bagRecords[i].names[2]; //.name;
                            }
                            
                        //}
                        //for(Integer n=0; n<resp.bagRecords[i].initials.size() ;n++){
                            //pirResp.R2_INC_TXT_PIR_Initial__c = resp.bagRecords[i].initials[0]; //.initial
                           // pirResp.R2_INC_TXT_PIR_Initial2__c = resp.bagRecords[i].initials[1].initial; //.initial
                           // pirResp.R2_INC_TXT_PIR_Initial3__c = resp.bagRecords[i].initials[2]; //.initial
                        //}

                        //List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
                        //if(resp.bagRecords[i].originalBags != null){
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
                                //if(resp.bagRecords[i].originalBags[0].flightDateOrARNK != null){
                                //    if(resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate != null){
                                        //for(Integer u=0; u<resp.delayedBagGroup.bagItinerary.flightDateOrARNK.size(); u++){//5
                                    //R2_Auxiliar_Data_Incident__c br = new R2_Auxiliar_Data_Incident__c();

                                    //br.R2_ADI_TXT_BR_Flight_number__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightNumber;
                                        //br.R2_ADI_DAT_BR_Flight_Date__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.flightDate;
                                    //br.R2_ADI_TXT_BR_Airline_Code__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.flightDate.airlinecode;
                                    //br.R2_ADI_TXT_BR_ARNK__c = resp.bagRecords[i].originalBags[0].flightDateOrARNK.arnk;
                                        //br.R2_ADI_MSDT_Incident__c = bag.Id;
                                        //listaAuxInc.add(br);
                               // }
                            //  }
                            //}
                        //}
                        //03/abril/2018 - @alberto.puerto : duplico los valores del vuelo de la maleta para pasarlos al pir y devolverlo así allí
                        if(resp.bagRecords[i].originalBags != null){
                            String pirFD = '';
                            for(Integer n = 0; n < resp.bagRecords[i].originalBags.size(); n++){
                                if(resp.bagRecords[i].originalBags[n].flightDateOrARNK != null){
                                    if(resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate != null){
                                        String vueloN = '';
                                        String fechaN = '';
                                        String codigoN = '';
                                        if(resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.flightNumber != null){
                                            vueloN = resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.flightNumber;
                                        }
                                        if(resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.flightDate != null){
                                            fechaN = resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.flightDate;
                                            fechaN = R1_CLS_Utilities.helper_DateSFtoDateString(fechaN);
                                        }
                                        if(resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.airlinecode != null){
                                            codigoN = resp.bagRecords[i].originalBags[n].flightDateOrARNK.flightDate.airlinecode;
                                        }
                                        pirFD +=  codigoN + vueloN + '/' + fechaN + '/';
                                    }
                                }      
                            }
                            pirResp.R2_INC_TXT_PIR_flight_Number__c = pirFD.removeEnd('/');
                        }
                        pirResp.R2_INC_TXT_PIR_Stop_and_Operator_MS__c =  pirResp.R2_INC_TXT_PIR_Station_Code__c + pirResp.R2_INC_TXT_PIR_Airline_Code__c;     
                        // System.debug('RES UN PIR '+pirResp);
                        listaPIRs.add(pirResp);
                    }
                     System.debug('LISTA PIRssssss '+listaPIRs);
                    return listaPIRs;
                }else{
                    return null;
                }
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


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Retrieves Delayed Bag

    IN:
    OUT:

    History:
    <Date>                     <Author>                             <Change Description>
    18/08/2017                 Ismael Yubero Moreno             Initial Version
    09/01/2018                 Alberto Puerto Collado           Adapt new system from II to manage Errors,
    "        "                 "                    "           now several errors will be reported with status 200 and success = false
                                VERIFICAR EL RESTO
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String ReadRecord_OHD_DOH (String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('ONHAND BAGS!!!');
           /* R1_Incident__c pir = helper_queryPIR(incidentId);

            //WRAPPER de request
            WpReq_ReadOnHand_DOH wrp =  new WpReq_ReadOnHand_DOH();
            //wrp.airlineVendorId = nada
                NewRecordType wr_rt = new NewRecordType();
                wr_rt.recordType = pir.RecordType.DeveloperName;
                    AssociatedRecord wr_ar = new AssociatedRecord();
                        wr_ar.stationCode = pir.R2_INC_TXT_PIR_AR_Station_Code__c;
                        wr_ar.airlineCode = pir.R2_INC_TXT_PIR_AR_Airline_Code__c;
                        wr_ar.referenceNumber = pir.R2_INC_TXT_PIR_AR_Reference_Number__c;
                wr_rt.recordReference = wr_ar;
            wrp.recordId = wr_rt;
            wrp.agentId = pir.R2_INC_TXT_PIR_Agent__c;
            //wrp.history = nada
            //wrp.recordAreas = nada
          */
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    //return ReadRecord_OHD_DOH(incidentId, intentos);
                    return ReadRecord_OHD_DOH(wrapper, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_BaggageTriggerMethods.ReadRecord_OHD_DOH()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }

            string wsMethod = 'R2_SearchBags';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }


            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/onhand-bags';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            //String body = '{"recordId": {"recordType":"ON-HAND","recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "73051"}},"agentId": "12345675"}';
            //req.setBody(body);
            wrapper = helper_fixerJson(wrapper);
            String body = wrapper;
            req.setBody(body);
            System.debug(body);



            Http http = new Http();
            HTTPResponse res;


            res = http.send(req);
            System.debug('STATUS '+res.getStatusCode());

            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                //***********TRANSFORMANDO DATETIME A SF FORMAT*********
                String bodyJson = res.getBody();
                body = helper_fixerJson(body);
                //bodyJson = bodyJson.replaceAll('(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1.000$3');
                System.debug('body CAMBIADO: '+bodyJson);
                WpResOnHandBag resp = (WpResOnHandBag)JSON.deserialize(bodyJson,WpResOnHandBag.class);
                //WpResOnHandBag resp = (WpResOnHandBag)JSON.deserialize(res.getBody(),WpResOnHandBag.class);
                System.debug('RESSSSSP '+resp);
                if(resp.success == 'TRUE'){
                    return JSON.serialize(resp);
                }
                return JSON.serialize(resp);
            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return ReadRecord_OHD_DOH(wrapper, intentos);
                        // return ReadRecord_OHD_DOH(incidentId, intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_BaggageTriggerMethods.ReadRecord_OHD_DOH()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_BaggageTriggerMethods.ReadRecord_OHD_DOH()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Retrieves Delayed Bag

    IN:     1) String wrapper: wrapper serialized from controller
            2) Integer intentos: in order to retry login (max 3)
            3) Boolean CambiarNumPIR: changes AR or not
    OUT:    ID: Id PIR or null

    History:
    <Date>                          <Author>                    <Change Description>
    18/08/2017                  Ismael Yubero Moreno            Initial Version
    15/11/2017                  Alberto Puerto Collado          Structural changes
    09/01/2018                  Alberto Puerto Collado          Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    05/02/2018                  Alberto Puerto Collado          Modify management of lstBags (insert & update + delete instead delete and insert)
    13/03/2018                  Alberto Puerto Collado          Added R2_INC_TXT_PIR_PIR_incident__c mapping in order to link PIR with EUROPASSISTANCE
    27/03/2018                  Alvaro Garcia Tapia             Added wrapper in catch
    20/04/2018                  Alberto Puerto Collado          Added IR (InternetInfo) mapping, new requirement
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static Id readRecord_AHL_DAH (String wrapper, Integer intentos, Boolean cambiarNumPIR){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('DELAYED BAGS');


            string wsMethod = 'R2_SearchBags';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    //return readRecord_AHL_DAH(incidentId, intentos);
                    return readRecord_AHL_DAH(wrapper, intentos, cambiarNumPIR);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readRecord_AHL_DAH()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }

            System.debug('*** token: ' + token);
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags';
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c); //aumentado de 3700 a 8000

            // ************* SERIALIZE *********
            //String body = JSON.serialize(wrp);
            //String body = '{    "recordId": {     "recordType": "DELAYED",      "recordReference": {        "stationCode": "MAD",        "airlineCode": "IB",        "referenceNumber": "67894"   }    },    "agentId": "1278"} ';
            //String body = '';
            wrapper = helper_fixerJson(wrapper);
            String body = wrapper;
            req.setBody(body);
            System.debug(body);
            System.debug(req);


            Http http = new Http();
            HTTPResponse res;


            res = http.send(req);
            System.debug('STATUS CODE -> '+res.getStatusCode());
            System.debug('BODY CODE -> '+res.getBody());
            String jsonString =res.getBody();



            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                System.debug('getBODYYYYYYYYYY: '+res.getBody());
                //***********TRANSFORMANDO DATETIME A SF FORMAT*********


                String bodyJson = res.getBody();
                //String bodyJson ='{"success":true,"diaryInfo":{"createDate":"2017-11-14T20:49:00Z","tracingDate":"2017-11-14T00:00:00Z","controllingStation":"HDQ"},"delayedBagGroup":{"bagWeight":"1/20","delayedBags":[{"colourAndType":{"suspended":false,"colourCode":"BK","typeCode":"22","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":false,"airlineCode":"IB","tagSequence":"570604"},"brandInfo":{"suspended":false,"brandInfo":"XXX"}}],"keysCollected":false},"passengers":{"names":[{"name":"BAILETTWIESE","seq":"1"},{"name":"ALBERTO","seq":"2"}],"initials":[{"initial":"BA","seq":"1"}],"contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"HOTEL LAND GUT H HNE DUSELDORFERSTR 253 40822 METTMAN","seq":"1"}]},"permanentPhones":[{"phone":"02113670041","seq":"1"}]},"language":"GE","ticketNumber":"N","autoMessageOption":"NO_MESSAGE","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"6650","flightDate":"2017-11-13"},"originDestination":{"origin":"LIM","destination":"MAD"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"3134","flightDate":"2017-11-14"},"originDestination":{"origin":"MAD","destination":"DUS"}}}]},"status":"N"},"claim":{"claimData":{"insuranceIndicator":false,"liabilityTagIndicator":false,"partnerCode":{"carrierCode":"01"}}},"handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL  14NOV/2049GMT AG 018133/19505 FROM WM BY IB/FROM HC Y\\n     / TX DUSLLIB","AAH  14NOV/2209GMT /IB AG 018641/19505 ELEMENTS\\n     PA01 WAITING FOR PAX INFO/"]}}';



                // String bodyJson ='{"success":"YES","diaryInfo":{"createDate":"2017-09-22T13:44:00 +0100","tracingDate":"2017-09-22T01:00:00 +0100","closeDate":"2017-09-22T13:47:00 +0100","retiredDate":"2017-09-28T01:00:00 +0100","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67852"}}],"claimInvestigationDate":"2017-09-22T01:00:00 +0100"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"bagWeight":"LHR","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"CMN:ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"2"},{"dlvInfo":"CMN:DIVINFO","seq":"2"}]},"bagPhones":[{"phone":"843853615","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":false,"colourCode":"BN","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":false,"airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"556985"},"brandInfo":{"suspended":false,"brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"}},"lockCode":"LOCK12","uniqueId":{"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":false,"delete":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":true,"missingWeight":"15","matchWindow":"1"},"passengers":{"names":[{"nameValue":"MANI","seq":"1"}],"initials":[{"initialValue":"U","seq":"1"}],"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"BZ"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"09/13/2017"},"originDestination":{"origin":"MAD","destination":"LHR"}}}],"additionalRoutes":["LHR"]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"INFOTEXT","seq":"1"}],"furtherInfo":"FURTHERINFO","supplementaryInfo":[{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"},{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"}],"customsInfo":"CMN:CUSTOMSINFO"},"claim":{"claimData":{"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}},{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}}]},"claimDate":"03/14/2017","notifiedDate":"03/14/2017","questionnaireDate":"03/14/2017","faultStationCode":"MAD","faultTerminal":"T1","missingBags":"10","partnerCode":{"carrierCode":"IB"},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"11","excessValue":{"amount":200,"currencyCodeValue":"USD"},"replacementBagIndicator":false,"repairBagIndicator":false}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL  22SEP/1244GMT AG N433081 FROM WWS WM BY IB TX MANIKAN","CAC  22SEP/1244GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED","CAH  22SEP/1247GMT /IB AG N433081 WWS RL01\n     20/FT01/XR01/DA01/SI02/LD02/CS02","RTD  28SEP/0201GMT RETIRED FROM TRACING"]},"recordStatus":"CLOSED"}';

                //String bodyJson = '{"success":"YES","diaryInfo":{"createDate":"2017-11-09T03:10:00","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"98711"}}],"controllingStation":"MAD","claimInvestigationDate":"2017-11-09T00:00:00"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"bagWeight":"10","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"BN"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"1"}]},"bagPhones":[{"phone":"84385361559440122333","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":"false","colourCode":"WT","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"556985"},"brandInfo":{"suspended":"false","brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"},"deliveredTime":"2017-09-19T00:00:00"},"lockCode":"LOCK12","uniqueId":{"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":"false","delete":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":true,"missingWeight":"3","matchWindow":"2"},"passengers":{"names":{"nameValues":[{"nameValue":"MANI","seq":"1"}]},"initials":{"initialValues":[{"initialValue":"U","seq":"1"}]},"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"CO"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"CO"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"},{"email":"CMNEMAIL@MAIL.COM","seq":"2"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"CO"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"XS","flightNumber":"413Q","flightDate":"04/12/2017"},"originDestination":{"origin":"LHR","destination":"MAA"}}},{"arnk":{"originDestination":{"origin":"MAA","destination":"MAA"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"413S","flightDate":"04/12/2017"},"originDestination":{"origin":"MAA","destination":"MAD"}}}]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"furtherInfo":"UPDATE FURTHER","supplementaryInfo":[{"supplimentInfoText":"UPDATE SUPPL","seq":"1"}],"customsInfo":"UPDATE CUSTOM"},"claim":{"claimData":{"claimAmount":{"amount":{"amount":2500,"currencyCodeValue":"GBP"}},"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}}]},"claimDate":"03/14/2017","notifiedDate":"03/14/2017","questionnaireDate":"03/14/2017","faultStationCode":"MAD","faultTerminal":"T2","insuranceIndicator":"YES","liabilityTagIndicator":"YES","missingBags":"10","partnerCode":{"carrierCode":"IB"},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"20","excessValue":{"amount":200,"currencyCodeValue":"USD"},"replacementBagIndicator":false,"repairBagIndicator":false}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL  09NOV/0310GMT AG N433081 FROM WWS WM BY IB TX ABCA9A9","CAC  09NOV/0310GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED"]},"recordStatus":"OPEN"}';

                //String bodyJson ='{"success":"YES","delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"bagWeight":"10","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"BN"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"1"}]},"bagPhones":[{"phone":"84385361559440122333","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":"false","colourCode":"WT","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"556985"},"brandInfo":{"suspended":"false","brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"},"deliveredTime":"2017-09-19T00:00:00"},"lockCode":"LOCK12","uniqueId":{"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"09/12/2017","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":"false","delete":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}]}}';

                //nuevo 13 noviembre
                //String bodyJson = '{"success":"YES","diaryInfo":{"createDate":"2017-09-22T12:44:00Z","tracingDate":"2017-09-22T00:00:00Z","closeDate":"2017-09-22T12:47:00Z","retiredDate":"2017-09-28T00:00:00Z","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67852"}}],"claimInvestigationDate":"2017-09-22T00:00:00Z"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"bagWeight":"LHR","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"CMN:ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"2"},{"dlvInfo":"CMN:DIVINFO","seq":"2"}]},"bagPhones":[{"phone":"843853615","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":"false","colourCode":"BN","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":"false","airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"556985"},"brandInfo":{"suspended":"false","brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"}},"lockCode":"LOCK12","uniqueId":{"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":"false","content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":true,"missingWeight":"15","matchWindow":"1"},"passengers":{"names":{"nameValues":[{"nameValue":"MANI","seq":"1"}]},"initials":{"initialValues":[{"initialValue":"U","seq":"1"}]},"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"BZ"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-13"},"originDestination":{"origin":"MAD","destination":"LHR"}}}],"additionalRoutes":["LHR"]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"INFOTEXT","seq":"1"}],"furtherInfo":"FURTHERINFO","supplementaryInfo":[{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"},{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"}],"customsInfo":"CMN:CUSTOMSINFO"},"claim":{"claimData":{"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}},{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}}]},"claimDate":"2017-03-14","notifiedDate":"2017-03-14","questionnaireDate":"2017-03-14","faultStationCode":"MAD","faultTerminal":"T1","missingBags":"10","partnerCode":{"carrierCode":"IB"},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"11","toiletKitsFemale":"10","excessValue":{"amount":200,"currencyCodeValue":"USD"}}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL  22SEP/1244GMT AG N433081 FROM WWS WM BY IB TX MANIKAN","CAC  22SEP/1244GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED","CAH  22SEP/1247GMT /IB AG N433081 WWS RL01\n     20/FT01/XR01/DA01/SI02/LD02/CS02","RTD  28SEP/0201GMT RETIRED FROM TRACING"]},"recordStatus":"CLOSED"}';
                //String bodyJson = '{"success":"YES","diaryInfo":{"createDate":"2017-09-22T12:44:00Z","tracingDate":"2017-09-22T00:00:00Z","closeDate":"2017-09-22T12:47:00Z","retiredDate":"2017-09-28T00:00:00Z","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67852"}}],"claimInvestigationDate":"2017-09-22T00:00:00Z"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"bagWeight":"LHR","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"CMN:ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"2"},{"dlvInfo":"CMN:DIVINFO","seq":"2"}]},"bagPhones":[{"phone":"843853615","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":"false","colourCode":"BN","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":"false","airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"556985"},"brandInfo":{"suspended":"false","brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"}},"lockCode":"LOCK12","uniqueId":{"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":"false","content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":true,"missingWeight":"15","matchWindow":"1"},"passengers":{"names":[{"nameValue":"MANI","seq":"1"}],"initials":[{"initialValue":"U","seq":"1"}],"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"BZ"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"BZ"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-13"},"originDestination":{"origin":"MAD","destination":"LHR"}}}],"additionalRoutes":["LHR"]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"INFOTEXT","seq":"1"}],"furtherInfo":"FURTHERINFO","supplementaryInfo":[{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"},{"supplimentInfoText":"CMN:SUPPLIMENTALINFOTEXT","seq":"2"}],"customsInfo":"CMN:CUSTOMSINFO"},"claim":{"claimData":{"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}},{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}}]},"claimDate":"2017-03-14","notifiedDate":"2017-03-14","questionnaireDate":"2017-03-14","faultStationCode":"MAD","faultTerminal":"T1","missingBags":"10","partnerCode":{"carrierCode":"IB"},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"11","toiletKitsFemale":"10","excessValue":{"amount":200,"currencyCodeValue":"USD"}}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":true,"recordHistory":{"history":["AHL  22SEP/1244GMT AG N433081 FROM WWS WM BY IB TX MANIKAN","CAC  22SEP/1244GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED","CAH  22SEP/1247GMT /IB AG N433081 WWS RL01\n     20/FT01/XR01/DA01/SI02/LD02/CS02","RTD  28SEP/0201GMT RETIRED FROM TRACING"]},"recordStatus":"CLOSED"}';
                //bodyJson = bodyJson.replaceAll('(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1'); //'$1.000$3'
                //ARREGLOS READ INDIOS
                //bodyJson = bodyJson.replaceAll('(\\d{4}-\\d{2}-\\d{2})(T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1'); //'$1.000$3'
                //bodyJson = bodyJson.replaceAll('"(false)"+','false');
                //bodyJson = bodyJson.replaceAll('"(true)"+','true');
                //bodyJson = bodyJson.replaceAll('\n','\\\\n');
               // bodyJson = bodyJson.replaceAll('\\\\n', '\n');

                System.debug('!!!getBODY: '+ bodyJson);
                bodyJson = helper_fixerJson(bodyJson);
                //segunda vez
                bodyJson = helper_fixerJson(bodyJson);

                //bodyJson = bodyJson.replaceAll('(\\d{2})(/)(\\d{2})(/)(\\d{4})','$5-$3-$1'); //

                ////acaba
                //bodyJson = bodyJson.replace('delete', 'deleteTemp');
                //bodyJson = bodyJson.replace('date', 'dateTemp');
                //System.debug('body CAMBIADO: '+bodyJson);

                System.debug('*** antes de deserializar');
                Wp_readDelayed_AHL_DAH resp = (Wp_readDelayed_AHL_DAH)JSON.deserialize(bodyJson,Wp_readDelayed_AHL_DAH.class);
                //Wp_readDelayed_AHL_DAH resp = (Wp_readDelayed_AHL_DAH)JSON.deserialize(res.getBody(),Wp_readDelayed_AHL_DAH.class);
                System.debug('RESSSSSP '+resp);
                System.debug('*** resp.success: ' + resp.success);
                //ADDED 09/01/2018, a partir de ahora II nos va a enviar la mayoría de errores con status 200 y success = false ...
                if(resp.success == 'TRUE'){
                    /***********************************     -> [,]?"+[a-zA-Z]+":null  replace
                    //1 success
                    //2 warnings
                    //3 Delayed Bag Record:
                    */
                    //WpReq wrapperReq = (WpReq)JSON.deserialize(wrapper,WpReq.class);
                    R1_Incident__c pirResp = new R1_Incident__c();
                    //obligamos a que todos los valores tengan su valor por defecto para que al hacer el update lo que no se rellene en el mapeo se quede con valor predeterminado
                    R1_CLS_Utilities.resetObject(pirResp, 'R1_Incident__c', false);

                    pirResp.RecordTypeId = map_RT.get('DELAYED');//Schema.sObjectType.R1_Incident__c.getRecordTypeInfosByName().get('DELAYED').getRecordTypeId();
                    //pirResp.R2_INC_TXT_PIR_Station_Code__c = wrapperReq.recordId.recordReference.stationCode;
                    //pirResp.R2_INC_TXT_PIR_Airline_Code__c = wrapperReq.recordId.recordReference.airlinecode;
                    //pirResp.R2_INC_TXT_PIR_Reference_Number__c = wrapperReq.recordId.recordReference.referenceNumber;                //query para ver si esta en sf o es insert
                    //query por CreatedDate R2_INC_DAT_PIR_Claim_Date__c
                    //          Record type demora/deterioro
                    // (AR): R2_INC_FOR_PIR_AR__c (formula q concatena stationCode,airlineCode y ReferenceNumber)

                    //lista R2_Auxiliar_Data_Incident__c
                    List<R2_Auxiliar_Data_Incident__c> listaAuxInc = new List<R2_Auxiliar_Data_Incident__c>();
                    //public List<BagType> delayedBags; - de 0 a 10 R2_Baggage__c
                    List<R2_Baggage__c> listaBags = new List<R2_Baggage__c>();
                    List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();

                //diaryInfo
                    if(resp.diaryInfo != null){ 
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
                        if(resp.diaryInfo.associateRecord != null){
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
                                    //R2_Auxiliar_Data_Incident__c xr = new R2_Auxiliar_Data_Incident__c();
                                    //xr.R2_ADI_TXT_XR_Station_Code__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.stationCode;
                                    //xr.R2_ADI_TXT_XR_Airline_Code__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.airlineCode;
                                    //xr.R2_ADI_TXT_XR_Reference_Number__c = resp.diaryInfo.crossReferenceRecord[i].recordReference.referenceNumber;
                                    //xr.R2_ADI_PKL_Type__c = 'XR';
                                    //listaAuxInc.add(xr);
                                }
                            }
                            xr = xr.removeEnd('/');
                            pirResp.R2_INC_TXT_PIR_Others_PIR_Associated_XR__c = xr;
                        }
                        //disposalDate no almacenan
                        pirResp.R2_INC_TXT_PIR_Control_office__c = resp.diaryInfo.controllingStation;
                        pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = resp.diaryInfo.tracingFinalizedDate != null ? Date.valueOf(resp.diaryInfo.tracingFinalizedDate) : null;
                        //pirResp. = resp.diaryInfo.claimInvestigationDate;
                        //pirResp. = resp.diaryInfo.inventoryReceivedDate;
                        //pirResp. = resp.diaryInfo.tracingExtendedDate;
                    }
                //baggrouptype
                    if(resp.delayedBagGroup != null){
                        if(resp.delayedBagGroup.bagAddress != null){
                             //adressLine-> lista de 2
                            if(resp.delayedBagGroup.bagAddress.addressLine != null){
                                pirResp.R2_INC_TXT_PIR_Address_in_suitcase1__c = resp.delayedBagGroup.bagAddress.addressLine[0].addressLineDesc;
                                if(resp.delayedBagGroup.bagAddress.addressLine.size() == 2){
                                    pirResp.R2_INC_TXT_PIR_Address_in_suitcase2__c = resp.delayedBagGroup.bagAddress.addressLine[1].addressLineDesc;
                                }
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

                        pirResp.R2_INC_TXT_PIR_Baggage_Weight_piece__c = resp.delayedBagGroup.bagWeight;
                        //contentsGender nada
                        //DELIVERY
                        if(resp.delayedBagGroup.delivery != null){
                            if(resp.delayedBagGroup.delivery.deliveryAddress != null){
                                //adressLine-> lista de 2
                                if(resp.delayedBagGroup.delivery.deliveryAddress.addressLine != null){
                                    pirResp.R2_INC_TXT_PIR_Delivery_address1__c = resp.delayedBagGroup.delivery.deliveryAddress.addressLine[0].addressLineDesc;
                                    if(resp.delayedBagGroup.delivery.deliveryAddress.addressLine.size() == 2){
                                        pirResp.R2_INC_TXT_PIR_Delivery_address2__c = resp.delayedBagGroup.delivery.deliveryAddress.addressLine[1].addressLineDesc;
                                    }
                                }
                            //city pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.city;
                            //State pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.state.stateDesc;
                            //State pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.state.stateCode;
                            //postalCode pirResp. = resp.delayedBagGroup.deliveryAddress.deliverypostalCode;
                            //Country pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.country.countryName;
                            //Country pirResp. = resp.delayedBagGroup.delivery.deliveryAddress.country.countryCode;
                            }
                            pirResp.R2_INC_TXT_PIR_Baggage_Weight_delivered__c = resp.delayedBagGroup.delivery.deliveryWeight;
                            if(resp.delayedBagGroup.delivery.localDeliveryInfo != null){
                                pirResp.R2_INC_TXT_PIR_Delivery_local_informatio__c = resp.delayedBagGroup.delivery.localDeliveryInfo[0].dlvInfo;
                                if(resp.delayedBagGroup.delivery.localDeliveryInfo.size() == 2){
                                    pirResp.R2_INC_TXT_PIR_Deliver_local_informatio2__c = resp.delayedBagGroup.delivery.localDeliveryInfo[1].dlvInfo;
                                }
                            }
                            //deliveryservice
                            if(resp.delayedBagGroup.delivery.deliveryService != null){
                                for(Integer i=0; i<resp.delayedBagGroup.delivery.deliveryService.size(); i++){ //10
                                    R2_Auxiliar_Data_Incident__c ds = new R2_Auxiliar_Data_Incident__c();
                                    ds.R2_ADI_ATXTL_DS_Delivery_service__c = resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc;
                                    ds.R2_ADI_PKL_Type__c = 'DS';
                                    //R2_Auxiliar_Data_Incident__c.R2_ADI_ATXTL_DS_Delivery_service__c = resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                    //pirResp.R2_INC_ATXTL_PIR_Delivery_service__c += resp.delayedBagGroup.delivery.deliveryService[i].deliveryServiceDesc + '##';
                                    listaAuxInc.add(ds);
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

                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////mapeo de maletas/////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //6 delayed bags
                         if(resp.delayedBagGroup.delayedBags != null){

                             for(Integer i=0; i<resp.delayedBagGroup.delayedBags.size(); i++){ //10
                                R2_Baggage__c bag = new R2_Baggage__c();
                                //master detail a incidencia
                                bag.R2_BAG_MSDT_Incident__c = pirResp.Id;

                                if(i == 0){
                                    bag.R2_BAG_CHK_Bag_selected__c = true;
                                }else{
                                    bag.R2_BAG_CHK_Bag_selected__c = false;
                                }

                                if(resp.delayedBagGroup.delayedBags[i].colourAndType != null){
                                    bag.R2_BAG_CHK_Colour_Type_Suspended__c = resp.delayedBagGroup.delayedBags[i].colourAndType.suspended != null ? resp.delayedBagGroup.delayedBags[i].colourAndType.suspended : false;
                                    bag.R2_BAG_PKL_Colour__c = resp.delayedBagGroup.delayedBags[i].colourAndType.colourCode;
                                    
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
                                    
                                    if (resp.delayedBagGroup.delayedBags[i].colourAndType.typeCode == '22') {
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
                                        if (resp.delayedBagGroup.delayedBags[i].colourAndType.typeCode.length() == 1) {
                                            bag.R2_BAG_PKL_Type__c = '0' + resp.delayedBagGroup.delayedBags[i].colourAndType.typeCode;
                                        }
                                        else {
                                            bag.R2_BAG_PKL_Type__c = resp.delayedBagGroup.delayedBags[i].colourAndType.typeCode;
                                        }
                                    }
                                }

                            //rellena el tiquet number de la maleta
                            if(resp.delayedBagGroup.delayedBags[i].bagTag != null){
                                bag.R2_BAG_CHK_BagTag_Suspended__c = resp.delayedBagGroup.delayedBags[i].bagTag.suspended != null ? resp.delayedBagGroup.delayedBags[i].bagTag.suspended : false;
                                String ticket = '';
                                if (resp.delayedBagGroup.delayedBags[i].bagTag.airlinecode != null && resp.delayedBagGroup.delayedBags[i].bagTag.airlinecode != '') {
                                    bag.R2_BAG_TXT_Bag_Airline_Code__c = resp.delayedBagGroup.delayedBags[i].bagTag.airlinecode;
                                    ticket = resp.delayedBagGroup.delayedBags[i].bagTag.airlinecode;
                                }
                                else if(resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber != null){
                                   bag.R2_BAG_NUM_LN_TagType__c = Integer.valueOf(resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber.tagType);
                                   bag.R2_BAG_TXT_LN_Issuer_Code__c = resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber.issuerCode;
                                   ticket = resp.delayedBagGroup.delayedBags[i].bagTag.licenseNumber.issuerCode;
                                }
                                bag.R2_BAG_TXT_TagSequence__c = resp.delayedBagGroup.delayedBags[i].bagTag.tagSequence;
                                ticket +=  resp.delayedBagGroup.delayedBags[i].bagTag.tagSequence;
                                bag.R2_BAG_TXT_Ticket_number__c = ticket;
                            }

                            if(resp.delayedBagGroup.delayedBags[i].rushTag != null){
                                bag.R2_BAG_CHK_RushTag_Suspended__c = resp.delayedBagGroup.delayedBags[i].rushTag.suspended != null ? resp.delayedBagGroup.delayedBags[i].rushTag.suspended : false;
                                if (resp.delayedBagGroup.delayedBags[i].rushTag.airlinecode != null && resp.delayedBagGroup.delayedBags[i].rushTag.airlinecode != '') {
                                    bag.R2_BAG_TXT_Rush_Airline_Code__c = resp.delayedBagGroup.delayedBags[i].rushTag.airlinecode;
                                    bag.R2_BAG_TXT_RUSH_label__c = resp.delayedBagGroup.delayedBags[i].rushTag.airlinecode;
                                }
                                else if(resp.delayedBagGroup.delayedBags[i].rushTag.licenseNumber != null){
                                   bag.R2_BAG_NUM_LN_RushTagType__c = Integer.valueOf(resp.delayedBagGroup.delayedBags[i].rushTag.licenseNumber.tagType);
                                   bag.R2_BAG_TXT_LN_Rush_Issuer_Code__c = resp.delayedBagGroup.delayedBags[i].rushTag.licenseNumber.issuerCode;
                                   bag.R2_BAG_TXT_RUSH_label__c = resp.delayedBagGroup.delayedBags[i].rushTag.licenseNumber.issuerCode;
                                }
                                bag.R2_BAG_TXT_TagSequence__c = resp.delayedBagGroup.delayedBags[i].rushTag.tagSequence;
                                bag.R2_BAG_TXT_RUSH_label__c += resp.delayedBagGroup.delayedBags[i].rushTag.tagSequence;
                            }

                            if(resp.delayedBagGroup.delayedBags[i].brandInfo != null){
                                bag.R2_BAG_TXT_Brand_Info_Suspended__c = resp.delayedBagGroup.delayedBags[i].brandInfo.suspended != null ? resp.delayedBagGroup.delayedBags[i].brandInfo.suspended : false; //pone txt pero es chk
                                bag.R2_BAG_TXT_Brand_Info__c = resp.delayedBagGroup.delayedBags[i].brandInfo.brandInfo;
                            }

                            //bagDelivery
                            if(resp.delayedBagGroup.delayedBags[i].bagDelivery != null){
                                if(resp.delayedBagGroup.delayedBags[i].bagDelivery.bagReceived != null){
                                    if (resp.delayedBagGroup.delayedBags[i].bagDelivery.bagReceived.rDate != null) {
                                        bag.R2_BAG_DAT_DateBagReceived__c = Date.ValueOf(resp.delayedBagGroup.delayedBags[i].bagDelivery.bagReceived.rDate); //bagReceivedDate; //ver replace o no de date en json de response
                                    }
                                    bag.R2_BAG_TXT_StationBagReceived__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.bagReceived.station;
                                }
                                //status
                                if(resp.delayedBagGroup.delayedBags[i].bagDelivery.status != null){
                                    bag.R2_BAG_TXT_OF__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.outForDelivery;
                                    bag.R2_BAG_TXT_OD__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.delivered;
                                    bag.R2_BAG_TXT_UP__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.status.trackingUpdate;
                                    bag.R2_BAG_TXT_UnableToDeliver__c =  resp.delayedBagGroup.delayedBags[i].bagDelivery.status.unableToDeliver;
                                }
                                bag.R2_BAG_DAT_Suitcase_delivery_date__c = resp.delayedBagGroup.delayedBags[i].bagDelivery.deliveredTime != null ? Date.valueOf(resp.delayedBagGroup.delayedBags[i].bagDelivery.deliveredTime) : null;
                            }

                            bag.R2_BAG_TXT_Lock_Code__c = resp.delayedBagGroup.delayedBags[i].lockCode;

                            if(resp.delayedBagGroup.delayedBags[i].uniqueID != null){
                                bag.R2_BAG_CHK_UniqueID_Suspended__c = resp.delayedBagGroup.delayedBags[i].uniqueID.suspended != null ? resp.delayedBagGroup.delayedBags[i].uniqueID.suspended : false;
                                bag.R2_BAG_TXT_UniqueID__c = resp.delayedBagGroup.delayedBags[i].uniqueID.uniqueID;
                            }
                            if(resp.delayedBagGroup.delayedBags[i].bagSentToCustoms != null){
                                //bag.R2_BAG_DATH_Bag_SentToCustoms__c = DateTime.valueOf(resp.delayedBagGroup.delayedBags[i].bagSentToCustoms.bagDate);
                                bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = resp.delayedBagGroup.delayedBags[i].bagSentToCustoms.timeZone;
                            }
                            if(resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms != null){
                                //bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = DateTime.valueOf(resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms.bagDate);
                                bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = resp.delayedBagGroup.delayedBags[i].bagReceivedFromCustoms.timeZone;
                            }

                            bag.R2_BAG_TXT_Storage_Location__c = resp.delayedBagGroup.delayedBags[i].storageLocation;

                            if(resp.delayedBagGroup.delayedBags[i].bagContents != null){
                                bag.R2_BAG_CHK_BagContends_Suspended__c = resp.delayedBagGroup.delayedBags[i].bagContents.suspended != null ? resp.delayedBagGroup.delayedBags[i].bagContents.suspended : false;
                            }
                            bag.R2_CB_TXT_Contents_Desc__c = resp.delayedBagGroup.delayedBags[i].contentDescription;
                            bag.R2_BAG_TXT_Aditional_damage_information__c = resp.delayedBagGroup.delayedBags[i].bagDetails;

                            if(resp.delayedBagGroup.delayedBags[i].remarks != null){
                                bag.R2_BAG_TXT_Comments__c = '';
                                for(Integer r=0; r<resp.delayedBagGroup.delayedBags[i].remarks.remark.size(); r++){
                                    bag.R2_BAG_TXT_Comments__c += resp.delayedBagGroup.delayedBags[i].remarks.remark[r] + '; ';
                                }
                            }

                            if(resp.delayedBagGroup.delayedBags[i].itinerary != null){
                                bag.R2_BAG_TXT_bagRoute__c = '';
                                bag.R2_BAG_TXT_bagNewRoute__c = '';
                                Map<String,String> vueloFechaMap = new Map<String,String>();
                                if (resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments != null) {
                                    if (resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment != null) {
                                        for(Integer j = 0; j < resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment.size(); j++){ //5
                                            //R2_Auxiliar_Data_Incident__c fd = new R2_Auxiliar_Data_Incident__c();
                                            if(resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].flightDate != null) {
                                                String vuelo = resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].flightDate.airlinecode;
                                                vuelo += resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].flightDate.flightNumber;
                                                String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].flightDate.flightDate);
                                                vueloFechaMap.put(vuelo, fecha);
                                            }
                                            bag.R2_BAG_TXT_BagFlight__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);

                                            if (resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].arnk != null) {
                                                if (resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].arnk.originDestination != null) {
                                                    if (j == 0) {
                                                        bag.R2_BAG_TXT_bagRoute__c = resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].arnk.originDestination.origin + '/';
                                                    }
                                                    bag.R2_BAG_TXT_bagRoute__c += resp.delayedBagGroup.delayedBags[i].itinerary.flightSegments.flightSegment[j].arnk.originDestination.destination + '/';
                                                }

                                            }
                                        }
                                    }
                                }
                                if (resp.delayedBagGroup.delayedBags[i].itinerary.routes != null) {
                                    for (Integer j = 0; j < resp.delayedBagGroup.delayedBags[i].itinerary.routes.size(); j++) {
                                        bag.R2_BAG_TXT_bagRoute__c += resp.delayedBagGroup.delayedBags[i].itinerary.routes[j] + '/';
                                    }
                                }
                                bag.R2_BAG_TXT_bagRoute__c = bag.R2_BAG_TXT_bagRoute__c.removeEnd('/');
                                Map<String,String> vueloFechaMapNew = new Map<String,String>();
                                if (resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments != null) {
                                    for(Integer j = 0; j < resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment.size(); j++){ //5
                                        //R2_Auxiliar_Data_Incident__c fd = new R2_Auxiliar_Data_Incident__c();
                                        if(resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].flightDate != null) {
                                            String vuelo = resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].flightDate.airlinecode;
                                            vuelo += resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].flightDate.flightNumber;
                                            String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].flightDate.flightDate);
                                            vueloFechaMapNew.put(vuelo, fecha);
                                        }
                                        bag.R2_BAG_TXT_BagNewFlight__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMapNew);

                                        if (resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].arnk != null) {
                                            if (resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].arnk.originDestination != null) {
                                                if (j == 0) {
                                                    bag.R2_BAG_TXT_bagNewRoute__c = resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].arnk.originDestination.origin + '/';
                                                }
                                                bag.R2_BAG_TXT_bagNewRoute__c += resp.delayedBagGroup.delayedBags[i].itinerary.newFlightSegments.flightSegment[j].arnk.originDestination.destination + '/';
                                            }
                                        }
                                    }
                                }
                                if (resp.delayedBagGroup.delayedBags[i].itinerary.routes != null) {
                                    for (Integer j = 0; j < resp.delayedBagGroup.delayedBags[i].itinerary.routes.size(); j++) {
                                        bag.R2_BAG_TXT_bagRoute__c += resp.delayedBagGroup.delayedBags[i].itinerary.routes[j] + '/';
                                    }
                                }
                                bag.R2_BAG_TXT_bagNewRoute__c = bag.R2_BAG_TXT_bagNewRoute__c.removeEnd('/');
                            }
                            listaBags.add(bag);
                            }
                        }

                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////Continua mapeo de PIR////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        pirResp.R2_INC_TXT_Last_Seen__c = resp.delayedBagGroup.bagLastseen;

                        //8.-baggage itinerary
                        if(resp.delayedBagGroup.bagItinerary != null){
                            Map<String,String> vueloFechaMap = new Map<String,String>();
                            if (resp.delayedBagGroup.bagItinerary.flightDateOrARNK != null) {
                                for(Integer i = 0; i < resp.delayedBagGroup.bagItinerary.flightDateOrARNK.size(); i++){ //5
                                    if(resp.delayedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate != null) {
                                        String vuelo = resp.delayedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.airlinecode;
                                        vuelo += resp.delayedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.flightNumber;
                                        String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resp.delayedBagGroup.bagItinerary.flightDateOrARNK[i].flightDate.flightDate);
                                        vueloFechaMap.put(vuelo, fecha);
                                    }
                                }
                                pirResp.R2_INC_TXT_PIR_Baggage_route__c = R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);
                            }
                        }
                        pirResp.R2_INC_TXT_Excess_Baggage__c = resp.delayedBagGroup.excessBaggage;
                        if(resp.delayedBagGroup.bagTagDestinations != null){
                            if(resp.delayedBagGroup.bagTagDestinations.station != null){
                                String destination = '';
                                for(Integer u = 0; u < resp.delayedBagGroup.bagTagDestinations.station.size(); u++){ //2
                                    destination += resp.delayedBagGroup.bagTagDestinations.station[u].stationValue + '/';
                                }
                                pirResp.R2_INC_TXT_PIR_Baggage_destination__c = destination.removeEnd('/');
                            }
                        }

                        //KeysCollected
                        pirResp.R2_INC_TXT_PIR_Weight_lost_parts__c = resp.delayedBagGroup.missingWeight;
                        if (resp.delayedBagGroup.lostContents != null) {
                            pirResp.R2_INC_TXT_PIR_Lost_content1__c = resp.delayedBagGroup.lostContents[0];
                            if (resp.delayedBagGroup.lostContents.size() ==2) {
                                pirResp.R2_INC_TXT_PIR_Lost_content2__c = resp.delayedBagGroup.lostContents[1];
                            }
                        }
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
                                    for (AddressLine addr : resp.passengers.contactInfo.permanentAddress.addressLine) {
                                        if (addr.seq == '1') {
                                            pirResp.R2_INC_TXT_PIR_Permanent_address1__c = addr.addressLineDesc;
                                        }
                                        else if (addr.seq == '2') {
                                            pirResp.R2_INC_TXT_PIR_Permanent_address2__c = addr.addressLineDesc;
                                        }
                                    }
                                    //pirResp.R2_INC_TXT_PIR_Permanent_address1__c = resp.passengers.contactInfo.permanentAddress.addressLine[0].addressLineDesc;
                                    //if(resp.passengers.contactInfo.permanentAddress.addressLine.size() == 2){
                                    //     pirResp.R2_INC_TXT_PIR_Permanent_address2__c = resp.passengers.contactInfo.permanentAddress.addressLine[1].addressLineDesc;
                                    //}
                                }
                            //city y state no se usa
                            pirResp.R2_INC_TXT_PIR_Zip_code__c = resp.passengers.contactInfo.permanentAddress.postalCode;
                            }
                            if(resp.passengers.contactInfo.temporaryAddress != null){
                                if(resp.passengers.contactInfo.temporaryAddress.addressLine != null){
                                    for (AddressLine addr : resp.passengers.contactInfo.temporaryAddress.addressLine) {
                                        if (addr.seq == '1') {
                                            pirResp.R2_INC_TXT_PIR_Temporal_address1__c = addr.addressLineDesc;
                                        }
                                        else if (addr.seq == '2') {
                                            pirResp.R2_INC_TXT_PIR_Temporal_address2__c = addr.addressLineDesc;
                                        }
                                    }
                                    //pirResp.R2_INC_TXT_PIR_Temporal_address1__c = resp.passengers.contactInfo.temporaryAddress.addressLine[0].addressLineDesc;
                                    //if(resp.passengers.contactInfo.temporaryAddress.addressLine.size() == 2){
                                    //     pirResp.R2_INC_TXT_PIR_Temporal_address2__c = resp.passengers.contactInfo.temporaryAddress.addressLine[1].addressLineDesc;
                                    //}
                                }
                                pirResp.R2_INC_TXT_PIR_Temporal_Zip_Code__c = resp.passengers.contactInfo.temporaryAddress.postalCode;
                                pirResp.R2_INC_DAT_PIR_Validity_temporal_address__c = resp.passengers.contactInfo.temporaryAddress.validityDate != null ? Date.valueOf(resp.passengers.contactInfo.temporaryAddress.validityDate) : null;
                            }
                            //city y state no se usa
                            if(resp.passengers.contactInfo.permanentPhones != null){
                                for (BagPhones phone : resp.passengers.contactInfo.permanentPhones) {
                                    if (phone.seq == '1') {
                                        pirResp.R2_INC_TLF_Landline1__c = phone.phone;
                                    }
                                    else if (phone.seq == '2') {
                                        pirResp.R2_INC_TLF_Landline2__c = phone.phone;
                                    }
                                }
                                //pirResp.R2_INC_TLF_Landline1__c = resp.passengers.contactInfo.permanentPhones[0].phone;
                                //if(resp.passengers.contactInfo.permanentPhones.size() == 2){
                                //     pirResp.R2_INC_TLF_Landline2__c = resp.passengers.contactInfo.permanentPhones[1].phone;
                                //}
                            }
                            if(resp.passengers.contactInfo.cellPhones != null){
                                for (BagPhones phone : resp.passengers.contactInfo.cellPhones) {
                                    if (phone.seq == '1') {
                                        pirResp.R2_INC_TLF_PIR_Mobile_phone_number1__c = phone.phone;
                                    }
                                    else if (phone.seq == '2') {
                                        pirResp.R2_INC_TLF_PIR_Mobile_phone_number2__c = phone.phone;
                                    }
                                }
                                //pirResp.R2_INC_TLF_PIR_Mobile_phone_number1__c = resp.passengers.contactInfo.cellPhones[0].phone;
                                //if(resp.passengers.contactInfo.cellPhones.size() == 2){
                                //     pirResp.R2_INC_TLF_PIR_Mobile_phone_number2__c = resp.passengers.contactInfo.cellPhones[1].phone;
                                //}
                            }
                            if(resp.passengers.contactInfo.temporaryPhones != null){
                                for (BagPhones phone : resp.passengers.contactInfo.temporaryPhones) {
                                    if (phone.seq == '1') {
                                        pirResp.R2_INC_TLF_PIR_Temporal_phone__c = phone.phone;
                                    }
                                    else if (phone.seq == '2') {
                                        pirResp.R2_INC_TLF_PIR_Temporal_phone2__c = phone.phone;
                                    }
                                }
                                //pirResp.R2_INC_TLF_PIR_Temporal_phone__c = resp.passengers.contactInfo.temporaryPhones[0].phone;
                                //if(resp.passengers.contactInfo.temporaryPhones.size() == 2){
                                //     pirResp.R2_INC_TLF_PIR_Temporal_phone2__c = resp.passengers.contactInfo.temporaryPhones[1].phone;
                                //}
                            }
                            if(resp.passengers.contactInfo.emails != null){
                                for (Emails email : resp.passengers.contactInfo.emails) {
                                    if (email.seq == '1') {
                                        pirResp.R2_INC_EMA_PIR_Email1__c = email.email;
                                    }
                                    else if (email.seq == '2') {
                                        pirResp.R2_INC_EMA_PIR_Email2__c = email.email;
                                    }
                                }
                                //pirResp.R2_INC_EMA_PIR_Email1__c = resp.passengers.contactInfo.emails[0].email;
                                //if(resp.passengers.contactInfo.emails.size() == 2){
                                //     pirResp.R2_INC_EMA_PIR_Email2__c = resp.passengers.contactInfo.emails[1].email;
                                //}
                            }
                        }
                        //faxes 1 y 2 nada
                        //country - state y zip mapear y no mostrar
                        //
                        pirResp.R2_INC_TXT_PIR_FF_Identificator__c = (resp.passengers.frequentFlyerId != null && resp.passengers.frequentFlyerId != '')? resp.passengers.frequentFlyerId : NO_IBERIA_PLUS;
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

                    //ADDITIONAL INFO
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

                //CLAIM - linea 332 aprox
                    //1.- claim data (CA no lo pintan) - 3 campos
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
                                            cs.R2_ADI_TXT_CS_Currency__c = resp.claim.claimData.passengerPayments.passengerPaymentsValue[i].amount.currencyCodeValue;
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
                            pirResp.R2_INC_CHK_PIR_Baggage_insurance__c = resp.claim.claimData.insuranceIndicator != null ? resp.claim.claimData.insuranceIndicator : false;
                            pirResp.R2_INC_CHK_PIR_Limited_approval_label__c = resp.claim.claimData.liabilityTagIndicator != null ? resp.claim.claimData.liabilityTagIndicator : false;
                            if (resp.claim.claimData.partnerCode != null) {
                               pirResp.R2_INC_TXT_PIR_Shared_code__c = resp.claim.claimData.partnerCode.carrierCode; //FIXME
                            }
                            pirResp.R2_INC_TXT_PIR_Lost_reason_causes__c = resp.claim.claimData.lossComments;
                            pirResp.R2_INC_TXT_PIR_Lost_reason__c = resp.claim.claimData.lossReasonCode;
                            //if (resp.claim.claimData.toilerkits != null) {
                            String kit = '';
                            if (String.valueOf(resp.claim.claimData.toiletKitsMale) != null && String.valueOf(resp.claim.claimData.toiletKitsMale) != '') {
                                kit += resp.claim.claimData.toiletKitsMale + 'M/';
                            }
                            if (String.valueOf(resp.claim.claimData.toiletKitsFemale) != null && String.valueOf(resp.claim.claimData.toiletKitsFemale) != '') {
                                kit += resp.claim.claimData.toiletKitsFemale + 'F';
                            }
                            pirResp.R2_INC_TXT_PIR_Washing_kit__c = kit.removeEnd('/');
                                //pirResp.R2_INC_NUM_Toiler_Kit_Female__c = resp.claim.claimData.toilerkits.female;
                            //}
                            //toilerkits - determinar si checkbox o no - pendiente
                            //excess value (XV) no se muestra - guardar luego
                            pirResp.R2_INC_DAT_PIR_Unsuccessful_search__c = resp.claim.claimData.tracingFinalized;
                        }
                    }
                    //F-G-H
                    pirResp.R2_INC_TXT_PIR_Designated_Locator__c = resp.designatedLocator;
                    pirResp.R2_INC_PKL_PIR_Copy_for_the_company_HC__c = resp.handledAirlineCopyIndicator;// != null ? resp.handledAirlineCopyIndicator : false;
                    //Internet Info (IR) - No en SIEBEL pero Sí nuevo requerimiento 20/abril/18 Alberto Puerto
                    //pirResp.R2_ADI_ATXTL_Internet_Info__c = 
                    if(resp.internetInfo != null){
                        for(Integer i=0; i<resp.internetInfo.size(); i++){ //10
                            R2_Auxiliar_Data_Incident__c ir = new R2_Auxiliar_Data_Incident__c();
                                ir.R2_ADI_ATXTL_Internet_Info__c = resp.internetInfo[i].internetInfoText;
                                ir.R2_ADI_NUM_seq__c = Integer.valueOf(resp.internetInfo[i].seq);
                                ir.R2_ADI_PKL_Type__c = 'IR';
                            listaAuxInc.add(ir);
                        }
                    }
                    //SMS Info (SM) - no se guarda en siebel
                    //Email Info (ER) - no se guarda en siebel
                    //recordStatus
                    pirResp.R2_INC_PKL_PIR_Status_incidence__c = resp.recordStatus;

                    //DML ACTION
                    List<R1_Incident__c> delayedExiste = new List<R1_Incident__c>();
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
                        delayedExiste = [SELECT Id FROM R1_Incident__c
                                                        WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_AR_Station_Code__c
                                                        AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_AR_Airline_Code__c
                                                        AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_AR_Reference_Number__c
                                                        AND RecordType.DeveloperName ='DELAYED'
                                                        //AND CreatedDate=:created
                                                        //AND CreatedDate=:(String)resp.diaryInfo.createDate
                                                        LIMIT 1];
                    }
                    else {
                        delayedExiste = [SELECT Id FROM R1_Incident__c
                                                        WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_Station_Code__c
                                                        AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_Airline_Code__c
                                                        AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_Reference_Number__c
                                                        AND RecordType.DeveloperName ='DELAYED'
                                                        //AND CreatedDate=:created
                                                        //AND CreatedDate=:(String)resp.diaryInfo.createDate
                                                        LIMIT 1];
                    }
                    //if(resp.diaryInfo != null && resp.diaryInfo.associateRecord != null && resp.diaryInfo.associateRecord.recordReference != null) {
                    //if(wrapReq != null && wrapReq.recordId != null && wrapReq.recordId.recordReference != null) {
                        //Datetime created = Datetime.newInstance(2017, 09, 12, 21, 20, 02);

                        //delayedExiste = [SELECT Id FROM R1_Incident__c
                        //                                WHERE R2_INC_TXT_PIR_Station_Code__c =:pirResp.R2_INC_TXT_PIR_Station_Code__c
                        //                                AND R2_INC_TXT_PIR_Airline_Code__c =:pirResp.R2_INC_TXT_PIR_Airline_Code__c
                        //                                AND R2_INC_TXT_PIR_Reference_Number__c =:pirResp.R2_INC_TXT_PIR_Reference_Number__c
                        //                                AND RecordType.DeveloperName ='DELAYED'
                        //                                //AND CreatedDate=:created
                        //                                //AND CreatedDate=:(String)resp.diaryInfo.createDate
                        //                                LIMIT 1];
                    //}

                    //13/03/18 Added R2_INC_TXT_PIR_PIR_incident__c mapping in order to link PIR with EUROPASSISTANCE 
                    pirResp.R2_INC_TXT_PIR_PIR_incident__c = pirResp.R2_INC_TXT_PIR_Station_Code__c + pirResp.R2_INC_TXT_PIR_Airline_Code__c + pirResp.R2_INC_TXT_PIR_Reference_Number__c;

                    System.debug('delayed Existe?? '+ delayedExiste);
                    List<R2_Auxiliar_Data_Incident__c> lstADIs = new List<R2_Auxiliar_Data_Incident__c>();
                    Boolean crearPago = true;
                    //update or insert
                    if(!delayedExiste.isEmpty()){
                        pirResp.Id = delayedExiste[0].Id;
                        //lista de query de objetos relacionados y borrar
                        lstADIs = [SELECT id, R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c =:delayedExiste[0].Id];
                        //List<R2_Baggage__c> lstBAGs = [SELECT id FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c =:delayedExiste[0].Id];
                        if(!lstADIs.isEmpty()){
                            delete lstADIs;
                        } 
                        //delete lstBAGs; <- 05/02/2018 ya no se borran maletas, manejado al final de este método en el update de maletas
                        if(pirResp != null){
                            update pirResp;
                        } 
                        System.debug('pirResp UPDATEADO::::::::'+pirResp);
                    }else{
                        if(pirResp != null){
                            insert pirResp;
                        }                  
                        System.debug('pirResp INSERTADO:::::::'+pirResp);
                    }
                    //fulfillment of dependent objects
                    if(!listaAuxInc.isEmpty()){
                        for(Integer i=0; i<listaAuxInc.size(); i++){
                            listaAuxInc[i].R2_ADI_MSDT_Incident__c = pirResp.Id;
                        }

                        //insert listaAuxInc;

                    }else System.debug('listaAuxInc VACIA '+listaAuxInc);

                    //crear pago vacío para poder cerrar un pir sin dar datos reales de pagos de Iberia en WT (requerimiento de cliente)
                    if(!lstADIs.isEmpty()){
                        for(Integer i = 0; i<lstADIs.size(); i++){
                            if(lstADIs[i].R2_ADI_NUM_CS_Amount__c != null
                                 && (lstADIs[i].R2_ADI_TXT_CS_Currency__c != null && lstADIs[i].R2_ADI_TXT_CS_Currency__c != '')){
                                crearPago = false;
                                break;
                            }
                        }
                        if(crearPago){
                            R2_Auxiliar_Data_Incident__c pago = new R2_Auxiliar_Data_Incident__c();
                                pago.R2_ADI_NUM_CS_Amount__c = 0;
                                pago.R2_ADI_TXT_CS_Currency__c = 'EUR';
                                pago.R2_ADI_NUM_Decimal_Place__c = 1;
                                pago.R2_ADI_PKL_CS_Cost_Type__c = 'X';
                                pago.R2_ADI_MSDT_Incident__c = pirResp.Id;
                            listaAuxInc.add(pago);
                            //insert pago;
                        }
                    }
                    if(!listaAuxInc.isEmpty()){
                        insert listaAuxInc;
                        System.debug('listaAuxInc INSERTADO'+listaAuxInc);
                    }

                    //auxiliar para guardar IDs de maletas y asociarlas a la MSDT de contenido de maletas
                    Map<String, Id> mapBagAUX = new Map<String, Id>(); 

                    if(!listaBags.isEmpty()){
                        for(Integer i=0; i<listaBags.size(); i++){
                            listaBags[i].R2_BAG_MSDT_Incident__c = pirResp.Id;

                        }
                        //insert listaBags;
                        //System.debug('listaBags INSERTADO'+listaBags);

                        if (!delayedExiste.isEmpty()) {
                            List<R2_Baggage__c> lstBAGsExist = [SELECT id, R2_BAG_TXT_Ticket_number__c,
                                            R2_BAG_TXT_ROH_SI01__c , R2_BAG_TXT_ROH_SI02__c, R2_BAG_TXT_ROH_FI__c  
                                            FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c =:delayedExiste[0].Id];

                            Map<String, Id> mapBagTN = new Map<String, Id>();
                            
                            

                            for(Integer i=0; i< lstBAGsExist.size(); i ++){
                                String numTN = lstBAGsExist[i].R2_BAG_TXT_Ticket_number__c;
                                mapBagTN.put(numTN, lstBAGsExist[i].Id);
                            }

                            System.debug(':::mapa de lstBAGsExist'+mapBagTN);
                            System.debug('lstBagUpdate delete'+listaBags); 
                            System.debug('lstBagUpdate delete'+lstBAGsExist);  

                            List<R2_Baggage__c> lstBagUpdate = new List<R2_Baggage__c>();
                            List<R2_Baggage__c> lstBagInsert = new List<R2_Baggage__c>();

                            for(Integer i=0; i<listaBags.size(); i++){
                                listaBags[i].R2_BAG_MSDT_Incident__c = pirResp.Id; 
                                R2_Baggage__c maleta = new R2_Baggage__c();

                                if(mapBagTN.containsKey(listaBags[i].R2_BAG_TXT_Ticket_number__c)){
                                    maleta.Id = mapBagTN.get(listaBags[i].R2_BAG_TXT_Ticket_number__c);
                                    maleta.R2_BAG_TXT_Ticket_number__c = listaBags[i].R2_BAG_TXT_Ticket_number__c;
                                    lstBagUpdate.add(maleta);
                                    mapBagTN.remove(listaBags[i].R2_BAG_TXT_Ticket_number__c);

                                    mapBagAUX.put(listaBags[i].R2_BAG_TXT_Ticket_number__c, maleta.Id);
                                    //lstBAGsExist.remove(i);
                                    //i--;
                                }else{

                                    lstBagInsert.add(listaBags[i]);

                                }
                            }
                            System.debug('lstBagUpdate delete'+lstBAGsExist); 
                            System.debug('lstBagUpdate ACTUALIZADO'+lstBagUpdate); 
                            System.debug('lstBagUpdate insertar'+lstBagInsert); 
                            if (mapBagTN != null) {
                                List<R2_Baggage__c>lstBagDelete = new List<R2_Baggage__c>();
                                for (String key : mapBagTN.keySet()){
                                    R2_Baggage__c maleta = new R2_Baggage__c();
                                    maleta.Id = mapBagTN.get(key);
                                    lstBagDelete.add(maleta);
                                }
                                delete lstBagDelete;
                            }

                            if(!lstBagUpdate.isEmpty()){
                                update lstBagUpdate;
                                System.debug('lstBagUpdate ACTUALIZADO'+lstBagUpdate);  

                            }
                            if(!lstBagInsert.isEmpty()){
                                insert lstBagInsert;
                                System.debug('lstBagInsert INSERTADO'+lstBagInsert); 
                                for(R2_Baggage__c maleta : lstBagInsert){
                                    mapBagAUX.put(maleta.R2_BAG_TXT_Ticket_number__c, maleta.Id);
                                }

                            }
                        }
                        else {
                            insert listaBags;
                            System.debug('listaBags INSERTADO'+listaBags);

                            for(R2_Baggage__c maleta : listaBags){
                                mapBagAUX.put(maleta.R2_BAG_TXT_Ticket_number__c, maleta.Id);
                            }
                        }
                        System.debug('listaBags meh'+listaBags);
                        //upsert listaBags;
                        //System.debug('listaBags ACTUALIZADO'+listaBags);                  


                        


                        //Reubico aquí la inserción del contenido de la maleta para agrupar los dos campos con su msdt en un ciclo
                        for(Integer i=0; i<listaBags.size(); i++){
                            if(resp.delayedBagGroup.delayedBags != null){
                                if(resp.delayedBagGroup.delayedBags[i].bagContents != null){
                                    //List<R2_Content_Baggage__c> listaContenidoB = new List<R2_Content_Baggage__c>();
                                    for(Integer o=0; o<resp.delayedBagGroup.delayedBags[i].bagContents.content.size(); o++){ //12
                                        R2_Content_Baggage__c contB = new R2_Content_Baggage__c();
                                        contB.R2_CB_TXT_Type__c = resp.delayedBagGroup.delayedBags[i].bagContents.content[o].category;
                                        contB.R2_CB_TXT_Description__c = resp.delayedBagGroup.delayedBags[i].bagContents.content[o].description;
                                        contB.R2_CB_MSDT_Baggage__c = mapBagAUX.get(listaBags[i].R2_BAG_TXT_Ticket_number__c);
                                        listaContenidoB.add(contB);

                                        
                                    }
                                }
                            }
                        }
                        if(!listaContenidoB.isEmpty()) {
                            System.debug(':::::::::::mapBagAUX '+mapBagAUX );
                            System.debug('listaContenidoB INSERTADO'+listaContenidoB);
                            insert listaContenidoB;
                        }
                    }else{System.debug('listaBags VACIA '+listaBags);}
                    //FALTA CONTENIDO MALETAS --> R2_Content_Baggage__c listaContenidoB  -> a R2_CB_MSDT_Baggage__c
    //INC-20171020-00151

       /*

        */

                    return pirResp.Id;
                   // return resp;
                }else{
                    return null;
                }
            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                       // return readRecord_AHL_DAH(incidentId, intentos);
                        return readRecord_AHL_DAH(wrapper, intentos, cambiarNumPIR);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readRecord_AHL_DAH()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readRecord_AHL_DAH()', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
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
    <Date>                          <Author>                    <Change Description>
    18/08/2017                  Ismael Yubero Moreno            Initial Version
    15/11/2017                  Alberto Puerto Collado          Structural changes
    16/01/2018                  Alvaro Garcia Tapia             Change the function to take only the history
                    VERIFICAR SU USO Y ADAPTAR ERRORES SI PROCEDE
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String readHistory (String wrapper, Integer intentos, String recordType){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('DELAYED BAGS WRAPPER');

            string wsMethod = 'R2_SearchBags';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return readHistory(wrapper, intentos, recordType);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readHistory()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }
            System.debug('!!llega');
            HttpRequest req = new HttpRequest();
            String endPoint;
            if (recordType == 'DELAYED') {
                endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/delayed-bags';
            }
            else if (recordType == 'DAMAGED') {
                endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/damaged-bags';
            }
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);

            wrapper = helper_fixerJson(wrapper);
            String body = wrapper;
            req.setBody(body);
            System.debug(body);


            Http http = new Http();
            HTTPResponse res;


            res = http.send(req);
            System.debug('STATUS CODE -> '+res.getStatusCode());
            System.debug('BODY CODE -> '+res.getBody());
            String jsonString =res.getBody();



            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203){
                System.debug('getBODYYYYYYYYYY: '+res.getBody());

                String bodyJson = res.getBody();

                System.debug('!!!getBODY: '+ bodyJson);
                bodyJson = helper_fixerJson(bodyJson);
                //segunda vez
                bodyJson = helper_fixerJson(bodyJson);

                Wp_readDelayed_AHL_DAH resp = (Wp_readDelayed_AHL_DAH)JSON.deserialize(bodyJson,Wp_readDelayed_AHL_DAH.class);
                //Wp_readDelayed_AHL_DAH resp = (Wp_readDelayed_AHL_DAH)JSON.deserialize(res.getBody(),Wp_readDelayed_AHL_DAH.class);
                System.debug('RESSSSSP '+resp);

                return JSON.serialize(resp.recordHistory);

            }else{

                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return readHistory(wrapper, intentos, recordType);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readHistory()', '', 'No se puede conectar con Intelligence Integration', 'Baggage');
                    return null;
                }
            }


        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.readHistory()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Baggage');
            return null;
        }
    }
    
    /* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
        ********************************************************* ONHAND ***************************************************************************************************************************************************************************
        ************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
    */
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:

    History:
     <Date>                     <Author>                         <Change Description>
    29/08/2017              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String RequestOnhandBagResponse(Integer contador) {
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('Aqui tambien');
            string wsMethod = 'R2_OnhandBagManager';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
            System.debug('Aqui ya no');
            // llenar el WPRequestOnHandBagWebRequest
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return RequestOnhandBagResponse(contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', 'Error en login','', '');
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

             //req.setBody(JSON.serialize(WPRequestOnHandBagWebRequest.class));
             //***************SERIALIZE************
             //
             //{  "delayedBag": {    "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "67934"  },  "onHandBags": [{       "stationCode": "BCN",    "airlineCode": "IB",    "referenceNumber": "71366"}],  "passengerName": ["AB"],  "supplementaryText": ["0"],     "agentId": "AGENT"}
             String body = '{"recordId":{"recordType":"ON-HAND","recordReference":{"stationCode": "MAD","airlineCode":"IB","referenceNumber":"73051"}},"agentId":"12345675"}';
             req.setBody(body);
             System.debug('Request:' + req.getBody());
             Http http = new Http();

             HTTPResponse res;

             res = http.send(req);
             System.debug('!!!body: ' + res.getBody());

             if(!System.Test.isRunningTest()) {
                 res = http.send(req);
             }

            //obtenemos los datos del response

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                WPRequestOnHandBagWebResponse resp = (WPRequestOnHandBagWebResponse)JSON.deserialize(res.getBody(),WPRequestOnHandBagWebResponse.class);
                System.debug('Este es el response: '+  resp);
                return JSON.serialize(resp);
            }else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return RequestOnhandBagResponse(contador);
            }else {
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', '','Error en RequestOnhandBagResponse', '');
                return null;
            }
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    public static String RequestOnhandBagResponse(String wrapper, Integer contador) {
      System.debug('RequestOnhandBagResponse');
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug(':::RequestOnhandBagResponse good');
            string wsMethod = 'R2_OnhandBagManager';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
      // llenar el WPRequestOnHandBagWebRequest
            HttpRequest req = new HttpRequest();
            //req.setEndpoint(endPoint);
            //system.debug(endPoint + parametersEndPoint);
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

            System.debug('!!!token: ' + token);

           if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return RequestOnhandBagResponse(wrapper, contador);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', 'Error en login','', '');
                    return null;
                }
            }

            //req.setHeader('Authorization', R1_CS_Endpoints__c.getInstance(wsMethod).Authorization__c);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

             //req.setBody(JSON.serialize(WPRequestOnHandBagWebRequest.class));
             //***************SERIALIZE************
             //
             //{  "delayedBag": {    "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "67934"  },  "onHandBags": [{       "stationCode": "BCN",    "airlineCode": "IB",    "referenceNumber": "71366"}],  "passengerName": ["AB"],  "supplementaryText": ["0"],     "agentId": "AGENT"}
             //String body = '{"recordId":{"recordType":"ON-HAND","recordReference":{"stationCode": "MAD","airlineCode":"IB","referenceNumber":"73051"}},"agentId":"12345675"}';
             System.debug('wrapper1: '+wrapper);
             wrapper = helper_fixerJson(wrapper);
             System.debug('wrapper2: '+wrapper);
             //String body = wrapper;
             String body = wrapper;//'{  "delayedBag": {    "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "68205"  },  "onHandBags": {    "onHandBag":[{       "stationCode": "MAD",    "airlineCode": "IB",    "referenceNumber": "72635"  }]  },  "passengerName": ["AB"],  "supplementaryText": ["0"],  "agentId": "abcd,"}';
             req.setBody(body);
             System.debug(body);
             Http http = new Http();
             system.debug(req);
             HTTPResponse res;

             res = http.send(req);
             System.debug('!!!body: ' + res.getBody());

             if(!System.Test.isRunningTest()) {
                 res = http.send(req);
             }

            //obtenemos los datos del response

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                WPRequestOnHandBagWebResponse resp = (WPRequestOnHandBagWebResponse)JSON.deserialize(res.getBody(),WPRequestOnHandBagWebResponse.class);
                System.debug('Este es el response: '+  resp);
                return JSON.serialize(resp);
            }else if (contador < 3 && res.getStatusCode() == 401) {
                R1_CLS_SendCustomerMDM.login();
                contador += 1;
                return RequestOnhandBagResponse(wrapper,contador);
            }else {
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', '','Error en RequestOnhandBagResponse', '');
                return null;
            }
      return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.RequestOnhandBagResponse', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    /* *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
    *****************************************************************************************************************************************************************************************************************************************************
        ********************************************************* STATION AND COMMUNICATION ***************************************************************************************************************************************************************************
        ************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
        *****************************************************************************************************************************************************************************************************************************************************
    */
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage Station and communication records

    IN:

    OUT:           Station and communication

    History:

    <Date>              <Author>            <Description>
    29/08/2017    Ruben Pingarron Jerez     Initial version
    20/11/2017    Alberto Puerto Collado    Structural changes
    09/01/2018                  Alberto Puerto Collado          (verified, not neccesary adapt) Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String InboxMessageSend_PXF(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'messages/inbox');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return InboxMessageSend_PXF(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageSend_PXF', wrapper ,'Error en login', 'DelayedBag');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_InboxMessageSend_PXFWebReq wrp = new WR_InboxMessageSend_PXFWebReq();

            //String body = JSON.serialize(wrp);
            //String body = '{ "agentId": "AGENT",     "destinationInboxAddress": [{               "stationCode": "MAD",                 "airlineCode": "IB",                  "area": "AA"                }],    "originStation": "MAD", "message": "MESSAGE TO BE SEND", "recordId":[{             "recordType":"DELAYED",             "recordReference":{                        "airlineCode":"IB",                        "stationCode":"MAD",                        "referenceNumber":"67801"            } }], "teletypeAddress": ["TTY05AA"] }';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            WR_MessageWebResp resp = (WR_MessageWebResp)JSON.deserialize(res.getBody(),WR_MessageWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_MessageWebResp resp = (WR_MessageWebResp)JSON.deserialize(res.getBody(),WR_MessageWebResp.class);
                System.debug('Este es el response: '+  resp);
                if(resp.errors == null || resp.errors.isEmpty()){
                    return '1';
                }
                //return null;
                String warReturn = '';
                for(ErrorType error : resp.errors){
                    if(error.code == '2031'){
                        warReturn += '+ Código de error:' + error.code + ' - ' + 'No es posible rellenar TX y DP al mismo tiempo.';
                        System.debug('::warrrning return CODE 2031 :::::::::'+warReturn); 
                    //}else if(error.code == '9999'){
                    //    warReturn += '+ Código de error:' + error.code + ' - ' + 'XF Inactive, revise la combinación STATION/AIRLINE (' + error.reason + ')';
                    //    System.debug('::warrrning return CODE 9999 :::::::::'+warReturn); 
                    //// -> código 9999 utilizado como comodín para muchas cosas... 
                    }else  if(error.code == '2046'){
                        warReturn += '+ Código de error:' + error.code + ' - ' + 'No existe el PIR indicado en copia';
                        System.debug('::warrrning return CODE 2046 :::::::::'+warReturn); 
                    }else {
                        warReturn += '+ Código de error:' + error.code + ' - ' + error.reason;// + '\\n';
                    }  
                }
                System.debug('::warrrrrrrrrning return :::::::::::'+warReturn);

                return warReturn;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    InboxMessageSend_PXF(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageSend_PXF', 'Intentos de login sobrepasados', 'Error en InboxMessageSend_PXF', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageSend_PXF', 'error en InboxMessageSend_PXF', exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
            return null;
        }
    }


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage Station and communication records

    IN:

    OUT:           Station and communication

    History:

    <Date>              <Author>            <Description>
    29/08/2017    Ruben Pingarron Jerez     Initial version
    20/11/2017    Alberto Puerto Collado    Structural changes
     09/01/2018                  Alberto Puerto Collado          (verified, not neccesary adapt) Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
   --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String InboxMessageRead_DXF(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'messages/inbox');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return InboxMessageRead_DXF(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageRead_DXF', wrapper ,'Error en login', 'DelayedBag');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_InboxMessageSend_PXFWebReq wrp = new WR_InboxMessageSend_PXFWebReq();

            //String body = JSON.serialize(wrp);
            //String body = '{            "inboxMessageSearch": {      "inboxAreaAddress": {        "stationCode": "MAD",        "airlineCode": "IB",        "areaType": "AA",        "date": "2017-10-17"      }    },    "agentId": "Test"  }}';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            //
            //res.getBody().replace('date', 'datee');
            System.debug('Este el el body: ' + res.getBody());
            String jsonString =res.getBody();

            System.debug('Este es el body ' + jsonString);
            String jsonReplacedString = jsonString.replace('date', 'dateTemp');
            System.debug('Este es el body cambiado: '+ jsonReplacedString);

            WR_ReadInboxMessageResp resp = (WR_ReadInboxMessageResp)JSON.deserialize(jsonReplacedString,WR_ReadInboxMessageResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_ReadInboxMessageResp resp = (WR_ReadInboxMessageResp)JSON.deserialize(jsonReplacedString,WR_ReadInboxMessageResp.class);
                System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    return '1';
                }
                return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    InboxMessageRead_DXF(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageRead_DXF', wrapper, 'Error en InboxMessageRead_DXF', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.InboxMessageRead_DXF', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
            return null;
        }
    }
   /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage Station and communication records

    IN:

    OUT:           Station and communication

    History:

    <Date>              <Author>            <Description>
    29/08/2017    Ruben Pingarron Jerez     Initial version
    20/11/2017    Alberto Puerto Collado    Structural changes
     09/01/2018                  Alberto Puerto Collado          (verified, not neccesary adapt) Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String SendTeletypeMessage(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            System.debug('Aqui ya llega');
            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'messages/teletype');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            
            System.debug('!!!token: ' + token);

            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return SendTeletypeMessage(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SendTeletypeMessage', wrapper ,'Error en login', 'DelayedBag');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
                        

            system.debug('*** request: '+req);

            WR_SendTeletypeMessageWebReq wrp = new WR_SendTeletypeMessageWebReq();

            //String body = JSON.serialize(wrp);
            //***********SERIALIZE************
            //String body = '{ "origin": {        "teletypeAddress": "TTY05A9",     "chargeableAirline": "IB"    },   "destinationTeletypeAddress": ["TTY05A9"],    "copyTo": {          "recordID": [        {      "recordType": "DELAYED",          "recordReference": {            "stationCode": "MAD",            "airlineCode": "IB",            "referenceNumber": "68111"          }        }      ]    },     "message": "Message",     "agentId": "AgentId"}';
            String body = wrapper;
            //System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);

            WR_MessageWebResp resp = (WR_MessageWebResp)JSON.deserialize(res.getBody(),WR_MessageWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_MessageWebResp resp = (WR_MessageWebResp)JSON.deserialize(res.getBody(),WR_MessageWebResp.class);

                //return resp;
                System.debug('Este es el response: '+  resp);
                if(resp.errors == null || resp.errors.isEmpty()){
                    //return 'Mensaje PXF correctamente enviado';
                    return '1';
                }
                //return null;
                String warReturn = '';
                    for(ErrorType error : resp.errors){
                        warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                    }
                    System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                return warReturn;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    SendTeletypeMessage(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        String warReturn = '';
                        for(ErrorType error : resp.errors){
                            warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        return warReturn;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SendTeletypeMessage', wrapper, 'Error en SendTeletypeMessage', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.SendTeletypeMessage', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage Station and communication records

    IN:

    OUT:           Station and communication

    History:

    <Date>                           <Author>                   <Description>
    29/08/2017                   Ruben Pingarron Jerez          Initial version
    16/11/2017                   Alberto Puerto Collado         Structural changes
     09/01/2018                  Alberto Puerto Collado         Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static WR_StationWebResp DisplayStationList(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'stations/list/');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return DisplayStationList(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationList', wrapper ,'Error en login', 'DelayedBag');
                    return null;
                }
            }

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_DisplayStationListWebReq wrp = new WR_DisplayStationListWebReq();

            //String body = JSON.serialize(wrp);
            //***************SERIALIZE*****************
            //String body = '{"status": "A","agentId": "agentId"}';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            System.debug('STATUS '+res.getStatusCode());
            WR_StationWebResp resp = (WR_StationWebResp)JSON.deserialize(res.getBody(),WR_StationWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //replace de Date por DateReplaced
                //WR_StationWebResp resp = (WR_StationWebResp)JSON.deserialize(res.getBody(),WR_StationWebResp.class);
                 System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    return resp;
                    //String stations =  JSON.serialize(resp.stations);
                   // return '1';
                   //return JSON.serialize(resp.stations);
                }
                return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    DisplayStationList(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        //String warReturn = '';
                        //for(ErrorType error : resp.errors){
                        //    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        //}
                        //System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        //return warReturn;
                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationList', wrapper, 'Error en DisplayStationList', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationList', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
            return null;
        }
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Class to manage Station and communication records

    IN:

    OUT:           Station and communication

    History:

    <Date>              <Author>            <Description>
    29/08/2017    Ruben Pingarron Jerez     Initial version
    16/11/2017    Alberto Puerto Collado    Structural changes
     09/01/2018                  Alberto Puerto Collado          (verified, not neccesary adapt) Adapt new system from II to manage Errors,
    "        "                  "                    "          now several errors will be reported with status 200 and success = false
    07/05/2018    Alberto Puerto Collado    Return type, now return the wrapper (instead String)
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static WR_StationWebResp DisplayStationScreen(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_StationBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'stations/screen');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            //System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return DisplayStationScreen(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationScreen', wrapper ,'Error en login', 'DelayedBag');
                    return null;
                }
            }
            System.debug('Login hecho');

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            system.debug(req);

            WR_DisplayStationScreenWebReq wrp = new WR_DisplayStationScreenWebReq();

            //String body = JSON.serialize(wrp);
            //*************SERIALIZE**************
            //String body ='{"referenceStationAirline": {        "stationCode": "MAD",        "airlineCode": "IB"        },"agentId": "Test"}';
            String body = wrapper;
            System.debug(body);
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            System.debug('STATUSSSSSSSSSSS '+res.getStatusCode());
            WR_StationWebResp resp = (WR_StationWebResp)JSON.deserialize(res.getBody(),WR_StationWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                //WR_MessageWebResp resp = (WR_MessageWebResp)JSON.deserialize(res.getBody(),WR_MessageWebResp.class);
                System.debug('RESSSSSSSSSSSSSPPPPPP '+resp);
                if(resp.errors == null || resp.errors.isEmpty()){
                    //return '1';
                    //return JSON.serialize(resp.stationConfig);
                    return resp;
                }
                return null;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    DisplayStationScreen(wrapper,intentos);
                    return null;
                }else{
                    if(intentos<3){
                        //String warReturn = '';
                        //for(ErrorType error : resp.errors){
                        //    warReturn += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        //}
                        //System.debug('warrrrrrrrrning return :::::::::::::::'+warReturn);
                        //return warReturn;
                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationScreen', wrapper, 'Error en DisplayStationScreen', 'R2_Baggage__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Bags_Management.DisplayStationScreen', wrapper, exc.getmessage()+', '+exc.getLineNumber(), 'DelayedBag');
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
        fixed = fixed.replaceAll('"rTime":','"time":');
        fixed = fixed.replaceAll('"newReplace":','"new":');
        fixed = fixed.replaceAll('"typeChange":','"change":');
        fixed = fixed.replaceAll('"delete_replace":','"delete":');
        fixed = fixed.replaceAll('"current":','"currency":');
        fixed = fixed.replaceAll('"type_z":', '"type":');
        fixed = fixed.replaceAll('(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(\\s)(((\\+|-)[0-1][0-9]{3}))','$1.000$3'); //convert date formats
        fixed = fixed.replaceAll('"+[a-zA-Z]+":null[,]?', '');//('[,]?"+[a-zA-Z]+":null', ''); //delete nulls
        fixed = fixed.replaceAll('[,]?"[a-zA-Z]+":\\[\\],}', '}'); //delete vacios [\\s]?
        fixed = fixed.replaceAll('"[a-zA-Z]+":\\[\\],', '');
        fixed = fixed.replaceAll('"[a-zA-Z]+":\\{\\},', '');
        fixed = fixed.replaceAll('(\\"[\\s]*:[\\s]*)([0-9.]+)', '$1\\"$2\\"');
        fixed = fixed.replaceAll(',}', '}');
        fixed = fixed.replaceAll('//', '/');
        return fixed;
    }
}