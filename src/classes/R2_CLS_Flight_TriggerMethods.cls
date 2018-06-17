global with sharing class R2_CLS_Flight_TriggerMethods{
    

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno                        
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    07/08/2017                 Ismael Yubero Moreno    Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    

    public class WpListaPasajero{
        public String fullFlightNumber;
        public String flightDate;
        public String flightOrigin;
        public String transactionResult;
        public WpVuelo flight;
    }

    public class WpVuelo{
        public Integer totalPassengers;
        public WpPasajero [] passengers = new WpPasajero[]{};
    }

    public class WpPasajero{
        public String paxSequenceNumber;
        public String originCity;
        public String specialTreatment;
        public String passengerName;
        public String companyFf;
        public String tierFf;
        public String companyFr;
        public String tierFr;
        public String numFr;
        public String deniedBoardingIndicator;
        public String downgradeIndicator;
        public String misconnectionIndicator;
        public String customerCategory;
        public String employeeIndicator;
        public String flightClass;
        public String inboundConnectionIndicator;
        public String outboundConnectionIndicator;
        public String disembarkAvailabilityIndicator;
        public String waitingListIndicator;
        public String vipIndicator;
        public String upgradeIndicator;
        public String seatAvailabilityIndicator;
        public String deadHeadCrewIndicator;
        public String voluntarySeatIndicator;
        public String sectionId;
        public String pnr;
        public String contactId;
        public String boardingNumber;
        public String seatNumber;
        public String cabin;
        
    }
    
    
    public static String formatoFecha(Date fechaVuelo){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           

            String fecha;
            system.debug('!!! fecha: ' +  fechaVuelo);
            if(fechaVuelo.month()<10){
                system.debug('!!! mes if: ' +  fechaVuelo.month());
                fecha = '0'+String.valueOf(fechaVuelo.month());
            }else{
                fecha = String.valueOf(fechaVuelo.month());
            }
            if(fechaVuelo.day()<10){
                system.debug('!!! dia if: ' +  fechaVuelo.day());
                fecha+= '0'+ String.valueOf(fechaVuelo.day());
            }else{
                fecha+= String.valueOf(fechaVuelo.day());
            }
            
            fecha+= String.valueOf(fechaVuelo.year());
            
            return fecha;
        }catch(Exception exc){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_Flight_TriggerMethods__c.formatoFecha', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Flight__c');
                return null;

        }      
        
    }


public static List<R2_CKI_info__c> imprimirlista(List<R2_CKI_info__c> listaPas){
    System.debug(listaPas);
    return listaPas;
}

