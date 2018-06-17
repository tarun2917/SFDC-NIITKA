/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
23/02/2018				Alvaro Garcia Tapia					Initial Version
----------------------------------------------------------------------------------------------------------------------*/

@isTest
private class CR_CLS_templateFilter_Test {
	
	@isTest static void test_mostrarTemplate_1() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
		guPost.companySelected = 'I0';
		guPost.textoSelected = 'test';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}
	
	@isTest static void test_mostrarTemplate_2() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
		guPost.companySelected = 'I0';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_3() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
		guPost.textoSelected = 'test';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_4() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.companySelected = 'I0';
		guPost.textoSelected = 'test';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_5() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_6() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.companySelected = 'I0';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_7() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.textoSelected = 'test';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}

	@isTest static void test_mostrarTemplate_8() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		Test.stopTest();
	}
		//Case caso = new Case();
		//Folder f = [SELECT id from Folder where Name = 'Cartas'];	
		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-GuPostEx'];
		//caso.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
		//insert caso;
		
		//R2_CLS_GuPostPreviewer_CTRL previewer = new R2_CLS_GuPostPreviewer_CTRL();
		//Test.setCurrentPageReference(new PageReference('Page.myPage')); 
		//System.currentPageReference().getParameters().put('p3_lkid', caso.id);
		//System.currentPageReference().getParameters().put('idTemplate', e.id);
		//Test.startTest();
		//previewer.formatearBody();
		//Test.stopTest(); 
	@isTest static void test_mostrarCasos_1() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
		guPost.companySelected = 'I0';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarCasos();
		Test.stopTest();
	}

	@isTest static void test_mostrarCasos_2() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.idiomaSelected = 'ES';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarCasos();
		Test.stopTest();
	}

	@isTest static void test_mostrarCasos_3() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
		guPost.companySelected = 'I0';
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarCasos();
		Test.stopTest();
	}

	@isTest static void test_mostrarCasos_4() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarCasos();
		Test.stopTest();
	}

	@isTest static void test_getSelected() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarCasos();
		guPost.getSelected();
		Test.stopTest();
	}

	@isTest static void test_GoBack() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.GoBack();
		Test.stopTest();
	}

	@isTest static void test_Beginning() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.Beginning();
		Test.stopTest();
	}

	@isTest static void test_Previous() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.Previous();
		Test.stopTest();
	}

	@isTest static void test_Next() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.Next();
		Test.stopTest();
	}

	@isTest static void test_End() {
		R1_CLS_LogHelper.throw_exception = false;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();
		Apexpages.currentPage().getParameters().put('p3_lkid','test1');
		Apexpages.currentPage().getParameters().put('p2_lkid','test2');
		Apexpages.currentPage().getParameters().put('p24','test3');
		Apexpages.currentPage().getParameters().put('p5','test4');
//		List<EmailTemplate> lstTemplateEmail =  [SELECT ID, Name FROM EmailTemplate WHERE Name ='EmailGuPost' order by Name limit 1];  
//System.debug(lstTemplateEmail);
//List<EmailTemplate> lst = [SELECT ID, Name, Folder.Name FROM EmailTemplate order by Name];
//System.debug(lst);
		Test.startTest();
		guPost.mostrarTemplate();
		guPost.Next();
		guPost.End();
		Test.stopTest();
	}	
	@isTest static void test_exceptions() {
		R1_CLS_LogHelper.throw_exception = true;

		//EmailTemplate e = [SELECT id from EmailTemplate where Name = 'Carta-EmailGuPost'];

		CR_CLS_templateFilter guPost = new CR_CLS_templateFilter();

		Test.startTest();
		guPost.mostrarTemplate();
		guPost.mostrarCasos();
		guPost.getSelected();
		guPost.GoBack();
		guPost.Beginning();
		guPost.Previous();
		guPost.Next();
		guPost.End();
		Test.stopTest();
	}
}