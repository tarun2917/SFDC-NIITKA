/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Clase para la primera operacion de la web de sustitucion, buscamos el PIR que nos pasan en WT o en SF si ya
					lo teniamos insertado. Sacamos las maletas de ese PIR, en el caso que esa maleta ya tuviera Gift Card, la mostramos.

    History: 
     <Date>                     <Author>                         <Change Description>
    26/02/2018              Sara Torres Bermúdez                    Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/


@RestResource(urlMapping='/getInfoIncidendiaPIR/*')   
global with sharing class R2_CR_SW_getInfoIncidendiaPIR_WS {

    public class WPGift{
 		public String cardAmount; // valor de la maleta
        public String cardCurrency; // moneda
        public String cardClaim;  
        public String cardDate; // fecha de caducidad de la tarjeta
        public String cardUrl; // url de iberia en amazon
    }
    
    global class WPResponse{
        public String pirNumber;
        public String fechaInc;
        public List<WPBaggage> baggages;
        public String success;
        public String error;
        public String errorDesc;
    }

    public class WPBaggage{
        public String order;
        public String brand;
        public String color;
        public String tag;
        public String tipo;
        public String reqCode;
        public String requestId;
        public List<WPGift> giftCard;
    }
    @HttpPost
    global static WPResponse createCase(String pirNumber, String fechaInc, String pais, String numIberiaPlus) {
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            //{"pirNumber":"BCNIB71421", "fechaInc":"2018-01-03","pais":"Spain","numIberiaPlus":"21344"}
            String status;
            String error;
            String errorDes;
            String stationCode;
            String airlinecode;
            String referenceNumber;
            String agentId = 'AgenTest';
            String recordType = 'DAMAGED'; // DPR maletas dañadas!!
            List<R2_Work_Order__c> lstWOMaletas = new List<R2_Work_Order__c>();
            Integer val = 0; // 0 ok, 1 error maleta, 9 faltan campos obligatorios, 5 no es IB, 2 cuando falten campos obligatorios
            List<R2_Baggage__c> lstMaletas = new List<R2_Baggage__c>();
            Id idIncidencia;
            WPResponse wp = new WPResponse();
            List<WPBaggage> lstwrapperBagsinWO = new List<WPBaggage>();
            List<WPBaggage> lstwrapperBagconWO = new List<WPBaggage>();
    
            List<WPGift> lstwrapperGift = new List<WPGift>();
            if(pirNumber == '' || pirNumber == null || fechaInc == null || fechaInc == '' || pais == '' || pais == null){
                status = 'false';
                error = '001';
                errorDes = 'Mandatory data missing';
            }else{
                stationCode = pirNumber.subString(0,3);
                airlinecode = pirNumber.subString(3,5);
                system.debug('airlinecode ' + airlinecode);
                if(airlinecode != 'IB'){
                    val = 5;
                }   
                referenceNumber = pirNumber.subString(5);
                if(val == 0){
                        // busco en SF si no en WT si no esta en ninguno mando el error
                   system.debug('pirnumber' + pirNumber);
                    List<R1_Incident__c> lstinci = [SELECT id, R2_INC_FOR_PIR__c FROM R1_Incident__c WHERE R2_INC_FOR_PIR__c =: pirNumber LIMIT 1];
                    system.debug('incidencia en SF: ' + lstinci);
                    if(lstinci.isEmpty()){
                        //system.debug('Incidencia no esta en SF, buscamos en WT ');
                        idIncidencia = R1_CLS_Utilities.readRecord_WT(recordType, stationCode, airlinecode, referenceNumber, agentId, 2); //LLamada a la clase de WT pasandole como parametro el pir y el tipo
                        system.debug('la incidencia que nos devuelve WT es: ' + idIncidencia);
                        if(idIncidencia == null){
                            //Enviar el error por json 003-Pir no encontrado 
                            System.debug('003-Pir no encontrado');
                            val = 3;
                        }
                    }else{
                        //system.debug('hemos encontrado el SF la incidencia: ');
                        idIncidencia = lstinci[0].id;
                        //system.debug('en id de la incidencia en SF: ' + idIncidencia);
                        // actualizo con WT???
                    }
                    //System.debug('Ha funcionado todo y ha devuelto el id de la incidencia: '+ idIncidencia);
                    //List<R2_Baggage__c> listmaleta = [Select id, name, R2_BAG_MSDT_Incident__c, R2_BAG_NUM_order_bag__c FROM R2_Baggage__c where R2_BAG_MSDT_Incident__c =: idIncidencia];
                    //System.debug('Hay este numero de maletas: ' +listmaleta.size());
                    //system.debug(listmaleta);
                    if(idIncidencia != null ){
                        lstMaletas = [SELECT Id, Name, R2_BAG_TXT_order_bag__c, R2_BAG_PKL_Type__c, R2_BAG_DIV_Estimated_amount__c, R2_BAG_NUMA_Amazon_Request_Id__c, R2_BAG_MSDT_Incident__c, R2_BAG_TXT_Brand_Info__c, R2_BAG_PKL_Colour__c, R2_BAG_FOR_Type__c, R2_BAG_TXT_TagSequence__c FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c =: idIncidencia];
                        system.debug('lista de la maleta ' + lstMaletas);
                        if(!lstMaletas.isEmpty()){
                            //system.debug('la lista de maletas no es vacia');
                            for(Integer i = 0 ;i< lstMaletas.size() ; i++){
                                //system.debug('estoy dentro del for()');
                                lstMaletas[i].R2_BAG_TXT_order_bag__c = String.valueof(i+1);
                                //system.debug(lstMaletas[i].R2_BAG_TXT_order_bag__c);
                            } 
                            //system.debug('vamos a update' + lstMaletas);
                            update(lstMaletas);
                            //system.debug('fin a update');
                           
                
                        }else{
                            val = 9;
                        }
                        Set<String> setMaletas = new Set<String>();
                        for(R2_Baggage__c male: lstMaletas){
                            setMaletas.add(male.Name);
                        }
                        system.debug('set de maletas: ' + setMaletas);
                        
                        
                        //system.debug(lstMaletas);
                        List<Case> lstCases = [SELECT ID, R1_CAS_LOO_Incidences__c FROM Case WHERE R1_CAS_LOO_Incidences__c =: idIncidencia];
                        //System.debug('lista de casos hijos: '+ lstCases);
                
                        if(lstCases.size()!=0){
                            List<R2_Work_Order__c> lstWO = [SELECT Id,R2_WO_DATH_GiftCard_Expiracion__c, R2_WO_TXT_Bags__c, R2_WO_LOO_Case__c FROM R2_Work_Order__c WHERE R2_WO_LOO_Case__c =: lstCases[0].id];
                        }/*else{
                            val = 9;
                        }*/
                        
                        lstWOMaletas = [SELECT Id,R2_WO_DATH_GiftCard_Expiracion__c, R2_WO_NUM_Amount_tot__c, R2_WO_TXT_cod_amazon__c, R2_WO_TXT_Bags__c FROM R2_Work_Order__c WHERE R2_WO_TXT_Bags__c =: setMaletas];
                
                        R2_CLS_BaggageTriggerMethods.asignarImporteMaleta(lstMaletas);
                        //System.debug('maletas' + lstMaletas);
                    }
                }
                if(val == 9){
                    status = 'false';
                    error = '900';
                    // que el PIR no tenga maletas o que no tenga caso asociado
                    errorDes = 'error generico';
                }else if(val == 3){
                    status = 'false';
                    error = '003';
                    errorDes = 'PIR no encontrado';
                }else if(val == 5){
                    status = 'false';
                    error = '005';
                    errorDes = 'El PIR no pertenece a Iberia';
                }else{
                    status = 'true';
                    error = '000';
                }
                if(error == '000'){
                        //rellenamos el tercer WP
                        // hay que hacer un mapa con clave el nombre de la maleta y de valor todas las giftcard
                    //map<R2_Baggage__c,List<R2_Work_Order__c>> mapa = new map<R2_Baggage__c,List<R2_Work_Order__c>>();
                    
                    map<id, R2_Baggage__c > mapaMaletas = new map<id, R2_Baggage__c>();
                    map<id, List<R2_Work_Order__c>> mapaWO = new map<id, List<R2_Work_Order__c>>(); 
                    
                    for(R2_Baggage__c male: lstMaletas){
                        /*if(mapaMaletas.containsKey(male.id)){
                            mapaMaletas.get(male.id).add(male);
                        }else{
                            mapaMaletas.put(male.Id, male);
                        } */ 
                        mapaMaletas.put(male.Id, male);
                        for(R2_Work_Order__c wo: lstWOMaletas){
                            if(wo.R2_WO_TXT_Bags__c == male.Name){
                              if(mapaWO.containsKey(male.Id)){
                                    mapaWO.get(male.Id).add(wo);
                                }else{
                                    mapaWO.put(male.Id, new List<R2_Work_Order__c>{wo});
                                }  
                            }     
                        }
                    }
                   
                    system.debug('mapa de maletas: ' + mapaMaletas);
                    system.debug('mapa de WO ' + mapaWO);
                    if(!lstWOMaletas.isEmpty()){
                        for (id mapMal : mapaMaletas.keySet()){
                            WPBaggage wpBagsinWO = new WPBaggage();
                            wpBagsinWO.order = mapaMaletas.get(mapMal).R2_BAG_TXT_order_bag__c;
                            if(mapaMaletas.get(mapMal).R2_BAG_TXT_Brand_Info__c != null){
                                wpBagsinWO.brand = mapaMaletas.get(mapMal).R2_BAG_TXT_Brand_Info__c;
                            }
                            system.debug('wpBagsinWO.brand ' + wpBagsinWO.brand);
    
                            if(mapaMaletas.get(mapMal).R2_BAG_PKL_Colour__c != null){
                                //wpBag.color = lstMaletas[i].R2_BAG_PKL_Colour__c;
                                wpBagsinWO.color = R2_CR_SW_getInfoBaggage_WS.color(mapaMaletas.get(mapMal).R2_BAG_PKL_Colour__c);
                            }
                            system.debug('wpBagsinWO.color ' + wpBagsinWO.color);
    
                            wpBagsinWO.tag = mapaMaletas.get(mapMal).R2_BAG_TXT_TagSequence__c;
                            //wpBag.tipo = lstMaletas[i].R2_BAG_PKL_Type__c;
                            wpBagsinWO.tipo = R2_CR_SW_getInfoBaggage_WS.tipo(mapaMaletas.get(mapMal).R2_BAG_PKL_Type__c);
                            wpBagsinWO.reqCode = mapaMaletas.get(mapMal).Name;
                            WPGift wpgift = new WPGift();
                            //for (id mapwo : mapaWO.keySet()){
                            if (mapaWO.containsKey(mapMal)) {
                                lstwrapperGift = new List<WPGift>();
                                for(R2_Work_Order__c wo : mapaWO.get(mapMal)){
                                    system.debug('wo: ' + wo);
                                    system.debug('mapaMaletas.get(mapMal).Name: ' + mapaMaletas.get(mapMal).Name);
                                    system.debug('wo.R2_WO_TXT_Bags__c: ' + wo.R2_WO_TXT_Bags__c);
                                    if(mapaMaletas.get(mapMal).Name == wo.R2_WO_TXT_Bags__c){
                                        wpgift = new WPGift();
                                        system.debug('entro: ' );
                                        wpgift.cardAmount = String.Valueof(wo.R2_WO_NUM_Amount_tot__c);
                                        wpgift.cardCurrency = 'EUR';
                                        wpGift.cardClaim = wo.R2_WO_TXT_cod_amazon__c;
                                        wpGift.cardDate = String.Valueof(wo.R2_WO_DATH_GiftCard_Expiracion__c);
                                        wpgift.cardUrl = 'https://www.amazon.es/Iberia';
                                        lstwrapperGift.add(wpgift);
                                        system.debug('lstwrapperGift' + lstwrapperGift);
                                        
                                    }
                                    
                                }
                                //wpBagsinWO.giftCard = lstwrapperGift;
                                //system.debug('wpBagsinWO' + wpBagsinWO);
                                //lstwrapperBagsinWO.add(wpBagsinWO);
                                system.debug('lstwrapperBagsinWO ' + lstwrapperBagsinWO);
                            }else {
                                lstwrapperGift = new List<WPGift>();
                            }
                            wpBagsinWO.giftCard = lstwrapperGift;
                            system.debug('wpBagsinWO' + wpBagsinWO);
                            lstwrapperBagsinWO.add(wpBagsinWO);
                            wp.baggages = lstwrapperBagsinWO;
                        }
                    }else{
                        system.debug('La lista de WO esta vacia: ' + lstWOMaletas);
                        for(Integer i = 0; i<lstMaletas.size(); i++){
                            system.debug('lista de maletas: ' + lstMaletas);
                            WPBaggage wpBagsinWO = new WPBaggage();
                            WPGift wpgift = new WPGift();
                            
                            wpBagsinWO.order = lstMaletas[i].R2_BAG_TXT_order_bag__c;
                            if(lstMaletas[i].R2_BAG_TXT_Brand_Info__c != null){
                                wpBagsinWO.brand = lstMaletas[i].R2_BAG_TXT_Brand_Info__c;
                            }
                            if(lstMaletas[i].R2_BAG_PKL_Colour__c != null){
                                //wpBag.color = lstMaletas[i].R2_BAG_PKL_Colour__c;
                                wpBagsinWO.color = R2_CR_SW_getInfoBaggage_WS.color(lstMaletas[i].R2_BAG_PKL_Colour__c);
                            }
                            wpBagsinWO.tag = lstMaletas[i].R2_BAG_TXT_TagSequence__c;
                            //wpBag.tipo = lstMaletas[i].R2_BAG_PKL_Type__c;
                            wpBagsinWO.tipo = R2_CR_SW_getInfoBaggage_WS.tipo(lstMaletas[i].R2_BAG_PKL_Type__c);
                            wpBagsinWO.reqCode = lstMaletas[i].Name;
                            lstwrapperGift.add(wpgift);
                            lstwrapperBagsinWO.add(wpBagsinWO);
                        }
                        wp.baggages = lstwrapperBagsinWO;
    
                    }
                    
                    
                    // rellenamos el WP principal
                    system.debug('wrapper: ' + wp.baggages);
                    wp.pirNumber = pirNumber;
                    wp.fechaInc = fechaInc;
                }
            }
            wp.success = status;
            wp.error = error;
            wp.errorDesc = errorDes;
            return wp; 
            
        
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoIncidendiaPIR_WS.createCase()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
		}
    }   
 
}