@future(callout=true)
    webservice static void listaPasajeros(String idVuelo){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:         

    OUT:           
    
    History:
    
    <Date>              <Author>                 <Description>
    11/08/2017          Ismael Yubero Moreno     Initial version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/   
           try{
                if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;           
                    Id k = Id.valueOf(idVuelo);
                    R1_Flight__c vuelo = [SELECT id, R1_FLG_TXT_Flight_number__c, R1_FLG_DAT_Flight_date_local__c,R1_FLG_TXT_Airport_depart__c FROM R1_Flight__c WHERE id=:k];                    
                    WpListaPasajero resp = getPassengerFromResiber(vuelo.R1_FLG_TXT_Flight_number__c,vuelo.R1_FLG_DAT_Flight_date_local__c, vuelo.R1_FLG_TXT_Airport_depart__c, 0);
                    System.debug('resp' + resp);
                    if(resp != null){
                        Integer numPas = resp.flight.totalPassengers;
                        List<R2_CKI_info__c> listPassengers =  new List<R2_CKI_info__c>();
                        Set<String> numFrs = new Set<String>();
                        for(Integer i = 0; i < numPas; i++){
                            numFrs.add(resp.flight.passengers[i].numFr);
                        }
                        System.debug('Este son los FF: ' + numFrs);
                        List<Account> lstAcc = [SELECT id, R1_ACC_TXT_Primary_FF_Card_CCPO__c FROM Account WHERE R1_ACC_TXT_Primary_FF_Card_CCPO__c IN :numFrs];
                        System.debug('Por que salen estos 4 :' +lstAcc);
                        Map<String,Account> mapAcc = new Map<String,Account>();
                        //mapAcc.put()
                        System.debug('MapACC'+  mapAcc);

                        for(Integer l = 0; l< lstAcc.size();l++){
                            mapAcc.put(lstAcc[l].R1_ACC_TXT_Primary_FF_Card_CCPO__c,lstAcc[l]);
                        }
                        System.debug(mapAcc.get(lstAcc[0].R1_ACC_TXT_Primary_FF_Card_CCPO__c));

                        // Cambiar el codigo para que no sea los dos igual dependiendo del FF
                        for(integer i = 0; i<numPas; i++){

                            R2_CKI_info__c pass = new R2_CKI_info__c();
                            pass.R2_CKI_LOO_Flight__c = vuelo.Id;
                            pass.R2_CKI_NUM_Pax_Number__c = integer.valueof(resp.flight.passengers[i].paxSequenceNumber);
                            pass.R2_CKI_TXT_Origin__c= resp.flight.passengers[i].originCity;                            
                            pass.R2_CKI_PKLM_Special__c =  resp.flight.passengers[i].specialTreatment;
                            pass.R2_CKI_TXT_CompanyFF__c= resp.flight.passengers[i].companyFf;
                            pass.R2_CKI_TXT_TierFF__c=resp.flight.passengers[i].tierFf;
                            //pass.         Preguntar a Virginia que campos es companyFr
                            //pass.         Preguntar a Virginia que campos es tierFr
                            //pass.R2_CKI_LOO_Account__r.R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c =  resp.flight.passengers[i].numFr;
                            pass.R2_CKI_CHK_CAP__c =  boolean.valueof(resp.flight.passengers[i].deniedBoardingIndicator);
                            pass.R2_CKI_CHK_DNG__c = boolean.valueof(resp.flight.passengers[i].downgradeIndicator);
                            pass.R2_CKI_CHK_XC__c =  boolean.valueof(resp.flight.passengers[i].misconnectionIndicator);
                            //pass.R2_CKI_FOR_Customer_category__c =  resp.flight.passengers[i].customerCategory;
                            pass.R2_CKI_TXT_ID__c =  resp.flight.passengers[i].employeeIndicator;
                            pass.R2_CKI_TXT_Flight_class__c=resp.flight.passengers[i].flightClass;
                            pass.R2_CKI_CHK_ICONN__c = boolean.valueof(resp.flight.passengers[i].inboundConnectionIndicator);
                            pass.R2_CKI_CHK_OCONN__c = boolean.valueof(resp.flight.passengers[i].outboundConnectionIndicator);
                            pass.R2_CKI_CHK_PAD__c =  boolean.valueof(resp.flight.passengers[i].disembarkAvailabilityIndicator); 
                            pass.R2_CKI_CHK_WL__c = boolean.valueof(resp.flight.passengers[i].waitingListIndicator);
                            pass.R2_CKI_CHK_VIP__c = boolean.valueof(resp.flight.passengers[i].vipIndicator);
                            pass.R2_CKI_CHK_UPG__c =  boolean.valueof(resp.flight.passengers[i].upgradeIndicator);
                            pass.R2_CKI_CHK_SA__c =  boolean.valueof(resp.flight.passengers[i].seatAvailabilityIndicator); 
                            pass.R2_CKI_CHK_DHC__c =  resp.flight.passengers[i].deadHeadCrewIndicator;
                            pass.R2_CKI_CHK_PCVP__c = boolean.valueof(resp.flight.passengers[i].voluntarySeatIndicator);
                            //pass.         Preguntar sectionId
                            pass.R2_CKI_TXT_PNR_Number__c =  resp.flight.passengers[i].pnr;
                            //pass.         Preguntar contactId
                            pass.R2_CKI_TXT_Boarding_number__c = resp.flight.passengers[i].boardingNumber;
                            pass.R2_CKI_TXT_Seat_number__c =  resp.flight.passengers[i].seatNumber;
                            pass.R2_CKI_TEX_Cabin_flight__c = resp.flight.passengers[i].cabin;
                            if(mapAcc.containsKey(resp.flight.passengers[i].numFr)){
                                Account newP = new Account();
                                newP = mapAcc.get(resp.flight.passengers[i].numFr);
                                pass.R2_CKI_LOO_Account__c = newP.Id;
                            }
                            listPassengers.add(pass);
                        }
                                
                        System.debug('Se va a insertar la lista de pasajeros');
                        insert listPassengers;

                    }

            }
            catch(Exception exc){
                R1_CLS_LogHelper.generateErrorLog('R2_CLS_Flight_TriggerMethods__c.listaPasajeros', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Flight__c');
            }
    }
    public static WpListaPasajero getPassengerFromResiber (String numeroVuelo, Date fechaVuelo, String aeropuerto, Integer intentos){
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    
    IN:       
    OUT:      

    History: 
    <Date>                     <Author>                <Change Description>
    10/08/2017                 Ismael Yubero Moreno    Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
            
            string wsMethod = 'PasajerosVuelo';

            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c){
                    return null;
            }
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token');
            if(token ==null){
                if(intentos<3){
                    intentos= intentos+1;
                    R1_CLS_SendCustomerMDM.login();
                    return getPassengerFromResiber(numeroVuelo,fechaVuelo,aeropuerto,intentos);
                }else{
                    return null;
                }
            }
            System.debug('Ha funcionado el login: '+ token);

            String fecha = formatoFecha(fechaVuelo);
            HttpRequest req = new HttpRequest();
            String endPoint = R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c  +numeroVuelo +'-'+fecha+'-'+aeropuerto+'/passengers';
            System.debug('EndPoint: ' +  endPoint);
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setEndpoint(endPoint);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(3700);
            
            Http http = new Http();
            HTTPResponse res;
            res = http.send(req);
            System.debug('Body: '+ res.getBody());
            System.debug('Status: '+ res.getStatusCode());
            if(res.getStatusCode()==200 || res.getStatusCode()==201 || res.getStatusCode()==202 || res.getStatusCode()==203 || res.getStatusCode() == 0){
                WpListaPasajero resp = (WpListaPasajero)JSON.deserialize(res.getBody(),WpListaPasajero.class);
                if(resp == null){
                    return null;
                }
                return resp;
            }else{
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                        R1_CLS_SendCustomerMDM.login();
                        return getPassengerFromResiber(numeroVuelo,fechaVuelo,aeropuerto,intentos);
                }else{
                    return null;
                }
            }

        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_Flight_TriggerMethods.getPassengerFromResiber()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Flight');
            return null;
        }
    }
}