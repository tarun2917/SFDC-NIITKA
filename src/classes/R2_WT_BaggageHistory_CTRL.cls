/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    Controller R2_VF_BaggageHistory.page
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
public class R2_WT_BaggageHistory_CTRL {
		public R1_Incident__c pir {get;set;}
		public List<List<String>> historyTransaction {get;set;}
		public List<List<String>> historyMatch {get;set;}
		public R1_Incident__c incident {get;set;}
		public String selection {get;set;}
		public String pirSelected {get;set;}
		public String selectionFull {get;set;}
		public String responseDOH {get;set;}
		public Boolean showROH {get;set;}{showROH=false;}
		public String nm {get;set;}
		public String tn {get;set;}
		public String xt {get;set;}
		public String fw {get;set;}
		public String fd {get;set;}
		public String fo {get;set;}
		public String fb {get;set;}
		public String fs {get;set;}
		public String rl {get;set;}
		public String ag {get;set;}
		public String ct {get;set;}
		public String bi {get;set;}
		public String fi {get;set;}
		public String si01 {get;set;}
		public String si02 {get;set;}

		{fi = ''; si01 = ''; si02 = '';
        incident = null;
                }
	 // public List<List<String>> getMatch(){
		//  String test1 = '1   MCH  14NOV/2050 FWD MADIB      TAG MATCH TN/IB570604\n         NM BAILETTIWIESE\n         TN IB570604\n         XT IB570604\n         FW DUSIB\n         FD IB6650/13NOV/IB3134/14NOV\n         FO IB3140/15NOV\n         FB 1 - FS MAD - RL 63 - AG 005364/09999';
		//  String test2 = '2   MCH  15NOV/0850 OHD CLOAA29458/C - 60\n TN/CT/FD/RT MAD';
		//  String test3 = '3   MCH  15NOV/0850 OHD MAD8X25014/C - 62 CT/FD/RT MAD';
		//  return splitInLines(new String[] {test1, test2, test3});
		//  // return null;
		//}
		public R2_WT_BaggageHistory_CTRL(ApexPages.StandardController controller){
			pir = (R1_Incident__c)controller.getRecord();
            

		}

