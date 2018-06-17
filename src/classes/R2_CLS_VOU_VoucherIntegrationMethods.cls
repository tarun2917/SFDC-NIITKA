public with sharing class R2_CLS_VOU_VoucherIntegrationMethods {
	public class wrpCancelDNB{
		public string petitioner;
		public string crmId;
		public string crmUserId;
		public string dnbVoucherNumber;
		public string passengerLastName;
		public string modifResiberUserID;
		public string modifResiberID;
		public string modifOfficeID;
		public string comments;
	}
	public class wrpCreateDNB{
		public string petitioner;
		public string crmId;
		public string crmUserId;
		public string passengerLastName;
		public string passengerFirstName;
		public string flightCompanyCode;
		public string numericFlightCompanyCode;
		public string flightNumber;
		public string flightDate;//DDMMYY
		public string flightSegmentDate; //DDMMYY
		public string reservedFlightClass;
		public string assignedFlightClass;
		public string flightOriginCountry;
		public string flightDestinationCountry;
		public string flightOriginAirport;
		public string flightDestinationAirport;
		public string ffcompanyCode;
		public string ffnumber;
		public string paymentCurrency;
		public string reason;
		public string pnr;
		public string passengerIdentifier;
		public string comments;
		public string budgetCenter;
		public string account;
		public string creationType;
		public string creationResiberUserID;
		public string creationResiberID;
		public string creationOfficeID;
		public Amounts amounts;
	}
	public class Amounts{
		List<Amount> amount = new List<Amount>();
	}
	public class Amount{
		public string paymentType;
		public string amount;
	}
	public class wrpUpdateDNB{
		public string petitioner;
		public string crmId;
		public string crmUserId;
		public string dnbVoucherNumber;
		public string passengerLastName;
		public string passengerFirstName;
		public string flightCompanyCode;
		public string flightNumber;
		public string flightOriginAirport;
		public string ffnumber;
		public string paymentCurrency;
		public string reason;
		public string pnr;
		public string passengerIdentifier;
		public string comments;
		public string budgetCenter;
		public string account;
	}
	public class wrpUpdateAmountDNB{
		public string petitioner;
		public string crmId;
		public string crmUserId;
		public string dnbVoucherNumber;
		public string passengerLastName;
		public string currencyChange;
		public string comments;
		public AmountsUpdate amounts;
	}
	public class AmountsUpdate{
		public List<AmountUpdate> amount = new List<AmountUpdate>();
	}
	public class AmountUpdate{
		public string paymentType;
		public string value;
	}
	public class wrpCancelOK{
		public string crmId;
	}

	public class wrpCreateOK{
		public List<Voucher> voucher;
		public string currencyChange;
		public string decimals;
		public string code;
		public string reason;
		public string timeStamp;
	}

	public class WrpResponse{
		public String crmId;
		public Voucher voucher;
	}

	public class Voucher{
		public string dnbVoucherNumber;
		public string creationDate; //DDMMYY
		public AmountsUpdate amounts;
	}
	public class wrpUpdateDNBOK{
		public string crmId;
		public VoucherUpdate voucher;
		public string code;
		public string reason;
		public string timeStamp;

	}
	public class VoucherUpdate{
		public string dnbVoucherNumber;
		public string modifiedDate; //DDMMYY
		public string modifiedTime;
		public string currencyChange;
		public string actionsCount;
		public string decimals;
	}
	public class wrpUpdateAmountDNBOK{
		public string crmId;
		public VoucherUpdate voucher;
		public string code;
		public string reason;
		public string timeStamp;

	}
	public class VoucherAmountUpdate{
		public string dnbVoucherNumber;
		public string modifiedDate; //DDMMYY
		public string modifiedTime;
		public List<AmountsUpdate> amounts;
		public string currencyChange;
		public string actionsCount;
		public string decimals;
	}



	@future(callout=true)
	public static void updateDNB (String id){
		try{
			List<R2_Voucher__c>lstVou = [SELECT Id,RecordTypeId,R2_VOU_PKL_Type__c,R2_VOU_TXT_Main_Flight_Number__c,
												R2_VOU_DIV_Amount_Value2_MCO__c,R2_VOU_DIV_Amount_Value_MCO__c,
												R2_VOU_DIV_Amount_Value2_Prepaid__c,R2_VOU_DIV_Amount_Value_Prepaid__c,
												R2_VOU_DIV_Amount_Value_Check__c,R2_VOU_DIV_Amount_Value2_Check__c,R2_VOU_DIV_Amount_Value2_Cash__c,
												R2_VOU_DIV_Amount_Value_Cash__c,R2_VOU_DIV_Amount_value_Avios__c,R2_VOU_DIV_Amount_value2_Avios__c,R2_VOU_TXT_OFC_Mod__c,
												R2_VOU_TXT_Voucher__c,R2_VOU_TXT_Account__c,R2_VOU_TXT_DNB_Budget__c,R2_VOU_PKL_Creation_Type__c,R2_VOU_TXT_Comments__c,
												R2_VOU_TXT_Passenger_FF__c,R2_VOU_TXT_Passenger_Reason__c,R2_VOU_PKL_Currency_Claimed__c,R2_VOU_TXT_CIA_ID__c,
												R2_VOU_TXT_CIA_FF__c,R2_VOU_TXT_Passenger_Airport_Arrival__c,R2_VOU_PKL_Country__c,R2_VOU_TXT_Passenger_Airport_Depart__c,
												R2_VOU_PKL_Arrival_Country__c,R2_VOU_DAT_Segment_Segment_Fight_Date__c,R2_VOU_DAT_Flight_Date__c,
												R2_VOU_TXT_Carrier_code_oper__c,R2_VOU_TXT_Name__c,R2_VOU_TXT_Surname__c,R2_VOU_TXT_Second_Surname__c,
												R2_VOU_TXT_AmadeusLocator__c,R2_VOU_TXT_ResiberLocator__c,R2_VOU_TXT_Origin__c,R2_VOU_TXT_Arrival__c 
											FROM R2_Voucher__c 
											WHERE id= :id ];
			System.debug(lstVou);
			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();
			Id recordTypeVou = lstVou[0].RecordTypeId;

			if(recordTypeDNB == recordTypeVou) {
				wrpUpdateDNBOK wrp = R2_CLS_VOU_VoucherIntegrationMethods.updateDNBInt(lstVou[0],0);
				System.debug('*** respuesta updateDNBInt() : ' + wrp );
			}
			else {

			}
		}
		catch(Exception exc){
			 R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt', '',exc.getMessage(), 'R2_Voucher__c');
		}
	}

	public static wrpUpdateDNBOK updateDNBInt (R2_Voucher__c vou, Integer intentos){
		try{
			wrpUpdateDNB wrp = new wrpUpdateDNB();
			
			wrp.petitioner = 'SIEBELEA66EF87E5DC424BAEF3B77D236B6B32'; //???
			wrp.crmId = makeCRMID(vou.id);
			wrp.crmUserId = UserInfo.getUserId();

			if(vou.R2_VOU_TXT_Voucher__c != null && vou.R2_VOU_TXT_Voucher__c != ''){
				wrp.dnbVoucherNumber = vou.R2_VOU_TXT_Voucher__c;
			}

			if((vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!='') && (vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c !='')){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c+' '+vou.R2_VOU_TXT_Second_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!= ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c != ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Second_Surname__c;
			}

			if(vou.R2_VOU_TXT_Name__c != null && vou.R2_VOU_TXT_Name__c !=null){
				wrp.passengerFirstName = vou.R2_VOU_TXT_Name__c;
			}
			
			if(vou.R2_VOU_TXT_Carrier_code_oper__c != null && vou.R2_VOU_TXT_Carrier_code_oper__c!=''){
				wrp.flightCompanyCode = vou.R2_VOU_TXT_Carrier_code_oper__c;
			}

			if(vou.R2_VOU_TXT_Main_Flight_Number__c != null && vou.R2_VOU_TXT_Main_Flight_Number__c != ''){
				wrp.flightNumber = vou.R2_VOU_TXT_Main_Flight_Number__c;
			}

			if(vou.R2_VOU_TXT_Origin__c!= null && vou.R2_VOU_TXT_Origin__c!= ''){
				wrp.flightOriginAirport = vou.R2_VOU_TXT_Origin__c;
			}

			if(vou.R2_VOU_TXT_Passenger_FF__c!= '' && vou.R2_VOU_TXT_Passenger_FF__c!= null){
				wrp.ffnumber = vou.R2_VOU_TXT_Passenger_FF__c; //???
			}
			else{
				wrp.ffnumber ='NOIBERIAPLUS' ;
			}

			if(vou.R2_VOU_PKL_Currency_Claimed__c != null && vou.R2_VOU_PKL_Currency_Claimed__c !=''){
				wrp.paymentCurrency = vou.R2_VOU_PKL_Currency_Claimed__c;
			}
			
			if(vou.R2_VOU_TXT_Passenger_Reason__c != null && vou.R2_VOU_TXT_Passenger_Reason__c!= ''){
				// wrp. = vou.R2_VOU_TXT_Passenger_Reason__c;
			}
			else{

			}
			if(vou.R2_VOU_PKL_Type__c != null && vou.R2_VOU_PKL_Type__c!= ''){
				wrp.reason = vou.R2_VOU_PKL_Type__c;
			}

			if(vou.R2_VOU_TXT_Comments__c != null && vou.R2_VOU_TXT_Comments__c != ''){
				wrp.comments = vou.R2_VOU_TXT_Comments__c;
			}

			if(vou.R2_VOU_TXT_DNB_Budget__c != null && vou.R2_VOU_TXT_DNB_Budget__c!=''){
				wrp.budgetCenter = vou.R2_VOU_TXT_DNB_Budget__c;
			}

			if(vou.R2_VOU_TXT_Account__c != null && vou.R2_VOU_TXT_Account__c != ''){
				wrp.account = vou.R2_VOU_TXT_Account__c;
			}




            string wsMethod = 'CreateUpdateDNB';
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
                    return updateDNBInt(vou,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBInt()', '','No se puede conectar', 'R2_Voucher__c');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
						req.setBody(JSON.serialize(wrp,true));

            system.debug(req);

            System.debug('*** request body:' + req.getBody() );

            Http http = new Http();

            HTTPResponse res;
            res = http.send(req);

            System.debug('*** response code: ' + res.getStatusCode());
						System.debug('*** response body: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){

								string respFormat = res.getBody();
        				string bodyFormat = respFormat.replaceAll('"currency":','"currencyChange":');
        				res.setBody(bodyFormat);
                wrpUpdateDNBOK resp = (wrpUpdateDNBOK)JSON.deserialize(res.getBody(),wrpUpdateDNBOK.class);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return updateDNBInt(vou,intentos);

                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBInt', '',res.getBody(), 'R2_Voucher__c');
            		return null;
                }
            }
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBInt', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
			return null;
		}
	}

	@future(callout=true)
	public static void createDNB (String id){

		try{

			System.debug('*** inicia createDNB()');

			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();
			List<R2_Voucher__c> lstVou = [SELECT Id,R2_VOU_LOO_Case__c, R2_VOU_LOO_Case__r.R2_CAS_NUM_MCO_Import__c, 
											R2_VOU_PKL_Service__c, R2_VOU_LOO_Case__r.OwnerId, RecordTypeId, 
											R2_VOU_PKL_Type__c,R2_VOU_TXT_IBConecta__c,R2_VOU_TXT_Main_Flight_Number__c, 
											R2_VOU_TXT_Passenger_Flight_Class__c,R2_VOU_TXT_Res_Class__c,
											R2_VOU_DIV_Amount_Value2_MCO__c,R2_VOU_DIV_Amount_Value_MCO__c,
											R2_VOU_DIV_Amount_Value2_Prepaid__c,R2_VOU_DIV_Amount_Value_Prepaid__c,
											R2_VOU_DIV_Amount_Value_Check__c,R2_VOU_DIV_Amount_Value2_Check__c,
											R2_VOU_DIV_Amount_Value2_Cash__c,R2_VOU_DIV_Amount_Value_Cash__c,
											R2_VOU_DIV_Amount_value_Avios__c,R2_VOU_DIV_Amount_value2_Avios__c,
											R2_VOU_TXT_OFC_Mod__c,R2_VOU_TXT_Voucher__c,R2_VOU_TXT_Account__c,R2_VOU_TXT_DNB_Budget__c,
											R2_VOU_PKL_Creation_Type__c,R2_VOU_TXT_Comments__c,R2_VOU_TXT_Passenger_FF__c,R2_VOU_TXT_Passenger_Reason__c,
											R2_VOU_PKL_Currency_Claimed__c,R2_VOU_TXT_CIA_ID__c,R2_VOU_TXT_CIA_FF__c,R2_VOU_TXT_Passenger_Airport_Arrival__c,
											R2_VOU_PKL_Country__c,R2_VOU_TXT_Passenger_Airport_Depart__c,R2_VOU_PKL_Arrival_Country__c,
											R2_VOU_DAT_Segment_Segment_Fight_Date__c,R2_VOU_DAT_Flight_Date__c,R2_VOU_TXT_Carrier_code_oper__c,
											R2_VOU_TXT_Name__c,R2_VOU_TXT_Surname__c,R2_VOU_TXT_Second_Surname__c, R2_VOU_TXT_ProfileId__c,
											R2_VOU_TXT_AmadeusLocator__c,R2_VOU_TXT_ResiberLocator__c,R2_VOU_TXT_Origin__c,R2_VOU_TXT_Arrival__c 
										FROM R2_Voucher__c 
										WHERE Id= :id AND RecordTypeId=: recordTypeDNB];

			if(!lstVou.isEmpty() ) {

				WrpResponse wrp = R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt(lstVou[0],0);

				if(wrp!=null){
					if( wrp.voucher != null && (wrp.voucher.dnbVoucherNumber != null && wrp.voucher.dnbVoucherNumber != '') ){

							System.debug('*** setea campos compos voucher');
							lstVou[0].R2_VOU_TXT_Voucher__c = wrp.voucher.dnbVoucherNumber;
							// lstVou[0].R2_VOU_PKL_Status__c = 'Creado';

							System.debug('*** id caso con vaoucher: ' + lstVou[0].R2_VOU_LOO_Case__c);

							if( lstVou[0].R2_VOU_TXT_IBConecta__c != null && lstVou[0].R2_VOU_TXT_IBConecta__c != '' ) {
								
								Id idOwner = lstVou[0].R2_VOU_LOO_Case__c!=null ? lstVou[0].R2_VOU_LOO_Case__r.OwnerId : null ;
								List<Group> groupList = [SELECT Id, DeveloperName FROM Group WHERE Id=:idOwner];
								String grouDevName = groupList.size()>0 ? groupList[0].DeveloperName : null;

								if( (grouDevName!=null && grouDevName=='R2_Proactive') &&
									(   (lstVou[0].R2_VOU_DIV_Amount_Value_MCO__c!=null && lstVou[0].R2_VOU_DIV_Amount_Value_MCO__c>0 ) ||
										(lstVou[0].R2_VOU_DIV_Amount_Value_Cash__c!=null && lstVou[0].R2_VOU_DIV_Amount_Value_Cash__c>0) ) ) {

										System.debug('*** llama integracion de notificacion sendDNBNumber() ');
										R2_CLS_DNBNumberNotification.WrpRespDNB ibconectRep = R2_CLS_DNBNumberNotification.sendDNBNumber(lstVou[0], 0);

										if(ibconectRep != null && (ibconectRep.status == 'SUCCESS' || ibconectRep.status == 'success' ) ) {
											// lstVou[0].R2_VOU_PKL_Status__c = 'Emitido';
										}
								}
							}

							System.debug('*** actualiza voucher');
							update lstVou;
					}
				}

			}
		}
		catch(Exception exc){
			 R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt', '',exc.getMessage(), 'R2_Voucher__c');
		}
	}

	public static WrpResponse createDNBInt (R2_Voucher__c vou, integer intentos){

		System.debug('*** inicia createDNBInt()');

		try{
			wrpCreateDNB wrp = new wrpCreateDNB();
			wrp.petitioner = 'SIEBELEA66EF87E5DC424BAEF3B77D236B6B32'; //???
			wrp.crmId = makeCRMID(vou.id);
			wrp.crmUserId = UserInfo.getUserId();

			if((vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!='') && (vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c !='')){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c+' '+vou.R2_VOU_TXT_Second_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!= ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c != ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Second_Surname__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Name__c != null && vou.R2_VOU_TXT_Name__c !=''){
				wrp.passengerFirstName = vou.R2_VOU_TXT_Name__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Carrier_code_oper__c != null && vou.R2_VOU_TXT_Carrier_code_oper__c != ''){
				wrp.flightCompanyCode = vou.R2_VOU_TXT_Carrier_code_oper__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_CIA_ID__c != null && vou.R2_VOU_TXT_CIA_ID__c != ''){
				wrp.numericFlightCompanyCode = vou.R2_VOU_TXT_CIA_ID__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Main_Flight_Number__c != null && vou.R2_VOU_TXT_Main_Flight_Number__c != ''){
				wrp.flightNumber = vou.R2_VOU_TXT_Main_Flight_Number__c;
			}
			else{

			}
			if(vou.R2_VOU_DAT_Flight_Date__c != null){
				String fechaVuelo = formatearFecha(vou.R2_VOU_DAT_Flight_Date__c);
				wrp.flightDate = fechaVuelo; //DDMMYY
			}
			else{

			}
			if(vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c != null){
			String fechaSegmneto = formatearFecha(vou.R2_VOU_DAT_Segment_Segment_Fight_Date__c);
			wrp.flightSegmentDate = fechaSegmneto; //DDMMYY
			}
			else{

			}
			if(vou.R2_VOU_TXT_Res_Class__c != null && vou.R2_VOU_TXT_Res_Class__c !=''){
				wrp.reservedFlightClass = vou.R2_VOU_TXT_Res_Class__c;//???
			}
			else{

			}
			if(vou.R2_VOU_TXT_Passenger_Flight_Class__c != null && vou.R2_VOU_TXT_Passenger_Flight_Class__c != ''){
				wrp.assignedFlightClass = vou.R2_VOU_TXT_Passenger_Flight_Class__c;//???
			}
			else{

			}

			if(vou.R2_VOU_PKL_Country__c != null && vou.R2_VOU_PKL_Country__c !=''){
				wrp.flightOriginCountry = vou.R2_VOU_PKL_Country__c;
			}
			else{

			}
			if(vou.R2_VOU_PKL_Arrival_Country__c != null && vou.R2_VOU_PKL_Arrival_Country__c != ''){
				wrp.flightDestinationCountry = vou.R2_VOU_PKL_Arrival_Country__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Passenger_Airport_Depart__c != null && vou.R2_VOU_TXT_Passenger_Airport_Depart__c !=''){
				// wrp.  = vou.R2_VOU_TXT_Passenger_Airport_Depart__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Origin__c != null && vou.R2_VOU_TXT_Origin__c !=''){
				wrp.flightOriginAirport = vou.R2_VOU_TXT_Origin__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Passenger_Airport_Arrival__c != null && vou.R2_VOU_TXT_Passenger_Airport_Arrival__c!=''){
				// wrp. = vou.R2_VOU_TXT_Passenger_Airport_Arrival__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Arrival__c != null && vou.R2_VOU_TXT_Arrival__c!=''){
				wrp.flightDestinationAirport = vou.R2_VOU_TXT_Arrival__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_CIA_FF__c !=null && vou.R2_VOU_TXT_CIA_FF__c != ''){
				wrp.ffcompanyCode = vou.R2_VOU_TXT_CIA_FF__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Passenger_FF__c!= '' && vou.R2_VOU_TXT_Passenger_FF__c!= null){
				wrp.ffnumber = vou.R2_VOU_TXT_Passenger_FF__c; //???
			}
			else{
				wrp.ffnumber ='NOIBERIAPLUS' ;
			}
			if(vou.R2_VOU_PKL_Currency_Claimed__c != null && vou.R2_VOU_PKL_Currency_Claimed__c != ''){
				wrp.paymentCurrency = vou.R2_VOU_PKL_Currency_Claimed__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Passenger_Reason__c != null && vou.R2_VOU_TXT_Passenger_Reason__c !=''){
				//wrp. = vou.R2_VOU_TXT_Passenger_Reason__c;
			}
			else{

			}
			if(vou.R2_VOU_PKL_Type__c != null && vou.R2_VOU_PKL_Type__c !=''){

				wrp.reason = vou.R2_VOU_PKL_Type__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Comments__c != null && vou.R2_VOU_TXT_Comments__c != ''){
				wrp.comments = vou.R2_VOU_TXT_Comments__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_DNB_Budget__c != null && vou.R2_VOU_TXT_DNB_Budget__c != ''){
				wrp.budgetCenter = vou.R2_VOU_TXT_DNB_Budget__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Account__c != null && vou.R2_VOU_TXT_Account__c!=''){
				wrp.account = vou.R2_VOU_TXT_Account__c;
			}
			else{

			}
			if(vou.R2_VOU_PKL_Creation_Type__c != null && vou.R2_VOU_PKL_Creation_Type__c !=''){
				wrp.creationType = vou.R2_VOU_PKL_Creation_Type__c;
			}
			else{

			}

			wrp.creationResiberUserID = '0'; //???
			wrp.creationResiberID = '0'; //???
			wrp.creationOfficeID = 'CRM000';
			Amounts wrpAmounts = new Amounts();

			if(vou.R2_VOU_DIV_Amount_value2_Avios__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'P';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_value2_Avios__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_value_Avios__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'P';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_value_Avios__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Cash__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'C';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value2_Cash__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Cash__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'C';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value_Cash__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Check__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'Q';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value2_Check__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Check__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'Q';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value_Check__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_MCO__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'M';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value2_MCO__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_MCO__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'M';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value_MCO__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Prepaid__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'T';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value_Prepaid__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Prepaid__c != null){
				Amount wrpAmount = new Amount();
				wrpAmount.paymentType = 'T';
				wrpAmount.amount = ''+vou.R2_VOU_DIV_Amount_Value2_Prepaid__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			wrp.amounts = wrpAmounts;


            string wsMethod = 'CreateUpdateDNB';
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
                    return createDNBInt(vou,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt', '','No se puede conectar', 'R2_Voucher__c');
                    return null;
                }
            }

						String bodyRequest = JSON.serialize(wrp, true);

            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            req.setTimeout(15000);
            req.setBody(bodyRequest);

            System.debug(req);

						System.debug('*** request body:' + req.getBody() );

            Http http = new Http();

            HTTPResponse res;
            res = http.send(req);

						System.debug('*** status code : ' + res.getStatusCode() );
						System.debug('*** body response: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
								string respFormat = res.getBody();
        				string bodyFormat = respFormat.replaceAll('"currency":','"currencyChange":');
        				res.setBody(bodyFormat);
                WrpResponse resp = (WrpResponse) JSON.deserialize(res.getBody(), WrpResponse.class);

                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return createDNBInt(vou,intentos);

                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt', '',res.getBody(), 'R2_Voucher__c');
            		return null;
                }
            }
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.createDNBInt', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
			return null;
		}
	}

	@future(callout=true)
	public static void updateDNBAmount (String id){
		try{
			List<R2_Voucher__c>lstVou = [SELECT Id,RecordTypeId,R2_VOU_TXT_Main_Flight_Number__c,R2_VOU_DIV_Amount_Value2_MCO__c,
												R2_VOU_DIV_Amount_Value_MCO__c,R2_VOU_DIV_Amount_Value2_Cash__c,
												R2_VOU_DIV_Amount_Value_Cash__c,R2_VOU_DIV_Amount_Value2_Prepaid__c,
												R2_VOU_DIV_Amount_Value_Prepaid__c,R2_VOU_DIV_Amount_Value2_Check__c,
												R2_VOU_DIV_Amount_Value_Check__c,R2_VOU_DIV_Amount_value_Avios__c,
												R2_VOU_DIV_Amount_value2_Avios__c,R2_VOU_TXT_OFC_Mod__c,R2_VOU_TXT_Voucher__c,
												R2_VOU_TXT_Account__c,R2_VOU_TXT_DNB_Budget__c,R2_VOU_PKL_Creation_Type__c,
												R2_VOU_TXT_Comments__c,R2_VOU_TXT_Passenger_FF__c,R2_VOU_TXT_Passenger_Reason__c,
												R2_VOU_PKL_Currency_Claimed__c,R2_VOU_TXT_CIA_ID__c,R2_VOU_TXT_CIA_FF__c,
												R2_VOU_TXT_Passenger_Airport_Arrival__c,R2_VOU_PKL_Country__c,
												R2_VOU_TXT_Passenger_Airport_Depart__c,	R2_VOU_PKL_Arrival_Country__c,
												R2_VOU_DAT_Segment_Segment_Fight_Date__c,R2_VOU_DAT_Flight_Date__c,
												R2_VOU_TXT_Carrier_code_oper__c,R2_VOU_TXT_Name__c,R2_VOU_TXT_Surname__c,
												R2_VOU_TXT_Second_Surname__c, R2_VOU_TXT_AmadeusLocator__c,R2_VOU_TXT_ResiberLocator__c 
										FROM R2_Voucher__c 
										WHERE Id= :id ];
			System.debug(lstVou);
			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();
			Id recordTypeVou = lstVou[0].RecordTypeId;

			if(recordTypeDNB == recordTypeVou) {
				wrpUpdateAmountDNBOK wrp = R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmountInt(lstVou[0],0);
				System.debug('*** wrpUpdateAmountDNBOK: ' + wrp);
			}
			else {

			}
		}
		catch(Exception exc){
			 R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmount', '',exc.getMessage(), 'R2_Voucher__c');
		}
	}

	public static wrpUpdateAmountDNBOK updateDNBAmountInt (R2_Voucher__c vou, integer intentos){
		try{

			System.debug('*** entra en updateDNBAmountInt : ');

			wrpUpdateAmountDNB wrp = new wrpUpdateAmountDNB();
			wrp.petitioner = 'SIEBELEA66EF87E5DC424BAEF3B77D236B6B32'; //???
			wrp.crmId = makeCRMID(vou.id);
			wrp.crmUserId = UserInfo.getUserId();
			if(vou.R2_VOU_TXT_Voucher__c != null && vou.R2_VOU_TXT_Voucher__c !=''){
				wrp.dnbVoucherNumber = vou.R2_VOU_TXT_Voucher__c;
			}
			
			if((vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!='') && (vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c !='')){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c+' '+vou.R2_VOU_TXT_Second_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!= ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c != ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Second_Surname__c;
			}
			else{

			}
			if(vou.R2_VOU_PKL_Currency_Claimed__c != null && vou.R2_VOU_PKL_Currency_Claimed__c!= ''){
				wrp.currencyChange = vou.R2_VOU_PKL_Currency_Claimed__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Comments__c != null && vou.R2_VOU_TXT_Comments__c != ''){
				wrp.comments = vou.R2_VOU_TXT_Comments__c;
			}
			else{

			}

			AmountsUpdate wrpAmounts = new AmountsUpdate();

			if(vou.R2_VOU_DIV_Amount_value2_Avios__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'P';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_value2_Avios__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_value_Avios__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'P';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_value_Avios__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Cash__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'C';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value2_Cash__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Cash__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'C';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value_Cash__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Check__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'Q';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value2_Check__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Check__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'Q';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value_Check__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_MCO__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'M';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value2_MCO__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_MCO__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'M';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value_MCO__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value_Prepaid__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'T';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value_Prepaid__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			if(vou.R2_VOU_DIV_Amount_Value2_Prepaid__c != null){
				AmountUpdate wrpAmount = new AmountUpdate();
				wrpAmount.paymentType = 'T';
				wrpAmount.value = ''+vou.R2_VOU_DIV_Amount_Value2_Prepaid__c;
				wrpAmounts.amount.add(wrpAmount);
			}
			wrp.amounts = wrpAmounts;

            string wsMethod = 'UpdateDNBAmount';
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
                    return updateDNBAmountInt(vou,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmountInt', '','No se puede conectar', 'R2_Voucher__c');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('PUT');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
            system.debug(req);
            String body = JSON.serialize(wrp,true);

        		body = body.replaceAll('"currencyChange":','"currency":');
            req.setBody(body);

						System.debug('*** request body: ' + req.getBody());

            Http http = new Http();

            HTTPResponse res;
            res = http.send(req);

            System.debug('*** response code: ' + res.getStatusCode());
						System.debug('*** response body: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
								string respFormat = res.getBody();
        				string bodyFormat = respFormat.replaceAll('"currency":','"currencyChange":');
        				res.setBody(bodyFormat);
                wrpUpdateAmountDNBOK resp = (wrpUpdateAmountDNBOK)JSON.deserialize(res.getBody(),wrpUpdateAmountDNBOK.class);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return updateDNBAmountInt(vou,intentos);

                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmountInt', '',res.getBody(), 'R2_Voucher__c');
            		return null;
                }
            }
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmountInt', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
			return null;
		}
	}

	@future(callout=true)
	public static void cancelDNB (String id){
		try{
			List<R2_Voucher__c>lstVou = [SELECT id,RecordTypeId,R2_VOU_TXT_Main_Flight_Number__c,R2_VOU_DIV_Amount_Value2_MCO__c,R2_VOU_DIV_Amount_Value_MCO__c,R2_VOU_DIV_Amount_Value2_Prepaid__c,R2_VOU_DIV_Amount_Value_Prepaid__c,R2_VOU_DIV_Amount_Value_Check__c,R2_VOU_DIV_Amount_Value2_Check__c,R2_VOU_DIV_Amount_Value2_Cash__c,R2_VOU_DIV_Amount_Value_Cash__c,R2_VOU_DIV_Amount_value_Avios__c,R2_VOU_DIV_Amount_value2_Avios__c,R2_VOU_TXT_OFC_Mod__c,R2_VOU_TXT_Voucher__c,R2_VOU_TXT_Account__c,R2_VOU_TXT_DNB_Budget__c,R2_VOU_PKL_Creation_Type__c,R2_VOU_TXT_Comments__c,R2_VOU_TXT_Passenger_FF__c,R2_VOU_TXT_Passenger_Reason__c,R2_VOU_PKL_Currency_Claimed__c,R2_VOU_TXT_CIA_ID__c,R2_VOU_TXT_CIA_FF__c,R2_VOU_TXT_Passenger_Airport_Arrival__c,R2_VOU_PKL_Country__c,R2_VOU_TXT_Passenger_Airport_Depart__c,	R2_VOU_PKL_Arrival_Country__c,R2_VOU_DAT_Segment_Segment_Fight_Date__c,R2_VOU_DAT_Flight_Date__c,R2_VOU_TXT_Carrier_code_oper__c,R2_VOU_TXT_Name__c,R2_VOU_TXT_Surname__c,R2_VOU_TXT_Second_Surname__c,R2_VOU_TXT_AmadeusLocator__c,R2_VOU_TXT_ResiberLocator__c from R2_Voucher__c where id= :id ];
			System.debug(lstVou);
			Id recordTypeDNB = Schema.SObjectType.R2_Voucher__c.getRecordTypeInfosByName().get('EBono').getRecordTypeId();
			Id recordTypeVou = lstVou[0].RecordTypeId;

			if(recordTypeDNB == recordTypeVou) {
			wrpCancelOK wrp = R2_CLS_VOU_VoucherIntegrationMethods.cancelDNBInt(lstVou[0],0);

			}
			else {

			}
		}
		catch(Exception exc){
			 R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.cancelDNB', '',exc.getMessage(), 'R2_Voucher__c');
		}
	}

	public static wrpCancelOK cancelDNBInt (R2_Voucher__c vou, integer intentos){
		try{
			wrpCancelDNB wrp = new wrpCancelDNB();
			wrp.petitioner = 'SIEBELEA66EF87E5DC424BAEF3B77D236B6B32'; //???
			wrp.crmId = makeCRMID(vou.id);
			wrp.crmUserId = UserInfo.getUserId();
			System.debug(vou);
			wrp.dnbVoucherNumber = vou.R2_VOU_TXT_Voucher__c;
			if((vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!='') && (vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c !='')){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c+' '+vou.R2_VOU_TXT_Second_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Surname__c != null && vou.R2_VOU_TXT_Surname__c!= ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Surname__c;
			}
			else if(vou.R2_VOU_TXT_Second_Surname__c != null && vou.R2_VOU_TXT_Second_Surname__c != ''){
				wrp.passengerLastName = vou.R2_VOU_TXT_Second_Surname__c;
			}
			else{

			}
			if(vou.R2_VOU_TXT_Comments__c != null && vou.R2_VOU_TXT_Comments__c != ''){
				wrp.comments = vou.R2_VOU_TXT_Comments__c;
			}
			else{

			}
			wrp.modifResiberUserID = '0'; //???
			wrp.modifResiberId = '0'; //???
			wrp.modifOfficeID = 'CRM000';

            string wsMethod = 'CancelDNB';
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
                    return cancelDNBInt(vou,intentos);
                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.cancelDNBInt', '','No se puede conectar', 'R2_Voucher__c');
                    return null;
                }
            }
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setMethod('POST');
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            //req.setBody(JSON.serialize(envio));
            req.setTimeout(15000);
            req.setBody(JSON.serialize(wrp,true));

						system.debug(req);

						System.debug('*** reques body: ' + req.getBody());

            Http http = new Http();

            HTTPResponse res;
            System.debug(req.getBody());
            res = http.send(req);

            System.debug('*** response code: ' + res.getStatusCode());
						System.debug('*** response body: ' + res.getBody());

            if(res.getStatusCode() == 200 || res.getStatusCode() == 201  || res.getStatusCode() == 202 || res.getStatusCode() == 203){
               	string respFormat = res.getBody();
        				string bodyFormat = respFormat.replaceAll('"currency":','"currencyChange":');
        				res.setBody(bodyFormat);
                wrpCancelOK resp = (wrpCancelOK)JSON.deserialize(res.getBody(),wrpCancelOK.class);
                return resp;
            }else {
                if(intentos<3 && res.getStatusCode() == 401){
                    intentos+=1;
                    R1_CLS_SendCustomerMDM.login();
                    return cancelDNBInt(vou,intentos);

                }else{
                    R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.cancelDNBInt', '',res.getBody(), 'R2_Voucher__c');
            		return null;
                }
            }
		}
		catch(Exception exc){
			R1_CLS_LogHelper.generateErrorLog('R2_CLS_VOU_VoucherIntegrationMethods.cancelDNBInt', '', exc.getmessage()+', '+exc.getLineNumber(), 'R2_Voucher__c');
			return null;
		}
	}

	public static String makeCRMID(String myId){
		
		if(myId==null || myId=='') return null;

		string crmFake = myId;
		crmFake = crmFake.substring(0, 10);
		return crmFake;
		
	}

	public static String formatearFecha(Date fecha){
		System.debug('Entro en formatear');
		string dia;
		if(fecha.day()<10){
            dia= '0'+ String.valueOf(fecha.day());
        }else{
            dia= String.valueOf(fecha.day());
        }
        string mes;
        if(fecha.month()==1){
        	mes = 'JAN';
        }
        else if(fecha.month()==2){
        	mes = 'FEB';
        }
        else if(fecha.month()==3){
        	mes = 'MAR';
        }
        else if(fecha.month()==4){
        	mes = 'APR';
        }
        else if(fecha.month()==5){
        	mes = 'MAY';
        }
        else if(fecha.month()==6){
        	mes = 'JUN';
        }
        else if(fecha.month()==7){
        	mes = 'JUL';
        }
        else if(fecha.month()==8){
        	mes = 'AUG';
        }
        else if(fecha.month()==9){
        	mes = 'SEP';
        }
        else if(fecha.month()==10){
        	mes = 'OCT';
        }
        else if(fecha.month()==11){
        	mes = 'NOV';
        }
        else if(fecha.month()==12){
        	mes = 'DEC';
        }

        string ano = String.valueOf(fecha.year()).subString(2,4);
        System.debug(dia+mes+ano);
        return dia+mes+ano;

	}
}