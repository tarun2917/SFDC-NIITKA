/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    controladora de R2_BAG_VF_Bag_Calculator.page
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    06/09/2017             Alberto Puerto Collado                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/   
public with sharing class R2_BAG_CLS_Bag_Calculator_CTRL {
    //Tipos
    public enum enumTypes {
        DEMORA, 
        EXTRAVIO,
        DETERIORO,
        FALTACONTENIDO,
        DEMORAAVIOS
    }
    //Writable fields
    public static Boolean vip{get;set;}
    public static Boolean rebote{get;set;}
    //public Boolean equiEspecial{get;set;}
    public static Integer delayDays{get;set;}
    public static Integer paxAffect{get;set;}
    public static Integer bagFacturados{get;set;}
    public static Integer bagAfectados{get;set;}
    public static Decimal importeSolicitado{get;set;}
    public List<SelectOption> lstMonedas{get;set;} //revisar picklists y valores EUR, USD... -> rellenar por integración o custom setting, ya veremos más adelatnte
    public List<SelectOption> lstClase{get;set;}
    public static String comentarios{get;set;}
    public static Decimal importeFinal{get;set;} 

    //public static String tipo{get;set;}

    //Read only fields
    public static Decimal maximoSDR{get;set;} 
    public static Decimal maximoEUR{get;set;}
    public static Decimal solicitadoEUR{get;set;} 
    public static Decimal recomendado{get;set;} 
    public static Decimal efectAbonado{get;set;} 
    public static Decimal aviosAbonados{get;set;}
    public static Decimal aviosImporte{get;set;}
    public static Decimal ordenesCursadas{get;set;}
    public static Decimal formulaSDR{get;set;}
    public static Decimal formulaEUR{get;set;} 

    public static String monedaSeleccionada{get;set;}
    public static String vuelosVolados{get;set;}

    //avios
    public static Integer delayDaysAvios{get;set;}
    public static String comentariosAvios{get;set;}


    //rendered vf:
    public static Boolean disp_menu{get;set;}
    public static Boolean disp_form{get;set;}
    
    public static String stringAuxiliar{get;set;}

    //rebote, dias demora, bultos factu, bultos afect
    public Boolean bool_Days{get;set;}
    public Boolean bool_bF{get;set;}
    public Boolean bool_bA{get;set;}
    public Boolean bool_reb{get;set;}
    public Boolean bool_pas{get;set;}
    public Boolean bool_AviosTab{get;set;}
    public Boolean bool_AviosDisplayed{get;set;}
    public static String tipoSelected{get;set;}

    public String casoId{get;set;}
    //controlando si existe FF y botones de confirmación de pago
    public Boolean existFF{get;set;}
    public Boolean boolConfirmaPago{get;set;}
    public Boolean boolConfirmaPagoAvios{get;set;}
    //caso y account global para rellenar en querys de helpers si existen para el caso
    public Case casoQuery{get;set;}
    public Account accQuery{get;set;}

    //refresh especial para no perder focus
    public String myFocus{get;set;}

    


    public R2_BAG_CLS_Bag_Calculator_CTRL(ApexPages.StandardController stdController){
 //ApexPages.StandardController sc){ //ApexPages.StandardController stdController + stdController.getRecord() etc ver https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/apex_ApexPages_StandardController_methods.html   
        casoId = stdController.getId();
        System.debug('constructor-> '+casoId);
        //otra opción sin stdController
        //String casoId = Apexpages.currentPage().getParameters().get('id');  
        //System.debug('constructor-> '+casoId);


        disp_menu = true;
        disp_form = false;
        
        stringAuxiliar = '';

        bool_reb = true;
        bool_Days = true;
        bool_bA = true;
        bool_bF = true;
        bool_pas = true;
        bool_AviosTab = false;
        bool_AviosDisplayed = false;
        tipoSelected = '';
    
        vip = false;
        rebote = false;
        delayDays = 0;
        paxAffect = 0;
        bagFacturados = 0;
        bagAfectados = 0;
        importeSolicitado = 0;
        lstMonedas = null;
        /*
        SelectOption optionEUR = new SelectOption('1', 'EUR');
        SelectOption optionSDR = new SelectOption('2', 'SDR');
        lstMonedas.add(new SelectOption('eur', 'EUR'));
        lstMonedas.add(new SelectOption('sdr', 'SDR'));*/
        lstClase = null;
        
        comentarios = '';
        importeFinal = 0;

        aviosAbonados= 0;
        aviosImporte = 0;
        delayDaysAvios = -1; //control
        comentariosAvios = '';

        existFF = false;
        boolConfirmaPago = false;
        boolConfirmaPagoAvios = false;

/*
        maximoSDR = 0;
        maximoEUR = 0;
        solicitadoEUR = 0;
        recomendado = 0;
        efectAbonado = 0;
        ordenesCursadas = 0;
        formulaSDR = 0;
        formulaEUR = 0;
*/
        casoQuery = null;
        accQuery = null;

        helper_getCaseInfo();
        if(casoQuery != null){
            helper_getAccountInfo(casoQuery.AccountId);
        }
        System.debug('casoQuery ' + casoQuery);
        System.debug('accQuery ' + accQuery);
    }

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Método que realiza los cálculos
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    07/09/2017             Alberto Puerto Collado                   Initial Version
    02/02/2018             Alberto Puerto Collado                   Importe solicitado fixed (value 0 does not count)
    07/02/2018             Alberto Puerto Collado                   Created Custom Setting R2_ExchangeRate__c to manage it by Users
----------------------------------------------------------------------------------------------------------------------*/ 
    public static void calculaBags(String aux){
        try{
            //conversión manual sdr a euros
            //valor por defecto de prueba
            Double SDRtoEUR = 1.1906; //1 SDR = 1.1906 eur || 1 eur = 0.8399 SDR -> valor por defecto a cambiar por exchangeRate
            //Double SDRtoEUR = exchangeRate.R2_SDRtoEUR__c;

            R2_ExchangeRate__c exchangeRate = R2_ExchangeRate__c.getInstance('CurrentExchangeRate');
            if(exchangeRate != null){
                SDRtoEUR = exchangeRate.R2_SDRtoEUR__c;
                System.debug(':::SDRtoEUR en el custom setting R2_ExchangeRate__c: ' + SDRtoEUR);
            }

            //delete spaces + trim + upperCase
            aux = aux.trim();
            aux = aux.replaceAll('(\\s+)', ''); 
            aux = aux.toUpperCase();

            //control
            if(paxAffect != null || delayDays != null || bagAfectados != null || bagFacturados != null){
                    //bultos Afectados <= b facturados
                if(bagAfectados > bagFacturados){
                    bagAfectados = bagFacturados;
                }

                //tipos posibles euros pasados a sdr = resultado en SDR:
                if(aux == enumTypes.DEMORA.name()){ //estandar todo
                    if(vip == true && rebote == true){
                        maximoSDR = 1131 * paxAffect;
                        formulaSDR = 1131 * paxAffect; 
                    }else if(vip == true || rebote == true){
                        maximoSDR = 350 * paxAffect * 1/SDRtoEUR;
                        formulaSDR = 350 * paxAffect * 1/SDRtoEUR; 
                    }else{
                        maximoSDR = 350 * 1/SDRtoEUR;
                        formulaSDR = 50 * delayDays * 1/SDRtoEUR; 
                        if(formulaSDR > 350 * 1/SDRtoEUR){
                            formulaSDR = 350 * 1/SDRtoEUR;
                        }   
                    }   
                }else if(aux == enumTypes.EXTRAVIO.name()){
                    maximoSDR = 1131;
                    delayDays = 21; //denominador formula?
                    //valores mínimo por defecto, por lógica
                    if(bagFacturados == null || bagFacturados < 1){
                        bagFacturados = 1;  
                        bagAfectados = 1;
                    }

                    if(paxAffect < 1 || paxAffect  == null){
                        paxAffect = 1;
                    }
                    //cálculo
                    if(vip){//estandar
                        formulaSDR = paxAffect * bagAfectados * delayDays * 1/21 * 1131;
                        System.debug('Extravio: vip: formula -> '+ formulaSDR +' ->pax+bagA+delayD'+paxAffect+', '+ bagAfectados + ', '+ delayDays + ' RESULTADO:' + paxAffect * bagAfectados * delayDays); 
                    }else{
                        formulaSDR = paxAffect * bagAfectados * delayDays / bagFacturados * 1/21 * 1131; 
                        System.debug('Extravio: NOvip: formula -> '+ formulaSDR +' ->pax+bagA+delayD'+paxAffect+', '+ bagAfectados + ', '+ delayDays+ ', bagF '+ bagFacturados + ' RESULTADO:' + paxAffect * bagAfectados * delayDays / bagFacturados); 

                    }
                }else if(aux == enumTypes.DETERIORO.name()){
                    if(vip){//estandar
                        maximoSDR = 1131 * bagAfectados; 
                        formulaSDR = 1131 * bagAfectados; 
                    }else{
                        maximoSDR = 200 * bagAfectados * 1/SDRtoEUR;
                        formulaSDR = 200 * bagAfectados * 1/SDRtoEUR;  
                    }
                }else if(aux == enumTypes.FALTACONTENIDO.name()){
                    if(vip){
                        maximoSDR = 1131 * paxAffect;
                        formulaSDR = 1131 * paxAffect; //pir (num incidencia)
                    }else{//estandar
                        maximoSDR = 1131;
                        formulaSDR = 1131;  
                    }
                }else if(aux == enumTypes.DEMORAAVIOS.name()){
                    //falta buscar en lista de demora avios
                    if(vuelosVolados.equalsIgnoreCase('Business')){
                        if(delayDaysAvios > 1 && delayDaysAvios <= 7){
                            aviosImporte = 10050;
                        }else if(delayDaysAvios > 8){
                            aviosImporte = 21900;
                        } 
                    }else{
                        if(delayDaysAvios > 1 && delayDaysAvios <= 7){
                            aviosImporte = 27000;
                        }else if(delayDaysAvios > 8){
                            aviosImporte = 58500;
                        }
                    }
                }

                // descontando histórico pagos en efectivo
                if(efectAbonado != null){
                    formulaSDR-= efectAbonado;
                }

                

                if(maximoSDR > 0){
                    //conversiones provisionales para no avios
                maximoEUR = maximoSDR * SDRtoEUR;
                //solicitadoEUR = importeSolicitado * SDRtoEUR;
                formulaEUR = formulaSDR * SDRtoEUR;
                }

                
                if(monedaSeleccionada == 'EUR'){
                    solicitadoEUR = importeSolicitado;  
                }else if(monedaSeleccionada == 'SDR'){
                    solicitadoEUR = importeSolicitado * SDRtoEUR;
                }

                ////moneda solicitada //valor 0 añadido en importe solicitado para que no cuente
                //if(importeSolicitado <= formulaEUR && importeSolicitado > 0){ //antes formula
                //    importeFinal = solicitadoEUR;
                //}else{
                //    importeFinal = formulaEUR;
                //}
                //formulaSDR = recomendado;
                //recomendado = maximoEUR;
                

                //2 decimales
                if(importeFinal != null)
                    importeFinal = importeFinal.setScale(2);
                if(maximoSDR != null)
                    maximoSDR = maximoSDR.setScale(2);
                if(maximoEUR != null)   
                    maximoEUR = maximoEUR.setScale(2);
                if(importeSolicitado != null)   
                    importeSolicitado = importeSolicitado.setScale(2);
                if(solicitadoEUR != null)   
                    solicitadoEUR = solicitadoEUR.setScale(2);
                if(formulaEUR != null)  
                    formulaEUR = formulaEUR.setScale(2);
                if(formulaSDR != null) 
                    formulaSDR = formulaSDR.setScale(2);
                //recomendado ADDED 02/02/2018
                if(formulaEUR > maximoEUR){
                    recomendado = maximoEUR;
                }else{
                    recomendado = formulaEUR;
                }
                if(recomendado != null) 
                    recomendado = recomendado.setScale(2);
                if(aviosImporte != null)    
                    aviosImporte = aviosImporte.setScale(0);

                //moneda solicitada //valor 0 añadido en importe solicitado para que no cuente
                if(importeSolicitado <= formulaEUR && importeSolicitado > 0){ //antes formula
                    if(recomendado < solicitadoEUR){
                        importeFinal = recomendado;
                    }else{
                        importeFinal = solicitadoEUR;
                    }            
                }else{
                    if(recomendado < formulaEUR){
                        importeFinal = recomendado;
                    }else{
                        importeFinal = formulaEUR;
                    } 
                }
            }         
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_Bag_Calculator_CTRL.calculaBags', '', e.getmessage()+', '+e.getLineNumber(), 'R2_Compensation__c');
        }
    }

    /*
    public static void validaTotal(){
        //no excede total del maximo permitido
        if(importeFinal > maximoEUR)
            importeFinal = maximoEUR;


    }
    */

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:   Llama a asigna valores (calcula)
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    07/09/2017             Alberto Puerto Collado                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    public static void asignaValores(){
        System.debug('asignaV '+tipoSelected);
        calculaBags(tipoSelected);

    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Crea e inserta R2_Compensation__c - https://cs86.salesforce.com/01I7E0000005Uzx?setupid=CustomObjects
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    07/09/2017             Alberto Puerto Collado                   Initial Version
    07/02/2018             Alberto Puerto Collado                   fields added R2_COM_TXT_Passenger_Reason__c & R2_COM_TXT_Frecuent_Flyer__c
----------------------------------------------------------------------------------------------------------------------*/ 
    public void insertObjeto(){
        try{
            R2_Compensation__c comp = new R2_Compensation__c();
            //contenido editable;
            comp.R2_COM_CHK_VIP__c = vip;
            comp.R2_COM_CHK_Bounce__c = rebote;
            //comp.R2_COM_CHK_Special_Bag__c = equiEspecial;
            comp.R2_COM_NUM_Affected_Bags__c = bagAfectados;
            comp.R2_COM_NUM_Billed_Bags__c = bagFacturados;
            comp.R2_COM_DIV_Claimed_Amount__c = importeSolicitado;
            comp.R2_COM_DIV_Total_Amount__c = importeFinal;
            
            comp.R2_COM_NUM_Delay_Days__c = delayDays;
            comp.R2_COM_TXT_Comments__c = comentarios;
    
            //contenido calculado
            comp.R2_COM_DIV_Max_Allowed_SDR__c = maximoSDR;
            comp.R2_COM_DIV_Max_Allowed_EUR__c = maximoEUR;
            comp.R2_COM_DIV_Claimed_Amount_EUR__c = solicitadoEUR;
            comp.R2_COM_DIV_Recommended_Amount__c = recomendado;
            comp.R2_COM_DIV_Amount_Credited__c = efectAbonado;
            //comp.R2_COM_DIV_Avios_Credited__c = aviosAbonados;
            comp.R2_COM_NUM_Work_Order__c = ordenesCursadas;
            comp.R2_COM_DIV_Formula__c = formulaSDR;
            comp.R2_COM_DIV_Formula_EUR__c = formulaEUR;
            //comp.R2_COM_NUM_AVIOS_amount__c = aviosImporte;
            comp.R2_COM_PKL_Currency_Claimed__c = monedaSeleccionada;
            //comp.R2_COM_PKL_Flight_Type__c = vuelosVolados;

            //Lookup caso
            comp.R2_COM_LOO_Case__c = casoId;
            //Case caso =
            //helper_getCaseInfo(); -> en constructor 
            if(casoQuery != null){
                comp.R2_COM_TXT_Budgetary_center__c = casoQuery.R1_CAS_TXT_Budgetary_center__c; // R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c
                comp.R2_COM_LOO_Client__c  =  casoQuery.AccountId; //R2_COM_LOO_Case__r.AccountId
                comp.R2_COM_TXT_Charge_account__c = casoQuery.R1_CAS_TXT_Charge_account__c; //R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c, 
                comp.R2_COM_TXT_Passenger_Reason__c = casoQuery.Subject;
                //Account acc = 
                //helper_getAccountInfo(casoQuery.AccountId); -> en constructor 
                if(accQuery != null){
                    comp.R2_COM_TXT_Frecuent_Flyer__c = accQuery.R1_ACC_FOR_Primary_FF_Card_CCPO__c;
                }
            }        

            comp.RecordtypeId = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Indemnización/Compensación').getRecordTypeId();   

            System.debug('id caso objeto lookup-> '+casoId);
            System.debug('id comp lookup-> '+ comp.R2_COM_LOO_Client__c);
            System.debug('objeto ANTES insert-> '+comp);
            insert comp;
            System.debug('objeto DESPUÉS insert-> '+comp);
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_Bag_Calculator_CTRL.insertObjeto', '', e.getmessage()+', '+e.getLineNumber(), 'R2_Compensation__c');
        }
        
    }/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Crea e inserta R2_Compensation__c de avios 
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    18/09/2017             Alberto Puerto Collado                   Initial Version
    07/02/2018             Alberto Puerto Collado                   fields added R2_COM_TXT_Passenger_Reason__c & R2_COM_TXT_Frecuent_Flyer__c
    08/02/2018             Alberto Puerto Collado                   R2_COM_DIV_Total_Amount__c instead R2_COM_NUM_AVIOS_amount__c
----------------------------------------------------------------------------------------------------------------------*/ 
    public void insertObjetoAvios(){
        try{
            R2_Compensation__c comp = new R2_Compensation__c();
            
            comp.R2_COM_TXT_Comments__c = comentariosAvios;
            comp.R2_COM_NUM_Delay_Days__c = delayDaysAvios;
            comp.R2_COM_PKL_Flight_Type__c = vuelosVolados;
            comp.R2_COM_DIV_Avios_Credited__c = aviosAbonados;
            comp.R2_COM_DIV_Total_Amount__c = aviosImporte; //antes se utilizaba R2_COM_NUM_AVIOS_amount__c

            comp.R2_COM_LOO_Case__c = casoId;
            //Case caso = 
            //helper_getCaseInfo(); -> en constructor 
            if(casoQuery != null){
                comp.R2_COM_TXT_Budgetary_center__c = casoQuery.R1_CAS_TXT_Budgetary_center__c; // R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c
                comp.R2_COM_LOO_Client__c  =  casoQuery.AccountId; //R2_COM_LOO_Case__r.AccountId
                comp.R2_COM_TXT_Charge_account__c = casoQuery.R1_CAS_TXT_Charge_account__c; //R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c, 
                comp.R2_COM_TXT_Passenger_Reason__c = casoQuery.Subject;
                //FF (Iberia Plus) from Account
                //Account acc = 
                //helper_getAccountInfo(casoQuery.AccountId); -> en constructor 
                if(accQuery != null){
                    comp.R2_COM_TXT_Frecuent_Flyer__c = accQuery.R1_ACC_FOR_Primary_FF_Card_CCPO__c;
                } 
            }
                      

            comp.RecordtypeId = Schema.SObjectType.R2_Compensation__c.getRecordTypeInfosByName().get('Avios').getRecordTypeId();

            insert comp;
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_Bag_Calculator_CTRL.insertObjetoAvios', '', e.getmessage()+', '+e.getLineNumber(), 'R2_Compensation__c');
        }
        
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Query to get data from case (using casoId from stdcontroller)

    IN:             
    OUT:            casoQuery = Object Case from query

    History: 
     <Date>                     <Author>                         <Change Description>
    05/10/2017             Alberto Puerto Collado                   Initial Version
    07/02/2018             Alberto Puerto Collado                   Subject field added to query
----------------------------------------------------------------------------------------------------------------------*/ 
    public void helper_getCaseInfo(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug('helper_getCaseInfo-> '+casoId);
            List<Case> casos = [SELECT id, R1_CAS_TXT_Budgetary_center__c, AccountId, R1_CAS_TXT_Charge_account__c, Subject
                        FROM Case WHERE id = :casoId];
            
            if(!casos.isEmpty()){
                casoQuery = casos[0];
            }
            
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_Bag_Calculator_CTRL.helper_getCaseInfo', 'lista de casos vacía', e.getmessage()+', '+e.getLineNumber(), 'R2_Compensation__c');
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Query to get data from Account (using casoId from stdcontroller) 
                    AND fulfill boolean existFF

    IN:             String/ID idAccount from helper_getCaseInfo
    OUT:            accQuery = Object Account from query

    History: 
     <Date>                     <Author>                         <Change Description>
    07/02/2018             Alberto Puerto Collado                   Initial Version
    16/02/2018             Alberto Puerto Collado                   Added existFF param 
----------------------------------------------------------------------------------------------------------------------*/ 
    public void helper_getAccountInfo(String idAccount){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

            System.debug('helper_getAccountInfo-> '+idAccount);
            List<Account> accounts = [SELECT id, R1_ACC_FOR_Primary_FF_Card_CCPO__c
                        FROM Account WHERE id = :idAccount];
            
            if(idAccount != null || idAccount != '' && !accounts.isEmpty()){
                String accFF = '';
                if(accounts[0].R1_ACC_FOR_Primary_FF_Card_CCPO__c != null){
                    accFF = accounts[0].R1_ACC_FOR_Primary_FF_Card_CCPO__c;
                }
                
                //if(accounts[0].R1_ACC_FOR_Primary_FF_Card_CCPO__c != null || accounts[0].R1_ACC_FOR_Primary_FF_Card_CCPO__c != ''){
                if(!String.isBlank(accFF)){
                    existFF = true;
                }else{
                    existFF = false;
                }
                // R1_ACC_FOR_Primary_FF_Card_CCPO__c -> Fórmula
                // R1_ACC_TXT_Primary_FF_Card_CCPO__c -> FF sin IB
                // R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c -> FF completo con IB
                if(!accounts.isEmpty()){
                    accQuery = accounts[0];
                }
            }      
            
            
            
        }catch(Exception e){
            R1_CLS_LogHelper.generateErrorLog('R2_BAG_CLS_Bag_Calculator_CTRL.helper_getAccountInfo', 'lista de account vacía', e.getmessage()+', '+e.getLineNumber(), 'R2_Compensation__c');
        }
    }  

    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    llamada a futura INTEGRACIÓN que tenga los cambios de moneda actualizados
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    07/09/2017             Alberto Puerto Collado                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    public Integer currencyConverter(Integer cantidad, String monedaOrig, String monedaDest){       
        Integer convertido;

        return convertido;
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Cambia variables para display o no en vf
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/09/2017             Alberto Puerto Collado                   Initial Version
----------------------------------------------------------------------------------------------------------------------*/ 
    public void changeBooleans(){
        disp_menu = false;
        disp_form = true;
        /*
demora
    //display 8 - todo - ok
deterioro 
    //display 5 -> oculta (3) rebote, pasajeros, dias demora
extravio
    //display 6 -> oculta (2) rebote, dias demora
faltaConten
    //display 4 -> oculta (4) rebote, dias demora, bultos factu, bultos afect
*/
        if(stringAuxiliar == 'Demora'){
            tipoSelected = 'DEMORA';
            bool_AviosTab = true;
        }else if(stringAuxiliar == 'Deterioro'){
            tipoSelected = 'DETERIORO';
            bool_reb = false;
            bool_Days = false;
            bool_pas = false;
        }else if(stringAuxiliar == 'Extravío'){
            tipoSelected = 'EXTRAVIO';
            bool_reb = false;
            bool_Days = false;
        }else if(stringAuxiliar == 'FaltaContenido'){
            tipoSelected = 'FALTA CONTENIDO';
            bool_reb = false;
            bool_Days = false;
            bool_bA = false;
            bool_bF = false;
            bool_AviosTab = false;
        }else if(stringAuxiliar == 'DisplayAvios'){
            tipoSelected = 'DEMORAAVIOS';
            bool_AviosDisplayed = true;
            bool_AviosTab = false;
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolConfirmaPagoAvios: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    16/02/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolConfirmaPagoAvios(){

        if(boolConfirmaPagoAvios){
            boolConfirmaPagoAvios = false;
            System.debug('switchBoolConfirmaPagoAvios = true cambiado a ' + boolConfirmaPagoAvios);
        }else{
            boolConfirmaPagoAvios = true;
            System.debug('switchBoolConfirmaPagoAvios = false cambiado a ' + boolConfirmaPagoAvios);
        }
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    switchBoolConfirmaPagoComp: display update mode or disable it
    IN:
    OUT:

    History:
     <Date>                     <Author>                         <Change Description>
    16/02/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
    public void switchBoolConfirmaPagoComp(){

        if(boolConfirmaPago){
            boolConfirmaPago = false;
            System.debug('switchBoolConfirmaPagoComp = true cambiado a ' + boolConfirmaPago);
        }else{
            boolConfirmaPago = true;
            System.debug('switchBoolConfirmaPagoComp = false cambiado a ' + boolConfirmaPago);
        }
    }
}
/*
query temporal de seguimiento:

select id, Name,R2_COM_DIV_Total_Amount__c, R2_COM_TXT_Comments__c, R2_COM_PKL_Flight_Type__c, R2_COM_PKL_Currency_Claimed__c, R2_COM_LOO_Case__c, CreatedBy.Name, R2_COM_TXT_Budgetary_center__c, R2_COM_LOO_Case__r.R1_CAS_TXT_Budgetary_center__c, R2_COM_TXT_Charge_account__c, R2_COM_LOO_Case__r.R1_CAS_TXT_Charge_account__c, R2_COM_LOO_Account__c, R2_COM_LOO_Case__r.AccountId,  CreatedDate from R2_Compensation__c order by CreatedDate desc

*/