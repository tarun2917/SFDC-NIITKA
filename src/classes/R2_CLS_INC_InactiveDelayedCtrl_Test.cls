@isTest
public with sharing class R2_CLS_INC_InactiveDelayedCtrl_Test {
	
	public static R2_Baggage__c completarMaleta(R2_Baggage__c bag){
		bag.R2_BAG_PKL_Type__c = '22D';
		bag.R2_BAG_PKL_Colour__c = 'WT';
		bag.R2_BAG_CHK_Metal__c = True;
		bag.R2_BAG_CHK_Retractable_handle__c =  True;
		bag.R2_BAG_CHK_Combination_lock__c =  True;
		bag.R2_BAG_CHK_Wheels_or_bearing__c =  True;
		bag.R2_BAG_CHK_Single_object_in_box__c =  True;
		bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
		bag.R2_BAG_CHK_Safety_belt__c =  True;
		bag.R2_BAG_TXT_Ticket_number__c ='uyehrjat';
		bag.R2_BAG_TXT_Brand_Info__c = 'Test';
		bag.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_OF__c = 'A';
		bag.R2_BAG_TXT_OD__c = 'A';
		bag.R2_BAG_TXT_UP__c = 'A';
		bag.R2_BAG_TXT_UnableToDeliver__c = 'A';
		bag.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Lock_Code__c ='5673';
		bag.R2_BAG_TXT_UniqueID__c ='56789';
		bag.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
		bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
		bag.R2_BAG_TXT_Storage_Location__c = 'Test';
		bag.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
		bag.R2_BAG_TXT_Comments__c = ' Test'; 
		return bag;
	}


	public static void completarInc(R2_CLS_INC_InactiveDelayedController createPir){
    	R1_CLS_LogHelper.throw_exception = false;  
		String objectName  = 'R1_Incident__c';

		createPir.incidentInformationSection1 = createPir.getIncidentInformation('1');
		createPir.incidentInformationSection2 = createPir.getIncidentInformation('2');
		createPir.incidentInformationSection3 = createPir.getIncidentInformation('3');
		createPir.incidentInformationSection4 = createPir.getIncidentInformation('4');
		createPir.incidentInformationSection5 = createPir.getIncidentInformation('5');
		createPir.incidentInformationSection6 = createPir.getIncidentInformation('6');
		createPir.incidentInformationSection7 = createPir.getIncidentInformation('7');
		createPir.incidentInformationSection8 = createPir.getIncidentInformation('8');
		createPir.incidentInformationSection9 = createPir.getIncidentInformation('9');
		createPir.incidentInformationSection10 = createPir.getIncidentInformation('10');
		System.debug('Lista de campos '+ createPir.incidentInformationSection1);
		for (R2_CLS_INC_InactiveDelayedController.Field field : createPir.incidentInformationSection1) {
			if (field.name == 'R2_INC_TXT_PIR_Responsible_Scale__c') {
				field.value ='MAD';
				}
            else if (field.name == 'R2_INC_TXT_PIR_Stop_and_Operator_MS__c') {
				field.value = 'MADIB';
			}
			else if (field.name == 'R2_INC_DAT_PIR_Claims_Created_Date__c') {
				field.value = '2018-01-12';
				}
            else if (field.name == 'R2_INC_TXT_PIR_Others_PIR_Associated_XR__c') {
                field.value = 'AHL MADIB76831/DPR MADIB12345/OHD MADIB76587';
            }
			// else if (field.name == 'R2_INC_FOR_PIR_AR__c') {
			// 	// TODO WIP
			// } NOT NECESSARY
            //duplicado con R2_INC_DAT_PIR_Claim_Date__c ???
			//else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
			//	if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
			//	if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
			//	//requestWR.claim.claimData.claimDate = parseDate(field.value);
   //             requestWR.claim.claimData.claimDate = field.value;
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Last_mapping_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_LOO_Case__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Search_start_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_PIR_DAT_PIR_Full_reintegration_date__c') {
			//	// TODO WIP
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Control_office__c') {
				field.value ='Test';
				// TODO WIP
			}
			else if (field.name == 'R2_INC_NUM_PIR_Associated_Cases__c') {
				field.value = 'Test';
				// TODO WIP
			}
			//else if (field.name == 'R2_INC_DAT_PIR_Cancellation_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Date_back_primary_search__c') {
			//	// TODO WIP
			//}
			else if (field.name == 'R2_INC_DAT_PIR_Control_date__c') {
				field.value = '2018-01-12';
			}
			//else if (field.name == 'RecordTypeId') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DAT_PIR_Unsuccessful_search__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_DATH_PIR_Incidence_closed_date__c') {
			//	// TODO WIP
			//}
			//else if (field.name == 'R2_INC_TXT_PIR_Agent__c') {
			//	// TODO WIP
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Report_PIR__c') {
				field.value = 'Test';
				// TODO WIP
			}
			else if (field.name == 'R2_INC_TXT_PIR_VIP_Account__c') {
				field.value = 'Test';
				// TODO WIP
			}
			//else if (field.name == 'R2_INC_PKL_PIR_Status_incidence__c') {
			//	// TODO WIP
			//}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection2) {
			if (field.name == 'R2_INC_TXT_PIR_Name__c') {
					field.value ='Test';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name__c') {
					field.value = 'Test';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Last_name2__c') {
					field.value = 'Test';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Treatment__c') {
					field.value = 'Sr';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Initial__c') {
					field.value = 'T';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Initial2__c') {
					field.value = 'T';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Initial3__c') {
					field.value = 'T';
				}
			else if (field.name == 'R2_INC_EMA_PIR_Email1__c') {
					field.value = 'test@test.com';
				}
			else if (field.name == 'R2_INC_EMA_PIR_Email2__c') {
					field.value = 'test2@test.com';
				}
			else if (field.name == 'R2_INC_TXT_PIR_FF_Identificator__c') {
                	field.value ='test7893';
                }
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_language__c') {
					field.value ='ES';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Ticket_number__c') {
					field.value ='321321';
				}
			else if (field.name == 'R2_INC_TXT_PIR_PNR_locator__c') {
					field.value = '321312';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Passenger_category__c') {
					field.value = 'Test';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_address1__c') {
					field.value = 'CASA TORTUGA';
				}
			//else if (field.name == 'R2_INC_TXT_PIR_Delivery_address2__c') {
			//	// R2_WT_Wrappers_Create_Delayed.AddressLine addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine();
			//	// addressLine.addressLineDesc = field.value;
			//	// addressLine.seq = ''+2;
			//	if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
			//	if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
			//	requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Delivery_local_informatio__c') {
					field.value = 'ASAP';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Deliver_local_informatio2__c') {
					field.value = 'ASAP';
				}
			else if (field.name == 'R2_INC_PKL_PIR_Send_SMS_email__c') {
					field.value = 'NO_MESAGGE (N)';
				}
			else if(field.name == 'R2_INC_TXT_PIR_Send_SMS_email__c'){
				field.value = 'Test';
			}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection3) {
			if (field.name == 'R2_INC_TXT_PIR_Permanent_address1__c') {
					field.value ='Test';
				}
			else if (field.name == 'R2_INC_TLF_Landline1__c') {
					field.value = '23412342321';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_address1__c') {
					field.value = 'Test';
				}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone__c') {
					field.value = '23412342321';
				}
			//else if (field.name == 'R2_INC_TXT_PIR_Permanent_address2__c') {
			//}
			else if (field.name == 'R2_INC_TLF_Landline2__c') {
					field.value = '23412342321';
				}
			//else if (field.name == 'R2_INC_TXT_PIR_Temporal_address2__c') {
			//	// R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea = new R2_WT_Wrappers_Create_Delayed.AddressLine();
			//	// direccionLinea.addressLineDesc = field.value;
			//	// direccionLinea.seq = ''+2;
			//	if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
			//	if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.contactInfo(); }
			//	if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.temporaryAddress(); }
			//	if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
			//	requestWR.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;
			//}
			else if (field.name == 'R2_INC_TLF_PIR_Temporal_phone2__c') {
					field.value = '23412342321';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Zip_code__c') {
					field.value = '12121';
				}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number1__c') {
					field.value = '12121';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Temporal_Zip_Code__c') {
					field.value = '12121';
				}
			else if (field.name == 'R2_INC_TLF_PIR_Mobile_phone_number2__c') {
					field.value ='3456789098765';
				}
			//else if(field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c'){
			//	field.value = '2018-02-12';
			//}
			 //else if (field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c') {
			 //	List<String> auxLst = field.value.split('/');
    //            //creando formato de fecha de salesforce (yyyy-mm-dd)
    //            String dateStr;
    //            //creando formato de fecha EEUU (mm-dd-yyyy)
    //            if (UserInfo.getLocale() == 'en_US') {
    //                dateStr = auxLst[2] + '-' + auxLst[0] + '-' + auxLst[1];
    //            }
    //            else {
    //                //creando formato de fecha resto mundo (dd-mm-yyyy)
    //                dateStr = auxLst[2] + '-' + auxLst[1] + '-' + auxLst[0];
    //            }
			 //	if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
			 //	if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
			 //	if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
			 //	requestWR.passengers.contactInfo.temporaryAddress.validityDate = dateStr;
			 //} //FIXME echarle un ojo
		}


		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection4) {
			if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
					field.value = 'IB5433/31DEC';
			} else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
				field.value = 'IB5433/31DEC';
			} else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
				field.value = 'MAD/JFK';
            }
					
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection5) {
			if (field.name == 'R2_INC_TXT_PIR_Send_direction_FI__c') {
				field.value ='CASA DE KARIN';
			}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information1__c') {
				field.value  = 'Test';
				}
			else if (field.name == 'R2_INC_TXT_PIR_Control_information2__c') {
				field.value = 'KINTON';
				}
			else if (field.name == 'R2_INC_PKL_PIR_Copy_for_the_company_HC__c') {
				field.value = 'KINTON';
			}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection6) {
			if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
				field.value = 'Test';	
			}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection7) {
			if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_piece__c') {
				field.value = '1';	
			}
			else if (field.name == 'R2_INC_TXT_Last_Seen__c') {
				field.value = 'Test';	
			}
			else if (field.name == 'R2_INC_TXT_PIR_Weight_lost_parts__c') {
				field.value = 'Test';
			}
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_Weight_delivered__c') {
				field.value = 'Test';	
			}
			else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase1__c') {
				field.value = 'CASA EN BOSQUE';	
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
			//	// Solo deja rellenar una direccion de maleta
			//}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase1__c') {
				field.value = '45678998765';	
			}
			else if (field.name == 'R2_INC_TLF_PIR_Phone_number_suitcase2__c') {
				field.value = '87654345678';	
			}
			else if (field.name == 'R2_INC_TXT_Excess_Baggage__c') {
				field.value = 'Test';	
			}
			else if (field.name == 'R2_INC_CHK_PIR_Limited_approval_label__c') {
				field.value ='Test';	
			}
			else if (field.name == 'R2_ADI_ATXTL_DS_Delivery_service__c') {
				field.value = 'Test';
			}
			else if (field.name == 'R2_INC_TXT_PIR_Baggage_destination__c') {
				field.value = 'Test/Test';
			}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection8) {
			
			if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
				field.value = 'True';
			}
			//else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
			//	field.value = 'Test';	
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
				field.value = 'Test';
				// if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				// if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				// requestWR.claim.claimData. = field.value ;
				// FIXME no encontrado
			}
			//else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
			//	if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
			//	if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
			//	requestWR.claim.claimData.replacementBagIndicator = field.value ;
			//	// FIXME no mapeado!
			//}
			else if (field.name == 'R2_INC_TXT_PIR_Lost_reason_causes__c') {
				field.value = 'Test';	
			}
			else if (field.name == 'R2_INC_TXT_PIR_Washing_kit__c') {
				field.value = 'Test M/Test F';	
			}
			//else if (field.name == 'R2_INC_TXT_PIR_DO_Flight__c') { // resp.claim.claimData.
				// if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
				// if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
				// requestWR.claim.claimData. = field.value ;
				// FIXME no encontrado
			//}
			else if (field.name == 'R2_ADI_TXT_CR_Remarks_Cost__c') { // resp.claim.claimData.
				field.value = 'Test';
			}
		}
		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection9) {
			if (field.name == 'R2_ADI_ATXTL_MR_Match__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
				field.value = 'Test';	
			}
		}

		for (R2_CLS_INC_InactiveDelayedController.Field field :createPir.incidentInformationSection10) {
			if (field.name == 'R2_ADI_ATXTL_MG_Message__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
				field.value = 'Test';	
			}
		}


		System.debug('Lista de campos '+ createPir.incidentInformationSection1);
		System.debug('Lista de campos '+ createPir.incidentInformationSection2);
		System.debug('Lista de campos '+ createPir.incidentInformationSection3);
		System.debug('Lista de campos '+ createPir.incidentInformationSection4);

    }

	static testMethod void utilities_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();

		bag.R2_BAG_PKL_Type__c = '22D';
		bag.R2_BAG_PKL_Colour__c = 'WT';
		bag.R2_BAG_CHK_Metal__c = True;
		bag.R2_BAG_CHK_Retractable_handle__c =  True;
		bag.R2_BAG_CHK_Combination_lock__c =  True;
		bag.R2_BAG_CHK_Wheels_or_bearing__c =  True;
		bag.R2_BAG_CHK_Single_object_in_box__c =  True;
		bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
		bag.R2_BAG_CHK_Safety_belt__c =  True;
		bag.R2_BAG_TXT_Ticket_number__c ='uyehrjat';
		bag.R2_BAG_TXT_Brand_Info__c = 'Test';
		bag.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_OF__c = 'A';
		bag.R2_BAG_TXT_OD__c = 'A';
		bag.R2_BAG_TXT_UP__c = 'A';
		bag.R2_BAG_TXT_UnableToDeliver__c = 'A';
		bag.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Lock_Code__c ='5673';
		bag.R2_BAG_TXT_UniqueID__c ='56789';
		bag.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
		bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
		bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
		bag.R2_BAG_TXT_Storage_Location__c = 'Test';
		bag.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
		bag.R2_BAG_TXT_Comments__c = ' Test'; 

		



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		Apexpages.currentPage().getParameters().put('imgParam','img1');
		createPir.modifyDAH();
		createPir.getIncidentHeader();
		createPir.closeCAH();
		createPir.reopenRCB();
		createPir.reassignRIB();
		createPir.suspendSUS();
		createPir.informePIR();
		createPir.reinstateCFD();
		createPir.refreshDAH();
		createPir.readRefreshDAH();
		createPir.switchBoolEnabled();
		createPir.cargarVisual();
		//createPir.switchBoolCambiaEscala();
		//createPir.switchBoolReabrir();
		//createPir.leerSecciones();
		//createPir.cargarImgMaletaOn();
		//createPir.bagMostrar(0);
		//createPir.mostrarContenido();
		//createPir.guardarContenido();
		//createPir.newBag();
		createPir.updateContent();
		//createPir.deleteCont();
		//createPir.contWT();
		Test.stopTest();

		



		//R2_CLS_INC_InactiveDelayedController.getFields
	}


	static testMethod void metodosSin_Test(){
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;
		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		
		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);

		Apexpages.currentPage().getParameters().put('imgParam','img1');
		//createPir.modifyDAH();
		//createPir.getIncidentHeader();
		//createPir.closeCAH();
		//createPir.reopenRCB();
		//createPir.reassignRIB();
		//createPir.suspendSUS();
		//createPir.informePIR();
		//createPir.reinstateCFD();
		//createPir.refreshDAH();
		//createPir.readRefreshDAH();
		//createPir.switchBoolEnabled();
		createPir.switchBoolCambiaEscala();
		createPir.switchBoolReabrir();
		createPir.leerSecciones();
		createPir.cargarImgMaletaOn();
		createPir.bagMostrar(0);
		createPir.mostrarContenido();
		createPir.guardarContenido();
		createPir.newBag();
		createPir.updateContent();
		createPir.deleteCont();
		createPir.contWT();
		Test.stopTest();

	}

	static testMethod void cargarImagenON_2_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		Apexpages.currentPage().getParameters().put('imgParam','img2');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();

	}
	static testMethod void cargarImagenON_2_1_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		


		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		
		Apexpages.currentPage().getParameters().put('imgParam','img2');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}
	static testMethod void cargarImagenON_3_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag3 = completarMaleta(bag3);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		Apexpages.currentPage().getParameters().put('imgParam','img3');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

