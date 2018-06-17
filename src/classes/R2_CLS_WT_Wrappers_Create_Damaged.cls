/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         David Rufo Valero
    Company:        Accenture
    Description:    Class to create damaged into WT

    IN:
    OUT:

    History:

    <Date>              <Author>                                 <Description>
    04/12/2017    		David Rufo Valero        	Integration with WT. Web service Damaged
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_WT_Wrappers_Create_Damaged {
	
	public class WpCreateDamagedRequest {
		public RefStationAirline refStationAirline ; 
		public DamagedBagGroup damagedBagGroup ; 
		public Passenger passenger ; 
		public CrossReferenceRecords crossReferenceRecords ; 
		public String designatedLocator ; 
		public AdditionalInfo additionalInfo ; 
		public Claim claim ; 
		public String agentId ;
		public String handledAirlineCopyIndicator ;
		public AssociatedDelayRecord associatedDelayRecord ;
	}
	
	public class WpCreateDamagedResponse {
		public String success;
		public Record record;
		public Warnings warnings;
		public List<Errors> errors;
	}
	
	public class LicenseNumber {
		public String tagType ; 
		public String issuerCode ;
	}
	
	public class Flight {
		public FlightDate flightAndDate ; 
		public OriginDestination originDestination ;
	}
	
	public class PassengerPayments {
		public List<PassengerPaymentsValue> passengerPaymentsValue ;
	}
	
	public class PassengerPaymentsValue {
		public String costType ; 
		public Amount amount ;
	}
	
	public class CrossReferenceRecord {
		public String recordType ; 
		public RecordReference recordReference ;
	}
	
	public class CurrencyCode {
		public String currencyCodeValue ;
	}
	
	public class AssociatedDelayRecord {
		public RecordReference recordReference ;
		public BagIDs bagIDs ;
	}

	public class BagIDs {
		public List<String> bagID ;
	}

	public class RecordReference {
		public String stationCode ; 
		public String airlineCode ; 
		public String referenceNumber ;
	}
	
	public class Itinerary {
		public List<FlightSegmentsOrARNK> flightSegmentsOrARNK ; 
		public List<String> additionalRoutes ;
	}
	
	public class TemporaryAddress {
		public AddressLine addressLine ; 
		public String validityDate ;
		public String postalCode ;
	}
	
	public class ContactInfo {
		public BagAddress permanentAddress ; 
		public TemporaryAddress temporaryAddress ; 
		public BagPhones permanentPhones ; 
		public BagPhones cellPhones ; 
		public BagPhones temporaryPhones ; 
		public Emails emails ;
	}
	
	public class Emails {
		public List<String> email ;
	}

	public class BagPhones {
		public List<String> phone ;
	}
	
	public class DamagedBag {
		public ColorTypeDesc colorTypeDesc ; 
		public BagTag bagTag ; 
		public BrandInfo brandInfo ; 
		public BagDelivery bagDelivery ; 
        public String storageLocation ; 
        public String lockCode ;
        public BagSentToCustoms bagSentToCustoms ;
        public BagSentToCustoms bagReceivedFromCustoms ;
		public UniqueId uniqueId ; 
		public String bagDetails ; 
		public DamagedTypes damagedTypes ;
        public CrossReferenceRecord associatedRecord ;
	}
	
    public class BagSentToCustoms {
		public String bagDate;
		public String timeZone;
	}
    
    
	public class Status {
		public String outForDelivery ; 
		public String delivered ; 
		public String unableToDeliver ; 
		public String trackingUpdate ;
	}
	
	public class UniqueId {
		public String suspended ; //boolean
		public String uniqueIDType ;
	}
	
	public class AdditionalInfo {
		public List<MiscellaneousInfo> miscellaneousInfo ; 
		public String furtherInfo ; 
		public List<SupplementaryInfo> supplementaryInfo ; 
		public String customsInfo ; 
		public List<UserComments> userComments ;
	}
	
	public class DamagedType {
		public String location ; 
		public String type_Z ; // in json: type
		public String amount ;
	}
	
	public class AddressLine {
		public String addressLineDesc ;
	}
	
	public class BagAddress {
		public AddressLine addressLine ; 
		public State state ; 
		public String postalCode ; 
		public Country country ;
	}
	
	public class CrossReferenceRecords {
		public List<CrossReferenceRecord> crossReferenceRecord ;
	}
	
	public class Initials {
		public String initial ; 
		public String seq ;
	}
	
	public class AddressLine_Z {
		public String addressLineDesc ; 
		public String seq ;
	}
	
	public class DamagedTypes {
		public List<DamagedType> damagedType ;
	}
	
	public class FlightDate {
		public String airlineCode ; 
		public String flightNumber ; 
		public String rDate ; // in json: date  
	}
	
	public class BagTag {
		public String suspended ; //boolean 
		public LicenseNumber licenseNumber ; 
		public String tagSequence ;
		public String airlineCode ;
	}
	
	public class BrandInfo {
		public String suspended ; //boolean 
		public String brandInfo ;
	}
	
	public class OriginDestination {
		public String origin ; 
		public String destination ;
	}
	
	public class State {
		public String stateDesc ; 
		public String stateCode ;
	}
	
	public class BagTag_Z {
		public String suspended ; //boolean 
		public String airlineCode ; 
		public String tagSequence ;
	}
	
	public class BaggageItinerary {
		public List<FlightDateOrARNK> flightDateOrARNK ;
	}
	
	public class Country {
		public String countryName ; 
		public String countryCode ;
	}
	
	public class Descriptor {
		public String materialElement ; 
		public List<String> otherElement ;
	}
	
	public class PermanentPhones {
		public List<String> phone ; 
		public String seq ;
	}
	
	public class LocalDlvInfo {
		public String dlvInfo ; 
		public String seq ;
	}
	
	public class BagDelivery {
		public String deliveredTime ; 
		public Status status ;
	}
	
	//public class BagPhones {
	//	public String phone ;
	//}
	
	public class SupplementaryInfo {
		public String supplimentInfoText ;
		public String seq ;
	}
	
	public class DeliveryAddress {
		public AddressLine_Z addressLine ; 
		public State state ; 
		public String postalCode ; 
		public Country country ;
	}
	
	public class PartnerCode {
		public String carrierCode ;
	}
	
	public class Names {
		public String name ; 
		public String seq ;
	}
	
	public class ClaimAmount {
		public Amount amount ;
	}
	
	public class Passenger {
		public List<Names> names ; 
		public List<Initials> initials ; 
		public String title ; 
		public ContactInfo contactInfo ;
		public String frequentFlyerId ; 
		public String language ; 
		public String ticketNumber ; 
		public String pnr ; 
		public String noOfPassengers ; 
		public Itinerary itinerary ; 
		public String status ; 
		public String pooledTktNumber ; 
		public String fareBasis ; 
		public String givenName ;
		public String autoMessageOption ;
	}
	
	public class UserComments {
		public String commentsText ;
		public String seq ;
	}
	
	public class DamagedBagGroup {
		public BagAddress bagAddress ; 
		public String baggageWeight ; 
		public String contentsGender ; 
		public Delivery delivery ; 
		public BagPhones bagPhones ; 
		public DamagedBags damagedBags ; 
		public BaggageItinerary baggageItinerary ; 
		public String excessBaggage ; 
		public String missingWeight ; 
		public List<String> lostContents ; 
		public String contentsDamage ;
		public String bagLastSeen ;
	}
	
	public class DamagedBags {
		public List<DamagedBag> damagedBag ;
	}
	
	public class Amount {
		public String amount ; 
		public CurrencyCode currencyCode ;
	}
	
	public class ColorTypeDesc {
		public String suspended ; //boolean
		public String colorCode ; 
		public String typeCode ; 
		public Descriptor descriptor ;
	}
	
	public class MiscellaneousInfo {
		public String miscInfoText ;
		public String seq ;
	}
	
	public class Delivery {
		public BagAddress deliveryAddress ; 
		public String deliveryWeight ; 
		public List<LocalDlvInfo> localDlvInfo ;
	}
	
	public class RefStationAirline {
		public String stationCode ; 
		public String airlineCode ;
	}
	
	public class FlightSegmentsOrARNK {
		public Flight flight ;
		public Arnk arnk ;
	}
	
	public class Arnk {
        public OriginDestination originDestination;
    }

	public class Claim {
		public ClaimAmount claimAmount ; 
		public List<String> costRemarks ; 
		public PassengerPayments passengerPayments ; 
		public String claimDate ; 
		public String notifiedDate ; 
		public String questionnaireDate ; 
		public String faultStationCode ; 
		public String faultTerminal ; 
		public String liabilityTag ;
		public PartnerCode partnerCode ; 
		public String lossComments ; 
		public String lossReasonCode ; 
		public String replacementBag ;  //boolean
		public String repairBag ; //boolean
		public Boolean insurance ;
	}
	
	public class FlightDateOrARNK {
		public FlightDate flightDate;// ;
	}
	
	//public class Warnings {  //descomentar cuando los indios lo arreglen
	//	public String warningCode;
	//	public String warningDescription;
	//}

	public class Warnings { //comentar cuando los indios lo arreglen
		public List<Warning> warning;
	}

	public class Warning {//comentar cuando los indios lo arreglen
		public String warningCode;
		public String warningDescription;
	}

	public class Record {
		public String recordType;
		public RecordReference recordReference;
	}

	public class Errors {
		public String code;
		public String reason;
		public String timeStamp; //added 11/01/2018 new field
        //napalm temporal esperando arreglos en II
        //public String errorCode;
        //public String errorDescription;
	}
	
	
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         David Rufo Valero
    Company:        Accenture
    Description:    Method to call CreateDamaged()

    IN:				wrapper 	-> Data input for send web service (Example: '{"additionalInfo":{"customsInfo":"customs info","furtherInfo":"further info","miscellaneousInfo":[{"miscInfoText":"Free misc"},{"miscInfoText":"Free misc One"}],"supplementaryInfo":[{"supplimentInfoText":"Free supp info"},{"supplimentInfoText":"Free supp info One"}],"userComments":[{"commentsText":"abcgd"}]},"agentId":"AGENT","claim":{"claimAmount":{"amount":{"amount":"5000","currencyCode":{"currencyCodeValue":"USD"}}},"claimDate":"2017-09-10","costRemarks":["OST REMARKS"],"faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","lossComments":"RL COMMENTS","lossReasonCode":"91","notifiedDate":"2017-09-10","partnerCode":{"carrierCode":"BAB"},"passengerPayments":{"passengerPaymentsValue":[{"amount":{"amount":"35.45","currencyCode":{"currencyCodeValue":"USD"}},"costType":"F"}]},"questionnaireDate":"2017-09-10","repairBag":"false","replacementBag":"true"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordReference":{"airlineCode":"IB","referenceNumber":"67874","stationCode":"MAD"},"recordType":"DELAYED"}]},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127 ELMO AVE, POUGHKEEPSIE VA 30335"},"country":{"countryCode":"CC","countryName":"India"},"postalCode":"POSTCODE","state":{"stateCode":"AA","stateDesc":"Arizona"}},"bagPhones":{"phone":["770 850 4550"]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","date_0":"2017-09-10","flightNumber":"23"}}]},"baggageWeight":"5/20K","contentsDamage":"CONTENTS DAMAGE","contentsGender":"M","damagedBags":{"damagedBag":[{"bagDelivery":{"deliveredTime":"2017-09-10T00:18:33","status":{"delivered":"string","outForDelivery":"123","trackingUpdate":"string","unableToDeliver":"string"}},"bagDetails":"Bag01","bagTag":{"licenseNumber":{"issuerCode":"123","tagType":"2"},"suspended":"false","tagSequence":"313131"},"brandInfo":{"brandInfo":"Carlton","suspended":"false"},"colorTypeDesc":{"colorCode":"BU","descriptor":{"materialElement":"X","otherElement":["X","X"]},"suspended":"false","typeCode":"1"},"damagedTypes":{"damagedType":[{"amount":"MA","location":"SIDE","type_Z":"04"},{"amount":"MI","location":"TOP","type_Z":"01"}]},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"}},{"bagDetails":"Bag02","bagTag":{"airlineCode":"IB","suspended":"false","tagSequence":"313234"},"brandInfo":{"brandInfo":"VIP","suspended":"false"},"colorTypeDesc":{"colorCode":"WT","descriptor":{"materialElement":"X","otherElement":["X","X"]},"suspended":"false","typeCode":"1"},"damagedTypes":{"damagedType":[{"amount":"MA","location":"BOTTOM","type_Z":"05"},{"amount":"TL","location":"TOP","type_Z":"03"}]}}]},"delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420 HIGH STREET, DAYTON OH 45202","seq":"1"},"country":{"countryCode":"IN","countryName":"India"},"postalCode":"TW59BE","state":{"stateCode":"AA","stateDesc":"Arizona"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM","seq":"1"}]},"excessBaggage":"EXCESSTICKET","lostContents":["TROUSERS MISSING"],"missingWeight":"1KG"},"designatedLocator":"1234","passenger":{"contactInfo":{"cellPhones":{"phone":["404 431 9238"]},"emails":{"email":["test_mail@gmail.com"]},"permanentAddress":{"addressLine":{"addressLineDesc":"666 PALACE BLVD, LONDON GB"},"country":{"countryCode":"CC","countryName":"Great Britain"},"postalCode":"A","state":{"stateCode":"SC","stateDesc":"Sussex"}},"permanentPhones":{"phone":["770 850 4550"],"seq":"1"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400 PENNSYLVANIA LN, WASHINGTON OK 30339"},"validityDate":"2017-09-10"},"temporaryPhones":{"phone":["404 431 3980"]}},"fareBasis":"F","givenName":"Test","initials":{"initial":["OK"],"seq":"1"},"itinerary":{"additionalRoutes":["VPS","PNS","SRQ","FLL"],"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","date_0":"2017-10-09","flightNumber":"89"},"originDestination":{"destination":"TPA","origin":"ATL"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","date_0":"2017-10-09","flightNumber":"98"},"originDestination":{"destination":"RSW","origin":"TPA"}}}]},"language":"ENGLISH","names":{"name":["OLGA","KAMINSKYA"],"seq":"1"},"noOfPassengers":"2","pnr":"YW8CD","pooledTktNumber":"POOLTKT","status":"F","ticketNumber":"XS1234567","title":"Ms"},"refStationAirline":{"airlineCode":"IB","stationCode":"MAD"}}')
    				contador 	-> Number of request (Example: 0)
    OUT:           	Result of create Damaged

    History:

    <Date>              <Author>            		<Description>
    04/12/2017    	David Rufo Valero    			Initial version
    11/12/2017		Alberto Puerto Collado			Final&minimal fixes
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	public static WpCreateDamagedResponse createDamagedPIR(String wrapper, Integer contador){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
			
			//Endpoint to callout
            String wsMethod = 'R2_DamagedBags';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }

			//1.- Create request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c + '/damaged-bags/');
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if (token == null) {
                if(contador < 3){
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return createDamagedPIR(wrapper, contador);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Create_Damaged.createDamaged', wrapper, 'Error en login', 'R1_Incident__c');
                    return null;
                }
            }
			//2.- Include headers into request
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            TimeOut_Integrations__c timeOut = TimeOut_Integrations__c.getInstance('WorldTracer');
            req.setTimeout((Integer)timeOut.setTimeOut__c);
            System.debug('Http Request: ' + req); //LoggingLevel.DEBUG, 

			//3.- Body for request
			String strBodyRequest = wrapper;
			//String strBodyRequest = '{"refStationAirline":{"stationCode":"MAD","airlineCode":"IB"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"2127 ELMO AVE, POUGHKEEPSIE VA 30335"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"POSTCODE","country":{"countryName":"India","countryCode":"CC"}},"baggageWeight":"5/20K","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"3420 HIGH STREET, DAYTON OH 45202","seq":"1"},"state":{"stateDesc":"Arizona","stateCode":"AA"},"postalCode":"TW59BE","country":{"countryName":"India","countryCode":"IN"}},"deliveryWeight":"53KG","localDlvInfo":[{"dlvInfo":"DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM","seq":"1"}]},"bagPhones":{"phone":["770 850 4550"]},"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":"false","colorCode":"BU","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","licenseNumber":{"tagType":"2","issuerCode":"123"},"tagSequence":"313131"},"brandInfo":{"suspended":"false","brandInfo":"Carlton"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:33","status":{"outForDelivery":"123","delivered":"string","unableToDeliver":"string","trackingUpdate":"string"}},"uniqueId":{"suspended":"false","uniqueIDType":"A123-B456-C789"},"bagDetails":"Bag01","damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]}},{"colorTypeDesc":{"suspended":"false","colorCode":"WT","typeCode":"1","descriptor":{"materialElement":"X","otherElement":["X","X"]}},"bagTag":{"suspended":"false","airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":"false","brandInfo":"VIP"},"bagDetails":"Bag02","damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]}}]},"baggageItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","date":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERS MISSING"],"contentsDamage":"CONTENTS DAMAGE"},"passenger":{"names":{"name":["TINTIN","KAMINSKYA"],"seq":"1"},"initials":{"initial":["OK"],"seq":"1"},"title":"Ms","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"666 PALACE BLVD, LONDON GB"},"state":{"stateDesc":"Sussex","stateCode":"SC"},"postalCode":"A","country":{"countryName":"Great Britain","countryCode":"CC"}},"temporaryAddress":{"addressLine":{"addressLineDesc":"3400 PENNSYLVANIA LN, WASHINGTON OK 30339"},"validityDate":"2017-09-10"},"permanentPhones":{"phone":["770 850 4550"],"seq":"1"},"cellPhones":{"phone":["404 431 9238"]},"temporaryPhones":{"phone":["404 431 3980"]},"emails":{"email":["test_mail@gmail.com"]}},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","noOfpassenger":"2","itinerary":{"flightSegmentsOrARNK":[{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","date":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flight":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","date":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTktNumber":"POOLTKT","fareBasis":"F","givenName":"Test"},"crossReferenceRecords":{"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}]},"designatedLocator":"1234","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"Free misc"},{"miscInfoText":"Free misc One"}],"furtherInfo":"further info","supplementaryInfo":[{"supplimentInfoText":"Free supp info"},{"supplimentInfoText":"Free supp info One"}],"customsInfo":"customs info","userComments":[{"commentsText":"abcgd"}]},"claim":{"claimAmount":{"amount":{"amount":"5000","currencyCode":{"currencyCodeValue":"USD"}}},"costRemarks":["OST REMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":"35.45","currencyCode":{"currencyCodeValue":"USD"}}}]},"claimDate":"2017-09-10","notifiedDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","liabilityTagIndicator":"Yes","partnerCode":{"carrierCode":"BAB"},"lossComments":"RL COMMENTS","lossReasonCode":"91","replacementBag":"true","repairBag":"false"},"agentId":"AGENT"}';
            
            //body = helper_fixerJson(body);
            //Replace text type not allowed in Salesforce
            strBodyRequest = strBodyRequest.replace('"date_0"','"date"');
            strBodyRequest = strBodyRequest.replace('"type_Z"','"type"');
            System.debug('Body Request: ' + strBodyRequest);
            req.setBody(strBodyRequest);

			//4.- Send data
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('Status Response Code: ' + res.getStatusCode());

            //5.- Get data for web service
            String strBodyResponse = res.getBody();
            System.debug('Body Response: ' + strBodyResponse);
            
            //6.- Parsing data response
            WpCreateDamagedResponse resp = (WpCreateDamagedResponse)JSON.deserialize(strBodyResponse, WpCreateDamagedResponse.class);
            System.debug('Body resp: ' + resp);
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                System.debug('RESPPPPP 20x: ' + resp);
                return resp;
            }else{
                if(contador<3 && res.getStatusCode() == 401){
                	System.debug('RESPPPPP: 401');
                    R1_CLS_SendCustomerMDM.login();
                    contador += 1;
                    return createDamagedPIR(wrapper, contador);
                }else{
                    if(contador<3){
                    	System.debug('RESPPPPP != 20x && != 401: ' + resp);
                        String callResponse = '';
                        for(Errors error : resp.errors){
                            callResponse += '+ ' + error.code + ' - ' + error.reason + '\\n';
                        }
                        System.debug('Errores: ' + callResponse);
                        //throw new R1_CLS_LogHelper.R1_Exception(callResponse);

                        return resp;
                    }
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Create_Damaged.createDamaged', '', 'Error en \'createDamaged\', fallos de login', 'R1_Incident__c');
                    return null;
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_WT_Wrappers_Create_Damaged.createDamaged', '', exc.getmessage() +', ' + exc.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }
    
}