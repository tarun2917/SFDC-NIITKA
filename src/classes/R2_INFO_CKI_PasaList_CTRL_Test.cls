/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:    Apex test from class "R2_INFO_CKI_PasaList_CTRL"
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	18/10/2017       	   			Jaime Ascanta                   		Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_INFO_CKI_PasaList_CTRL_Test {
	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from method getPasajerosListParcial()
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		18/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void getPasajerosListParcial_Test() {
				R1_CLS_LogHelper.throw_exception = false;

				R1_Flight__c fli = new R1_Flight__c();
				//fli.R1_FLG_FOR_Flight_name__c = 'Test';
				fli.R1_FLG_TXT_Carrier_code__c = '000000000';
				fli.R1_FLG_TXT_Flight_number__c = '111111111111';
				fli.R1_FLG_TXT_Carrier_code_oper__c = '222222222';
				fli.R1_FLG_DAT_Flight_date_local__c = Date.today();
				fli.R1_FLG_TXT_Origin__c = 'Madrid';
				fli.R1_FLG_TXT_Destination__c = 'Paris';
				insert fli;

				List<R2_CKI_info__c> pasList = new List<R2_CKI_info__c>();
				for(Integer i = 0; i < 30; i++){
					pasList.add(new R2_CKI_info__c(Name='Pasajero '+ i, R2_CKI_LOO_Flight__c = fli.Id));
				}
				insert pasList;

				Test.startTest();

						ApexPages.StandardController sc = new ApexPages.StandardController(fli);
		        R2_INFO_CKI_PasaList_CTRL icp = new R2_INFO_CKI_PasaList_CTRL(sc);
		        icp.getPasajerosListParcial();
						//Case 1
		        Boolean pasListOk = icp.getPasajerosListParcial().isEmpty() ? false : true;
						System.assertEquals(true, pasListOk );

				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from method crearIncidencia()
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
18/10/2017       	   			Jaime Ascanta                   		Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    @isTest
    static void crearIncidencia_Test() {
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_Flight__c fli = new R1_Flight__c();
        //fli.R1_FLG_FOR_Flight_name__c = 'Test';
        fli.R1_FLG_TXT_Carrier_code__c = 'IB';
        fli.R1_FLG_TXT_Flight_number__c = '1111';
        fli.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        fli.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 05, 05);
        fli.R1_FLG_TXT_Origin__c = 'Madrid';
        fli.R1_FLG_TXT_Destination__c = 'Paris';
        insert fli;
        
        List<R2_CKI_info__c> pasList = new List<R2_CKI_info__c>();
        //Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cliente' LIMIT 1].Id;	
        
        for(Integer i = 0; i < 10; i++){
            pasList.add(new R2_CKI_info__c(Name='Pasajero '+ i, R2_CKI_LOO_Flight__c = fli.Id));
        }
        insert pasList;
        
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(fli);
        R2_INFO_CKI_PasaList_CTRL icp = new R2_INFO_CKI_PasaList_CTRL(sc);
        icp.getPasajerosListParcial();
        
        //case 1 (not selected)
        icp.crearIncidencia();
       	icp.redirectPopup();
        icp.cancelIncidencia();
        
        //case 3 (selected passenger)
        if(!icp.pasajerosListWP.isEmpty()){
            for(Integer i = 0; i < icp.pasajerosListWP.size(); i++){
                icp.pasajerosListWP[i].selected = true;
            }
        }
        
        icp.crearIncidencia();
        icp.saveIncidencia();
        
        R1_Incident__c incidentSaved = [SELECT Id, R2_INC_LOO_Flight__c FROM R1_Incident__c ORDER BY CreatedDate DESC LIMIT 1 ];
        
        System.assertEquals(fli.Id, incidentSaved.R2_INC_LOO_Flight__c);
        
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from methods of pagination
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		18/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void pagination_Test(){
				R1_CLS_LogHelper.throw_exception = false;

				R1_Flight__c fli = new R1_Flight__c();
				//fli.R1_FLG_FOR_Flight_name__c = 'Test';
				fli.R1_FLG_TXT_Carrier_code__c = '000000000';
				fli.R1_FLG_TXT_Flight_number__c = '111111111111';
				fli.R1_FLG_TXT_Carrier_code_oper__c = '222222222';
				fli.R1_FLG_DAT_Flight_date_local__c = Date.today();
				fli.R1_FLG_TXT_Origin__c = 'Madrid';
				fli.R1_FLG_TXT_Destination__c = 'Paris';
				insert fli;

				List<R2_CKI_info__c> pasList = new List<R2_CKI_info__c>();
				for(Integer i = 0; i < 30; i++){
					pasList.add(new R2_CKI_info__c(Name='Pasajero '+ i, R2_CKI_LOO_Flight__c = fli.Id));
				}
				insert pasList;

				Test.startTest();
						ApexPages.StandardController sc = new ApexPages.StandardController(fli);
						R2_INFO_CKI_PasaList_CTRL icp1 = new R2_INFO_CKI_PasaList_CTRL(sc);
						R2_INFO_CKI_PasaList_CTRL icp2 = new R2_INFO_CKI_PasaList_CTRL(sc);

						//case 1
		        icp1.getPasajerosListParcial();
						icp1.End();
						icp1.Next();
						icp1.Next();
						System.assertEquals(true, icp1.getDisableNext() );

						//case 2
		        icp2.getPasajerosListParcial();
						icp2.Beginning();
						icp2.Previous();
						icp2.Previous();
						System.assertEquals(true, icp2.getDisablePrevious() );

				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from methods of pagination (not data)
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		18/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void paginationEmpty_Test(){
				R1_CLS_LogHelper.throw_exception = false;

				R1_Flight__c fli = new R1_Flight__c();
				//fli.R1_FLG_FOR_Flight_name__c = 'Test';
				fli.R1_FLG_TXT_Carrier_code__c = '000000000';
				fli.R1_FLG_TXT_Flight_number__c = '111111111111';
				fli.R1_FLG_TXT_Carrier_code_oper__c = '222222222';
				fli.R1_FLG_DAT_Flight_date_local__c = Date.today();
				fli.R1_FLG_TXT_Origin__c = 'Madrid';
				fli.R1_FLG_TXT_Destination__c = 'Paris';
				insert fli;

				Test.startTest();
						ApexPages.StandardController sc = new ApexPages.StandardController(fli);
		        R2_INFO_CKI_PasaList_CTRL icp = new R2_INFO_CKI_PasaList_CTRL(sc);
		        icp.getPasajerosListParcial();
						//case 1
						icp.Next();
						icp.Previous();
						icp.Beginning();
						icp.End();
						icp.getDisableNext();
						icp.getDisablePrevious();

				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:    Apex test from excenptions
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		18/10/2017       	   			Jaime Ascanta                   		Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@isTest
	static void exceptions_Test(){
				R1_CLS_LogHelper.throw_exception = true;

				R1_Flight__c fli = new R1_Flight__c();
				//fli.R1_FLG_FOR_Flight_name__c = 'Test';
				fli.R1_FLG_TXT_Carrier_code__c = '000000000';
				fli.R1_FLG_TXT_Flight_number__c = '111111111111';
				fli.R1_FLG_TXT_Carrier_code_oper__c = '222222222';
				fli.R1_FLG_DAT_Flight_date_local__c = Date.today();
				fli.R1_FLG_TXT_Origin__c = 'Madrid';
				fli.R1_FLG_TXT_Destination__c = 'Paris';
				insert fli;

				Test.startTest();
						ApexPages.StandardController sc = new ApexPages.StandardController(fli);
		        R2_INFO_CKI_PasaList_CTRL icp = new R2_INFO_CKI_PasaList_CTRL(sc);

						icp.getPasajerosListParcial();
						icp.initIncidencia();
						icp.crearIncidencia();
						icp.refrescarVF();
						icp.saveIncidencia();
				Test.stopTest();

				System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


}