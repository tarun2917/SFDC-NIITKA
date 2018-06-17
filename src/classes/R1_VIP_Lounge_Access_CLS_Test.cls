/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Clase apex test para la clase 'R1_VIP_Lounge_Access_CLS'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
public class R1_VIP_Lounge_Access_CLS_Test {
        /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion validaracceso()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/05/2017             Rubén Pingarrón Jerez                   Initial Version
    2/06/2017              Borja Gay Flores                        Changed picklist R1_ACC_PKL_Platinum_level_description__c values
    19/07/2017             David Barco Infante                     Add the field UserId__c in Salas_VIP__c custom setting
    16/08/2017             David Barco Infante                     Add the value 'MAD' in all field R1_VLI_TXT_Origin__c of R1_VIP_Lounge_Access__c object
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void validaracceso_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Status__c';
        insert bpass;

        List<R1_VIP_Lounge_Access__c> lstAccesos = new List<R1_VIP_Lounge_Access__c>();
        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        acceso.R1_VLI_PKL_Sala_Vip__c = 'Autoridades';
        acceso.R1_VLI_TXT_Frecuent_Flyer_number__c = 'IB12345678';
        acceso.R1_VLI_PKL_Vip_lounge_position__c = 'Puesto 1';
        acceso.R1_VLI_TXT_Flight_number__c = '123';
        acceso.R1_VLI_DAT_Date__c = Date.newInstance(2017, 08, 21);
        acceso.R1_VLI_TXT_Comp_Flight__c = 'compTest';
        acceso.R1_VLI_TXT_Class__c = 'classTest';
        acceso.R1_VLI_PKL_OneWolrd_code__c = 'codeTest';
        acceso.R1_VLI_TXT_Mkt_Flight__c = '1234';
        acceso.R1_VLI_NUM_Guest_number__c = 3;
        acceso.R1_VLI_TXT_Origin__c = 'MAD';
        lstAccesos.add(acceso);
        
        
        Salas_VIP__c sala = new Salas_VIP__c();
        sala.Sala_Vip__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Nombre_del_Equipo__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Puesto_de_Trabajo__c =  lstAccesos[0].R1_VLI_PKL_Vip_lounge_position__c;
        sala.UserId__c = UserInfo.getUserId();
        sala.Name = 'SalaTest';
        insert sala;
        
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = lstAccesos[0].R1_VLI_TXT_Flight_number__c;
        cliente.R1_ACC_PKL_Platinum_level_description__c = '04';
        insert cliente;
        
        R1_VIP_Loung_access_rules__c regla = new R1_VIP_Loung_access_rules__c();
        regla.Name = 'reglaTest';
        insert regla;
        
