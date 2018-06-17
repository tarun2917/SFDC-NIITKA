global class R2_CLS_PreOrderMethods {
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    28/11/2017          Sara Torres Bermúdez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    public static String tipoMenu;   
    
    public class WPinfo{
        public Boolean reembolsoOk;
        public String emdidentifier;
        public String orderPNRResiber;   
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    28/11/2017          Sara Torres Bermúdez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
    //@future(callout=true)
    public static WPinfo esReembolsable(String TKT, String numVuelo, Date fechaVuelo, String departAirport, String arriveAirport, String menu, String cabin){
                                        
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            
            System.debug('Aqui no ha petado todavia');
            R2_CLS_Pre_Order_Integration.WpResponseCheckRefundPreOrder resp = R2_CLS_Pre_Order_Integration.checkPreOrder(TKT, numVuelo, fechaVuelo, departAirport, arriveAirport, menu , 0);
            WPinfo infoReq = new WPinfo();

            //System.debug('Porque viene despues de la primera integracion mas resp: ' + resp);

            //////////////////////////////////////////////////////////////////////
            //Trampa para comprobar si funciona el flujo de reembolso
            //resp.order.refundRequestedIndicator = 'true';

            //////////////////////////////////////////////////////////////////////

            if(resp != null){
                if (resp.order.refundRequestedIndicator == 'true' && resp.order.refundableIndicator == 'false' && cabin != 'Business'){
                    infoReq.reembolsoOk = True;
                    infoReq.emdidentifier = resp.order.emdidentifier;
                    infoReq.orderPNRResiber = resp.order.orderPNRResiber;
                    return infoReq;
                }else if(resp.order.orderLanguage == 'Fallo'){
                    infoReq.reembolsoOk = False;
                    infoReq.emdidentifier = 'Fallo';
                    infoReq.orderPNRResiber = resp.order.orderStatus;
                    return infoReq;
                }else{
                    infoReq.reembolsoOk = False;
                    infoReq.emdidentifier = '';
                    infoReq.orderPNRResiber = '';
                    return infoReq;
                }
            }
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.comprobarReembolsoPreOrder()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    28/11/2017          Sara Torres Bermúdez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    public static void auxComprobacionesParaReembolso(Set<id> casoId){
        comprobacionesParaReembolso(casoId);
    }


    @future(callout=true)
    public static void comprobacionesParaReembolso(Set<Id> casoId){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            system.debug('entro en comprobar Reembolso: ' + casoId);
            
            Id rtPasj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();            
            String menuPreOrder = '';
            system.debug('caso: ' + casoId);
            List<Case> caso = [SELECT Id, R2_CAS_TXT_TKT_Ticket__c,R1_CAS_PKL_Subtype__c, R2_CAS_FOR_Flight_date_local__c, R2_CAS_FOR_Flight_number__c, R2_CAS_FOR_Origin__c, 
                               R2_CAS_FOR_Destination__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, 
                               R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c FROM Case WHERE Id IN :casoId AND RecordTypeId = :rtPasj AND R1_CAS_LOO_Incidences__c != null AND 
                               (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c  != '') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c  != '') LIMIT 1];
            system.debug('entro en el rembolso 2' + caso);
            if(!caso.isEmpty()){
                
                
                menuPreOrder = menuPreOrder(caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                          
                R2_CLS_PreOrderMethods.WPinfo resp1 = esReembolsable(caso[0].R2_CAS_TXT_TKT_Ticket__c , caso[0].R2_CAS_FOR_Flight_number__c, caso[0].R2_CAS_FOR_Flight_date_local__c, caso[0].R2_CAS_FOR_Origin__c, caso[0].R2_CAS_FOR_Destination__c, menuPreOrder, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                
                System.debug('Aqui tambien ha llegado y este es  subtipo: ' + resp1);

                /////////////////////////////////////////////////////////////////////////////////////
                //Trampa para probar el flujo de que si es reembolsable

                //resp1.reembolsoOk = true;

                       /////////////////////////////////////////////////////////////////////////////////////


                if(resp1 != null){
                    if(resp1.reembolsoOk){
                        caso[0].R1_CAS_PKL_Subtype__c = 'Reembolso';
                        R2_CLS_Pre_Order_Integration.WpResponseRequestRefund resp2 = R2_CLS_Pre_Order_Integration.requestRefund(resp1.emdidentifier, resp1.orderPNRResiber, 0);
                        System.debug('Aquí ya no llega pues?');
                        /////////////////////////////////////////////////////////////////////////////////
                        //Trampa para probar que va bien la integracion
                        //resp2.error.errorCode = '200';
                        /////////////////////////////////////////////////////////////////////////////////
                        if(resp2!=null){
                            if(resp2.error.errorCode != '200'){
                                caso[0].R1_CAS_PKL_Subtype__c = '';
                            }else{
                                caso[0].R1_CAS_PKL_Subtype__c ='Reembolso';
                                reembolsarCaso(caso[0].id);
                            }
                        }
                    }else{
                        caso[0].R1_CAS_PKL_Subtype__c = 'No corresponde reembolso';
                        noReembolsarCaso(caso[0].id);
                    }
                    System.debug(caso[0].R1_CAS_PKL_Subtype__c);
                    System.debug(caso);
                    update caso;
                    system.debug(caso);
                }
                
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.comprobacionesParaReembolso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
        }
    }
    
     

    

     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    30/11/2017          Ruben Pingarron Jerez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    @future(callout= true)
    public static void admiteReembolso(String id){
        try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            System.debug('Va a comprobar si se admite un reembolso ' + id);
            CaseComment comentario = new CaseComment();
            Id rtPasj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            String resultado = '';
            String menuPreOrder = '';
            List<Case> caso = [SELECT Id, ParentId, R2_CAS_TXT_TKT_Ticket__c, R2_CAS_FOR_Flight_date_local__c, R2_CAS_FOR_Flight_number__c, R2_CAS_FOR_Origin__c, 
                               R2_CAS_FOR_Destination__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, 
                               R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c FROM Case WHERE Id =:id AND RecordTypeId = :rtPasj AND R1_CAS_LOO_Incidences__c != null AND 
                               (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c  != '') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c  != '') LIMIT 1];
            
            List<Case> casoPasaje = [SELECT Id,ParentId FROM Case WHERE ParentId =: id];
            system.debug('entro en el rembolso 2' + caso);
            system.debug('entro en el rembolso 2' + casoPasaje);
            
            if(!caso.isEmpty()){
                comentario.ParentId = caso[0].ParentId;
                menuPreOrder = menuPreOrder(caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                
                R2_CLS_PreOrderMethods.WPinfo resp1 = esReembolsable(caso[0].R2_CAS_TXT_TKT_Ticket__c , caso[0].R2_CAS_FOR_Flight_number__c, caso[0].R2_CAS_FOR_Flight_date_local__c, caso[0].R2_CAS_FOR_Origin__c, caso[0].R2_CAS_FOR_Destination__c, menuPreOrder, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                
                if(resp1 != null){
                    if(resp1.reembolsoOk){
                        caso[0].R1_CAS_PKL_Subtype__c = 'No corresponde reembolso'; 
                        comentario.CommentBody = 'No es reembolsable porque ya se está tramitando su reembolso para esta incidencia';
                        /////////////////////////////////////////////////////////////////////////////////
                        //Trampa para probar que va bien la integracion
                        //resp2.error.errorCode = '200';
                        /////////////////////////////////////////////////////////////////////////////////
                        
                    }else{
                        caso[0].R1_CAS_PKL_Subtype__c = 'No corresponde reembolso';
                        comentario.CommentBody ='No es reembolsable porque no existe una preorder para esta incidencia';
                    }
                    System.debug(caso[0].R1_CAS_PKL_Subtype__c);
                    System.debug(caso);
                    insert comentario;
                    update caso;
                    system.debug(caso);
                }
            System.debug('Resultado: ' + resultado);
             
            }
           	//resultado = 'True';
            //return resultado;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.admiteReembolso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            //return 'Fallo en el sistema. Contacte con su administrador';
        }
    }
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    30/11/2017          Ruben Pingarron Jerez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    public static String reembolsarCaso(String id){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            System.debug('Se va a realizar el pago');
            CaseComment comentario = new CaseComment();
            List<Case> caso = [SELECT Id, ParentId, R1_CAS_PKL_Subtype__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, R2_CAS_TXT_TKT_Ticket__c, R2_CAS_FOR_Flight_number__c, R2_CAS_FOR_Flight_date_local__c, R2_CAS_FOR_Origin__c, R2_CAS_FOR_Destination__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c FROM Case WHERE Id =:id LIMIT 1];
            String reembolso = '';
            String menuPreOrder = '';
            comentario.ParentId = caso[0].ParentId;
            if(!caso.isEmpty()){
                
                menuPreOrder = menuPreOrder(caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);

               	R2_CLS_PreOrderMethods.WPinfo resp1 = esReembolsable(caso[0].R2_CAS_TXT_TKT_Ticket__c , caso[0].R2_CAS_FOR_Flight_number__c, caso[0].R2_CAS_FOR_Flight_date_local__c, caso[0].R2_CAS_FOR_Origin__c, caso[0].R2_CAS_FOR_Destination__c, menuPreOrder, caso[0].R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c);
                
                if(resp1 != null){
                    R2_CLS_Pre_Order_Integration.WpResponseRequestRefund resp2 = R2_CLS_Pre_Order_Integration.requestRefund(resp1.emdidentifier, resp1.orderPNRResiber, 0);
                    /////////////////////////////////////////////////////////////////////////////////
                    //Trampa para probar que va bien la integracion
                    //resp2.error.errorCode = '200';
                    /////////////////////////////////////////////////////////////////////////////////
                    if(resp2 != null){
                        if(resp2.error.errorCode == '200'){
                            caso[0].R1_CAS_PKL_Subtype__c = 'Reembolso';
                            reembolso = 'El caso se ha reembolsado con exito';
                            comentario.CommentBody = reembolso;
                            update caso;
                        }else if(resp2.error.errorCode != '200'){
                            reembolso = 'Fallo la integracion. Contacte con su administrador.';
                            comentario.CommentBody = reembolso;
                        }
                    }
                }

            }else{
                reembolso = 'No se encontro el caso.';
                comentario.CommentBody = reembolso;
            }
			Insert comentario;	
            return reembolso;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.reembolsarCaso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return 'Fallo del sistema. Contacte con su administrador.';
        }
    }
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    30/11/2017          Ruben Pingarron Jerez     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    public static String noReembolsarCaso(String id){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            System.debug('No va a reembolsar el caso');
            CaseComment comentario = new CaseComment();
                        System.debug('Va a denegar el pago');
            List<Case> caso = [SELECT Id, R1_CAS_PKL_Subtype__c, ParentId FROM Case WHERE Id =:id LIMIT 1];
            String reembolso = '';
            comentario.ParentId = caso[0].ParentId;

            System.debug(caso);
            
            if(!caso.isEmpty()){
                caso[0].R1_CAS_PKL_Subtype__c = 'No corresponde reembolso';
                reembolso = 'No es reembolsable porque no existe una preorder para esta incidencia';
                comentario.CommentBody = reembolso;

                update caso;
            }
            System.debug('Este es el comentario ' + comentario);
            insert comentario;
            return reembolso;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.noReembolsarCaso()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return 'Fallo del sistema. Contacte con su administrador.';
        }
    }
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ruben Pingarron Jerez
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    30/11/2017          Ruben Pingarron Jerez     Initial version
    15/02/2018          Ismael Yubero Moreno      Añadidos valores de la tabla
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
    public static String menuPreOrder(String tipoInc, String subTipoInc, String cabina){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;         
            
            System.debug(tipoInc);
            System.debug(subTipoInc);
            System.debug(cabina);
            if(tipoInc == 'Menus Preorder A la carta'){
                if(subTipoInc == 'J/C Preorder distinto solicitado' || subTipoInc == 'Y/C A la carta distinto solicitado' || subTipoInc == 'W/C Preorder distinto solicitado' || subTipoInc == 'W/Y/C A la carta distinto solicitado'){
                    if(cabina == 'Business'){
                        tipoMenu = 'No corresponde';
                    }else if((cabina == 'Turista Premium' || cabina == 'Turista')){
                        tipoMenu = 'TDM';
                        System.debug('Pasa por aqui');
                    }
                }else if(subTipoInc == 'J/C Preorder falta solicitado' || subTipoInc == 'Y/C A la carta falta menú solicitado' || subTipoInc == 'W/C Preorder falta solicitado' || subTipoInc == 'W/Y/C A la carta falta menú solicitado' || subTipoInc == 'W/C  Preorder mal estado'){
                    if(cabina == 'Business'){
                        tipoMenu = 'No corresponde';
                    }else if((cabina == 'Turista Premium' || cabina == 'Turista')){
                        if(subTipoInc != 'W/C  Preorder mal estado'){
                            tipoMenu = 'TMM';
                        }else{
                            tipoMenu = 'TBM';
                        }
                    }
                }else if(subTipoInc == 'J/C Preorder mal estado' || subTipoInc == 'Y/C A la carta mal estado' || subTipoInc == 'W/Y/C A la carta mal estado'){
                    if(cabina == 'Business'){
                        tipoMenu = 'No corresponde';
                    }else if((cabina == 'Turista Premium' || cabina == 'Turista')){
                        tipoMenu = 'TBM';
                    }
                }else if(subTipoInc == 'Y/C A la carta baja aceptación' || subTipoInc == 'W/Y/C A la carta baja aceptación'){
                    tipoMenu = 'BBM';
                }
            }else if(tipoInc == 'Meal Standard SPML SBP'){
                if(subTipoInc == 'SPML no embarcada'){
                    tipoMenu = '';
                }
            }
            System.debug('Y por aqui ' + tipoMenu);
            return tipoMenu;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_PreOrderMethods.menuPreOrder()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Case');
            return null;
        }
    }


/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    16/02/2018          Ismael Yubero Moreno      Añadidos valores de la tabla
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
     public static void auxCreateCaseExpediente(List<R1_Incident__c> lstInc){
        String idInc = lstInc[0].Id;
        createCaseExpediente(idInc);
     }   


    //@future(callout=true)
    public static void createCaseExpediente(String incidencia){

        List<R1_Incident__c> lstInc = [SELECT Id, R2_INC_LOO_Flight__c, R2_INC_DATH_II_Flight_date__c, R2_INC_FOR_Flight_number__c,
            R2_INC_TXT_II_Depart_flight__c,  R2_INC_TXT_II_Arrival_flight__c, R1_INC_LOO_II_Client__c, R2_INC_TXT_name__c,
            R2_INC_TXT_lastname1__c, R2_INC_TXT_lastname2__c, R2_INC_TXT_II_TKT__c, R2_INC_PKL_II_Cabin__c FROM R1_Incident__c WHERE id =: incidencia LIMIT 1];

        System.debug('Incidencia ' + lstInc);

        Id rtExpediente = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
        Id rtPasj = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
        System.debug('Este es el TKT: ' +lstInc[0].R2_INC_TXT_II_TKT__c);
        List<Case> lstCase = [SELECT Id, R2_CAS_TXT_TKT_Ticket__c FROM Case WHERE RecordTypeId =: rtExpediente AND R2_CAS_TXT_TKT_Ticket__c =: lstInc[0].R2_INC_TXT_II_TKT__c AND R1_CAS_Fecha_vuelo__c =: Date.valueOf(lstInc[0].R2_INC_DATH_II_Flight_date__c) AND  R2_CAS_TXT_Flight_Origin__c =: lstInc[0].R2_INC_TXT_II_Depart_flight__c AND R2_CAS_TXT_Flight_Desnity__c =: lstInc[0].R2_INC_TXT_II_Arrival_flight__c];
        System.debug('************************ Expediente'+ lstCase);
        List<Case> lst = new List<Case>();
        if(!lstCase.isEmpty()){
            System.debug('Por aqui no va a pasar ahora');
        /////////////////////////////////////////////////////////////////////////////////////////////////////
            
        //System.debug('Va a comprobar si se admite un reembolso ');
        //    CaseComment comentario = new CaseComment();
        //    String resultado = '';
        //    String menuPreOrder = '';
            List<Case> casoPasaje = [SELECT Id, ParentId, R2_CAS_TXT_TKT_Ticket__c, R2_CAS_FOR_Flight_date_local__c, R2_CAS_FOR_Flight_number__c, R2_CAS_FOR_Origin__c, 
                               R2_CAS_FOR_Destination__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c, R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c, 
                               R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c FROM Case WHERE ParentId =: lstCase[0].Id AND RecordTypeId = :rtPasj AND R1_CAS_LOO_Incidences__c != null AND 
                               (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Type__c = 'Menus Preorder A la carta') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Cabin__c  != '') 
                               AND (R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c != null AND R1_CAS_LOO_Incidences__r.R2_INC_PKL_II_Subtype__c  != '') LIMIT 1];
            System.debug('LLamo a admitir reembolso ' + casoPasaje);
             if(!casoPasaje.isEmpty()){      
                    admiteReembolso(casoPasaje[0].Id);
               
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                    //System.debug('************************ Psaje'+ lstCasePasaje);
                    lstCase[0].RecordTypeId = rtExpediente;
                    lstCase[0].Type = 'Servicios gastronomicos';
                    lstCase[0].R1_CAS_PKL_Subtype__c = 'Petición datos';
                    lstCase[0].R1_CAS_PKL_Idioma__c = 'es';
                    if(lstInc[0].Id != null){
                        lstCase[0].R1_CAS_LOO_Incidences__c = lstInc[0].Id;
                    }
                    if(lstInc[0].R2_INC_LOO_Flight__c != null){
                        lstCase[0].R1_CAS_LOO_Flight__c = lstInc[0].R2_INC_LOO_Flight__c;
                    }
                    if(Date.valueOf(lstInc[0].R2_INC_DATH_II_Flight_date__c)!= null){
                        lstCase[0].R1_CAS_Fecha_vuelo__c = Date.valueOf(lstInc[0].R2_INC_DATH_II_Flight_date__c);
                    }
                    if(lstInc[0].R2_INC_FOR_Flight_number__c != null){
                        lstCase[0].R2_CAS_TXT_Flight_number__c = lstInc[0].R2_INC_FOR_Flight_number__c;
                    }
                        //cas.R2_CAS_PKL_Class_flown__c = lstInc[0].R2_INC_LOO_Flight__r.
                    if(lstInc[0].R2_INC_TXT_II_Depart_flight__c != null){
                        lstCase[0].R2_CAS_TXT_Flight_Origin__c = lstInc[0].R2_INC_TXT_II_Depart_flight__c; 
                    }
                    if(lstInc[0].R2_INC_TXT_II_Arrival_flight__c != null){
                        lstCase[0].R2_CAS_TXT_Flight_Desnity__c = lstInc[0].R2_INC_TXT_II_Arrival_flight__c;
                    }
                        ////cas.R1_CAS_TXT_PNR__c = 
                        ////cas.R2_CAS_PKL_OW__c = 

                        //lstCase[0].AccountID = lstInc[0].R1_INC_LOO_II_Client__c;
                    if(lstInc[0].R2_INC_TXT_name__c != null){
                        lstCase[0].R2_CAS_TXT_Name__c = lstInc[0].R2_INC_TXT_name__c;
                    }
                    if(lstInc[0].R2_INC_TXT_lastname1__c != null && lstInc[0].R2_INC_TXT_lastname2__c != null){
                        lstCase[0].R2_CAS_TXT_LastName__c = lstInc[0].R2_INC_TXT_lastname1__c + ' '+ lstInc[0].R2_INC_TXT_lastname2__c;
                    }
                    if(lstInc[0].R2_INC_TXT_II_TKT__c != null){
                        lstCase[0].R2_CAS_TXT_TKT_Ticket__c = lstInc[0].R2_INC_TXT_II_TKT__c;
                    }
                    if(lstInc[0].R2_INC_PKL_II_Cabin__c != null){
                        lstCase[0].R2_CAS_PKL_Class_flown__c = lstInc[0].R2_INC_PKL_II_Cabin__c;
                    }
                    System.debug('Se va a updatear el caso '+ lstCase);
                    //System.debug('Se va a updatear el caso '+ lstCasePasaje[0].R1_CAS_PKL_Subtype__c);

                    //update lstCasePasaje[0];
                    update lstCase[0];
                }
            
        }else{
            System.debug('Va a pasar por aqui y crear el caso');
            Case cas = new Case();
            cas.RecordTypeId = rtExpediente;
            cas.Type = 'Servicios gastronomicos';
             System.debug('Va a pasar por aqui y completar el tipo');
            cas.R1_CAS_PKL_Subtype__c = 'Petición datos';
             System.debug('Va a pasar por aqui y completar el subtipo');
            cas.R1_CAS_PKL_Idioma__c = 'es';
            cas.R1_CAS_LOO_Incidences__c = lstInc[0].Id;
            cas.R1_CAS_LOO_Flight__c = lstInc[0].R2_INC_LOO_Flight__c;
            cas.R1_CAS_Fecha_vuelo__c = Date.valueOf(lstInc[0].R2_INC_DATH_II_Flight_date__c);
            cas.R2_CAS_TXT_Flight_number__c = lstInc[0].R2_INC_FOR_Flight_number__c;
            //cas.R2_CAS_PKL_Class_flown__c = lstInc[0].R2_INC_LOO_Flight__r.
            cas.R2_CAS_TXT_Flight_Origin__c = lstInc[0].R2_INC_TXT_II_Depart_flight__c; 
            cas.R2_CAS_TXT_Flight_Desnity__c = lstInc[0].R2_INC_TXT_II_Arrival_flight__c;
            //cas.R1_CAS_TXT_PNR__c = 
            //cas.R2_CAS_PKL_OW__c = 

            cas.AccountID = lstInc[0].R1_INC_LOO_II_Client__c;
            cas.R2_CAS_TXT_Name__c = lstInc[0].R2_INC_TXT_name__c;
            cas.R2_CAS_TXT_LastName__c = lstInc[0].R2_INC_TXT_lastname1__c + ' '+ lstInc[0].R2_INC_TXT_lastname2__c;
            cas.R2_CAS_TXT_TKT_Ticket__c = lstInc[0].R2_INC_TXT_II_TKT__c;
            cas.R2_CAS_PKL_Class_flown__c = lstInc[0].R2_INC_PKL_II_Cabin__c;
            
            System.debug('Se va a crear el expediente ' +  cas);
            insert cas;
        }
        

   }
  
}