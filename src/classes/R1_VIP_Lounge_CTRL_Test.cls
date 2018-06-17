/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Apex test de la clase apex "R1_VIP_Lounge_CTRL"
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R1_VIP_Lounge_CTRL_Test {
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion esInvitado()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void esInvitado_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.esInvitado();
        System.assertEquals(true,vipL.invitado);
        Test.stopTest();
    }

        /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion actualizarObservaciones()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void actualizarObservaciones_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        insert acceso;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.observaciones = 'afas';
        vipL.idC[0].Id = acceso.Id;
        vipL.actualizarObservaciones();
        System.assertEquals(vipL.idC[0].R1_VLI_ATXT_Observations__c, vipL.observaciones);
        Test.stopTest();
    }

        /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion actualizarInvitado()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void actualizarInvitado_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        insert acceso;

        List<R1_Vip_lounge_invitees__c> invitados = new List<R1_Vip_lounge_invitees__c>();
        for(Integer i = 0; i < 2; i++){
            R1_Vip_lounge_invitees__c invitado = new R1_Vip_lounge_invitees__c();
            invitado.R1_IV_MDRS_Vip_lounge_access__c = acceso.Id;
            invitado.R1_IV_LOO_Client__c = acc.Id;
            invitado.R1_IV_CHK_Ninos__c = false;
            invitados.add(invitado);
        }
        insert invitados;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.observaciones = 'afas';
        vipL.idC[0].ID=acceso.Id;
        vipL.idInteraccion = vipL.idC[0].Id;
        vipL.idInvitado = invitados[0].Id;
        vipL.actualizarInvitado();
        Test.stopTest();
    }

       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion refreshidC()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void refreshidC_Test(){
       	R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        insert acceso;

        List<R1_Vip_lounge_invitees__c> invitados = new List<R1_Vip_lounge_invitees__c>();
        for(Integer i = 0; i < 2; i++){
            R1_Vip_lounge_invitees__c invitado = new R1_Vip_lounge_invitees__c();
            invitado.R1_IV_MDRS_Vip_lounge_access__c = acceso.Id;
            invitado.R1_IV_LOO_Client__c = acc.Id;
            invitado.R1_IV_CHK_Ninos__c = false;
            invitados.add(invitado);
        }
        insert invitados;

        Salas_Vip__c salas = new Salas_Vip__c();
        salas.Name = 'LOQUESEA';
        salas.Puesto_de_trabajo__c = 'Puesto 1';
        salas.Sala_Vip__c = 'Autoridades 1';
        insert salas;



        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.VipInt.add(acceso);
        vipL.invitado = true;
		vipL.refreshidC();
        Test.stopTest();
    }

       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion refreshidC()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void refreshidC_Test02(){
       	R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.invitado = false;
		vipL.refreshidC();
        Test.stopTest();
    }

    
       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion refreshidC()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void refreshidC_Test03(){
       	R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        insert acceso;

        List<R1_Vip_lounge_invitees__c> invitados = new List<R1_Vip_lounge_invitees__c>();
        for(Integer i = 0; i < 2; i++){
            R1_Vip_lounge_invitees__c invitado = new R1_Vip_lounge_invitees__c();
            invitado.R1_IV_MDRS_Vip_lounge_access__c = acceso.Id;
            invitado.R1_IV_LOO_Client__c = acc.Id;
            invitado.R1_IV_CHK_Ninos__c = false;
            invitados.add(invitado);
        }
        insert invitados;

        Salas_Vip__c salas = new Salas_Vip__c();
        salas.Name = 'LOQUESEA';
        salas.Puesto_de_trabajo__c = 'Puesto 1';
        salas.Sala_Vip__c = 'Autoridades 1';
        insert salas;

        
        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.recupInvitado = true;
		vipL.refreshidC();
        Test.stopTest();
    }
    
       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion refreshidC()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void refreshidC_Test04(){
       	R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        insert acceso;

        List<R1_Vip_lounge_invitees__c> invitados = new List<R1_Vip_lounge_invitees__c>();
        for(Integer i = 0; i < 2; i++){
            R1_Vip_lounge_invitees__c invitado = new R1_Vip_lounge_invitees__c();
            invitado.R1_IV_MDRS_Vip_lounge_access__c = acceso.Id;
            invitado.R1_IV_LOO_Client__c = acc.Id;
            invitado.R1_IV_CHK_Ninos__c = false;
            invitados.add(invitado);
        }
        insert invitados;

        Salas_Vip__c salas = new Salas_Vip__c();
        salas.Name = 'LOQUESEA';
        salas.Puesto_de_trabajo__c = 'Puesto 1';
        salas.Sala_Vip__c = 'Autoridades 1';
        insert salas;

        
        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.recuperar = true;
		vipL.refreshidC();
        Test.stopTest();
    }
    
       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion cargarDatos()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cargarDatos_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.cargarDatos();
        Test.stopTest();
    }

       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion cambiaSala()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cambiaSala_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        Salas_Vip__c salas = new Salas_Vip__c();
        salas.Name = 'LOQUESEA';
        salas.Puesto_de_trabajo__c = 'Puesto 1';
        salas.Sala_Vip__c = 'Autoridades 1';
        insert salas;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.cambiaSala();
        Test.stopTest();
    }

       /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para la funcion forzarEntrada()
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	03/05/2017       	   Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
     static testMethod void forzarEntrada_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        acceso.R1_VLI_PKL_Access_status__c = 'Denegado';
        insert acceso;

        Test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.idC[0].Id = acceso.Id;
        vipL.forzarEntrada();
        Test.stopTest();
    }

  /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion setSala()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    03/05/2017             Rubén Pingarrón Jerez                   Initial Version
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void setSala_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        String sala = 'Autoridades Puesto 1';
        vipL.setSala(sala);
        //System.assertEquals([SELECT count() FROM R1_Log__c], 0);
        Test.stopTest();
        //List<R1_Log__c> logs = [SELECT Id FROM R1_Log__c];
        //System.debug('Logs:' + logs);
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
        //System.assertEquals(logs.size(),0);
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
    17/10/2017             Jaime Ascanta                            completar campo obligatorio (PersonBirthdate) al crear una cuenta
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        //User usu = [SELECT Id FROM User WHERE UserName = 'r.pingarron.jerez@accenture.com.service' LIMIT 1];
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_CHK_skip_validation_Rules__c = true;
        bpass.R1_TXT_Objects__c = 'Account';
        insert bpass;

        List<R1_byPass__c> lstBpass = [SELECT Id, Name, SetupOwnerId, R1_TXT_Objects__c, R1_CHK_skip_trigger__c, R1_CHK_skip_validation_Rules__c FROM R1_byPass__c];
        System.debug(lstBpass);

        Id recordTypeIdAcc = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account acc = new Account();
        acc.RecordTypeId = recordTypeIdAcc;
        acc.LastName = 'TestAcc';
        acc.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert acc;

        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        R1_VIP_Lounge_CTRL vipL = new R1_VIP_Lounge_CTRL(sc);
        vipL.esInvitado();
        vipL.actualizarInvitado();
        vipL.actualizarObservaciones();
        vipL.cambiaSala();
        vipL.cargarDatos();
        vipL.forzarEntrada();
        vipL.refreshidC();
        vipL.puesto();
        vipL.SetSala(null);
        vipL.recuperarAcceso();
        vipL.recuperarInvitado();
        vipL.limpiaID();
        vipL.saltaPopUp();
    }
}