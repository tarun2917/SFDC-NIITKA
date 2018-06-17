@isTest
private class R2_CLS_GuPostPreviewer_CTRL_Test
{
	@isTest
	static void generarPDF_Test()
	{
		R2_CLS_GuPostPreviewer_CTRL previewer = new R2_CLS_GuPostPreviewer_CTRL();
		Test.startTest();
		previewer.generarPDF();
		Test.stopTest();
	}

	@isTest
	static void formatearBody_Test(){
		Case caso = new Case();
		Folder f = [SELECT id from Folder where Name = 'Cartas'];	
		EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-GuPostEx'];
		caso.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
		insert caso;
		
		R2_CLS_GuPostPreviewer_CTRL previewer = new R2_CLS_GuPostPreviewer_CTRL();
		Test.setCurrentPageReference(new PageReference('Page.myPage')); 
		System.currentPageReference().getParameters().put('p3_lkid', caso.id);
		System.currentPageReference().getParameters().put('idTemplate', e.id);
		Test.startTest();
		previewer.formatearBody();
		Test.stopTest();

	}
}