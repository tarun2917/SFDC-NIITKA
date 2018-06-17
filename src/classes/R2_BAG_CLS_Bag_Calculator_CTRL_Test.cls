/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    controladora de R2_BAG_VF_Bag_Calculator.page
                    -> aparece como botón en lista relacionada pagos de casos hijo
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    26/09/2017             Alberto Puerto Collado                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
@isTest
private class R2_BAG_CLS_Bag_Calculator_CTRL_Test {

    /*
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    26/09/2017             Alberto Puerto Collado                  Initial Version
    27/09/2017             Jaime Ascanta                           Modification
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_demora_test(){
        R1_CLS_LogHelper.throw_exception = false;

        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
        insert casoPadre;

        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
        insert casoHijo;
        System.debug('CASO PADRE' + casoPadre);
        System.debug('CASO HIJO' + casoHijo);

        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagAfectados = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.importeSolicitado = 100;
        R2_BAG_CLS_Bag_Calculator_CTRL.monedaSeleccionada = 'EUR';
        R2_BAG_CLS_Bag_Calculator_CTRL.comentarios = 'test coment';
        R2_BAG_CLS_Bag_Calculator_CTRL.stringAuxiliar = 'Demora';

        Test.startTest();

        cal.changeBooleans();

        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 10;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        cal.insertObjeto();


        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/09/2017                  Jaime Ascanta                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_extravio_test(){
        R1_CLS_LogHelper.throw_exception = false;
        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
        insert casoPadre;
        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
        insert casoHijo;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagAfectados = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.importeSolicitado = 100;
        R2_BAG_CLS_Bag_Calculator_CTRL.monedaSeleccionada = 'SDR';
        R2_BAG_CLS_Bag_Calculator_CTRL.comentarios = 'test coment';

        R2_BAG_CLS_Bag_Calculator_CTRL.stringAuxiliar = 'Extravío';

        Test.startTest();

        cal.changeBooleans();

        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = null;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 0;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        cal.insertObjeto();


        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


    /*
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/09/2017                  Jaime Ascanta                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_deterioro_test(){
        R1_CLS_LogHelper.throw_exception = false;
        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
        insert casoPadre;
        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
        insert casoHijo;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagAfectados = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.importeSolicitado = 100;
        R2_BAG_CLS_Bag_Calculator_CTRL.monedaSeleccionada = 'EUR';
        R2_BAG_CLS_Bag_Calculator_CTRL.comentarios = 'test coment';

        R2_BAG_CLS_Bag_Calculator_CTRL.stringAuxiliar = 'Deterioro';

        Test.startTest();

        cal.changeBooleans();

        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();


        R2_BAG_CLS_Bag_Calculator_CTRL.vip = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();
                
        cal.insertObjeto();


        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/09/2017                  Jaime Ascanta                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_falta_contenido_test(){
        R1_CLS_LogHelper.throw_exception = false;
        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
        insert casoPadre;
        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
        insert casoHijo;

        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagAfectados = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.importeSolicitado = 100;
        R2_BAG_CLS_Bag_Calculator_CTRL.monedaSeleccionada = 'EUR';
        R2_BAG_CLS_Bag_Calculator_CTRL.comentarios = 'test coment';

        R2_BAG_CLS_Bag_Calculator_CTRL.stringAuxiliar = 'FaltaContenido';

        Test.startTest();

        cal.changeBooleans();

        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = false;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();
                
        cal.insertObjeto();


        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


    /*
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/09/2017                  Jaime Ascanta                      Initial Version
    27/09/2017                  Jaime Ascanta                      Added R1_ACC_FOR_Primary_FF_Card_CCPO__c values for account
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_demoravios_test(){
        R1_CLS_LogHelper.throw_exception = false;
        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
            Account acc = R1_CLS_Utilities.helper_Account_constructor();
            acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = '12345678'; // y sobreescribe -> R1_ACC_FOR_Primary_FF_Card_CCPO__c
            insert acc;
        casoPadre.AccountID = acc.Id;
        insert casoPadre;
        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
            casoHijo.AccountID = acc.Id;
        insert casoHijo;

        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        R2_BAG_CLS_Bag_Calculator_CTRL.vip = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.rebote = true;
        R2_BAG_CLS_Bag_Calculator_CTRL.paxAffect = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDays = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagFacturados = 1;
        R2_BAG_CLS_Bag_Calculator_CTRL.bagAfectados = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.importeSolicitado = 100;
        R2_BAG_CLS_Bag_Calculator_CTRL.monedaSeleccionada = 'EUR';
        R2_BAG_CLS_Bag_Calculator_CTRL.comentarios = 'test coment';

        R2_BAG_CLS_Bag_Calculator_CTRL.stringAuxiliar = 'DisplayAvios';
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDaysAvios = 0;
        R2_BAG_CLS_Bag_Calculator_CTRL.vuelosVolados = '';

        Test.startTest();

        cal.changeBooleans();

        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.vuelosVolados = 'Business';
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDaysAvios = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();


        R2_BAG_CLS_Bag_Calculator_CTRL.delayDaysAvios = 9;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();


        R2_BAG_CLS_Bag_Calculator_CTRL.vuelosVolados = 'none';
        R2_BAG_CLS_Bag_Calculator_CTRL.delayDaysAvios = 2;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();

        R2_BAG_CLS_Bag_Calculator_CTRL.delayDaysAvios = 9;
        R2_BAG_CLS_Bag_Calculator_CTRL.asignaValores();
                
        cal.insertObjetoAvios();


        Test.stopTest();
        
        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]); -> provisional!! 20/feb/18
    }

    /*
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    27/09/2017                  Jaime Ascanta                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    
    static testMethod void bag_Calculator_currencyConverter_test(){
        R1_CLS_LogHelper.throw_exception = false;
        //Caso con flight y account
        Case casoPadre = R1_CLS_Utilities.helper_Case_constructor('Equipaje',true,true);
        insert casoPadre;
        //Caso hijo
        Case casoHijo = new Case();
        Id rt_equipaje = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        casoHijo.RecordTypeId = rt_equipaje;
        casoHijo.ParentId = casoPadre.Id;
        insert casoHijo;

        ApexPages.StandardController sc = new ApexPages.StandardController(casoHijo);
        R2_BAG_CLS_Bag_Calculator_CTRL cal = new R2_BAG_CLS_Bag_Calculator_CTRL(sc);

        Test.startTest();
        cal.currencyConverter(10, 'Euro', 'Dolar');
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


}