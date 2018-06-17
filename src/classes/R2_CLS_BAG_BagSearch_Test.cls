@isTest
private class R2_CLS_BAG_BagSearch_Test {
	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alvaro Garcia Tapia
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                     <Author>                         <Change Description>
	12/02/2018       	   	Alvaro Garcia Tapia                  Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	@isTest static void getSearch_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.getSearch();
		Test.stopTest();
	}

	@isTest static void wpDAH_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.wpDAH();
		Test.stopTest();
	}

	@isTest static void wpDAH2_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.wpDAH();
		Test.stopTest();
	}
	
	@isTest static void incidents_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.nPIR = 'MADIB98765';
			bagSearch.searchParams.pirAsociado = 'MADIB12345';
			bagSearch.searchParams.tipoIncidencia = 'DELAYED';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.searchParams.estadoIncidencia = 'Aberta';
			bagSearch.searchParams.tipoBBDD = 'Activa';
			bagSearch.incidents();
		Test.stopTest();
	}

	@isTest static void incidents2_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.pirAsociado = 'MADIB12345';
			bagSearch.searchParams.tipoIncidencia = 'DELAYED';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.searchParams.estadoIncidencia = 'Aberta';
			bagSearch.searchParams.tipoBBDD = 'Activa';
			bagSearch.incidents();
		Test.stopTest();
	}

	@isTest static void incidents3_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.incidents();
		Test.stopTest();
	}
	
	@isTest static void wpDDP_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.wpDDP();
		Test.stopTest();
	}

	@isTest static void wpDDP2_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();		
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.wpDDP();
		Test.stopTest();
	}

	@isTest static void wpPDIAHL_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.wpPDIAHL();
		Test.stopTest();
	}

	@isTest static void wpPDIAHL2_test() {
		R1_CLS_LogHelper.throw_exception = false;

		Test.startTest();		
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.wpPDIAHL();
		Test.stopTest();
	}

	@isTest static void wpPDIDPR_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.wpPDIDPR();
		Test.stopTest();
	}

	@isTest static void wpPDIDPR2_test() {
		R1_CLS_LogHelper.throw_exception = false;
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.wpPDIDPR();
		Test.stopTest();
	}

	@isTest static void wpSearching_test() {
		R1_CLS_LogHelper.throw_exception = false;

		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.wpSearching('DELAYED');
		Test.stopTest();
	}

	@isTest static void wpRetiredSearching_test() {
		R1_CLS_LogHelper.throw_exception = false;

		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.wpRetiredSearching('DELAYED');
		Test.stopTest();
	}

	@isTest static void searchRecordByPIR_test() {
		R1_CLS_LogHelper.throw_exception = false;

		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.searchRecordByPIR('DELAYED');
		Test.stopTest();
	}

	@isTest static void searchRecordByPIR_Inactive_test() {
		R1_CLS_LogHelper.throw_exception = false;

		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_SearchBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_SearchBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());
		
		Test.startTest();
			R2_CLS_BAG_BagSearch bagSearch = new R2_CLS_BAG_BagSearch();
			bagSearch.searchParams = new R2_CLS_BAG_BagSearch.Search();
			bagSearch.searchParams.nPIR = 'MADIB12345';
			bagSearch.searchParams.escala = 'MADIB';
			bagSearch.searchParams.nombrePax = 'Carlos';
			bagSearch.searchParams.fechaCreacion = '2017-12-02';
			bagSearch.searchParams.etiqueta = 'IB123456';
			bagSearch.searchRecordByPIR_Inactive('DELAYED', '2017-02-05');
		Test.stopTest();
	}	
}