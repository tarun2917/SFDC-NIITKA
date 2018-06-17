@isTest
private class R2_CLS_QueueableUpdateFlightsSIP_Test {
	
    static testMethod void execute_test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Update Flight Status';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaUpdateFlightStatus';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Status__c';
        insert bpass;    
            
        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'TestVuelo';
        vuelo.R1_FLG_DAT_Flight_date_local__c=date.newInstance(2017, 8,10);
        vuelo.R1_FLG_TXT_Carrier_code__c='IB';
        vuelo.R1_FLG_TXT_Airport_arrive__c='MAD';
        vuelo.R1_FLG_TXT_Flight_number__c='1234';
        vuelo.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo;

		R1_Flight__c vuelo2 = new R1_Flight__c();
        vuelo2.Name = 'TestVuelo';
        vuelo2.R1_FLG_DAT_Flight_date_local__c=date.newInstance(2017, 8,10);
        vuelo2.R1_FLG_TXT_Carrier_code__c='IB';
        vuelo2.R1_FLG_TXT_Airport_arrive__c='MAD';
        vuelo2.R1_FLG_TXT_Flight_number__c='1234';
        vuelo2.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo2;
        /*
        R1_Flight__c vuelo3 = new R1_Flight__c();
        vuelo3.Name = 'TestVuelo';
        vuelo3.R1_FLG_DAT_Flight_date_local__c=date.newInstance(2017, 8,10);
        vuelo3.R1_FLG_TXT_Carrier_code__c='IB';
        vuelo3.R1_FLG_TXT_Airport_arrive__c='MAD';
        vuelo3.R1_FLG_TXT_Flight_number__c='1234';
        vuelo3.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo3;
        */
        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;
            
            
         R1_SIP_Status__c estado=new R1_SIP_Status__c();
        estado.R1_SIS_LOO_Flight__c=vuelo.id;
        estado.R1_SIS_PKL_Vip_lounge__c='Dalí';
        insert estado;

        Test.startTest();
             vuelo.R1_FLG_PKL_Message_Type__c = 'Retrasado';
            update vuelo;
            
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
}