static testMethod void cargarImagenON_3_2_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		Apexpages.currentPage().getParameters().put('imgParam','img3');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	


	static testMethod void cargarImagenON_4_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		Apexpages.currentPage().getParameters().put('imgParam','img4');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_4_3_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag3 = completarMaleta(bag3);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		Apexpages.currentPage().getParameters().put('imgParam','img4');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_5_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		Apexpages.currentPage().getParameters().put('imgParam','img5');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_5_4_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		Apexpages.currentPage().getParameters().put('imgParam','img5');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}


	static testMethod void cargarImagenON_6_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		Apexpages.currentPage().getParameters().put('imgParam','img6');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_6_5_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		Apexpages.currentPage().getParameters().put('imgParam','img6');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_7_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		Apexpages.currentPage().getParameters().put('imgParam','img7');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_7_6_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		Apexpages.currentPage().getParameters().put('imgParam','img7');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_8_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);
		R2_Baggage__c bag8 = new R2_Baggage__c();
		bag2 = completarMaleta(bag8);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		createPir.bagLst.add(bag8);
		Apexpages.currentPage().getParameters().put('imgParam','img8');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_8_77_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);



		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		Apexpages.currentPage().getParameters().put('imgParam','img8');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_9_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);
		R2_Baggage__c bag8 = new R2_Baggage__c();
		bag2 = completarMaleta(bag8);
		R2_Baggage__c bag9 = new R2_Baggage__c();
		bag2 = completarMaleta(bag9);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		createPir.bagLst.add(bag8);
		createPir.bagLst.add(bag9);
		Apexpages.currentPage().getParameters().put('imgParam','img9');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_9_8_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);
		R2_Baggage__c bag8 = new R2_Baggage__c();
		bag2 = completarMaleta(bag8);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		createPir.bagLst.add(bag8);
		Apexpages.currentPage().getParameters().put('imgParam','img9');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_10_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);
		R2_Baggage__c bag8 = new R2_Baggage__c();
		bag2 = completarMaleta(bag8);
		R2_Baggage__c bag9 = new R2_Baggage__c();
		bag2 = completarMaleta(bag9);
		R2_Baggage__c bag10 = new R2_Baggage__c();
		bag2 = completarMaleta(bag10);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		createPir.bagLst.add(bag8);
		createPir.bagLst.add(bag9);
		createPir.bagLst.add(bag10);
		Apexpages.currentPage().getParameters().put('imgParam','img10');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	static testMethod void cargarImagenON_10_9_Test(){
		
		String rtInc = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR PDI AHL').getRecordTypeId(); 
		R1_CLS_LogHelper.throw_exception = false; 
		List<R1_CS_Endpoints__c> lst_ep = new List<R1_CS_Endpoints__c>();
		R1_CS_Endpoints__c epLogin = new R1_CS_Endpoints__c();
		epLogin.Name = 'ETL_Login';
		epLogin.R1_CHK_Activo__c = true;
		epLogin.R1_TXT_EndPoint__c = 'PruebaLogin';
		lst_ep.add(epLogin);

		R1_CS_Endpoints__c read = new R1_CS_Endpoints__c();
		read.Name='R2_DelayedBags';
		read.R1_CHK_Activo__c = true;
		read.R1_TXT_EndPoint__c = 'R2_DelayedBags';
		lst_ep.add(read);

		insert lst_ep;

		//timeOut
		TimeOut_Integrations__c cst = new TimeOut_Integrations__c();
		cst.Name = 'WorldTracer';
		cst.setTimeOut__c = 8000;
		insert cst;

		Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

		R1_Incident__c inc = new R1_Incident__c();
		inc.R2_INC_TXT_PIR_Reference_Number__c = '54321';
		inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
		inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
		inc.RecordTypeId = rtInc;
		insert inc;

		R2_Baggage__c bag = new R2_Baggage__c();
		bag = completarMaleta(bag);
		R2_Baggage__c bag2 = new R2_Baggage__c();
		bag2 = completarMaleta(bag2);
		R2_Baggage__c bag3 = new R2_Baggage__c();
		bag2 = completarMaleta(bag3);
		R2_Baggage__c bag4 = new R2_Baggage__c();
		bag2 = completarMaleta(bag4);
		R2_Baggage__c bag5 = new R2_Baggage__c();
		bag2 = completarMaleta(bag5);
		R2_Baggage__c bag6 = new R2_Baggage__c();
		bag2 = completarMaleta(bag6);
		R2_Baggage__c bag7 = new R2_Baggage__c();
		bag2 = completarMaleta(bag7);
		R2_Baggage__c bag8 = new R2_Baggage__c();
		bag2 = completarMaleta(bag8);
		R2_Baggage__c bag9 = new R2_Baggage__c();
		bag2 = completarMaleta(bag9);




		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		System.debug('Inc.id-->'+inc.id);		

		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
		completarInc(createPir);
		createPir.bagLst.add(bag);
		createPir.bagLst.add(bag2);
		createPir.bagLst.add(bag3);
		createPir.bagLst.add(bag4);
		createPir.bagLst.add(bag5);
		createPir.bagLst.add(bag6);
		createPir.bagLst.add(bag7);
		createPir.bagLst.add(bag8);
		createPir.bagLst.add(bag9);
		Apexpages.currentPage().getParameters().put('imgParam','img10');
		
		createPir.cargarImgMaletaOn();
		Test.stopTest();
		System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
	}

	
    static testMethod void exceptions_Test(){
		R1_CLS_LogHelper.throw_exception = true;

		R1_Incident__c inc = new R1_Incident__c();

		insert inc;
				
		Test.startTest();
		Apexpages.currentPage().getParameters().put('id',inc.id);
		ApexPages.StandardController sc = new ApexPages.StandardController(inc);
		R2_CLS_INC_InactiveDelayedController createPir = new R2_CLS_INC_InactiveDelayedController(sc);
			createPir.cargarVisual();
			createPir.getBagImageMaleta();
			createPir.cargarImgMaletaOn();
			createPir.getBagImageTipo();
			createPir.getBagImageColor();
			createPir.bagMostrar(null);
			createPir.mostrarContenido();
			createPir.guardarContenido();
			createPir.newBag();
			createPir.updateContent();
			createPir.deleteCont();
			createPir.contWT();
			createPir.recargarLstCont(null);
				

		Test.stopTest();
	}	 
	
}