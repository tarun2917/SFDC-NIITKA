/*---------------------------------------------------------------------------------------------------------------------
    Author:         Sara Torres Bermúdez
    Company:        Accenture
    Description:    Clase para la segunda operacion de la web de sustitucion. Nos pasan las maletas de una en una del PIR y buscamos su Gift Card,
					a traves de la integracion con Amazon. Tenemos la informacion del cliente que si no lo tenemos lo insertamos para poder enviar 
					un mail de recordatorio. Cada maleta puede tener mas de una Gift Card, una creada a traves de la integracion y otra por Call Center.

    History: 
     <Date>                     <Author>                         <Change Description>
    26/02/2018              Sara Torres Bermúdez                    Initial Version
    31/03/2018              Alberto Puerto Collado                  Added & replaced wrong fields 
    ----------------------------------------------------------------------------------------------------------------------*/

@RestResource(urlMapping='/getInfoBaggage/*')
global with sharing class R2_CR_SW_getInfoBaggage_WS {
    public class WPGift{
 		public String cardAmount; // valor de la maleta
        public String cardCurrency; // moneda
        public String cardClaim;  
        public String cardDate; // fecha de caducidad de la tarjeta
        public String cardUrl; // url de iberia en amazon
    }
    public class WPBaggage{
        public String order;
        public String brand;
        public String color;
        public String tag;
        public String tipo;
        public String reqCode; //nombre de la maleta
        public List<WPGift> giftCard; // informacion sobre la gift
        public String reqStatusCode; // campo en Siebel, para nosotros null
        public String reqStatusDesc; // campo en Siebel, para nosotros null
        public String requestId; // campo a la espera de saber lo que es.

    }
    global class WPResponse{
        public String pirNumber;
        public String fechaInc;
        public WPBaggage baggage;
        public String success;
        public String error;
        public String errorDesc;
    }
    //05/04/18 @Alberto.Puerto - CasoExpediente instead lstCasos
    //public static String validacion(List<R1_Incident__c> lstinci, List<Case> lstCasos, String tipo, String status, String error, String errorDes, String pirNumber, String fechaInc, String numIberiaPlus, String reminder, String genero,String nombre, String apell1, String apell2, String docty, String docnum, String email, String telfpais, String telfnum, String lengua, String reqcode){
    public static String validacion(List<R1_Incident__c> lstinci, String casoExpId, String tipo, String status, String error, String errorDes, String pirNumber, String fechaInc, String numIberiaPlus, String reminder, String genero,String nombre, String apell1, String apell2, String docty, String docnum, String email, String telfpais, String telfnum, String lengua, String reqcode){
         try{
             if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
             String err = '';
             if(pirNumber == '' || pirNumber == null || fechaInc == '' || fechaInc == null || reqcode == '' ||  reqcode == null || lengua == null || lengua == '' || email == null || email == '' || docnum == null || docnum == '' || docty == null || docty == '' || apell1 == null || apell1 == '' || nombre == null || nombre == '' || genero == null || genero == '' || reminder == null || reminder == '' ){         
                 system.debug('error 1');
                 err = '1';
             }
             if(tipo == 'noMaleta'){
                 system.debug('error 3');
                 err = '3';
             }
             /*if(!lstCasos.isEmpty()){
                 if(lstCasos[0].R2_CAS_CHK_EA_Locked__c == False){
                     lstCasos[0].R2_CAS_CHK_EA_Locked__c = True;
                     system.debug(lstCasos[0].R2_CAS_CHK_EA_Locked__c);
                     update (lstCasos[0]);
                 }
             }/*else{
                 err = '9';
             }*/

            //04/04/18 @Alberto.Puerto - Added error 9 if casoExp.R2_CAS_CHK_EA_Locked__c = true;
            //05/04/18 @Alberto.Puerto - CasoExpediente instead lstCasos
            //if(!lstCasos.isEmpty()){
            //    if(lstCasos[0].R2_CAS_CHK_EA_Locked__c == True){
            if(casoExpId != null){
                Case casoPadre = [SELECT id, R2_CAS_CHK_EA_Locked__c FROM Case WHERE id = :casoExpId];
                System.debug(':::casoExpediente ' + casoPadre);
                if(casoPadre != null){
                   if(casoPadre.R2_CAS_CHK_EA_Locked__c == True){
                     err = '4';
                        System.debug(':::CasoExpediente.R2_CAS_CHK_EA_Locked__c == TRUE - Bloqueado => error 4');
                    } 
                }    
            }   

             List<R2_Compensation__c> lstPagos = [SELECT id, R2_COM_LOO_Incidence__c, R2_COM_PKL_Status__c FROM R2_Compensation__c where R2_COM_LOO_Incidence__c =: lstinci[0].id LIMIT 1];
             system.debug(lstPagos);
             if(!lstPagos.isEmpty()){
                 if (lstPagos[0].R2_COM_PKL_Status__c == 'Rechazado' || lstPagos[0].R2_COM_PKL_Status__c == 'Cancelado'){
                     err = '4';
                 }
             }/*else{
                 err = '9';
             }*/
             return err;
         }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.validacion()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
             return null;
        } 
	}
    public static id actualizarCliente(String nombre, String genero, String apell1, String apell2, String docty, String docnum, String email, String telfpais,String telfnum, String numIberiaPlus, String lengua){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
          
            List<Account> clien = [SELECT R2_ACC_CHK_envio_mail_webSustitucion__c, R2_ACC_EMA_email_web_sustitucion__c, R1_ACC_PKL_Gender_description__c, FirstName, LastName, R1_ACC_TXT_Identification_number__c, R1_ACC_PKL_identification_Type__c, R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c, R1_ACC_TLF_Phone_Marketing__c, R1_ACC_PKL_Comunication_Language__c FROM Account WHERE R1_ACC_TXT_Identification_number__c =: docnum LIMIT 1];                                                                                      
            system.debug('lista de clientes: ' + clien);
            if (clien.isEmpty()){
                Account acc = new Account();
                //creamos la cuenta
                if (genero == 'Hombre' || genero == 'HOMBRE'){
                    acc.R1_ACC_PKL_Gender_description__c = 'M';
                }else if (genero == 'Mujer' || genero == 'MUJER'){
                    acc.R1_ACC_PKL_Gender_description__c = 'F';
                }
                acc.FirstName = nombre;
                acc.LastName = apell1;
                acc.R1_ACC_TXT_Identification_number__c = docnum;
                // validamos el tipo de documento de identidad
                if (docty == 'CIF'){
                    acc.R1_ACC_PKL_identification_Type__c = '01';
                } else if(docty == 'C. conducir Noruega'){
                    acc.R1_ACC_PKL_identification_Type__c = '03';
                } else if(docty == 'NIF'){
                    acc.R1_ACC_PKL_identification_Type__c = '04';
                } else if(docty == 'Tarjeta residente'){
                    acc.R1_ACC_PKL_identification_Type__c = '06';
                } else if(docty == 'Carnet diplomatico'){
                    acc.R1_ACC_PKL_identification_Type__c = '07';
                } else if(docty == 'Desconocido'){
                    acc.R1_ACC_PKL_identification_Type__c = '09';
                } else if(docty == 'CI'){
                    acc.R1_ACC_PKL_identification_Type__c = '12';
                } else if(docty == 'DNI AR'){
                    acc.R1_ACC_PKL_identification_Type__c = '13';     
                } else if(docty == '99Desconocido'){
                    acc.R1_ACC_PKL_identification_Type__c = '99';    
                } else if(docty == 'DNI (12 Digitos)'){
                    acc.R1_ACC_PKL_identification_Type__c = '10';
                } else if(docty == 'DNI'){
                    acc.R1_ACC_PKL_identification_Type__c = '02';
                }else{ // pasaporte
                    acc.R1_ACC_PKL_identification_Type__c = '05';
                }
                acc.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c = numIberiaPlus;
                acc.R1_ACC_TLF_Phone_Marketing__c = telfpais + telfnum;
                if (lengua == 'ES'){  //español
                    acc.R1_ACC_PKL_Comunication_Language__c = '4';
                } else if(lengua == 'IT'){ //italiano
                    acc.R1_ACC_PKL_Comunication_Language__c = '5';
                } else if(lengua == 'DE'){ //aleman
                    acc.R1_ACC_PKL_Comunication_Language__c = '2';
                } else if(lengua == 'FR'){ //frances
                    acc.R1_ACC_PKL_Comunication_Language__c = '3';
                } else if(lengua == 'RU'){ //ruso
                    acc.R1_ACC_PKL_Comunication_Language__c = '9';
                } else if(lengua == 'PO'){ //polaco
                    acc.R1_ACC_PKL_Comunication_Language__c = '8';
                } else if(lengua == 'PT'){ //portugues
                    acc.R1_ACC_PKL_Comunication_Language__c = '6';
                } else if(lengua == 'CT'){ //catalan
                    acc.R1_ACC_PKL_Comunication_Language__c = '7';
                }  else{
                    acc.R1_ACC_PKL_Comunication_Language__c = '1';
                }
                acc.R2_ACC_EMA_email_web_sustitucion__c = email;
                acc.R2_ACC_CHK_envio_mail_webSustitucion__c = True;
                insert (acc);
                return acc.id;
            }else{
                //update
                clien[0].R2_ACC_EMA_email_web_sustitucion__c = email;
                clien[0].R2_ACC_CHK_envio_mail_webSustitucion__c = True;
                update (clien);
                return clien[0].id;
            }
             return null;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.actualizarCliente()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }                                       
    }
    public static String color(String c){
         try{
            String color = '';
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
            if(c == 'BE'){
                color =  'BE- BEIGE/CREMA/MARFIL';
            }else if(c == 'BK'){
                color = 'BK- NEGRO';
            }else if(c == 'BN'){
                color = 'BN- MARRÓN/TOSTADO/BRONCE/COBRE/TOPO';
            }else if(c == 'BU'){
                color = 'BU- AZUL';
            }else if(c == 'GN'){
                color = 'GN- VERDE/OLIVA/JADE';
            }else if(c == 'GY'){
                color =  'GY- GRIS/ALUMINIO/PLATA';
            }else if(c == 'MC'){
                color = 'MC- 2 O MÁS COLORES SÓLIDOS EXCEPTUANDO LOS ADORNOS';
            }else if(c == 'PR'){
                color = 'PR- ESTAMPADA/DIBUJOS/FLORES/LUNARES/RAYAS/ESCOCESA/CUADROS/TAPICERÍA';
            }else if(c == 'PU'){
                color = 'PU - VIOLETA/PURPURA';
            }else if(c == 'RD'){
                color = 'RD- ROJO/CASTAÑO/PÚRPURA/ROSA/VIOLETA/LILA/MALVA/BURDEOS';
            }else if(c == 'WT'){
                color = 'WT- BLANCO/CLARO';
            }else if(c == 'YW'){
                color = 'YW- AMARILLO/NARANJA/DORADO';
            }else{
                color = '';
            }
            return color;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.color()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }   
        
    }
    public static String tipo(String t){
        try{
            String tipo = '';
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
             if(t == '01'){
                    tipo =  '01-MALETAS RÍGIDAS, MARCAS DELSEY, SAMSONITE (SILHOULETTE/OYSTER), Y METÁLICAS MARCA ZERO HALLIBURTON';                 
                 }else if(t == '02'){
                    tipo =  '02- EQUIPAJE DE MANO RÍGIDO CON ASA RETRÁCTIL. SE INCLUYEN BOLSAS CON SOPORTES DE RUEDAS'; 
                }else if(t == '03'){
                    tipo =  '03- ESTRUCTURA RÍGIDA, LATERALES DUROS O BLANDOS, PUEDE TENER ESQUINAS REFORZADAS (HARTMANN)'; 
                }else if(t == '05'){
                    tipo =  '05-ESTRUCTURA RÍGIDA, LATERALES BLANDOS Y EXTENSIBLE';                 
                }else if(t == '06'){
                    tipo =  '06-MALETINES DE MANO / PORTAFOLIOS';                 
                }else if(t == '07'){
                    tipo =  '07-MALETÍN DE PILOTO / CARTERA DE DOCUMENTOS';                 
                }else if(t == '08'){
                    tipo =  '08-MACUTO / BOLSO MILITAR';                 
                }else if(t == '09'){
                    tipo =  '09-BOLSA CAMPING, LAVANDERÍA, DE ROPA ETC.';                 
                }else if(t == '10'){
                    tipo =  '10-CAJAS DE CARTÓN, MADERA, CONTENEDORES DE METAL CON CONTENIDO VARIO (SI LAS CAJAS SOLO CONTIENEN UN OBJETO, USE CÓDIGOS 50-99)';                 
                }else if(t == '12'){
                    tipo =  '12-BAÚLES';                 
                }else if(t == '20'){
                    tipo =  '20-BOLSAS DE TRAJES, INCL BOLSAS DE TRAJES EN SUS CAJAS';                 
                }else if(t == '22'){
                    tipo =  '22-EQUIPAJE DE MANO, LATERAL BLANDO, CON ASA RETRÁCTIL. SE INCLUYEN BOLSAS CON SOPORTES DE RUEDAS';                 
                }else if(t == '22D'){
                    tipo =  '22D-EQUIPAJE DE MANO, LATERAL BLANDO Y DURO, CON ASA RETRÁCTIL. SE INCLUYEN BOLSAS CON SOPORTES DE RUEDAS';                 
                }else if(t == '22R'){
                    tipo =  '22R-EQUIPAJE DE MANO, LATERAL DURO, CON ASA RETRÁCTIL. SE INCLUYEN BOLSAS CON SOPORTES DE RUEDAS';                 
                }else if(t == '23'){
                    tipo =  '23-MALETA DE UN ASA Y APERTURA CON UNA O VARIAS CREMALLERAS';                 
                }else if(t == '25'){
                    tipo =  '25-BOLSA DE DEPORTE Y GIMNASIA, CUALQUIER TAMAÑO (PUEDE LLEVAR CORREA-ESPALDA)';                 
                }else if(t == '26'){
                    tipo =  '26-BOLSAS DE MANO CON CORREA DE ESPALDA (LA CORREA PUEDE IR QUITADA)';                 
                }else if(t == '27'){
                    tipo =  '27-BOLSAS ALTAS BLANDAS (EXTENSIBLES EN ALTURA Y A MENUDO CON RUEDAS)';                 
                }else if(t == '28'){
                    tipo =  '28-BOLSA GRANDE PLÁSTICA';                 
                }else if(t == '29'){
                    tipo =  '29-MOCHILAS Y MORRALES';                 
                }else if(t == '50'){
                    tipo =  '50-PEQUEÑA PAQUETERÍA EN PRIORIDAD DE SERVICIO';                 
                }else if(t == '51'){
                    tipo =  '51-SACA DE MENSAJERO';                 
                }else if(t == '52'){
                    tipo =  '52-MUESTRARIO, GENERALMENTE HECHO A MEDIDA';                 
                }else if(t == '53'){
                    tipo =  '53-CARPETA DE DIBUJO';                 
                }else if(t == '54'){
                    tipo =  '54-TUBO (QUE NO SEA DE EQUIPO DEPORTIVO)';                 
                }else if(t == '55'){
                    tipo =  '55-ARTÍCULOS DUTY FREE (NO DESCRITOS EN OTROS)';                                                
                }else if(t == '56'){
                    tipo =  '56-JAULA DE ANIMALES';                                                                
                }else if(t == '57'){
                    tipo =  '57-CAJA HERRAMIENTAS / APAREJOS';                                                                
                }else if(t == '58'){
                    tipo =  '58-NEVERAS DE HIELO, CONTAINER DE PLÁSTICO';                                                                
                }else if(t == '59'){
                    tipo =  '59-CAJA HERRAMIENTAS / APAREJOS';                                                
                }else if(t == '60'){
                    tipo =  '60-CAÑAS, ÚTILES DE PESCA (CON O SIN BOLSA)';                                
                }else if(t == '61'){
                    tipo =  '61-ARMAS DE FUEGO';                
                }else if(t == '62'){               
                    tipo =  '62-BOLSA Y/O PALOS DE GOLF- USE MARCA DE GOLF';                
                }else if(t == '63'){
                    tipo =  '63-BICICLETA';                
                }else if(t == '64'){
                    tipo =  '64-SACO DORMIR, COLCHONETA ENROLLABLE, TIENDA';                
                }else if(t == '65'){
                    tipo =  '65-TABLA SURF, WINDSURF';
                }else if(t == '66'){
                    tipo =  '66-ESQUÍES Y/O BASTONES (CON O SIN BOLSA) - ESPECIFIQUE MARCA';                              
                }else if(t == '67'){
                    tipo =  '67-TABLA ESQUÍ DE NIEVE, TRINEOS (CON SIN BOLSA) - ESPECIFIQUE MARCA DEL ARTICULO';                
                }else if(t == '68'){
                    tipo =  '68-BOTAS DE ESQUIAR Y/O BOLSA - ESPECIFIQUE MARCA DE BOTAS';
                }else if(t == '69'){
                    tipo =  '69-EQUIPO DEPORTIVO INDIVIDUAL NO DEFINIDO EN OTRA PARTE';                                                                                                                 
                }else if(t == '71'){
                    tipo =  '71-ASIENTO DE COCHE NIÑO / BEBÉ';                                                                                                 
                }else if(t == '72'){
                    tipo =  '72-EQUIPO DE NIÑO NO DEFINIDO COMO: PORTANIÑOS, CORRALITOS, CUNAS';                                                                                 
                }else if(t == '73'){
                    tipo =  '73-CARRITO BEBE GRAN TAMAÑO';                                                                 
                }else if(t == '74'){
                    tipo =  '74-CARRITO CON SOMBRILLA';                                                 
                }else if(t == '75'){
                    tipo =  '75-ELEMENTOS DEPORTIVOS CON RUEDAS';                                 
                }else if(t == '81'){
                    tipo =  '81-EQUIPO FOTOGRÁFICO / VIDEO / VISUAL';                                    
                }else if(t == '82'){
                    tipo =  '82-COMPUTADORES (PC) INCLUIDOS EQUIPOS PERIFÉRICOS, DISQUETERAS, MONITORES, TECLADOS, PC PORTÁTILES, IMPRESORAS, AGENDAS ELECTRÓNICAS';
                }else if(t == '83'){
                    tipo =  '83-ARTÍCULOS ELÉCTRICOS';                    
                }else if(t == '85'){
                    tipo =  '85-INSTRUMENTOS MUSICALES';    
                }else if(t == '89'){
                    tipo =  '89-SILLA PLEGABLE';                                
                }else if(t == '90'){
                    tipo =  '90-CARRITO DE EQUIPAJE';                
                }else if(t == '92'){
                    tipo =  '92-ARTÍCULOS RETIRADOS POR SEGURIDAD';
                }else if(t == '93'){
                    tipo = '93-BOLSA DE COMPRA (PAPEL / PAJA / PLÁSTICO / NYLON)';    
                }else if(t == '94'){
                    tipo = '94-SILLA DE RUEDAS MANUAL O MECÁNICA Y ACCESORIOS';
                }else if(t == '95'){
                    tipo = '95-DISPOSITIVOS ORTOPEDICOS';
                }else if(t == '96'){
                    tipo = '96-BOLSA CON ROPA DE CAMA';
                }else if(t == '97'){
                    tipo = '97-BOLSA/EQUIPO DE BUCEO';
                }else if(t == '98'){
                    tipo = '98-SOMBRILLA';
                }else if(t == '99'){
                    tipo = '99-ARTÍCULOS (QUE NO SEAN MALETAS) NO DEFINIDOS EN LA LISTA - DESCRIBIR EN OBSERVACIONES';
                }else{
                    tipo = '';
                }
            return tipo;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.tipo()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
        }   
    }
    public static String crearFecha(List<String> ExpirationDate){
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
            if (ExpirationDate[1] == 'Jan'){
                ExpirationDate[1] = '01';
            }else if(ExpirationDate[1] == 'Feb'){
                ExpirationDate[1] = '02';
            }else if(ExpirationDate[1] == 'Mar'){
                ExpirationDate[1] = '03';
            }else if(ExpirationDate[1] == 'Apr'){
                ExpirationDate[1] = '04';
            }else if(ExpirationDate[1] == 'May'){
                ExpirationDate[1] ='05';
            }else if(ExpirationDate[1] == 'Jun'){
                ExpirationDate[1] = '06';
            }else if(ExpirationDate[1] == 'Jul'){
                ExpirationDate[1] = '07';
            }else if(ExpirationDate[1] == 'Aug'){
                ExpirationDate[1] = '08';
            }else if(ExpirationDate[1] == 'Sep'){
                ExpirationDate[1] = '09';
            }else if(ExpirationDate[1] == 'Oct'){
                ExpirationDate[1] = '10';
            }else if(ExpirationDate[1] == 'Nov'){
                ExpirationDate[1] = '11';
            }else{
                ExpirationDate[1] = '12';
            }
            String fecha = ExpirationDate[5] + '-' + ExpirationDate[1] + '-' + ExpirationDate[2] + ' ' + ExpirationDate[3];
            return fecha;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.crearFecha()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
		}
    }
    public static void rellenarWO(String fechaValida, String cod_ama, String giftCodeId, R2_Work_Order__c workO,  R2_CLS_GiftCard.WPCreateGiftCardWeb_Response resp, List<R2_Baggage__c> lstMaletas, String pirNumber, String reqcode, String fechaInc){
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
        	//workO.R2_WO_NUMA_Amazon_Request_Id__c = resp.giftCard.crmCreationRequestId;
            workO.R2_WO_TXT_AmazonId__c = resp.giftCard.giftCodeId;
            workO.R2_WO_TXT_Bags__c = lstMaletas[0].Name;
            giftCodeId = workO.R2_WO_TXT_AmazonId__c;
            workO.R2_WO_TXT_cod_amazon__c = resp.giftCard.giftClaimCode;
            List<String> ExpirationDate = resp.giftCard.giftCodeExpirationDate.split(' ');
            fechaValida = crearFecha(ExpirationDate);
            workO.R2_WO_DATH_GiftCard_Expiracion__c = DateTime.valueOf(fechaValida);
            workO.R2_WO_PKL_status__c = resp.giftCard.cardInfo.cardStatus;
            workO.R2_WO_NUM_Amount_tot__c = Decimal.valueof(resp.giftCard.cardInfo.value.amount);
            workO.R2_WO_TXT_PIR__c = pirNumber;
            workO.R2_WO_TXT_Bags__c = reqcode;
            workO.R2_WO_TXT_OT__c = '==' + cod_ama + '//';
            workO.R2_WO_DAT_Date_Creation_PIR__c = Date.Valueof(fechaInc);
            workO.R2_WO_PKL_type__c = 'Amazon';
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.rellenarWO()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
		}
    }
    @HttpPost
    global static WPResponse createCase(String pirNumber, String fechaInc, String numIberiaPlus, String reminder, String genero, String nombre, String apell1, String apell2, String docty, String docnum, String email, String telfpais,String telfnum, String lengua, String reqcode) {
        try{
            //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}
                                            
            String tipo = '';
            String val = '';
            String fechaValida = '';
            String body;
            String status;
            String error;
            String errorDes;
            String giftCodeId;
            String cod_ama;
            String valor = '';
            String errStatusDesc = '';
            String errStatusCode = '';
            String errTimeOut;
            String errResp = '';
            Boolean insertarWO = False;
            WPResponse wp = new WPResponse();
            List<R1_Incident__c> lstinci = new List<R1_Incident__c>();
            List<Case> lstCasos = new List<Case>();
            if(pirNumber == '' || pirNumber == null || fechaInc == '' || fechaInc == null || reqcode == '' ||  reqcode == null || lengua == null || lengua == '' || email == null || email == '' || docnum == null || docnum == '' || docty == null || docty == '' || apell1 == null || apell1 == '' || nombre == null || nombre == '' || genero == null || genero == '' || reminder == null || reminder == '' ){
					status = 'false';
                    error = '001';
                    errorDes = 'Mandatory data missing';                
            }else{
                if(pirNumber != null && pirNumber != ''){
                    //21/marzo18 replaced R2_INC_TXT_II_Passenger_name__c by R2_INC_TXT_PIR_Name__c
                    lstinci = [SELECT id, R2_INC_TXT_PIR_Name__c, R2_INC_CHK_mail_web__c, R2_INC_FOR_PIR__c, R2_INC_EMA_email_web__c, R2_INC_LOO_Case__c FROM R1_Incident__c Where R2_INC_FOR_PIR__c = :pirNumber LIMIT 1];
                    //system.debug('la incidencia: ' + lstinci[0].id);
                    if(!lstinci.isEmpty()){
                        lstCasos = [SELECT id, AccountId, R2_CAS_TXT_webSustitucion__c, R2_CAS_LOO_PIR__c, ParentId, R2_CAS_CHK_EA_Locked__c, R1_CAS_FOR_Case_Number__c FROM Case Where R2_CAS_LOO_PIR__c =: lstinci[0].Id LIMIT 1];
                    }else{
                        tipo = 'noMaleta';
                    }
                }
                Date fechaIncDate = Date.valueOf(fechaInc);
                system.debug(reqcode);
                List<R2_Baggage__c> lstMaletas = new List<R2_Baggage__c>();
                if (reqcode != null && reqcode != ''){
                    lstMaletas = [SELECT Id, Name, R2_BAG_DIV_Estimated_amount__c, R2_BAG_TXT_order_bag__c, R2_BAG_NUMA_Amazon_Request_Id__c, R2_BAG_PKL_Colour__c, R2_BAG_MSDT_Incident__c, R2_BAG_TXT_Brand_Info__c, R2_BAG_FOR_Colour__c, R2_BAG_PKL_Type__c, R2_BAG_TXT_TagSequence__c FROM R2_Baggage__c WHERE Name = :reqcode LIMIT 1];              
                }
                List<R2_Work_Order__c> lstWo = [SELECT id,R2_WO_TXT_cod_amazon__c, R2_WO_TXT_Bags__c, R2_WO_TXT_AmazonId__c, R2_WO_TXT_PIR__c, R2_WO_DAT_Date_Creation_PIR__c, R2_WO_DATH_GiftCard_Expiracion__c FROM R2_Work_Order__c where R2_WO_TXT_Bags__c = :reqcode AND R2_WO_TXT_PIR__c = :pirNumber AND R2_WO_DAT_Date_Creation_PIR__c = :fechaIncDate ];

                //String order = '';
                system.debug('incidencia: ' + lstinci);
                system.debug('maleta: ' + lstMaletas);
                system.debug('workorder: ' + lstWo);
                R2_Work_Order__c workO = new R2_Work_Order__c();

                //05/04/18 @Alberto.Puerto - CasoExpediente instead lstCasos (param validation();)
                String casoExpId = null;
                if (!lstinci.isEmpty()){
                    if(!lstMaletas.isEmpty()){
                        system.debug('maletas ' + lstMaletas[0]);
                        if (lstMaletas[0].R2_BAG_DIV_Estimated_amount__c != null ){
                            valor = String.valueOf(lstMaletas[0].R2_BAG_DIV_Estimated_amount__c);
                        }else{
                            valor = R2_CLS_BaggageTriggerMethods.asignarImporteMaleta(lstMaletas);
                        }
                        String numAmazon = String.valueOf(lstMaletas[0].R2_BAG_NUMA_Amazon_Request_Id__c);
                        R2_CLS_GiftCard.WPCreateGiftCardWeb_Response resp = R2_CLS_GiftCard.CrearTarjetaResponseSinWO(numAmazon, valor, 0);
                        system.debug('resp en el POST ' + resp);
                        if (resp != null){
                            if (resp.status == 'SUCCESS'){
								cod_ama = resp.giftCard.giftClaimCode;
                                List<String> ExpirationDate = resp.giftCard.giftCodeExpirationDate.split(' ');
            					fechaValida = crearFecha(ExpirationDate);
                                system.debug('SUCCESS');
                                if(lstWo.isEmpty()){
                                    rellenarWO(fechaValida, cod_ama, giftCodeId, workO,  resp, lstMaletas, pirNumber, reqcode, fechaInc);
                                    insertarWO = True;
                                }else{
                                    for(Integer i = 0; i< lstwo.size(); i++){
                                        if(resp.giftCard.giftClaimCode != lstwo[i].R2_WO_TXT_cod_amazon__c){
                                            rellenarWO(fechaValida, cod_ama, giftCodeId, workO,  resp, lstMaletas, pirNumber, reqcode, fechaInc);
                                            insertarWO = True;
                                        }else{
                                            rellenarWO(fechaValida, cod_ama, giftCodeId, workO,  resp, lstMaletas, pirNumber, reqcode, fechaInc);
                                            insertarWO = False;
                                        }
                                    }
                                }
                                Id rtIdEqui = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
                                String idAcc = actualizarCliente(nombre,genero,apell1,apell2,docty,docnum,email,telfpais,telfnum,numIberiaPlus,lengua);
                                Case casohijo = new Case();
                                if(!lstCasos.isEmpty()){
                                    if(lstCasos[0].ParentId != null || lstCasos[0].ParentId != ''){
                                        lstCasos[0].AccountId = idAcc;
                                        workO.R2_WO_LOO_Case__c = lstCasos[0].id;
                                        lstCasos[0].R2_CAS_LOO_PIR__c = lstinci[0].id;
                                        //lstCasos[0].R2_CAS_CHK_EA_Locked__c = True; //04/04/18 @Alberto.Puerto commented
                                        workO.R2_WO_TXT_main_file__c = lstCasos[0].R2_CAS_TXT_Case_Number__c;
                                        lstCasos[0].R2_CAS_TXT_webSustitucion__c = 'Amazon';
                                        update(lstCasos[0]);    
                                        System.Debug(':::lstCasos[0] updateado' + lstCasos[0]);

                                        //05/04/18 @Alberto.Puerto - CasoExpediente instead lstCasos (param validation();)
                                        casoExpId = lstCasos[0].ParentId;
                                        System.Debug(':::casoExpId rellenado para enviar a validacion()' + casoExpId);
                                    }else{
                                        system.debug('El caso no tiene padre');
                                    }
                                }else{
                                    casohijo.AccountId = idAcc;
                                    casohijo.RecordTypeId = rtIdEqui;
                                    casohijo.R2_CAS_TXT_webSustitucion__c = 'Amazon';
                                    casohijo.Type = 'Deterioro';
                                    casohijo.R2_CAS_LOO_PIR__c = lstinci[0].id;
                                    //casohijo.R2_CAS_CHK_EA_Locked__c = True; //04/04/18 @Alberto.Puerto commented
                                    insert casohijo; 
                                    system.debug(':::casohijo INSERTADO: ' + casohijo);               
                                    lstCasos.add(casohijo);

                                    //21/marzo added Pir.R2_INC_LOO_Case__c update
                                    //workO.R2_WO_LOO_Case__c = casohijo.id; <- borrado
                                    lstinci[0].R2_INC_LOO_Case__c = casohijo.id;

                                    Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
                                    List<Case> lstCasoHijoReal = [SELECT Id, R2_CAS_TXT_Case_Number__c FROM Case 
                                                            WHERE ParentId =:casohijo.Id
                                                            //AND R2_CAS_TXT_webSustitucion__c ='Amazon'
                                                            //AND RecordTypeId =:rTEquip  //--> sólo un caso hijo por expediente de tipo equipaje
                                                            ];
                                    system.debug(':::lstCasoHijoReales: ' + lstCasoHijoReal);

                                    if(!lstCasoHijoReal.isEmpty()){
                                        workO.R2_WO_TXT_main_file__c = lstCasoHijoReal[0].R2_CAS_TXT_Case_Number__c;
                                        workO.R2_WO_LOO_Case__c = lstCasoHijoReal[0].Id;
                                        system.debug(':::añadido Id del caso a la WorkOrder ' + lstCasoHijoReal[0]);
                                    }else{
                                         system.debug(':::no se encontró el caso hijo, la WorkOrder sigue asociada al expediente ');
                                    }


                                    update lstinci[0];
                                   
                                    
                                }
                                //21Marzo18 la WorkOrder se relaciona con el caso hijo, no con el expediente
                                //Id rTEquip = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Equipaje').getRecordTypeId();
                                //List<Case> lstCasoHijoReal = [SELECT Id, R2_CAS_TXT_Case_Number__c FROM Case 
                                //                            WHERE ParentId =:workO.R2_WO_LOO_Case__c
                                //                            AND R2_CAS_TXT_webSustitucion__c ='Amazon'
                                //                            AND RecordTypeId =:rTEquip];
                                                             //necesito algo para identificar la maleta en caso 
                                //system.debug(':::lstCasoHijoReales: ' + lstCasoHijoReal);
                                //if(!lstCasoHijoReal.isEmpty()){
                                //    workO.R2_WO_TXT_main_file__c = lstCasoHijoReal[0].R2_CAS_TXT_Case_Number__c;
                                //    workO.R2_WO_LOO_Case__c = lstCasoHijoReal[0].Id;
                                //    system.debug(':::añadido Id del caso a la WorkOrder ' + lstCasoHijoReal[0]);
                                //}else{
                                //     system.debug(':::no se encontró el caso hijo, la WorkOrder sigue asociada al expediente ');
                                //}

                                workO.R2_WO_LOO_Client__c = idAcc;
                            
                            //04/04/18 @Alberto.Puerto cambiado para enviar el nombre del formulario y no del PIR en el mail
                                String nombreCompleto = '';
                                if(nombre != null && nombre != ''){
                                    nombreCompleto += nombre + ' ';
                                }
                                if(apell1 != null && apell1 != ''){
                                    nombreCompleto += apell1 + ' ';
                                }
                                if(apell2 != null && apell2 != ''){
                                    nombreCompleto += apell2;
                                }
                                nombreCompleto += '.';
                                R2_CR_CLS_envioEmailWebSustitucion.sendEmailWebSustitucion(email, pirNumber, fechaInc, lengua, lstCasos, lstinci, valor, cod_ama, fechaValida, nombreCompleto);
                            }else{
                                system.debug('No success' + resp.errors);
                                if(!resp.errors.isempty()){
                                    for(Integer j=0; j<resp.errors.size(); j++){
                                        if(resp.errors[j].code != null || resp.errors[j].reason != ''){
                                            errStatusDesc = resp.errors[j].code;
                                            errStatusCode = resp.errors[j].reason;
                                            errResp = '3';
                                        }
                                    }
                                }
                                system.debug('timeout ' + resp.timeout);
                                if(resp.timeout != null){
                                    errTimeOut = resp.timeout;
                                    errResp = '4';
                                }
                            }
                        }else{
                            system.debug('No devuelve nada Amazon ' + resp);
                        }
                        if(errResp != '4' && errResp != '3'){
                            if(insertarWO){
                                insert workO;
                                system.debug('::: workorder wo INSERTADO: ' + workO);
                            }
                        }
                    }else{
                        tipo = 'noMaleta';
                    }
                }else{
                    tipo = 'noMaleta';
                }
                if(errResp == '3'){
                    status = 'false';
                    error = '003';
                    errorDes = 'Transacción Incompleta. (Error al generar una de las tarjetas regalo solicitadas)';
                }else if(errResp == '4'){
                    status = 'false';
                    error = '004';
                    errorDes = 'Transacción Incompleta. (Al menos una de las tarjetas regalo solicitadas no ha obtenido respuesta)';
                }else{
                    //05/04/18 @Alberto.Puerto - CasoExpediente instead lstCasos
                    //val = validacion(lstinci,lstCasos,tipo,status,error,errorDes,pirNumber,fechaInc,numIberiaPlus,reminder,genero,nombre,apell1,apell2,docty,docnum,email,telfpais,telfnum,lengua,reqcode);
                    val = validacion(lstinci,casoExpId,tipo,status,error,errorDes,pirNumber,fechaInc,numIberiaPlus,reminder,genero,nombre,apell1,apell2,docty,docnum,email,telfpais,telfnum,lengua,reqcode);
                
                    if(val == '1'){
                        status = 'false';
                        error = '001';
                        errorDes = 'Mandatory data missing';
                    }else if(val == '9' || tipo == 'noMaleta'){
                        status = 'false';
                        error = '900';
                        errorDes = 'error generico';
                    }else{
                        status = 'true';
                        error = '000';
                    }
                }
                if(error == '000'){
                    wp.pirNumber = pirNumber;
                    wp.fechaInc = fechaInc;
                    String t = lstMaletas[0].R2_BAG_PKL_Type__c;
                    String c = lstMaletas[0].R2_BAG_PKL_Colour__c;
                   
                    WPBaggage wpBag = new WPBaggage();
                    List<WPGift> lstwpGift = new List<WPGift>();
                    //wpBag.order = order;
                    if(!lstMaletas.isEmpty()){
                        wpBag.brand = lstMaletas[0].R2_BAG_TXT_Brand_Info__c;
                        wpBag.tipo = tipo(t);
                        system.debug('order: ' + lstMaletas[0].R2_BAG_TXT_order_bag__c);
                        wpBag.order = lstMaletas[0].R2_BAG_TXT_order_bag__c;
                        wpBag.color = color(c);
                        wpBag.reqStatusCode = errStatusDesc;
                        wpBag.reqStatusDesc = errStatusCode;
                        wpBag.tag = lstMaletas[0].R2_BAG_TXT_TagSequence__c;
                        //wpBag.cardAmount = String.Valueof(lstMaletas[0].R2_BAG_DIV_Estimated_amount__c);
                        wpBag.reqcode = lstMaletas[0].Name;
                    }
                    //wpBag.cardClaim = '';
                    if(insertarWO){
                        lstWo.add(workO);
                    }
                    for(Integer i = 0; i< lstWo.size(); i++){
                        if(lstWo[i].R2_WO_TXT_cod_amazon__c != null){
                            WPGift wpGift = new WPGift();
                            wpGift.cardClaim = lstWo[i].R2_WO_TXT_cod_amazon__c;
                            //wpBag.requestId = lstWo[i].R2_WO_TXT_AmazonId__c;//RequestId;                              
                            wpGift.cardUrl = 'https://www.amazon.es/Iberia';
                            wpGift.cardDate = String.Valueof(lstWo[i].R2_WO_DATH_GiftCard_Expiracion__c);
                            wpGift.cardCurrency = 'EUR';
                            wpGift.cardAmount = String.Valueof(lstMaletas[0].R2_BAG_DIV_Estimated_amount__c);
                            system.debug('WP GIFT: ' + wpGift);
                            lstwpGift.add(wpGift);
                        }
                        
                    }
                    wp.baggage = wpBag;
                    wp.baggage.giftCard = lstwpGift;
                }
            }
            wp.success = status;
            wp.error = error;
            wp.errorDesc = errorDes;
    
            return wp;
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CR_SW_getInfoBaggage_WS.createCase()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
            return null;
		}
    }
}