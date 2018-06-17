global class R2_CLS_RetrieveAccountPastFlights {
	public class RequestWRP{
		public String goldenRecordID='';
	}
	public class ResponseWRP{
		public List<VueloWRP> flights;
	}
	public class VueloWRP{
		public String marketingFlight;
		public String operatingFlight;
		public Date flightDate;
		public String scheduledDepartureTime;
		public String actualDepartureTime;
		public String scheduledArrivalTime;
		public String actualArrivalTime;
		public String origin;
		public String destination;
		public String flightClass;
		public string fareBasis;
		public string seatRow;
		public string seatLetter;
		public string pnr;
		public string ticketNumber;
		public string staffIndicator;
		public string misconnectionIndicator;
		public string unreservedIndicator;
		public string upgradeDowngradeIndicator;
		public string volUpgradeDowngradeIndicator;
		public String deniedBoardReason;
		public String passengerID;
		public String compensation;
		public String padindicator;
	}
	public static void savePastFlights(String id){
		try{
		List<Account> lstAcc = [SELECT R1_ACC_TXT_Id_Golden_record__c from Account where id = :id LIMIT 1];
		if(!lstAcc.isEmpty()){
			ResponseWRP respWrp = retrievePasFlights(lstAcc[0].R1_ACC_TXT_Id_Golden_record__c,0);

		}
		}catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
        } 
	}
	webservice static string getPastFlights(String id){
		try{
		List<Account> lstAcc = [SELECT R1_ACC_TXT_Id_Golden_record__c from Account where id = :id LIMIT 1];
		if(!lstAcc.isEmpty()){
			ResponseWRP respWrp = retrievePasFlights(lstAcc[0].R1_ACC_TXT_Id_Golden_record__c,0);
			String vuelos = '';
			for(VueloWRP vuelo : respWrp.flights){
				vuelos+='--------------------\n';
				vuelos+= 'Vuelo de Marketing: '+vuelo.marketingFlight+'\n';
				vuelos+= 'Vuelo Operacional: '+vuelo.operatingFlight+'\n';
				vuelos+= 'Fecha de Vuelo: '+vuelo.flightDate+'\n';
				vuelos+= 'Fecha Esperada de Salida: '+vuelo.scheduledDepartureTime+'\n';
				vuelos+= 'Fecha Real de Salida: '+vuelo.actualDepartureTime+'\n';
				vuelos+= 'Fecha Esperada de Llegada: '+vuelo.scheduledArrivalTime+'\n';
				vuelos+= 'Fecha Real de Llegada: '+vuelo.actualArrivalTime+'\n';
				vuelos+= 'Origen: '+vuelo.origin+'\n';
				vuelos+= 'Destino: '+vuelo.destination+'\n';
				vuelos+= 'Clase de Vuelo: '+vuelo.flightClass+'\n';
				vuelos+= 'Base de Tarifa: '+vuelo.fareBasis+'\n';
				vuelos+= 'Fila de Asiento: '+vuelo.seatRow+'\n';
				vuelos+= 'Letra de Asiento: '+vuelo.seatLetter+'\n';
				vuelos+= 'PNR: '+vuelo.pnr+'\n';
				vuelos+= 'Número de Ticket: '+vuelo.ticketNumber+'\n';
				vuelos+= 'Indicador de Personal: '+vuelo.staffIndicator+'\n';
				vuelos+= 'Indicador de Falta de Conexión: '+vuelo.misconnectionIndicator+'\n';
				vuelos+= 'Indicador Sin Reserva: '+vuelo.unreservedIndicator+'\n';
				vuelos+= 'Indicador de Upgrade/Downgrade: '+vuelo.upgradeDowngradeIndicator+'\n';
				vuelos+= 'Indicador de VolUpgrade/Downgrade: '+vuelo.volUpgradeDowngradeIndicator+'\n';
				vuelos+= 'Motivo de Denegación de Embarque: '+vuelo.deniedBoardReason+'\n';
				vuelos+= 'ID de Pasajero: '+vuelo.passengerID+'\n';
				vuelos+= 'Compensación: '+vuelo.compensation+'\n';
				vuelos+= 'Indicador PAD: '+vuelo.padindicator+'\n';
			}
			vuelos+='\n\n';
			System.debug(vuelos);
			return vuelos;
		}
		else{
			return '';
		}
		}catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }  
	}
	webservice static List<String> getPastFlightsWRP(String id){
		try{
			List<Account> lstAcc = [SELECT R1_ACC_TXT_Id_Golden_record__c from Account where id = :id LIMIT 1];
			if(!lstAcc.isEmpty()){
				ResponseWRP respWrp = retrievePasFlights(lstAcc[0].R1_ACC_TXT_Id_Golden_record__c,0);
				String vueloJson='';
				List<String> lstWrpJson = new List<String>();
				for(VueloWRP vuelo : respWrp.flights){
					vueloJson = JSON.serialize(vuelo);
					lstWrpJson.add(vueloJson);
				}
			return lstWrpJson;
			}
			else{
				return null;
			}
		}catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }  

	}
	public static ResponseWRP retrievePasFlights(String goldenRecordId, integer intentos){
		 try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;  
            
           	RequestWRP wrp = new RequestWRP();
           	wrp.goldenRecordID = goldenRecordId;
    		
            
            
        
            string wsMethod = 'Retrieve Past Flights';
            if(R1_CS_Endpoints__c.getInstance(wsMethod) == null || !R1_CS_Endpoints__c.getInstance(wsMethod).R1_CHK_Activo__c) {
                return null;
            }
  
            HttpRequest req = new HttpRequest();
            req.setEndpoint(R1_CS_Endpoints__c.getInstance(wsMethod).R1_TXT_EndPoint__c);  

        
            String token = R1_CLS_Utilities.getCache('local.sessionCache.token'); 
            if(token==null){
                if(intentos<3){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return retrievePasFlights(goldenRecordId,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '','No se puede conectar', 'Account');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token); 
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(10000);
            system.debug(req);

            req.setBody(JSON.serialize(wrp));
            Http http = new Http();
        
            HTTPResponse res;
            res = http.send(req);

            System.debug('!!!body: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
                ResponseWRP resp = (ResponseWRP)JSON.deserialize(res.getBody(),ResponseWRP.class);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return retrievePasFlights(goldenRecordId,intentos);
             
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '','', 'Account');
            		return null;
                }
            }
          
        }catch(Exception exc){
            R1_CLS_LogHelper.generateErrorLog('R2_CLS_RetrieveAccountPastFlights.retrievePasFlights', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
            return null;
        }  
	}
}