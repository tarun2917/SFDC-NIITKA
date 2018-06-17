/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Apex test de la clase apex "R1_Cases_RelatedList_CTRL"
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_Cases_RelatedList_CTRL_Test {
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion init()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/10/2017       	   Jaime Ascanta                   			 add (acc.PersonBirthdate = Date.newInstance(1990, 12, 31))
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void init_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);

        insert acc;
  
        Id recordTypeIdCase = [SELECT Id FROM recordType WHERE Name like 'Asistencia' LIMIT 1].Id;
        List<Case> lstCasos = new List<Case>();
        for(Integer i=0;i<2;i++){
            Case caso = new Case();
        	caso.RecordTypeId = recordTypeIdCase;
        	caso.AccountId = acc.Id;
        	caso.Type = 'Asistencia';
        	caso.Origin = 'Email';
        	caso.Status = 'Abierto';
            lstCasos.add(caso);           
        }
        insert lstCasos; 
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);     
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.rtDeveloperName = 'R1_Asistencia';
        List<Schema.FieldSetMember> schemaTest = Schema.SObjectType.Case.FieldSets.R1_FS_Campos_Caso_RT_Asistencia.getFields();
        cR.init(schemaTest);        
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initComunicacionEntrante()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initComunicacionEntrante_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initComunicacionEntrante();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initAsistencias()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initAsistencias_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initAsistencias();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initVuelos_Obtencion()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initVuelos_Obtencion_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initVuelos_Obtencion();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initFelicitacion()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initFelicitacion_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initFelicitacion();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initIberia_Plus()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initIberia_Plus_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initIberia_Plus();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initVuelos_Redencion()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initVuelos_Redencion_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initVuelos_Redencion();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initIberia()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initIberia_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initIberia();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initProactividad()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initProactividad_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initProactividad();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initCallPass()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initCallPass_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initCallPass();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initReclamacion()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initReclamacion_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initReclamacion();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initTransferidas()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initTransferidas_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initTransferidas();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initHelp_Desk()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initHelp_Desk_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initHelp_Desk();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initCampanas_Salientes()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initCampanas_Salientes_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
       	cR.initCampanas_Salientes();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion initSalientes()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void initSalientes_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.initSalientes();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion newCase()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void newCase_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.newCase();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion showAll()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void showAll_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Account acc = new Account();
        
        Test.startTest(); 
		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
        cR.showAll();
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para cubrir los catch()
	IN:             
	OUT:            

	History: 
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        Account acc = new Account();

		ApexPages.StandardController sc = new ApexPages.StandardController(acc); 
        R1_Cases_RelatedList_CTRL cR = new R1_Cases_RelatedList_CTRL(sc);
		List<Schema.FieldSetMember> schemaTest = Schema.SObjectType.Case.FieldSets.R1_FS_Campos_Caso_RT_Asistencia.getFields();
        cR.init(schemaTest);
        cR.initAsistencias();
        cR.initCallPass();
        cR.initCampanas_Salientes();
        cR.initComunicacionEntrante();
        cR.initFelicitacion();
        cR.initHelp_Desk();
        cR.initIberia();
        cR.initIberia_Plus();
        cR.initProactividad();
        cR.initReclamacion();
        cR.initSalientes();
        cR.initTransferidas();
        cR.initVuelos_Obtencion();
        cR.initVuelos_Redencion();
        cR.newCase();
        cR.showAll();
    }
}