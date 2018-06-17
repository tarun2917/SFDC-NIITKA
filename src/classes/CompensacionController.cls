public with sharing class CompensacionController {
    
    private final Case caso;
    public List<Case> casoPadreList = new List<Case>();
    public Case casoPadre {get; set;}
    public List<R2_Compensation__c> compensaciones {get; set;}
    public List<R2_Compensation__c> compenIni {get; set;} //listado de compensaciones en estado Inicial
    public List<R2_Compensation__c> compenNoIni {get; set;} //listado de compensaciones que no están en estado Inicial
    public List<wrapPayment> compenEmitido {get; set;} //listado de compensaciones en estado Emitido o pendientes de emisión
    public List<List<wrapPayment>> compenEmitidoList {get; set;} //listado de compensaciones en estado Emitido o pendientes de emisión
    public List<List<wrapPayment>> compenEmitidoList2 {get; set;} //listado de compensaciones en estado Emitido, pendientes de emisión e inicial
    public R2_Compensation__c compensacion {get; set;}
    public List<List<wrapPayment>> compensacionesPendientes {get;set;}
    public List<List<wrapPayment>> compenTramitar {get; set;}
    public R2_Payment_order__c  oPago {get;set;}
    public R2_Payment_order__c opUpdate {get; set;}
    public Account cliente {get;set;}
    public List<R2_Compensation__c> pagosCompletados {get; set;} //listado de pagos en estado completado
    public List<String> camposList {get; set;} //etiquetas
    public Boolean flagEstado=false;
    public Boolean flagName=false;
    public Boolean flagCase=false;
    public Boolean flagFormaPago=false;
    public Boolean flagCliente=false;
    public Boolean flagNumCuenta=false;
    public Boolean flagMoneda=false;
    public Boolean flagCentro=false;
    public Boolean flagMotivo=false;
    public List<String> listaCampos {get; set;} //nombres api
    public Boolean isExpediente {get; set;} //servirá para renderizar vistas diferentes dentro de la visualforce dependiendo del RT del caso
    public Map<String, String> coloresAsignados; //mapa para almacenar los colores utilizados
    public Map<ID, List<R2_Compensation__c>> clientesPago;  //mapa que almacenará los pagos separados por cliente
    public List<wrapPayment> lpTemp;
    public List<wrapPayment> lpTemp2;
    public List<wrapPayment> lpTempEmitido;
    public String iban {get; set;} //almacenamos el valor del IBAN del formulario
    public String swift {get; set;} //almacenamos el valor del SWIFT del formulario
    public String soqlQuery {get; set;}
    public List<Id> identificadoresCH {get; set;}
    public Boolean duplicados {get; set;}
    public Map<Id,List<R2_Compensation__c>> mapaDuplicados {get; set;}
    public Map<ID,ID> mapaDupli {get; set;}
    public List<String> colores = new List<String>{'AzulClaro', 'Verde', 'Amarillo', 'Naranja', 'AzulOscuro', 'Negro', 'Violeta', 'Rosa', 'Rojo', 'VerdeOscuro', 'Marron', 'Oliva', 'Gris', 'Cian'};
    public String msg {get; set;}
    public List<wrapDuplicado> listadoDuplicados {get; set;}
    public Boolean escalado {get; set;} //pintará mensaje en pantalla en caso de ser escalado
    public Boolean equipajeVisible {get; set;} //controla la visibilidad en la visual del botón de equipaje
    public Boolean pasajeVisible {get; set;} //controla en la visual, la visibilidad del botón de pasaje
    public Map<Id, String> mapaNombres {get; set;} //almacena los nombres de los clientes
    public List<SelectOption> optionTipoDoc {get;set;} //almacena los valores de picklist del tipo de documento
    public List<SelectOption> optionPais {get;set;} //almacena los valores de picklist del pais de la orden de pago
    public List<SelectOption> optionTipoPago {get;set;} //almacena los valores de picklist del pais de la orden de pago
    public Account cuentaLookup {get;set;}
    public Boolean noValidado {get;set;}
    public Boolean validado {get;set;}
    public boolean displayPopup {get; set;}
    public R2_CLS_PYT_Validate_Payment.PaymentValidationWebResponse resp {get;set;}
    public String messageText {get;set;}
    public String resultado {get; set;}
    public List<String> errores {get;set;}
    public Boolean boolCheque {get;set;}
    public Boolean boolSepa {get; set;}
    public Boolean boolLatam {get; set;}
    public String valueTipoPago {get; set;}
    public String emailCliente {get;set;}
    public String telefonoCliente {get; set;}
    public String observaciones {get; set;}
    public String caseId{get; set;}
    public String labelPago {get;set;}
    public String centroPopUp {get;set;}
    public String cuentaPopUp {get;set;}
    public Boolean modoDePago {get;set;}
    public String formadePago {get;set;}


    
    
    public CompensacionController(ApexPages.StandardController stdController) {
        opUpdate = new R2_Payment_order__c();
        centroPopUp = '';
        cuentaPopUp = '';
        boolCheque = false;
        noValidado = true;
        
        // labelPago ='';
        boolSepa = false;
        validado = true;
        System.debug('COnstructor ' + boolCheque);
        boolLatam = false;
        modoDePago= false;
        errores = new List<String>();
        this.caso = (Case)stdController.getRecord();
        opUpdate.R2_OPY_LOO_CaseAccount__c = caso.Id;
        caseId =caso.Id;
        // System.debug('Id del caso: '+caso.Type);
        optionTipoDoc = new List<SelectOption>();
        optionTipoDoc.add(new SelectOption('', '--NONE--'));
        Schema.DescribeFieldResult fieldResult = R2_Compensation__c.R2_COM_PKL_Document_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            optionTipoDoc.add(new SelectOption(f.getValue(),f.getLabel()));
        }
        optionPais = new List<SelectOption>();
        optionPais.add(new SelectOption('', '--NONE--'));
        Schema.DescribeFieldResult fieldResult2 = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
        System.debug('Pais: ' + fieldResult2);
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple2)
        {
            optionPais.add(new SelectOption(f.getValue(),f.getLabel()));
        }
        optionTipoPago = new List<SelectOption>(); 
        optionTipoPago.add(new SelectOption('', '--NONE--'));
        Schema.DescribeFieldResult fieldResult3 = R2_Payment_order__c.R2_OPY_PKL_PaymentType__c.getDescribe();
        System.debug('Tipo de pago: ' + fieldResult3);
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        for( Schema.PicklistEntry f : ple3)
        {
            String sepa = f.getLabel();
            if(f.getValue() == 'CHEQUE'){
                optionTipoPago.add(new SelectOption(f.getValue(),f.getLabel()));
            }else if(f.getValue() == 'SEPA'){
                optionTipoPago.add(new SelectOption(f.getValue(),f.getLabel()));
            }else if(f.getValue() == 'LATAM'){
                optionTipoPago.add(new SelectOption(f.getValue(),f.getLabel()));
            }
        }
        
        compensacionIni();
        
    }   
    
    public Account getLookupAccount(){
         try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
        	return [Select id,Name,isPersonAccount from Account where isPersonAccount = true limit 1];
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.getLookupAccount', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    public void compensacionIni(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            //se hace un remove de colores y cuando refresca y se queda sin colores falla.
            System.debug('Se va a mostrar el pop up añ cargar la clase');
            
            // displayPopUpFormaPago = true;
            if(colores.isEmpty())colores = new List<String>{'AzulClaro', 'Verde', 'Amarillo', 'Naranja', 'AzulOscuro', 'Negro', 'Violeta', 'Rosa', 'Rojo', 'VerdeOscuro', 'Marron', 'Oliva', 'Gris', 'Cian'};
                escalado = false;
            Id expedienteRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            //comprobamos si no existe el caso
            Case emptyObj=new Case();
            duplicados=false;
            equipajeVisible = false;
            opUpdate = new R2_Payment_order__c();
            
            pasajeVisible = false;
            listadoDuplicados = new List<wrapDuplicado>();
            mapaNombres = new Map<Id, String>();
            mapaDupli = new Map<ID,ID>();
            if(caso != emptyObj){
                
                compenEmitidoList = new List<List<wrapPayment>>();
                compenEmitidoList2 = new List<List<wrapPayment>>();
                //inicializamos los mapas
                coloresAsignados = new Map<String, String>();
                clientesPago = new Map<ID, List<R2_Compensation__c>>();
                //comprobamos si se trata de un padre o de un hijo
                if(caso.RecordTypeId == expedienteRecordTypeId){
                    //se trata de un padre
                    isExpediente=true;
                }
                else{
                    isExpediente=false;
                }
                //iniciamos los datos del formulario
                swift = '';
                iban = '';
                //creamos una lista de colores para asignar los estilos
                casoPadreList = [select id, RecordTypeId,Type, R1_CAS_PKL_Subtype__c,R2_CAS_PKL_Manage__c,  Account.Name,R2_CAS_EMA_Email__c,R2_CAS_TEL_contact_phone__c, AccountId,R2_CAS_PKL_Type_document__c,R2_CAS_TXT_Identification_number__c,R2_CAS_TXT_Direccion_Postal_del_Pasajero__c, R2_CAS_DIV_Sum_Compensation__c, R2_CAS_DIV_Compensation__c, ContactId, CaseNumber, Origin, Subject, Description, R1_CAS_LOO_Flight__c, R1_CAS_PKL_Idioma__c, R2_CAS_PKL_Vip_Type__c, R1_CAS_TXT_Budgetary_center__c, R1_CAS_TXT_Charge_account__c  from Case where id=:caso.Id LIMIT 1];
                System.debug('Campos del caso expediente: ' +casoPadreList);
                this.opUpdate.R2_OPY_TXT_NIF__c=casoPadreList[0].R2_CAS_TXT_Identification_number__c;
                this.opUpdate.R2_OPY_PKL_Document_Type__c = casoPadreList[0].R2_CAS_PKL_Type_document__c;
                this.opUpdate.R2_OPY_PKL_Document_Type__c = casoPadreList[0].R2_CAS_PKL_Type_document__c;
                this.opUpdate.R2_OPY_LOO_CaseAccount__c = casoPadreList[0].AccountId;
                this.opUpdate.R2_OPY_TXT_Address1__c=casoPadreList[0].R2_CAS_TXT_Direccion_Postal_del_Pasajero__c;
                this.telefonoCliente = casoPadreList[0].R2_CAS_TEL_contact_phone__c;
                this.emailCliente = casoPadreList[0].R2_CAS_EMA_Email__c;
                if(casoPadreList.size()>0){
                    casoPadre = casoPadreList.get(0);
                    if(casoPadre.RecordTypeId == Label.R2_LB_RT_Child_bagagge){
                        //como se trata de un caso de equipaje, activamos el botón de la calculadora para que se vea
                        equipajeVisible = true;
                    }
                    else if(casoPadre.RecordTypeId == Label.R2_LB_RT_Child_passage){
                        //como se trata de un caso de pasaje, activamos el botón de la calculadora de pasaje
                        pasajeVisible = true;
                    }
                }    
                String camposDB = '';
                camposList = new List<String>();
                listaCampos = new List<String>();
                //La query necesita campos obligatorios como el status por lo que no se puede limitar solo al fieldset
                //   for(Schema.FieldSetMember s: Schema.SObjectType.Case.fieldSets.getMap().get('R2_FS_Campos_caso_VF_RL_motivo').getFields()){
                for(Schema.FieldSetMember s: Schema.SObjectType.R2_Compensation__c.fieldSets.getMap().get('R2_FS_Pago_Inicial').getFields()){     
                    camposList.add(s.label);
                    if(s.getFieldPath() != null){
                        system.debug('***Antes: ' + camposDB);
                        camposDB = camposDB + ',' + s.getFieldPath();
                        system.debug('***Despues: ' + camposDB);
                    }    
                    listaCampos.add(s.getFieldPath());
                    if(s.getFieldPath() == 'R2_COM_PKL_Status__c'){
                        flagEstado=true;
                    }
                    else if(s.getFieldPath() == 'Name'){
                        flagName=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_LOO_Case__r.R1_CAS_FOR_Case_Number__c'){
                        flagCase=true;           
                    }
                    else if(s.getFieldPath() == 'R2_COM_PKL_Payment_method__c'){
                        flagFormaPago=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_LOO_Client__c'){
                        flagCliente=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_TXT_Charge_account__c'){
                        flagNumCuenta=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_TXT_Passenger_Reason__c'){
                        flagMotivo=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_TXT_Budgetary_center__c'){
                        flagCentro=true;
                    }
                    else if(s.getFieldPath() == 'R2_COM_PKL_Currency_Claimed__c'){
                        flagMoneda=true;
                    }
                }
                if(!flagEstado){
                    camposDB = camposDB + ',R2_COM_PKL_Status__c';
                }
                if(!flagName){
                    camposDB = camposDB + ',Name';
                }
                if(!flagCase){
                    camposDB = camposDB + ',R2_COM_LOO_Case__r.R1_CAS_FOR_Case_Number__c';
                }
                if(!flagFormaPago){
                    camposDB = camposDB + ',R2_COM_PKL_Payment_method__c';
                }
                if(!flagCliente){
                    camposDB = camposDB + ',R2_COM_LOO_Client__c';
                }
                if(!flagNumCuenta){
                    camposDB = camposDB + ',R2_COM_TXT_Charge_account__c';
                }
                if(!flagMotivo){
                    camposDB = camposDB + ',R2_COM_TXT_Passenger_Reason__c';
                }
                if(!flagCentro){
                    camposDB = camposDB + ',R2_COM_TXT_Budgetary_center__c';
                }
                if(!flagMoneda){
                    camposDB = camposDB + ',R2_COM_PKL_Currency_Claimed__c';
                }
                
                //inicializamos las listas
                compensaciones = new List<R2_Compensation__c>();
                compenIni = new List<R2_Compensation__c>();
                compenNoIni = new List<R2_Compensation__c>();
                compenEmitido = new List<wrapPayment>();
                compensacionesPendientes = new List<List<wrapPayment>>();
                pagosCompletados = new List<R2_Compensation__c>();
                
                //Inicializamos la orden de pago
                oPago = new R2_Payment_order__c();
                
                
                //recuperamos los datos para pintar
                if(isExpediente){
                    //recuperamos todos los casos hijo
                    List<Case> casosHijo = new List<Case>();
                    casosHijo = [select id , parentId, AccountId, Type, R1_CAS_PKL_Subtype__c,R2_CAS_PKL_Manage__c from Case where parentId=:caso.id];
                    identificadoresCH = new List<Id>();
                    for(Case ident: casosHijo){
                        identificadoresCH.add(ident.Id);
                    }
                    System.debug('identificadoresCH '+identificadoresCH);
                    soqlQuery = 'select Id'+camposDB+', R2_COM_LOO_Account__r.Name,R2_COM_TXT_IBAN__c, R2_COM_PKL_Document_Type__c, R2_COM_TXT_Document_Number__c from R2_Compensation__c where (R2_COM_PKL_Payment_method__c =\'Cheque\' OR R2_COM_PKL_Payment_method__c =\'Transferencia\' OR R2_COM_PKL_Payment_method__c =\'Avios\') AND R2_COM_LOO_Case__c IN :identificadoresCH';
                    system.debug('*****query: ' + soqlQuery);
                    compensaciones = database.query(soqlQuery);
                    system.debug('*****compensaciones: ' + compensaciones);
                    if(!compensaciones.isEmpty()){
                        //recorremos primero para agrupar por cliente
                        for(R2_Compensation__c c: compensaciones){
                            //rellenamos el mapa de cuentas utilizadas
                            system.debug('****Comprobamos el pago: ' + c);
                            if(!mapaNombres.containsKey(c.R2_COM_LOO_Client__c)){
                                mapaNombres.put(c.R2_COM_LOO_Client__c, '');
                                system.debug('*****Agregamos al mapa: ' + c.R2_COM_LOO_Client__c);
                            }
                            if(clientesPago.containsKey(c.R2_COM_LOO_Client__c)){
                                //recuperamos la lista, la actualizamos, borramos la entrada del mapa y la recreamos
                                List<R2_Compensation__c> listaTemp = clientesPago.get(c.R2_COM_LOO_Client__c);
                                listaTemp.add(c);
                                clientesPago.remove(c.R2_COM_LOO_Client__c);
                                clientesPago.put(c.R2_COM_LOO_Client__c, listaTemp);                  
                            }
                            else{
                                //como no hay entrada para este cliente creamos una nueva
                                List<R2_Compensation__c> listaTemp = new List<R2_Compensation__c>();
                                listaTemp.add(c);
                                clientesPago.put(c.R2_COM_LOO_Client__c, listaTemp);
                            }
                        }
                        
                        
                        for(List<R2_Compensation__c> lc: clientesPago.values()){
                            //Recorremos la lista de listas para ir creando el wrapper con el estilo        
                            lpTemp = new List<wrapPayment>();
                            lpTemp2 = new List<wrapPayment>();
                            lpTempEmitido = new List<wrapPayment>();
                            for(R2_Compensation__c c: lc){
                                system.debug('****Proceso la compensación:'+ c);
                                if(c.R2_COM_PKL_Status__c == 'Emitido' || c.R2_COM_PKL_Status__c == 'Pendiente de emisión' || c.R2_COM_PKL_Status__c == 'Inicial'){
                                    system.debug('****c.R2_COM_PKL_Status__c == Emitido || c.R2_COM_PKL_Status__c == Pendiente de emisión || c.R2_COM_PKL_Status__c == Inicial');
                                    //miramos si ya hay un color asignado
                                    if(coloresAsignados.containsKey(c.R2_COM_TXT_IBAN__c)){
                                        system.debug('****R2_COM_TXT_IBAN__c');
                                        if(c.R2_COM_PKL_Status__c == 'Inicial'){
                                            system.debug('****Inicial');
                                            lpTemp2.add(new wrapPayment(c, coloresAsignados.get(c.R2_COM_TXT_IBAN__c)));
                                        }
                                        else{
                                            lpTemp.add(new wrapPayment(c, coloresAsignados.get(c.R2_COM_TXT_IBAN__c)));
                                            system.debug('****Añado a la temporal:'+ lpTemp);
                                        }    
                                    }
                                    else{
                                        //no se ha usado color por lo que procesamos el siguiente
                                        System.debug('>>>>>>>>>>>>>colores:'+colores);
                                        if(colores.size()>0){
                                            String color = colores.get(0);
                                            colores.remove(0);
                                            coloresAsignados.put(c.R2_COM_TXT_IBAN__c, color);
                                            if(c.R2_COM_PKL_Status__c == 'Inicial'){
                                                lpTemp2.add(new wrapPayment(c, color));
                                            }
                                            else{
                                                lpTemp.add(new wrapPayment(c, color));
                                            }                                   
                                            system.debug('****Añado a la temporal2:'+ lpTemp);
                                            if(c.R2_COM_PKL_Status__c == 'Escalado'){
                                                lpTempEmitido.add(new wrapPayment(c, color));
                                            }
                                        }
                                    }                
                                }
                                if(c.R2_COM_PKL_Status__c == 'Emitido' || c.R2_COM_PKL_Status__c == 'Completado'){
                                    System.debug('if(c.R2_COM_PKL_Status__c == Emitido || c.R2_COM_PKL_Status__c == Completado)');
                                    pagosCompletados.add(c);
                                }
                            }
                            system.debug('****Antes dl if:'+lpTemp);
                            if(!lpTemp.isEmpty()){
                                //si no está vacia la añadimos a la lista final
                                compenEmitidoList.add(lpTemp);
                                compensacionesPendientes.add(lpTemp);
                                compenEmitidoList2.add(lpTemp);
                                system.debug('****Añado la lista:'+compenEmitidoList);
                            } 
                            system.debug('****Antes dl if2:'+lpTemp2);
                            if(!lpTemp2.isEmpty()){
                                //si no está vacia la añadimos a la lista final
                                compenEmitidoList2.add(lpTemp2);
                            }
                            /* if(!lpTempEmitido.isEmpty()){
                            compensacionesPendientes.add(lpTempEmitido);
                            }*/
                            system.debug('*****compensacionesPendientes:' + compensacionesPendientes);
                        }
                        //recuperamos la cuenta para mostrar en el formulario de los datos bancarios
                        //+++++++aqui meter que lo haga sobre la lista de todos los ids y luego se le da al cliente el que corresponde
                        system.debug('*****NombreCuentas: ' + mapaNombres.values());
                        List<Account> listaAcc = [Select id, Name, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Identification_number__c from Account where id IN :mapaNombres.keySet()];
                        system.debug('*****Lista de cuentas:'+listaAcc);
                        if(!listaAcc.isEmpty()){
                            mapaNombres = new Map<Id, String>();
                            for(Account a : listaAcc){
                                if(a.Id == casoPadre.AccountId){
                                    cliente = listaAcc.get(0);
                                }
                                if(!mapaNombres.containsKey(a.id)){
                                    mapaNombres.put(a.Id, a.Name);
                                }                                           
                            }
                        }
                        
                        
                        
                        
                        /*   List<Account> listaAcc = [Select id, Name, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Identification_number__c from Account where id=:casoPadre.AccountId];
                        if(!listaAcc.isEmpty()){
                        cliente = listaAcc.get(0);
                        }*/
                    }
                    system.debug('***Mapa: ' + mapaNombres);
                }
                else{
                    soqlQuery = 'select Id'+camposDB+' from R2_Compensation__c where R2_COM_LOO_Case__c =\'' + caso.Id + '\'';
                    system.debug('****Query: ' + soqlQuery);
                    compensaciones = database.query(soqlQuery);
                    mapaNombres = new Map<Id,String>();
                    //compensaciones = [Select id, Name, R2_COM_PKL_Status__c, R2_COM_PKL_Type__c, R2_COM_LOO_Case__c, R2_COM_DIV_Total_Amount__c, R2_COM_LOO_Client__c   from R2_Compensation__c where R2_COM_LOO_Case__c =:caso.Id];
                    if(!compensaciones.isEmpty()){
                        for(R2_Compensation__c c: compensaciones){
                            if(!mapaNombres.containsKey(c.R2_COM_LOO_Client__c)){
                                mapaNombres.put(c.R2_COM_LOO_Client__c, '');
                                system.debug('*****Agregamos al mapa: ' + c.R2_COM_LOO_Client__c);
                            }
                            if(c.R2_COM_PKL_Status__c == 'Inicial'){
                                compenIni.add(c);
                            }
                            else{
                                compenNoIni.add(c);
                            }
                        }
                        //recuperamos la cuenta para mostrar en el formulario de los datos bancarios
                        system.debug('*****NombreCuentas: ' + mapaNombres.values());
                        List<Account> listaAcc = [Select id, Name, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Identification_number__c from Account where id IN :mapaNombres.keySet()];
                        system.debug('*****Lista de cuentas:'+listaAcc);
                        if(!listaAcc.isEmpty()){
                            mapaNombres = new Map<Id, String>();
                            for(Account a : listaAcc){
                                if(a.Id == casoPadre.AccountId){
                                    cliente = listaAcc.get(0);
                                }
                                if(!mapaNombres.containsKey(a.id)){
                                    mapaNombres.put(a.Id, a.Name);
                                }                                           
                            }
                        }
                    }       
                } 
            }
            System.debug('****compenNoIni:'+ compenNoIni);
            System.debug('****compenIni:'+ compenIni);
            system.debug('****ListaVF:'+ compenEmitidoList);    
            system.debug('****ListaVF2:'+ compenEmitidoList2);
            system.debug('****ListaCampos:' + listaCampos);
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.compensacionIni', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            //return null;
        }
    }
    
    public void guardar(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            if(oPago != null){
                Database.SaveResult sr = Database.insert(oPago, false);
                if(sr.isSuccess()){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Orden de pago creada'));
                    //+++ Aqui habría que redirigir a la visual que muestra el historico de pagos para ese cliente
                }
                else{
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No se pudo crear la orden de pagos');
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.guardar', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            //return null;
        }
    }
    
    /*public void GuardarIBAN(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            system.debug('***Entro en guardar iban');
            system.debug('****compenEmitidoList: ' + compenEmitidoList);
            List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
            R2_Compensation__c pago = new R2_Compensation__c();
            //recuperamos los pagos y cancelamos los que esten marcados
            for(List<wrapPayment> cList : compenEmitidoList){
                for(wrapPayment c: cList){
                    system.debug('*****Proceso entrada: ' + c);
                    if(c.selected){
                        pago = c.pago;
                        pago.R2_COM_PKL_Status__c = 'Emitido';
                        pago.R2_COM_TXT_SWIFT__c = opUpdate.R2_OPY_TXT_SWIFT__c;
                        pago.R2_COM_TXT_IBAN__c = opUpdate.R2_OPY_TXT_IBAN__c;                                                                    
                        pagos.add(pago); 
                    }
                }
            }    
            Database.SaveResult[] srList = Database.update(pagos, false);
            Integer contadorOK = 0;
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    System.debug('***Se actualizó correctamente: ' + sr.getId());
                    contadorOK++;
                }
                else {
                    // Error al actualizar, por lo que recuperamos los errores              
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());
                    }
                }               
            }
            //mostramos los registros actualziados correctamente
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Actualizados '+ contadorOK + ' pagos.'));
            system.debug('***Actualizo los pagos:' + pagos);  
            msg = 'Actualizados '+ contadorOK + ' pagos.';
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.GuardarIBAN', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            //return null;
        }
    }*/
    
    public void ComprobarDuplicados(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
        
            system.debug('***Entro en guardar iban');
            system.debug('****compenEmitidoList: ' + compenEmitidoList);
            system.debug('****mapaNombres: ' + mapaNombres);
            //primero recuperamos todos los posibles duplicados antes de actualizar los datos
            //Hacemos una lista con todos los pagos que tenemos seleccionados
            List<R2_Compensation__c> pagosDupNombre = new List<R2_Compensation__c>();
            List<R2_Compensation__c> pagosDupIBAN = new List<R2_Compensation__c>();
            List<R2_Compensation__c> pagosSel = new List<R2_Compensation__c>();
            List<ID> listaIdCuenta = new List<ID>(); //listado de los ID seleccionados
            Set<String> listaNombre = new Set<String>(); //listado de nombre y apellidos de los seleccionados
            set<String> listaIBAN= new Set<String>(); //listado IBAN de los elementos seleccionados
            //hacemos una lista con los valores seleccionados, no consideraremos duplicados entre ellos mismos
            for(List<wrapPayment> listawp : compenEmitidoList){
                for(wrapPayment wpt : listawp){
                    if(wpt.selected){
                        listaIdCuenta.add(wpt.pago.id);
                        pagosSel.add(wpt.pago);
                        if(!listaNombre.contains(wpt.pago.R2_COM_LOO_Client__c)){
                            listaNombre.add(wpt.pago.R2_COM_LOO_Client__c);
                        }    
                        if(!listaIBAN.contains(wpt.pago.R2_COM_TXT_IBAN__c) && wpt.pago.R2_COM_TXT_IBAN__c!='' && wpt.pago.R2_COM_TXT_IBAN__c!=null){
                            listaIBAN.add(wpt.pago.R2_COM_TXT_IBAN__c);
                        }   
                    } 
                }
            }
            System.debug('IBAN: '+opUpdate.R2_OPY_TXT_IBAN__c);
            listaIBAN.add(opUpdate.R2_OPY_TXT_IBAN__c);
            //obtenemos los posibles pagos duplicados
            pagosDupNombre = [select id, name, R2_COM_LOO_Client__c, R2_COM_TXT_IBAN__c, R2_COM_PKL_Status__c, R2_COM_TXT_Passenger_Reason__c, R2_COM_DIV_Total_Amount__c  
                              from R2_Compensation__c 
                              where id not in :listaIdCuenta AND R2_COM_LOO_Client__c in :listaNombre AND (R2_COM_PKL_Status__c = 'Enviado' OR R2_COM_PKL_Status__c = 'Completado')];
            pagosDupIBAN = [select id, name, R2_COM_LOO_Client__c, R2_COM_TXT_IBAN__c, R2_COM_PKL_Status__c, R2_COM_TXT_Passenger_Reason__c, R2_COM_DIV_Total_Amount__c   
                            from R2_Compensation__c 
                            where id not in :listaIdCuenta AND R2_COM_TXT_IBAN__c in :listaIBAN AND (R2_COM_PKL_Status__c = 'Enviado' OR R2_COM_PKL_Status__c = 'Completado')];
            mapaDupli = new Map<ID,ID>();
            //Creamos la estructura de memoria para pintar estos duplicados           
            Map<Id,List<R2_Compensation__c>> mapaDuplicados = new Map<Id,List<R2_Compensation__c>>(); 
            listadoDuplicados = new List<wrapDuplicado>();
            //y la poblamos
            for(R2_Compensation__c ps :pagosSel){
                /////////////////////////////////////////////
                if(!mapaNombres.containsKey(ps.R2_COM_LOO_Client__c)){
                    System.debug('Entra en ps MapaNombres');
                    mapaNombres.put(ps.R2_COM_LOO_Client__c, '');
                    system.debug('*****Agregamos al mapa: ' + ps.R2_COM_LOO_Client__c);
                }
                /////////////////////////////////////////////
                System.debug(ps);
                for(R2_Compensation__c pn :pagosDupNombre){
                    System.debug(pn);
                    /////////////////////////////////////////////
                    if(!mapaNombres.containsKey(pn.R2_COM_LOO_Client__c)){
                        System.debug('Entra en pn MapaNombres');
                        mapaNombres.put(pn.R2_COM_LOO_Client__c, '');
                        system.debug('*****Agregamos al mapa: ' + pn.R2_COM_LOO_Client__c);
                    }
                    /////////////////////////////////////////////
                    if(pn.R2_COM_LOO_Client__c == ps.R2_COM_LOO_Client__c){
                        List<R2_Compensation__c> lstTempPago = new List<R2_Compensation__c>();
                        if(mapaDuplicados.containsKey(ps.id)){
                            lstTempPago = mapaDuplicados.get(ps.id);
                            lstTempPago.add(pn);
                            mapaDuplicados.remove(ps.id);
                            mapaDuplicados.put(ps.id, lstTempPago);
                            duplicados=true;
                            mapaDupli.put(ps.id, pn.id);
                            listadoDuplicados.add(new wrapDuplicado(ps, pn, 'cliente'));
                        }
                        else{
                            lstTempPago.add(pn);
                            mapaDuplicados.put(ps.id, lstTempPago);
                            duplicados=true;
                            mapaDupli.put(ps.id, pn.id);
                            listadoDuplicados.add(new wrapDuplicado(ps, pn, 'cliente'));
                        }
                    }
                }
                for(R2_Compensation__c pi :pagosDupIBAN){
                    System.debug(pi);
                    /////////////////////////////////////////////
                    if(!mapaNombres.containsKey(pi.R2_COM_LOO_Client__c)){
                        mapaNombres.put(pi.R2_COM_LOO_Client__c, '');
                        system.debug('*****Agregamos al mapa: ' + pi.R2_COM_LOO_Client__c);
                    }
                    /////////////////////////////////////////////
                    if(pi.R2_COM_TXT_IBAN__c == ps.R2_COM_TXT_IBAN__c){
                        List<R2_Compensation__c> lstTempPago = new List<R2_Compensation__c>();
                        if(mapaDuplicados.containsKey(ps.id)){
                            lstTempPago = mapaDuplicados.get(ps.id);
                            lstTempPago.add(pi);
                            mapaDuplicados.remove(ps.id);
                            mapaDuplicados.put(ps.id, lstTempPago);
                            duplicados=true;
                            mapaDupli.put(ps.id, pi.id);
                            listadoDuplicados.add(new wrapDuplicado(ps, pi, 'iban'));
                        }
                        else{
                            lstTempPago.add(pi);
                            mapaDuplicados.put(ps.id, lstTempPago);
                            duplicados=true;
                            mapaDupli.put(ps.id, pi.id);
                            listadoDuplicados.add(new wrapDuplicado(ps, pi, 'iban'));
                        }
                    }            
                }
            }
            /////////////////////////////////////////////
            system.debug('*****NombreCuentas: ' + mapaNombres);
            List<Account> listaAcc = [Select id, Name, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Identification_number__c from Account where id IN :mapaNombres.keySet()];
            system.debug('*****Lista de cuentas:'+listaAcc);
            if(!listaAcc.isEmpty()){
                mapaNombres = new Map<Id, String>();
                for(Account a : listaAcc){
                    if(a.Id == casoPadre.AccountId){
                        cliente = listaAcc.get(0);
                    }
                    if(!mapaNombres.containsKey(a.id)){
                        mapaNombres.put(a.Id, a.Name);
                    }                                           
                }
            }
            /////////////////////////////////////////////
            //mostramos los posibles duplicados por pantalla en caso de existir
            system.debug('****Mapa:' + mapaDuplicados);
            system.debug('****Mapa tamaño:' + mapaDuplicados.size());
            if(mapaDuplicados.size()>0){                
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Posibles duplicados, reviselos antes de continuar');
                ApexPages.addMessage(myMsg);
                msg = 'Posibles duplicados, reviselos antes de continuar';
                //marcamos los posibles registros a revisar por duplicados
                List<List<wrapPayment>> temporalWrapper = new List<List<wrapPayment>>();
                List<wrapPayment> temporalLW= new List<wrapPayment>();
                wrapPayment temporalW;
                for(List<wrapPayment> wptemp: compenEmitidoList){
                    for(wrapPayment wp : wptemp){
                        if(mapaDuplicados.containsKey(wp.pago.id)){
                            //    temporalW = wp;
                            //    temporalW.duplicado = 'duplicado';  
                            wp.duplicado = 'duplicado';
                        }
                        else{
                            //  temporalW = wp;
                            //  temporalW.duplicado = '';
                        }
                        //  temporalLW.add(temporalW);
                    }
                    // temporalWrapper.add(temporalLW);
                }
                //compenEmitidoList = temporalWrapper;
                system.debug('****despues duplicados ListadoDuplicados: '+listadoDuplicados);
                system.debug('****despues duplicados compenEmitidoList: '+compenEmitidoList);
            }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, 'No se han encontrado duplicados.');
                ApexPages.addMessage(myMsg);
                msg = 'No se han encontrado duplicados.';
            }
            //compensacionIni();
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.ComprobarDuplicados', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            //return null;
        }
    }
    
    
    
    //si elige procesar el pago abriremos la siguiente visualforce
    public PageReference gotoPage(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            noValidado = true;
            compensacionIni();
            PageReference pr = Page.FormularioCuentaC;
            pr.setRedirect(false);
            return pr;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.gotoPage', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    //si elige crear orden de pago abriremos la siguiente visualforce
    public PageReference GotoOP(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            PageReference pr = Page.CrearOP;
            pr.setRedirect(false);
            return pr;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.GotoOP', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    //creamos la orden de pago
    public PageReference crearOp(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            //primero actualizamos los datos de los pagos seleccionados con los datos de la orden de pago rellenos y actualizamos su estado a enviado
            //Decimal suma = 0; //variable que nos indicará lo que debemos sumarle al expediente.
            List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
            List<R2_Compensation__c> pagosUpdate = new List<R2_Compensation__c>();
            List<R2_Compensation__c> pagosAvios = new List<R2_Compensation__c>(); //lista de pagos para avios
            Map<String, List<R2_Compensation__c>> pagosDinero = new Map<String, List<R2_Compensation__c>>();
            List<String> listadoIban = new List<String>();
            R2_Compensation__c pago = new R2_Compensation__c();
            //recuperamos los pagos y actualizamos los que esten marcados
            for(List<wrapPayment> cList : compenEmitidoList){
                for(wrapPayment c: cList){
                    if(c.selected){
                        pago = c.pago;
                        //suma = suma + pago.R2_COM_DIV_Total_Amount__c;
                        pago.R2_COM_PKL_Status__c = 'Enviado';
                        System.debug('Pago enviado');
                        if(opUpdate.R2_OPY_TXT_SWIFT__c != null)
                            pago.R2_COM_TXT_SWIFT__c = opUpdate.R2_OPY_TXT_SWIFT__c;
                        if(opUpdate.R2_OPY_TXT_IBAN__c != null)
                            pago.R2_COM_TXT_IBAN__c = opUpdate.R2_OPY_TXT_IBAN__c;
                        if(pago.R2_COM_PKL_Payment_method__c == 'Avios'){
                            pagosAvios.add(pago);
                            pagosUpdate.add(pago);
                        }
                        else if(pago.R2_COM_PKL_Payment_method__c == 'Cheque' || pago.R2_COM_PKL_Payment_method__c == 'Transferencia'){                                                                    
                            if(pagosDinero.ContainsKey(pago.R2_COM_TXT_IBAN__c)){
                                pagos = pagosDinero.get(pago.R2_COM_TXT_IBAN__c);
                                pagosDinero.remove(pago.R2_COM_TXT_IBAN__c);
                                pagos.add(pago);
                                pagosDinero.put(pago.R2_COM_TXT_IBAN__c, pagos);
                            }
                            else{
                                pagos = new List<R2_Compensation__c>();
                                pagos.add(pago);
                                pagosDinero.put(pago.R2_COM_TXT_IBAN__c, pagos);
                                listadoIban.add(pago.R2_COM_TXT_IBAN__c);
                            }
                            pagosUpdate.add(pago);
                        }    
                    }    
                }
            }    
            Database.SaveResult[] srList = Database.update(pagosUpdate, false);
            Integer contadorOK = 0;
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    System.debug('***Se actualizó correctamente: ' + sr.getId());
                    contadorOK++;
                }
                else {
                    // Error al actualizar, por lo que recuperamos los errores              
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());
                    }
                }               
            }
            
            
             
            
            //una vez actualizados los pagos procedemos a crear las ordenes de pago pertinentes
            R2_Payment_order__c opAvios = new R2_Payment_order__c();
            opAvios.R2_OPY_LOO_CaseAccount__c = opUpdate.R2_OPY_LOO_CaseAccount__c;
            List<R2_Compensation__c> pagosAvios2 = new List<R2_Compensation__c>(); //lista de pagos para avios
            //si falla algo en la creación de la orden o en la actualización de los pagos o del expediente revertimos todos los cambios
            Savepoint sp = Database.setSavepoint();
            /*if(pagosAvios.size() > 0){ //hay pagos con AVIOS
                opAvios.R2_OPY_PCK_Status__c = 'Borrador';
                opAvios.R2_OPY_LOO_File_associated__c = casoPadre.Id;
                opAvios.R2_OPY_PKL_PaymentType__c = 'AVIOS';
                opAvios.R2_OPY_TXT_Address2__c = opUpdate.R2_OPY_TXT_Address2__c;
                opAvios.R2_OPY_TXT_Province__c = opUpdate.R2_OPY_TXT_Province__c;
                opAvios.R2_OPY_ATXTL_Others__c = opUpdate.R2_OPY_ATXTL_Others__c;
                opAvios.R2_OPY_TXT_NIF__c = opUpdate.R2_OPY_TXT_NIF__c;
                opAvios.R2_OPY_TXT_NIF_Name__c = opUpdate.R2_OPY_TXT_NIF_Name__c;
                opAvios.R2_OPY_LOO_CaseAccount__c = opUpdate.R2_OPY_LOO_CaseAccount__c;
                Database.SaveResult srOP = Database.insert(opAvios, true);
                if (srOP.isSuccess()) {
                    System.debug('***Se creo la OP de avios: ' + srOP.getId());
                    opAvios.Id = srOP.getId();
                    List<R2_Compensation__c> lpt = new List<R2_Compensation__c>();
                    R2_Compensation__c pt = new R2_Compensation__c();
                    //recorremos la lista de pagos en avios para actualizarles el lookup a la nueva OP
                    for(R2_Compensation__c pag: pagosAvios){
                        pt = pag;
                        pt.R2_COM_LOO_Payment_Code__c = opAvios.Id;
                        lpt.add(pt);
                    }
                    Database.SaveResult[] srPT = Database.update(lpt, true);
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : srOP.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());                   
                    }
                    //Hacemos el rollback
                    Database.rollback(sp);
                }
            }
            */
            //comprobamos los pagos de dinero
            List<R2_Payment_order__c> lOP = new List<R2_Payment_order__c>();
            for(String s: listadoIban){
                List<R2_Compensation__c> ltempo = pagosDinero.get(s);
                //creamos una OP para estos pagos
                R2_Payment_order__c opt = opUpdate;
                lOP.add(opt);
                //recorremos los pagos asociados para vincularlos a esta OP.
                
            }
            
            //Decimal sumaTotal = 0;
            List<R2_Compensation__c> compensacionesUpdate = new List<R2_Compensation__c>();
            R2_Payment_order__c op = new R2_Payment_order__c();
            op.R2_OPY_LOO_CaseAccount__c = opUpdate.R2_OPY_LOO_CaseAccount__c;
            System.debug('Nombre NIF: '+ opUpdate.R2_OPY_LOO_CaseAccount__r.Name);
            System.debug('Centro presupuestario: '+ pagos[0].R2_COM_TXT_Budgetary_center__c);
            System.debug('Cuenta: '+ pagos[0].R2_COM_TXT_Charge_account__c);
            
            op.R2_OPY_TXT_Coin__c = pagos[0].R2_COM_PKL_Currency_Claimed__c;
            op.R2_OPY_TXT_Budget_Center__c = pagos[0].R2_COM_TXT_Budgetary_center__c;
            op.R2_OPY_TXT_Charge_account__c = pagos[0].R2_COM_TXT_Charge_account__c;
            op.R2_OPY_TXT_Address1__c = opUpdate.R2_OPY_TXT_Address1__c;
            op.R2_OPY_TXT_Address2__c = opUpdate.R2_OPY_TXT_Address2__c;
            op.R2_OPY_TXT_Province__c = opUpdate.R2_OPY_TXT_Province__c!=null ? opUpdate.R2_OPY_TXT_Province__c:'-';
            op.R2_OPY_ATXTL_Others__c = opUpdate.R2_OPY_ATXTL_Others__c;
            op.R2_OPY_TXT_NIF__c = opUpdate.R2_OPY_TXT_NIF__c;
            op.R2_OPY_PKL_Document_Type__c = opUpdate.R2_OPY_PKL_Document_Type__c;
            op.R2_OPY_TXT_Account_Type__c = opUpdate.R2_OPY_TXT_Account_Type__c;
            op.R2_OPY_TXT_IBAN__c = opUpdate.R2_OPY_TXT_IBAN__c;
            op.R2_OPY_ATXTL_Others__c = opUpdate.R2_OPY_ATXTL_Others__c;
            op.R2_OPY_TXT_SWIFT__c = opUpdate.R2_OPY_TXT_SWIFT__c;
            op.R2_OPY_TXT_City__c = opUpdate.R2_OPY_TXT_City__c;
            op.R2_OPY_TXT_Bank_Name__c = opUpdate.R2_OPY_TXT_Bank_Name__c;
            op.R2_OPY_TXT_Bank_Country__c = opUpdate.R2_OPY_TXT_Bank_Country__c;
            op.R2_OPY_TXT_Fed_ABA__c = opUpdate.R2_OPY_TXT_Fed_ABA__c;
            op.R2_OPY_TXT_Chips_ABA__c = opUpdate.R2_OPY_TXT_Chips_ABA__c;
            op.R2_OPY_TXT_Bank_Account__c = opUpdate.R2_OPY_TXT_Bank_Account__c;
            op.R2_OPY_TXT_External_Local_Account__c = opUpdate.R2_OPY_TXT_External_Local_Account__c;
            op.R2_OPY_TXT_Latam_Bank__c = opUpdate.R2_OPY_TXT_Latam_Bank__c;
            op.R2_OPY_TXT_Latam_Sucursal__c = opUpdate.R2_OPY_TXT_Latam_Sucursal__c;
            op.R2_OPY_TXT_Latam_DC__c = opUpdate.R2_OPY_TXT_Latam_DC__c;
            op.R2_OPY_TXT_Latam_Account__c = opUpdate.R2_OPY_TXT_Latam_Account__c;
            op.R2_OPY_TXT_Bank_Code__c = opUpdate.R2_OPY_TXT_Bank_Code__c;
            op.R2_OPY_TXT_Bank_Sucursal__c = opUpdate.R2_OPY_TXT_Bank_Sucursal__c;
            op.R2_OPY_TXT_Control_Digit__c = opUpdate.R2_OPY_TXT_Control_Digit__c;
            op.R2_OPY_TXT_Postal_Code__c = opUpdate.R2_OPY_TXT_Postal_Code__c!=null ? opUpdate.R2_OPY_TXT_Postal_Code__c:'-';
            R2_Compensation__c compen = new R2_Compensation__c();
            
            //si falla algo en la creación de la orden o en la actualización de los pagos o del expediente revertimos todos los cambios
            sp = Database.setSavepoint();
            //creamos la orden de pago
            op.R2_OPY_PCK_Status__c = 'Borrador';
            op.R2_OPY_LOO_File_associated__c = casoPadre.Id;
            //mostramos los registros actualizados correctamente
            if(opUpdate.R2_OPY_TXT_Bank_Country__c!='' && opUpdate.R2_OPY_TXT_Bank_Country__c!=null){
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debe elegir un Pais para continuar'));
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Actualizados '+ contadorOK + ' pagos.'));
                system.debug('***Actualizo los pagos:' + pagos);  
                msg = 'Actualizados '+ contadorOK + ' pagos.'; 
                if(observaciones != null || observaciones != ''){
                    op.R2_OPY_ATXTL_Others__c = observaciones;
                }
                Database.SaveResult srOP = Database.insert(op, true);
                if (srOP.isSuccess()) {
                    System.debug('***Se creo la OP: ' + srOP.getId());
                    op.Id = srOP.getId();
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : srOP.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());                   
                    }
                    //Hacemos el rollback
                    Database.rollback(sp);
                }
            }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Debe elegir un Pais para continuar.');
                ApexPages.addMessage(myMsg);
                msg = 'Debe elegir un Pais para continuar.'; 
            }
  
            //para cada pago seleccionado hay que cambiarle el estado a enviado y añadir su valor al expediente
            for(List<wrapPayment> lwp :compensacionesPendientes){
                for(wrapPayment wp :lwp){
                    if(wp.selected){
                        //suma = suma + wp.pago.R2_COM_DIV_Total_Amount__c;
                        compen = wp.pago;
                        compen.R2_COM_LOO_Payment_Code__c = op.Id; //vinculamos los pagos a la OP
                        compen.R2_COM_PKL_Status__c = 'Enviado'; //ponemos los pagos a estado enviado
                        compensacionesUpdate.add(compen);
                    }
                }
            }
            System.debug('***********************************CasoPadre: '+casoPadre.Id);
            //sumaTotal = casoPadre.R2_CAS_DIV_Sum_Compensation__c;
            //actualizamos los pagos
            srList = Database.update(compensacionesUpdate, true);
            for (Database.SaveResult srpago : srList) {
                if (srPago.isSuccess()) {
                    System.debug('***Se actualizó correctamente: ' + srpago.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : srPago.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());
                    }
                }
            }       
            
            //mostramos mensaje si se ha escalado y deshabilitamos el botón para que no le de de nuevo a crear orden de pago
            //////////////////////////////////

            //////////////////////////////////
            //System.debug('*********************************'+sumaTotal);
            //if(op.R2_OPY_DIV_Amount__c != null){
            //sumatotal += op.R2_OPY_DIV_Amount__c;
            //}
            /*if(sumaTotal > 850){
            System.debug('*********************************ESCALADO');
            escalado = true;
            if(sumaTotal > 3000){
            System.debug('*********************************ESCALADO 3000');
            Group grupo = [select Id, Name from Group where Type = 'Queue' AND Name='USR Pagos'];
            op.R2_OPY_PCK_Status__c = 'ESCALADO';
            op.R2_OPY_LOO_Submitter__c = UserInfo.getUserId();
            op.R2_OPY_TXT_ApproverGroup__c = ''+grupo.Name;
            }
            else{
            Group grupo = [select Id, Name from Group where Type = 'Queue' AND Name='SYR Supervisores'];
            System.debug('*********************************ESCALADO');
            op.R2_OPY_PCK_Status__c = 'ESCALADO';
            op.R2_OPY_LOO_Submitter__c = UserInfo.getUserId(); 
            op.R2_OPY_TXT_ApproverGroup__c = ''+grupo.Name;
            }
            }
            else{
            escalado = false;
            op.R2_OPY_PCK_Status__c = 'Ready';
            }*/
           
            return null; 
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.crearOp', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    
    public PageReference traza(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            system.debug('****LLego a la traza');
            system.debug('****compenEmitidoList: ' + compenEmitidoList);
            return null; 
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.traza', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    //proceso que recupera los pagos validados
    public void iniciaValidados(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            compensacionesPendientes = new List<List<wrapPayment>>();
            clientesPago = new Map<ID, List<R2_Compensation__c>>();
            coloresAsignados = new Map<String, String>();
            colores = new List<String>{'AzulClaro', 'Verde', 'Amarillo', 'Naranja', 'AzulOscuro', 'Negro', 'Violeta', 'Rosa', 'Rojo', 'VerdeOscuro', 'Marron', 'Oliva', 'Gris', 'Cian'};
                system.debug('****soqlQuery:'+soqlQuery);
            compensaciones = database.query(soqlQuery);
            if(!compensaciones.isEmpty()){
                //recorremos primero para agrupar por cliente
                for(R2_Compensation__c c: compensaciones){
                    if(clientesPago.containsKey(c.R2_COM_LOO_Client__c)){
                        //recuperamos la lista, la actualizamos, borramos la entrada del mapa y la recreamos
                        List<R2_Compensation__c> listaTemp = clientesPago.get(c.R2_COM_LOO_Client__c);
                        listaTemp.add(c);
                        clientesPago.remove(c.R2_COM_LOO_Client__c);
                        clientesPago.put(c.R2_COM_LOO_Client__c, listaTemp);                  
                    }
                    else{
                        //como no hay entrada para este cliente creamos una nueva
                        List<R2_Compensation__c> listaTemp = new List<R2_Compensation__c>();
                        listaTemp.add(c);
                        clientesPago.put(c.R2_COM_LOO_Client__c, listaTemp);
                    }
                }
                
                
                for(List<R2_Compensation__c> lc: clientesPago.values()){
                    //Recorremos la lista de listas para ir creando el wrapper con el estilo        
                    lpTemp = new List<wrapPayment>();
                    lpTempEmitido = new List<wrapPayment>();
                    for(R2_Compensation__c c: lc){
                        if(c.R2_COM_PKL_Status__c == 'Emitido' || c.R2_COM_PKL_Status__c == 'Pendiente de emisión'){
                            //miramos si ya hay un color asignado
                            if(coloresAsignados.containsKey(c.R2_COM_TXT_IBAN__c)){
                                lpTemp.add(new wrapPayment(c, coloresAsignados.get(c.R2_COM_TXT_IBAN__c)));
                                system.debug('****Añado a la temporal:'+ lpTemp);
                            }
                            else{
                                //no se ha usado color por lo que procesamos el siguiente
                                if(colores.size()>0){
                                    String color = colores.get(0);
                                    colores.remove(0);
                                    coloresAsignados.put(c.R2_COM_TXT_IBAN__c, color);
                                    lpTemp.add(new wrapPayment(c, color));
                                    system.debug('****Añado a la temporal2:'+ lpTemp);
                                    if(c.R2_COM_PKL_Status__c == 'Emitido'){
                                        lpTempEmitido.add(new wrapPayment(c, color));
                                    }
                                }
                            }                
                        }
                        if(c.R2_COM_PKL_Status__c == 'Emitido' || c.R2_COM_PKL_Status__c == 'Completado'){
                            pagosCompletados.add(c);
                        }
                    }
                    system.debug('****Antes dl if:'+lpTemp);
                    if(!lpTemp.isEmpty()){
                        //si no está vacia la añadimos a la lista final
                        compenEmitidoList.add(lpTemp);
                        system.debug('****Añado la lista:'+compenEmitidoList);
                    } 
                    if(!lpTempEmitido.isEmpty()){
                        compensacionesPendientes.add(lpTempEmitido);
                    }
                }
            }
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.iniciaValidados', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            
        }
    }
    
    //si elige cancelar el pago
    public PageReference cancelar(){    
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
            R2_Compensation__c pago = new R2_Compensation__c();
            //recuperamos los pagos y cancelamos los que esten marcados
            for(List<wrapPayment> cList : compenEmitidoList2){
                for(wrapPayment c: cList){
                    if(c.selected){
                        pago = c.pago;
                        pago.R2_COM_PKL_Status__c = 'Cancelado';  
                        pagos.add(pago); 
                    }
                }
            }    
            Database.SaveResult[] srList = Database.update(pagos, false);
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    System.debug('***Se actualizó correctamente: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());
                    }
                }
            }
            compensacionIni();
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.cancelar', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    
    public PageReference cerrarFormularioCuenta(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            compensacionIni();
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.cerrarFormularioCuenta', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    //si elige pasar los pagos a estado pendiente de emisión
    public PageReference pendiente(){   
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            List<R2_Compensation__c> pagos = new List<R2_Compensation__c>();
            R2_Compensation__c pago = new R2_Compensation__c();
            //recuperamos los pagos y ponemos en pendientes los que esten marcados
            for(List<wrapPayment> cList : compenEmitidoList2){
                for(wrapPayment c: cList){
                    if(c.selected){
                        if(c.pago.R2_COM_PKL_Status__c == 'Inicial')
                            pago = c.pago;
                        pago.R2_COM_PKL_Status__c = 'Pendiente de emisión';  
                        pagos.add(pago); 
                    }
                }
            }    
            Database.SaveResult[] srList = Database.update(pagos, false);
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    System.debug('***Se actualizó correctamente: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Ocurrió el siguiente error.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Campos afectados: ' + err.getFields());
                    }
                }
            }
            compensacionIni();
            return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.pendiente', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }
    
    
    
    public list<selectOption> getcompensacionesPending(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            
            list<selectOption> opciones = new list<selectOption>();
            
            return opciones;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.getcompensacionesPending', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
            return null;
        }
    }


   
    public void validarPago(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            System.debug('Se ha llamado a la validación del pago');
            errores.clear();
            System.debug(noValidado);
            List<Account> lstAcc = [SELECT id, FirstName, LastName FROM Account where id =: opUpdate.R2_OPY_LOO_CaseAccount__c LIMIT 1];
            if(!lstAcc.isEmpty()){
                System.debug(lstAcc[0].FirstName);
                PaymentValidationWebRequest wrapper = new PaymentValidationWebRequest();
                wrapper.customerName = lstAcc[0].FirstName;  // falta poner el nombre
                wrapper.financialInstitution = opUpdate.R2_OPY_TXT_Bank_Name__c;
                wrapper.countryCode = opUpdate.R2_OPY_TXT_Bank_Country__c;
                wrapper.bankKey = opUpdate.R2_OPY_TXT_Bank_Code__c + opUpdate.R2_OPY_TXT_Bank_Sucursal__c; //Falta por ver con que campo se mapea este, en el formulario solo acepta 4 caracteres
                wrapper.bankAccountNumber = opUpdate.R2_OPY_TXT_Bank_Account__c;
                wrapper.bankControlKey = opUpdate.R2_OPY_TXT_Control_Digit__c;
                wrapper.swift = opUpdate.R2_OPY_TXT_SWIFT__c;
                wrapper.iban = opUpdate.R2_OPY_TXT_IBAN__c;
                wrapper.postalCode = opUpdate.R2_OPY_TXT_Postal_Code__c;
                wrapper.street = opUpdate.R2_OPY_TXT_Address1__c;
                wrapper.city = opUpdate.R2_OPY_TXT_City__c;
                String wrp = JSON.serialize(wrapper);
                System.debug(wrp);

                resp = R2_CLS_PYT_Validate_Payment.validatePayment(wrp, 0);

                
                System.debug('Este es el response: '+ resp);
                if(resp.statusCode == 200){
                    if(resp.responseType == 'S'){
                        //Poner a true el checkbox
                        displayPopup = true;
                        resultado = 'Success';
                        errores.add('Payment order validated correctly');
                        noValidado = false;
                    }else{
                        System.debug('Pasa por aqui1');
                        displayPopup = true;
                        resultado = 'Error';
                        errores.add(resp.messageText);
                        //messageText = resp.messageText;
                        noValidado = true;
                    }
                }else{
                    displayPopup = true;
                    noValidado = true;
                    resultado = 'Error';
                    messageText = '';
                    System.debug(resp.errors.size());
                    for(Integer i = 0; i < resp.errors.size();i++){
                        System.debug(resp.errors[i].reason);
                        String aux = resp.errors[i].reason;
                        errores.add(aux);
                    }
                    System.debug(errores);
                }
            }else{
                displayPopup = true;
                resultado = 'Error';
                errores.add('The client does not exit');
            }
            
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.validarPago', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }

    public boolean displayPopUpCentroCuenta {get; set;}
    public boolean displayPopUpFormaPago {get; set;}
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    public void closePopupCentroCuenta() {        
        displayPopUpCentroCuenta = false;    
    }
    public void closePopupFormaPago() {
        System.debug('El pago va a ir por ' + labelPago);        
        displayPopUpFormaPago = false;    
    }     
    public void showPopupCentroCuenta() {   
        System.debug('Se va a abrir el pop up ' + displayPopUpCentroCuenta);     
        displayPopUpCentroCuenta = true;    
    }
    public void showPopupFormaPago() {   
        System.debug('Se va a abrir el pop up ' + displayPopUpCentroCuenta);     
        displayPopUpFormaPago = true;    
    }
    
    public class PaymentValidationWebRequest{
        public String customerName;
        public String financialInstitution;
        public String countryCode;
        public String bankKey;
        public String bankAccountNumber;
        public String bankControlKey;
        public String swift;
        public String iban;
        public String postalCode;
        public String street;
        public String city;

    }

    public class wrapPayment {
        public R2_Compensation__c pago {get; set;} //almacena el pago
        public Boolean selected {get; set;} //indicará si ha sido selecionado
        public Boolean editable {get; set;} //indicará si debe será sólo de lectura
        public String duplicado {get; set;} //indica si tiene posibles duplicados
        public String formato {get; set;} //nos indicará el estilo para este elemento en la VF
        
        public wrapPayment(R2_Compensation__c pago, String estilo) {
            this.pago = pago;
            selected = false;
            if(pago.R2_COM_PKL_Status__c == 'Emitido'){
                editable = true;
            }
            else{
                editable = false;
            }    
            formato = estilo;
            duplicado = '';
        }
    }
    
    
    public class wrapDuplicado{
        public R2_Compensation__c original {get; set;}
        public R2_Compensation__c duplicado {get; set;}
        public String estilo {get; set;}   
        
        public wrapDuplicado(R2_Compensation__c original, R2_Compensation__c duplicado, String estilo){
            this.original = original;
            this.duplicado = duplicado;
            this.estilo = estilo;
        }
        
        public wrapDuplicado(R2_Compensation__c original, R2_Compensation__c duplicado){
            this.original = original;
            this.duplicado = duplicado;
        }
    }

     public void habilitarPago(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            System.debug('^^^^: Se viene por aqui');
            System.debug(boolSepa);
            if(valueTipoPago == 'SEPA'){
                boolSepa = true;
                boolLatam = false;
                boolCheque = false;
                validado = true;
                // validado = false;
            }else if(valueTipoPago == 'LATAM'){
                boolLatam = true;
                boolCheque = false;
                boolSepa = false;
                validado = true;
                // validado = false;
            }else if(valueTipoPago == 'CHEQUE'){
                boolCheque = true;
                boolSepa = false;
                boolLatam = false;                
                validado = true;
            }else{
                boolCheque = false;
                boolSepa = false;
                boolLatam = false;
                validado = true;
            }
            System.debug(valueTipoPago);
            System.debug(boolSepa);
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.habilitarPago', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }  
    }

    public void cambioCliente(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            System.debug('Cambio de cliente; '+ opUpdate.R2_OPY_LOO_CaseAccount__c);
            
            //     System.debug('Cambio de cliente; '+ lstAcc);
            opUpdate.R2_OPY_TXT_NIF__c = null;
            opUpdate.R2_OPY_PKL_Document_Type__c = null;
            // opUpdate.R2_OPY_LOO_CaseAccount__c = null;
            opUpdate.R2_OPY_TXT_Address1__c= null;
            telefonoCliente = null;
            emailCliente = null;

            // casoPadreList = [select id, RecordTypeId, Account.Name,R2_CAS_EMA_Email__c,R2_CAS_TEL_contact_phone__c, AccountId,R2_CAS_PKL_Type_document__c,R2_CAS_TXT_Identification_number__c,R2_CAS_TXT_Direccion_Postal_del_Pasajero__c, R2_CAS_DIV_Sum_Compensation__c, R2_CAS_DIV_Compensation__c, ContactId, CaseNumber, Origin, Type, Subject, Description, R1_CAS_LOO_Flight__c, R1_CAS_PKL_Idioma__c, R1_CAS_PKL_Subtype__c, R2_CAS_PKL_Vip_Type__c, R1_CAS_TXT_Budgetary_center__c, R1_CAS_TXT_Charge_account__c  from Case where AccountId=:opUpdate.R2_OPY_LOO_CaseAccount__c LIMIT 1];
            //     System.debug('Campos del caso expediente: ' +casoPadreList);
            //     this.opUpdate.R2_OPY_TXT_NIF__c=casoPadreList[0].R2_CAS_TXT_Identification_number__c;
            //     this.opUpdate.R2_OPY_PKL_Document_Type__c = casoPadreList[0].R2_CAS_PKL_Type_document__c;
            opUpdate.R2_OPY_LOO_CaseAccount__c = opUpdate.R2_OPY_LOO_CaseAccount__c;
                // this.opUpdate.R2_OPY_TXT_Address1__c=casoPadreList[0].R2_CAS_TXT_Direccion_Postal_del_Pasajero__c;
                // this.telefonoCliente = casoPadreList[0].R2_CAS_TEL_contact_phone__c;
                // this.emailCliente = casoPadreList[0].R2_CAS_EMA_Email__c;
            // opUpdate.R2_OPY_TXT_NIF__c=lstAcc[0].R1_ACC_TXT_Identification_number__c;
            // opUpdate.R2_OPY_PKL_Document_Type__c = '06';
            // // this.opUpdate.R2_OPY_LOO_CaseAccount__c = lstAcc[0].Id;
            // opUpdate.R2_OPY_TXT_Address1__c='Dirección del cliente';
            // telefonoCliente = lstAcc[0].R1_ACC_TLF_Phone_Marketing__c;
            // emailCliente = lstAcc[0].PersonEmail;
            System.debug('Estos son los nuevos valores: ');
            System.debug(opUpdate.R2_OPY_PKL_Document_Type__c);
            System.debug(opUpdate.R2_OPY_TXT_NIF__c);
            System.debug(opUpdate.R2_OPY_PKL_Document_Type__c);
            System.debug(opUpdate.R2_OPY_LOO_CaseAccount__c);
            System.debug(emailCliente);

        
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.cambiarCliente', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }

    public void comprobacionCentroCuenta(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            //  public List<List<wrapPayment>> compenTramitar =  new List<List<wrapPayment>>();
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Error');
            ApexPages.addMessage(myMsg);
            msg = '';
            System.debug('Modo de pago: '+ modoDePago);
            // if(modoDePago = true){
            //          displayPopUpFormaPago = true;
            // }
            List<Case> lstCasosHijos = [SELECT Id, RecordTypeId, R1_CAS_PKL_Subtype__c,R2_CAS_PKL_Manage__c, Type, R2_CAS_FOR_carrier_code_oper__c FROM Case WHERE ParentId =: caso.Id];
            System.debug('Todos los campos del caso: '+lstCasosHijos[0].Type);
            Map<String, PagosSAP__c> csSAP = new Map<String, PagosSAP__c>();
            Map<String, pagosOracle__c> csOF = new Map<String, pagosOracle__c>();  
            Schema.DescribeFieldResult F = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
            List<Schema.PicklistEntry> P = F.getPicklistValues();
            Map<String, String> paises = new Map<String, String>();
            String paisKey;
            Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            for( Schema.PicklistEntry k : P)
            {
                // optionPais.add(new SelectOption(f.getValue(),f.getLabel()));
                paises.put(k.getValue(),k.getLabel());
            }
            String tipoPago;
            if(boolCheque==true){
                tipoPago = 'Cheque';
            }else if( boolSepa == true){
                tipoPago = 'Sepa';
            }else if(boolLatam == true){
                tipoPago ='Latam';
            }


            List<wrapPayment> listaTramitar = new List<wrapPayment>();
             for(Integer i = 0; i < compenEmitidoList2[0].size(); i++){
                 if(compenEmitidoList2[0][i].selected == true){
                     listaTramitar.add(compenEmitidoList2[0][i]);
                 }
             }
             System.debug('lista a tramitar: ' + listaTramitar);
             List<String> cuenta = new List<String>();
             List<String> centro = new List<String>(); 
             List<String> moneda = new List<String>();
             for(Integer i = 0; i< listaTramitar.size(); i++){
                 cuenta.add(listaTramitar[i].pago.R2_COM_TXT_Charge_account__c);
                 centro.add(listaTramitar[i].pago.R2_COM_TXT_Budgetary_center__c);
                 moneda.add(listaTramitar[i].pago.R2_COM_PKL_Currency_Claimed__c);
             }
            Boolean iguales;
            Integer count = 0;
            if(opUpdate.R2_OPY_TXT_Bank_Country__c != null){
                if(tipoPago!= null){
                    while(count < cuenta.size()){
                        if(cuenta[0]== cuenta[count]){
                            if(centro[0] == centro[count]){
                                if(moneda[0] ==moneda[count]){
                                    iguales =  true;
                                }else{
                                    msg = 'Las monedas no coinciden.';
                                    iguales = false;
                                    break;
                                }
                            }else{
                                msg = 'Los centros coinciden.';
                                iguales = false;
                                break;
                            }
                            count++;
                        }else{
                            msg = 'Las cuentas no coinciden.';
                            iguales = false;
                            break;
                        }
                    }
                }else{
                    msg = 'No se ha escogido un tipo de pago.';
                }
            }else{
                msg = 'No se ha escogido un país.';
            }
            System.debug('Esta el la label: ' + Label.R2_LBL_Escoger_Proceso_Pago_SAP_OF);

            if(iguales == true){
                if(Label.R2_LBL_Escoger_Proceso_Pago_SAP_OF == 'SAP'){
                    csSAP = PagosSAP__c.getall();
                    if(paises.containsKey(opUpdate.R2_OPY_TXT_Bank_Country__c)){
                        paisKey = paises.get(opUpdate.R2_OPY_TXT_Bank_Country__c);
                        
                        if(csSAP.containsKey(paisKey)){
                            PagosSAP__c csettingSAP = csSAP.get(paisKey);
                            if(csettingSAP.Codigo_Pais_SAP__c == opUpdate.R2_OPY_TXT_Bank_Country__c && csettingSAP.Tipo_SAP__c == tipoPago && csettingSAP.Moneda_SAP__c == moneda[0]){
                                System.debug('Ha encontrado el cs seting ' + csettingSAP);
                                //Aqui hay que llemar a las funciones de calcular centro y cuenta
                                labelPago ='SAP';
                            }else{
                                labelPago ='SDP';
                            }
                        }else{
                        labelPago = 'SDP';
                    }
                        
                    }else{
                            labelPago = 'SDP';
                    }
                }else if(Label.R2_LBL_Escoger_Proceso_Pago_SAP_OF == 'OF'){
                    System.debug('Vienes por oracle financial');
                    csOF = pagosOracle__c.getall();
                    if(paises.containsKey(opUpdate.R2_OPY_TXT_Bank_Country__c)){
                        System.debug('Viene a coger el pais');
                        paisKey = paises.get(opUpdate.R2_OPY_TXT_Bank_Country__c);
                        System.debug('Viene a coger el pais ' + paisKey);
                        if(csOF.containsKey(paisKey)){
                            pagosOracle__c csOracle = csOF.get(paisKey);
                            System.debug('Ha cogido el custom setting: ' + csOracle);
                            if(csOracle.codigoPais__c == opUpdate.R2_OPY_TXT_Bank_Country__c && csOracle.tipo__c == tipoPago && csOracle.moneda__c == moneda[0]){
                                //Aqui hay que llemar a las funciones de calcular centro y cuenta
                                System.debug('Todo ha ido bien y ha cogido bien el tipo de pago');
                                labelPago = 'OF';
                            }else{
                                labelPago = 'SDP';
                            }
                        }else{
                        labelPago = 'SDP';
                    }
                        
                    }else{
                        labelPago = 'SDP';
                    }
                    
                }
            }

           System.debug('El pago va a ir por: ' + labelPago);
        //     if(labelPago == 'OF' || labelPago == 'SDP' || labelPago == 'SAP'){
        //         noValidado = false;
        //     }

            List<Case> pagosSeleccionados = [SELECT Id, RecordTypeId, R1_CAS_PKL_Subtype__c,R2_CAS_PKL_Manage__c, Type, R2_CAS_FOR_carrier_code_oper__c FROM Case WHERE Id =: listaTramitar[0].pago.R2_COM_LOO_Case__c ];
            System.debug('Chequeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            System.debug('Este es el pago bueno con su caso '+  pagosSeleccionados);
            System.debug('Chequeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            System.debug(rTPasaje);
            String centroPagoBueno = calcularCentro(labelPago, pagosSeleccionados[0]);
            System.debug('Centro del pago: ' +centroPagoBueno);
            String cuentaPagoBueno = calcularCuenta(labelPago, pagosSeleccionados[0]);            
            System.debug('Cuenta del pago: ' +cuentaPagoBueno);
            List<R2_Compensation__c> lstPagos = new List<R2_Compensation__c>();
            
            if(centroPagoBueno != null && cuentaPagoBueno != null && iguales == true){
                for(Integer i = 0; i< listaTramitar.size(); i++){
                    listaTramitar[i].pago.R2_COM_TXT_Charge_account__c = cuentaPagoBueno;
                    listaTramitar[i].pago.R2_COM_TXT_Budgetary_center__c = centroPagoBueno;
                    lstPagos.add(listaTramitar[i].pago);
                    // if(tipoPago == 'Cheque'){
                    //     noValidado = false;
                    // }
                    noValidado = false;
                    displayPopUpFormaPago = true;
                    llamadaUpdate();
                }
                
                

            }else if(iguales == true){
                System.debug('Tiene que saltar el pop up ' + labelPago);
                displayPopUpCentroCuenta = true;
            }
            if(tipoPago == 'Sepa' || tipoPago == 'Latam'){
                validado = false;
            }
            System.debug('Lista de pagos a actualizar: ' +lstPagos);
            
            update lstPagos;
            
            
            
            
            // displayPopUpFormaPago = true;
            // System.debug('¿Son iguales? ' + paises);
            // System.debug('¿Son iguales? ' + iguales);
            // System.debug('Estos son los centro y cuentas a tramitar: '+  opUpdate.R2_OPY_TXT_Bank_Country__c);
            // System.debug('Estos son los centro y cuentas a tramitar: '+ centro);
            // system.debug('y este es el tipo de pago: ' + tipoPago);

            // System.debug('Iteraciones de la lista de listas: ' +compenEmitidoList2[][0]);
            // System.debug('Va a comprobar el centro y la cuenta');
            // System.debug('Lista de pagos: ' +compensaciones);
            //  System.debug('Lista de pagos: ' +compenEmitidoList2);
            }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('CompensationController.comprobarCentroCuenta', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Compensation__c');
        }
    }

    public void llamadaUpdate(){
        System.debug('Viene por la llamada update');
        formadePago = '';
        // modoDePago = true;
        if(labelPago == 'SDP'){
            formadePago = 'Seguimiento de pagos';
        }else if(labelPago == 'OF'){
            formadePago = 'Oracle Financial';
        }else{
            formadePago = 'SAP';
        }
        System.debug('Forma de pago: ' + labelPago);
        System.debug('Forma de pago: ' + formadePago);
        displayPopUpFormaPago = true;
        

    }

    public  void guardarCentroCuenta(){
        System.debug('Centro: ' + centroPopUp + '   ' + labelPago);
        System.debug('CUenta: ' + cuentaPopUp);

        List<Case> lstCasosHijos = [SELECT Id, RecordTypeId, R1_CAS_PKL_Subtype__c,R2_CAS_PKL_Manage__c, Type, R2_CAS_FOR_carrier_code_oper__c FROM Case WHERE ParentId =: caso.Id];
            System.debug('Todos los campos del caso: '+lstCasosHijos[0].Type);
            Map<String, PagosSAP__c> csSAP = new Map<String, PagosSAP__c>();
            Map<String, pagosOracle__c> csOF = new Map<String, pagosOracle__c>();  
            Schema.DescribeFieldResult F = R2_Payment_order__c.R2_OPY_TXT_Bank_Country__c.getDescribe();
            List<Schema.PicklistEntry> P = F.getPicklistValues();
            Map<String, String> paises = new Map<String, String>();
            String paisKey;
            // labelPago ='';
            String tipoPago;
            if(boolCheque==true){
                tipoPago = 'Cheque';
            }else if( boolSepa == true){
                tipoPago = 'Sepa';
            }else if(boolLatam == true){
                tipoPago ='Latam';
            }
            Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
            for( Schema.PicklistEntry k : P)
            {
                // optionPais.add(new SelectOption(f.getValue(),f.getLabel()));
                paises.put(k.getValue(),k.getLabel());
            }
            


            List<wrapPayment> listaTramitarCentroCuenta = new List<wrapPayment>();
             for(Integer i = 0; i < compenEmitidoList2[0].size(); i++){
                 if(compenEmitidoList2[0][i].selected == true){
                     listaTramitarCentroCuenta.add(compenEmitidoList2[0][i]);
                 }
             }
            //  System.debug('lista a tramitar: ' + listaTramitarCentroCuenta);
              List<R2_Compensation__c> lstPagosSinCentroCuenta = new List<R2_Compensation__c>();

            
            for(Integer i = 0; i< listaTramitarCentroCuenta.size(); i++){
                listaTramitarCentroCuenta[i].pago.R2_COM_TXT_Charge_account__c = cuentaPopUp;
                listaTramitarCentroCuenta[i].pago.R2_COM_TXT_Budgetary_center__c = centroPopUp;
                lstPagosSinCentroCuenta.add(listaTramitarCentroCuenta[i].pago);
            }
            

            System.debug('Lista de pagos a actualizar: ' +lstPagosSinCentroCuenta[0].R2_COM_TXT_Charge_account__c);
            update lstPagosSinCentroCuenta;
            // if(tipoPago == 'Cheque'){
                
            // }
            noValidado=false;
            
        formadePago = '';
        displayPopUpCentroCuenta = false;
        // modoDePago = true;
        if(labelPago == 'SDP'){
            formadePago = 'Seguimiento de pagos';
        }else if(labelPago == 'OF'){
            formadePago = 'Oracle Financial';
        }else{
            formadePago = 'SAP';
        }
        System.debug('Forma de pago: ' + labelPago);
        System.debug('Forma de pago: ' + formadePago);
        displayPopUpFormaPago = true;
        
        
    }

    public String calcularCentro(String labelPago, Case caso){
        String centroPago;
        Id rTEquipaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            System.debug('caso: ' +caso.RecordTypeId);
            system.debug('rtcaso' + rTPasaje);
            SYstem.debug('por donde va? ' + labelPago);
            SYstem.debug('por donde va? ' + caso.R1_CAS_PKL_Subtype__c);
        
        if(caso.RecordTypeId == rTEquipaje && (caso.R1_CAS_PKL_Subtype__c == 'Pago'
            || caso.R1_CAS_PKL_Subtype__c == 'No conforme con indemnización' 
            || caso.R1_CAS_PKL_Subtype__c == 'Condenas superiores')){
        if(labelPago == 'SAP'){
            centroPago = 'IBAOG0HQT3';
        }else if(labelPago == 'OF' || labelPago == 'SDP'){
            System.debug('VIene por aqui!!!!!!!!!!!!!!!');
            centroPago = 'PR013200'; 
        }
        }else if(caso.RecordTypeId == rTEquipaje && (caso.R1_CAS_PKL_Subtype__c == 'Gastos abogado cliente'
                || caso.R1_CAS_PKL_Subtype__c == 'Multas fuera de plazo_Embargo' 
                || caso.R1_CAS_PKL_Subtype__c == 'Intereses' || caso.R1_CAS_PKL_Subtype__c == 'Costas judiciales')){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBAPM0HQT2';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'CL051000';
                    }
        }else if((caso.RecordTypeId == rTPasaje && (caso.R1_CAS_PKL_Subtype__c == 'Pago (Nacionales, I2, YW)'
                || caso.R1_CAS_PKL_Subtype__c == 'Condenas superiores')) || ((caso.Type == 'Retraso'
                    || caso.Type == 'Cancelación' || caso.Type == 'Pérdida conexión') && caso.R2_CAS_PKL_Manage__c == 'Pago')
                    || (caso.Type == 'Cambio programación' && caso.R1_CAS_PKL_Subtype__c == 'Pago')){
                        if(labelPago == 'SAP'){
                        centroPago = 'IBAOG0HQT3';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        System.debug('Viene por po oracle porque es de condenas superioes del  centro');
                        centroPago = 'PR013200';
                    }
        }else if((caso.RecordTypeId == rTPasaje && (caso.R1_CAS_PKL_Subtype__c == 'Intereses'
                || caso.R1_CAS_PKL_Subtype__c == 'Multas fuera de plazo_Embargo'
                || caso.R1_CAS_PKL_Subtype__c == 'Costas judiciales')) || (caso.Type == 'Desvío Otro Aeropuerto'
                && caso.R2_CAS_PKL_Manage__c == 'Pago')){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBAPM0HQT2';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'CL051000';
                    }
        }else if(caso.RecordTypeId == rTPasaje && caso.R1_CAS_PKL_Subtype__c == 'Pago'
                && caso.Type == 'Denegación a embarque'){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBACR0HQT1';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'SL070000';
                    }
        }else if(caso.RecordTypeId == rTPasaje && caso.R1_CAS_PKL_Subtype__c == 'Pago'
                || caso.Type == 'Downgrade'){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBACI0HQT1';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'SL000100';
                    }
        }else if(caso.RecordTypeId == rTPasaje && caso.R1_CAS_PKL_Subtype__c == 'Pago'
                || caso.Type == 'Manchas_Daños'){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBAOIOHQTI';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'PR000100';
                    }
        }else if(caso.R2_CAS_FOR_carrier_code_oper__c == 'I0' && caso.Type != ''){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBAPM0HQTL';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'CL05100L';
                    }
        }else if((caso.R1_CAS_PKL_Subtype__c == '3e)bag delayed' || caso.R1_CAS_PKL_Subtype__c == '3f)bag damaged'
                || caso.R1_CAS_PKL_Subtype__c == '3g)pilferage' || caso.R1_CAS_PKL_Subtype__c == '3h)bagdelayed and damage'
                || caso.R1_CAS_PKL_Subtype__c == '3i)bag delay and pilfered' 
                || caso.R1_CAS_PKL_Subtype__c == '3j)bag delay,damage and pilfer' 
                || caso.R1_CAS_PKL_Subtype__c == '3p)carryon bag'
                || caso.R1_CAS_PKL_Subtype__c == '3q)lost permanently and mishandled baggage') 
                && caso.Type == '03-Baggage'){
                    if(labelPago == 'SAP'){
                        centroPago = 'IBAOG0HQT3';
                    }else if(labelPago == 'OF' || labelPago == 'SDP'){
                        centroPago = 'PR013200';
                    }
        }else{
            centroPago = null;
        }

    return centroPago;
    }

    public String calcularCuenta(String labelPago, Case caso){
        String cuentaPago;
        Id rTEquipaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
        Id rTPasaje = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pasaje').getRecordTypeId();
            System.debug('caso: ' +caso.RecordTypeId);
            system.debug('rtcaso' + rTPasaje);
            SYstem.debug('por donde va? ' + labelPago);
            SYstem.debug('por donde va? ' + caso.R1_CAS_PKL_Subtype__c);
        
        if((caso.RecordTypeId == rTEquipaje && (caso.R1_CAS_PKL_Subtype__c == 'Pago'
		|| caso.R1_CAS_PKL_Subtype__c == 'No conforme con indemnización'
		|| caso.R1_CAS_PKL_Subtype__c == 'Condenas superiores')) 
		|| (caso.RecordTypeId == rTPasaje && caso.Type == 'Gastos varios'
		&& caso.R1_CAS_PKL_Subtype__c == ' Condenas superiores') 
		|| (caso.RecordTypeId == rTPasaje && caso.Type == '03-Baggage'
		&& (caso.R1_CAS_PKL_Subtype__c == '3e)bag delayed' 
		|| caso.R1_CAS_PKL_Subtype__c == '3f)bag damaged'
		|| caso.R1_CAS_PKL_Subtype__c == '3g)pilferage'
		|| caso.R1_CAS_PKL_Subtype__c == '3h)bagdelayed and damage'
		|| caso.R1_CAS_PKL_Subtype__c == '3i)bag delay and pilfered'
		|| caso.R1_CAS_PKL_Subtype__c == '3j)bag delay,damage and pilfer'
		|| caso.R1_CAS_PKL_Subtype__c == '3q)lost permanently and mishandled baggage'))){
			if(labelPago == 'SAP'){
				cuentaPago = '2330910100';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
                System.debug('Viene a coger la cuenta de condenas superiores');
				cuentaPago = '65902003';
			}
}else if(caso.RecordTypeId == rTEquipaje && caso.R1_CAS_PKL_Subtype__c == 'Gastos abogado cliente'){
			if(labelPago == 'SAP'){
				cuentaPago = '2643000200';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '62301000';
			}
}else if((caso.RecordTypeId == rTEquipaje || caso.RecordTypeId == rTPasaje)
		&& (caso.R1_CAS_PKL_Subtype__c == 'Multas fuera de plazo_Embargo'
		|| caso.R1_CAS_PKL_Subtype__c == 'Intereses')
		|| caso.R1_CAS_PKL_Subtype__c == 'Costas judiciales'){
			if(labelPago == 'SAP'){
				cuentaPago = '2331700200';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '67803000';
			}
}else if(caso.RecordTypeId == rTPasaje && (((caso.Type == 'Retraso'
		|| caso.Type == 'Cancelación' || caso.Type == 'Pérdida conexión') 
		&& caso.R2_CAS_PKL_Manage__c == 'Pago' )|| (caso.Type == 'Cambio programación'
		&& caso.R1_CAS_PKL_Subtype__c == 'Pago'))){
			if(labelPago == 'SAP'){
				cuentaPago = '2330920500';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '65900004';
			}
}else if(caso.RecordTypeId == rTPasaje && caso.Type == 'Asistencia' 
		&& (caso.R1_CAS_PKL_Subtype__c == 'Pago (Nacionales, I2, YW)'
		|| caso.R1_CAS_PKL_Subtype__c == 'Pago (Resto)')){
			if(labelPago == 'SAP'){
				cuentaPago = '2330920100';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '62900005';
			}
}else if(caso.RecordTypeId == rTPasaje && caso.Type == 'Denegación a embarque'
		&& caso.R1_CAS_PKL_Subtype__c == 'Pago'){
			if(labelPago == 'SAP'){
				cuentaPago = '2330920200';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '65900000';
			}
}else if(caso.RecordTypeId == rTPasaje && caso.Type == 'Downgrade'
		&& caso.R1_CAS_PKL_Subtype__c == 'Pago'){
			if(labelPago == 'SAP'){
				cuentaPago = '2330930100';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '65900002';
			}
}else if(caso.RecordTypeId == rTPasaje && caso.Type == 'Desvío Otro Aeropuerto'
		&& caso.R2_CAS_PKL_Manage__c == 'Pago'
		&& (caso.R1_CAS_PKL_Subtype__c == 'Avería' || caso.R1_CAS_PKL_Subtype__c == 'Control aéreo'
		|| caso.R1_CAS_PKL_Subtype__c == 'Meteorología' 
		|| caso.R1_CAS_PKL_Subtype__c == 'Aeropuerto destino inoperativo')){
			if(labelPago == 'SAP'){
				cuentaPago = '2330930100';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '65909000';
			}
}else if(caso.RecordTypeId == rTPasaje && caso.Type == 'Manchas_Daños'
		&& caso.R1_CAS_PKL_Subtype__c == 'Pago'){
			if(labelPago == 'SAP'){
				cuentaPago = '5120002000';
			}else if(labelPago == 'OF' || labelPago == 'SDP'){
				cuentaPago = '44090002';
			}
}else{
	cuentaPago = null;
}

    return cuentaPago;
    }



    
     
}