/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Apex test para la clase apex 'R1_Utilities'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    @isTest
    private class R1_CLS_Utilities_Test {


    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion generateStrProg()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void generateStrProgTest(){
        R1_CLS_LogHelper.throw_exception = false;

        Datetime dat = System.today();

        R1_CLS_Utilities.generateStrProg(dat);

    }



    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion putCache() y getCache()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void put_getCacheTest(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_CLS_Utilities.putCache('local.sessionCache.token', 'prueba');

        String token = R1_CLS_Utilities.getCache('local.sessionCache.token');

        //System.assertEquals(token,'prueba');

    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion splitText()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void splitTextTest(){

        Set<String> setString= R1_CLS_Utilities.splitText(';Account;All;R1_Company__c');

        System.assert(setString.contains('Account'));

    }

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Account_constructor(), helper_Account_constructor(String auxiliar)
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Account_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
  				Test.startTest();
            Account acc = R1_CLS_Utilities.helper_Account_constructor();
            System.assertNotEquals(null, acc);

            Account acc2 = R1_CLS_Utilities.helper_Account_constructor('test 2');
            System.assertNotEquals(null, acc2);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Flight_constructor(), helper_Flight_constructor(String auxiliar)
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Flight_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
  				Test.startTest();

            R1_Flight__c fli = R1_CLS_Utilities.helper_Flight_constructor();
            System.assertNotEquals(null, fli);

            R1_Flight__c fi2 = R1_CLS_Utilities.helper_Flight_constructor('test 2');
            System.assertNotEquals(null, fi2);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Case_constructor(String fieldType, boolean flight, boolean customer), helper_Case_constructor(String fieldType, boolean flight, boolean customer, String auxiliar)
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Case_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
  				Test.startTest();

          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', true, true);
          System.assertNotEquals(null, cas);

          Case cas2 = R1_CLS_Utilities.helper_Case_constructor('Demora', true, true, '1');
          System.assertNotEquals(null, cas2);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_duplicateBackslashes()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_duplicateBackslashes_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
          String textTest = 'test';
          Test.startTest();
            String testTxt = R1_CLS_Utilities.helper_duplicateBackslashes('\\test');
            System.assertEquals('\\\\test', testTxt);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}


    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Work_Order_constructor()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Work_Order_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;

          Account acc = R1_CLS_Utilities.helper_Account_constructor();
          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);

          Test.startTest();

            R2_Work_Order__c wo = R1_CLS_Utilities.helper_Work_Order_constructor(cas.Id, acc.Id);
            System.assertNotEquals(null, wo);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_EmailMessage_constructor()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_EmailMessage_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);

          Test.startTest();

            EmailMessage em = R1_CLS_Utilities.helper_EmailMessage_constructor(cas.Id);
            System.assertNotEquals(null, em);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Compensation_constructor()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Compensation_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;
          Account acc = R1_CLS_Utilities.helper_Account_constructor();
          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);
          R2_Payment_order__c pay = R1_CLS_Utilities.helper_PaymentOrder_constructor();
          R1_Incident__c inc = R1_CLS_Utilities.helper_Incident_constructor(cas.Id, acc.Id);
          R1_Flight__c fli = R1_CLS_Utilities.helper_Flight_constructor();
          R2_CKI_info__c pas = R1_CLS_Utilities.helper_Passenger_constructor(fli.Id, acc.Id);

          Test.startTest();

            R2_Compensation__c com = R1_CLS_Utilities.helper_Compensation_constructor(cas.Id, acc.Id, pay.Id, inc.Id, fli.Id, pas.Id);
            System.assertNotEquals(null, com);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_Incident_constructor()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_Incident_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;

          Account acc = R1_CLS_Utilities.helper_Account_constructor();
          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);

          Test.startTest();

            R1_Incident__c inc = R1_CLS_Utilities.helper_Incident_constructor(cas.Id, acc.Id);
            System.assertNotEquals(null, inc);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
  		Author:         Jaime Ascanta
  		Company:        Accenture
  		Description:    Apex test from method helper_PaymentOrder_constructor()
  		IN:
  		OUT:

  		History:
  		 <Date>                     <Author>                         <Change Description>
  		30/10/2017       	   			Jaime Ascanta                   		Initial Version
  		----------------------------------------------------------------------------------------------------------------------*/
  	@isTest
  	static void helper_PaymentOrder_constructor_Test() {
  				R1_CLS_LogHelper.throw_exception = false;

          Account acc = R1_CLS_Utilities.helper_Account_constructor();
          Case cas = R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);

          Test.startTest();

            R2_Payment_order__c pay = R1_CLS_Utilities.helper_PaymentOrder_constructor();
            System.assertNotEquals(null, pay);

  				Test.stopTest();
  				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
  	}

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: mockCallOut test
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    11/08/2017             Alberto Puerto Collado                  Added 11 y 12
    30/10/2017             Jaime Ascanta                           Added
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void mockCallOut_test(){
        R1_CLS_LogHelper.throw_exception = true;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        //1 - endpoint == login
        HTTPRequest req_Login = new HTTPRequest();
        req_Login.setEndpoint('Login');
        //2 - SendCustomerError
        HTTPRequest req_SendCustomerError = new HTTPRequest();
        req_SendCustomerError.setEndpoint('SendCustomerError');
        //3 - SendCustomer
        HTTPRequest req_SendCustomer = new HTTPRequest();
        req_SendCustomer.setEndpoint('SendCustomer');
        //4 - Message
        HTTPRequest req_Message = new HTTPRequest();
        req_Message.setEndpoint('Message');
        //5 - SubmitFlight
        HTTPRequest req_SubmitFlight = new HTTPRequest();
        req_SubmitFlight.setEndpoint('SubmitFlight');
        //6 - UpdateFlightStatus
        HTTPRequest req_UpdateFlightStatus = new HTTPRequest();
        req_UpdateFlightStatus.setEndpoint('UpdateFlightStatus');
        //7 - SMS_Login
        HTTPRequest req_SMS_Login = new HTTPRequest();
        req_SMS_Login.setEndpoint('SMS_Login');
        //8 - SendSMS
        HTTPRequest req_SendSMS = new HTTPRequest();
        req_SendSMS.setEndpoint('SendSMS');
        //9 - SMS_Intentos
        HTTPRequest req_SMS_Intentos = new HTTPRequest();
        req_SMS_Intentos.setEndpoint('SMS_Intentos');
        //10- error unexpected
        HTTPRequest req_Unexpected = new HTTPRequest();
        req_Unexpected.setEndpoint('unexpected endpoint error etc ');

        //añadidos posteriores
        //11- error unexpected
        HTTPRequest req_R2_Retrieve_Passenger_Details = new HTTPRequest();
        req_R2_Retrieve_Passenger_Details.setEndpoint('R2_Retrieve_Passenger_Details');
        //12- error unexpected
        HTTPRequest req_PasajerosVuelo = new HTTPRequest();
        req_PasajerosVuelo.setEndpoint('PasajerosVuelo');

        //13 - Send TSK
        HTTPRequest req_send_tsk = new HTTPRequest();
        req_send_tsk.setEndpoint('Send TSK');
        //14 - PruebaGiftCardJan
        HTTPRequest req_prueba_gift_card_jan = new HTTPRequest();
        req_prueba_gift_card_jan.setEndpoint('PruebaGiftCardJan');
        //15 - PruebaGiftCardFeb
        HTTPRequest req_prueba_gift_card_feb = new HTTPRequest();
        req_prueba_gift_card_feb.setEndpoint('PruebaGiftCardFeb');
        //16 - PruebaGiftCardMar
        HTTPRequest req_prueba_gift_card_mar = new HTTPRequest();
        req_prueba_gift_card_mar.setEndpoint('PruebaGiftCardMar');
        //17 - PruebaGiftCardApr
        HTTPRequest req_prueba_gift_card_apr = new HTTPRequest();
        req_prueba_gift_card_apr.setEndpoint('PruebaGiftCardApr');
        //18 - PruebaGiftCardMay
        HTTPRequest req_prueba_gift_card_may = new HTTPRequest();
        req_prueba_gift_card_may.setEndpoint('PruebaGiftCardMay');
        //19 - PruebaGiftCardJun
        HTTPRequest req_prueba_gift_card_jun = new HTTPRequest();
        req_prueba_gift_card_jun.setEndpoint('PruebaGiftCardJun');
        //20 - PruebaGiftCardJul
        HTTPRequest req_prueba_gift_card_jul = new HTTPRequest();
        req_prueba_gift_card_jul.setEndpoint('PruebaGiftCardJul');
        //21 - PruebaGiftCardAug
        HTTPRequest req_prueba_gift_card_aug = new HTTPRequest();
        req_prueba_gift_card_aug.setEndpoint('PruebaGiftCardAug');
        //22 - PruebaGiftCardSep
        HTTPRequest req_prueba_gift_card_sep = new HTTPRequest();
        req_prueba_gift_card_sep.setEndpoint('PruebaGiftCardSep');
        //23 - PruebaGiftCardOct
        HTTPRequest req_prueba_gift_card_oct = new HTTPRequest();
        req_prueba_gift_card_oct.setEndpoint('PruebaGiftCardOct');
        //24 - PruebaGiftCardNov
        HTTPRequest req_prueba_gift_card_nov = new HTTPRequest();
        req_prueba_gift_card_nov.setEndpoint('PruebaGiftCardNov');
        //25 - PruebaGiftCardDec
        HTTPRequest req_prueba_gift_card_dec = new HTTPRequest();
        req_prueba_gift_card_dec.setEndpoint('PruebaGiftCardDec');
        //26 - PruebaGiftCard401
        HTTPRequest req_prueba_gift_card_401 = new HTTPRequest();
        req_prueba_gift_card_401.setEndpoint('PruebaGiftCard401');
        //27 - PruebaGiftCardCualquiera
        HTTPRequest req_prueba_gift_card_cualquiera = new HTTPRequest();
        req_prueba_gift_card_cualquiera.setEndpoint('PruebaGiftCardCualquiera');


        //28 - PasajerosVuelo011
        HTTPRequest req_pasajeros_vuelo_011 = new HTTPRequest();
        req_pasajeros_vuelo_011.setEndpoint('PasajerosVuelo011');
        //29 - Pagos
        HTTPRequest req_pagos = new HTTPRequest();
        req_pagos.setEndpoint('Pagos');
        //30 - R2_Retrieve_Passe
        HTTPRequest req_r2_retrieve_passe = new HTTPRequest();
        req_r2_retrieve_passe.setEndpoint('R2_Retrieve_Passe');
        //31 - "/api/FM-FPM/rs/v1"
        HTTPRequest req_fm_fpm_rs = new HTTPRequest();
        req_fm_fpm_rs.setEndpoint('/api/FM-FPM/rs/v1');

        //32 - "/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAD-1AMDE/passengers"
        HTTPRequest req_fm_fpm_rs_flightlegs = new HTTPRequest();
        req_fm_fpm_rs_flightlegs.setEndpoint('/api/FM-FPM/rs/v1/flightlegs/IB_3710-08212017-null-MAD-1AMDE/passengers');


        Test.startTest();
        //creacion de objeto Http y uso del HttpResponse.send
        Http http = new Http();

        HttpResponse res_Login = http.send(req_Login); //1
        HttpResponse res_SendCustomerError = http.send(req_SendCustomerError); //2
        HttpResponse res_SendCustomer = http.send(req_SendCustomer); //3
        HttpResponse res_Message = http.send(req_Message); //4
        HttpResponse res_SubmitFlight = http.send(req_SubmitFlight); //5
        HttpResponse res_UpdateFlightStatus = http.send(req_UpdateFlightStatus); //6
        HttpResponse res_SMS_Login = http.send(req_SMS_Login); //7
        HttpResponse res_SendSMS = http.send(req_SendSMS); //8
        HttpResponse res_SMS_Intentos = http.send(req_SMS_Intentos); //9
        HttpResponse res_Unexpected = http.send(req_Unexpected); //10
        HttpResponse res_R2_Retrieve_Passenger_Details = http.send(req_R2_Retrieve_Passenger_Details); //11
        HttpResponse res_PasajerosVuelo = http.send(req_PasajerosVuelo); //12
        HttpResponse res_send_tsk = http.send(req_send_tsk); //13
        HttpResponse res_prueba_gift_card_jan = http.send(req_prueba_gift_card_jan); //14
        HttpResponse res_prueba_gift_card_feb = http.send(req_prueba_gift_card_feb); //15
        HttpResponse res_prueba_gift_card_mar = http.send(req_prueba_gift_card_mar); //16
        HttpResponse res_prueba_gift_card_apr = http.send(req_prueba_gift_card_apr); //17
        HttpResponse res_prueba_gift_card_may = http.send(req_prueba_gift_card_may); //18
        HttpResponse res_prueba_gift_card_jun = http.send(req_prueba_gift_card_jun); //19
        HttpResponse res_prueba_gift_card_jul = http.send(req_prueba_gift_card_jul); //20
        HttpResponse res_prueba_gift_card_aug = http.send(req_prueba_gift_card_aug); //21
        HttpResponse res_prueba_gift_card_sep = http.send(req_prueba_gift_card_sep); //22
        HttpResponse res_prueba_gift_card_oct = http.send(req_prueba_gift_card_oct); //23
        HttpResponse res_prueba_gift_card_nov = http.send(req_prueba_gift_card_nov); //24
        HttpResponse res_prueba_gift_card_dec = http.send(req_prueba_gift_card_dec); //25
        HttpResponse res_prueba_gift_card_401 = http.send(req_prueba_gift_card_401); //26
        HttpResponse res_prueba_gift_card_cualquiera = http.send(req_prueba_gift_card_cualquiera); //27

        HttpResponse res_pasajeros_vuelo_011 = http.send(req_pasajeros_vuelo_011); //28
        HttpResponse res_pagos = http.send(req_pagos); //29
        HttpResponse res_r2_retrieve_passe = http.send(req_r2_retrieve_passe); //30
        HttpResponse res_fm_fpm_rs = http.send(req_fm_fpm_rs); //31
        HttpResponse res_fm_fpm_rs_flightlegs = http.send(req_fm_fpm_rs_flightlegs); //32

        Test.stopTest();
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para cubrir los catch()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    03/05/2017             Alvaro Garcia Tapia                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R1_CLS_Utilities.generateStrProg(null);
        R1_CLS_Utilities.putCache('local.sessionCache.token', 'prueba');
        R1_CLS_Utilities.getCache('local.sessionCache.token');

        R1_CLS_Utilities.helper_Account_constructor();
        R1_CLS_Utilities.helper_Account_constructor(null);
        R1_CLS_Utilities.helper_Flight_constructor();
        R1_CLS_Utilities.helper_Flight_constructor(null);
        R1_CLS_Utilities.helper_Case_constructor('Demora', false, false);
        R1_CLS_Utilities.helper_Case_constructor('Demora', false, false, 'test');
        R1_CLS_Utilities.helper_duplicateBackslashes(null);
        R1_CLS_Utilities.helper_Passenger_constructor(null, null);
        R1_CLS_Utilities.helper_Work_Order_constructor(null, null);
        R1_CLS_Utilities.helper_EmailMessage_constructor(null);
        R1_CLS_Utilities.helper_Compensation_constructor(null, null, null, null, null, null);
        R1_CLS_Utilities.helper_Incident_constructor(null, null);
        R1_CLS_Utilities.helper_PaymentOrder_constructor();
    }
}