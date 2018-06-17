public with sharing class R1_CLS_Utilities {

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alvaro Garcia
    Company:       Accenture
    Description:

Vishal
    History:

    <Date>                  <Author>                         <Change Description>
    09/05/2017              Alvaro Garcia                   Initial Version
    18/05/2017              Alvaro García                   added methods putCache and getCache
    03/08/2017              Alberto Puerto Collado          added helper methods: Account/Flight/Case constructors & static variable contador
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

       /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para simular las llamadas externas
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    29/05/2017             Alvaro Garcia Tapia                   Initial Version
    14/07/2017              Borja Gay Flores                     Added MockCallout for SMS Integration
    11/08/2017             Alberto Puerto Collado                Added MockCallout for R2_Retrieve_Passenger_Details and PasajerosVuelo
    06/03/2018             Alberto Puerto Collado                Added MockCallout for R2_ReadTelex
    ----------------------------------------------------------------------------------------------------------------------*/


     public class mockCallOut implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            String endpoint = String.valueof(req.getEndpoint());
            if(endpoint.contains('/')){
                // req.setEndPoint(endpoint.substring(0,17));
            }
            system.debug('##RP## Endpoint en Mock:' + req.getEndpoint());
            if (req.getEndpoint()==('Login')) {
                system.debug('login');
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"access_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiO", "expires_in":3600, "id_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiOiJhYTQ2OTUzOS1kMGFlL", "refresh_expires_in":604800, "refresh_token":"eyJhbGciOiJSUzI1NiJ9.eyJqdGkiOiJhMWNmNTUwYS1", "token_type":"bearer"}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint().endsWith('SendCustomerError')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"goldenRecordId": "8860003","source": {"sourceSystemName": "IBPLUS","customerId": "X458921"}}');
                res.setStatusCode(401);
                return res;
            }
            else if (req.getEndpoint().endsWith('SendCustomer')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"goldenRecordId": "8860003","source": {"sourceSystemName": "IBPLUS","customerId": "X458921"}}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint().endsWith('Message')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"Response" : "Success"}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint().endsWith('SubmitFlight')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"Result" : "Success","controlFlag" : "YES","mktCompany" : "IB","flightNumber" : "12345","flightDate" : "2017-01-12","boardingTime" : "2017-01-12 12:00:00"}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint().endsWith('UpdateFlightStatus')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"Response" : "Success"}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint()==('SMS_Login')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"accessToken" : "abcdefghijklmnopqrstuvwxy", "expiresIn" : "3745"}');
                res.setStatusCode(200);
                return res;
            }
            else if (req.getEndpoint().endsWith('SendSMS')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"tokenId" : "abcdefghijklmnopqrst123456789"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('SMS_Intentos')){
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"ERROR " : "Test"}');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('Send DNB')){
                HTTPResponse res = new HTTPResponse();
                res.setBody('<NotifyVoucherCreationWebResponse xmlns="http://www.ib.com/schema/vcm/NotifyVoucherCreationWebResponseV01">   <Status>SUCCESS</Status></NotifyVoucherCreationWebResponse>');
                res.setHeader('Content-Type', 'application/xml');
                res.setHeader('Accept', 'application/xml');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('create_dnb')){

                HTTPResponse res = new HTTPResponse();

                if (req.getMethod()=='POST'){
                  res.setBody('{"crmId":"1234567890","voucher":{"dnbVoucherNumber":"9999999999","creationDate":"22NOV17","creationTime":"08:32:49","amounts":{"amount":[{"paymentType":"C","value":"125.00"},{"paymentType":"M","value":"150.00"},{"paymentType":"Q","value":"125.00"},{"paymentType":"T","value":"125.00"}]},"currency":"EUR","decimals":"2"}}');
                  res.setStatusCode(200);
                }else if(req.getMethod()=='PUT'){
                  res.setBody('{"crmId":"1234567890","voucher":{"dnbVoucherNumber":"9999999999","modifiedDate":"22NOV17","modifiedTime":"08:34:02","currency":"EUR","actionsCount":"3","decimals":"2"}}');
                  res.setStatusCode(200);
                }
                return res;
            }else if (req.getEndpoint()==('update_amounts_dnb')){
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"crmId":"1234567890","voucher":{"dnbVoucherNumber":"1439983467","modifiedDate":"22NOV17","modifiedTime":"08:35:37","amounts":{"amount":[{"paymentType":"C","value":"5500.00"},{"paymentType":"M","value":"100.00"},{"paymentType":"Q","value":"125.00"},{"paymentType":"T","value":"125.00"}]},"currency":"EUR","actionsCount":"4","decimals":"2"}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('cancel_amounts_dnb')){
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"crmId": "1234567890"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAD-1AMDE/passengers')){ //apañado a capón
                HTTPResponse res = new HTTPResponse();
                //res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\n| CRS ET UM1 CHD1 |\n| EMD:0755557000143-PREPAID BAGGAGE |\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\n| TKNE:0757500000563 |\n| CRS AUTO 19AUG0027 16A |\n|*** PREVIOUS API DATA IS MANDATORY *** |\n|@ |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n----------------------------------------------------------------------------------\n"}');
                res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\\n| CRS ET UM1 CHD1 |\\n| EMD:0755557000143-PREPAID BAGGAGE |\\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\\n| TKNE:0757500000563 |\\n| CRS AUTO 19AUG0027 16A |\\n|*** PREVIOUS API DATA IS MANDATORY *** |\\n|@ |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n----------------------------------------------------------------------------------\\n"}');
                res.setStatusCode(200);
                return res;

            }else if (req.getEndpoint()==('/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAD-null/passengers')){ //apañado a capón
                HTTPResponse res = new HTTPResponse();
                //res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\n| CRS ET UM1 CHD1 |\n| EMD:0755557000143-PREPAID BAGGAGE |\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\n| TKNE:0757500000563 |\n| CRS AUTO 19AUG0027 16A |\n|*** PREVIOUS API DATA IS MANDATORY *** |\n|@ |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n----------------------------------------------------------------------------------\n"}');
                res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\\n| CRS ET UM1 CHD1 |\\n| EMD:0755557000143-PREPAID BAGGAGE |\\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\\n| TKNE:0757500000563 |\\n| CRS AUTO 19AUG0027 16A |\\n|*** PREVIOUS API DATA IS MANDATORY *** |\\n|@ |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n----------------------------------------------------------------------------------\\n"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAL-null/passengers')){ //apañado a capón
                HTTPResponse res = new HTTPResponse();
                //res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\n| CRS ET UM1 CHD1 |\n| EMD:0755557000143-PREPAID BAGGAGE |\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\n| TKNE:0757500000563 |\n| CRS AUTO 19AUG0027 16A |\n|*** PREVIOUS API DATA IS MANDATORY *** |\n|@ |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n| |\n----------------------------------------------------------------------------------\n"}');
                res.setBody('{"passengerRecord":"----------------------------------------------------------------------------------\\n|@PR:IB3170/20AUGYMAD,SN16A PNR RL J0PYW |\\n| 1. TESTONE/XBAG SN16A Y LHR 0655/0810 ???? OP/NAM |\\n| CRS ET UM1 CHD1 |\\n| EMD:0755557000143-PREPAID BAGGAGE |\\n| EMD:0755557000144-UNACCOMPANIED MINORFEE |\\n|PSM- UMNR HK1 UM05 XBAG HK1 01PC -CONFIRMED 01 PC |\\n| TKNE:0757500000563 |\\n| CRS AUTO 19AUG0027 16A |\\n|*** PREVIOUS API DATA IS MANDATORY *** |\\n|@ |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n| |\\n----------------------------------------------------------------------------------\\n"}');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('PasajerosVuelo011')/*('PasajerosVuelo/0123-11212017-null/passengers')*/){
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"fullFlightNumber":"IB 6275","flightDate":"07/25/2017","flightOrigin":"MAD","transactionResult":"Success","flight":{"totalPassengers":2,"passengers":[{"paxSequenceNumber":1,"originCity":"CAN","specialTreatment":"special","passengerName":"Cinta","companyFf":"Ff","tierFf":"Ff","companyFr":"Fr","tierFr":"fr","numFr":"","deniedBoardingIndicator":"Y","downgradeIndicator":"Y","misconnectionIndicator":"Y","customerCategory":"category","employeeIndicator":"Y","flightClass":"Business","inboundConnectionIndicator":"Y","outboundConnectionIndicator":"Y","disembarkAvailabilityIndicator":"Y","waitingListIndicator":"Y","vipIndicator":"Y","upgradeIndicator":"Y","seatAvailabilityIndicator":"Y","deadHeadCrewIndicator":"Y","voluntarySeatIndicator":"Y","sectionId":"SecId","pnr":"IJK123","contactId":"123","boardingNumber":"123","seatNumber":"SN29","cabin":"A"},{"paxSequenceNumber":1,"originCity":"CAN","specialTreatment":"special","passengerName":"Pedro","companyFf":"Ff","tierFf":"Ff","companyFr":"Fr","tierFr":"fr","numFr":"","deniedBoardingIndicator":"Y","downgradeIndicator":"Y","misconnectionIndicator":"Y","customerCategory":"category","employeeIndicator":"Y","flightClass":"Business","inboundConnectionIndicator":"Y","outboundConnectionIndicator":"Y","disembarkAvailabilityIndicator":"Y","waitingListIndicator":"Y","vipIndicator":"Y","upgradeIndicator":"Y","seatAvailabilityIndicator":"Y","deadHeadCrewIndicator":"Y","voluntarySeatIndicator":"Y","sectionId":"SecId","pnr":"IJK123","contactId":"123","boardingNumber":"123","seatNumber":"SN29","cabin":"A"}]}}');
                res.setStatusCode(200);
                return res;
            }/*else if (req.getEndpoint()==('PasajerosVuelo/0111-07022017-BAR/passengers')){
                HTTPResponse res = new HTTPResponse();
                //'{"fullFlightNumber":"IB 6275","flightDate":"07/25/2017","flightOrigin":"MAD","transactionResult":"Success","flight":{"totalPassengers":2,"passengers":[{"paxSequenceNumber":1,"originCity":"CAN","specialTreatment":"special","passengerName":"Cinta","companyFf":"Ff","tierFf":"Ff","companyFr":"Fr","tierFr":"fr","numFr":"Num","deniedBoardingIndicator":"Y","downgradeIndicator":"Y","misconnectionIndicator":"Y","customerCategory":"category","employeeIndicator":"Y","flightClass":"Business","inboundConnectionIndicator":"Y","outboundConnectionIndicator":"Y","disembarkAvailabilityIndicator":"Y","waitingListIndicator":"Y","vipIndicator":"Y","upgradeIndicator":"Y","seatAvailabilityIndicator":"Y","deadHeadCrewIndicator":"Y","voluntarySeatIndicator":"Y","sectionId":"SecId","pnr":"IJK123","contactId":"123","boardingNumber":"123","seatNumber":"SN29","cabin":"A"},{"paxSequenceNumber":1,"originCity":"CAN","specialTreatment":"special","passengerName":"Pedro","companyFf":"Ff","tierFf":"Ff","companyFr":"Fr","tierFr":"fr","numFr":"Num","deniedBoardingIndicator":"Y","downgradeIndicator":"Y","misconnectionIndicator":"Y","customerCategory":"category","employeeIndicator":"Y","flightClass":"Business","inboundConnectionIndicator":"Y","outboundConnectionIndicator":"Y","disembarkAvailabilityIndicator":"Y","waitingListIndicator":"Y","vipIndicator":"Y","upgradeIndicator":"Y","seatAvailabilityIndicator":"Y","deadHeadCrewIndicator":"Y","voluntarySeatIndicator":"Y","sectionId":"SecId","pnr":"IJK123","contactId":"123","boardingNumber":"123","seatNumber":"SN29","cabin":"A"}]}}'
                res.setBody('');
                res.setStatusCode(401);
                return res;
            }*/else if (req.getEndpoint()==('Send TSK')){
                HttpResponse res = new HttpResponse();
                res.setBody('');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardJan')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Jan 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardFeb')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Feb 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardMar')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Mar 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
           }else if (req.getEndpoint()==('PruebaGiftCardApr')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Apr 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
           }else if (req.getEndpoint()==('PruebaGiftCardMay')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed May 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
           }else if (req.getEndpoint()==('PruebaGiftCardJun')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Jun 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
           }else if (req.getEndpoint()==('PruebaGiftCardJul')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Jul 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardAug')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Aug 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardSep')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Sep 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardOct')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Oct 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardNov')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Nov 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardDec')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Dec 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCard401')){
                HttpResponse res = new HttpResponse();
                res.setBody('');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_Retrieve_Passe')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PreOrderCheck')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"order":{"orderID":1286,"orderPNR":"WLKMDL","orderPNRResiber":"J3RVR","orderLanguage":"es","orderStatus":"E","refundRequestedIndicator":true,"refundableIndicator":false,"service":{"serviceId":"301","menu":{"menuName":"GOURMET PREMIUM ECONOMY","iberiaMenuID":"MLAW","gateGourmetMenuID":664707}},"customerEmail":"lrodriguez@leda-mc.com","flight":{"airportDeparture":"MEX","airportArrival":"MEX","flightNumber":"IB6403"},"emdidentifier":"755554073593"}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PreOrderCheck2')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"order":{"orderID":1286,"orderPNR":"WLKMDL","orderPNRResiber":"J3RVR","orderLanguage":"fallo","orderStatus":"E","refundRequestedIndicator":true,"refundableIndicator":false,"service":{"serviceId":"301","menu":{"menuName":"GOURMET PREMIUM ECONOMY","iberiaMenuID":"MLAW","gateGourmetMenuID":664707}},"customerEmail":"lrodriguez@leda-mc.com","flight":{"airportDeparture":"MEX","airportArrival":"MEX","flightNumber":"IB6403"},"emdidentifier":"755554073593"}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('RequestRefund')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"success":"true"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('RequestRefund401')){
                HttpResponse res = new HttpResponse();
                res.setBody('');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('Pagos')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"result": "Success", "crmUserId": "SITSVQAG540", "crmPaymentId": "89585RAMRA"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint().endsWith('cancel')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"result": "Success", "crmUserId": "SITSVQAG539", "crmPaymentId": "896RU788A"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('PruebaGiftCardCualquiera')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Dec 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint() == ('/api/FM-FPM/rs/v1')){
                HttpResponse res = new HttpResponse();
                res.setBody('{"status": "SUCCESS","giftCard":{"crmCreationRequestId": "AiberFirstTes01","giftCodeId": "A3JZNQC7PUJD54","giftClaimCode": "TZCF-3P6RF5-9LY5","giftCodeExpirationDate": "Wed Dec 22 21:59:59 UTC 2027","cardInfo":{"cardStatus": "RefundedToPurchaser","value":{"amount": "10.0","currencyCode": "EUR"}}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('retriveCompensationTranference')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"indemnization":"500","singularIndicator":"Sin Informacion","delayTime":"16.0","carrierCode":"IB","flightNumber":"IB_6464_2017-03-08","departureAirport":"UIO","arrivalAirport":"GYE","cabinClass":"0","traveledDistance":"1240.539","missedConnection":"Sin Informacion","indNotAutomate":"Si"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('retriveCompensationAvios')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"aviosCompensation":"500","singularIndicator":"Sin Informacion","delayTime":"16.0","carrierCode":"IB","flightNumber":"IB_6464_2017-03-08","departureAirport":"UIO","arrivalAirport":"GYE","cabinClass":"0","traveledDistance":"1240.539","missedConnection":"Sin Informacion","indNotAutomate":"Si"}');
                res.setStatusCode(200);
                return res;
                //----- WT comprobar el nombre del endpoint  y el tipo de metodo (post o put)
            }else if (req.getEndpoint()==('R2_DamagedBags' + '/damaged-bags/') && req.getMethod() == 'PUT') { //update
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"warnings":[{"warningCode":"4500","warningDescription":"ACCEPTED - CHECK THE DATE OF FLIGHT"}]}');
                //res.setBody('{"errors": [{ "code": "FRAM_A0005", "reason": "JSON_MAPPING_EXCEPTION", "timeStamp": "2017-12-28 16:17" }]}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DamagedBags' + '/damaged-bags/')) { // create
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"errors": [{"code": "PAC_UTILS_E0005","reason": "Fallo de validación de datos. Por favor, revisalos por si hay un error","timeStamp": "2017-12-28 16:14"},{"code": "PAC_UTILS_E0005","reason": "property:damagedBagGroup|error:no puede ser null","timeStamp": "2017-12-28 16:14"},{"code": "PAC_UTILS_E0005","reason": "property:passenger|error:no puede ser null","timeStamp": "2017-12-28 16:14" }, { "code": "PAC_UTILS_E0005", "reason": "property:refStationAirline|error:no puede ser null", "timeStamp": "2017-12-28 16:14" } ]}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DamagedBags' + '/damaged-bags/report')) { //generate
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "reportOutput": "Test" }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DamagedBags' + '/damaged-bags/reassign')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "newRecord":    { "recordType": "DAMAGED", "recordReference":       { "stationCode": "BCN", "airlineCode": "IB", "referenceNumber": "71423" } } }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DamagedBags' + 'damaged-bags/close')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + 'delayed-bags/suspend')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "warnings": [   { "warningCode": "4064", "warningDescription": "RECORD ALREADY CLOSED" }] }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBagsErrorResp' + 'delayed-bags/suspend')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{   "success": false,   "errors": [   {      "errorCode": "1000",      "errorDescription": "STATION/AIRLINE INVALID"   }]}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + 'delayed-bags/reinstate')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "warnings": [   { "warningCode": "9999", "warningDescription": "NOT IN TRACING MUST RAW" }] }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + '/delayed-bags/close')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success" :true}');
                //res.setBody('{"errors": [{ "code": "BGM_DLBM_00019", "reason": "Record Already Closed", "timeStamp": "2017-12-28 16:13" }]}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + 'delayed-bags/reopen')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"newRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"68434"}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags/delayed-bags/reassign')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"newRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"66523"}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + 'delayed-bags/report')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"reportOutput":"Test"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags/delayed-bags/') && req.getMethod() == 'PUT' ) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_DelayedBags' + '/delayed-bags/')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "record":    { "recordType": "DELAYED", "recordReference":       { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68679" } }, "warnings": [   { "warningCode": "4500", "warningDescription": "ACCEPTED - CHECK THE DATE OF FLIGHT" }] }');
                res.setStatusCode(200);
                return res;
            }else if (  (req.getMethod() == 'POST' || req.getMethod() == 'PUT') &&
                        ( req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + 'delayed-bags/suspend') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + 'delayed-bags/reinstate') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + '/delayed-bags/close') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + 'delayed-bags/reopen') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + '/delayed-bags/reassign') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + 'delayed-bags/report') ||
                          req.getEndpoint().equalsIgnoreCase('R2_DelayedBagsError401' + '/delayed-bags/')
                        )
                        ) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('');
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags' + '/delayed-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags400' + '/delayed-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(400);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags403' + '/delayed-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(403);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags500' + '/delayed-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBagsError' + '/delayed-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(405);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags' + '/delayed-bags')) { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MISCINFOTEXT","seq":1}],"furtherInfo":{"furtherInfoDesc":"FURTHERINFODESC"},"supplimentalInfo":[{"supplimentInfoText":"SUPPLIMENTINFOTEXT","seq":1}],"customsInfo":{"customsInfoDesc":"CUSTOMSINFODESC"},"messageInfo":[{"messageInfoText":"MESSAGEINFOTEXT","seq":1}]},"success":true,"diaryInfo":{"createDate":"2017-10-06T13:22:00+0000","tracingDate":"2017-10-06T00:00:00+0000","retiredDate":"2017-10-06T00:00:00+0000","controllingStation":"HDQ"},"delayedBagGroup":{"bagAddress":{"addressLine":{"addressLineDesc":"ADDRESSLINE","seq":1},"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"baggageWeight":"20","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":{"addressLineDesc":"ADDRESSLINEDESC","seq":1},"state":{"stateCode":"BN"},"country":{"countryCode":"BZ"}},"deliveryWeight":"50","localDlvInfo":[{"dlvInfo":"CMN:DIVINFO","seq":1}]},"bagPhones":[{"phone":"84385361559","seq":1}],"delayedBags":[{"colorTypeDesc":{"suspended":false,"colorCode":"WT","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":false,"airlineCode":"IB","tagSequence":"770066"},"brandInfo":{"suspended":false,"brandInfo":"MNA"},"bagDelivery":{"deliveredTime":"2017-09-30T00:00:00+00:00","bagReceived":{"date":"2017-09-12T00:00:00Z","station":"MAD"}},"lockCode":"LOCK2","uniqueID":{"suspended":false,"uniqueID":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12T00:00:00Z","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"}]},"bagDetails":"CMN:BAGDETAILS","contentsDesc":"CMN:CONTENTDESCRIPTION","seq":1}],"keysCollected":false},"passengers":{"names":[{"name":"RAM","seq":1},{"name":"RAM","seq":1},{"name":"RAM","seq":1}],"initials":[{"initial":"P","seq":1},{"initial":"P","seq":1},{"initial":"P","seq":1}],"contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":1},"city":"ATL","state":{"stateDesc":"STATEDESC"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":1},"city":"ATL","state":{"stateDesc":"STATEDESC"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"cellPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"temporaryPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":1},{"email":"TEST.EMAIL@SITA.COM","seq":1}],"faxes":[{"fax":"12345678","seq":1}]},"ticketNumber":"7894445","itinerary":{"flightSegmentOrARNK":[{"flight":{"flightAndDate":{"airlinecode":"IB","flightNumber":"5678","flightDate":"2017-02-12"},"originDestination":{"origin":"MAD","destination":"JFK"}}}],"flightSegmentsorARNK":[{"flight":{"flightandDate":{"airlineCode":"XS","flightNumber":"413Q","date":"2017-10-05"},"originDestination":{"origin":"LHR","destination":"MAA"}}},{"arnk":{"originDestination":{"origin":"MAA","destination":"MAA"}}},{"flight":{"flightandDate":{"airlineCode":"IB","flightNumber":"413S","date":"2017-10-05"},"originDestination":{"origin":"MAA","destination":"MAD"}}}]},"status":"CMN:STATUS"},"claim":{"claimData":{"partnerCode":{"carrierCode":"IB"}}},"handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL06OCT/1322GMTAGN453485FROMWWSWMBYIB"]},"recordStatus":"OPEN"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags401' + '/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags400' + '/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(400);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags403' + '/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(403);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags500' + '/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBagsError' + '/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(567);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags' + '/damaged-bags') && req.getMethod() == 'PUT') {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags400' + '/damaged-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(400);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags403' + '/damaged-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(403);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags500' + '/damaged-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBagsError' + '/damaged-bags') && req.getMethod() == 'PUT') { //retrieveDelayed
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true}');
                res.setStatusCode(405);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                System.debug('***********!!!!!');
                res.setBody('{"success":true,"diaryInfo":{"crossReferenceRecords":[{"recordReference":{"stationCode":"MAD", "airlineCode":"IB", "referenceNumber":"234342"}}],"createDate":"2017-01-10T15:39:00+0000", "associateRecord":{"recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"23453"}}},"damagedBagGroup":{"bagTagDestinations":{"stationType":[{"stationValue":"234"}]},"bagAddress":{"addressLine":{"addressLineDesc":"ADDRESSLINEDESC","seq":1},"city":"MAD","state":{"stateDesc":"STATEDESC"},"postalCode":"A"},"baggageWeight":"54","delivery":{"localDeliveryInfo":[{"dlvInfo":"23234"},{"dlvInfo":"23235"}],"deliveryService":[{"deliveryServiceDesc":"edcas"}],"deliveryAddress":{"addressLine":{"addressLineDesc":"ADDRESSLINEDESC","seq":1},"city":"CITY","state":{"stateDesc":"STATEDESC"},"postalCode":"A"},"deliveryWeight":"54","localDlvInfo":[{"dlvInfo":"DLVINFO","seq":1}]},"bagPhones":[{"phone":"8805983508","seq":1},{"phone":"8805983509","seq":2}],"damagedBags":{"damagedBag":[{"colorTypeDesc":{"suspended":false,"colorCode":"GY","typeCode":"3","descriptor":{"mtrlElement":"R","otherElement":["K","C","H"]}},"bagTag":{"suspended":false,"airlineCode":"XS","tagSequence":"101100"},"brandInfo":{"suspended":false,"brandInfo":"KORS"},"bagDelivery":{"deliveredTime":"2017-09-30T09:00:00+00:00","bagReceived":{"date":"2017-09-28T09:00:00Z","station":"ATL"}},"uniqueID":{"suspended":false,"uniqueID":"TENTOEIGHTEEN"},"bagSentToCustoms":{"bagDate":"2017-09-20T09:00:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-20T09:00:00Z","timeZone":"IST"},"storageLocation":"STORAGELOCATION","damagedTypes":{"damagedType":[{"location":"SIDE","type":"05","amount":"MA"},{"location":"TOP","type":"02","amount":"MI"}]},"bagDetails":"BAGDETAILS","seq":1}]},"missingWeight":"18","lostContents":{"content":[{"contentValue":"WALKMANPERDIDO","seq":1},{"contentValue":"WALKMANPERDIDO","seq":1}]}},"passengers":{"names":[{"name":"CARMEN","seq":1},{"name":"CAMARA","seq":2},{"name":"MORAL","seq":3}],"initials":[{"initial":"MP","seq":1},{"initial":"MP","seq":1},{"initial":"MP","seq":1}],"title":"ER","contactInfo":{"permanentAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":1},"city":"ATL","state":{"stateDesc":"STATEDESC"},"postalCode":"A"},"temporaryAddress":{"addressLine":{"addressLineDesc":"3100CUMBERLANDBLVD,ATLANTAGA3033999999","seq":1},"city":"ATL","state":{"stateDesc":"STATEDESC"},"postalCode":"A","validityDate":"2017-12-15"},"permanentPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"cellPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"temporaryPhones":[{"phone":"12345678","seq":1},{"phone":"12345678","seq":1}],"emails":[{"email":"TEST.EMAIL@SITA.COM","seq":1},{"email":"TEST.EMAIL@SITA.COM","seq":1}],"faxes":[{"fax":"12345678","seq":1}]},"frequentFlyerID":"XS123345678","language":"LANGUAGE","ticketNumber":"TICKETNUMBER","pnr":"PNR","noofPassengers":"NOOFPASSENGERS","autoMessageOption":"NO_MESSAGE","passportInfo":"PASSPORTINFO","itinerary":{"flightSegmentOrARNK":[{"flight":{"flightAndDate":{"airlinecode":"IB","flightNumber":"5678","flightDate":"2017-02-12"},"originDestination":{"origin":"MAD","destination":"JFK"}}}],"flightSegmentsorARNK":[{"flight":{"flightandDate":{"airlineCode":"IB","flightNumber":"3923","date":"2017-01-06"},"originDestination":{"origin":"SVQ","destination":"MAD"}}}]},"status":"STATUS","fareBasis":"AAA"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"MISCINFOTEXT","seq":1}],"furtherInfo":{"furtherInfoDesc":"FURTHERINFODESC"},"supplimentalInfo":[{"supplimentInfoText":"SUPPLIMENTINFOTEXT","seq":1}],"customsInfo":{"customsInfoDesc":"CUSTOMSINFODESC"},"messageInfo":[{"messageInfoText":"MESSAGEINFOTEXT","seq":1}]},"claim":{"claimData":{"claimAmount":{"amount":{"amount":11,"currencyCode":"USD"}},"costRemarks":[{"costRemarksText":"PASSENGERPAIDAMOUNTTTT","seq":1}],"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}},{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}},{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}},{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}},{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}},{"costType":"A","amount":{"amount":1222,"currencyCode":"INR"}}]},"claimDate":"2017-08-26","dateNotified":"2017-02-27","faultStationCode":"LHR","faultTerminal":"T5","insurance":true,"liabilityTag":true,"partnerCode":{"none":true},"lossComments":"LOSSCOMMENTS","lossReasonCode":75}},"handledAirlineCopyIndicator":"YES","recordHistory":{"history":["DPR10JAN/1539GMTAG102096/09999FROMWMBYIB"]},"recordStatus":"OPEN"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags401' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags400' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(400);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags403' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(403);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags500' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBagsError' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(567);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "bagRecords": [   { "recordIdentifier":       { "recordType": "DAMAGED", "recordReference":          { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "71383" } }, "status": "ACTIVE", "names": {"name":       [ "JOHN", "LENNON" ]}, "initials": {"initial": ["JL"]}, "originalBags": [      { "bagTag":          { "suspended": false, "airlineCode": "IB", "tagSequence": "676545" }, "colourCode":          { "colorCode": "BK", "suspended": false, "typeCode": "1" }, "flight": {"flightDate":{ "airlineCode": "IB", "flightNumber": "3723", "date": "2017-05-15" }} }] }] }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags401' + '/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags400' + '/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(400);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags403' + '/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(403);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBags500' + '/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(500);
                return res;
            }else if (req.getEndpoint()==('R2_InactiveBagsError' + '/bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(567);
                return res;
            }else if (req.getEndpoint()==('R2_OnhandBagManager')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true,"warnings": [   {"recordId": "MADIB68205","warningCode": "9999","warningDescription": "ROH ACCEPTED - CK OHD FD"}]}');
                res.setStatusCode(200);
                return res;
            }
            /*
            // this resposnse (json) is invalid for this endpoint
            else if (req.getEndpoint()==('R2_OnhandBagManager')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "diaryInfo":{ "createDate": "2017-07-20T18:24:00Z", "tracingDate": "2017-07-20T00:00:00Z", "retiredDate": "2017-08-20T00:00:00Z" }, "onHandBagGroup": {"onHandBags":{ "colourAndType":{ "suspended": false, "colourCode": "RD", "typeCode": "1", "descriptor": {"otherElement":          [ "S", "W", "X" ]} }, "itinerary":       { "flightSegments": {"flightSegment":          [ {"flightDate":             { "airlineCode": "IB", "flightNumber": "0001", "flightDate": "2016-12-09" }}, {"flightDate":             { "airlineCode": "IB", "flightNumber": "0002", "flightDate": "2016-12-09" }} ]}, "routes": {"route":          [ "LHR", "ATL" ]} } }}, "passengers": {}, "additionalInfo": {"matchInfo":    [ { "matchInfoText": "ROH 03OCT17/1311GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "1" }, { "matchInfoText": "ROH 27JUL17/1512GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM TEST/AG AGENT\nFI NONE\nSI SUPPLIMENTALINFO\nSL STORAGELOCATION", "seq": "2" }, { "matchInfoText": "ROH 24AUG17/0702GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM TEST/AG AGENT\nFI NONE\nSI SUPPLIMENTALINFO\nSL STORAGELOCATION", "seq": "3" }, { "matchInfoText": "ROH 24AUG17/1303GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "4" }, { "matchInfoText": "ROH 24AUG17/1312GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "5" }, { "matchInfoText": "ROH 24AUG17/1322GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "6" }, { "matchInfoText": "ROH 24AUG17/1329GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "7" }, { "matchInfoText": "ROH 24AUG17/1330GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "8" }, { "matchInfoText": "ROH 24AUG17/1331GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "9" }, { "matchInfoText": "ROH 24AUG17/1348GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "10" }, { "matchInfoText": "ROH 24AUG17/1350GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "11" }, { "matchInfoText": "ROH 24AUG17/1428GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "12" }, { "matchInfoText": "ROH 01SEP17/1414GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "13" }, { "matchInfoText": "ROH 01SEP17/1419GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "14" }, { "matchInfoText": "ROH 05SEP17/1202GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "15" }, { "matchInfoText": "ROH 05SEP17/1353GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "16" }, { "matchInfoText": "ROH 05SEP17/1357GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "17" }, { "matchInfoText": "ROH 05SEP17/1400GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "18" }, { "matchInfoText": "ROH 05SEP17/1407GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "19" }, { "matchInfoText": "ROH 05SEP17/1410GMT\nFORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357\nNM STRING/AG STRING\nSI STRING", "seq": "20" } ]}, "recordHistory": {"history":    [ "OHD  20JUL/1824GMT AG STEPHEN FROM WWS WT BY IB TX AAA00A0", "ROH  26JUL/1927GMT /IB AG AGENT WWS BCNIB66357", "ROH  27JUL/1512GMT /IB AG AGENT WWS BCNIB66357", "RTD  20AUG/0200GMT RETIRED FROM TRACING", "ROH  24AUG/0702GMT /IB AG AGENT WWS BCNIB66357", "ROH  24AUG/1303GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1312GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1322GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1329GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1330GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1331GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1348GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1350GMT /IB AG STRING WWS BCNIB66357", "ROH  24AUG/1428GMT /IB AG STRING WWS BCNIB66357", "ROH  01SEP/1414GMT /IB AG STRING WWS BCNIB66357", "ROH  01SEP/1419GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1202GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1353GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1357GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1400GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1407GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1410GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1416GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1426GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1441GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1443GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1444GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1449GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1453GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1502GMT /IB AG STRING WWS BCNIB66357", "ROH  05SEP/1505GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0551GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0552GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0552GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0807GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0816GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/0816GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1009GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1024GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1024GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1039GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1051GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1156GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1200GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1204GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1205GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1345GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1347GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1354GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1406GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1414GMT /IB AG STRING WWS BCNIB66357", "ROH  06SEP/1419GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0433GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0433GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0434GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0501GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0502GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0505GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0505GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0506GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0506GMT /IB AG 123 WWS BCNIB66357", "ROH  07SEP/0507GMT /IB AG 123456789111 WWS BCNIB66357", "ROH  07SEP/0507GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0507GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0508GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0508GMT /IB AG 12345 WWS BCNIB66357", "ROH  07SEP/0512GMT /IB AG 12345 WWS BCNIB66357", "ROH  07SEP/0513GMT /IB AG 12345 WWS BCNIB66357", "ROH  07SEP/0514GMT /IB AG 12345 WWS BCNIB66357", "ROH  07SEP/0528GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0555GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0604GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0605GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0614GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0648GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0654GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0656GMT /IB AG 12345 WWS BCNIB66357", "ROH  07SEP/0831GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0834GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0834GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0834GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0835GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0835GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0953GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/0957GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1002GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1008GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1013GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1019GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1242GMT /IB AG 123 WWS BCNIB66357", "ROH  07SEP/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  07SEP/1341GMT /IB AG STRING WWS BCNIB66357", "ROH  08SEP/0416GMT /IB AG STRING WWS BCNIB66357", "ROH  08SEP/0416GMT /IB AG STRING WWS BCNIB66357", "ROH  08SEP/0526GMT /IB AG STRING WWS BCNIB66357", "ROH  08SEP/0529GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0542GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0544GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0544GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0711GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0717GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/0946GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/1049GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/1117GMT /IB AG 123 WWS BCNIB66357", "ROH  11SEP/1121GMT /IB AG 123 WWS BCNIB66357", "ROH  11SEP/1137GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/1207GMT /IB AG STRING WWS BCNIB66357", "ROH  11SEP/1218GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0722GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0727GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0734GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0748GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0751GMT /IB AG 123 WWS BCNIB66357", "ROH  12SEP/0752GMT /IB AG 123 WWS BCNIB66357", "ROH  22SEP/1004GMT /IB AG STRING WWS BCNIB66357", "ROH  22SEP/1004GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/0700GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/0713GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1159GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1159GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1159GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1159GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1159GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1217GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1217GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1217GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1217GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1217GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1245GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1311GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1311GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1311GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1311GMT /IB AG STRING WWS BCNIB66357", "ROH  03OCT/1311GMT /IB AG STRING WWS BCNIB66357" ]}, "recordStatus": "OPEN" }');
                res.setStatusCode(200);
                return res;
            }
            */
            else if (req.getEndpoint()==('R2_OnhandBagManager401')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(401);
                return res;
            }else if (req.getEndpoint()==('R2_OnhandBagManagerError')) {
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(421);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags' + 'forward-bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags' + 'bags/search')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "bagRecords":    [ { "recordIdentifier":{ "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68673" } }, "status": "ACTIVE", "names": ["RON"], "initials":          [ "R", "WE", "L" ], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68672" } }, "status": "CLOSED", "names": ["RON"], "initials":          [ "R", "WE", "L" ], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68671" } }, "status": "CLOSED", "names": ["RON"], "initials":          [ "R", "WE", "L" ], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68582" } }, "status": "ACTIVE", "names":          [ "RON", "WEASLY" ], "initials":          [ "R", "W" ], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68580" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68464" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68462" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68424" } }, "status": "SUSPENDED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68409" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68405" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68397" } }, "status": "ACTIVE", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68396" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68395" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68394" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68393" } }, "status": "ACTIVE", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] }, { "recordIdentifier":          { "recordType": "DELAYED", "recordReference":             { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "68392" } }, "status": "CLOSED", "names": ["RON"], "initials": ["A"], "originalBags":          [ { "bagTag": {"tagSequence": "556985"}, "colourCode":                { "colorCode": "WT", "suspended": false, "typeCode": "5" }, "flightDateOrARNK": {"flightDate":                { "airlineCode": "XS", "flightNumber": "413Q", "flightDate": "2017-11-11" }} }, {"flightDateOrARNK": {"flightDate":             { "airlineCode": "IB", "flightNumber": "413S", "flightDate": "2017-11-11" }}} ] } ] }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags' + '/onhand-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"diaryInfo":{"createDate":"2017-07-20T18:24:00Z","tracingDate":"2017-07-20T00:00:00Z","retiredDate":"2017-08-20T00:00:00Z"},"onHandBagGroup":{"onHandBags":{"colourAndType":{"suspended":false,"colourCode":"RD","typeCode":"1","descriptor":{"otherElement":["S","W","X"]}},"itinerary":{"flightSegments":{"flightSegment":[{"flightDate":{"airlineCode":"IB","flightNumber":"1","flightDate":"2016-12-09"}},{"flightDate":{"airlineCode":"IB","flightNumber":"2","flightDate":"2016-12-09"}}]},"routes":{"route":["LHR","ATL"]}}}},"passengers":{},"additionalInfo":{"matchInfo":[{"matchInfoText":"ROH 03OCT17/1311GMT FORWARD OHD MADIB72637 TO MATCHING FILE BCNIB66357 NM STRING/AG STRING SI STRING","seq":"1"}]},"recordHistory":{"history":["OHD  20JUL/1824GMT AG STEPHEN FROM WWS WT BY IB TX AAA00A0","ROH  26JUL/1927GMT /IB AG AGENT WWS BCNIB66357"]},"recordStatus":"OPEN"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                System.debug('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
                res.setBody('{"success":true,"diaryInfo":{"associateRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"87654"}},"createDate":"2017-11-24T20:30:00Z","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"DAMAGED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"ON-HAND","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"RUSH","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}],"claimInvestigationDate":"2017-11-24T00:00:00Z"},"damagedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"1"},{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"2"}],"state":{"stateName":"ARIZONA"},"postalCode":"POSTCODE","country":{"countryCode":"CC"}},"bagWeight":"5/20K","contentsGender":"M","delivery":{"deliveryService":[{"deliveryServiceDesc":"iuytghjkioujhk"}],"deliveryAddress":{"addressLine":[{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"1"},{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"2"}],"state":{"stateName":"ARIZONA"},"postalCode":"TW59BE","country":{"countryCode":"IN"}},"deliveryWeight":"53KG","localDeliveryInfo":[{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"1"},{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"2"}]},"bagPhones":[{"phone":"7708504550","seq":"1"},{"phone":"7708504550","seq":"2"}],"damagedBags":[{"colourAndType":{"suspended":false,"colourCode":"BU","typeCode":"1","descriptor":{"mtrlElement":"D","otherElement":["K","S"]}},"bagTag":{"suspended":false,"licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"313131"},"brandInfo":{"suspended":false,"brandInfo":"CARLTON"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:00+00:00"},"damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]},"bagDetails":"BAG01"},{"colourAndType":{"suspended":false,"colourCode":"BU","typeCode":"1","descriptor":{"mtrlElement":"M","otherElement":["W","B"]}},"bagTag":{"suspended":false,"airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"313131"},"brandInfo":{"suspended":false,"brandInfo":"CARLTON"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:00+00:00"},"damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]},"bagDetails":"BAG01"},{"colourAndType":{"suspended":false,"colourCode":"WT","typeCode":"22","descriptor":{"mtrlElement":"R","otherElement":["H","C"]}},"bagTag":{"suspended":false,"airlineCode":"IB","tagSequence":"313234"},"brandInfo":{"suspended":false,"brandInfo":"VIP"},"damagedTypes":{"damagedType":[{"location":"BOTTOM","type":"05","amount":"MA"},{"location":"TOP","type":"03","amount":"TL"}]},"bagDetails":"BAG02"}],"bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","flightDate":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERSMISSING"],"contentsDamageDesc":"CONTENTSDAMAGE"},"passengers":{"names":[{"name":"OLGA","seq":"1"}],"initials":[{"initial":"OK","seq":"1"}],"title":"MS","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"666PALACEBLVD,LONDONGB","seq":"1"}],"state":{"stateName":"SUSSEX"},"postalCode":"A","country":{"countryCode":"CC"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"3400PENNSYLVANIALN,WASHINGTONOK30339","seq":"1"}],"validityDate":"2018-09-10"},"permanentPhones":[{"phone":"7708504550","seq":"1"}],"cellPhones":[{"phone":"4044319238","seq":"1"}],"temporaryPhones":[{"phone":"4044319238","seq":"1"}],"emails":[{"email":"TEST_MAIL@GMAIL.COM","seq":"1"}],"country":{"countryCode":"CC"},"zipCode":"A"},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","numberOfPassengers":"2","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","flightDate":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","flightDate":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTicketNumber":"POOLTKT","fareBasis":"F","givenName":"TEST"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"FREEMISCONE","seq":"2"},{"miscInfoText":"FREEMISCONE","seq":"2"}],"furtherInfo":"FURTHERINFO","supplementaryInfo":[{"supplimentInfoText":"FREESUPPINFOONE","seq":"2"},{"supplimentInfoText":"FREESUPPINFOONE","seq":"2"}],"customsInfo":"CUSTOMSINFO"},"claim":{"claimData":{"claimAmount":{"amount":{"amount":5000,"currencyCodeValue":"USD"}},"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":35,"currencyCodeValue":"USD"}}]},"claimDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","insuranceIndicator":false,"liabilityTagIndicator":false,"partnerCode":{"carrierCode":"BAB"},"lossComments":"RLCOMMENTS","lossReasonCode":"91","replacementBagIndicator":true,"repairBagIndicator":false}},"designatedLocator":"1234","recordHistory":{"history":["DPR24NOV/2030GMTAGAGENTFROMWWSWMBYIB","CDC24NOV/2030GMT/IBMATCHING-NONEAGSITAFROMAUTOFEED"]},"recordStatus":"OPEN"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags2' + '/damaged-bags')) {
                HTTPResponse res = new HTTPResponse();
                SYstem.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
                res.setBody('{"success":true,"diaryInfo":{"associateRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"87654"}},"createDate":"2017-11-24T20:30:00Z","crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"DAMAGED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"ON-HAND","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}},{"recordType":"RUSH","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"67874"}}],"claimInvestigationDate":"2017-11-24T00:00:00Z"},"damagedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"1"},{"addressLineDesc":"2127ELMOAVE,POUGHKEEPSIEVA30335","seq":"2"}],"state":{"stateName":"ARIZONA"},"postalCode":"POSTCODE","country":{"countryCode":"CC"}},"bagWeight":"5/20K","contentsGender":"M","delivery":{"deliveryService":[{"deliveryServiceDesc":"iuytghjkioujhk"}],"deliveryAddress":{"addressLine":[{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"1"},{"addressLineDesc":"3420HIGHSTREET,DAYTONOH45202","seq":"2"}],"state":{"stateName":"ARIZONA"},"postalCode":"TW59BE","country":{"countryCode":"IN"}},"deliveryWeight":"53KG","localDeliveryInfo":[{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"1"},{"dlvInfo":"DELIVERDURINGTHEAFTERNOONBETWEEN2-4PM","seq":"2"}]},"bagPhones":[{"phone":"7708504550","seq":"1"},{"phone":"7708504550","seq":"2"}],"damagedBags":[{"colourAndType":{"suspended":false,"colourCode":"BU","typeCode":"1","descriptor":{"mtrlElement":"D","otherElement":["K","S"]}},"bagTag":{"suspended":false,"licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"313131"},"brandInfo":{"suspended":false,"brandInfo":"CARLTON"},"bagDelivery":{"status":{"outForDelivery":"987","delivered":"9876","trackingUpdate":"poiu","unableToDeliver":"poiu"},"bagReceived":{"rDate":"2018-02-27","station":"MAD"},"deliveredTime":"2017-09-10T00:18:00+00:00"},"itinerary":{"newFlightSegments":{"flightSegment":[{"arnk":{"originDestination":{"origin":"MAD","destination":"JFK"}},"flightDate":{"airlinecode":"IB","flightNumber":"6785","flightDate":"2018-02-27"}}]},"flightSegments":{"flightSegment":[{"flightDate":{"airlinecode":"IB","flightNumber":"3421","flightDate":"2018-02-27"},"arnk":{"originDestination":{"origin":"MAD","destination":"JFK"}}}]}},"damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]},"bagDetails":"BAG01"},{"colourAndType":{"suspended":false,"colourCode":"BU","typeCode":"1","descriptor":{"mtrlElement":"M","otherElement":["W","B"]}},"rushTag":{"suspended":false,"airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"131"},"bagTag":{"suspended":false,"airlineCode":"ON","licenseNumber":{"issuerCode":"123","tagType":"2"},"tagSequence":"313131"},"brandInfo":{"suspended":false,"brandInfo":"CARLTON"},"bagDelivery":{"deliveredTime":"2017-09-10T00:18:00+00:00"},"damagedTypes":{"damagedType":[{"location":"SIDE","type":"04","amount":"MA"},{"location":"TOP","type":"01","amount":"MI"}]},"bagDetails":"BAG01"}],"bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"23","flightDate":"2017-09-10"}}]},"excessBaggage":"EXCESSTICKET","missingWeight":"1KG","lostContents":["TROUSERSMISSING"],"contentsDamageDesc":"CONTENTSDAMAGE"},"passengers":{"names":[{"name":"OLGA","seq":"1"},{"name":"OLGA","seq":"1"},{"name":"OLGA","seq":"1"}],"initials":[{"initial":"OK","seq":"1"},{"initial":"OK","seq":"1"},{"initial":"OK","seq":"1"}],"title":"MS","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"666PALACEBLVD,LONDONGB","seq":"1"}],"state":{"stateName":"SUSSEX"},"postalCode":"A","country":{"countryCode":"CC"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"3400PENNSYLVANIALN,WASHINGTONOK30339","seq":"1"},{"addressLineDesc":"3400PENNSYLVANIALN,WASHINGTONOK30339","seq":"2"}],"validityDate":"2018-09-10"},"permanentPhones":[{"phone":"7708504550","seq":"1"},{"phone":"7708504550","seq":"1"}],"cellPhones":[{"phone":"4044319238","seq":"1"},{"phone":"4044319238","seq":"1"}],"temporaryPhones":[{"phone":"4044319238","seq":"1"},{"phone":"4044319238","seq":"1"}],"emails":[{"email":"TEST_MAIL@GMAIL.COM","seq":"1"},{"email":"TEST_MAIL@GMAIL.COM","seq":"1"}],"country":{"countryCode":"CC"},"zipCode":"A"},"language":"ENGLISH","ticketNumber":"XS1234567","pnr":"YW8CD","numberOfPassengers":"2","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"89","flightDate":"2017-10-09"},"originDestination":{"origin":"ATL","destination":"TPA"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"98","flightDate":"2017-10-09"},"originDestination":{"origin":"TPA","destination":"RSW"}}}],"additionalRoutes":["VPS","PNS","SRQ","FLL"]},"status":"F","pooledTicketNumber":"POOLTKT","fareBasis":"F","givenName":"TEST"},"additionalInfo":{"matchInfo":[{"matchInfoText":"wert","seq":"1"}],"messageInfo":[{"messageInfoText":"were","seq":"1"}],"deliveryInfo":[{"deliveryInfoText":"wertyr","seq":"1"}],"userComments":[{"commentsText":"wertyr","seq":"1"}],"miscellaneousInfo":[{"miscInfoText":"FREEMISCONE","seq":"2"},{"miscInfoText":"FREEMISCONE","seq":"2"}],"furtherInfo":"FURTHERINFO","supplementaryInfo":[{"supplimentInfoText":"FREESUPPINFOONE","seq":"2"},{"supplimentInfoText":"FREESUPPINFOONE","seq":"2"}],"customsInfo":"CUSTOMSINFO"},"claim":{"claimData":{"claimAmount":{"amount":{"amount":5000,"currencyCodeValue":"USD"}},"passengerPayments":{"passengerPaymentsValue":[{"costType":"F","amount":{"amount":35,"currencyCodeValue":"USD"}}]},"claimDate":"2017-09-10","questionnaireDate":"2017-09-10","faultStationCode":"ATL","faultTerminal":"CQ","insuranceIndicator":false,"liabilityTagIndicator":false,"partnerCode":{"carrierCode":"BAB"},"lossComments":"RLCOMMENTS","lossReasonCode":"91","replacementBagIndicator":true,"repairBagIndicator":false}},"designatedLocator":"1234","recordHistory":{"history":["DPR24NOV/2030GMTAGAGENTFROMWWSWMBYIB","CDC24NOV/2030GMT/IBMATCHING-NONEAGSITAFROMAUTOFEED"]},"recordStatus":"OPEN"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_SearchBags/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{ "success": true, "diaryInfo":    { "createDate": "2017-11-24T20:30:00Z", "crossReferenceRecord": [      { "recordType": "DELAYED", "recordReference":          { "stationCode": "MAD", "airlineCode": "IB", "referenceNumber": "67874" } }], "claimInvestigationDate": "2017-11-24T00:00:00Z" }, "damagedBagGroup":    { "bagAddress":       { "addressLine": [         { "addressLineDesc": "2127 ELMO AVE, POUGHKEEPSIE VA 30335", "seq": "1" }], "state": {"stateName": "ARIZONA"}, "postalCode": "POSTCODE", "country": {"countryCode": "CC"} }, "bagWeight": "5/20K", "contentsGender": "M", "delivery":       { "deliveryAddress":          { "addressLine": [            { "addressLineDesc": "3420 HIGH STREET, DAYTON OH 45202", "seq": "1" }], "state": {"stateName": "ARIZONA"}, "postalCode": "TW59BE", "country": {"countryCode": "IN"} }, "deliveryWeight": "53KG", "localDeliveryInfo": [         { "dlvInfo": "DELIVER DURING THE AFTERNOON BETWEEN 2-4 PM", "seq": "1" }] }, "bagPhones": [      { "phone": "770 850 4550", "seq": "1" }], "damagedBags":       [ { "colourAndType":             { "suspended": false, "colourCode": "BU", "typeCode": "1", "descriptor":                { "materialElement": "X", "otherElement":                   [ "X", "X" ] } }, "bagTag":             { "suspended": false, "airlineCode": "ON", "licenseNumber":                { "issuerCode": "123", "tagType": "2" }, "tagSequence": "313131" }, "brandInfo":             { "suspended": false, "brandInfo": "CARLTON" }, "bagDelivery": {"deliveredTime": "2017-09-10T00:18:00+00:00"}, "damagedTypes": {"damagedType":             [ { "location": "SIDE", "type": "04", "amount": "MA" }, { "location": "TOP", "type": "01", "amount": "MI" } ]}, "bagDetails": "BAG01" }, { "colourAndType":             { "suspended": false, "colourCode": "WT", "typeCode": "1", "descriptor":                { "materialElement": "X", "otherElement":                   [ "X", "X" ] } }, "bagTag":             { "suspended": false, "airlineCode": "IB", "tagSequence": "313234" }, "brandInfo":             { "suspended": false, "brandInfo": "VIP" }, "damagedTypes": {"damagedType":             [ { "location": "BOTTOM", "type": "05", "amount": "MA" }, { "location": "TOP", "type": "03", "amount": "TL" } ]}, "bagDetails": "BAG02" } ], "bagItinerary": {"flightDateOrARNK": [{"flightDate":       { "airlineCode": "IB", "flightNumber": "0023", "flightDate": "2017-09-10" }}]}, "excessBaggage": "EXCESSTICKET", "missingWeight": "1KG", "lostContents": ["TROUSERS MISSING"], "contentsDamageDesc": "CONTENTS DAMAGE" }, "passengers":    { "names": [      { "name": "OLGA", "seq": "1" }], "initials": [      { "initial": "OK", "seq": "1" }], "title": "MS", "contactInfo":       { "permanentAddress":          { "addressLine": [            { "addressLineDesc": "666 PALACE BLVD, LONDON GB", "seq": "1" }], "state": {"stateName": "SUSSEX"}, "postalCode": "A", "country": {"countryCode": "CC"} }, "temporaryAddress":          { "addressLine": [            { "addressLineDesc": "3400 PENNSYLVANIA LN, WASHINGTON OK 30339", "seq": "1" }], "validityDate": "2018-09-10" }, "permanentPhones": [         { "phone": "770 850 4550", "seq": "1" }], "cellPhones": [         { "phone": "404 431 9238", "seq": "1" }], "temporaryPhones": [         { "phone": "404 431 9238", "seq": "1" }], "emails": [         { "email": "TEST_MAIL@GMAIL.COM", "seq": "1" }], "country": {"countryCode": "CC"}, "zipCode": "A" }, "language": "ENGLISH", "ticketNumber": "XS1234567", "pnr": "YW8CD", "numberOfPassengers": "2", "itinerary":       { "flightSegmentsorARNK":          [ {"flightAmend":             { "flightAndDate":                { "airlineCode": "IB", "flightNumber": "0089", "flightDate": "2017-10-09" }, "originDestination":                { "origin": "ATL", "destination": "TPA" } }}, {"flightAmend":             { "flightAndDate":                { "airlineCode": "IB", "flightNumber": "0098", "flightDate": "2017-10-09" }, "originDestination":                { "origin": "TPA", "destination": "RSW" } }} ], "additionalRoutes":          [ "VPS", "PNS", "SRQ", "FLL" ] }, "status": "F", "pooledTicketNumber": "POOLTKT", "fareBasis": "F", "givenName": "TEST" }, "additionalInfo":    { "miscellaneousInfo":       [ { "miscInfoText": "FREE MISC ONE", "seq": "2" }, { "miscInfoText": "FREE MISC ONE", "seq": "2" } ], "furtherInfo": "FURTHER INFO", "supplementaryInfo":       [ { "supplimentInfoText": "FREE SUPP INFO ONE", "seq": "2" }, { "supplimentInfoText": "FREE SUPP INFO ONE", "seq": "2" } ], "customsInfo": "CUSTOMS INFO" }, "claim": {"claimData":    { "claimAmount": {"amount":       { "amount": 5000, "currencyCodeValue": "USD" }}, "passengerPayments": {"passengerPaymentsValue": [      { "costType": "F", "amount":          { "amount": 35, "currencyCodeValue": "USD" } }]}, "claimDate": "2017-09-10", "questionnaireDate": "2017-09-10", "faultStationCode": "ATL", "faultTerminal": "CQ", "insuranceIndicator": false, "liabilityTagIndicator": false, "partnerCode": {"carrierCode": "BAB"}, "lossComments": "RL COMMENTS", "lossReasonCode": "91", "replacementBagIndicator": true, "repairBagIndicator": false }}, "designatedLocator": "1234", "recordHistory": {"history":    [ "DPR  24NOV/2030GMT AG AGENT FROM WWS WM BY IB", "CDC  24NOV/2030GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED" ],"matchHistory":       [ "1   MCH  18JAN/1110 OHD BCNIB71429   TAG MATCH", "2   MCH  18JAN/1110 OHD MADIB73418   TAG MATCH", "3   MCH  18JAN/1115 OHD MADIB73419   TAG MATCH", "4   MCH  18JAN/1115 OHD MADIB73420   TAG MATCH", "5   MCH  18JAN/1118 OHD MADIB73419   - 70 TN/CT/FD/BI", "6   MCH  18JAN/1118 OHD MADIB73418   - 72 TN/CT/FD/BI", "7   MCH  18JAN/1118 OHD BCNIB71429   - 72 TN/CT/FD/BI", "8   MCH  18JAN/1118 OHD MADIB73420   - 70 TN/CT/FD/BI", "9   MCH  08FEB/1436 OHD BCNIB71429   - 72 TN/CT/FD/BI", "10  MCH  08FEB/1436 OHD MADIB73418   - 72 TN/CT/FD/BI", "11  MCH  08FEB/1436 OHD MADIB73419   - 70 TN/CT/FD/BI"]}, "recordStatus": "OPEN" }');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('readRecord_AHL_DAH/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"diaryInfo":{"createDate":"2018-01-17T11:26:00Z","tracingDate":"2018-01-17T00:00:00Z","closeDate":"2018-01-24T10:19:00Z","associateRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"66523"}},"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"98711"}}],"claimInvestigationDate":"2018-01-17T00:00:00Z"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ES"},"postalCode":"BZ","country":{"countryCode":"BN"}},"bagWeight":"10","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"BN"},"postalCode":"BZ","country":{"countryCode":"BN"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"1"}]},"bagPhones":[{"phone":"84385361559440122333","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":false,"colourCode":"WT","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":false,"airlineCode":"IB","tagSequence":"556985"},"brandInfo":{"suspended":false,"brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T09:05:00Z","station":"MAD"},"deliveredTime":"2017-09-19T09:05:00+00:00"},"lockCode":"LOCK12","uniqueId":{"suspended":false,"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:00Z","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"},{"category":"CAMISA","description":"AZUL"},{"category":"IPAD","description":"IPAD AIR BLANCO"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":false,"missingWeight":"3","matchWindow":"2"},"passengers":{"names":[{"name":"HERMIONE","seq":"1"}],"initials":[{"initial":"A","seq":"1"}],"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"CO"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"CO"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"},{"email":"CMNEMAIL@MAIL.COM","seq":"2"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"CO"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"XS","flightNumber":"413Q","flightDate":"2017-11-11"},"originDestination":{"origin":"LHR","destination":"MAA"}}},{"arnk":{"originDestination":{"origin":"MAA","destination":"MAA"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"413S","flightDate":"2017-11-11"},"originDestination":{"origin":"MAA","destination":"MAD"}}}]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"furtherInfo":"UPDATE FURTHER","supplementaryInfo":[{"supplimentInfoText":"UPDATE SUPPL","seq":"1"}],"customsInfo":"UPDATE CUSTOM"},"claim":{"claimData":{"claimAmount":{"amount":{"amount":9500,"currencyCodeValue":"GBP"}},"costRemarks":["CMN:COSTREMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}},{"costType":"A","amount":{"amount":1000,"currencyCodeValue":"GBP"}}]},"claimDate":"2017-03-14","notifiedDate":"2017-03-14","questionnaireDate":"2017-03-14","faultStationCode":"XXX","insuranceIndicator":false,"liabilityTagIndicator":false,"missingBags":"10","partnerCode":{"none":true},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"0","toiletKitsFemale":"2","excessValue":{"amount":200,"currencyCodeValue":"USD"}}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"YES","recordHistory":{"history":["AHL  17JAN/1126GMT AG N433081 FROM WWS WM BY IB TX ABCA9A9","CAC  17JAN/1126GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED","CFI  24JAN/1019GMT /IB AG 1234567","RIB  24JAN/1019GMT AG 1234567 AR BCNIB66519 BY IB","RIB  24JAN/1019GMT AG 1234567 AR BCNIB66520 BY IB","RIB  24JAN/1321GMT AG JASCA AR BCNIB66521 BY IB","RIB  24JAN/1434GMT AG 1234567 AR BCNIB66522 BY IB","RIB  24JAN/1436GMT AG 1234567 AR BCNIB66523 BY IB"]},"recordStatus":"CLOSED"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('ReadRecord_AHL/delayed-bags')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"diaryInfo":{"createDate":"2017-11-29T12:30:00Z","closeDate":"2017-11-30T16:07:00Z","associateRecord":{"recordType":"DELAYED","recordReference":{"stationCode":"BCN","airlineCode":"IB","referenceNumber":"66488"}},"crossReferenceRecord":[{"recordType":"DELAYED","recordReference":{"stationCode":"MAD","airlineCode":"IB","referenceNumber":"98711"}}],"claimInvestigationDate":"2017-11-29T00:00:00Z"},"delayedBagGroup":{"bagAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINE","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"BZ"}},"bagWeight":"10","contentsGender":"M","delivery":{"deliveryAddress":{"addressLine":[{"addressLineDesc":"ADDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"BN"},"country":{"countryCode":"BZ"}},"deliveryWeight":"20","localDeliveryInfo":[{"dlvInfo":"CMN:DIVINFO","seq":"1"}]},"bagPhones":[{"phone":"84385361559440122333","seq":"1"}],"delayedBags":[{"colourAndType":{"suspended":false,"colourCode":"WT","typeCode":"5","descriptor":{"otherElement":["B","W","X"]}},"bagTag":{"suspended":false,"airlineCode":"IB","tagSequence":"556985"},"brandInfo":{"suspended":false,"brandInfo":"MNA"},"bagDelivery":{"bagReceived":{"date":"2017-09-12T09:05:00Z","station":"MAD"},"deliveredTime":"2017-09-19T09:05:00+00:00"},"lockCode":"LOCK12","uniqueId":{"suspended":false,"uniqueId":"2556-5698-4152"},"bagSentToCustoms":{"bagDate":"2017-09-12T09:05:00Z","timeZone":"GMT"},"bagReceivedFromCustoms":{"bagDate":"2017-09-12T09:05:00Z","timeZone":"GMT"},"storageLocation":"CMN:STORAGELOCATION","bagContents":{"suspended":false,"content":[{"category":"ALCOHOL","description":"CMN:DESCRIPTION"},{"category":"CAMISA","description":"AZUL"},{"category":"IPAD","description":"IPAD AIR BLANCO"}]},"contentsDesc":"CMN:CONTENTDESCRIPTION","bagDetails":"CMN:BAGDETAILS","remarks":{"remark":["CMN:REMARKS"]}}],"bagLastSeen":"LHR","bagItinerary":{"flightDateOrARNK":[{"flightDate":{"airlineCode":"IB","flightNumber":"3170","flightDate":"2017-09-12"}}]},"excessBaggage":"EXCESSBAGGAGE","bagTagDestinations":{"station":[{"stationValue":"MAD"}]},"keysCollected":false,"missingWeight":"3","matchWindow":"2"},"passengers":{"names":[{"name":"RON","seq":"1"}],"initials":[{"initial":"R","seq":"1"}],"title":"CMN:TITLE","contactInfo":{"permanentAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ES"},"country":{"countryCode":"CO"}},"temporaryAddress":{"addressLine":[{"addressLineDesc":"DDRESSLINEDESC","seq":"1"}],"state":{"stateCode":"ST"},"country":{"countryCode":"CO"}},"permanentPhones":[{"phone":"1234567890","seq":"1"}],"cellPhones":[{"phone":"1234567890","seq":"1"}],"temporaryPhones":[{"phone":"1234567890","seq":"1"}],"emails":[{"email":"CMNEMAIL@MAIL.COM","seq":"1"},{"email":"CMNEMAIL@MAIL.COM","seq":"2"}],"faxes":[{"fax":"CMN:FAX","seq":"1"}],"country":{"countryCode":"CO"}},"frequentFlyerId":"XS123345678","language":"ENGLISH","ticketNumber":"1256984","pnr":"58624","numberOfPassengers":"2","autoMessageOption":"NO_MESSAGE","passportInfo":"CMN:PASSPORTINFO","itinerary":{"flightSegmentsorARNK":[{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"0123","flightDate":"2017-12-12"},"originDestination":{"origin":"MAD","destination":"BAR"}}},{"flightAmend":{"flightAndDate":{"airlineCode":"IB","flightNumber":"0432","flightDate":"2017-12-24"},"originDestination":{"origin":"BAR","destination":"LHR"}}}],"additionalRoutes":["DSA","LOP"]},"status":"CMN:STATUS","pooledTicketNumber":"TICKETNUMBER","fareBasis":"BASIS"},"additionalInfo":{"miscellaneousInfo":[{"miscInfoText":"UPDATE MISCL","seq":"1"}],"furtherInfo":"UPDATE FURTHER2","supplementaryInfo":[{"supplimentInfoText":"UPDATE SUPPL2","seq":"1"},{"supplimentInfoText":"TEST","seq":"2"}],"customsInfo":"UPDATE CUSTOM"},"claim":{"claimData":{"claimAmount":{"amount":{"amount":9500,"currencyCodeValue":"GBP"}},"costRemarks":["CMN:COSTREMARKS"],"passengerPayments":{"passengerPaymentsValue":[{"costType":"A","amount":{"amount":2500,"currencyCodeValue":"GBP"}},{"costType":"A","amount":{"amount":1000,"currencyCodeValue":"GBP"}}]},"claimDate":"2017-03-14","notifiedDate":"2017-03-14","questionnaireDate":"2017-03-14","faultStationCode":"XXX","insuranceIndicator":false,"liabilityTagIndicator":false,"missingBags":"10","partnerCode":{"none":true},"lossComments":"CMN:LOSSCOMMENTS","lossReasonCode":"10","toiletKitsFemale":"2","excessValue":{"amount":200,"currencyCodeValue":"USD"}}},"designatedLocator":"AMDI","handledAirlineCopyIndicator":"FULL","recordHistory":{"history":["AHL  29NOV/1230GMT AG N433081 FROM WWS WM BY IB TX ABCA9A9","CAC  29NOV/1230GMT /IB MATCHING-NONE AG SITA  FROM AUTOFEED","CFI  30NOV/1607GMT /IB AG 1234","RIB  30NOV/1607GMT AG 1234 AR BCNIB66488 BY IB","AAH  08JAN/1506GMT /IB AG AGENTID WWS ELEMENTS\n     RL01 00/HC01/IN01/LT01/IT01 A/","AAH  08JAN/1507GMT /IB AG AGENTID WWS ELEMENTS HC01/","AAH  08JAN/1508GMT /IB AG AGENTID WWS ELEMENTS\n     HC01/FI01/SI02/SI01/","AAH  08JAN/1649GMT /IB AG AGENTID WWS ELEMENTS HC01/\n     FD01 XS413Q/11NOV/ARNK/IB413S/11NOV/RT01 LHR/MAA/MAA/MAD/"]},"recordStatus":"CLOSED"}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_StationBags' + 'messages/inbox') && req.getMethod()== 'POST') {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_StationBags' + 'messages/inbox') && req.getMethod()== 'PUT') {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success":true,"messages":{"messageCount":11,"messages":[{"date":"2017-11-12","sequenceNumber":1,"message":"      AHL MADIB68179 08NOV17 -UPDATE OR CLOSE"},{"date":"2017-11-12","sequenceNumber":2,"message":"      AHL MADIB68186 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":3,"message":"      AHL MADIB68187 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":4,"message":"      AHL MADIB68188 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":5,"message":"      AHL MADIB68189 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":6,"message":"      AHL MADIB68180 08NOV17 -UPDATE OR CLOSE"},{"date":"2017-11-12","sequenceNumber":7,"message":"      AHL MADIB68181 08NOV17 -UPDATE OR CLOSE"},{"date":"2017-11-12","sequenceNumber":8,"message":"      AHL MADIB68191 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":9,"message":"      AHL MADIB68192 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":10,"message":"      AHL MADIB68193 10NOV17 -UPDATE NON-TRACING FILE"},{"date":"2017-11-12","sequenceNumber":11,"message":"      AHL MADIB68194 10NOV17 -UPDATE NON-TRACING FILE"}]}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_StationBags' + 'messages/teletype')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_StationBags' + 'stations/screen')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true,"stationConfig":    {"handler": {"current": "IB"},"participancy":       [{"module": "WT","status": "A","access": true},{"module": "WM","status": "A","access": true},{"module": "WI","status": "A","access": true}],"defaultAddress": {"tty": "MADLLIB"},"matchDlvryAttribs":       [{"seq": 1,"stationCode": "HDQ","airlineCode": "IB","days": "5"},{"seq": 2,"stationCode": "HDQ","airlineCode": "IB","days": "5"},{"seq": 3,"stationCode": "HDQ","airlineCode": "IB","days": "5"},{"seq": 4,"stationCode": "HDQ","airlineCode": "IB","days": "5"},{"seq": 5,"stationCode": "HDQ","airlineCode": "IB"}],"options":       {"sitaref": true,"lzcontrolled": false},"stationConfigAttributes":       {"stationCode": "MAD","airlineCode": "IB","updateDate": "2007-01-04"}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_StationBags' + 'stations/list/')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": true,"stations": {"stationProperty":    [{"stationPropertyDescription": "ACTIVE WORLDTRACER MANAGEMENT STATIONS FOR USER IB","stationPropertySubType":          [{"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value":                ["ABJ","AGP","BCN","BIL","BIO","CCS","FLL","FRA","HDQ","JFK","JNB","MAD","MIA","PLZ","PMI","PNA","PNS","POP","SCL","SCQ","SVQ","TFN","UNK"]}},{"stationPropertySubTypeDescription": "TYPE B ACCESS - TTY","values": {"value":                ["SDR","ZRH"]}}]},{"stationPropertyDescription": "ACTIVE HANDLING FACILITIES FOR USER IB / 6 STATIONSIB","stationPropertySubType":          [{"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value":                ["ABQCO","ATLUX","HELAY","LHRBA","SEALI","STN04"]}},{"stationPropertySubTypeDescription": "TYPE B ACCESS - TTY","values": {"value": ["NO CURRENT STATIONS"]}}]},{"stationPropertyDescription": "INACTIVE WORLDTRACER MANAGEMENT STATIONS FOR USER IB","stationPropertySubType":          [{"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value": ["NO CURRENT STATIONS"]}},{"stationPropertySubTypeDescription": "TYPE B ACCESS - TTY","values": {"value": ["NO CURRENT STATIONS"]}}]},{"stationPropertyDescription": "CALL CENTER/LZ HANDLER FOR MEMBER  IB:","stationPropertySubType":          [{"stationPropertySubTypeDescription": "CALL CENTER","values": {"value": ["NONE"]}},{"stationPropertySubTypeDescription": "LZ HANDLER","values": {"value": ["NONE"]}}]},{"stationPropertyDescription": "ACTIVE WORLDTRACER MANAGEMENT STATIONS WITH CODE SHARE EXCEPTION","stationPropertySubType": [         {"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value": ["NO CURRENT STATIONS"]}}]},{"stationPropertyDescription": "ACTIVE CLAIMS INVESTIGATION STATIONS","stationPropertySubType":          [{"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value":                ["ABJ","ABQCO","AGP","ATLUX","BCN","BIL","BIO","CCS","FLL","HDQ","HELAY","JFK","JNB","LHRBA","MAD","MIA","PLZ","PMI","PNA","PNS","POP","SCQ","SEALI","STN04","SVQ","TFN"]}},{"stationPropertySubTypeDescription": "TYPE B ACCESS - TTY","values": {"value":                ["SDR","ZRH"]}}]},{"stationPropertyDescription": "TRAINING WORLDTRACER MANAGEMENT STATIONS FOR USER IB","stationPropertySubType":          [{"stationPropertySubTypeDescription": "TYPE A ACCESS - CRT","values": {"value":                ["XAD","XRD","XTS"]}},{"stationPropertySubTypeDescription": "TYPE B ACCESS - TTY","values": {"value": ["NO CURRENT STATIONS"]}}]      }]}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_ReadTelex')) { //success
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"header":{"start":"ZCZC","serial":"001","dateTime":"03061241"},"telexMessages":[{"destination":"QD MADLCIB","origin":"MADXCIB 270922FEB18/AGNT23446/PID21482","messageText":"PRUEBA1"},{"destination":"QD MADLCIB","origin":"MADXCIB 270922FEB18/AGNT23446/PID21482","messageText":"PRUEBA1"}]}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_ReadTelex_Emtpy')) { //wrong, body is empty
                HTTPResponse res = new HTTPResponse();
                res.setStatusCode(204);
                return res;
            }else if (req.getEndpoint()==('R2_IberiaComBonosOkResponse')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"bonus":{"id":"12345","commercialCode":"8FPacjK9q","campaignID":"241","maximumPermittedUse":"99999999","discountPercentage":"true","discountType":"1","discountValue":"17.0","reservationRedeemabilityIndicator":"false","campaignCommercialCode":"SALESFORCE3","allowUnselectedOperators":"false","validity":{"startDateTime":"2018-01-01 00:12:01","endDateTime":"2018-06-01 23:19:59"},"logInUserRequiredIndicator":"false","sundayRuleApplicabilityIndicator":"false","amountconsumed":"0.0","bonusUsageCount":"0","returnDays":{"dayCode":["L","M"]},"departureDays":{"dayCode":["L","X"]}}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('R2_IberiaComBonosErrorResponse')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"error":{"errorCode":"00010013","errorDescription":"No se ha localizado la campaña solicitada"}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('QueryVoucherPostiveResponse'+'12345') && req.getMethod()== 'GET') {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"bonus":{"id":"12345","commercialCode":"testXXXXX","campaignID":"123","maximumPermittedUse":"1","discountConcept":{"conceptCode":["TI"]},"discountPercentage":"false","discountType":"0","discountValue":"300.0","currency":"CLP","reservationRedeemabilityIndicator":"true","campaignCommercialCode":"ARGENTINA","allowUnselectedOperators":"false","logInUserRequiredIndicator":"false","sundayRuleApplicabilityIndicator":"false","amountconsumed":"0.0","bonusUsageCount":"0"}}');
                res.setStatusCode(200);
                return res;
            }else if (req.getEndpoint()==('CancelVoucherConsumptionWebPositiveResponse'+'12345'+'/cancelconsumption')) {
                HTTPResponse res = new HTTPResponse();
                res.setBody('{"success": "true"}');
                res.setStatusCode(200);
                return res;
            }else {
                HTTPResponse res = new HTTPResponse();
                res.setBody('');
                system.debug(req.getEndpoint());
                return res;
            }
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to generate string of a programable date

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    09/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String generateStrProg(Datetime dt_job){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String StrProg = dt_job.second() + ' ' + dt_job.minute() + ' ' + dt_job.hour() + ' ' + dt_job.day() + ' ' +dt_job.month() + ' ? ' + dt_job.year();
            return StrProg;

        }catch (exception Exc){
            return null;
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to encrypt and put in cache

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    18/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static void putCache(String key, String value){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            //encriptacion del data
            //Encriptacion mediante metodo AES128
            Blob cryptoKey = Blob.valueOf('380db410e8b11fa9');
            Blob data = Blob.valueOf(value);
            System.debug('data: '+ data);
            Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey , data);

            //Encriptacion Base64
            String b64Data = EncodingUtil.base64Encode(encryptedData);
            System.debug('b64Data: '+b64Data);

            //introducir valor en cache de sesion, este valor estara en cache durante 900 segundos
            Cache.Org.put(key, b64Data, 900);

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.putCache()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to get from cache and decrypt

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    18/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static String getCache(String key){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            //obtener data de cache
            String token = (String)Cache.Org.get(key);

            if (token != null) {
                //Desencriptacion Base64
                Blob data = EncodingUtil.base64Decode(token);

                //Desencriptacion mediante metodo AES128
                Blob cryptoKey = Blob.valueOf('380db410e8b11fa9');
                Blob decryptedData = Crypto.decryptWithManagedIV('AES128', cryptoKey , data);
                System.debug('Desencriptado : ' + decryptedData.toString());

                return decryptedData.toString();
            }

        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.getCache()', '', exc.getmessage()+', '+exc.getLineNumber(), '');

        }

        return null;
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro García
    Company:        Accenture
    Description:    Method to create a set of a split text

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    18/05/2017                 Alvaro García            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    public static Set<String> splitText (String text) {

        Set<String> set_text = new set<String>();
        if (text != null) {
            for (String txt : text.split(';')) {
                set_text.add(txt);
            }
        }
        return set_text;
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo generico que envia emails a usuarios pasando los emails como lista de strings por parametro

    IN:
    OUT:

    History:
    <Date>                     <Author>                <Change Description>
    16/05/2017            Ruben Pingarron Jerez            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    /*
    //enviar email, parametros lista correos/usuarios y subject (integer)
    public static void enviarEmail(List<User> lstDestinatarios, Integer condicion) {
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            Integer contador = 0;


            List<String> lstCorreos = new List<String>();
            for(User destinatario : lstDestinatarios){
                lstCorreos.add(destinatario.Email);
            }
            // Crea la cantidad de emails igual a la cantidad de destinatarios
            Messaging.SingleEmailMessage[] mailsToSend = new Messaging.SingleEmailMessage[lstDestinatarios.size()];

            for(String correo : lstCorreos){

                // Se crea un email para cada destinatario
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {correo};
                // Añadimos el destinatario al email
                mail.setToAddresses(toAddresses);

                // Segun la condicion se envia un email u otro
                if(condicion == 1){
                    mail.setSubject('Error en proceso de duplicacion');
                    mail.setPlainTextBody('');
                }else{
                    mail.setSubject('Titulo correo generico');
                    mail.setPlainTextBody('Cuerpo del email');
                }

                // El nombre del que envia el email saldra Salesforce Support
                mail.setSenderDisplayName('Salesforce Support');
                mail.setBccSender(false);
                mail.setUseSignature(false);
                mailsToSend[contador] = mail;
                contador++;
            }
            // Realizamos el envio de los emails
            Messaging.sendEmail(mailsToSend);
        }catch(Exception exc){

            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.enviarEmail()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }
    } */

    /*--------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: Helper: Create Basic Account
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    06/03/2018            Alberto Puerto Collado         Added account fields to follow the Validation Rule named R1_ACC_VRU_Account_create
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Account helper_Account_constructor(){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            Account acc = new Account();
            acc.RecordTypeId = recordTypeId;
            acc.LastName = 'ClienteTest';
            acc.PersonEmail = 'test@test.com';
            acc.R1_ACC_PKL_Gender_description__c = 'M';
            acc.R1_ACC_PKL_identification_Type__c = '02';
            acc.R1_ACC_TXT_Identification_number__c = '123456789';
            acc.PersonBirthdate = Date.valueOf('1982-11-16');
            acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
            acc.R1_ACC_TLF_Phone_Operative__c   = '123123123';
            acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '1234567';
            acc.R1_ACC_EMA_Marketing_Email__c  = 'testmkt@mkt.es';
            acc.R1_ACC_EMA_Email_Operative__c  = 'operative@test.es';

            return acc;
        }catch(Exception exc){
            System.debug(exc.getmessage()+', '+exc.getLineNumber());
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Account_constructor()', 'Error account constructor()', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    /*--------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: Helper: Create Basic Account(String personalizado) - overloaded
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Account helper_Account_constructor(String auxiliar){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            Account acc = new Account();
            acc.RecordTypeId = recordTypeId;
            acc.LastName = 'ClienteTest'+auxiliar;
            acc.PersonEmail = 'test'+auxiliar+'@test.com';
            acc.R1_ACC_PKL_Gender_description__c = 'M';
            acc.R1_ACC_TLF_Phone_Marketing__c = '123456789'+auxiliar;
            acc.R1_ACC_PKL_identification_Type__c = '02';
            acc.R1_ACC_TXT_Identification_number__c = '123456789'+auxiliar;

            return acc;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Account_constructor()', 'Error account constructor(aux)', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: Helper: Create Basic Flight
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R1_Flight__c helper_Flight_constructor(){
            try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            R1_Flight__c vuelo = new R1_Flight__c();
            vuelo.Name = 'VueloTest';
            vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest';
            vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest';
            vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
            vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
            vuelo.R1_FLG_TXT_Flight_number__c = 'NumTest';

            return vuelo;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Flight_constructor()', 'Error flight constructor()', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: Helper: Create Basic Flight (String personalizado) - overloaded
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R1_Flight__c helper_Flight_constructor(String auxiliar){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            R1_Flight__c vuelo = new R1_Flight__c();
            vuelo.Name = 'VueloTest'+auxiliar;
            vuelo.R1_FLG_TXT_Origin__c = 'OrigenTest'+auxiliar;
            vuelo.R1_FLG_TXT_Destination__c = 'DestinoTest'+auxiliar;
            vuelo.R1_FLG_TXT_Carrier_code__c = 'IBC';
            vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
            vuelo.R1_FLG_TXT_Flight_number__c = 'NumTest'+auxiliar;

            return vuelo;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Flight_constructor()', 'Error flight constructor(aux)', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Helper: Case(fieldType, boolean flight, boolean account) - 'expediente' RTId as default (overwritable before insert)
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    25/08/2017             Alberto Puerto Collado                  Passenger Added
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Case helper_Case_constructor(String fieldType, boolean flight, boolean customer){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            //RT del caso expendiente
            Id rt_expediente = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

            Case caso = new Case();
            caso.RecordTypeId = rt_expediente;
            caso.Status = 'Abierto';
            caso.Origin = 'Email';
            caso.Type = fieldType;

            //added 25/08/17 fullfilling passenger
            if(flight && customer){
                Account acc = helper_Account_constructor();
                insert acc;
                caso.AccountID = acc.Id;

                R1_Flight__c v = helper_Flight_constructor();
                insert v;
                caso.R1_CAS_LOO_Flight__c = v.Id;

                R2_CKI_info__c pas = helper_Passenger_constructor(v.Id, acc.Id);
                insert pas;

            }else if(customer){
                Account acc = helper_Account_constructor();
                insert acc;
                caso.AccountID = acc.Id;
            }else if(flight){
                R1_Flight__c v = helper_Flight_constructor();
                insert v;
                caso.R1_CAS_LOO_Flight__c = v.Id;
            }

            return caso;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Case_constructor()', 'Error case constructor()', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Helper: Case(fieldType, boolean flight, boolean account, STRING AUXILIAR) - 'expediente' RTId as default (overwritable before insert) - OVERLOADING
                    Se sobrecarga el método para personalizar la creación de vuelos y accounts para métodos en los que invoque este constructor más de una vez (no repetir objetos)
                    (preferible sobrecargar a crear variable estática para controlarlo desde el test)
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    25/08/2017             Alberto Puerto Collado                  Passenger Added
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Case helper_Case_constructor(String fieldType, boolean flight, boolean customer, String auxiliar){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            //RT del caso expendiente
            Id rt_expediente = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

            Case caso = new Case();
            caso.RecordTypeId = rt_expediente;
            caso.Status = 'Abierto';
            caso.Origin = 'Email';
            caso.Type = fieldType;

            //added 25/08/17 fullfilling passenger
            if(flight && customer){
                Account acc = helper_Account_constructor();
                insert acc;
                caso.AccountID = acc.Id;

                R1_Flight__c v = helper_Flight_constructor();
                insert v;
                caso.R1_CAS_LOO_Flight__c = v.Id;

                R2_CKI_info__c pas = helper_Passenger_constructor(v.Id, acc.Id);
                insert pas;

            }else if(customer){
                Account acc = helper_Account_constructor(auxiliar);
                insert acc;
                caso.AccountID = acc.Id;
            }else if(flight){
                R1_Flight__c v = helper_Flight_constructor(auxiliar);
                insert v;
                caso.R1_CAS_LOO_Flight__c = v.Id;
            }

            return caso;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Case_constructor()', 'Error case constructor(aux)', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Helper: normaliceChars: replace chars to parse JSON data: duplicate backslashes
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String helper_duplicateBackslashes(String stringInvalid){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            String stringFixed = stringInvalid.replace('\\', '\\\\');

            //System.debug(stringInvalid+'|||||||||||'+stringFixed);
            return stringFixed;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_duplicateBackslashes()', 'Error duplicating backslashes', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Helper: Passenger(Id vueloId, Id accId) Constructor
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R2_CKI_info__c helper_Passenger_constructor(Id vueloId, Id accId){//{String auxAcc){//String flightId, String accountId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            R2_CKI_info__c passenger = new R2_CKI_info__c();
            passenger.Name = 'Han Solo';
            passenger.R2_CKI_LOO_Flight__c = vueloId;
            passenger.R2_CKI_LOO_Account__c = accId;
            return passenger;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Passenger_constructor()', 'Error passenger constructor()', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }
     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Helper: Work Order(Id accId, Id casId) Constructor
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    17/10/2017             Sara Torres Bermúdez                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R2_Work_Order__c helper_Work_Order_constructor(Id casId, Id accId){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            R2_Work_Order__c WO = new R2_Work_Order__c();
            WO.R2_WO_LOO_Case__c = casId;
            WO.R2_WO_LOO_Client__c = accId;
            WO.R2_WO_NUM_Amount_tot__c = 10.0;
            WO.R2_WO_PKL_type__c = 'Amazon';
            return WO;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Work_Order_constructor()', 'Error Work Order constructor()', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }
    }

     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Helper: Work Order(Id accId, Id casId) Constructor
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/10/2017             Sara Torres Bermúdez                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static EmailMessage helper_EmailMessage_constructor(Id casId){
        try{
          if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

            EmailMessage email = new EmailMessage();
            email.Subject = 'PruebaSubject';
            email.FromAddress = 'TestAddress@test.com';
            email.ParentId = casId;
            email.TextBody = '[ref: test01@test01 :ref]';
            email.Subject = '[ref: test01@test01 :ref]';
            return email;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_EmailMessage_constructor()', 'Error Email constructor()', exc.getmessage()+', '+exc.getLineNumber(), 'EmailMessage');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/10/2017             Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R2_Compensation__c helper_Compensation_constructor(Id casId, Id accId, Id pagoId, Id inciId, Id vueloId, Id passId){
         try{
           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

             R2_Compensation__c compensa = new R2_Compensation__c();
             system.debug('caso en utilities' + casId);
             compensa.R2_COM_LOO_Case__c = casId;
             system.debug('caso en utilities' + casId);

             compensa.R2_COM_LOO_Account__c = accId;
             compensa.R2_COM_LOO_Payment_Code__c = pagoId;
             compensa.R2_COM_LOO_Flight__c = vueloId;
             compensa.R2_COM_LOO_Incidence__c = inciId;
             compensa.R2_COM_LOO_Passenger__c = passId;
            return compensa;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Compensation_constructor()', 'Error Email constructor()', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }

     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/10/2017             Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R1_Incident__c helper_Incident_constructor(Id casId, Id accId){
         try{
           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

             R1_Incident__c inciden = new R1_Incident__c();
             inciden.R1_INC_LOO_Case__c = casId;
             inciden.R1_INC_LOO_Client__c = accId;
            return inciden;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Compensation_constructor()', 'Error Email constructor()', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }

      /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/10/2017             Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static R2_Payment_order__c helper_PaymentOrder_constructor(){
         try{
           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

             R2_Payment_order__c payment = new R2_Payment_order__c();
            return payment;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.helper_Compensation_constructor()', 'Error Email constructor()', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Read and Refresh delayed and damaged bag
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    13/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Id readRecord_WT(String recordTypeName, String stationCode, String airlinecode, String referenceNumber, String agentId, Integer service){//PIR pirObject){
        System.debug('PageReference readRecord()');
        System.debug('Se va a lanzar la operacion : '+ service);
        R1_Incident__c inc;
        Id resId;
        try{
            ////////////////////
          System.debug('ANTES DE MAPEO');
            R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
            System.debug('TRAS BIGWP');
            R2_CLS_WT_Bags_Management.WpReq requestRead = new R2_CLS_WT_Bags_Management.WpReq();
            System.debug('TRAS requestREAD');
                R2_CLS_WT_Bags_Management.NewRecordType rt = new R2_CLS_WT_Bags_Management.NewRecordType();
                    R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                    ar.stationCode = stationCode;//inc.R2_INC_TXT_PIR_AR_Station_Code__c;//'MAD';
                    ar.airlineCode = airlinecode;//inc.R2_INC_TXT_PIR_AR_Airline_Code__c;//'IB'; //
                    ar.referenceNumber = referenceNumber;//inc.R2_INC_TXT_PIR_AR_Reference_Number__c; //'67894';
                rt.recordReference = ar;
                rt.recordType = recordTypeName;//'DELAYED';
            requestRead.recordId = rt;
            requestRead.agentId = agentId;//'1278'; //duda

            System.debug('ANTES DESERIALIZE'+requestRead);
            bigWP.read = JSON.serialize(requestRead, true);
            System.debug('bigWP::::::::READ:'+bigWP.read);
            Id idbag;
            //if (service == 0) { //posiblemente sin uso
            //    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH_previo(bigWP.read,0);
            //}
            //else
            if (service == 1){ // refresca con el mismo numero de PIR
                                   //Servicios: Leer; Refrescar; Close; Suspender; Reinstate; modificar
                if(recordTypeName == 'DELAYED'){
                    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0, false);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 1: ');
                    idbag = R2_CLS_INC_Read_Damaged_PIR.readRecord_DPR_DDP(bigWP.read,0, false);

                    System.debug('*** damaged idbag: ' + idbag);
                }

            }
            else if (service == 2){ //cambia el numero de PIR al refrescar, el numero esta en la respuesta del servicio.
                                   //Servicios: Cambiar escala; Reabrir
                System.debug('*** entra en service - 2: //recordtype=' + recordTypeName);
                if(recordTypeName == 'DELAYED'){
                    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0, true);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 2: ');
                    idbag = R2_CLS_INC_Read_Damaged_PIR.readRecord_DPR_DDP(bigWP.read,0, true);

                    System.debug('*** damaged idbag: ' + idbag);
                }
            }
            else if (service == 3){ //Para incidencias Inactive//cambia el numero de PIR al refrescar, el numero esta en la respuesta del servicio.
                                   //Servicios: Cambiar escala; Reabrir
                System.debug('*** entra en service - 3: //recordtype=' + recordTypeName);
                if(recordTypeName == 'DELAYED'){
                    System.debug('*** entra en DELAYED - 3: ');
                    idbag = R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(bigWP.read,0, false);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 3: ');
                    idbag = R2_WT_ReadRetiredDamaged.retrieve_Damaged_bag(bigWP.read,0, false);

                    System.debug('*** damaged idbag: ' + idbag);
                }
            }


            System.debug('!!!resID  = '+idbag);
            return idbag;// pageRef;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.readRecord_WT', '', ex.getmessage()+', '+ex.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    Read and Refresh  inactive delayed and damaged bag
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    16/01/2018             Ismael Yubero Moreno                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Id readRecord_WTInactive(String recordTypeName, String stationCode, String airlinecode, String referenceNumber, String agentId, Integer service, String createdDate){//PIR pirObject){
        System.debug('PageReference readRecord() Inactive');
        System.debug('Se va a lanzar la operacion : '+ service);
        R1_Incident__c inc;
        Id resId;
        try{
            ////////////////////
          System.debug('ANTES DE MAPEO');
            R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
            System.debug('TRAS BIGWP');
            R2_CLS_WT_Bags_Management.WpReq requestRead = new R2_CLS_WT_Bags_Management.WpReq();
            System.debug('TRAS requestREAD');
                R2_CLS_WT_Bags_Management.NewRecordType rt = new R2_CLS_WT_Bags_Management.NewRecordType();
                    R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
                    ar.stationCode = stationCode;//inc.R2_INC_TXT_PIR_AR_Station_Code__c;//'MAD';
                    ar.airlineCode = airlinecode;//inc.R2_INC_TXT_PIR_AR_Airline_Code__c;//'IB'; //
                    ar.referenceNumber = referenceNumber;//inc.R2_INC_TXT_PIR_AR_Reference_Number__c; //'67894';
                rt.recordReference = ar;
                rt.recordType = recordTypeName;//'DELAYED';
            requestRead.recordId = rt;
            requestRead.agentId = agentId;//'1278'; //duda
            requestRead.airlineVendorId = airlinecode;

            List<String> aux = createdDate.split(' ');
            System.debug('Fecha auxiliar: ' + aux[0]);

            requestRead.rdate = aux[0];



            System.debug('ANTES DESERIALIZE'+requestRead);
            bigWP.read = JSON.serialize(requestRead, true);
            String fixed = bigWP.read;
            fixed = fixed.replaceAll('"rDate":','"date":');
            if(recordTypeName == 'DAMAGED'){
                fixed = fixed.replaceAll('"agentId":','"agentID":');
                fixed = fixed.replaceAll('"recordId":','"recordID":');

            }
            System.debug( 'Fixed: ' + fixed);
            System.debug('bigWP::::::::READ:'+bigWP.read);

            Id idbag;
            //if (service == 0) { //posiblemente sin uso
            //    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH_previo(bigWP.read,0);
            //}
            //else
            if (service == 1){ // refresca con el mismo numero de PIR
                                   //Servicios: Leer; Refrescar; Close; Suspender; Reinstate; modificar
                if(recordTypeName == 'DELAYED'){
                    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0, false);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 1: ');
                    idbag = R2_CLS_INC_Read_Damaged_PIR.readRecord_DPR_DDP(bigWP.read,0, false);

                    System.debug('*** damaged idbag: ' + idbag);
                }

            }
            else if (service == 2){ //cambia el numero de PIR al refrescar, el numero esta en la respuesta del servicio.
                                   //Servicios: Cambiar escala; Reabrir
                System.debug('*** entra en service - 2: //recordtype=' + recordTypeName);
                if(recordTypeName == 'DELAYED'){
                    idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0, true);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 2: ');
                    idbag = R2_CLS_INC_Read_Damaged_PIR.readRecord_DPR_DDP(bigWP.read,0, true);

                    System.debug('*** damaged idbag: ' + idbag);
                }
            }
            else if (service == 3){ //Para incidencias Inactive//cambia el numero de PIR al refrescar, el numero esta en la respuesta del servicio.
                                   //Servicios: Cambiar escala; Reabrir
                System.debug('*** entra en service - 3: //recordtype=' + recordTypeName);
                if(recordTypeName == 'DELAYED'){
                    idbag = R2_WT_ReadRetiredDelayed.readRetiredRecord_AHL_PDI(fixed,0, false);
                    System.debug('*** delayed idbag: ' + idbag);
                }else if(recordTypeName == 'DAMAGED'){
                  System.debug('*** entra en DAMAGED - 3: ');
                    idbag = R2_WT_ReadRetiredDamaged.retrieve_Damaged_bag(fixed,0, false);

                    System.debug('*** damaged idbag: ' + idbag);
                }
            }


            System.debug('!!!resID  = '+idbag);
            return idbag;// pageRef;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.readRecord_WT', '', ex.getmessage()+', '+ex.getLineNumber(), 'R1_Incident__c');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Read and Refresh delayed and damaged bag
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    13/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    //public static Id readRecord_WT(String recordTypeName, String stationCode, String airlinecode, String referenceNumber, String agentId){//PIR pirObject){
    //    System.debug('PageReference readRecord()');

    //    R1_Incident__c inc;
    //    Id resId;
    //    try{
    //        ////////////////////
    //      System.debug('ANTES DE MAPEO');
    //        R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
    //        System.debug('TRAS BIGWP');
    //        R2_CLS_WT_Bags_Management.WpReq requestRead = new R2_CLS_WT_Bags_Management.WpReq();
    //        System.debug('TRAS requestREAD');
    //            R2_CLS_WT_Bags_Management.NewRecordType rt = new R2_CLS_WT_Bags_Management.NewRecordType();
    //                R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
    //                ar.stationCode = stationCode;//inc.R2_INC_TXT_PIR_AR_Station_Code__c;//'MAD';
    //                ar.airlineCode = airlinecode;//inc.R2_INC_TXT_PIR_AR_Airline_Code__c;//'IB'; //
    //                ar.referenceNumber = referenceNumber;//inc.R2_INC_TXT_PIR_AR_Reference_Number__c; //'67894';
    //            rt.recordReference = ar;
    //            rt.recordType = recordTypeName;//'DELAYED';
    //        requestRead.recordId = rt;
    //        requestRead.agentId = agentId;//'1278'; //duda

    //        System.debug('ANTES DESERIALIZE'+requestRead);
    //        bigWP.read = JSON.serialize(requestRead);
    //        System.debug('bigWP::::::::READ:'+bigWP.read);
    //        Id idbag;
    //        idbag = R2_CLS_WT_Bags_Management.readRecord_AHL_DAH(bigWP.read,0, true);


    //        System.debug('!!!resID  = '+idbag);
    //        return idbag;// pageRef;
    //    }catch(Exception ex){
    //        R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.readRecord_WT', '', ex.getmessage()+', '+ex.getLineNumber(), 'R1_Incident__c');
    //        return null;
    //    }
    //}

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Empty all the updateables fields of a object
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/12/2017             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static sObject resetObject(sObject obj, String nameObject, Boolean deleteReference){
        try{
           if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();

            Map <String, Schema.SObjectField> fieldMap = schemaMap.get(nameObject).getDescribe().fields.getMap();
            for(Schema.SObjectField sfield : fieldMap.Values())
            {
                schema.describefieldresult dfield = sfield.getDescribe();
                if (dfield.isUpdateable() && ((dfield.getType() == Schema.DisplayType.Reference && deleteReference) || dfield.getType() != Schema.DisplayType.Reference)) {
                    obj.put(dfield.getname(), dfield.getDefaultValue());
                }
            }

            System.debug(obj);
            return obj;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.resetObject', 'Error al borrar resetear los campos del objeto', ex.getmessage()+', '+ex.getLineNumber(), nameObject);
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:
     IN:             String cadena:
                        Possible formats from WorldTracer:
                             EXAMPLE 1 NORMAL FD    - BA123/23MAY/VS456/23MAY/EI789/23MAY                    |
                            |          SHORTENED FD - BA123/VS456/EI789/23MAY                                |
                            |                                           -----                                |
                            |EXAMPLE 2 NORMAL FD    - BA123/23MAY/VS456/23MAY/EI789/24MAY                    |
                            |          SHORTENED FD - BA123/VS456/23MAY/EI789/24MAY                          |
                            |                                     -----       -----                          |
                            |EXAMPLE 3 NORMAL FD    - BA123/23MAY/VS456/24MAY/EI789/24MAY                    |
                            |          SHORTENED FD - BA123/23MAY/VS456/EI789/24MAY

                        Possible formats with ARNK values
                            |RT  ATL / LGA / EWR / DEN                                                       |
                            |FD  ZZ123/07JUL / ARNK / ZZ134/07JUL                                            |
                            |RT DOH / LHR / LGW / ATL                                                        |
                            |FD ZZ344/08JUL / ARNK / ZZ55/08JUL

                        -->ARNK value NEVER could be located at the first/last position

    OUT:        Map<String, List<String>> -> Map(Day, Flights)

    History:
     <Date>                     <Author>                         <Change Description>
    10/01/2018             Alberto Puerto Collado                  Initial Version
    19/01/2018             Alberto Puerto Collado                  Management for ARNK values added
    ----------------------------------------------------------------------------------------------------------------------*/
    public static Map<String, List<String>> helper_parseDate(String cadena){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String transforMe = cadena;
            transforMe = transforMe.replaceAll('([0-9]{2}[A-Z]{3})(/?)', '$1@splitMe@');
            transforMe = transforMe.replaceAll('(ARNK)(/?)', '$1@splitMe@');
            System.debug(':::transforMe'+transforMe);
            //Lista con Vuelo/Fecha o Vuelo/[...]/Vuelo/Fecha
            List<String> lstDias = transforMe.split('@splitMe@');

            System.debug(':::lstDias'+lstDias);
            //Mapa que contendrá (Fecha, Lst<Vuelos>)
            Map<String, List<String>> mapVuelosDia = new Map<String, List<String>>();
            if(!lstDias.isEmpty()){
                for(Integer i=0; i < lstDias.size(); i++){
                    List<String> lstElementPerDay = lstDias[i].split('/');
                    System.debug(':::LISTA lstElementPerDay'+lstElementPerDay);
                    String fecha = lstElementPerDay.get(lstElementPerDay.size() - 1); //ARNK sirve para fecha cuando es ARNK
                    System.debug(':::fecha'+fecha);
                    List<String> lstVuelos = lstElementPerDay;
                    System.debug(':::LISTA VUELOS antes de remover'+lstVuelos);
                    lstVuelos.remove(lstElementPerDay.size()  - 1);
                    //transformo formato fecha 11/ENE a YYYY-MM-DD -> helper_DateStringToDateSF
                    fecha = helper_DateStringToDateSF(fecha);
                    System.debug(':::LISTA VUELOS buena'+lstVuelos);
                    for(String vuelo : lstVuelos){
                        if(mapVuelosDia.containsKey('ARNK')){
                            List<String> lstFlightVacia = mapVuelosDia.get(fecha);
                            lstFlightVacia.add('ARNK');
                            mapVuelosDia.put(fecha, lstFlightVacia);
                        }
                        if(mapVuelosDia.containsKey(fecha)){
                            List<String> lstFlight = mapVuelosDia.get(fecha);
                            lstFlight.add(vuelo);
                            mapVuelosDia.put(fecha, lstFlight );
                        }else{
                            mapVuelosDia.put(fecha, lstVuelos);
                        }
                    }

                }
            }
            //Se tratará desde donde se llame ya que se llenan wrappers distintos
            //if(!mapVuelosDia.isEmpty()){
            //    for (String fieldName : mapVuelosDia.keySet()){
            //        System.debug('Key del mapa: ' + fieldName); -> llenar wrappers según corresponda
            //    }
            //}
            return mapVuelosDia;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.helper_parseDate', 'error en helper_parseDate', ex.getmessage()+', '+ex.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Change format of Date received, Number(Day)String(Month) to YYYY-MM-DD

    IN:             String: 23MAY
    OUT:            String: YYYY-MM-DD

    History:
     <Date>                     <Author>                         <Change Description>
    11/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String helper_DateStringToDateSF(String cadena){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            String fecha = '';
            String mes = cadena.substring(2);
            String dia = cadena.substring(0, 2);

            Date today = Date.today();
            Integer currentYear = today.year();

            //Switch case for months:
            if(mes.contains('JAN') || mes.contains('ENE')){
                fecha = '-01-' + dia;
            }else if(mes.contains('FEB')){
                fecha = '-02-' + dia;
            }else if(mes.contains('MAR') ){
                fecha = '-03-' + dia;
            }else if(mes.contains('APR') || mes.contains('ABR')){
                fecha = '-04-' + dia;
            }else if(mes.contains('MAY') ){
                fecha = '-05-' + dia;
            }else if(mes.contains('JUN') ){
                fecha = '-06-' + dia;
            }else if(mes.contains('JUL') ){
                fecha = '-07-' + dia;
            }else if(mes.contains('AUG') || mes.contains('AGO')){
                fecha = '-08-' + dia;
            }else if(mes.contains('SEP') ){
                fecha = '-09-' + dia;
            }else if(mes.contains('OCT') ){
                fecha = '-10-' + dia;
            }else if(mes.contains('NOV') ){
                fecha = '-11-' + dia;
            }else if(mes.contains('DEC') || mes.contains('DIC')){
                fecha = '-12-' + dia;
            }
            String fecha2 = currentYear + fecha;
            //select the year of each flight
            if(Date.valueOf(fecha2) > Date.today()){
                fecha = currentYear - 1 + fecha;
            }else{
                fecha = currentYear + fecha;
            }
            return fecha;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.helper_DateStringToDateSF', 'error en helper_DateStringToDateSF', ex.getmessage()+', '+ex.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    The "inverse" of previous method called helper_parseDate()

    IN:        Map<String, String> -> Map(Flight, Date)
    OUT:             String cadena: Possible formats from WorldTracer:
                         EXAMPLE 1 NORMAL FD    - BA123/23MAY/VS456/23MAY/EI789/23MAY                    |
                        |          SHORTENED FD - BA123/VS456/EI789/23MAY                                |
                        |                                           -----                                |
                        |EXAMPLE 2 NORMAL FD    - BA123/23MAY/VS456/23MAY/EI789/24MAY                    |
                        |          SHORTENED FD - BA123/VS456/23MAY/EI789/24MAY                          |
                        |                                     -----       -----                          |
                        |EXAMPLE 3 NORMAL FD    - BA123/23MAY/VS456/24MAY/EI789/24MAY                    |
                        |          SHORTENED FD - BA123/23MAY/VS456/EI789/24MAY


    History:
     <Date>                     <Author>                         <Change Description>
    11/01/2018             Alberto Puerto Collado                  Initial Version
    19/01/2018             Alberto Puerto Collado                  Management for ARNK values added
    ----------------------------------------------------------------------------------------------------------------------*/
   public static String helper_parseDate_MapaToString(Map<String, String> mapa){
        try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug(':::helper_parseDate_MapaToString' + mapa);
            System.debug('::: MAPA' + mapa);
            Map<String, String> mapVueloFecha = mapa;
            String cadena = '';

            for(String vuelo : mapVueloFecha.keySet()){
                //if añadido para ARNK, verificar y sincronizar si recibiré estos valores
                if(mapVueloFecha.get('ARNK') != null){
                    if(mapVueloFecha.get('ARNK').contains('ARNK')){
                        cadena += vuelo + '/';
                    }
                }
                cadena += vuelo + '/' + mapVueloFecha.get(vuelo) + '/';
            }
            //deleting the last slash
            cadena = cadena.removeEnd('/');

            return cadena;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.helper_parseDate_MapaToString', 'error en helper_parseDate_MapaToString', ex.getmessage()+', '+ex.getLineNumber(), '');
            return null;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    The inverse of previous method called helper_DateStringToDateSF()

    IN:             String: YYYY-MM-DD
    OUT:            String: 23MAY

    History:
     <Date>                     <Author>                         <Change Description>
    11/01/2018             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    public static String helper_DateSFtoDateString(String cadena){
         try {
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            if(cadena.length() >= 9 && cadena.length() <= 10){//mejora pendiente para splitear y comparar mejor, cuando haya tiempo :D
                String fecha = '';
                String mes = cadena.substring(5, 8);
                String dia = cadena.substring(8);
                if(dia.length() == 1){
                    dia = '0' + dia;
                }

                //Switch case for months:
                if(mes.contains('01')){
                    fecha = dia + 'JAN';
                }else if(mes.contains('02')){
                    fecha = dia + 'FEB';
                }else if(mes.contains('03') ){
                    fecha = dia + 'MAR';
                }else if(mes.contains('04')){
                    fecha = dia + 'APR';
                }else if(mes.contains('05') ){
                    fecha = dia + 'MAY';
                }else if(mes.contains('06') ){
                    fecha = dia + 'JUN';
                }else if(mes.contains('07') ){
                    fecha = dia + 'JUL';
                }else if(mes.contains('08') ){
                    fecha = dia + 'AUG';
                }else if(mes.contains('09') ){
                    fecha = dia + 'SEP';
                }else if(mes.contains('10') ){
                    fecha = dia + 'OCT';
                }else if(mes.contains('11') ){
                    fecha = dia + 'NOV';
                }else if(mes.contains('12') ){
                    fecha = dia + 'DEC';
                }
                return fecha;
            }
            return null;
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_INC_IncidentInformationController.helper_DateSFtoDateString', 'error en helper_DateSFtoDateString', ex.getmessage()+', '+ex.getLineNumber(), '');
            return null;
        }
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Returns a string with the accesible fields of the object
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    05/02/2017             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

    public static String dynamicQuery(String myObjectS) {

        List<DescribeFieldResult> selectedField = obtainFields(myObjectS);

        string myFieldQS = 'SELECT ' + selectedField[0].getName();

        //Verifies if the field is accessible
        for (Integer i = 1; i < selectedField.size(); i++) {
            if (selectedField[i].isAccessible()) {
                myFieldQS = myFieldQS + ', ' + selectedField[i].getName();
            }
        }
        return myFieldQS;
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Obtains fields of the object
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    05/02/2017             Alvaro Garcia Tapia                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

    private static list <DescribeFieldResult> obtainFields(String myObjectS) {

        SObjectType objToken = Schema.getGlobalDescribe().get(myObjectS);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> sObjectfields = objDef.fields.getMap();
        Set<String> fieldSet = sObjectfields.keySet();
        list <DescribeFieldResult> selectedField = new list<DescribeFieldResult>();

        for (String str : fieldSet) {
            SObjectField fieldToken = sObjectfields.get(str);
            selectedField.add(fieldToken.getDescribe());
        }
        return selectedField;
    }

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Separa el Codigo de la compania y numero de vuelo de un codigo compuesto ej (IB1234)

    IN: String, Boolean
    OUT: string

    History:
    <Date>                     <Author>                <Change Description>
    18/01/2018                 jaime Ascanta            Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    public static String splitFlyNumber (String numeroVuelo, Integer option) {
      try{
        string result = '';
        if(numeroVuelo != null && numeroVuelo != '' && numeroVuelo.length()>2) {

          numeroVuelo = numeroVuelo.deleteWhitespace();
          List<String> dataArray = new List<String>();
          if(numeroVuelo.contains('-')) {
            dataArray.add(numeroVuelo.split('-')[0]);
            dataArray.add(numeroVuelo.split('-')[1]);

          }else if(numeroVuelo.contains('_')){
            dataArray.add(numeroVuelo.split('_')[0]);
            dataArray.add(numeroVuelo.split('_')[1]);
          }else {
            dataArray.add( numeroVuelo.substring(0, 2) );
            dataArray.add( numeroVuelo.substring(2) );
          }

          if(option==1) {
            result = dataArray[0];
          }else if(option==2) {
            result = dataArray[1];
          }

        }

        return result;

      }catch(Exception exc){
        R1_CLS_LogHelper.generateErrorLog('R1_CLS_Utilities.splitFlyNumber()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        return '';
      }
    }
}