		private List<List<String>> splitInLines(List<String> items) {
			List<List<String>> splited = new List<List<String>>();
			for (String item : items) {
				splited.add(item.split('\n'));
			}
			return splited;
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
		public String readRecord_WT(String recordTypeName, String stationCode, String airlinecode, String referenceNumber, String agentId){
			try{
					if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
					R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
					R2_CLS_WT_Bags_Management.WpReq requestRead = new R2_CLS_WT_Bags_Management.WpReq();
							R2_CLS_WT_Bags_Management.NewRecordType rt = new R2_CLS_WT_Bags_Management.NewRecordType();
									R2_CLS_WT_Bags_Management.AssociatedRecord ar = new R2_CLS_WT_Bags_Management.AssociatedRecord();
									ar.stationCode = stationCode;
									ar.airlineCode = airlinecode;
									ar.referenceNumber = referenceNumber;
							rt.recordReference = ar;
							rt.recordType = recordTypeName;
					requestRead.recordId = rt;
					requestRead.agentId = agentId;
					bigWP.read = JSON.serialize(requestRead);
					String wrapper = R2_CLS_WT_Bags_Management.readHistory(bigWP.read, 0, recordTypeName);//'DELAYED');
					return wrapper;
			}catch(Exception ex){
					R1_CLS_LogHelper.generateErrorLog('readRecord_WT', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
					return null;
			}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		04/05/2018             Alberto Puerto Collado                  Reverse of match history && field recordType.DeveloperName used in query
		----------------------------------------------------------------------------------------------------------------------*/
		public void readRecordId(){
			responseDOH = null;
			selection = null;
				incident = [SELECT Id, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c, RecordType.DeveloperName
							FROM R1_Incident__c WHERE Id=:pir.Id];
				System.debug('*******************incident'+incident);
				String stationCode = incident.R2_INC_TXT_PIR_Station_Code__c;
				String airlinecode = incident.R2_INC_TXT_PIR_Airline_Code__c;
				String referenceNumber = incident.R2_INC_TXT_PIR_Reference_Number__c;
				String recordTypeName = incident.RecordType.DeveloperName;
				String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;
				
				try{
						if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
						String bag = readRecord_WT(recordTypeName, stationCode, airlinecode, referenceNumber, agentId);
						R2_CLS_WT_Bags_Management.Wp_RetrieveDelayedBag_Response response = (R2_CLS_WT_Bags_Management.Wp_RetrieveDelayedBag_Response)JSON.deserialize(bag, R2_CLS_WT_Bags_Management.Wp_RetrieveDelayedBag_Response.class);
						System.debug('(List<String>) response.history: '+(List<String>) response.history);
						if (response.history != null) {
							historyTransaction = splitInLines((List<String>) response.history);
							//04/may AlbertoPuerto: there is not a reverse function in apex yet, manually reverse:
							List<List<String>> reversed = new List<List<String>>();

							for(Integer i = historyTransaction.size() - 1; i >= 0; i--){
							    reversed.add(historyTransaction[i]);
							}
							//System.debug(':::historyTransaction ANTES del reverse: '+ historyTransaction);
							historyTransaction = reversed;
							//System.debug(':::historyTransaction DESPUES del reverse: '+ historyTransaction);
						}
						if (response.matchHistory != null) {
							historyMatch = splitInLines((List<String>) response.matchHistory);
						}
						//historyMatch = getMatch();
						System.debug('historyMatch: ' + historyMatch);
						CLS_INC_WT_Monitoring.watchingWT('Histórico/Match', 'Histórico/Match WT');
				}catch(Exception ex){
						R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.readRecordId', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
				}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
		public void processROH(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				System.debug('processROH: ');
				nm = null;
				tn = null;
				xt = null;
				fw = null;
				fd = null;
				fo = null;
				fb = null;
				fs = null;
				rl = null;
				ag = null;
				ct = null;
				bi = null;
				fi = null;
				si01 = null;
				si02 = null;
				//List<String> rohSelected = selectionFull.split(' |\n');
				List<String> rohSelected = selectionFull.split(' ');
				System.debug(rohSelected);
				for(Integer i = 0; i < rohSelected.size(); i++){
					if(rohSelected.get(i).equals('NM')){
						nm = rohSelected.get(i+1);
						System.debug('NM: '+nm);
					}
					else if (rohSelected.get(i).equals('TN')){
						tn = rohSelected.get(i+1);
						System.debug('TN: '+tn);
					}
					else if (rohSelected.get(i).equals('XT')){
						xt = rohSelected.get(i+1);
						System.debug('XT: '+xt);
					}
					else if (rohSelected.get(i).equals('FW')){
						fw = rohSelected.get(i+1);
						System.debug('FW: '+fw);
					}
					else if (rohSelected.get(i).equals('FD')){
						fd = rohSelected.get(i+1);
						System.debug('FD: '+fd);
					}
					else if (rohSelected.get(i).equals('FO')){
						fo = rohSelected.get(i+1);
						System.debug('FO: '+fo);
					}
					else if (rohSelected.get(i).equals('FB')){
						fb = rohSelected.get(i+1);
						System.debug('FB: '+fb);
					}
					else if (rohSelected.get(i).equals('FS')){
						fs = rohSelected.get(i+1);
						System.debug('FS: '+fs);
					}
					else if (rohSelected.get(i).equals('RL')){
						rl = rohSelected.get(i+1);
						System.debug('RL: '+rl);
					}
					else if (rohSelected.get(i).equals('AG')){
						ag = rohSelected.get(i+1);
						System.debug('AG: '+ag);
					}
					else if (rohSelected.get(i).equals('CT')){
						ct = rohSelected.get(i+1);
						System.debug('CT: '+ct);
					}
					else if (rohSelected.get(i).equals('BI')){
						ct = rohSelected.get(i+1);
						System.debug('BI: '+bi);
					}
					showROH = true;
				}
			}catch(Exception ex){
				R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.processROH', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
			}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
		public void readDOHAux(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				responseDOH=null;
				System.debug('!!!!!!!!!!readDOHAux');
				List<String> dohSelected = selection.split(' |/');
				String pirSelected = null;
				for(String match : dohSelected){
					if(match.equals('OHD')){
						System.debug('!!!!!!!!!!OHD');
						readDOH();
					}
					else if(match.equals('FWD')){
						System.debug('FWD');
						rushSearchFWD();
					}
				}
			}catch(Exception ex){
				R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.readDOHAux', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
			}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017              Alberto Puerto Collado                  Initial Version
		18/04/2018				Alberto Puerto Collado					Format JSON to display it
		----------------------------------------------------------------------------------------------------------------------*/
		public void readDOH(){
			System.debug('***********readDOH********selection'+selection);
			System.debug('***********readDOH********incident'+incident);
			String wrapper = null;
			List<String> dohSelected = selection.split(' |/');
			String pirSelected = null;
			for(String match : dohSelected){
				if(Pattern.matches('[a-zA-Z]{5}[0-9]{5}', match)){
					System.debug('MATCHED!!!'+match);
					pirSelected = match;
				}
			}
			String stationCodeOnHand = pirSelected.substring(0,3);
			System.debug(stationCodeOnHand);
			String airlinecodeOnHand = pirSelected.substring(3,5);
			System.debug(airlinecodeOnHand);
			String referenceNumberOnHand = pirSelected.substring(5,10);
			System.debug(referenceNumberOnHand);
			String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

			try{
					if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
					R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request bigWP = new R2_CLS_WT_Bags_Management.WrapperBigBigOne_Request();
					R2_CLS_WT_Bags_Management.WpReq_ReadOnHand_DOH requestRead = new R2_CLS_WT_Bags_Management.WpReq_ReadOnHand_DOH();
					R2_CLS_WT_Bags_Management.NewRecordType recordType = new R2_CLS_WT_Bags_Management.NewRecordType();
					R2_CLS_WT_Bags_Management.AssociatedRecord bagRecord = new R2_CLS_WT_Bags_Management.AssociatedRecord();
					bagRecord.stationCode = stationCodeOnHand;
					bagRecord.airlineCode = airlinecodeOnHand;
					bagRecord.referenceNumber = referenceNumberOnHand;
					recordType.recordType = 'ON-HAND';
					recordType.recordReference = bagRecord;
					requestRead.recordId = recordType;
					requestRead.agentId = agentId;
					bigWP.read = JSON.serialize(requestRead);
					wrapper = R2_CLS_WT_Bags_Management.ReadRecord_OHD_DOH(bigWP.read,0);
			}catch(Exception ex){
					R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.readDOH', 'error creando el wrapper y llamando a ReadRecord_OHD_DOH', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
			}
			try{
					responseDOH = R2_CLS_WT_Bags_Management.helper_fixerJson(wrapper);
					//responseDOH = wrapper;
					System.debug('responseDOH' + responseDOH);
					//18/04/2018 format
					R2_CLS_WT_Bags_Management.WpResOnHandBag resultado = (R2_CLS_WT_Bags_Management.WpResOnHandBag)JSON.deserialize(wrapper, R2_CLS_WT_Bags_Management.WpResOnHandBag.class);
					
					String pintando = '';
					//NOTA:
					//styleClass='ckeditor' -> Rerender is not currently supported with rich text editing enabled  when
					// richText = true, revisar, pintar mientras de otra forma
					if(resultado.success == 'YES' || resultado.success == 'TRUE'){
						System.debug('Pintando respuesta de lectura DOH success y warnings');
						pintando += 'Lectura de OHD ' + stationCodeOnHand + airlinecodeOnHand + referenceNumberOnHand + ':';
						pintando += '                  Estado del OHD: ' + resultado.recordStatus;
			  			
			  			if(resultado.diaryInfo != null){
			  				//pintando += 'blabla<br/>';
			  				pintando += ' ///////////////////////////////////////////////////////////DRY////////////////////////////////////////////////////////// ';
							//pintando += ' Bag TOTAL created: ' + String.valueOf(resultado.diaryInfo.createDate);
							String longFecha = String.valueOf(resultado.diaryInfo.createDate);
							List<String> lstFech = longFecha.split('T');
							String fecha = R1_CLS_Utilities.helper_DateSFtoDateString(lstFech[0]);
							pintando += ' Bag created: ' + fecha + lstFech[0].substring(2,4) + '/' + lstFech[1].substring(0,5) + 'GTM';
							pintando += ' || WT-'  + fecha; //+dia mes - 04APR... etc
			  			}
						if(resultado.passengers != null){
							if(resultado.passengers.names != null){
								pintando += ' ///////////////////////////////////////////////////////////PAX////////////////////////////////////////////////////////// ';
								pintando += 'NM' + resultado.passengers.names[0].name;	
								if(resultado.passengers.names.size() > 1){
									pintando += ' || NM' + resultado.passengers.names[1].name;
								}
							}
							if(resultado.passengers.initials != null){
								pintando += ' || IT' + resultado.passengers.initials[0].initial;
								if(resultado.passengers.initials.size() > 1){
									pintando += ' || IT' + resultado.passengers.initials[1].initial;
								}
							}
							if(resultado.passengers.title != null){ pintando += ' .PT' + resultado.passengers.title; }
							if(resultado.passengers.frequentFlyerId != null){ pintando += ' .FL' + resultado.passengers.frequentFlyerId; }
						}
						if(resultado.onHandBagGroup != null){
							if(resultado.onHandBagGroup.onHandBags != null){
								//Sólo se lee un on hand
								pintando += ' ///////////////////////////////////////////////////////////BAG//////////////////////////////////////////////////////////// ';
								//pintando += 'TN01***    .LN01      .CT01***';
								if(resultado.onHandBagGroup.onHandBags.bagTag != null){
									pintando += 'TN: ' + resultado.onHandBagGroup.onHandBags.bagTag.airlineCode + resultado.onHandBagGroup.onHandBags.bagTag.tagSequence;
									if(resultado.onHandBagGroup.onHandBags.bagTag.suspended == true){
										pintando += '/S';
									}
								}
								//if(resultado.onHandBagGroup.onHandBags.brandInfo != null){
								//	pintando += 'BrandInfo: ' + resultado.onHandBagGroup.onHandBags.brandInfo;
								//	if(resultado.onHandBagGroup.onHandBags.brandInfo.suspended == true){
								//		pintando += '/S';
								//	}
								//}
								
								if(resultado.onHandBagGroup.onHandBags.colourAndType != null){
									if(resultado.onHandBagGroup.onHandBags.colourAndType.typeCode != null){
										pintando += ' || TypeCode: ' + resultado.onHandBagGroup.onHandBags.colourAndType.typeCode;
									}
									// colourCode + typeCode + materialElement != null  y otherElement lista
									pintando += ' || CT: ' + resultado.onHandBagGroup.onHandBags.colourAndType.colourCode
												+resultado.onHandBagGroup.onHandBags.colourAndType.typeCode;
									if(resultado.onHandBagGroup.onHandBags.colourAndType.descriptor != null){
										if(resultado.onHandBagGroup.onHandBags.colourAndType.descriptor.materialElement != null){
											pintando += resultado.onHandBagGroup.onHandBags.colourAndType.descriptor.materialElement;
										}
										if(resultado.onHandBagGroup.onHandBags.colourAndType.descriptor.otherElement != null){
											for(Integer i = 0 ; i < resultado.onHandBagGroup.onHandBags.colourAndType.descriptor.otherElement.size(); i++){
												pintando += resultado.onHandBagGroup.onHandBags.colourAndType.descriptor.otherElement[i];
											}	
										}
									}
								}
							}

							if(resultado.onHandBagGroup.onHandBags.itinerary != null){
								pintando += ' ///////////////////////////////////////////////////////////RTI//////////////////////////////////////////////////////////// ';
								//for(Integer i=0; i<resultado.passengers.itinerary.flightSegmentsorARNK.size(); i++){
								//	pintando += 'RT' + resultado.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.flightAndDate;
								//	pintando += 'FD' + resultado.passengers.itinerary.flightSegmentsorARNK[i].flightAmend.originDestination;
								//}
								//if(resultado.onHandBagGroup.onHandBags.itinerary.flightSegments != null){
								//	if(resultado.onHandBagGroup.onHandBags.itinerary.flightSegments.flightSegment != null){
								//		pintando += ' || FD: ' + '';
								//		for(Integer i=0; i< resultado.onHandBagGroup.onHandBags.itinerary.flightSegments.flightSegment.size(); i++){
								//			String vuelo = '';
								//			pintando +=  'meh';
								//			pintando += ' || FD: ' + resultado.onHandBagGroup.onHandBags.itinerary.flightSegments.flightSegment;
								//		}
								//	}
								//}
								//if(resultado.onHandBagGroup.onHandBags.itinerary.routes != null){
								//	pintando += ' || RT: ' + resultado.onHandBagGroup.onHandBags.itinerary.routes;
								//}
								//if(resultado.onHandBagGroup.onHandBags.itinerary.newRoutes != null){
								//	pintando += ' || RTnew: ' + resultado.onHandBagGroup.onHandBags.itinerary.newRoutes;
								//}
							}
						}
						
						String vueloFinal = '';
						String rutas = '';
						Map<String,String> vueloFechaMap = new Map<String,String>();
						Map<String,String> vueloFechaMapNew = new Map<String,String>();
						if(resultado.onhandBagGroup != null){
						    if (resultado.onhandBagGroup.onHandBags != null){
						        if (resultado.onhandBagGroup.onHandBags.itinerary != null) {
						            if (resultado.onhandBagGroup.onHandBags.itinerary.flightSegments != null) {
						                if (resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment != null) {
						                    for(Integer i = 0; i < resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment.size(); i++){ //5
						                        if(resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment[i].flightDate != null) {
						                            String vuelo = resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment[i].flightDate.airlinecode;
						                            vuelo += resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment[i].flightDate.flightNumber;
						                            String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resultado.onhandBagGroup.onHandBags.itinerary.flightSegments.flightSegment[i].flightDate.flightDate);
						                            vueloFechaMap.put(vuelo, fecha);
						                        }
						                    }
						                }
						            }
						            vueloFinal += R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMap);

						            if (resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments != null) {
						                if (resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment != null) {
						                    for(Integer i = 0; i < resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment.size(); i++){ //5
						                        if(resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment[i].flightDate != null) {
						                            String vuelo = resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment[i].flightDate.airlinecode;
						                            vuelo += resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment[i].flightDate.flightNumber;
						                            String fecha = R1_CLS_Utilities.helper_DateSFtoDateString((String)resultado.onhandBagGroup.onHandBags.itinerary.newFlightSegments.flightSegment[i].flightDate.flightDate);
						                            vueloFechaMapNew.put(vuelo, fecha);
						                        }
						                    }
						                }
						            }
						            vueloFinal += R1_CLS_Utilities.helper_parseDate_MapaToString(vueloFechaMapNew);
						            pintando += ' ||FD:' + vueloFinal;

						            if (resultado.onhandBagGroup.onHandBags.itinerary.routes != null) {
						                if (resultado.onhandBagGroup.onHandBags.itinerary.routes.route != null) {
						                    for(Integer i = 0; i < resultado.onhandBagGroup.onHandBags.itinerary.routes.route.size(); i++){ 
						                        rutas += resultado.onhandBagGroup.onHandBags.itinerary.routes.route[i] + '/'; 
						                    }
						                }
						                if (resultado.onhandBagGroup.onHandBags.itinerary.newRoutes != null) {
						                	if (resultado.onhandBagGroup.onHandBags.itinerary.newRoutes.route != null) {
							                    for(Integer i = 0; i < resultado.onhandBagGroup.onHandBags.itinerary.newRoutes.route.size(); i++){ 
							                        rutas += resultado.onhandBagGroup.onHandBags.itinerary.newRoutes.route[i] + '/'; 
							                    }
							                }
						                }
						                
						            }
						        }
						        rutas = rutas.removeEnd('/'); 
						        pintando += ' ||RT:' + rutas;
						    }
						}


						//NO hay CLAIMS en OHD ...
						//pintando += ' ///////////////////////////////////////////////////////////CLM////////////////////////////////////////////////////////// ';

						pintando += ' ///////////////////////////////////////////////////////////OSI//////////////////////////////////////////////////////////// ';			
						if(resultado.handledAirlineCopyIndicator != null){
							pintando += resultado.handledAirlineCopyIndicator;
						}else{
							pintando += 'Sin datos OSI';
						}
						

						pintando += ' ///////////////////////////////////////////////////////////MCH//////////////////////////////////////////////////////////// ';
						if(resultado.recordHistory.matchHistory != null){
							//pintando += resultado.recordHistory.matchHistory;
							for(Integer i=0; i<resultado.recordHistory.matchHistory.size();i++){
								pintando += resultado.recordHistory.matchHistory[i] + '. ';
							}
						}else{
							pintando += 'Sin datos MCH';
						}

						pintando += ' ///////////////////////////////////////////////////////////MSG///////////////////////////////////////////////////////// ';
						if(resultado.additionalInfo.messageInfo != null){
							pintando += resultado.additionalInfo.messageInfo;
						}else{
							pintando += 'Sin datos MSG';
						}
					}else{
						System.debug('Pintando errores de lectura DOH ');
						pintando += 'Error al leer el OHD seleccionado';
			  
		            }
		            responseDOH = pintando;// + + ;
			}catch(Exception ex){
					R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.readDOH', 'error parseando la respuesta de ReadRecord_OHD_DOH', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
			}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                   Initial Version
		18/03/2018             Alberto Puerto Collado     				Fixed calling service
		18/04/2018             Alberto Puerto Collado     				prepareFW('ADVANCED'); //commented, it does not exist for agents, only from the airports
		----------------------------------------------------------------------------------------------------------------------*/
		public void prepareROHAux(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				responseDOH=null;
				System.debug('!!!!!!!!!!prepareROHAux');
				List<String> dohSelected = selection.split(' |/');
				String pirSelected = null;
				for(String match : dohSelected){
					if(match.equals('OHD')){
						System.debug('!!!!!!!!!!OHD');			
						 rushSearchROH(); 
						//prepareFW('SIMPLE');
					}
					else if(match.equals('FWD')){
						System.debug('FWD');
						//prepareROH(); 
						System.debug('FWD::no va a existir el servicio, se hace desde el aeropuerto');
						//prepareFW('ADVANCED'); //commented, it does not exist for agents, only from the airports
						// rushSearchROH();  -> antiguo, ahora arreglado con prepareFW
					}
				}
			}catch(Exception ex){
				R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.prepareROHAux', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
			}
		}
/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alberto Puerto Collado
	Company:        Accenture
	Description:    No existe el servicio Leer FWD activo en Iberia/IntInt -> los datos los recogemos de la info devuelta del match
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	21/11/2017             Alberto Puerto Collado                  Initial Version
    18/03/2018             Alberto Puerto Collado                  Fixed calling service 
	----------------------------------------------------------------------------------------------------------------------*/
	public void prepareFW(String searchType){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
                
  			incident = [SELECT Id, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c,R2_INC_TXT_PIR_Name__c 
                        FROM R1_Incident__c WHERE Id=:pir.Id];
  			System.debug('***********prepareFW********selection'+selection);
  			System.debug('***********prepareFW********selectionFull'+selectionFull);
  			System.debug('***********prepareFW********incident'+incident);

  			String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

			//preparando el matcheo de cada componente:
			String cadena = selection.replaceAll('((FWD|NM|TN|XT|FW|FD|FO|TX))(\\s)','$1@');
			List<String> fwdSelected = cadena.split(' |/');
			String stationAirline = null;
			String originalBagTag = null;
			String rushBagTag = null;
			String rushBagDestination = null;
			String originalFlights = null;
			String rushFlights = null;
			String name = null;
			String teletypeAddress = null;
			List<String> lstAux = new List<String>();
			for(String match : fwdSelected){
                if(Pattern.matches('FWD@[a-zA-Z]{5}', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    stationAirline = lstAux[1];
					System.debug(':::stationAirline!!!'+stationAirline);
                }
				if(Pattern.matches('TN@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    originalBagTag = lstAux[1];
					System.debug('MATCHED!!!'+originalBagTag);
                }
				if(Pattern.matches('XT@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    rushBagTag = lstAux[1];
					System.debug(':::stationAirline!!!'+rushBagTag);
                }
				if(Pattern.matches('FW@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    rushBagDestination = lstAux[1];
					System.debug(':::stationAirline!!!'+rushBagDestination);
                }
				if(Pattern.matches('FD@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    originalFlights = lstAux[1];
					System.debug(':::stationAirline!!!'+originalFlights);
                }
				if(Pattern.matches('FO@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    rushFlights = lstAux[1];
					System.debug(':::stationAirline!!!'+rushFlights);
                }
				if(Pattern.matches('NM@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    name = lstAux[1];
					System.debug(':::stationAirline!!!'+name);
                }
				if(Pattern.matches('TX@.*', match)){
                    System.debug('MATCHED!!!'+match);
					lstAux = match.split('@');
                    teletypeAddress = lstAux[1];
					System.debug(':::stationAirline!!!'+teletypeAddress);
                }
            }
            

          	//wrapper request
			  R2_CLS_WT_Bags_Management.WpReqSearchForward request = new R2_CLS_WT_Bags_Management.WpReqSearchForward();
				request.recordType = 'RUSH';
				request.searchType = searchType; //ADVANCED or SIMPLE values
				if(stationAirline != null){
					R2_CLS_WT_Bags_Management.RefStationAirlineType refSA = new R2_CLS_WT_Bags_Management.RefStationAirlineType();
						refSA.stationCode = stationAirline.substring(0,2);
						refSA.airlineCode = stationAirline.substring(2,5);
					request.referenceStationAirLine = refSA;
				}
				if(name != null){
					request.name = name;
				}
				//missing station empty en la lectura desde match, no se mapea
				//date range empty en la lectura desde match, no se mapea
				if(originalBagTag != null){
					R2_CLS_WT_Bags_Management.BagTag obt = new R2_CLS_WT_Bags_Management.BagTag();
						obt.tagSequence = originalBagTag.substring(2);
						R2_CLS_WT_Bags_Management.LicenseNumber licNum = new R2_CLS_WT_Bags_Management.LicenseNumber();
							licNum.issuerCode = originalBagTag.substring(0,2);//este mapeo a comprobar!
						obt.licenseNumber = licNum;
					request.bagTag = obt;
				}
				if(rushBagTag != null){
					R2_CLS_WT_Bags_Management.BagTag rbt = new R2_CLS_WT_Bags_Management.BagTag();
						rbt.tagSequence = rushBagTag.substring(2);
						R2_CLS_WT_Bags_Management.LicenseNumber licNum = new R2_CLS_WT_Bags_Management.LicenseNumber();
							licNum.issuerCode = rushBagTag.substring(0,2);//este mapeo a comprobar!
						rbt.licenseNumber = licNum;
					request.rushBagTag = rbt;
				}
				if(rushBagDestination != null){
					R2_CLS_WT_Bags_Management.MissingStation route = new R2_CLS_WT_Bags_Management.MissingStation();
						route.stationCode = rushBagDestination.substring(0,2);
						route.airlineCode = rushBagDestination.substring(2,5);
					request.rushRoute = route;
				}
				if(originalFlights != null || rushFlights != null){
					R2_CLS_WT_Bags_Management.WrapFlights vuelos = new R2_CLS_WT_Bags_Management.WrapFlights();
						if(originalFlights != null){
						R2_CLS_WT_Bags_Management.FlightDate originalVue = new R2_CLS_WT_Bags_Management.FlightDate();
						List<String> splitVuelos = originalFlights.split('/');
							originalVue.stationCode = splitVuelos[0].substring(0,2);
							originalVue.airlineCode = splitVuelos[0].substring(2,5);
							originalVue.rDate = splitVuelos[1];
						vuelos.originalFlight = originalVue;
						}
						if(rushFlights != null){
						R2_CLS_WT_Bags_Management.FlightDate rushVue = new R2_CLS_WT_Bags_Management.FlightDate();
						List<String> splitVuelos = rushFlights.split('/');
							rushVue.stationCode = splitVuelos[0].substring(0,2);
							rushVue.airlineCode = splitVuelos[0].substring(2,5);
							rushVue.rDate = splitVuelos[1];
						vuelos.rushFlight = rushVue;
						}
					request.flight = vuelos;
				}

				//area empty en la lectura desde match, no se mapea -> puede que venga pero no necesario tras hablar con IntInt
				if(teletypeAddress != null){
					List<String> lstTX = teletypeAddress.split('/');
					request.teletypeAddress = lstTX;
				}
				//email empty en la lectura desde match, no se mapea
            	request.agentId = agentId;
         
            String wrapper = JSON.serialize(request);

            String resp = R2_CLS_WT_Bags_Management.rushBagSearch(wrapper,0);


        }catch(Exception exc){
              R1_CLS_LogHelper.generateErrorLog('R2_CLS_DamagedBagManager.prepareFW', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }
	}
	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Alberto Puerto Collado
	Company:        Accenture
	Description:    
	IN:
	OUT:

	History:
	 <Date>                     <Author>                         <Change Description>
	21/11/2017             Alberto Puerto Collado                  Initial Version
    27/02/2018             Alberto Puerto Collado                  Fixed calling service 
	----------------------------------------------------------------------------------------------------------------------*/
	public void prepareROH(){
        try{
            if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    
                
  			incident = [SELECT Id, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c,R2_INC_TXT_PIR_Name__c 
                        FROM R1_Incident__c WHERE Id=:pir.Id];
  			System.debug('***********readDOH********selection'+selection);
  			System.debug('***********readDOH********selectionFull'+selectionFull);
  			System.debug('***********readDOH********incident'+incident);
  			//String stationCode = incident.R2_INC_TXT_PIR_Station_Code__c;
  			//String airlineCode = incident.R2_INC_TXT_PIR_Airline_Code__c;
  			//String referenceNumber = incident.R2_INC_TXT_PIR_Reference_Number__c;
  			 
     //       String passengerName = incident.R2_INC_TXT_PIR_Name__c;

  			String agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

            List<String> dohSelected = selection.split(' |/');
            String pirSelected = null;
            for(String match : dohSelected){
                if(Pattern.matches('[a-zA-Z]{5}[0-9]{5}', match)){
                    System.debug('MATCHED!!!'+match);
                    pirSelected = match;
                }
            }

            //wrapper request
         //   R2_CLS_WT_Bags_Management.WPRequestOnHandBagWebRequest request = new R2_CLS_WT_Bags_Management.WPRequestOnHandBagWebRequest();
  			    //R2_CLS_WT_Bags_Management.AssociatedRecord delBag = new R2_CLS_WT_Bags_Management.AssociatedRecord();
         //           delBag.stationCode = incident.R2_INC_TXT_PIR_Station_Code__c;
         //           delBag.airlineCode = incident.R2_INC_TXT_PIR_Airline_Code__c;
         //           delBag.referenceNumber = incident.R2_INC_TXT_PIR_Reference_Number__c;
         //       request.delayedBag = delBag;

         //       R2_CLS_WT_Bags_Management.AssociatedRecord ohnBag = new R2_CLS_WT_Bags_Management.AssociatedRecord();
         //           ohnBag.stationCode = null;
         //           ohnBag.airlineCode = null;
         //           ohnBag.referenceNumber = null;
         //       request.onHandBags = ohnBag;


            //request.passengerName = incident.R2_INC_TXT_PIR_Name__c;
            //request.supplementaryText = null;
            //request.furtherInfo = null;
            //request.agentId = agentId;
         
            //String req = createRequest_ROH();

            String wrapper = null;

        

  			

            String resp = R2_CLS_WT_Bags_Management.RequestOnhandBagResponse(wrapper,0);


        }catch(Exception exc){
              R1_CLS_LogHelper.generateErrorLog('R2_CLS_DamagedBagManager.prepareROH', '', exc.getmessage()+', '+exc.getLineNumber(), '');
        }
	}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
		public void rushSearchFWD(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
		
				String req = createRequest_ROH();
				String resp = R2_CLS_WT_Bags_Management.RetrieveOHD(req,0);
				System.debug(resp);
				if(resp != null && resp.equals('1')){//{"success":true}')){
					//List<R2_Baggage__c> bag = [SELECT Id, Name FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c=:incident.Id];
					updateSelectedBag();
					showROH = false;
				}
			}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.rushSearchFWD', 'error en rushSearchFWD', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Baggage__c');
        	}
		}
/*---------------------------------------------------------------------------------------------------------------------
		Author:         Alberto Puerto Collado
		Company:        Accenture
		Description:    
		IN:
		OUT:

		History:
		 <Date>                     <Author>                         <Change Description>
		21/11/2017             Alberto Puerto Collado                  Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
		public void rushSearchROH(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
		
				String req = createRequest_ROH();
				String resp = R2_CLS_WT_Bags_Management.RetrieveOHD(req,0);
				System.debug(resp);
				if(resp != null && resp.equals('1')){//{"success":true}')){
					//List<R2_Baggage__c> bag = [SELECT Id, Name FROM R2_Baggage__c WHERE R2_BAG_MSDT_Incident__c=:incident.Id];
					updateSelectedBag();
					showROH = false;
				}
			}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.rushSearchROH', 'error en rushSearchROH', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Baggage__c');        	}
		}


/*---------------------------------------------------------------------------------------------------------------------
Author:         Alberto Puerto Collado
Company:        Accenture
Description:    Create Wrapper WpReq_ROH_forward
IN:
OUT:

History:
 <Date>                     <Author>                         <Change Description>
06/02/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
	public String createRequest_ROH(){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
		
			System.debug(':::createRequest_ROH ');
			incident = [SELECT Id, R2_INC_TXT_PIR_Station_Code__c, R2_INC_TXT_PIR_Airline_Code__c, R2_INC_TXT_PIR_Reference_Number__c, 
									R2_INC_TXT_PIR_Name__c, R2_INC_TXT_PIR_Last_name__c, R2_INC_TXT_PIR_Last_name2__c
									FROM R1_Incident__c WHERE Id=:pir.Id];

			R2_CLS_WT_Bags_Management.WpReq_ROH_forward wrapper = new R2_CLS_WT_Bags_Management.WpReq_ROH_forward();
			
			List<String> lstSI = new List<String>();
				String si1 = si01; //var from page
				lstSI.add(si1);
				String si2 = si02; //var from page
				lstSI.add(si2);
			wrapper.supplimentaryText = lstSI;
			wrapper.furtherInfo = fi; //var from page
				R2_CLS_WT_Bags_Management.OnHandBags ohds = new R2_CLS_WT_Bags_Management.OnHandBags();
					List<R2_CLS_WT_Bags_Management.OnHandBag> lstOHD = new List<R2_CLS_WT_Bags_Management.OnHandBag>();
					//lista hasta 5, for etc.. pero realmente sólo mandamos uno...
						R2_CLS_WT_Bags_Management.OnHandBag ohd = new R2_CLS_WT_Bags_Management.OnHandBag();
						String rowSelected = selection.replaceAll('.*(OHD|FWD)\\s([A-Z]{3}[A-Z0-9]{2}[0-9]{5,6}).*', '$2'); //añadir |FWD
						ohd.stationCode = rowSelected.substring(0, 3);
						ohd.airlinecode = rowSelected.substring(3, 5);
						ohd.referenceNumber = rowSelected.substring(5);
						System.debug(':::rowSelected '+ rowSelected);
						System.debug(':::ohd '+ ohd);
					//} fin for
					lstOHD.add(ohd);
				ohds.onHandBag = lstOHD;
			wrapper.onHandBags = ohds;
				R2_CLS_WT_Bags_Management.AssociatedRecord bagDelayed = new R2_CLS_WT_Bags_Management.AssociatedRecord();
				bagDelayed.stationCode = incident.R2_INC_TXT_PIR_Station_Code__c;
				bagDelayed.airlineCode = incident.R2_INC_TXT_PIR_Airline_Code__c;
				bagDelayed.referenceNumber = incident.R2_INC_TXT_PIR_Reference_Number__c;
			wrapper.delayedBag = bagDelayed;
			//sacar del passenger y rellenar if not null etc :
			List<String> lstNames = new List<String>();
				String name = incident.R2_INC_TXT_PIR_Name__c; 
				lstNames.add(name);
				String lastName1 = incident.R2_INC_TXT_PIR_Last_name__c; 
				lstNames.add(lastName1);
				String lastName2 = incident.R2_INC_TXT_PIR_Last_name2__c; 
				lstNames.add(lastName2);
			wrapper.passengerName = lstNames;
			wrapper.agentId = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;

			//System.debug(':::wrapper creado ROH ' + wrapper);
			//return wrapper;

			String req = JSON.serialize(wrapper);
			System.debug(':::JSON creado ROH ' + req);
			req = R2_CLS_WT_Bags_Management.helper_fixerJson(req);
			System.debug(':::JSON creado ROH con helper_fixerJson' + req);
			return req;
		}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.createRequest_ROH', 'error en createRequest_ROH', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Baggage__c');
        	return null;
        }
	}
	
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alberto Puerto Collado
Company:        Accenture
Description:    update selected bag from AHL PIR with FI, SI01 and SI02 values
IN:
OUT:

History:
 <Date>                     <Author>                         <Change Description>
06/02/2018             Alberto Puerto Collado                  Initial Version
 ----------------------------------------------------------------------------------------------------------------------*/
	//estará en la visual :
	//public List<R2_Baggage__c> lstBagsInicial{get;set;}
	//public List<R2_Baggage__c> bagLst {get;set;}
	//private Integer maletaSelect {get;set;}
	//{maletaSelect = 0;}

	public void updateSelectedBag(){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
		
			//if(!bagLst.isEmpty()){
            if(incident != null){
				System.debug('Actualizando la bag seleccionada con FI,SI01, SI02 y resultado');
				//R2_Baggage__c bag = bagLst[maletaSelect];// o lstBagsInicial?

                R2_Baggage__c bag = [SELECT id, R2_BAG_CHK_Bag_selected__c,
                                    R2_BAG_TXT_ROH_FI__c, R2_BAG_TXT_ROH_SI01__c, R2_BAG_TXT_ROH_SI02__c, R2_BAG_TXT_ROH_result__c
                                    FROM R2_Baggage__c 
                                    WHERE R2_BAG_CHK_Bag_selected__c=TRUE
                                          AND R2_BAG_MSDT_Incident__c =: incident.Id
                                          LIMIT 1];
                System.debug(':::bag PRE seleccionada - ' + bag);   
                if(bag == null){
                    List<R2_Baggage__c> lstBag = [SELECT id, R2_BAG_CHK_Bag_selected__c,
                                    R2_BAG_TXT_ROH_FI__c, R2_BAG_TXT_ROH_SI01__c, R2_BAG_TXT_ROH_SI02__c, R2_BAG_TXT_ROH_result__c
                                    FROM R2_Baggage__c 
                                    WHERE R2_BAG_MSDT_Incident__c =: incident.Id
                                          ];
                    bag = lstBag[0];
                    System.debug(':::lstBag - ' + lstBag);   
                }
                System.debug(':::bag seleccionada - ' + bag);                       
					bag.R2_BAG_TXT_ROH_FI__c = fi;
					bag.R2_BAG_TXT_ROH_SI01__c = si01;
					bag.R2_BAG_TXT_ROH_SI02__c = si02;
					bag.R2_BAG_TXT_ROH_result__c = 'OHD Solicitado';
				update bag;
                System.debug(':::bag actualizada - ' + bag);
			}else{
				System.debug('incident está vacío, no hay update de bag, FI y SI01 y 02 y resultado no actualizado');
			}
			
		}catch(DmlException ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.updateSelectedBag', 'error DML en updateSelectedBag', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Baggage__c');
        }catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_BaggageHistory_CTRL.updateSelectedBag', 'error genérico en updateSelectedBag', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Baggage__c');
        }
	}
}