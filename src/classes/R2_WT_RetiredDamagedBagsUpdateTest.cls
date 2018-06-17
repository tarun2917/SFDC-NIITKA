@isTest
public with sharing class R2_WT_RetiredDamagedBagsUpdateTest {
	@isTest
    static void retiredDamagedBagsUpdate_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"71313"},"damagedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"MAD","state":{"stateDesc":"stateDesc"},"postalCode":"A"},"baggageWeight":"54","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"City","state":{"stateDesc":"stateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DlvInfo","seq":"1"}]},"bagPhones":[{"phone":"8805983508","seq":"1"}],"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":false,"colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","C"]}},"bagTag":{"suspended":false,"airlineCode":"XS","tagSequence":"101100"},"brandInfo":{"suspended":false,"brandInfo":"KORS"},"bagDelivery":{"deliveredTime":"2016-09-30T09:00:00","status":{"outForDelivery":"OutForDelivery","delivered":"Delivered","unableToDeliver":"unableToDeliver","trackingUpdate":"TrackingUpdate"},"bagReceived":{"date":"2016-09-28T09:00:00","station":"ATL"}},"uniqueID":{"suspended":"false","uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"IST"},"storageLocation":"StorageLocation","bagDetails":"bagDetails","contentsDesc":"contentsDesc","associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"ATL","airlineCode":"IB","referenceNumber":"456732"}},"seq":"1"}],"missingWeight":"18"}},"passengers":{"initials":[{"initial":"MP","seq":"1"}],"title":"Er","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":"1"}],"cellPhones":[{"phone":"12345678","seq":"1"}],"temporaryPhones":[{"phone":"12345678","seq":"1"}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":"1"}],"faxes":[{"fax":"12345678","seq":"1"}],"state":"TN","ZipCode":"517408"},"frequentFlyerID":"XS123345678","language":"language","ticketNumber":"TicketNumber","pnr":"PNR","noofPassengers":"NoofPassengers","passportInfo":"PassportInfo","status":"status","pooledTktNumber":"123456987","fareBasis":"AAA","givenName":"GivenName"},"designatedLocator":"ABCD","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MiscInfoText","seq":"1"}],"furtherInfo":{"furtherInfoDesc":"furtherInfoDesc"},"supplimentalInfo":[{"supplimentInfoText":"supplimentInfoText","seq":"1"}],"customsInfo":{"customsInfoDesc":"customsInfoDesc"},"messageInfo":{"messageInfoText":"MessageInfoText","seq":"1"}},"claim":{"claimData":{"claimAmount":{"amountUnknown":true},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":"1"}],"claimDate":"2016-08-26","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"lossComments":"lossComments","lossReasonCode":"75"}},"lZControlDate":"2017-09-30","crossReferenceRecords":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"1234"}},"inboxAddress":{"stationAirline":{"stationCode":"MAA","airlineCode":"IB"},"area":"AP"},"definedPrompt":{"date":"2017-09-30","text":"ABC"},"agentID":"AGENT","date":"2017-01-10"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(wrapper, 0);
        Test.stopTest();
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


     @isTest
    static void retiredDelayedBagsUpdate400_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags400';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67371"},"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"MAD","state":{"stateDesc":"stateDesc"},"postalCode":"A"},"baggageWeight":"54","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"City","state":{"stateDesc":"stateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DlvInfo","seq":"1"}]},"bagPhones":[{"phone":"8805983508","seq":"1"}],"delayedBags":[{"colorTypeDesc":{"suspended":"true","colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","S"]}},"bagTag":{"suspended":"false","airlineCode":"XS","tagSequence":"310191"},"brandInfo":{"brandInfo":"MNA"},"bagDelivery":{"deliveredTime":"2016-09-30T09:00:00","status":{"outForDelivery":"OutForDelivery","delivered":"Delivered","unableToDeliver":"unableToDeliver","trackingUpdate":"TrackingUpdate"},"bagReceived":{"date":"2016-09-28T09:00:00","station":"ATL"}},"lockCode":"Lock","uniqueID":{"suspended":"false","uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"IST"},"storageLocation":"StorageLocation","bagDetails":"bagDetails","contentsDesc":"contentsDesc","associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"ATL","airlineCode":"IB","referenceNumber":"456732"}},"seq":"1"}],"excessBaggage":"excessBaggage"},"passengers":{"initials":[{"initial":"V","seq":"1"}],"title":"Er","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":"1"}],"cellPhones":[{"phone":"12345678","seq":"1"}],"temporaryPhones":[{"phone":"12345678","seq":"1"}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":"1"}],"faxes":[{"fax":"12345678","seq":"1"}],"state":"TN","ZipCode":"517408"},"frequentFlyerID":"XS123345678","language":"language","ticketNumber":"TicketNumber","pnr":"PNR","noofPassengers":"NoofPassengers","passportInfo":"PassportInfo","status":"status","pooledTktNumber":"123456987","fareBasis":"AAA","givenName":"GivenName"},"designatedLocator":"ABCD","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MiscInfoText","seq":"1"}],"furtherInfo":{"furtherInfoDesc":"furtherInfoDesc"},"supplimentalInfo":[{"supplimentInfoText":"supplimentInfoText","seq":"1"}],"customsInfo":{"customsInfoDesc":"customsInfoDesc"},"messageInfo":{"messageInfoText":"MessageInfoText","seq":"1"}},"claim":{"claimData":{"claimAmount":{"amountUnknown":true},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":"1"}],"claimDate":"2016-08-26","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"lossComments":"lossComments","lossReasonCode":"75"}},"lZControlDate":"2017-09-30","crossReferenceRecords":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"1234"}},"inboxAddress":{"stationAirline":{"stationCode":"MAA","airlineCode":"IB"},"area":"AP"},"definedPrompt":{"date":"2017-09-30","text":"ABC"},"agentID":"agentID","date":"2017-01-11"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(wrapper, 0);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }


    @isTest
    static void retiredDelayedBagsUpdate403_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags403';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67371"},"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"MAD","state":{"stateDesc":"stateDesc"},"postalCode":"A"},"baggageWeight":"54","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"City","state":{"stateDesc":"stateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DlvInfo","seq":"1"}]},"bagPhones":[{"phone":"8805983508","seq":"1"}],"delayedBags":[{"colorTypeDesc":{"suspended":"true","colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","S"]}},"bagTag":{"suspended":"false","airlineCode":"XS","tagSequence":"310191"},"brandInfo":{"brandInfo":"MNA"},"bagDelivery":{"deliveredTime":"2016-09-30T09:00:00","status":{"outForDelivery":"OutForDelivery","delivered":"Delivered","unableToDeliver":"unableToDeliver","trackingUpdate":"TrackingUpdate"},"bagReceived":{"date":"2016-09-28T09:00:00","station":"ATL"}},"lockCode":"Lock","uniqueID":{"suspended":"false","uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"IST"},"storageLocation":"StorageLocation","bagDetails":"bagDetails","contentsDesc":"contentsDesc","associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"ATL","airlineCode":"IB","referenceNumber":"456732"}},"seq":"1"}],"excessBaggage":"excessBaggage"},"passengers":{"initials":[{"initial":"V","seq":"1"}],"title":"Er","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":"1"}],"cellPhones":[{"phone":"12345678","seq":"1"}],"temporaryPhones":[{"phone":"12345678","seq":"1"}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":"1"}],"faxes":[{"fax":"12345678","seq":"1"}],"state":"TN","ZipCode":"517408"},"frequentFlyerID":"XS123345678","language":"language","ticketNumber":"TicketNumber","pnr":"PNR","noofPassengers":"NoofPassengers","passportInfo":"PassportInfo","status":"status","pooledTktNumber":"123456987","fareBasis":"AAA","givenName":"GivenName"},"designatedLocator":"ABCD","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MiscInfoText","seq":"1"}],"furtherInfo":{"furtherInfoDesc":"furtherInfoDesc"},"supplimentalInfo":[{"supplimentInfoText":"supplimentInfoText","seq":"1"}],"customsInfo":{"customsInfoDesc":"customsInfoDesc"},"messageInfo":{"messageInfoText":"MessageInfoText","seq":"1"}},"claim":{"claimData":{"claimAmount":{"amountUnknown":true},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":"1"}],"claimDate":"2016-08-26","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"lossComments":"lossComments","lossReasonCode":"75"}},"lZControlDate":"2017-09-30","crossReferenceRecords":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"1234"}},"inboxAddress":{"stationAirline":{"stationCode":"MAA","airlineCode":"IB"},"area":"AP"},"definedPrompt":{"date":"2017-09-30","text":"ABC"},"agentID":"agentID","date":"2017-01-11"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(wrapper, 0);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }


    @isTest
    static void retiredDelayedBagsUpdate500_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBags500';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67371"},"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"MAD","state":{"stateDesc":"stateDesc"},"postalCode":"A"},"baggageWeight":"54","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"City","state":{"stateDesc":"stateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DlvInfo","seq":"1"}]},"bagPhones":[{"phone":"8805983508","seq":"1"}],"delayedBags":[{"colorTypeDesc":{"suspended":"true","colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","S"]}},"bagTag":{"suspended":"false","airlineCode":"XS","tagSequence":"310191"},"brandInfo":{"brandInfo":"MNA"},"bagDelivery":{"deliveredTime":"2016-09-30T09:00:00","status":{"outForDelivery":"OutForDelivery","delivered":"Delivered","unableToDeliver":"unableToDeliver","trackingUpdate":"TrackingUpdate"},"bagReceived":{"date":"2016-09-28T09:00:00","station":"ATL"}},"lockCode":"Lock","uniqueID":{"suspended":"false","uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"IST"},"storageLocation":"StorageLocation","bagDetails":"bagDetails","contentsDesc":"contentsDesc","associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"ATL","airlineCode":"IB","referenceNumber":"456732"}},"seq":"1"}],"excessBaggage":"excessBaggage"},"passengers":{"initials":[{"initial":"V","seq":"1"}],"title":"Er","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":"1"}],"cellPhones":[{"phone":"12345678","seq":"1"}],"temporaryPhones":[{"phone":"12345678","seq":"1"}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":"1"}],"faxes":[{"fax":"12345678","seq":"1"}],"state":"TN","ZipCode":"517408"},"frequentFlyerID":"XS123345678","language":"language","ticketNumber":"TicketNumber","pnr":"PNR","noofPassengers":"NoofPassengers","passportInfo":"PassportInfo","status":"status","pooledTktNumber":"123456987","fareBasis":"AAA","givenName":"GivenName"},"designatedLocator":"ABCD","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MiscInfoText","seq":"1"}],"furtherInfo":{"furtherInfoDesc":"furtherInfoDesc"},"supplimentalInfo":[{"supplimentInfoText":"supplimentInfoText","seq":"1"}],"customsInfo":{"customsInfoDesc":"customsInfoDesc"},"messageInfo":{"messageInfoText":"MessageInfoText","seq":"1"}},"claim":{"claimData":{"claimAmount":{"amountUnknown":true},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":"1"}],"claimDate":"2016-08-26","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"lossComments":"lossComments","lossReasonCode":"75"}},"lZControlDate":"2017-09-30","crossReferenceRecords":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"1234"}},"inboxAddress":{"stationAirline":{"stationCode":"MAA","airlineCode":"IB"},"area":"AP"},"definedPrompt":{"date":"2017-09-30","text":"ABC"},"agentID":"agentID","date":"2017-01-11"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(wrapper, 0);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }


    @isTest
    static void retiredDelayedBagsUpdateError_Test(){
    	R1_CLS_LogHelper.throw_exception = false;
        R1_CS_Endpoints__c ep = new R1_CS_Endpoints__c();
        ep.Name='R2_InactiveBags';
        ep.R1_CHK_Activo__c = true	;
        ep.R1_TXT_EndPoint__c='R2_InactiveBagsError';
        insert ep;
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        insert ep2;
        TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;
        String wrapper = '{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67371"},"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"MAD","state":{"stateDesc":"stateDesc"},"postalCode":"A"},"baggageWeight":"54","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"AddressLineDesc","seq":"1"},"city":"City","state":{"stateDesc":"stateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DlvInfo","seq":"1"}]},"bagPhones":[{"phone":"8805983508","seq":"1"}],"delayedBags":[{"colorTypeDesc":{"suspended":"true","colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","S"]}},"bagTag":{"suspended":"false","airlineCode":"XS","tagSequence":"310191"},"brandInfo":{"brandInfo":"MNA"},"bagDelivery":{"deliveredTime":"2016-09-30T09:00:00","status":{"outForDelivery":"OutForDelivery","delivered":"Delivered","unableToDeliver":"unableToDeliver","trackingUpdate":"TrackingUpdate"},"bagReceived":{"date":"2016-09-28T09:00:00","station":"ATL"}},"lockCode":"Lock","uniqueID":{"suspended":"false","uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2016-09-20T09:00:00","timeZone":"IST"},"storageLocation":"StorageLocation","bagDetails":"bagDetails","contentsDesc":"contentsDesc","associatedRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"ATL","airlineCode":"IB","referenceNumber":"456732"}},"seq":"1"}],"excessBaggage":"excessBaggage"},"passengers":{"initials":[{"initial":"V","seq":"1"}],"title":"Er","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":"1"},"city":"ATL","state":{"stateDesc":"StateDesc"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":"1"}],"cellPhones":[{"phone":"12345678","seq":"1"}],"temporaryPhones":[{"phone":"12345678","seq":"1"}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":"1"}],"faxes":[{"fax":"12345678","seq":"1"}],"state":"TN","ZipCode":"517408"},"frequentFlyerID":"XS123345678","language":"language","ticketNumber":"TicketNumber","pnr":"PNR","noofPassengers":"NoofPassengers","passportInfo":"PassportInfo","status":"status","pooledTktNumber":"123456987","fareBasis":"AAA","givenName":"GivenName"},"designatedLocator":"ABCD","additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MiscInfoText","seq":"1"}],"furtherInfo":{"furtherInfoDesc":"furtherInfoDesc"},"supplimentalInfo":[{"supplimentInfoText":"supplimentInfoText","seq":"1"}],"customsInfo":{"customsInfoDesc":"customsInfoDesc"},"messageInfo":{"messageInfoText":"MessageInfoText","seq":"1"}},"claim":{"claimData":{"claimAmount":{"amountUnknown":true},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":"1"}],"claimDate":"2016-08-26","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"lossComments":"lossComments","lossReasonCode":"75"}},"lZControlDate":"2017-09-30","crossReferenceRecords":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"1234"}},"inboxAddress":{"stationAirline":{"stationCode":"MAA","airlineCode":"IB"},"area":"AP"},"definedPrompt":{"date":"2017-09-30","text":"ABC"},"agentID":"agentID","date":"2017-01-11"}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(wrapper, 0);
        Test.stopTest();
        //System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    }

    @isTest
    static void exception_Test(){
        R2_WT_RetiredDamagedBagsUpdate.updateRetiredRecord_DPR_PDI(null, null);
    }
}