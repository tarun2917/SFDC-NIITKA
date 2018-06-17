/*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	18/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    
@isTest
private class R2_CLS_GiftCard_Test {
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
        
    static testMethod void CrearTarjetaJan_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardJan';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '006';
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaFeb_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardFeb';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '009';


        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaMar_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardMar';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '008';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaApr_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardApr';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '001';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaMay_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardMay';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '002';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaJun_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardJun';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '004';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
     static testMethod void CrearTarjetaJul_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardJul';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '007';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaAug_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardAug';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '010';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
   /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaSep_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardSep';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '011';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaOct_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardOct';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '012';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaNov_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardNov';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '013';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
   /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
   static testMethod void CrearTarjetaDec_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardDec';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '014';

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
        insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	11/11/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
   static testMethod void CrearTarjetaNoLogin_Test(){
       R1_CLS_LogHelper.throw_exception = false;
       
       List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
       
       R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
       ep.Name='R2';
       ep.R1_CHK_Activo__c=true;
       ep.R1_TXT_EndPoint__c='Prueba';
       lst_ep.add(ep);
       
       insert lst_ep;
       
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '016';
       
       Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
       
       Test.startTest();
		insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);       
        Test.stopTest();
       
       System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

   }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaError401_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCard401';
        lst_ep.add(ep);
        
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
       
       insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '015';
		
       
       Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
       
       Test.startTest();
		insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);       
        Test.stopTest();
       
       System.assertEquals(1, [SELECT count() FROM R1_Log__c]);

   }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaStatusErroneo_Test(){
        R1_CLS_LogHelper.throw_exception = false;
       
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
       
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='R2_Gift_Card';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaGiftCardStatusErroneo';
        lst_ep.add(ep);
        
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        
        insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '020';
        
        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
        
        Test.startTest();
		insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjeta(idWO);       
        Test.stopTest();
       
       System.assertEquals(1, [SELECT count() FROM R1_Log__c]);

   }
     /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/10/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void CrearTarjetaContador_Test(){
       R1_CLS_LogHelper.throw_exception = false;
       
       List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
       
       R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
       ep.Name='R2_Gift_Card';
       ep.R1_CHK_Activo__c=true;
       ep.R1_TXT_EndPoint__c='PruebaGiftCardStatusErroneo';
       lst_ep.add(ep);
        
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
               
       insert lst_ep;
        
        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert casoPa;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc;  

        R2_Work_Order__c WO = R1_CLS_Utilities.helper_Work_Order_constructor(casoPa.id, acc.id);
        WO.R2_WO_TXT_OT__c = '090';
		
       Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
       
       Test.startTest();
		insert WO;
        String idWO = String.valueOf(WO.Id);        
        R2_CLS_GiftCard.CrearTarjetaResponse(idWO, 3);       
        Test.stopTest();
       
       System.assertEquals(1, [SELECT count() FROM R1_Log__c]);

   }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Sara Torres Bermúdez
	Company:        Accenture
	Description:                

	History: 
	 <Date>                     <Author>                         <Change Description>
	11/11/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_GiftCard.CrearTarjeta(null);
        R2_CLS_GiftCard.CrearTarjetaResponse(null, null);
    }

}