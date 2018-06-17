/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:   Test to R2_CLS_INC_Info_PIR_DamagedController 
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/
@isTest
public class R2_CLS_INC_Info_PIR_DMGControllerTest {

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method auxiliar to fill all the fields of the PIR
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static void completarInc(R2_CLS_INC_Info_PIR_DamagedController createPir){
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
        for (R2_CLS_INC_Info_PIR_DamagedController.Field field : createPir.incidentInformationSection1) {
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
            //  // TODO WIP
            // } NOT NECESSARY
            //duplicado con R2_INC_DAT_PIR_Claim_Date__c ???
            //else if (field.name == 'R2_INC_DAT_PIR_Claim_Date__c') {
            //  if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
            //  if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
            //  //requestWR.claim.claimData.claimDate = parseDate(field.value);
   //             requestWR.claim.claimData.claimDate = field.value;
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Last_mapping_date__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_LOO_Case__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Search_start_date__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_PIR_DAT_PIR_Full_reintegration_date__c') {
            //  // TODO WIP
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
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Date_back_primary_search__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Control_date__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'RecordTypeId') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DAT_PIR_Unsuccessful_search__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_DATH_PIR_Incidence_closed_date__c') {
            //  // TODO WIP
            //}
            //else if (field.name == 'R2_INC_TXT_PIR_Agent__c') {
            //  // TODO WIP
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
            //  // TODO WIP
            //}
        }

        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection2) {
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
            //  // R2_WT_Wrappers_Create_Delayed.AddressLine addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine();
            //  // addressLine.addressLineDesc = field.value;
            //  // addressLine.seq = ''+2;
            //  if (requestWR.delayedBagGroup == null) { requestWR.delayedBagGroup = new R2_WT_Wrappers_Create_Delayed.DelayedBagGroup(); }
            //  if (requestWR.delayedBagGroup.bagDeliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress = new R2_WT_Wrappers_Create_Delayed.BagDeliveryAddress(); }
            //  if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
            //  if (requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine == null) { requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
            //  requestWR.delayedBagGroup.bagDeliveryAddress.deliveryAddress.addressLine.addressLineDesc = field.value;
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
        }

        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection3) {
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
            //  // R2_WT_Wrappers_Create_Delayed.AddressLine direccionLinea = new R2_WT_Wrappers_Create_Delayed.AddressLine();
            //  // direccionLinea.addressLineDesc = field.value;
            //  // direccionLinea.seq = ''+2;
            //  if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
            //  if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.contactInfo(); }
            //  if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.temporaryAddress(); }
            //  if (requestWR.passengers.contactInfo.temporaryAddress.addressLine == null) { requestWR.passengers.contactInfo.temporaryAddress.addressLine = new R2_WT_Wrappers_Create_Delayed.AddressLine(); }
            //  requestWR.passengers.contactInfo.temporaryAddress.addressLine.addressLineDesc = field.value;
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
            //else if (field.name == 'R2_INC_DAT_PIR_Validity_temporal_address__c') {
            //  List<String> auxLst = field.value.split('/');
   //             //creando formato de fecha de salesforce (yyyy-mm-dd)
   //             String dateStr;
   //             //creando formato de fecha EEUU (mm-dd-yyyy)
   //             if (UserInfo.getLocale() == 'en_US') {
   //                 dateStr = auxLst[2] + '-' + auxLst[0] + '-' + auxLst[1];
   //             }
   //             else {
   //                 //creando formato de fecha resto mundo (dd-mm-yyyy)
   //                 dateStr = auxLst[2] + '-' + auxLst[1] + '-' + auxLst[0];
   //             }
   //             field.value = dateStr;
   //         }
             // if (requestWR.passengers == null) { requestWR.passengers = new R2_WT_Wrappers_Create_Delayed.Passengers(); }
             // if (requestWR.passengers.contactInfo == null) { requestWR.passengers.contactInfo = new R2_WT_Wrappers_Create_Delayed.ContactInfo(); }
             // if (requestWR.passengers.contactInfo.temporaryAddress == null) { requestWR.passengers.contactInfo.temporaryAddress = new R2_WT_Wrappers_Create_Delayed.DeliveryAddress(); }
             // requestWR.passengers.contactInfo.temporaryAddress.validityDate = dateStr;
             //} //FIXME echarle un ojo
        }


        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection4) {
            if (field.name == 'R2_INC_TXT_PIR_Baggage_route__c') {
                    field.value = 'IB5433/2JAN';
            } else if (field.name == 'R2_INC_TXT_PIR_flight_Number__c'){
                field.value = 'IB5433/2JAN';
            } else if (field.name == 'R2_INC_TXT_PIR_Route__c'){
                field.value = 'MAD/JFK/MIA';
            }
                    
        }

        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection5) {
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

        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection7) {
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
            else if (field.name == 'R2_INC_TXT_PIR_Address_in_suitcase2__c') {
                field.value = 'test';   
            }
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
                // TODO WIP
            }
            else if (field.name == 'R2_INC_TXT_PIR_Baggage_destination__c') {
                field.value = 'Test';
            }
        }

        for (R2_CLS_INC_Info_PIR_DamagedController.Field field :createPir.incidentInformationSection8) {
            if (field.name == 'R2_INC_TXT_PIR_Shared_code__c') { // claim.claimData.partnerCode.carrierCode PartnerCodecarrierCode
                field.value = 'Test';   
            }
            else if (field.name == 'R2_INC_CHK_PIR_Baggage_insurance__c') { // claim.claimData.insurance
                field.value = 'True';
            }
            else if (field.name == 'R2_INC_TXT_PIR_Lost_reason__c') {
                field.value = 'Test';   
            }
            else if (field.name == 'R2_INC_TXT_PIR_Special_lost_reason__c') {
                // if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
                // if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
                // requestWR.claim.claimData. = field.value ;
                // FIXME no encontrado
            }
            //else if (field.name == 'R2_INC_CHK_PIR_Replace_suitcase__c') {
            //  if (requestWR.claim == null) { requestWR.claim = new R2_WT_Wrappers_Create_Delayed.Claim(); }
            //  if (requestWR.claim.claimData == null) { requestWR.claim.claimData = new R2_WT_Wrappers_Create_Delayed.ClaimData(); }
            //  requestWR.claim.claimData.replacementBagIndicator = field.value ;
            //  // FIXME no mapeado!
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

        System.debug('Lista de campos '+ createPir.incidentInformationSection1);
        System.debug('Lista de campos '+ createPir.incidentInformationSection2);
        System.debug('Lista de campos '+ createPir.incidentInformationSection3);
        System.debug('Lista de campos '+ createPir.incidentInformationSection4);

    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method auxiliar to fill bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static void completarbag(R2_CLS_INC_Info_PIR_DamagedController createPir){

        R2_Baggage__c bag = new R2_Baggage__c();
        bag.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag.R2_BAG_PKL_Type__c = '22D';
        bag.R2_BAG_PKL_Colour__c = 'WT';
        bag.R2_BAG_CHK_Suspended__c = true;
        bag.R2_BAG_CHK_Metal__c = true;
        bag.R2_BAG_CHK_Retractable_handle__c =  true;
        bag.R2_BAG_CHK_Combination_lock__c =  true;
        bag.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag.R2_BAG_CHK_Safety_belt__c =  true;
        bag.R2_BAG_TXT_Ticket_number__c ='IB987651';
        bag.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_OF__c = 'A';
        bag.R2_BAG_TXT_OD__c = 'A';
        bag.R2_BAG_TXT_UP__c = 'A';
        bag.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Lock_Code__c ='5673';
        bag.R2_BAG_TXT_UniqueID__c ='25342523';
        bag.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag.R2_BAG_TXT_Comments__c = ' Test';
        
        createPir.bagLst.add(bag);

        R2_Baggage__c bag2 = new R2_Baggage__c();
        bag2.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag2.R2_BAG_PKL_Type__c = '22D';
        bag2.R2_BAG_PKL_Colour__c = 'WT';
        bag2.R2_BAG_CHK_Suspended__c = false;
        bag2.R2_BAG_CHK_Rigid__c = true;
        bag2.R2_BAG_CHK_Retractable_handle__c =  true;
        bag2.R2_BAG_CHK_Combination_lock__c =  true;
        bag2.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag2.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag2.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag2.R2_BAG_CHK_Safety_belt__c =  true;
        bag2.R2_BAG_TXT_Ticket_number__c ='IB987652';
        bag2.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag2.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_OF__c = 'A';
        bag2.R2_BAG_TXT_OD__c = 'A';
        bag2.R2_BAG_TXT_UP__c = 'A';
        bag2.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag2.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_Lock_Code__c ='5673';
        bag2.R2_BAG_TXT_UniqueID__c ='25342523';
        bag2.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag2.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag2.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag2.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag2.R2_BAG_TXT_Comments__c = ' Test';
        
        createPir.bagLst.add(bag2);

        R2_Baggage__c bag3 = new R2_Baggage__c();
        bag3.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag3.R2_BAG_PKL_Type__c = '22D';
        bag3.R2_BAG_PKL_Colour__c = 'WT';
        bag3.R2_BAG_CHK_Suspended__c = true;
        bag3.R2_BAG_CHK_Mixed__c = true;
        bag3.R2_BAG_CHK_Retractable_handle__c =  true;
        bag3.R2_BAG_TXT_Ticket_number__c ='IB987653';
        bag3.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag3.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_OF__c = 'A';
        bag3.R2_BAG_TXT_OD__c = 'A';
        bag3.R2_BAG_TXT_UP__c = 'A';
        bag3.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag3.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_Lock_Code__c ='5673';
        bag3.R2_BAG_TXT_UniqueID__c ='IB987653';
        bag3.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag3.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag3.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag3.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag3.R2_BAG_TXT_Comments__c = ' Test';
        
        createPir.bagLst.add(bag3);

        R2_Baggage__c bag4 = new R2_Baggage__c();
        bag4.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag4.R2_BAG_PKL_Type__c = '22D';
        bag4.R2_BAG_PKL_Colour__c = 'WT';
        bag4.R2_BAG_CHK_Suspended__c = true;
        bag4.R2_BAG_CHK_Leather__c = true;
        bag4.R2_BAG_CHK_Combination_lock__c =  true;
        bag4.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag4.R2_BAG_TXT_Ticket_number__c ='IB987654';
        bag4.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag4.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_OF__c = 'A';
        bag4.R2_BAG_TXT_OD__c = 'A';
        bag4.R2_BAG_TXT_UP__c = 'A';
        bag4.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag4.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_Lock_Code__c ='5673';
        bag4.R2_BAG_TXT_UniqueID__c ='25342523';
        bag4.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag4.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag4.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag4.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag4.R2_BAG_TXT_Comments__c = ' Test';

        createPir.bagLst.add(bag4);

        R2_Baggage__c bag5 = new R2_Baggage__c();
        bag5.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag5.R2_BAG_PKL_Type__c = '22D';
        bag5.R2_BAG_PKL_Colour__c = 'WT';
        bag5.R2_BAG_CHK_Suspended__c = true;
        bag5.R2_BAG_CHK_Printed_fabric__c = true;
        bag5.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag5.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag5.R2_BAG_CHK_Safety_belt__c =  true;
        bag5.R2_BAG_TXT_Ticket_number__c ='075987655';
        bag5.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag5.R2_BAG_TXT_Brand_Info_Suspended__c = true;
        bag5.R2_BAG_CHK_BagTag_Suspended__c = true;
        bag5.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_OF__c = 'A';
        bag5.R2_BAG_TXT_OD__c = 'A';
        bag5.R2_BAG_TXT_UP__c = 'A';
        bag5.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag5.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_Lock_Code__c ='5673';
        bag5.R2_BAG_TXT_UniqueID__c ='25342523';
        bag5.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag5.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag5.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag5.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag5.R2_BAG_TXT_Comments__c = ' Test';

        createPir.bagLst.add(bag5);

        R2_Baggage__c bag6 = new R2_Baggage__c();
        bag6.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag6.R2_BAG_PKL_Type__c = '26';
        bag6.R2_BAG_PKL_Colour__c = 'WT';
        bag6.R2_BAG_CHK_Rigid__c = True;
        bag6.R2_BAG_CHK_Retractable_handle__c =  True;
        bag6.R2_BAG_CHK_Combination_lock__c =  True;
        bag6.R2_BAG_CHK_Wheels_or_bearing__c =  True;
        bag6.R2_BAG_CHK_Single_object_in_box__c =  True;
        bag6.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
        bag6.R2_BAG_CHK_Safety_belt__c =  True;
        bag6.R2_BAG_TXT_Ticket_number__c ='uyehrjat2';
        bag6.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag6.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag6.R2_BAG_TXT_OF__c = 'A';
        bag6.R2_BAG_TXT_OD__c = 'A';
        bag6.R2_BAG_TXT_UP__c = 'A';
        bag6.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag6.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag6.R2_BAG_TXT_Lock_Code__c ='5673';
        bag6.R2_BAG_TXT_UniqueID__c ='5345234';
        bag6.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag6.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        bag6.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag6.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
        bag6.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag6.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag6.R2_BAG_TXT_Comments__c = ' Test'; 

        createPir.bagLst.add(bag6);

        R2_Baggage__c bag7 = new R2_Baggage__c();
        bag7.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag7.R2_BAG_PKL_Type__c = '22D';
        bag7.R2_BAG_PKL_Colour__c = 'WT';
        bag7.R2_BAG_CHK_Mixed__c = True;
        bag7.R2_BAG_CHK_Retractable_handle__c =  True;
        bag7.R2_BAG_CHK_Combination_lock__c =  True;
        bag7.R2_BAG_CHK_Wheels_or_bearing__c =  True;
        bag7.R2_BAG_CHK_Single_object_in_box__c =  True;
        bag7.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
        bag7.R2_BAG_CHK_Safety_belt__c =  True;
        bag7.R2_BAG_TXT_Ticket_number__c ='uyehrjat2';
        bag7.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag7.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag7.R2_BAG_TXT_OF__c = 'A';
        bag7.R2_BAG_TXT_OD__c = 'A';
        bag7.R2_BAG_TXT_UP__c = 'A';
        bag7.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag7.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag7.R2_BAG_TXT_Lock_Code__c ='5673';
        bag7.R2_BAG_TXT_UniqueID__c ='54325234523';
        bag7.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag7.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        bag7.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag7.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
        bag7.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag7.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag7.R2_BAG_TXT_Comments__c = ' Test'; 

        createPir.bagLst.add(bag7);

        R2_Baggage__c bag8 = new R2_Baggage__c();
        bag8.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag8.R2_BAG_PKL_Type__c = '22D';
        bag8.R2_BAG_PKL_Colour__c = 'WT';
        bag8.R2_BAG_CHK_Leather__c = True;
        bag8.R2_BAG_CHK_Retractable_handle__c =  True;
        bag8.R2_BAG_CHK_Combination_lock__c =  True;
        bag8.R2_BAG_CHK_Wheels_or_bearing__c =  True;
        bag8.R2_BAG_CHK_Single_object_in_box__c =  True;
        bag8.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
        bag8.R2_BAG_CHK_Safety_belt__c =  True;
        bag8.R2_BAG_TXT_Ticket_number__c ='uyehrjat2';
        bag8.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag8.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag8.R2_BAG_TXT_OF__c = 'A';
        bag8.R2_BAG_TXT_OD__c = 'A';
        bag8.R2_BAG_TXT_UP__c = 'A';
        bag8.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag8.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag8.R2_BAG_TXT_Lock_Code__c ='5673';
        bag8.R2_BAG_TXT_UniqueID__c ='7898967';
        bag8.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag8.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        bag8.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag8.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
        bag8.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag8.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag8.R2_BAG_TXT_Comments__c = ' Test'; 

        createPir.bagLst.add(bag8);

        R2_Baggage__c bag9 = new R2_Baggage__c();
        bag9.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag9.R2_BAG_PKL_Type__c = '22D';
        bag9.R2_BAG_PKL_Colour__c = 'WT';
        bag9.R2_BAG_CHK_Printed_fabric__c = True;
        bag9.R2_BAG_CHK_Retractable_handle__c =  True;
        bag9.R2_BAG_CHK_Combination_lock__c =  True;
        bag9.R2_BAG_CHK_Wheels_or_bearing__c =  True;
        bag9.R2_BAG_CHK_Single_object_in_box__c =  True;
        bag9.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
        bag9.R2_BAG_CHK_Safety_belt__c =  True;
        bag9.R2_BAG_TXT_Ticket_number__c ='uyehrjat2';
        bag9.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag9.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag9.R2_BAG_TXT_OF__c = 'A';
        bag9.R2_BAG_TXT_OD__c = 'A';
        bag9.R2_BAG_TXT_UP__c = 'A';
        bag9.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag9.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag9.R2_BAG_TXT_Lock_Code__c ='5673';
        bag9.R2_BAG_TXT_UniqueID__c ='768995976';
        bag9.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag9.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        bag9.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag9.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
        bag9.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag9.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag9.R2_BAG_TXT_Comments__c = ' Test'; 

        createPir.bagLst.add(bag9);

        R2_Baggage__c bag10 = new R2_Baggage__c();
        bag10.R2_BAG_TXT_PIR_AR__c = 'MADIB12345';
        bag10.R2_BAG_PKL_Type__c = '22D';
        bag10.R2_BAG_CHK_Printed_fabric__c = True;
        bag10.R2_BAG_CHK_Retractable_handle__c =  True;
        bag10.R2_BAG_CHK_Combination_lock__c =  True;
        bag10.R2_BAG_CHK_Wheels_or_bearing__c =  True;
        bag10.R2_BAG_CHK_Single_object_in_box__c =  True;
        bag10.R2_BAG_CHK_Suitcase_allowed_cabin__c = True;
        bag10.R2_BAG_CHK_Safety_belt__c =  True;
        bag10.R2_BAG_TXT_Ticket_number__c ='uyehrjat2';
        bag10.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag10.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag10.R2_BAG_TXT_OF__c = 'A';
        bag10.R2_BAG_TXT_OD__c = 'A';
        bag10.R2_BAG_TXT_UP__c = 'A';
        bag10.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag10.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag10.R2_BAG_TXT_Lock_Code__c ='5673';
        bag10.R2_BAG_TXT_UniqueID__c ='959978957';
        bag10.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag10.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        bag10.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag10.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = '2018-02-12';
        bag10.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag10.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag10.R2_BAG_TXT_Comments__c = ' Test'; 

        createPir.bagLst.add(bag10);

        //contenido no insertado para un if del metodo deleteCont
        if (createPir.lstContent == null) {
            createPir.lstContent = new List<R2_Content_Baggage__c>();
        }
        R2_Content_Baggage__c cont = new R2_Content_Baggage__c();
        cont.R2_CB_TXT_Description__c = 'ipad';
        cont.R2_BG_CHK_Select__c = true;
        createPir.lstContent.add(cont);
    }
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method auxiliar to create data of the PIR and EndPoints in Salesforce
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/
    public static R1_Incident__c initializeData(){
    
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
        String recordtype = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR AHL').getRecordTypeId();
        R1_Incident__c inc = new R1_Incident__c();
        inc.RecordTypeId = recordtype;
        inc.R2_INC_TXT_PIR_Reference_Number__c = '56789';
        inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
        inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        insert inc;

        List<R2_Baggage__c> bag_Lst = new List<R2_Baggage__c>();
        R2_Baggage__c bag = new R2_Baggage__c();
        bag.R2_BAG_PKL_Type__c = '22D';
        bag.R2_BAG_PKL_Colour__c = 'WT';
        bag.R2_BAG_CHK_Suspended__c = true;
        bag.R2_BAG_CHK_Metal__c = true;
        bag.R2_BAG_CHK_Retractable_handle__c =  true;
        bag.R2_BAG_CHK_Combination_lock__c =  true;
        bag.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag.R2_BAG_CHK_Safety_belt__c =  true;
        bag.R2_BAG_TXT_Ticket_number__c ='IB987651';
        bag.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_OF__c = 'A';
        bag.R2_BAG_TXT_OD__c = 'A';
        bag.R2_BAG_TXT_UP__c = 'A';
        bag.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Lock_Code__c ='5673';
        bag.R2_BAG_TXT_UniqueID__c ='25342523';
        //bag.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        //bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        //bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        //bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag.R2_BAG_TXT_Comments__c = ' Test';
        bag.R2_BAG_MSDT_Incident__c = inc.Id;
        bag_Lst.add(bag);

        R2_Baggage__c bag2 = new R2_Baggage__c();
        bag2.R2_BAG_PKL_Type__c = '22D';
        bag2.R2_BAG_PKL_Colour__c = 'WT';
        bag2.R2_BAG_CHK_Suspended__c = false;
        bag2.R2_BAG_CHK_Rigid__c = true;
        bag2.R2_BAG_CHK_Retractable_handle__c =  true;
        bag2.R2_BAG_CHK_Combination_lock__c =  true;
        bag2.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag2.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag2.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag2.R2_BAG_CHK_Safety_belt__c =  true;
        bag2.R2_BAG_TXT_Ticket_number__c ='IB987652';
        bag2.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag2.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_OF__c = 'A';
        bag2.R2_BAG_TXT_OD__c = 'A';
        bag2.R2_BAG_TXT_UP__c = 'A';
        bag2.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag2.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag2.R2_BAG_TXT_Lock_Code__c ='5673';
        bag2.R2_BAG_TXT_UniqueID__c ='25342523';
        //bag2.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        //bag2.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        //bag2.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        //bag2.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag2.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag2.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag2.R2_BAG_TXT_Comments__c = ' Test';
        bag2.R2_BAG_MSDT_Incident__c = inc.Id;
        bag_Lst.add(bag2);

        R2_Baggage__c bag3 = new R2_Baggage__c();
        bag3.R2_BAG_PKL_Type__c = '22D';
        bag3.R2_BAG_PKL_Colour__c = 'WT';
        bag3.R2_BAG_CHK_Suspended__c = true;
        bag3.R2_BAG_CHK_Mixed__c = true;
        bag3.R2_BAG_CHK_Retractable_handle__c =  true;
        bag3.R2_BAG_TXT_Ticket_number__c ='IB987653';
        bag3.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag3.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_OF__c = 'A';
        bag3.R2_BAG_TXT_OD__c = 'A';
        bag3.R2_BAG_TXT_UP__c = 'A';
        bag3.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag3.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag3.R2_BAG_TXT_Lock_Code__c ='5673';
        bag3.R2_BAG_TXT_UniqueID__c ='IB987653';
        //bag3.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        //bag3.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        //bag3.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        //bag3.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag3.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag3.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag3.R2_BAG_TXT_Comments__c = ' Test';
        bag3.R2_BAG_MSDT_Incident__c = inc.Id;
        bag_Lst.add(bag3);

        R2_Baggage__c bag4 = new R2_Baggage__c();
        bag4.R2_BAG_PKL_Type__c = '22D';
        bag4.R2_BAG_PKL_Colour__c = 'WT';
        bag4.R2_BAG_CHK_Suspended__c = true;
        bag4.R2_BAG_CHK_Leather__c = true;
        bag4.R2_BAG_CHK_Combination_lock__c =  true;
        bag4.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag4.R2_BAG_TXT_Ticket_number__c ='IB987654';
        bag4.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag4.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_OF__c = 'A';
        bag4.R2_BAG_TXT_OD__c = 'A';
        bag4.R2_BAG_TXT_UP__c = 'A';
        bag4.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag4.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag4.R2_BAG_TXT_Lock_Code__c ='5673';
        bag4.R2_BAG_TXT_UniqueID__c ='25342523';
        //bag4.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        //bag4.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        //bag4.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        //bag4.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag4.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag4.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag4.R2_BAG_TXT_Comments__c = ' Test';
        bag4.R2_BAG_MSDT_Incident__c = inc.Id;
        bag_Lst.add(bag4);

        R2_Baggage__c bag5 = new R2_Baggage__c();
        bag5.R2_BAG_PKL_Type__c = '22D';
        bag5.R2_BAG_PKL_Colour__c = 'WT';
        bag5.R2_BAG_CHK_Suspended__c = true;
        bag5.R2_BAG_CHK_Printed_fabric__c = true;
        bag5.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag5.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag5.R2_BAG_CHK_Safety_belt__c =  true;
        bag5.R2_BAG_TXT_Ticket_number__c ='075987655';
        bag5.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag5.R2_BAG_TXT_Brand_Info_Suspended__c = true;
        bag5.R2_BAG_CHK_BagTag_Suspended__c = true;
        bag5.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_OF__c = 'A';
        bag5.R2_BAG_TXT_OD__c = 'A';
        bag5.R2_BAG_TXT_UP__c = 'A';
        bag5.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag5.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag5.R2_BAG_TXT_Lock_Code__c ='5673';
        bag5.R2_BAG_TXT_UniqueID__c ='25342523';
        //bag5.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        //bag5.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'EU';
        //bag5.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        //bag5.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag5.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag5.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag5.R2_BAG_TXT_Comments__c = ' Test';
        bag5.R2_BAG_MSDT_Incident__c = inc.Id;
        bag_Lst.add(bag5);

        insert bag_Lst;

        List<R2_Content_Baggage__c> con_Lst = new List<R2_Content_Baggage__c>();
        R2_Content_Baggage__c con = new R2_Content_Baggage__c();
        con.R2_CB_MSDT_Baggage__c = bag.Id;
        con.R2_CB_TXT_Description__c = 'reloj';
        con.R2_BG_CHK_Select__c = true;
        con_Lst.add(con);
        R2_Content_Baggage__c con2 = new R2_Content_Baggage__c();
        con2.R2_CB_MSDT_Baggage__c = bag.Id;
        con2.R2_CB_TXT_Description__c = 'ipad';
        con2.R2_BG_CHK_Select__c = false;
        con_Lst.add(con2);
        insert con_Lst;

        return inc;
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getMG of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getMG_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_MG_Message__c message = new R2_MG_Message__c();
        message.R2_MG_LOO_Incident__c = inc.Id;
        insert message;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getMG();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getMR of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getMR_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        aux.R2_ADI_PKL_Type__c = 'MR';
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getMR();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getCR of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getCR_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        aux.R2_ADI_PKL_Type__c = 'CR';
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getCR();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getDY of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getDY_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        aux.R2_ADI_PKL_Type__c = 'DY';
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getDY();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getUC of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getUC_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        aux.R2_ADI_PKL_Type__c = 'UC';
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getUC();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getFF of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getFF_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        aux.R2_ADI_PKL_Type__c = 'FF';
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getFF();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentInformation of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidenteInformation_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getIncidentInformation('1');
            createPir.getIncidentInformation('2');
            createPir.getIncidentInformation('3');
            createPir.getIncidentInformation('4');
            createPir.getIncidentInformation('5');
            createPir.getIncidentInformation('6');
            createPir.getIncidentInformation('7');
            createPir.getIncidentInformation('8');
            createPir.getIncidentInformation('9');
            createPir.getIncidentInformation('10');
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentFields of the controller with boolenabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidentFields_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        String fields = 'R2_INC_DAT_PIR_Claim_Date__c, R2_INC_LOO_Case__c, R2_INC_NUM_PIR_Associated_Cases__c, R2_INC_DATH_PIR_Incidence_closed_date__c, ' +
                        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_TLF_Landline1__c';
        String fields2 = 'R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_ATXTL_MG_Message__c, R2_ADI_ATXTL_MR_Match__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_TXT_UC_User_Comment__c, ' +
                        'R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c';

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getIncidentFields(inc,fields,aux,fields2);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentFields of the controller with boolModifyEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidentFields2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        String fields = 'R2_INC_DAT_PIR_Claim_Date__c, R2_INC_LOO_Case__c, R2_INC_NUM_PIR_Associated_Cases__c, R2_INC_DATH_PIR_Incidence_closed_date__c, ' +
                        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_TLF_Landline1__c';
        String fields2 = 'R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_ATXTL_MG_Message__c, R2_ADI_ATXTL_MR_Match__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_TXT_UC_User_Comment__c, ' +
                        'R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c';

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
        createPir.boolModifyEnabled = true;
            createPir.getIncidentFields(inc,fields,aux,fields2);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentFields of the controller with boolCloseEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidentFields3_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        String fields = 'R2_INC_DAT_PIR_Claim_Date__c, R2_INC_LOO_Case__c, R2_INC_NUM_PIR_Associated_Cases__c, R2_INC_DATH_PIR_Incidence_closed_date__c, '+
                        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_TLF_Landline1__c';
        String fields2 = 'R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_ATXTL_MG_Message__c, R2_ADI_ATXTL_MR_Match__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_TXT_UC_User_Comment__c, ' +
                        'R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c';

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.boolCloseEnabled = true;
            createPir.getIncidentFields(inc,fields,aux,fields2);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentFields of the controller with no boolean fields active
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidentFields4_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        String fields = 'R2_INC_DAT_PIR_Claim_Date__c, R2_INC_LOO_Case__c, R2_INC_NUM_PIR_Associated_Cases__c, R2_INC_DATH_PIR_Incidence_closed_date__c, '+
                        'R2_INC_TXT_PIR_Stop_and_Operator_MS__c, R2_INC_PKL_PIR_Status_incidence__c, R2_INC_CHK_PIR_Limited_approval_label__c, R2_INC_TLF_Landline1__c';
        String fields2 = 'R2_ADI_TXT_CR_Remarks_Cost__c, R2_ADI_ATXTL_MG_Message__c, R2_ADI_ATXTL_MR_Match__c, R2_ADI_TXT_FF_Observation__c, R2_ADI_TXT_UC_User_Comment__c, ' +
                        'R2_ADI_ATXTL_DS_Delivery_service__c, R2_ADI_TXT_DB_baggage_Destination__c, R2_ADI_ATXTL_DY_Delivery_Info__c';

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getIncidentFields(inc,fields,aux,fields2);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentHeader of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getIncidentHeader_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.getIncidentHeader();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getIncidentHeader of the controller
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void insertDummyPayment_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
            createPir.insertDummyPayment(inc.Id);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test closeCAH
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void closeCAH_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        
        R2_Auxiliar_Data_Incident__c aux = new R2_Auxiliar_Data_Incident__c();
        aux.R2_ADI_NUM_CS_Amount__c = 100;
        aux.R2_ADI_TXT_CS_Currency__c = 'EUR';
        aux.R2_ADI_PKL_CS_Cost_Type__c = 'X';
        aux.R2_ADI_MSDT_Incident__c = inc.Id;
        insert aux;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
        createPir.closeCAH();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test reassignRIB
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void reassignRIB_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
        createPir.reassignRIB();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test informePIR
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void informePIR_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
        createPir.informePIR();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test refreshDAH
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void refreshDAH_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
        createPir.refreshDAH();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test readRefreshDAH
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void readRefreshDAH_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
        createPir.readRefreshDAH();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test modifyDPR
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void modifyDPR_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        //R1_Incident__c inc = initializeData();
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
        String recordtype = Schema.SObjectType.R1_Incident__c.getRecordTypeInfosByName().get('PIR AHL').getRecordTypeId();
        R1_Incident__c inc = new R1_Incident__c();
        inc.RecordTypeId = recordtype;
        inc.R2_INC_TXT_PIR_Reference_Number__c = '56789';
        inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
        inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';
        insert inc;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
        createPir.modifyDPR();
        
        //R1_Log__c log = [SELECT R1_LOG_ATXTL_MensajeError__c, R1_LOG_TXT_RegAsociado__c, R1_LOG_TXT_Objeto__c, R1_LOG_TXT_Metodo__c FROM R1_Log__c LIMIT 1];
        //System.debug('log: ' + log);
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolEnabled_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        Test.startTest();
        createPir.boolEnabled = false;
        createPir.boolModifyEnabled = false;
        createPir.switchBoolEnabled();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolEnabled2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolEnabled = true;
        createPir.boolModifyEnabled = true;
        createPir.switchBoolEnabled();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolCambiaEscala
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolCambiaEscala_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolCambiaEscala = false;
        createPir.switchBoolCambiaEscala();

        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolCambiaEscala
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolCambiaEscala2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolCambiaEscala = true;
        createPir.switchBoolCambiaEscala();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolReabrir
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolReabrir_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolReabrir = false;
        createPir.switchBoolReabrir();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolReabrir
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolReabrir2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolReabrir = true;
        createPir.switchBoolReabrir();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolCloseEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolCloseEnabled_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolCloseEnabled = false;
        createPir.switchBoolCloseEnabled();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test switchBoolCloseEnabled
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void switchBoolCloseEnabled2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.boolCloseEnabled = true;
        createPir.switchBoolCloseEnabled();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test resetBooleanos
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void resetBooleanos_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.resetBooleanos();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test leerSecciones
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void leerSecciones_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        
        Test.startTest();
        createPir.leerSecciones();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getLookupField
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getLookupField_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();
        R2_Prorrateo__c pro = new R2_Prorrateo__c();
        pro.R2_PRO_PKL_Status__c = 'Prorrateo a Revisar';
        pro.R2_PRO_LOO_PIR__c = inc.Id;
        pro.R2_PRO_TXT_ExternalId__c = 'werwerw4234234324';
        insert pro;

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);

        Test.startTest();
        createPir.getLookupField();
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 0
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta0_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 0;
            createPir.cargarVisual();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 1
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta1_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 1;
            createPir.cargarVisual();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 2
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 2;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 3
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta3_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 3;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 4
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta4_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 4;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 5
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta5_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 5;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 6
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta6_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 6;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 7
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta7_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 7;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 8
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta8_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 8;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   
    
/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarVisual with maleta selected 9
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarVisualMaleta9_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.maletaSelect = 9;
            createPir.cargarVisual();
        
        Test.stopTest();
    }   

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getBagImageMaleta with ten bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getBagImageMaleta_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.getBagImageMaleta();
        
        Test.stopTest();
    }   

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getBagImageMaleta with only one bag
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getBagImageMaleta1_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        R2_Baggage__c bag = new R2_Baggage__c();
        bag.R2_BAG_PKL_Type__c = '22D';
        bag.R2_BAG_PKL_Colour__c = 'WT';
        bag.R2_BAG_CHK_Suspended__c = true;
        bag.R2_BAG_CHK_Metal__c = true;
        bag.R2_BAG_CHK_Retractable_handle__c =  true;
        bag.R2_BAG_CHK_Combination_lock__c =  true;
        bag.R2_BAG_CHK_Wheels_or_bearing__c =  true;
        bag.R2_BAG_CHK_Single_object_in_box__c =  true;
        bag.R2_BAG_CHK_Suitcase_allowed_cabin__c = true;
        bag.R2_BAG_CHK_Safety_belt__c =  true;
        bag.R2_BAG_TXT_Ticket_number__c ='IB987651';
        bag.R2_BAG_TXT_Brand_Info__c = 'Test';
        bag.R2_BAG_DAT_Suitcase_delivery_date__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_OF__c = 'A';
        bag.R2_BAG_TXT_OD__c = 'A';
        bag.R2_BAG_TXT_UP__c = 'A';
        bag.R2_BAG_TXT_UnableToDeliver__c = 'A';
        bag.R2_BAG_DAT_DateBagReceived__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Lock_Code__c ='5673';
        bag.R2_BAG_TXT_UniqueID__c ='25342523';
        bag.R2_BAG_DATH_Bag_SentToCustoms__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Bag_SentToCustoms_TimeZone__c = 'GMT';
        bag.R2_BAG_DATH_Bag_ReceivedFromCustoms__c = Date.valueOf('2018-02-12');
        bag.R2_BAG_TXT_Bag_ReceivedCustoms_TimeZone__c = 'GMT';
        bag.R2_BAG_TXT_Storage_Location__c = 'Test';
        bag.R2_BAG_TXT_Aditional_damage_information__c = 'Test';
        bag.R2_BAG_TXT_Comments__c = ' Test';
        
        createPir.bagLst.add(bag);
        Test.startTest();
            createPir.getBagImageMaleta();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getBagImageMaleta
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getBagImageMaleta2_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.getBagImageMaleta();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img1 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn1a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img1');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img1 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn1b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img1');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img2 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn2a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img2');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img2 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn2b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img2');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img3 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn3a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img3');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img3 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn3b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img3');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img4 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn4a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img4');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img4 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn4b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img4');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img5 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn5a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img5');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img5 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn5b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img5');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img6 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn6a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img6');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img6 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn6b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img6');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img7 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn7a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img7');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img7 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn7b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img7');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img8 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn8a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img8');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img8 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn8b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img8');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img9 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn9a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img9');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img9 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn9b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img9');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img10 with bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn10a_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img10');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test cargarImgMaletaOn img10 without bags
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void cargarImgMaletaOn10b_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        Apexpages.currentPage().getParameters().put('imgParam','img10');
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        
        Test.startTest();
            createPir.cargarImgMaletaOn();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getBagImageTipo
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getBagImageTipo_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = new R1_Incident__c();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
                
        Test.startTest();
            createPir.getBagImageTipo();
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test getBagImageColor
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void getBagImageColor_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
        
        completarInc(createPir);
        completarbag(createPir);

        Test.startTest();
            createPir.getBagImageColor();
        
        Test.stopTest();
    }


