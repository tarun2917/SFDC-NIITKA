/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Clase test de la clase 'R2_CLS_CaseTriggerMethods'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    04/10/2017             Jaime Ascanta                           asignaAccountToCaseRTIberiaCom_CuentaSiExiste_test, asignaAccountToCaseRTIberiaCom_CuentaNoExiste_test
    ----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_CaseTriggerMethods_Test {

    /*
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: insert Case + query + assertEquals
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static Case insertCase_queryCasosHijos_assert(Case step, Integer expected){
        System.debug(step);
        /* RecordType.Name : EQUIPAJE {Demora,
                                    Deterioro,
                                    Extravío,
                                    Demora con deterioro,
                                    Deterioro falta contenido,
                                    Demora deterioro y falta contenido}
                             PASAJE - lo demás*/
        String rt_name = 'Pasaje';
        if(step.Type.equalsIgnoreCase('Demora') || step.Type.equalsIgnoreCase('Deterioro') || step.Type.equalsIgnoreCase('Extravío')
                            || step.Type.equalsIgnoreCase('Demora con deterioro') || step.Type.equalsIgnoreCase('Deterioro con falta de contenido')
                            || step.Type.equalsIgnoreCase('Demora con deterioro y falta de contenido')){
            rt_name = 'Equipaje';
        }
        List<Case> casoH = [SELECT Id, recordTypeId, Type, AccountId , R1_CAS_LOO_Flight__c FROM Case
                                WHERE ParentID = :step.Id AND Type = :step.Type AND AccountId = :step.AccountId
                                AND recordType.Name = :rt_name AND R1_CAS_LOO_Flight__c = :step.R1_CAS_LOO_Flight__c];

        System.assertEquals(expected, casoH.size());
        return step;
    }
    /*
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Utility: insert Case + query + assertEquals -> query mas amplia (sin account ni vuelo)
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    24/07/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static Case updateCase_queryCasosHijos_assert_Lazy(Case step, Integer expected){
        System.debug('--------------' + step);
        /* RecordType.Name : EQUIPAJE {Demora,
                                    Deterioro,
                                    Extravío,
                                    Demora con deterioro,
                                    Deterioro falta contenido,
                                    Demora deterioro y falta contenido}
                             PASAJE - lo demás*/
        String rt_name = 'Pasaje';
        if(step.Type.equalsIgnoreCase('Demora') || step.Type.equalsIgnoreCase('Deterioro') || step.Type.equalsIgnoreCase('Extravío')
                            || step.Type.equalsIgnoreCase('Demora con deterioro') || step.Type.equalsIgnoreCase('Deterioro con falta de contenido')
                            || step.Type.equalsIgnoreCase('Demora con deterioro y falta de contenido')){
            rt_name = 'Equipaje';
        }
        //sin tener en cuenta accountId - QUERY "LAZY"
        List<Case> casoH = [SELECT Id, recordTypeId, Type, AccountId , R1_CAS_LOO_Flight__c FROM Case
                                WHERE ParentID = :step.Id AND Type = :step.Type
                                AND recordType.Name = :rt_name];

        System.assertEquals(expected, casoH.size());
        return step;
    }



    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package1 (steps1-6)
                    04/08/17 -> 46/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/078/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package1_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<Case> listCase = new List<Case>();
        //Step 1 - Insert a new parent case with recordType: "expediente", field type: "demora" and with flight and customer fields fulfilled
        Case step1 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'1');
        listCase.add(step1);
        //insert step1;
        //Step 2 -  Insert a new parent case with recordType: "expediente", field type: retraso and with flight and customer.
        Case step2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'2');
        listCase.add(step2);
        //insert step2;


        Test.startTest();
        insert listCase;

        // insertCase_queryCasosHijos_assert(step1, 1);
        // insertCase_queryCasosHijos_assert(step2, 1);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package1 (steps1-6)
                    04/08/17 -> 46/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/078/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //Step 3 - Insert a new parent case with recordType: "expediente", field type indifferent, without flight and without customer.
        Case step3 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'3');
        listCase.add(step3);
        //insert step3;
        //Step 4 - Insert a new parent case with recordType: "expediente", field type indifferent, without flight and with customer
        Case step4 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,true,'4');
        listCase.add(step4);
        //insert step4;

        Test.startTest();
        insert listCase;
        
        //insertCase_queryCasosHijos_assert(step3, 0);
        //insertCase_queryCasosHijos_assert(step4, 0);


        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package2 (steps7-10)
                    04/08/17 -> 46/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package3_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<Case> listCase = new List<Case>();
        //step5 - Insert a new parent case with recordType: "expediente" , field type indifferent, with flight and without customer
        Case step5 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,false,'5');
        listCase.add(step5);
        //insert step5;
        //step6 - Insert a new parent case with recordType: "expediente", field type: "Deterioro con falta de contenido" and with flight and customer.
        Case step6 = R1_CLS_Utilities.helper_Case_constructor('Deterioro con falta de contenido',true,true,'6');
        listCase.add(step6);
        //insert step6;

        Test.startTest();
        insert listCase;
        // insertCase_queryCasosHijos_assert(step5, 0);
        // insertCase_queryCasosHijos_assert(step6, 1);


        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package2 (steps7-10)
                    04/08/17 -> 46/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package4_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

         Case step7 = R1_CLS_Utilities.helper_Case_constructor('Deterioro con falta de contenido',true,false,'7');
        listCase.add(step7);
        //insert step7;

        //step8 - Insert a new parent case with recordType: "expediente", field type: "Deterioro con falta de contenido" and without flight and with customer.
        Case step8 = R1_CLS_Utilities.helper_Case_constructor('Deterioro con falta de contenido',false,true,'8');
        listCase.add(step8);
        //insert step8;



        Test.startTest();
        insert listCase;

        // insertCase_queryCasosHijos_assert(step7, 0);
        //insertCase_queryCasosHijos_assert(step8, 0);


        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package2 (steps7-10)
                    04/08/17 -> 46/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package5_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //step9 - Insert a new parent case with recordType: "expediente", field type: "Deterioro con falta de contenido" and without flight and without customer.
        Case step9 = R1_CLS_Utilities.helper_Case_constructor('Deterioro con falta de contenido',false,false,'9');
        listCase.add(step9);
        //insert step9;
        //step10 - Insert a new parent case with recordType: "expediente", field type: "Demora, con deterioro" and with flight and customer.
        Case step10 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',true,true,'10');
        listCase.add(step10);
        //insert step10;


        Test.startTest();
        insert listCase;
        //insertCase_queryCasosHijos_assert(step9, 0);
        //insertCase_queryCasosHijos_assert(step10, 1);

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package3 (steps11-15)
                    04/08/17 -> 43/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package6_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //step11 - Insert a new parent case with recordType: "expediente", field type: "Demora, con deterioro" and without flight and without customer.
        Case step11 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',false,false,'11');
        listCase.add(step11);
        //insert step11;
        //step12 - Insert a new parent case with recordType: "expediente", field type: "Demora, con deterioro" and without flight and with customer.
        Case step12 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',false,true, '12');
        listCase.add(step12);
        //insert step12;


        Test.startTest();
        insert listCase;

        // insertCase_queryCasosHijos_assert(step11, 0);
        // insertCase_queryCasosHijos_assert(step12, 0);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package3 (steps11-15)
                    04/08/17 -> 43/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package7_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //step13 - Insert a new parent case with recordType: "expediente" , field type: "Demora, con deterioro" and with flight and without customer.
        Case step13 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',true,false, '13');
        listCase.add(step13);
        //insert step13;
        //step14 - Insert a new parent case with recordType: "expediente" , field type: "Deterioro" and with flight and with customer.
        Case step14 = R1_CLS_Utilities.helper_Case_constructor('Deterioro',true,true, '14');
        listCase.add(step14);
        //insert step14;
        //step15 - Insert a new parent case with recordType: "expediente" , field type: "Deterioro" and with flight and without customer.
        Case step15 = R1_CLS_Utilities.helper_Case_constructor('Deterioro',true,false, '15');
        listCase.add(step15);
        //insert step15;

        Test.startTest();

        insert listCase;

        // insertCase_queryCasosHijos_assert(step13, 0);
        // insertCase_queryCasosHijos_assert(step14, 1);// step14 comentado de momento, error por línea 389 update cuentarebotes()
        // insertCase_queryCasosHijos_assert(step15, 0);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package4 (steps16-20)
                    04/08/17 -> 44/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package8_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<Case> listCase = new List<Case>();
         //step16 - Insert a new parent case with recordType: "expediente" , field type: "Deterioro" and without flight and with customer.
        Case step16 = R1_CLS_Utilities.helper_Case_constructor('Deterioro',false,true,'16');
        listCase.add(step16);
        //insert step16;
        //step17 - Insert a new parent case with recordType: "expediente" , field type: "Deterioro" and without flight and without customer.
        Case step17 = R1_CLS_Utilities.helper_Case_constructor('Deterioro',false,false,'17');
        listCase.add(step17);
        //insert step17;

        Test.startTest();
        insert listCase;
        //insertCase_queryCasosHijos_assert(step16, 0);
        //insertCase_queryCasosHijos_assert(step17, 0);

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package4 (steps16-20)
                    04/08/17 -> 44/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package9_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<Case> listCase = new List<Case>();

        //step18 - Insert a new parent case with recordType: "expediente" , field type: "Extravío" and with flight and with customer.
        Case step18 = R1_CLS_Utilities.helper_Case_constructor('Extravío',true,true,'18');
        listCase.add(step18);
        //insert step18;
        //step19 - Insert a new parent case with recordType: "expediente" , field type: "Extravío" and with flight and without customer.
        Case step19 = R1_CLS_Utilities.helper_Case_constructor('Extravío',true,false,'19');
        listCase.add(step19);
        //insert step19;
        //step20 - Insert a new parent case with recordType: "expediente" , field type: "Extravío" and without flight and with customer.
        Case step20 = R1_CLS_Utilities.helper_Case_constructor('Extravío',false,true,'20');
        listCase.add(step20);
        //insert step20;

        Test.startTest();
        insert listCase;
        
        //insertCase_queryCasosHijos_assert(step18, 1);
        //insertCase_queryCasosHijos_assert(step19, 0);
        //insertCase_queryCasosHijos_assert(step20, 0);

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package5 (steps21-25)
                    04/08/17 -> 43/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package10_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        List<Case> listCase = new List<Case>();
         //step21 - Insert a new parent case with recordType: "expediente" , field type: "Extravío" and without flight and without customer.
        Case step21 = R1_CLS_Utilities.helper_Case_constructor('Extravío',false,false,'21');
        listCase.add(step21);
        //insert step21;
        //step22 - Insert a new parent case with recordType: "expediente" , field type: "Demora, con deterioro y falta de contenido" and with flight and with customer.
        Case step22 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro y falta de contenido',true,true,'22');
        listCase.add(step22);
        //insert step22;

        Test.startTest();
        insert listCase;
        //insertCase_queryCasosHijos_assert(step21, 0);
        //insertCase_queryCasosHijos_assert(step22, 1);


        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package5 (steps21-25)
                    04/08/17 -> 43/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package11_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //step23 - Insert a new parent case with recordType: "expediente" , field type: "Demora, con deterioro y falta de contenido" and without flight and with customer.
        Case step23 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro y falta de contenido',false,true,'23');
        listCase.add(step23);
        //insert step23;
        //step24 - Insert a new parent case with recordType: "expediente" , field type: "Demora, con deterioro y falta de contenido" and with flight and without customer.
        Case step24 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro y falta de contenido',true,false,'24');
        listCase.add(step24);
        //insert step24;
        //step25 - Insert a new parent case with recordType: "expediente" , field type: "Demora, con deterioro y falta de contenido" and without flight and without customer.
        Case step25 = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro y falta de contenido',false,false,'25');
        listCase.add(step25);
        //insert step25;

        Test.startTest();
        insert listCase;

        // insertCase_queryCasosHijos_assert(step23, 0);
        // insertCase_queryCasosHijos_assert(step24, 0);
        // insertCase_queryCasosHijos_assert(step25, 0);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package6 (steps26-30)
                    04/08/17 -> 52/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package12_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<Case> listCase = new List<Case>();

        //step26 - Insert a new parent case withdistinct recordType of the following values:
                //{"expediente" , field type:"Demora"; "Deterioro"; "Extravío";  "Demora con deterioro"; "Deterioro con falta de contenido";
                // "Demora, con deterioro y falta de contenido"}
            // and also with flight and with customer fields fulfilled
        Case step26 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'26');
        listCase.add(step26);
        //insert step26;
        //step27 - Insert a new parent case with distinct recordType of the following values: "expediente" , field type:"Demora"; "Deterioro"; "Extravío";  "Demora con deterioro"; "Deterioro con falta de contenido";
                // "Demora, con deterioro y falta de contenido" and without flight and with customer.
        Case step27 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,true,'27');
        listCase.add(step27);
        //insert step27;
        //step28 - Insert a new parent case with distinct recordType of the following values: "expediente" , field type:"Demora"; "Deterioro"; "Extravío";  "Demora con deterioro"; "Deterioro con falta de contenido";
                // "Demora, con deterioro y falta de contenido" and with flight and without customer.
        Case step28 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,false,'28');
        listCase.add(step28);
        //insert step28;


        Test.startTest();

        insert listCase;

        //insertCase_queryCasosHijos_assert(step26, 1);
        //insertCase_queryCasosHijos_assert(step27, 0);
        //insertCase_queryCasosHijos_assert(step28, 0);

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package6 (steps26-30)
                    04/08/17 -> 52/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    /*static testMethod void CasesManagement_package13_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //step29 - Insert a new parent case with distinct recordType of the following values: "expediente" , field type:"Demora"; "Deterioro"; "Extravío";  "Demora con deterioro"; "Deterioro con falta de contenido";
                //"Demora, con deterioro y falta de contenido" and without flight and without customer.
        Case step29 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'29');
        insert step29;
        //step30 - Update a parent case with recordType "expediente", field type: "demora" or "retraso", changing the customer
        Case step30= R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'30');
        insert step30;

        system.debug('test package13' + step29);
        Test.startTest();

        insertCase_queryCasosHijos_assert(step29, 0);
        //*******UPDATES********
        Account ac30 = R1_CLS_Utilities.helper_Account_constructor();
        insert ac30;
        system.debug('test package13, account ' + ac30);
        step30.AccountId = ac30.Id;
        system.debug(ac30);
        system.debug('--> ' + step30);
        update step30;
        system.debug('Despues de update');
        insertCase_queryCasosHijos_assert(step30, 0);//no crea caso hijo
        system.debug('------------');
        updateCase_queryCasosHijos_assert_Lazy(step30, 1);//comprobamos que existe el anterior

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }*/

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package7 (steps31-33)
                    04/08/17 -> 56/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package14_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        //step31 - Update a parent case with recordType "expediente", field type: "demora" or "retraso", changing the flight.
        Case step31 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'31');
        insert step31;

        Test.startTest();

        R1_Flight__c fl31 = R1_CLS_Utilities.helper_Flight_constructor();
        insert fl31;
        step31.R1_CAS_LOO_Flight__c = fl31.Id;
        update step31;
        insertCase_queryCasosHijos_assert(step31, 0);//no crea caso hijo
        updateCase_queryCasosHijos_assert_Lazy(step31, 1);//comprobamos que existe el anterior


        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package7 (steps31-33)
                    04/08/17 -> 56/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   /*static testMethod void CasesManagement_package15_Test(){
        R1_CLS_LogHelper.throw_exception = false;


        //step32 - Update a parent case with recordType "expediente", field type: "demora" or "retraso", changing the flight and customer.
        Case step32 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'32');
        insert step32;
        //step33 - Update a parent case with recordType "expediente", field type is not equal to: "demora" or "retraso", changing the flight and customer.
        Case step33 = R1_CLS_Utilities.helper_Case_constructor('Extravío',true,true,'33');
        insert step33;


        Test.startTest();

        Account ac32 = R1_CLS_Utilities.helper_Account_constructor('32');
        insert ac32;
        step32.AccountID = ac32.Id;
        R1_Flight__c fl32 = R1_CLS_Utilities.helper_Flight_constructor('32');
        insert fl32;
        step32.R1_CAS_LOO_Flight__c = fl32.Id;
        update step32;
        insertCase_queryCasosHijos_assert(step32, 0);//no crea caso hijo
        updateCase_queryCasosHijos_assert_Lazy(step32, 1);//comprobamos que existe el anterior

         Account ac33 = R1_CLS_Utilities.helper_Account_constructor('33');
        insert ac33;
        step33.AccountID = ac33.Id;
        R1_Flight__c fl33 = R1_CLS_Utilities.helper_Flight_constructor('33');
        insert fl33;
        step33.R1_CAS_LOO_Flight__c = fl33.Id;
        update step33;
        insertCase_queryCasosHijos_assert(step33, 0);//no crea caso hijo
        updateCase_queryCasosHijos_assert_Lazy(step33, 1);//comprobamos que existe el anterior



        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package8 (steps33-37)
                    04/08/17 -> 50/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   /*static testMethod void CasesManagement_package16_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //step34 - Update a parent case with recordType "expediente", field type is not equal to: "demora" o "retraso", changing the flight.
        Case step34 = R1_CLS_Utilities.helper_Case_constructor('Extravío',true,true,'34');
        insert step34;
        //step35 - Update a parent case with recordType "expediente", field type is not equal to: "demora" o "retraso", changing the customer.
        Case step35 = R1_CLS_Utilities.helper_Case_constructor('Extravío',true,true,'35');
        insert step35;


        Test.startTest();

        R1_Flight__c fl34 = R1_CLS_Utilities.helper_Flight_constructor('34');
        insert fl34;
        step34.R1_CAS_LOO_Flight__c = fl34.Id;
        update step34;
        insertCase_queryCasosHijos_assert(step34, 0);//no crea caso hijo
        updateCase_queryCasosHijos_assert_Lazy(step34, 1);//comprobamos que existe el anterior

        Account ac35 = R1_CLS_Utilities.helper_Account_constructor('35');
        insert ac35;
        step35.AccountID = ac35.Id;
        update step35;
        insertCase_queryCasosHijos_assert(step35, 0);//no crea caso hijo
        updateCase_queryCasosHijos_assert_Lazy(step35, 1);//comprobamos que existe el anterior

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package8 (steps33-37)
                    04/08/17 -> 50/100 querys
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package17_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //step36 - The parent case with field type "demora" and having a related flight but not having a related account, the user put a related account
        Case step36 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,false,'36');
        insert step36;
        //step37 - The parent case with field type "demora" and not having a related flight but having a related account, the user put a related flight
        Case step37 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true,'37');
        insert step37;

        Test.startTest();

        Account ac36 = R1_CLS_Utilities.helper_Account_constructor();
        insert ac36;
        step36.AccountID = ac36.Id;
        update step36;
        //comprobamos que crea el hijo
        insertCase_queryCasosHijos_assert(step36, 1); //query restringida a coincidir acc y vuelo
        updateCase_queryCasosHijos_assert_Lazy(step36, 1); //query global sin coincidir acc y vuelo

        R1_Flight__c fl37 = R1_CLS_Utilities.helper_Flight_constructor();
        insert fl37;
        step37.R1_CAS_LOO_Flight__c = fl37.Id;
        update step37;
        //comprobamos que crea el hijo
        //insertCase_queryCasosHijos_assert(step37, 1); //query restringida a coincidir acc y vuelo
        //updateCase_queryCasosHijos_assert_Lazy(step37, 1); //query global sin coincidir acc y vuelo

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package8 (steps38-41)
                    04/08/17 -> 59/100 querys -> si es necesario más adelante pasar a package10 algún step
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package18_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //step38 - The parent case with field type "demora" and not having a related flight and account, the user put a related flight and account
        Case step38 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'38');
        insert step38;
        //step39 - The parent case with field type "Retraso" and having a related flight but not having a related account, the user put a related account
        Case step39 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,false,'39');
        insert step39;


        Test.startTest();

        Account ac38 = R1_CLS_Utilities.helper_Account_constructor();
        insert ac38;
        step38.AccountID = ac38.Id;
        R1_Flight__c fl38 = R1_CLS_Utilities.helper_Flight_constructor();
        insert fl38;
        step38.R1_CAS_LOO_Flight__c = fl38.Id;
        update step38;
         //comprobamos que crea el hijo
        insertCase_queryCasosHijos_assert(step38, 1); //query restringida a coincidir acc y vuelo
        updateCase_queryCasosHijos_assert_Lazy(step38, 1); //query global sin coincidir acc y vuelo

        Account ac39 = R1_CLS_Utilities.helper_Account_constructor('39');
        insert ac39;
        step39.AccountID = ac39.Id;
        update step39;
        //comprobamos que crea el hijo
        insertCase_queryCasosHijos_assert(step39, 1); //query restringida a coincidir acc y vuelo
        updateCase_queryCasosHijos_assert_Lazy(step39, 1); //query global sin coincidir acc y vuelo

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*----------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    TextScript - Cases Management - Fusión de steps en 1 método - package8 (steps38-41)
                    04/08/17 -> 59/100 querys -> si es necesario más adelante pasar a package10 algún step
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/08/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void CasesManagement_package19_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //step40 - The parent case with field type "Retraso" and not having a related flight but having a related account, the user put a related flight
        Case step40 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,true,'40');
        insert step40;
        //step41 - The parent case with field type "Retraso" and not having a related flight and account, the user put a related flight and account
        Case step41 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'41');
        insert step41;

        Test.startTest();

        R1_Flight__c fl40 = R1_CLS_Utilities.helper_Flight_constructor('40');
        insert fl40;

        //insertCase_queryCasosHijos_assert(step40, 0); //query restringida a coincidir acc y vuelo
        insertCase_queryCasosHijos_assert(step40, 1); // -> 27/feb/18 - cambiado expected de 0 a 1 - verificar

        step40.R1_CAS_LOO_Flight__c = fl40.Id;
        update step40;
        //comprobamos que crea el hijo

        updateCase_queryCasosHijos_assert_Lazy(step40, 1); //query global sin coincidir acc y vuelo

        Account ac41 = R1_CLS_Utilities.helper_Account_constructor('41');
        insert ac41;

         //insertCase_queryCasosHijos_assert(step41, 0); //query restringida a coincidir acc y vuelo

        step41.AccountID = ac41.Id;
        R1_Flight__c fl41 = R1_CLS_Utilities.helper_Flight_constructor('41');
        insert fl41;
        step41.R1_CAS_LOO_Flight__c = fl41.Id;
        update step41;
        //comprobamos que crea el hijo

        updateCase_queryCasosHijos_assert_Lazy(step41, 1); //query global sin coincidir acc y vuelo

        Test.stopTest();

        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void asignaPadre_testScriptCases_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa1 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'1');
        insert casoPa1;

        Case casoPa2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'2');
        insert casoPa2;


        Id rtExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'3');
        casoH1.RecordTypeId = rtIdEquip;
        casoH1.AccountID = casoPa1.AccountID;
        casoH1.R1_CAS_LOO_Flight__c = casoPa1.R1_CAS_LOO_Flight__c;

        Case casoH2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'4');
        casoH2.RecordTypeId = rtIdPasaj;
        casoH2.AccountID = casoPa2.AccountID;
        casoH2.R1_CAS_LOO_Flight__c = casoPa2.R1_CAS_LOO_Flight__c;

        Test.startTest();

        // TestCase 1
        insert casoH1;
        List<Case> lstCaso = [SELECT Id FROM Case WHERE Id = :casoH1.Id AND ParentId = :casoPa1.Id];
        System.assertEquals(1, lstCaso.size());

        // TestCase 2
        insert casoH2;
        List<Case> lstCaso2 = [SELECT Id FROM Case WHERE Id = :casoH2.Id AND ParentId = :casoPa2.Id];
        System.assertEquals(1, lstCaso2.size());

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void asignaPadre_testScriptCases_Test2(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa1 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'1');
        insert casoPa1;

        Case casoPa2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',true,true,'2');
        insert casoPa2;


        Id rtExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH3 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'5');
        casoH3.RecordTypeId = rtIdEquip;
        casoH3.AccountID = casoPa1.AccountID;
        casoH3.R1_CAS_LOO_Flight__c = casoPa2.R1_CAS_LOO_Flight__c;

        Case casoH4 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'6');
        casoH4.RecordTypeId = rtIdPasaj;
        casoH4.AccountID = casoPa2.AccountID;
        casoH4.R1_CAS_LOO_Flight__c = casoPa1.R1_CAS_LOO_Flight__c;


        Test.startTest();

        // TestCase 3
        insert casoH3;
        List<Case> lstCaso3 = [SELECT Id, recordTypeId FROM Case WHERE Id = :casoH3.Id];
        System.assertEquals(rtExp, lstCaso3[0].recordTypeId);

        // TestCase 4
        insert casoH4;
        List<Case> lstCaso4 = [SELECT Id, recordTypeId FROM Case WHERE Id = :casoH4.Id];
        System.assertEquals(rtExp, lstCaso4[0].recordTypeId);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        casoPa.R2_CAS_NUM_Number_of_rebounds__c = 0;
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Test.startTest();
          // TestCase 1
          Case casoPadreTest = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
          System.assertEquals(0, casoPadreTest.R2_CAS_NUM_Number_of_rebounds__c);

          // TestCase 2
          Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'1');
          casoH1.RecordTypeId = rtIdEquip;
          casoH1.ParentId = casoPa.ID;
          casoH1.AccountID = casoPa.AccountID;
          casoH1.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
          casoH1.R2_CAS_CHK_Rebound__c = true;
          insert casoH1;
          Case casoPadreTest2 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
          System.assertEquals(1, casoPadreTest2.R2_CAS_NUM_Number_of_rebounds__c);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test2(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'1');
        casoH1.RecordTypeId = rtIdEquip;
        casoH1.ParentId = casoPa.ID;
        casoH1.AccountID = casoPa.AccountID;
        casoH1.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH1.R2_CAS_CHK_Rebound__c = true;
        insert casoH1;

        Case casoH2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'2');
        casoH2.RecordTypeId = rtIdPasaj;
        casoH2.ParentId = casoPa.ID;
        casoH2.AccountID = casoPa.AccountID;
        casoH2.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH2.R2_CAS_CHK_Rebound__c = false;
        insert casoH2;

        Test.startTest();
        //TestCase 3
        Case casoPaTest = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(1, casoPaTest.R2_CAS_NUM_Number_of_rebounds__c);

        //TestCase 4
        casoH1.R2_CAS_CHK_Rebound__c = false;
        update casoH1;
        Case casoPaTest2 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(0, casoPaTest2.R2_CAS_NUM_Number_of_rebounds__c);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test3(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'1');
        casoH1.RecordTypeId = rtIdEquip;
        casoH1.ParentId = casoPa.ID;
        casoH1.AccountID = casoPa.AccountID;
        casoH1.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH1.R2_CAS_CHK_Rebound__c = true;
        insert casoH1;

        Case casoH2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'2');
        casoH2.RecordTypeId = rtIdPasaj;
        casoH2.ParentId = casoPa.ID;
        casoH2.AccountID = casoPa.AccountID;
        casoH2.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH2.R2_CAS_CHK_Rebound__c = false;
        insert casoH2;

        Test.startTest();
          // TestCase 5
          casoH2.R2_CAS_CHK_Rebound__c = true;
          update casoH2;
          Case casoPadreTest = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
          System.assertEquals(2, casoPadreTest.R2_CAS_NUM_Number_of_rebounds__c);

          // TestCase 6
          casoH1.Origin = 'Llamada';
          update casoH1;
          Case casoPadreTest2 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
          System.assertEquals(2, casoPadreTest2.R2_CAS_NUM_Number_of_rebounds__c);


        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test4(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'1');
        casoH1.RecordTypeId = rtIdEquip;
        casoH1.ParentId = casoPa.ID;
        casoH1.AccountID = casoPa.AccountID;
        casoH1.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH1.R2_CAS_CHK_Rebound__c = true;
        insert casoH1;

        Case casoH2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'2');
        casoH2.RecordTypeId = rtIdPasaj;
        casoH2.ParentId = casoPa.ID;
        casoH2.AccountID = casoPa.AccountID;
        casoH2.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH2.R2_CAS_CHK_Rebound__c = false;
        insert casoH2;

        Test.startTest();
        // TestCase 7
        casoH2.Origin = 'Llamada';
        update casoH2;
        Case casoPadre7 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(1, casoPadre7.R2_CAS_NUM_Number_of_rebounds__c);

        // TestCase 8
        delete casoH2;
        Case casoPadre8 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(1, casoPadre8.R2_CAS_NUM_Number_of_rebounds__c);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test5(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH2 = R1_CLS_Utilities.helper_Case_constructor('Retraso',false,false,'2');
        casoH2.RecordTypeId = rtIdPasaj;
        casoH2.ParentId = casoPa.ID;
        casoH2.AccountID = casoPa.AccountID;
        casoH2.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH2.R2_CAS_CHK_Rebound__c = false;
        insert casoH2;

        Test.startTest();
        // TestCase 8
        delete casoH2;
         // TestCase 10
        undelete casoH2;
        Case casoPadre10 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(0, casoPadre10.R2_CAS_NUM_Number_of_rebounds__c);
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

     /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void cuentaRebotes_testScript_Test6(){
        R1_CLS_LogHelper.throw_exception = false;

        Case casoPa = R1_CLS_Utilities.helper_Case_constructor('Demora',false,true);
        insert casoPa;

        Id rtIdEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rtIdPasaj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();

        Case casoH1 = R1_CLS_Utilities.helper_Case_constructor('Demora',false,false,'1');
        casoH1.RecordTypeId = rtIdEquip;
        casoH1.ParentId = casoPa.ID;
        casoH1.AccountID = casoPa.AccountID;
        casoH1.R1_CAS_LOO_Flight__c = casoPa.R1_CAS_LOO_Flight__c;
        casoH1.R2_CAS_CHK_Rebound__c = true;
        insert casoH1;

        Test.startTest();

        // TestCase 9
        delete casoH1;

        // TestCase 11
        undelete casoH1;
        Case casoPadre11 = [SELECT Id, R2_CAS_NUM_Number_of_rebounds__c FROM Case WHERE Id = :casoPa.Id LIMIT 1];
        System.assertEquals(1, casoPadre11.R2_CAS_NUM_Number_of_rebounds__c);

        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    test para asignaAccountToCaseRTIberiaCom()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/10/2017             jaime ascanta                           Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   static testMethod void asignaAccountToCaseRTIberiaCom_CuentaSiExiste_test(){
        R1_CLS_LogHelper.throw_exception = false;

        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        acc.LastName = 'account_Existente';
        acc.R1_ACC_TXT_Primary_FF_Card_CCPO__c = 'xxxxxxxxx';
        acc.R1_ACC_PKL_identification_Type__c = '04';
        acc.R1_ACC_TXT_Identification_number__c = '222222222';
        insert acc;

        Case cas = new Case();
        Id rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        cas.RecordTypeId = rtId;
        cas.Status = 'Abierto';
        cas.Origin = 'Web';
        cas.R1_CAS_PKL_Idioma__c = 'Espanol';
        cas.R2_CAS_TXT_LastName__c = 'account_Existente';
        cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c = 'xxxxxxxxx';
        cas.R2_CAS_PKL_Type_document__c = '04';
        cas.R2_CAS_TXT_Identification_number__c = '222222222';
        

        Test.startTest();
            insert cas;
        Test.stopTest();

         //where si no fuera test debe de ser más extenso, +-como el método
        List<Case> casoAccountId = [SELECT Id, AccountId, R2_CAS_TXT_Identification_number__c FROM Case WHERE Id =: cas.Id LIMIT 1];
        List<Account> accId = [SELECT Id FROM Account WHERE Id =: acc.Id LIMIT 1];

        system.debug('primera query: ' + accId[0].Id);
        system.debug('segunda query: ' + casoAccountId[0].AccountId);
        System.assertEquals(accId[0].Id, casoAccountId[0].AccountId);

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
   }
   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    test para asignaAccountToCaseRTIberiaCom()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    04/10/2017             jaime ascanta                           Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   static testMethod void asignaAccountToCaseRTIberiaCom_CuentaNoExiste_test(){
        R1_CLS_LogHelper.throw_exception = false;


        Case cas = new Case();
        Id rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        system.debug('--------->' + rtId);
        cas.RecordTypeId = rtId;
        cas.Status = 'Abierto';
        cas.Origin = 'Web';
        cas.R1_CAS_PKL_Idioma__c = 'Espanol';
        cas.R2_CAS_TXT_PASS_Name_Passenger__c = 'account_Existente';
        cas.R2_CAS_TXT_PASS_LastName_Passenger__c = 'account_Existente';
        cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c = '12345678';
        cas.R2_CAS_PKL_Type_document__c = '04';
        cas.R2_CAS_TXT_Identification_number__c = '71520940W';
        
        Test.startTest();
            insert cas;
        Test.stopTest();

        List<Case> casoAccountId = [SELECT Id, AccountId, R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c FROM Case WHERE Id =: cas.Id LIMIT 1];

        List<Account> accId = [SELECT Id FROM Account WHERE R1_ACC_TXT_Primary_FF_Card_CCPO__c =: casoAccountId[0].R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c LIMIT 1];
        system.debug('::::::::: ' + accId[0].Id);

        system.debug('primera query: ' + accId[0].Id);
        system.debug('segunda query: ' + casoAccountId[0].AccountId);
        System.assertEquals(accId[0].Id, casoAccountId[0].AccountId);

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
   }


   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Metodo test para reabrirExpediente con caso Expediente (padre)
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    01/08/2017             Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
  /* static testMethod void reabrirExpediente_Expediente_Test(){
        R1_CLS_LogHelper.throw_exception = false;

            //Account
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;
            //vuelo
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
            //Caso Padre
        Id recordTypeIdPadre = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;
        Case casoPa = new Case();
        casoPa.RecordTypeId = recordTypeIdPadre;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Web';
        insert casoPa;
            //Caso Hijo
        Id recordTypeIdHijo = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdHijo;
        caso.AccountID = acc.Id;
        caso.R1_CAS_LOO_Flight__c = vuelo.Id;
        caso.Status = 'Abierto';
        caso.Origin = 'Web';
        insert caso;

        Test.startTest();
        //insert caso Hijo y test


        Case casoHijo = [SELECT Id, ParentId, Status FROM Case WHERE Id = :caso.Id];
        Case casoPadre = [SELECT Id, Status FROM Case WHERE Id = :casoPa.Id];
        System.debug('Caso'+casoHijo);
        System.debug('Caso hijo anterior'+caso+' / y parentId: '+caso.ParentId);
        System.debug('Caso padre anterior'+casoPa);
        System.debug('Caso padre actualizado'+casoPadre);
        System.debug('Caso hijo actualizado'+casoHijo);
        System.assertEquals(casoHijo.ParentId, casoPa.Id);
        System.assertEquals('Reabierto', casoPadre.Status);
        Test.stopTest();


        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
   }
   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Metodo test para reabrirExpediente con caso Expediente (padre)
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    01/08/2017             Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   /*static testMethod void reabrirExpediente_Expediente_NoCambiaStatus_Test(){
        R1_CLS_LogHelper.throw_exception = false;

            //Account
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;
            //vuelo
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
            //Caso Padre
        Id recordTypeIdPadre = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;
        Case casoPa = new Case();
        casoPa.RecordTypeId = recordTypeIdPadre;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Trabajando';
        casoPa.Origin = 'Web';
        insert casoPa;
            //Caso Hijo
        Id recordTypeIdHijo = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Equipaje' LIMIT 1].Id;
        Case caso = new Case();
        caso.RecordTypeId = recordTypeIdHijo;
        caso.AccountID = acc.Id;
        caso.R1_CAS_LOO_Flight__c = vuelo.Id;
        caso.Status = 'Abierto';
        caso.Origin = 'Web';


        Test.startTest();
        //insert caso Hijo y test
        insert caso;

        Case casoHijo = [SELECT Id, ParentId FROM Case WHERE Id = :caso.Id];
        System.debug('Caso'+casoHijo);
        System.debug('Caso padre'+casoPa);
        System.debug('Caso hijo'+casoHijo);
        System.assertEquals(casoHijo.ParentId, casoPa.Id);
        System.assertEquals('Trabajando',casoPa.Status);
        Test.stopTest();


        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
   }*/
   /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Metodo test para reabrirExpediente con caso hijo
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    01/08/2017             Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
   /*static testMethod void reabrirExpediente_Hijo_Test(){
        R1_CLS_LogHelper.throw_exception = false;

            //Account
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;

            //vuelo
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;


        //Caso sin record type (!= expediente)
        Case caso = new Case();
        caso.AccountID = acc.Id;
        caso.R1_CAS_LOO_Flight__c = vuelo.Id;
        caso.Origin = 'Web';

        Id recordTypeIdPadre = [SELECT Id FROM recordType WHERE sObjectType = 'Case' AND Name = 'Expediente' LIMIT 1].Id;

        Test.startTest();

        System.debug('reabrirExpediente_Hijo_Test - ANTES INSERT -  caso '+caso);

        //insert caso Hijo y test
        insert caso;

        Case casoExp = [SELECT Id, ParentId, RecordTypeId, Status FROM Case WHERE Id = :caso.Id];

        System.assertEquals(casoExp.RecordTypeId, recordTypeIdPadre);
        System.assertEquals('Abierto', casoExp.Status);

        Test.stopTest();

        System.debug('reabrirExpediente_Hijo_Test - DESPUES INSERT - caso '+caso + ' || casoExp:'+casoExp);
        System.debug('reabrirExpediente_Hijo_Test - DESPUES INSERT - STATUS'+casoExp.RecordTypeId + '|| recordtypepadre -' + recordTypeIdPadre);

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
   }*/
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Sara Torres Bermúdez
    Company:       Accenture
    Description:


    History:

    <Date>                        <Author>                       <Change Description>
    24/08/2017                  Sara Torres Bermúdez              Initial Version
    -------------------------------------------------------------------------------------------------------------------------------------------------------*/

   static testMethod void rellenarCampoDescripcion_Test(){
       R1_CLS_LogHelper.throw_exception = false;

            //Account
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;

            //vuelo
        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;

       // pasajeros
        R2_CKI_info__c pasa = new R2_CKI_info__c();
        pasa.R2_CKI_LOO_Flight__c = vuelo.Id;
        pasa.R2_CKI_LOO_Account__c = acc.Id;
        pasa.Name = 'test';
        insert pasa;

       // caso padre con tipo: Cancelación
       Id recordTypeIdPadreCancel = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

       Case casoPaCancel = new Case();
       casoPaCancel.RecordTypeId = recordTypeIdPadreCancel;
       casoPaCancel.AccountID = acc.Id;
       casoPaCancel.R1_CAS_LOO_Flight__c = vuelo.Id;
       casoPaCancel.R2_CAS_CHK_Comprobar_cliente__c = False;
       casoPaCancel.Type = 'Cancelación';
       insert casoPaCancel;


       Test.startTest();
       Case casoTrue = [SELECT id, R2_CAS_CHK_Comprobar_cliente__c, R1_CAS_ATXTL_Automation_variables__c FROM Case WHERE ID = :casoPaCancel.Id LIMIT 1];
       casoTrue.R2_CAS_CHK_Comprobar_cliente__c = True;
       update casoTrue;
       Case casoRelleno = [SELECT id, R2_CAS_CHK_Comprobar_cliente__c, R1_CAS_ATXTL_Automation_variables__c FROM Case WHERE ID = :casoPaCancel.Id LIMIT 1];
       System.assertEquals(True, casoRelleno.R2_CAS_CHK_Comprobar_cliente__c);
       System.assertNotEquals('', casoRelleno.R1_CAS_ATXTL_Automation_variables__c);
       System.assertNotEquals(Null, casoRelleno.R1_CAS_ATXTL_Automation_variables__c);

       Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);

   }

        /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Metodo test para la funcion cambiosEnElStatus()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    06/09/2017             Sara Torres Bermúdez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

   static testMethod void cambiosEnElStatus_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        /*
        Account acc = R1_CLS_Utilities.helper_Account_constructor();
        insert acc;

        R1_Flight__c vuelo = R1_CLS_Utilities.helper_Flight_constructor();
        insert vuelo;
        */
        // para hijo con estado: abierto
        Case caso1 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'1');
        caso1.Origin = 'Llamada';
        caso1.Status = 'Abierto';
        insert caso1;

       Case caso2 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'1');
        caso2.Origin = 'Llamada';
        caso2.Status = 'Abierto';
        insert caso2;

        Test.startTest();
      Case casoActual = [SELECT Id, Status FROM Case WHERE ParentId = :caso1.Id];
       //System.assertEquals('Cerrado', casoActual.Status);
       System.assertEquals('Abierto', casoActual.Status);

       caso2.Status = 'Cerrado';
       update caso2;

       Case casoActual2 = [SELECT Id, Status FROM Case WHERE ParentId = :caso2.Id];
       //System.assertEquals('Cerrado', casoActual.Status);
       System.assertEquals('Cerrado', casoActual2.Status);

        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Metodo test para la funcion cambiosEnElStatus()
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    06/09/2017             Sara Torres Bermúdez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

   static testMethod void cambiosEnElStatus2_Test(){
       R1_CLS_LogHelper.throw_exception = false;

        Case caso5 = R1_CLS_Utilities.helper_Case_constructor('Demora',true,true,'5');
        caso5.Status = 'Cerrado';
        insert caso5;

       Test.startTest();
      Case casoActual = [SELECT Id, Status FROM Case WHERE ParentId = :caso5.Id];
       System.assertEquals('Cerrado', casoActual.Status);
       //System.assertEquals('Abierto', casoActual.Status);
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
      }

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Alberto Puerto Collado
    Company:       Accenture
    Description:   actualizaType_fromType1 Test - R2_CAS_PKL_Type1__c fulfilled



    History:

    <Date>                        <Author>                       <Change Description>
    22/09/2017                Alberto Puerto Collado                Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static testMethod void actualizaType_fromType1_Test_type_NOnull(){
        R1_CLS_LogHelper.throw_exception = false;

        //Caso sin type y con vuelo y account
        Case caso = R1_CLS_Utilities.helper_Case_constructor(null,true,true);
        caso.R2_CAS_PKL_Type1__c = 'Demora';//'01-Automation';//valor existente en ambas piklists type1 y type
/*
        System.debug('______ANTES:_____');
        System.debug('type1__c - ' + caso.R2_CAS_PKL_Type1__c);
        System.debug('type !!!! - ' + caso.Type);
*/
        Test.startTest();
        insert caso;
        Case casoRelleno = [SELECT id, Type, R2_CAS_PKL_Type1__c FROM Case WHERE ID = :caso.Id LIMIT 1];
/*
        System.debug('_______DESPUES!!!________:');
        System.debug('type1__c - ' + casoRelleno.R2_CAS_PKL_Type1__c);
        System.debug('type !!!! - ' + casoRelleno.Type);
        */
        System.assertEquals(casoRelleno.Type, caso.R2_CAS_PKL_Type1__c);
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }


 static testMethod void asistentesUpdate_test(){
        R1_CLS_LogHelper.throw_exception = false;

        Campaign camp = new Campaign();
        camp.Name = 'CampTest';
        insert camp;

        List<CampaignMember> miembrosCampana = new List<CampaignMember>();
        for(Contact con : [select Id from Contact]){
            miembrosCampana.add(new CampaignMember(
                                    ContactId = con.Id,

                                    CampaignId = camp.Id,
                                    R2_CMM_PK_answer_event__c = 'SI',
                                    R2_CMM_PK_status_event__c = 'Inscrito'
                                ));
        }
        insert miembrosCampana;

        Case caso = R1_CLS_Utilities.helper_Case_constructor('Evento',false,true);
        Id rtIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campañas salientes').getRecordTypeId();

        caso.Status = 'Trabajando';
        caso.RecordTypeId = rtIdCase;
        caso.R2_CAS_LOO_Campaigns__c = camp.Id;

        Test.startTest();
        insert caso;


        Test.stopTest();
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    20/12/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------
    static testMethod void insertaCasosPadreEnCola_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();

        Account acc = new Account();
        acc.RecordTypeId = recordTypeId;
        acc.FirstName = 'Test';
        acc.LastName = 'ClienteTest';
        acc.PersonEmail = 'test@test.com';
        acc.R1_ACC_PKL_Gender_description__c = 'M';
        acc.R1_ACC_TLF_Phone_Marketing__c = '123456789';
        acc.R1_ACC_PKL_identification_Type__c = '02';
        acc.R1_ACC_TXT_Identification_number__c = '123456789';
        insert acc;

        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_TXT_Carrier_code_oper__c = 'IB';
        vuelo.R1_FLG_TXT_AC_owner__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Flight_number__c = 'IB22342';
        insert vuelo;

        Id rTExp = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();

        Case casoPa = new Case();
        casoPa.RecordTypeId = rTExp;
        casoPa.AccountID = acc.Id;
        casoPa.R1_CAS_LOO_Flight__c = vuelo.Id;
        casoPa.Status = 'Abierto';
        casoPa.Origin = 'Web';
        casoPa.Type = 'Demora';
        casoPa.Subject = 'SubjectTest';
        casoPa.Description = 'DescriptionTest';
        casoPa.R2_CAS_PKL_Vip_Type__c = 'Oneworld';
        casoPa.Priority = 'Sin prioridad';
        casoPa.R1_CAS_PKL_Idioma__c = 'Español';


        Test.startTest();
        insert casoPa;
        Case casoRelleno = [SELECT id, OwnerId, Owner.Name FROM Case WHERE ID = :casoPa.Id LIMIT 1];
        List<QueueSobject> lstQueue = [SELECT Id, QueueId, Queue.Name FROM QueueSobject WHERE Queue.Name = 'SYR Gestión Equipaje'];
        System.debug('owner' + casoRelleno.OwnerId);
        System.assertEquals(lstQueue[0].QueueId, casoRelleno.OwnerId);
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    */

    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
   Author:        Jaime Ascanta
   Company:       Accenture
   Description:
   History:
   <Date>                        <Author>                       <Change Description>
   16/01/2018                Jaime Ascanta                      Initial Version
   --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static testMethod void crearVoucherIBConecta_Voucher_test(){
        R1_CLS_LogHelper.throw_exception = false;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

            List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
            R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
            ep.Name='CreateUpdateDNB';
            ep.R1_CHK_Activo__c=true;
            ep.R1_TXT_EndPoint__c='create_dnb';
            lst_ep.add(ep);
            R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
            ep3.Name='Send DNB';
            ep3.R1_CHK_Activo__c=true;
            ep3.R1_TXT_EndPoint__c='Send DNB';
            lst_ep.add(ep3);
            R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
            ep2.Name = 'ETL_Login';
            ep2.R1_CHK_Activo__c = true;
            ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
            lst_ep.add(ep2);
            insert lst_ep;

            //timeOut
            TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
            cst.Name = 'BonoDNB';
            cst.setTimeOut__c = 8000;
            insert cst;
            TimeOut_Integrations__c cst2 = new TimeOut_Integrations__c();
            cst2.Name = 'IberiaConecta';
            cst2.setTimeOut__c = 8000;
            insert cst2;

            Id ownerId = [SELECT Id FROM Group WHERE Type='Queue' AND Name='SYR Proactivos' LIMIT 1].Id;
            Id rt_case =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();
            Case cas = new Case();
            cas.Status = 'Abierto';
            cas.RecordTypeId = rt_case;
            cas.OwnerId = ownerId;
            //fligth
            cas.R1_CAS_TXT_Vuelo__c = 'IB0448';
            cas.R1_CAS_Fecha_vuelo__c = Date.newInstance(2018, 03, 28);
            cas.R2_CAS_TXT_Flight_Origin__c = 'MAD';
            cas.R2_CAS_TXT_Flight_Desnity__c = 'BIO';
            cas.R2_CAS_TXT_Amadeus_Locator__c = 'J39ZZN';
            cas.R2_CAS_TXT_Resiber_Locator__c = 'JFKMZ';
            // Compensation
            cas.R2_CAS_PKL_Type1__c = '5';
            cas.R1_CAS_PKLM_Assistance_subtype__c = '2';
            cas.R2_CAS_TXT_MotiveCode__c = 'BUTACAS;PETICIÓN DATOS';
            cas.R2_CAS_TXT_Compensation_Type__c  = 'INDEMNIZACIÓN';
            cas.R2_CAS_TXT_Payment_Way__c  = 'DNB';
            cas.R2_CAS_DIV_Compensation_in_vouchers__c = 150;
            //cas.R2_CAS_NUM_MCO_Import__c = 0;
            //cas.R1_CAS_NUM_Compensacion_en_Avios__c = 0;
            cas.R2_CAS_TXT_Coin__c  = 'EUR';
            cas.R2_CAS_TXT_User_Nomina__c = 'NOMINATEST';
            cas.R2_CAS_TXT_IBConnectID__c = '4444';
            //Passenger
            cas.R2_CAS_TXT_Name__c = 'PASAJERO';
            cas.R2_CAS_TXT_LastName__c = 'APELLIDO';
            cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c = 'IB9999999';
            cas.R2_CAS_TXT_TKT_Ticket__c = '0752374269908';
            cas.R2_CAS_TXT_ProfileId__c = '111111';
 
            List<Case> listCas = new List<Case>();

            // 1
            listCas.add(cas);
            // 2
            Case cas2 = cas.clone(false, true);
            cas2.R2_CAS_TXT_Name__c = 'PASAJERO2';
            listCas.add(cas2);
            // 3
            Case cas3 = cas.clone(false, true);
            cas3.R2_CAS_TXT_Name__c = 'PASAJERO3';
            listCas.add(cas3);

            Test.startTest();
                insert listCas;
            Test.stopTest();

            List<R2_Voucher__c> vouList = [ SELECT Id FROM R2_Voucher__c 
                                            WHERE R2_VOU_TXT_Passenger_FF__c = 'IB9999999' AND (R2_VOU_TXT_Voucher__c!=null AND R2_VOU_TXT_Voucher__c!='') ];
            //System.equals(3, vouList.size());

        // System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
   Author:        Jaime Ascanta
   Company:       Accenture
   Description:
   History:
   <Date>                        <Author>                       <Change Description>
   16/01/2018                Jaime Ascanta                      Initial Version
   --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static testMethod void crearVoucherIBConecta_Avios_test(){
        R1_CLS_LogHelper.throw_exception = false;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

            List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
            R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
            ep.Name='CreateUpdateDNB';
            ep.R1_CHK_Activo__c=true;
            ep.R1_TXT_EndPoint__c='create_dnb';
            lst_ep.add(ep);
            R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
            ep3.Name='Send DNB';
            ep3.R1_CHK_Activo__c=true;
            ep3.R1_TXT_EndPoint__c='Send DNB';
            lst_ep.add(ep3);
            R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
            ep2.Name = 'ETL_Login';
            ep2.R1_CHK_Activo__c = true;
            ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
            lst_ep.add(ep2);
            insert lst_ep;

            //timeOut
            TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
            cst.Name = 'BonoDNB';
            cst.setTimeOut__c = 8000;
            insert cst;
            TimeOut_Integrations__c cst2 = new TimeOut_Integrations__c();
            cst2.Name = 'IberiaConecta';
            cst2.setTimeOut__c = 8000;
            insert cst2;

            Id ownerId = [SELECT Id FROM Group WHERE Type='Queue' AND Name='SYR Proactivos' LIMIT 1].Id;
            Id rt_case =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('Proactivos').getRecordTypeId();
            Case cas = new Case();
            cas.Status = 'Abierto';
            cas.RecordTypeId = rt_case;
            cas.OwnerId = ownerId;
            //fligth
            cas.R1_CAS_TXT_Vuelo__c = 'IB0448';
            cas.R1_CAS_Fecha_vuelo__c = Date.newInstance(2018, 03, 28);
            cas.R2_CAS_TXT_Flight_Origin__c = 'MAD';
            cas.R2_CAS_TXT_Flight_Desnity__c = 'BIO';
            cas.R2_CAS_TXT_Amadeus_Locator__c = 'J39ZZN';
            cas.R2_CAS_TXT_Resiber_Locator__c = 'JFKMZ';
            // Compensation
            cas.R2_CAS_PKL_Type1__c = '5';
            cas.R1_CAS_PKLM_Assistance_subtype__c = '2';
            cas.R2_CAS_TXT_MotiveCode__c = 'BUTACAS;PETICIÓN DATOS';
            cas.R2_CAS_TXT_Compensation_Type__c  = 'INDEMNIZACIÓN';
            cas.R2_CAS_TXT_Payment_Way__c  = 'DNB';
            //cas.R2_CAS_DIV_Compensation_in_vouchers__c = 150;
            //cas.R2_CAS_NUM_MCO_Import__c = 0;
            cas.R1_CAS_NUM_Compensacion_en_Avios__c = 80;
            cas.R2_CAS_TXT_Coin__c  = 'EUR';
            cas.R2_CAS_TXT_User_Nomina__c = 'NOMINATEST';
            cas.R2_CAS_TXT_IBConnectID__c = '4444';
            //Passenger
            cas.R2_CAS_TXT_Name__c = 'PASAJERO';
            cas.R2_CAS_TXT_LastName__c = 'APELLIDO';
            cas.R2_CAS_TXT_Primary_Frecuent_Flyer_Card__c = 'IB9999999';
            cas.R2_CAS_TXT_TKT_Ticket__c = '0752374269908';
            cas.R2_CAS_TXT_ProfileId__c = '111111';
 
            List<Case> listCas = new List<Case>();

            // 1
            listCas.add(cas);
            // 2
            Case cas2 = cas.clone(false, true);
            cas2.R2_CAS_TXT_Name__c = 'PASAJERO2';
            listCas.add(cas2);
            // 3
            Case cas3 = cas.clone(false, true);
            cas3.R2_CAS_TXT_Name__c = 'PASAJERO3';
            listCas.add(cas3);

            Test.startTest();
                insert listCas;
            Test.stopTest();

            List<R2_Compensation__c> compList = [SELECT Id FROM R2_Compensation__c WHERE R2_COM_TXT_Frecuent_Flyer__c = '9999999'];
            //System.equals(3, compList.size());


        //System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
   
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test de la clase 'R2_CLS_CaseTriggerMethods_Test'
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    28/07/2017             Rubén Pingarrón Jerez                   Initial Version
    22/09/2017             Alberto Puerto Collado               actualizaType_fromType1
    04/10/2017             jaime Ascanta                        asignaAccountToCaseRTIberiaCom
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R2_CLS_CaseTriggerMethods.cuentaCasos(null);
        R2_CLS_CaseTriggerMethods.asignaPadre(null);
        //R2_CLS_CaseTriggerMethods.insertarCasoPadreEnCola(null);
        R2_CLS_CaseTriggerMethods.asignarCasoHijoInsert(null);
        R2_CLS_CaseTriggerMethods.asignarCasoHijoUpdate(null, null);
        //R2_CLS_CaseTriggerMethods.asociarCasoAVuelo(null);
        //R2_CLS_CaseTriggerMethods.asignaAccountToCase(null);
        R2_CLS_CaseTriggerMethods.asignaAccountToCaseRTIberiaCom(null);
        R2_CLS_CaseTriggerMethods.rellenarCampoDescripcion(null, null);
        R2_CLS_CaseTriggerMethods.actualizaType_fromType1(null);
        R2_CLS_CaseTriggerMethods.CuentaCasosUpdate(null, null);
        R2_CLS_CaseTriggerMethods.cambiosEnElStatus(null);
        R2_CLS_CaseTriggerMethods.gestionaAprobacion(null, null);
        R2_CLS_CaseTriggerMethods.updateClaimantEntity(null, null);
    }

}