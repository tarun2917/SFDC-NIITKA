public with sharing class R2_CLS_WT_Wrappers_Modify_Damaged {
	
	public class WT_modify_damaged_heroku {
		public RecordReference recordReference;
		public DamagedBagGroup damagedBagGroup;
		public Passenger passenger;
		public String handledAirlineCopyIndicator;
		public String designatedLocator;
		public AdditionalInfo additionalInfo;
		public Claim claim;
		public String lzcontrolDate;
		public CrossReferenceRecords crossReferenceRecords;
		public InboxAddresses inboxAddresses; //added
		public DefinedPrompt definedPrompt; //added
		public String agentId;
	}

	public class RecordReference {
		public String stationCode;
		public String airlineCode;
		public String referenceNumber;
	}

	public class DamagedBagGroup {
		public BagAddress bagAddress;
		public String baggageWeight;
		public String contentsGender;
		public Delivery delivery;
		public List<BagPhones> bagPhones;
		public DamagedBags damagedBags;
		public BaggageItinerary baggageItinerary;
		public String excessBaggage;
		public String missingWeight;
		public List<LostContents> lostContents;
		public String contentsDamage;
	}

	public class BagAddress {
		public AddressLine addressLine;
		public State state;
		public String postalCode;
		public Country country;
	}

	public class AddressLine {
		public String addressLineDesc;
		public String seq;
	}

	public class State {
		public String stateDesc;
		public String stateCode;
	}
	public class Country {
		public String countryName;
		public String countryCode;
	}

	public class Delivery {
		public BagAddress deliveryAddress;
		public String deliveryWeight;
		public List<LocalDlvInfo> localDlvInfo;
		public List<String> deliveryService;
		public String deliveryInfo;
	}

	public class LocalDlvInfo {
		public String dlvInfo;
		public String seq;
	}

	public class BagPhones {
		public String phone;
		public String seq;
	}
	
	public class DamagedBags {
		public List<DamagedBag> damagedBag;
	}
	
	public class DamagedBag {
		public ColorTypeDesc colorTypeDesc;
		public BagTag bagTag;
		public BrandInfo brandInfo;
		public BagDelivery bagDelivery;
		public String lockCode;
		public UniqueId uniqueId;
		public BagSentToCustoms bagSentToCustoms;
		public BagSentToCustoms bagReceivedFromCustoms;
		public String storageLocation;
		public String bagDetails;
		public DamagedTypes damagedTypes;
		public AssociatedRecord associatedRecord;
		public String seq;
	}

	public class ColorTypeDesc {
		public Boolean suspended;
		public String colorCode;
		public String typeCode;
		public Descriptor descriptor;
	}

	public class Descriptor {
		public String mtrlElement;
		public List<String> otherElement;
	}

	public class BagTag {
		public Boolean suspended;
		public String tagSequence;
		public String airlineCode; //added
		public LicenseNumber licenseNumber;
	}

	public class LicenseNumber {
		public String tagType;
		public String issuerCode;
	}

	public class BrandInfo {
		public Boolean suspended;
		public String brandInfo;
	}
	
	public class BagDelivery {
		public String deliveredTime;
		public Status status;
		public BagReceived bagReceived;
	}

	public class Status {
		public String outForDelivery;
		public String delivered;
		public String unableToDeliver;
		public String trackingUpdate;
	}
	
	public class BagReceived {
		public String rDate;
		public String station;
	}

	public class UniqueId {
		public Boolean suspended;
		public String uniqueIDType;
	}
	
	public class BagSentToCustoms {
		public String bagDate;
		public String timeZone;
	}

	public class DamagedTypes {
		public List<DamagedType> damagedType;
	}
	
	public class DamagedType {
		public String location;
		public String type_Z;// in json: type
		public String amount;
	}

	public class AssociatedRecord {
		public String recordType;
		public RecordReference recordReference;
	}
	
	public class BaggageItinerary {
		public List<FlightDateOrARNK> flightDateOrARNK;
	}
	
	public class FlightDateOrARNK {
		public FlightDate flightDate;
		public String arnk; //Added
	}
	
	public class FlightDate {
		public String airlineCode;
		public String flightNumber;
		public String rDate;
	}
	
	public class LostContents {
		public String content;
		public String seq;
	}

	public class Passenger {
		public List<Names> names;
		public List<Initials> initials;
		public String title;
		public ContactInfo contactInfo;
		public String frequentFlyerID;
		public String language;
		public String ticketNumber;
		public String pnr;
		public String noOfPassengers;
		public String autoMessageOption;
		public String passportInfo;
		public Itinerary itinerary;
		public String status;
		public String pooledTktNumber;
		public String fareBasis;
		public String givenName;
	}
	
	public class Names {
		public String name;
		public String seq;
	}
	
	public class Initials {
		public String initial;
		public String seq;
	}
	
	public class ContactInfo {
		public BagAddress permanentAddress;
		public TemporaryAddress temporaryAddress;
		public PermanentPhones permanentPhones;
		public PermanentPhones cellPhones;
		public PermanentPhones temporaryPhones;
		public Emails emails;
		public Faxes faxes;
	}
	
	public class TemporaryAddress {
		public AddressLine addressLine;
		public State state;
		public String postalCode;
		public Country country;
		public String validityDate;
	}
	
	public class PermanentPhones {
		public List<Phone> phone;
	}

	public class Phone {
		public String value;
		public String seq;
	}

	public class Emails {
		public List<Phone> email;
	}
	
	public class Faxes {
		public List<Phone> fax;
	}
	
	public class Itinerary {
		public List<FlightSegmentsOrARNK> flightSegmentsOrARNK;
		public List<String> additionalRoutes;
	}

	public class FlightSegmentsOrARNK {
		public Flight flight;
		public Arnk arnk;
	}

	public class Flight {
		public FlightDate flightAndDate;
		public OriginDestination originDestination;
	}

	public class OriginDestination {
		public String origin;
		public String destination;
	}
	
	public class Arnk {
		public OriginDestination originDestination;
	}

	public class AdditionalInfo {
		public List<MiscellaneousInfo> miscellaneousInfo;
		public String furtherInfo;
		public List<SupplementaryInfo> supplementaryInfo;
		public String customsInfo;
		public List<UserComments> userComments;
		public String deliveryInfo;  //Added
		public String messageInfo;  //Added
		public String matchInfo;  //Added
	}
	
	public class MiscellaneousInfo {
		public String miscInfoText;
		public String seq; //Added
	}

	public class SupplementaryInfo {
		public String supplimentInfoText;
		public String seq;
	}
		
	public class UserComments {
		public String commentsText;
		public String seq;
	}

	public class Claim {
		public ClaimAmount claimAmount;
		public List<CostRemarks> costRemarks;
		public PassengerPayments passengerPayments; //Added
		public String claimDate;
		public String dateNotified;
		public String questionnaireDate;
		public String faultStationCode;
		public String faultTerminal;
		public Boolean insurance;
		public Boolean liabilityTag;
		public String missingBag;
		public PartnerCode partnerCode;
		public String lossComments;
		public String lossReasonCode;
		public Boolean replacementBag;
		public Boolean repairBag;
		public Amount excessValue; //Added
	}

	public class ClaimAmount {
		public String amountUnknown; //Added pone que debe estar en blanco, solo es para comprobar que esta la etiqueta
		public Amount amount;
	}

	public class Amount {
		public String amount;
		public CurrencyCode currencyCode;
	}
	
	public class CurrencyCode {
		public String currencyCodeValue;
		public String decimalPlace;
	}

	public class CostRemarks {
		public String costRemark;
		public String seq;
	}

	public class PassengerPayments { //Added
		public List<PassengerPaymentsValue> passengerPaymentsValue; 
	}

	public class PassengerPaymentsValue { //Added
		public String costType;
		public Amount amount;
	}

	public class PartnerCode {
		public String carrierCode; //Added
		public Boolean none;
	}

	public class CrossReferenceRecords {
		public List<AssociatedRecord> crossReferenceRecord;
	}

	public class InboxAddresses {   //added
		public List<InboxAddress> inboxAddress;
	}

	public class InboxAddress { //added
		public StationAirline stationAriline;
		public String area;
	}

	public class StationAirline { //added
		public String stationCode;
		public String airlineCode;
	}
	
	public class DefinedPrompt { //added
		public String rDate;
		public String text;
	}

	public class WR_DamagedBagWebResp{
        public String success;
        public List<WarningType> warnings;
        public List<ErrorType> errors;
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

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Method to call UpdateDamagedBag()

    IN:

    OUT:           DamagedBags

    History:

    <Date>              <Author>            <Description>
    21/12/2017    Alvaro Garcia Tapia     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String UpdateDamagedBag(String wrapper, Integer intentos){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String wsMethod = 'R2_DamagedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

            HttpRequest req = new HttpRequest();

            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + 'damaged-bags');

            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            System.debug('!!!token: ' + token);
            if (token == null) {
                if(intentos < 3){
                    R1_CLS_SendCustomerMDM.login();
                    intentos += 1;
                    return UpdateDamagedBag(wrapper,intentos);
                }
                else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag', '' ,'Error en login', 'R1_Incident__c');
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

            //WT_modify_delayed_heroku wrp = new WT_modify_delayed_heroku();

            //SERIALIZE
            //String body = JSON.serialize(wrp);
            // create::String body = '{"airlineVendorId":"IB","refStationAirline":{"stationCode":"MAD","stationAirline":"IB"},"tracingOption":"NON_TRACING","delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"addressLine"},"state":{"stateDesc":"ES","StateCode":"ST"},"postalCode":"BZ","country":{"countryName":"Country","countryCode":"BN"}},"bagWeight":"10","contentsGender":"M","bagDeliveryAddress":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc"},"state":{"stateDesc":"Desc","stateCode":"BN"},"city":"city","postalCode":"BZ","country":{"countryName":"Country","countryCode":"BN"}},"deliveryWeight":"20","localDlvInfo":[{"divInfo":"cmn:DivInfo","seq":"3"}],"deliveryService":["cmn:DeliveryService"],"deliveryInfo":["cmn:DeliveryInfo"]},"bagPhones":{"phone":["84385361559440122333"]},"delayedBags":[{"colorTypeDesc":{"colorCode":"WT","suspended":"false","typeCode":"5","descriptor":{"materialElement":"X","otherElement":["W","B"]}},"bagTag":{"licenseNumber":{"tagType":"2","issuerCode":"123"},"airlineCode":"IB","suspended":"false","tagSequence":"556985"},"brandInfo":{"brandInfo":"MNA","suspended":"false"},"bagDelivery":{"deliveredTime":"2017-09-19","status":{"outForDelivery":"cmn:OutForDelivery","delivered":"cmn:Delivered","unableToDeliver":"cmn:UnableToDeliver","trackingUpdate":"cmn:TrackingUpdate"},"bagReceived":{"bagReceivedDate":"2017-09-12","station":"MAD"}},"lockCode":"lock12","uniqueId":{"uniqueID":"2556-5698-4152","suspended":"false"},"bagSentToCustoms":{"bagDate":"2017-09-12","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12","timeZone":"GMT"},"storageLocation":"cmn:StorageLocation","bagContents":{"content":[{"category":"ALCOHOL","description":"cmn:Description"}],"suspended":"false"},"bagDetails":"cmn:BagDetails","contentDescription":"cmn:ContentDescription","remarks":["cmn:Remarks"],"associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"987011"}}}],"bagLastSeen":"LHR","baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"flightNumber":"3170","date":"2017-09-12","airlineCode":"IB"}}]},"excessBaggage":"ExcessBaggage","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":"true","missingWeight":"3","matchWindow":"2"},"passengers":{"names":[{"name":"mani"}],"initials":[{"initial":"U"}],"title":"cmn:Title","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"state":{"stateDesc":"ES","StateCode":"ST"},"country":{"countryName":"Country","countryCode":"CO"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"ddressLineDesc"},"state":{"stateDesc":"ES","StateCode":"ST"},"country":{"countryName":"Country","countryCode":"CO"}},"permanentPhones":[{"phone":"1234567890"}],"cellPhones":[{"phone":"1234567890"}],"temporaryPhones":[{"phone":"1234567890"}],"emails":[{"email":"cmnEmail@mail.com"}],"faxes":[{"fax":"cmn:Fax"}]},"frequentFlyerId":"XS123345678","language":"English","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"MANUAL","passportInfo":"cmn:PassportInfo","itinerary":{"flightSegmentsorARNK":[{"flight":{"flightandDate":{"flightNumber":"3170","date":"2017-09-13","airlineCode":"IB"},"originDestination":{"origin":"MAD","destination":"LHR"}}}]},"status":"cmn:Status","pooledTicketNumber":"TicketNumber","fareBasis":"Basis"},"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"98711"}}],"handledAirlineCopyIndicator":"YES","designatedLocator":"AMDI","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"UPDATEMISCL","seq":"1"}],"furtherInfo":"UPDATEFURTHER","supplementaryInfo":[{"supplimentInfoText":"UPDATESUPPL","seq":"1"}],"customsInfo":"UPDATECUSTOM","userComments":[{"commentsText":"UPDATECOMMENTS","seq":"2"}]},"claim":{"claimData":{"claimAmount":{"amountUnknown":null,"amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"2"}},"costRemarks":["cmn:CostRemarks"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amountValue":"2500","currencyCode":"GBP","decimalPlace":"1"}}]},"claimDate":"2017-03-14","notifiedDate":"2017-03-14","questionnaireDate":"2017-03-14","faultStationCode":"MAD","faultTerminal":"T2","insurance":"YES","liabilityTag":"YES","missingBags":"10","partnerCode":{"carrierCode":"IB"},"lossComments":"cmn:LossComments","lossReasonCode":"20","toiletKits":{"toiletKitsFemale":"2"},"excessValue":{"amountValue":"200","currencyCode":"USD","decimalPlace":"1"}}},"teletypeAddresses":["MANIKAN"],"agentId":"n433081"}';
			//String body = '{"recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "68155"},"delayedBagGroup": {  "bagAddress" : {"addressLine":{"addressLineDesc":"","seq":"1"},"state" : {"stateCode" : "ATL"},"postalCode":"A","country" : {"countryName" : "UnitedKingdom","countryCode" : "UK"}  },  "baggageWeight": "54",  "contentsGender" : "M",  "delivery": {"deliveryAddress":{"addressLine":{"addressLineDesc":"","seq":"1"},"state" : {"stateCode" : "ATL"},"postalCode":"A","country" : {"countryName" : "UnitedKingdom","countryCode" : "UK"}},"deliveryWeight": "54","localDlvInfo": [{"dlvInfo": "DELIVER DURING THE AFTERNOONNNN","seq": "1"}],"deliveryService" : [{"deliveryServiceDesc" : "deliveryService","seq" : "1"},{"deliveryServiceDesc" : "deliveryService2","seq" : "2"}]},"bagPhones": [{"phone": "8805983508","seq": "1"},  {"phone": "98745723","seq": "2"}  ], "bagLastseen": "LHR","baggageItinerary": {"flightDateOrARNK": [{"flightDate": { "date":"2017-09-25","flightNumber": "3170","airlineCode": "IB"}}]},"excessBaggage": "ExcessBaggage","bagTagDestinations": {"station" :[{"stationValue": "MAD"}]},"keysCollected": "true","missingWeight": "15","matchWindow": "10","passengers": {  "passengerType" : { "names":[{"name":"MANN","seq":"1" }],"initials": [{"initial": "V","seq": "1"}],"title": "Er","contactInfo": {"permanentAddress": {"addressLine": {"addressLineDesc": "3100 CUMBERLAND BLVD, ATLANTA GA 3033999999","seq" : "1"},"state" : {"stateCode" : "ATL"},"postalCode":"A","country" : {"countryName" : "UnitedKingdom","countryCode" : "UK"}},"temporaryAddress": {"addressLine": {"addressLineDesc": "3100 CUMBERLAND BLVD, ATLANTA GA 3033999999","seq" : "1"},"state" : {"stateCode" : "ATL"},"postalCode":"A","country" : {"countryName" : "UnitedKingdom","countryCode" : "UK"},  "validityDate":"2017-12-15"},"permanentPhones":[{"phone":"","seq":"1"}],"cellPhones":[{"phone":"","seq":"1"}],"temporaryPhones":[{"phone":"","seq":"1"}],"emails": [{"email": "TEST.EMAIL@SITA.COM","seq": "1"},{"email": "TEST.EMAIL@AERO.COM","seq": "2"}],"faxes":[{"fax":"","seq":"1"}]},"frequentFlyerID": "XS123345678","language" : "Language",  "ticketNumber" : "TicketNumber",  "pnr" : "PNR",  "noofPassengers" : "NoofPassengers",  "passportInfo" : "PASSPORT INFO",  "itinerary": {"flightSegmentsorARNK": [{"flight": {"flightandDate" : {"airlineCode" : "XS","flightNumber" : "413Q","date" : "2017-04-12"},"originDestination": {"origin": "LHR","destination": "MAA"}}}]},"status": "J/GOLD",  "pooledTktNumber" : "PooledTkt",  "fareBasis" : "AAA",  "givenName" : "GivenName"  }}, "crossReferenceRecords": {"crossReferenceRecord":[{"recordType": "DELAYED","recordReference": {"stationCode": "MAD","airlineCode": "IB","referenceNumber": "98711"}}]},"handledAirlineCopyIndicator": "YES",   "designatedLocator" : "Designated","additionalInfo" : {"miscellaneousInfo" : [ {        "miscInfoText" : "MiscInfoText1", "seq" : "1" }],"furtherInfo" : "FurtherInfo",     "supplimentalInfo" : [{"supplimentInfoText" : "SupplimentInfoText1","seq":"1"}],"customsInfo" : "CustomsInfo","userComments" : [{"commentsText" : "CommentsText1"}],"messageInfo" : {"messageInfoText" : "MessageInfoText","seq" : "1"}},"claim": {"claimData": {"claimAmount": {"amount": {"amount": "11","currencyCode": "USD"}},"costRemarks": [{"costRemarksText": "PASSENGER PAID AMOUNTTTT","seq": "1"}],"claimDate" : "2016-08-26","dateNotified" : "2016-08-12","questionnaireDate" : "2016-04-12","faultStationCode": "ATL","faultTerminal": "LA","insurance": "No","liabilityTag": "No","missingBags" : "56","partnerCode" : {"carrierCode" : "IB"},"lossComments" : "LossComments","lossReasonCode":"","excessValue" : {"amount" : "172", "currencyCode" : "INR"},"toiletKits" : {"male" : "37","female" : "98"}}},"agentID": "n433081"}';
            System.debug(wrapper);
            String body = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapper);
            System.debug(body);

            //body = body.replaceAll('"current":','"currency":');
            req.setBody(body);

            Http http = new Http();
            HTTPResponse res;

            res = http.send(req);
            WR_DamagedBagWebResp resp = (WR_DamagedBagWebResp)JSON.deserialize(res.getBody(),WR_DamagedBagWebResp.class);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                
                
                System.debug(resp);
                //return resp;
                //return '1';
                //return resp;
                if(resp.errors == null || resp.errors.isEmpty()){
                    //return '1';
                    System.debug('sin error');
                    //String booleanResp = JSON.serialize(resp.success);
                    //System.debug(booleanResp);
                    //String advertencias = JSON.serialize(resp.warnings);
                    //System.debug(advertencias);
                    //String respUpdated = booleanResp + '@splitMe@' + advertencias; //facilitando la vida a la visual
                    //System.debug(respUpdated);
                    //return respUpdated;
                    return '1';
                }else{
                	System.debug('entra en error');
                   return JSON.serialize(resp.errors);
                }
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return UpdateDamagedBag(wrapper,intentos);
                }
                else if (res.getStatusCode() == 400){
                	System.debug('entra en error');
	                return JSON.serialize(resp.errors);
                }
                else{
                	R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag', '', 'Error en UpdateDamagedBag', 'R1_Incident__c');
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Modify_Damaged.UpdateDamagedBag', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }
}