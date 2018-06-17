/*---------------------------------------------------------------------------------------------------------------------
	Author:         Ricardo Pereira Ramírez
	Company:        Accenture
	Description:    Clase de metodos para el trigger de Vouchers
	IN:
	OUT:

	History:
	<Date>                  <Author>                         <Change Description>
	27/10/2017             	Ricardo Pereira Ramírez          Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
public with sharing class R2_CLS_VoucherTriggerMethods {

	static final Map<String, Id> MAP_RT_NAME = new Map<String, Id>();
	static final Map<Id, String> MAP_RT_ID = new Map<Id, String>();

	static{
		for(RecordType rt : [SELECT Id, Name, DeveloperName FROM RecordType WHERE SobjectType IN ('R2_Voucher__c', 'R1_Incident__c')]){
			MAP_RT_NAME.put(rt.DeveloperName, rt.Id);
			MAP_RT_ID.put(rt.Id, rt.DeveloperName);
		}
	}

	public static void organizarVoucherIBConecta(List<R2_Voucher__c> lstVouchers){
		try{	
			if(lstVouchers[0].R2_VOU_LOO_Case__c != null && lstVouchers[0].R2_VOU_LOO_Incidence__c != null){
				List<Case> casoHijo = [SELECT id,R1_CAS_LOO_Incidences__c from Case where ParentId = :lstVouchers[0].R2_VOU_LOO_Case__c and RecordType.Name = 'Pasaje' and R2_CAS_CHK_Is_Proactive__c = true];
				if(casoHijo != null){
					casoHijo[0].R1_CAS_LOO_Incidences__c = lstVouchers[0].R2_VOU_LOO_Incidence__c;
					update casoHijo;
				}
			}
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.organizarVoucherIBConecta()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Voucher');
		}	
	}


	/*---------------------------------------------------------------------------------------------------------------------
	Author:         Jaime Ascanta
	Company:        Accenture
	Description:
	IN:
	OUT:

	History:
	<Date>                  <Author>                         <Change Description>
	18/12/2017             	Jaime Ascanta          			 Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
	public static void relateVoucher(List<R2_Voucher__c> newsVouchers){
		try{
			System.debug('*** Se va relacionar voucher con incidencia y vuelo');
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

			Set<String> setFliExtId = new Set<String>();
			Set<String> setIncExtId = new Set<String>();

			for(R2_Voucher__c voucher : newsVouchers){
				String fliExtIdTemp = generateFligthExternalId(voucher);
				if(fliExtIdTemp!=null && fliExtIdTemp!=''){
					setFliExtId.add(fliExtIdTemp);
					String delayType = getDelayType(voucher);
					if(delayType!=null && delayType!=''){
						setIncExtId.add(fliExtIdTemp+delayType);
						setIncExtId.add(fliExtIdTemp+delayType+'1');
						setIncExtId.add(fliExtIdTemp+delayType+'2');
						setIncExtId.add(fliExtIdTemp+delayType+'3');
					}
				}
			}

			// Buscamos vuelos
			Map<Id, R1_Flight__c> mapFlights = new Map<Id, R1_Flight__c>(
				[SELECT Id, R1_FLG_TXT_External_ID__c
				FROM R1_Flight__c
				WHERE R1_FLG_TXT_External_ID__c IN: setFliExtId ]);

			// Buscamos incidencias
			Map<Id, R1_Incident__c> mapIncidences = new Map<Id, R1_Incident__c>(
				[SELECT Id, R2_INC_TXT_MI_Incident_External_ID__c 
				FROM R1_Incident__c
				WHERE R2_INC_TXT_MI_Incident_External_ID__c IN: setIncExtId ]);

			// creamos mapa con external id y vuelo
			Map<String, R1_Flight__c> mapIdExtFlight = new Map<String, R1_Flight__c>();
			for(R1_Flight__c flight: mapFlights.values()){
				mapIdExtFlight.put(flight.R1_FLG_TXT_External_ID__c, flight);
			}

			// creamos mapa con external id e incidencia
			Map<String, R1_Incident__c> mapIdExtIncident = new Map<String, R1_Incident__c>();
			for(R1_Incident__c inc: mapIncidences.values()){
				mapIdExtIncident.put(inc.R2_INC_TXT_MI_Incident_External_ID__c, inc);				
			}

			// mapa para nuevas incidencias
			Map<String, R1_Incident__c> mapNewInc = new Map<String, R1_Incident__c>();

			// relacionamos vuelos, incidencian con los vouchers
			for(R2_Voucher__c voucher : newsVouchers){

				String tempExternalIdFlight = generateFligthExternalId(voucher);

				if(tempExternalIdFlight!=null && tempExternalIdFlight!=''){
					String delayType = getDelayType(voucher);

					// relacionamos vuelos
					R1_Flight__c vuelo = null;
					if(mapIdExtFlight.containsKey(tempExternalIdFlight)){
						vuelo = mapIdExtFlight.get(tempExternalIdFlight);
						voucher.R2_VOU_LOO_Flight__c = vuelo.Id;
					}

					// relacionamos incidencias
					if(delayType!=null && delayType!=''){
						Id idIncRT = getIdRtInc(voucher);

						if(mapIdExtIncident.containsKey(tempExternalIdFlight+delayType)){
							R1_Incident__c incident = mapIdExtIncident.get(tempExternalIdFlight+delayType);
							voucher.R2_VOU_LOO_Incidence__c = incident.Id;
						}else if(mapIdExtIncident.containsKey(tempExternalIdFlight+delayType+'1')){
							R1_Incident__c incident = mapIdExtIncident.get(tempExternalIdFlight+delayType+'1');
							voucher.R2_VOU_LOO_Incidence__c = incident.Id;
						}else if(mapIdExtIncident.containsKey(tempExternalIdFlight+delayType+'2')){
							R1_Incident__c incident = mapIdExtIncident.get(tempExternalIdFlight+delayType+'2');
							voucher.R2_VOU_LOO_Incidence__c = incident.Id;
						}else if(mapIdExtIncident.containsKey(tempExternalIdFlight+delayType+'3')){
							R1_Incident__c incident = mapIdExtIncident.get(tempExternalIdFlight+delayType+'3');
							voucher.R2_VOU_LOO_Incidence__c = incident.Id;
						}else if(idIncRT!=null){
							//Crear incidencia
							R1_Incident__c newInc = new R1_Incident__c();
							newInc.RecordTypeId = idIncRT;
							newInc.R1_INC_LOO_Client__c = voucher.R2_VOU_LOO_Client__c;
							if(vuelo!=null){
								newInc.R2_INC_LOO_Flight__c = vuelo.Id;
							}
							newInc.R2_INC_TXT_MI_Incident_External_ID__c = tempExternalIdFlight+delayType+'1';
							newInc.R2_INC_PKL_MI_Delay_Type__c = delayType;
							newInc.R2_INC_TXT_II_Depart_flight__c = voucher.R2_VOU_TXT_Origin__c;
							newInc.R2_INC_TXT_II_Arrival_flight__c = voucher.R2_VOU_TXT_Arrival__c;
							newInc.R2_INC_TXT_II_TKT__c = voucher.R2_VOU_TXT_Ticket_Num__c;
							newInc.R2_INC_TXT_II_Passenger_name__c = voucher.R2_VOU_TXT_Name__c;
							newInc.R2_INC_TXT_II_Passenger_lastname1__c = voucher.R2_VOU_TXT_Surname__c;
							newInc.R2_INC_TXT_II_Passenger_lastname2__c = voucher.R2_VOU_TXT_Second_Surname__c;
							newInc.R2_INC_DATH_II_Flight_date__c = voucher.R2_VOU_DAT_Flight_Date__c;
							mapNewInc.put(newInc.R2_INC_TXT_MI_Incident_External_ID__c, newInc);
						}
					}
				}

			}


			if(!mapNewInc.isEmpty()){
				try{
					System.debug('*** se van a insertar las nuevas incidencias');
					insert mapNewInc.values();
					List<R1_Incident__c> listInc = [SELECT Id, R2_INC_TXT_MI_Incident_External_ID__c 
													FROM R1_Incident__c 
													WHERE R2_INC_TXT_MI_Incident_External_ID__c IN:mapNewInc.keySet() ];
													
					for(R2_Voucher__c voucher: newsVouchers){
						String tempExternalIdFlight = generateFligthExternalId(voucher);
						String delayType = getDelayType(voucher);
						if( (tempExternalIdFlight!=null && tempExternalIdFlight!='') &&
							(delayType!=null && delayType!='') && 
							(voucher.R2_VOU_LOO_Incidence__c==null) ){
								String extIdIncTemp = tempExternalIdFlight+delayType;
								for(R1_Incident__c inc: listInc){
									if(extIdIncTemp == inc.R2_INC_TXT_MI_Incident_External_ID__c){
										voucher.R2_VOU_LOO_Incidence__c = inc.Id;
									}else if(extIdIncTemp+'1' == inc.R2_INC_TXT_MI_Incident_External_ID__c){
										voucher.R2_VOU_LOO_Incidence__c = inc.Id;
									}else if(extIdIncTemp+'2' == inc.R2_INC_TXT_MI_Incident_External_ID__c){
										voucher.R2_VOU_LOO_Incidence__c = inc.Id;
									}else if(extIdIncTemp+'3' == inc.R2_INC_TXT_MI_Incident_External_ID__c){
										voucher.R2_VOU_LOO_Incidence__c = inc.Id;
									}
								}
						}
					}
				}catch(Exception exc){
					System.debug('*** error al isertar nuevas incidencias');
					R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.relateVoucher()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
				}
				
			}
			
		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.relateVoucher()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
		}
	}

	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:   generate Fligth External Id (EJ: IB 4000 12162017 JFK )
		IN:
		OUT: String 

		History:
		<Date>                  <Author>                         <Change Description>
		18/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@TestVisible public static String generateFligthExternalId(R2_Voucher__c voucher){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
			String externalId = null;

			String origin = voucher.R2_VOU_TXT_Origin__c;
			String flightNumber = voucher.R2_VOU_TXT_Main_Flight_Number__c;
			Date flightDate = voucher.R2_VOU_DAT_Flight_Date__c;
			String company = voucher.R2_VOU_PKL_Marketing_Company__c;

			if( (origin!=null && flightNumber!=null && flightDate!=null && company!=null) &&
			  	(origin!='' && flightNumber!='' && company!='') ){

				externalId = '';

				// company
				externalId += company;
				// numero vuelo
				externalId += flightNumber.length() < 4 ? flightNumber.rightPad(4, '0') :  flightNumber;
				// fecha
				String datDay = flightDate.day() < 10 ? '0'+flightDate.day() : String.valueOf(flightDate.day());
				String datMonth = flightDate.month() < 10 ? '0'+flightDate.month() : String.valueOf(flightDate.month());
				String datYear = String.valueOf(flightDate.year());
				externalId += datMonth+datDay+datYear;

				// Origen
				externalId += origin;
			}

			return externalId;

		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.generateFligthExternalId()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
			return null;
		}
	}


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:   generate Fligth External Id (EJ: IB 4000 12162017 JFK )
		IN:
		OUT: String 

		History:
		<Date>                  <Author>                         <Change Description>
		18/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	// @TestVisible public static String generateIncidentExternalId(R2_Voucher__c voucher, String aux){
	// 	try{
	// 		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
	// 		String externalId = '';

	// 		String flightExtId = generateFligthExternalId(voucher);
	// 		String delayType = getDelayType(voucher);
	// 		String tempExternalIdInc = (flightExtId!=null && flightExtId!='') && (delayType!=null && delayType!='') ? flightExtId+delayType : null;
	// 		if(tempExternalIdInc!=null && tempExternalIdInc!=''){
	// 			String tempAux = aux!=null && aux!='' ? aux : '';
	// 			externalId = tempExternalIdInc+tempAux;
	// 		}
	// 		return externalId;
	// 	}catch(Exception exc){
	// 		R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.generateFligthExternalId()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
	// 		return '';
	// 	}
	// }


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN:
		OUT:

		History:
		<Date>                  <Author>                         <Change Description>
		11/01/2018             	Jaime Ascanta          			Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@TestVisible public static String getDelayType(R2_Voucher__c voucher){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

			String delayType = null;

			if(voucher != null && voucher.R2_VOU_TXT_Passenger_Reason__c!=null) {
				String rtDevNameVaucher = MAP_RT_ID.get(voucher.RecordTypeId);
				String vouTypeDelay = voucher.R2_VOU_TXT_Passenger_Reason__c;

					if(rtDevNameVaucher.equalsIgnoreCase('R2_RT_HTR')) {

						if(	vouTypeDelay.equalsIgnoreCase('CN') ) {
							delayType = 'CNL';

						}else if(vouTypeDelay.equalsIgnoreCase('DV')) {
							delayType = 'DIV';

						}else if(vouTypeDelay.equalsIgnoreCase('OV')) {
							delayType = 'DNB';

						}else if(vouTypeDelay.equalsIgnoreCase('DL')) {
							delayType = 'DEP';

						}else if(vouTypeDelay.equalsIgnoreCase('OT')) {
							delayType = 'OTB';

						}else{
							delayType = vouTypeDelay;
						}

					}else if(rtDevNameVaucher.equalsIgnoreCase('R2_RT_DNB')){

						if(	vouTypeDelay.equalsIgnoreCase('CNL') ||
							vouTypeDelay.equalsIgnoreCase('DNB') ||
							vouTypeDelay.equalsIgnoreCase('OTB') ||
							vouTypeDelay.equalsIgnoreCase('AVV') ||
							vouTypeDelay.equalsIgnoreCase('CVP') ||
							vouTypeDelay.equalsIgnoreCase('DNG') ||
							vouTypeDelay.equalsIgnoreCase('RPA')) {

							delayType = vouTypeDelay;

						}else{
							delayType = vouTypeDelay;
						}

					}
			}

			return delayType;

		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.getDelayType()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
			return null;
		}
	}


	/*---------------------------------------------------------------------------------------------------------------------
		Author:         Jaime Ascanta
		Company:        Accenture
		Description:
		IN: R2_Voucher__c
		OUT: Id (RT Incidence)

		History:
		<Date>                  <Author>                         <Change Description>
		21/12/2017             	Jaime Ascanta          						Initial Version
		----------------------------------------------------------------------------------------------------------------------*/
	@TestVisible public static Id getIdRtInc(R2_Voucher__c voucher){
		try{
			if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;

			Id idRTIndiv = MAP_RT_NAME.get('R2_Individual');
			Id idRTMasiv = MAP_RT_NAME.get('Masiva');

			Id idReturn = null;
			if(voucher != null && voucher.R2_VOU_TXT_Passenger_Reason__c!=null) {
				String rtDevNameVaucher = MAP_RT_ID.get(voucher.RecordTypeId);
				String vouTypeDelay = voucher.R2_VOU_TXT_Passenger_Reason__c;
					if(rtDevNameVaucher.equalsIgnoreCase('R2_RT_HTR')) {
						if( vouTypeDelay.equalsIgnoreCase('CN') ||
						 	vouTypeDelay.equalsIgnoreCase('DV') ||
							vouTypeDelay.equalsIgnoreCase('DL') ){

								idReturn = idRTMasiv;
						}
						else if(vouTypeDelay.equalsIgnoreCase('OV') ||
								vouTypeDelay.equalsIgnoreCase('DE') ||
								vouTypeDelay.equalsIgnoreCase('CI') ||
								vouTypeDelay.equalsIgnoreCase('TT') ||
								vouTypeDelay.equalsIgnoreCase('XC') ||
								vouTypeDelay.equalsIgnoreCase('ID') ||
								vouTypeDelay.equalsIgnoreCase('OT') ){

									idReturn = idRTIndiv;
						}

					}
					else if(rtDevNameVaucher.equalsIgnoreCase('R2_RT_DNB')){

						if(vouTypeDelay.equalsIgnoreCase('CNL')) {

							idReturn = idRTMasiv;
						}
						else if(vouTypeDelay.equalsIgnoreCase('DNB') ||
						 		vouTypeDelay.equalsIgnoreCase('OTB') ||
								vouTypeDelay.equalsIgnoreCase('AVV') ||
								vouTypeDelay.equalsIgnoreCase('CVP') ||
								vouTypeDelay.equalsIgnoreCase('DNG') ||
								vouTypeDelay.equalsIgnoreCase('RPA') ){
									
									idReturn = idRTIndiv;
						}
					}
			}

			return idReturn;

		}catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VoucherTriggerMethods.getIdRtInc()', '', exc.getmessage()+', '+exc.getLineNumber(), '');
			return null;
		}
	}


}