        Test.startTest();
        R1_VIP_Lounge_Access_CLS.validaracceso(lstAccesos,0);
        System.assertEquals('Denegado', lstAccesos[0].R1_VLI_PKL_Access_status__c);
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
    Description:    Metodo test para la funcion validaracceso()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/05/2017             Rubén Pingarrón Jerez                   Initial Version
    2/06/2017              Borja Gay Flores                        Changed picklist R1_ACC_PKL_Platinum_level_description__c values
    19/07/2017             David Barco Infante                     Add the field UserId__c in Salas_VIP__c custom setting
    16/08/2017             David Barco Infante                     Add the value 'MAD' in all field R1_VLI_TXT_Origin__c of R1_VIP_Lounge_Access__c object
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void validaracceso_Test2(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Status__c';
        insert bpass;
        
        R1_Flight__c vuelo = new R1_Flight__c();
        //vuelo.Name = 'VueloTest';
        vuelo.R1_FLG_TXT_Flight_number__c = '1234';
        vuelo.R1_FLG_TXT_Carrier_code__c = 'IB';
        vuelo.R1_FLG_DAT_Flight_date_local__c = Date.newInstance(2017, 08, 21);
        vuelo.R1_FLG_TXT_Origin__c = 'MAD';
        vuelo.R1_FLG_TXT_Destination__c = 'BCN';
        vuelo.R1_FLG_TXT_External_ID__c ='IB123408212017MAD';

        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = 'AA16734983236';
        cliente.R1_ACC_PKL_Platinum_level_description__c = '04';
        insert cliente;
        
        List<R1_VIP_Lounge_Access__c> lstAccesos = new List<R1_VIP_Lounge_Access__c>();
        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        acceso.R1_VLI_PKL_Sala_Vip__c = 'Autoridades';
        acceso.R1_VLI_TXT_Frecuent_Flyer_number__c = cliente.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c;
        acceso.R1_VLI_PKL_Vip_lounge_position__c = 'Puesto 1';
        acceso.R1_VLI_TXT_Flight_number__c = '1234';
        acceso.R1_VLI_TXT_Comp_Mkt_flight__c = 'IB';
        acceso.R1_VLI_TXT_Origin__c = 'MAD';
        acceso.R1_VLI_TXT_Destination__c='BCN';
        acceso.R1_VLI_NUM_departure_tieme_cki__c='1500';
        acceso.R1_VLI_LOO_Cliente__c = cliente.Id;
        acceso.R1_VLI_DAT_Date__c = Date.newInstance(2017, 08, 21);
        acceso.R1_VLI_TXT_Comp_Flight__c = 'IB';
        acceso.R1_VLI_TXT_Class__c = 'classTest';
        acceso.R1_VLI_PKL_OneWolrd_code__c = 'codeTest';
        acceso.R1_VLI_TXT_Mkt_Flight__c='1234';
        acceso.R1_VLI_DAT_Date__c=date.newInstance(2018, 3,12);
        acceso.R1_VLI_TXT_Origin__c = 'MAD';
        lstAccesos.add(acceso);
        insert lstAccesos;
        
        Salas_VIP__c sala = new Salas_VIP__c();
        sala.Sala_Vip__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Nombre_del_Equipo__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Puesto_de_Trabajo__c =  lstAccesos[0].R1_VLI_PKL_Vip_lounge_position__c;
        sala.UserId__c = UserInfo.getUserId();
        sala.Name = 'SalaTest';
        insert sala;
        
        
        
        R1_VIP_Loung_access_rules__c regla = new R1_VIP_Loung_access_rules__c();
        regla.Name = 'reglaTest';
        regla.R1_VLR_TXT_Cia_Ope__c = lstAccesos[0].R1_VLI_TXT_Comp_Flight__c;
        regla.R1_VLR_TXT_ID_AD_indicator__c = 'ID/DA';
        regla.R1_VLR_TXT_Value__c = lstAccesos[0].R1_VLI_TXT_Class__c;
        regla.R1_VLR_TXT_FF_Ow__c = lstAccesos[0].R1_VLI_PKL_OneWolrd_code__c;
        regla.R1_VLR_TXT_FF_Iberia__c = 'test';
        regla.R1_VLR_TXT_Observations__c = 'OBSERVACIONES DE PRUEBA';
        regla.R1_VLR_TXT_Invited__c = '1';
        insert regla;
        
        Test.startTest();
        insert vuelo;
        R1_VIP_Lounge_Access_CLS.validaracceso(lstAccesos,0);
        System.assertEquals('Denegado', lstAccesos[0].R1_VLI_PKL_Access_status__c);//DBI null
        //System.assertEquals([SELECT count() FROM R1_Log__c], 0);
        Test.stopTest();
        //List<R1_Log__c> logs = [SELECT Id FROM R1_Log__c];
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);//DBI 1
        //System.assertEquals(logs.size(),0);
        
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion validaracceso()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/05/2017             Rubén Pingarrón Jerez                   Initial Version
    2/06/2017              Borja Gay Flores                        Changed picklist R1_ACC_PKL_Platinum_level_description__c values
    19/07/2017             David Barco Infante                     Add the value of the field UserId__c in Salas_VIP__c custom setting
    16/08/2017             David Barco Infante                     Add the value 'MAD' in all field R1_VLI_TXT_Origin__c of R1_VIP_Lounge_Access__c object
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void validaracceso_Test3(){
        R1_CLS_LogHelper.throw_exception = false;
        
        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Status__c';
        insert bpass;
        
        List<R1_VIP_Lounge_Access__c> lstAccesos = new List<R1_VIP_Lounge_Access__c>();
        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        acceso.R1_VLI_PKL_Sala_Vip__c = 'Autoridades';
        acceso.R1_VLI_TXT_Frecuent_Flyer_number__c = '123';
        acceso.R1_VLI_PKL_Vip_lounge_position__c = 'Puesto 2';
        acceso.R1_VLI_TXT_Flight_number__c = '123';
        acceso.R1_VLI_DAT_Date__c = Date.newInstance(2017, 08, 21);
        acceso.R1_VLI_TXT_Comp_Flight__c = 'compT';
        acceso.R1_VLI_TXT_Class__c = 'classTest';
        acceso.R1_VLI_PKL_OneWolrd_code__c = 'codeTest';
        acceso.R1_VLI_TXT_Origin__c = 'MAD';
        lstAccesos.add(acceso);
        
        
        Salas_VIP__c sala = new Salas_VIP__c();
        sala.Sala_Vip__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Nombre_del_Equipo__c = lstAccesos[0].R1_VLI_PKL_Sala_Vip__c;
        sala.Puesto_de_Trabajo__c =  lstAccesos[0].R1_VLI_PKL_Vip_lounge_position__c;
        sala.UserId__c = UserInfo.getUserId();
        sala.Name = 'SalaTest';
        insert sala;
        
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient2';
        cliente.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = lstAccesos[0].R1_VLI_TXT_Flight_number__c;
        insert cliente;
        
        R1_VIP_Loung_access_rules__c regla = new R1_VIP_Loung_access_rules__c();
        regla.Name = 'reglaTest';
        regla.R1_VLR_TXT_Cia_Ope__c = lstAccesos[0].R1_VLI_TXT_Comp_Flight__c;
        regla.R1_VLR_TXT_ID_AD_indicator__c = 'ID/DA';
        regla.R1_VLR_TXT_Value__c = lstAccesos[0].R1_VLI_TXT_Class__c;
        regla.R1_VLR_TXT_FF_Ow__c = lstAccesos[0].R1_VLI_PKL_OneWolrd_code__c;
        regla.R1_VLR_TXT_FF_Iberia__c = 'test';
        regla.R1_VLR_TXT_Observations__c = null;
        regla.R1_VLR_TXT_Invited__c = null;
        insert regla;
        
        Test.startTest();
        R1_VIP_Lounge_Access_CLS.validaracceso(lstAccesos,0);
        System.assertEquals('Denegado', lstAccesos[0].R1_VLI_PKL_Access_status__c);
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
    Description:    Metodo test para que cubra los catch
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/05/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/  
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        //List<R1_VIP_Lounge_Access__c> lstAccesos = new List<R1_VIP_Lounge_Access__c>();
        R1_VIP_Lounge_Access_CLS.validaracceso(null,0);
    }
}