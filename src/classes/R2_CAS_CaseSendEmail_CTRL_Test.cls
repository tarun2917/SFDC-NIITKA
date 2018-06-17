/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Clase test de la clase 'R2_CAS_CaseSendEmail_CTRL'
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	02/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CAS_CaseSendEmail_CTRL_Test {
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test que cubre el metodo mostrarEmails()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	02/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void mostrarEmails_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc; 
        
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
        
        Case caso = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert caso;
        
        EmailMessage email = R1_CLS_Utilities.helper_EmailMessage_constructor(caso.id);
        insert email;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R2_CAS_CaseSendEmail_CTRL cse = new R2_CAS_CaseSendEmail_CTRL(sc);
        cse.mostrarEmails();
        
        System.assertEquals(1, cse.allCorreos);
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    static testMethod void GotoPrint_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
		insert acc; 
        
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
        
        Case caso = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true);
        insert caso;
        
        EmailMessage email = R1_CLS_Utilities.helper_EmailMessage_constructor(caso.id);
        insert email; 
        
        R2_CAS_CaseSendEmail_CTRL.emailswrapper ema = new R2_CAS_CaseSendEmail_CTRL.emailswrapper(email);
      	ema.selected = True;
        
        List<R2_CAS_CaseSendEmail_CTRL.emailswrapper> listaEmails = new List<R2_CAS_CaseSendEmail_CTRL.emailswrapper>();
     	
        listaEmails.add(ema);
        system.debug('--Z' + listaEmails);
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R2_CAS_CaseSendEmail_CTRL cse = new R2_CAS_CaseSendEmail_CTRL(sc);
        cse.mostrarEmails();
        cse.GotoPrint();
        
        //System.assertEquals(1, cse.allCorreos);
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        
    }
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para cubrir los catch
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	02/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        Case caso = new Case();
        ApexPages.StandardController sc = new ApexPages.StandardController(caso);
        R2_CAS_CaseSendEmail_CTRL cse = new R2_CAS_CaseSendEmail_CTRL(sc);
        cse.mostrarEmails();
        cse.recolectarCheck();
        cse.recorrerEmailsSelected();
        cse.GotoPrint();
    }
}