/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Apex test para la clase apex 'R1_CLS_SIPInt'
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    @isTest
    private class R1_CLS_SIPInt_Test{
    
    
        
       /*---------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay Flores
    Company:        Accenture
    Description:    Metodo test para la funcion trigger vuelo()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Borja Gay Flores                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
        
        static testMethod void subirVueloVipTest(){
        R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Submit Flight';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaSubmitFlight';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        R1_Flight__c vuelo = new R1_Flight__c();
        vuelo.Name = 'TestVuelo';
        vuelo.R1_FLG_TXT_Flight_number__c='1234';
        vuelo.R1_FLG_DAT_Flight_date_local__c= Date.newInstance(1991, 2, 4);
        vuelo.R1_FLG_DATH_Schedule_depart_time__c = Datetime.newInstance(1991, 2, 4);
        vuelo.R1_FLG_TXT_Carrier_code__c='IB';
        vuelo.R1_FLG_TXT_Destination__c='BCN';
        vuelo.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo;

        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;
            
        Test.startTest();
        R1_SIP_Status__c acceso=new R1_SIP_Status__c();
        acceso.R1_SIS_PKL_Vip_lounge__c='Dalí';
        acceso.R1_SIS_LOO_Flight__c=vuelo.id;
        insert acceso;
             
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }    
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion trigger vuelo()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
        
        static testMethod void vueloTest(){
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
        vuelo.R1_FLG_TXT_Destination__c='MAD';
        vuelo.R1_FLG_TXT_Flight_number__c='1234';
        vuelo.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo;

        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;
            
            
         R1_SIP_Status__c estado=new R1_SIP_Status__c();
        estado.R1_SIS_LOO_Flight__c=vuelo.id;
        estado.R1_SIS_PKL_Vip_lounge__c='Dalí';
        insert estado;
        
        estado.R1_SIS_CHK_Control_flag__c=true;
        
        update estado;

        Test.startTest();
             vuelo.R1_FLG_PKL_Message_Type__c = 'Retrasado';
            update vuelo;
            
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay Flores
    Company:        Accenture
    Description:    Metodo test para la funcion trigger vuelo()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Borja Gay Flores                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void vueloFallidoLoginTest(){
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
        vuelo.R1_FLG_DAT_Flight_date_local__c=date.newInstance(2017, 8, 4);
        vuelo.R1_FLG_TXT_Carrier_code__c='IB';
        vuelo.R1_FLG_TXT_Destination__c='MAD';
        vuelo.R1_FLG_TXT_Flight_number__c='1234';
        vuelo.R1_FLG_TXT_Origin__c='MAD';
        insert vuelo;

        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;

        R1_SIP_Status__c estado=new R1_SIP_Status__c();
        estado.R1_SIS_LOO_Flight__c=vuelo.id;
        estado.R1_SIS_PKL_Vip_lounge__c='Dalí';
        insert estado;
        
        estado.R1_SIS_CHK_Control_flag__c=false;
        
        update estado;
        
        Test.startTest();
            vuelo.R1_FLG_PKL_Message_Type__c = 'Retrasado';
            update vuelo;
        
        
        Test.stopTest();
        System.debug('Numero '+[SELECT count() FROM R1_Log__c]);
        System.debug('Numero '+[SELECT R1_LOG_ATXTL_MensajeError__c FROM R1_Log__c]);
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion trigger message()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    26/05/2017             Borja Gay Flores                      Modified to cover code
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void createMessageTest(){
       
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Create Message';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
        ep3.Name='Delete Message';
        ep3.R1_CHK_Activo__c=true;
        ep3.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep3);
        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;

        Test.startTest();
            R1_SIP_Message__c mensaje = new R1_SIP_Message__c();
            mensaje.R1_SIM_NUM_Display_duration__c=1;
            mensaje.R1_SIM_PKL_Message_type__c='Urgente';
            mensaje.R1_SIM_PKL_VIP_lounge_name__c='Dalí';
            insert mensaje;
            
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay Flores
    Company:        Accenture
    Description:    Metodo test para la funcion trigger message()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    26/05/2017             Borja Gay Flores                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void createMessageLoginFallidoTest(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Create Message';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep);


        R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
        ep3.Name='Delete Message';
        ep3.R1_CHK_Activo__c=true;
        ep3.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep3);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());


        

        Test.startTest();
            R1_SIP_Message__c mensaje = new R1_SIP_Message__c();
            mensaje.R1_SIM_NUM_Display_duration__c=1;
            mensaje.R1_SIM_PKL_Message_type__c='Urgente';
            mensaje.R1_SIM_PKL_VIP_lounge_name__c='Dalí';
            insert mensaje;
            
        
        Test.stopTest();
        System.debug('Numero '+[SELECT count() FROM R1_Log__c]);
        System.debug('Numero '+[SELECT R1_LOG_ATXTL_MensajeError__c FROM R1_Log__c]);
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]); 
    }
    
        /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alvaro Garcia Tapia
    Company:        Accenture
    Description:    Metodo test para la funcion trigger message()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/05/2017             Alvaro Garcia Tapia                   Initial Version
    26/05/2017             Borja Gay Flores                      Modified to cover code
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void deleteMessageTest(){
       R1_CLS_LogHelper.throw_exception = false;  

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();

        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Create Message';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);

        R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
        ep3.Name='Delete Message';
        ep3.R1_CHK_Activo__c=true;
        ep3.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep3);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Message__c';
        insert bpass;

        Salas_VIP__c sala=new Salas_VIP__c();
        sala.Name='test';
        sala.Nombre_Sip__c='test';
        sala.Sala_Vip__c='Dalí';
        insert sala;
        
        R1_SIP_Message__c mensaje = new R1_SIP_Message__c();
        mensaje.R1_SIM_NUM_Display_duration__c=1;
        mensaje.R1_SIM_PKL_Message_type__c='Urgente';
        mensaje.R1_SIM_PKL_VIP_lounge_name__c='Dalí';
        insert mensaje;

        System.debug('mensaje: ' + mensaje);

        bpass.R1_CHK_skip_trigger__c = false;
        update bpass;
        
        Test.startTest();
            
            delete mensaje;
            
        
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
        
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Borja Gay Flores
    Company:        Accenture
    Description:    Metodo test para la funcion trigger message()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    26/05/2017             Borja Gay Flores                      Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void deleteMessageLoginFallidoTest(){
        R1_CLS_LogHelper.throw_exception = false;
        
        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();

        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Create Message';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep);

        R1_CS_Endpoints__c ep3=new R1_CS_Endpoints__c();
        ep3.Name='Delete Message';
        ep3.R1_CHK_Activo__c=true;
        ep3.R1_TXT_EndPoint__c='PruebaMessage';
        lst_ep.add(ep3);

        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        R1_byPass__c bpass = new R1_byPass__c();
        bpass.Name = 'bypass(User)';
        bpass.SetupOwnerId = userinfo.getuserid();
        bpass.R1_CHK_skip_trigger__c = true;
        bpass.R1_TXT_Objects__c = 'R1_SIP_Message__c';
        insert bpass;

        
        R1_SIP_Message__c mensaje = new R1_SIP_Message__c();
        mensaje.R1_SIM_NUM_Display_duration__c=1;
        mensaje.R1_SIM_PKL_Message_type__c='Urgente';
        mensaje.R1_SIM_PKL_VIP_lounge_name__c='Dalí';
        insert mensaje;

        bpass.R1_CHK_skip_trigger__c = false;
        update bpass;

        Test.startTest();
            delete mensaje;
            
        
        Test.stopTest();
        System.debug('Numero '+[SELECT count() FROM R1_Log__c]);
        System.debug('Numero 1:'+[SELECT R1_LOG_ATXTL_MensajeError__c FROM R1_Log__c]);
        System.assertEquals(1, [SELECT count() FROM R1_Log__c]);
    } 
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    Metodo test para cubrir los catch
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    26/05/2017             Ruben Pingarron Jerez                     Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/        
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R1_VIP_Lounge_Access__c acceso = new R1_VIP_Lounge_Access__c();
        
        R1_CLS_SIPInt.mensajesSIP(null);
        R1_CLS_SIPInt.crearMensaje(null, null);
        R1_CLS_SIPInt.mensajesSIPBorrar(null, null, null, null, null, null, null);
        R1_CLS_SIPInt.borrarMensaje(null, null, null, null, null, null, null, null);
        R1_CLS_SIPInt.enviarVueloVip(null);
        R1_CLS_SIPInt.mensajeVueloVip(null, null);
        R1_CLS_SIPInt.actualizarVuelo(null, null);
        R1_CLS_SIPInt.actualizarMensajeVuelo(null, null, null);
        R1_CLS_SIPInt.crearEstadoSIP(acceso);
    }

}