/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test bagMostrar
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void bagMostrar_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = new R1_Incident__c();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
                
        Test.startTest();
            createPir.bagMostrar(1);
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test newBag
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void newBag_Test(){
        R1_CLS_LogHelper.throw_exception = false;

        R1_Incident__c inc = initializeData();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        Apexpages.currentPage().getParameters().put('id',inc.Id);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
            
        completarInc(createPir);
        completarbag(createPir);

        Test.startTest();
            createPir.bagMostrar(1);
            createPir.actionBag = 'save';
            createPir.newBag();
            createPir.actionBag = 'update';
            createPir.newBag();
            
        
        Test.stopTest();
    }

/*---------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Method to test exceptions
IN:          
OUT:            

History: 
<Date>                     <Author>                         <Change Description>
26/02/2018              Alvaro Garcia Tapia                 Initial Version
----------------------------------------------------------------------------------------------------------------------*/    
    static testMethod void exceptions_Test(){
        R1_CLS_LogHelper.throw_exception = true;

        R1_Incident__c inc = new R1_Incident__c();

        ApexPages.StandardController sc = new ApexPages.StandardController(inc);
        R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
                
        Test.startTest();
            createPir.cargarVisual();
            createPir.getMG();
            createPir.getMR();
            createPir.getCR();
            createPir.getDY();
            createPir.getUC();
            createPir.getFF();
            createPir.getIncidentInformation('1');
            createPir.getIncidentFields(null,'',null,'');
            createPir.getIncidentHeader();
            createPir.insertDummyPayment(null);
            createPir.closeCAH();
            createPir.reassignRIB();
            createPir.informePIR();
            createPir.refreshDAH();
            createPir.readRefreshDAH();
            createPir.modifyDPR();
            createPir.getLookupField();
            createPir.getBagImageMaleta();
            createPir.cargarImgMaletaOn();
            createPir.getBagImageTipo();
            createPir.getBagImageColor();
            createPir.bagMostrar(1);
            createPir.newBag();
        Test.stopTest();
    }
    //static testMethod void utilities_TestImg1(){      
    //  R1_Incident__c inc = new R1_Incident__c();
    //  String recordtype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('DELAYED').getRecordTypeId();
    //  inc.RecordTypeId = recordtype;
    //  inc.R2_INC_TXT_PIR_Reference_Number__c = '56789';
    //  inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
    //  inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';

    //  insert inc;
    //  ApexPages.StandardController sc = new ApexPages.StandardController(inc);
    //  R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
    //  completarInc(createPir);
    //  createPir.cargarVisual();
    //  Apexpages.currentPage().getParameters().put('imgParam','img1');
    //  createPir.cargarImgMaletaOn();
    //  createPir.modifyDPR();
    //}

    //static testMethod void utilities_TestImg2(){  
    //  R1_Incident__c inc = new R1_Incident__c();
    //  String recordtype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('DELAYED').getRecordTypeId();
    //  inc.RecordTypeId = recordtype;
    //  inc.R2_INC_TXT_PIR_Reference_Number__c = '56789';
    //  inc.R2_INC_TXT_PIR_Station_Code__c = 'MAD';
    //  inc.R2_INC_TXT_PIR_Airline_Code__c = 'IB';

    //  insert inc; 
    //  ApexPages.StandardController sc = new ApexPages.StandardController(inc);
    //  R2_CLS_INC_Info_PIR_DamagedController createPir = new R2_CLS_INC_Info_PIR_DamagedController(sc);
    //  completarInc(createPir);
    //  createPir.cargarVisual();
    //  Apexpages.currentPage().getParameters().put('imgParam','img1');
    //  createPir.cargarImgMaletaOn();
    //  createPir.modifyDPR();
    //}

}


        //createPir.cargarVisual();
        //Apexpages.currentPage().getParameters().put('imgParam','img1');
        //createPir.cargarImgMaletaOn();
        //createPir.modifyDPR();
        //createPir.getMG();
        //createPir.getMR();
        //createPir.getCR();
        //createPir.getDY();
        //createPir.getUC();
        //createPir.getFF();
        //createPir.closeCAH();
        //createPir.reopenRCB();
        //createPir.reassignRIB();
        //createPir.suspendSUS();
        //createPir.informePIR();
        //createPir.reinstateCFD();
        //createPir.refreshDAH();
        //createPir.readRefreshDAH();
        //createPir.switchBoolEnabled();
        //createPir.switchBoolCambiaEscala();
        //createPir.switchBoolReabrir();
        //createPir.switchBoolCloseEnabled();
        //createPir.leerSecciones();
        //createPir.resetBooleanos();
        //createPir.getLookupField();
        //createPir.cargarVisual();
        //createPir.getBagImageMaleta();
        //createPir.cargarImgMaletaOn();
        //createPir.getBagImageTipo();
        //createPir.getBagImageColor();
        //createPir.mostrarContenido();
        //createPir.guardarContenido();
        //createPir.newBag();
        //createPir.updateContent();
        //createPir.suspenderBag();
        //createPir.deleteCont();
        //createPir.contWT();
        //createPir.delayToDamage();