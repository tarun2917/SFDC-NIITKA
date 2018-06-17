global with sharing class R2_CAM_TRG_CamMemTriggerMethods {
/*---------------------------------------------------------------------------------------------------------------------
Author:
Company:        Accenture
Description:    Metodo que inserta un caso al crear un CampaignMember de campanha manualmente
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
??            ??                    Initial Version
15/03/2018        Alberto Puerto Collado          In insertarCasoPorMiembroCampnha Several Field Names has been changed, Currency to Num or TXT to Date. Objects affected: Case & CampaignMember
																	Fields fixed: CMM -> R2_CMM_NUM_cash_bus_seg1__c; R2_CMM_NUM_cash_bus_seg2__c; R2_CMM_NUM_cash_TP_seg2__c; R2_CMM_DAT_creation_date__c; R2_CMM_NUM_cash_TP_seg1__c; R2_CMM_NUM_avios_TP_seg1__c;
																					CASE-> R2_CAS_NUM_cash_bus_seg1__c; R2_CAS_NUM_avios_bus_seg1__c; R2_CAS_NUM_cash_bus_seg2__c; R2_CAS_NUM_avios_bus_seg2__c;R2_CAS_NUM_cash_TP_seg2__c;R2_CAS_NUM_avios_TP_seg2__c;R2_CAS_DAT_creation_date__c;R2_CAS_NUM_cash_TP_seg1__c; R2_CAS_NUM_avios_TP_seg1__c;R2_CAS_NUM_avios_bus_others__c ; R2_CAS_NUM_cash_bus_other__c.
11/04/2018          Alvaro Garcia Tapia	   	     Added getCampaignMemberbyId
11/04/2018			Alvaro Garcia Tapia			In insertarCasoPorMiembroCampnha added the param bypassOwner
----------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Alvaro Garcia Tapia
Company:        Accenture
Description:    Methdo call by a button, to create a case with the data of the campaignMember
				This method get a record of a campaignMember through the Id by the param and call the method that create the case
IN:         

OUT:           

History:

<Date>              <Author>                 <Description>
11/04/2018          Alvaro Garcia Tapia	   	 Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/  
	webservice static void getCampaignMemberbyId(Id campgMemberId){
		try{
			String s_Object = 'CampaignMember';
			String Query = R1_CLS_Utilities.dynamicQuery(s_Object)+ ' FROM ' + s_Object + ' WHERE Id = \'' + campgMemberId + '\' LIMIT 1';
			
			List<CampaignMember> campaignmember_lst = DataBase.query(Query);
			insertarCasoPorMiembroCampnha(campaignmember_lst, true);
		
		}catch(Exception exc){
		R1_CLS_LogHelper.generateErrorLog('R2_CAM_TRG_CamMemTriggerMethods.getCampaignMemberbyId()', '', exc.getmessage()+', '+exc.getLineNumber(), 'CampaignMember');
		}
		
	}

/*---------------------------------------------------------------------------------------------------------------------
Author:
Company:        Accenture
Description:    Metodo que inserta un caso al crear un CampaignMember de campanha manualmente
IN:
OUT:

History:
<Date>                     <Author>                         <Change Description>
??            				??                    	Initial Version
15/03/2018        	Alberto Puerto Collado          Several Field Names has been changed, Currency to Num or TXT to Date. Objects affected: Case & CampaignMember
																	Fields fixed: CMM -> R2_CMM_NUM_cash_bus_seg1__c; R2_CMM_NUM_cash_bus_seg2__c; R2_CMM_NUM_cash_TP_seg2__c; R2_CMM_DAT_creation_date__c; R2_CMM_NUM_cash_TP_seg1__c; R2_CMM_NUM_avios_TP_seg1__c;
																					CASE-> R2_CAS_NUM_cash_bus_seg1__c; R2_CAS_NUM_avios_bus_seg1__c; R2_CAS_NUM_cash_bus_seg2__c; R2_CAS_NUM_avios_bus_seg2__c;R2_CAS_NUM_cash_TP_seg2__c;R2_CAS_NUM_avios_TP_seg2__c;R2_CAS_DAT_creation_date__c;R2_CAS_NUM_cash_TP_seg1__c; R2_CAS_NUM_avios_TP_seg1__c;R2_CAS_NUM_avios_bus_others__c ; R2_CAS_NUM_cash_bus_other__c.
11/04/2018			Alvaro Garcia Tapia				Added the param bypassOwner
----------------------------------------------------------------------------------------------------------------------*/
	public static void insertarCasoPorMiembroCampnha(List<CampaignMember> miembrosCampanha, Boolean bypassOwner){
		try{
			 if (miembrosCampanha.size()==1){
				 CampaignMember miembroCampanha = miembrosCampanha[0];
				 List<User> usuarios = [Select u.Name, u.Id, u.Email From User u where u.name='MC System User'];
				 Id idUsuarioProcAuto = usuarios[0].id;
				 
				 if (bypassOwner || miembroCampanha.createdById != idUsuarioProcAuto){
					 System.debug(LoggingLevel.Info,'R2_CAM_TRG_CamMemTriggerMethods insertarCasoPorMiembroCampnha: insertamos nuevo caso');
					 Case caso = new Case();
					 caso.R2_CAS_LOO_Campaigns__c = miembroCampanha.CampaignId;
					 caso.ContactId = miembroCampanha.ContactId;
					 Id rtCamSal = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Campañas salientes').getRecordTypeId();
					 caso.RecordtypeId = rtCamSal;
					 System.debug(LoggingLevel.Info,'Caso con recorTypeId: '+rtCamSal);
					 //caso.RecordtypeId = '01258000000AiuRAAS';//campanhas salientes
					 
					 caso.Origin = 'Llamada';
					 caso.Status = 'Abierto';
					 
					 if (miembroCampanha.R2_CMM_TXT_upg_surname__c!=null){
						 caso.R2_CAS_TXT_upg_surname__c = miembroCampanha.R2_CMM_TXT_upg_surname__c;
					 }
					 if (miembroCampanha.R2_CMM_PK_answer__c!=null){
						caso.R2_CAS_PK_answer__c = miembroCampanha.R2_CMM_PK_answer__c;
					 }
					 if (miembroCampanha.R2_CMM_PK_Avios_Cash__c!=null){
						caso.R2_CAS_PK_Avios_Cash__c= miembroCampanha.R2_CMM_PK_Avios_Cash__c;
					 }
					 if (miembroCampanha.R2_CMM_NUM_ticket__c!=null){
						caso.R2_CAS_NUM_ticket__c= miembroCampanha.R2_CMM_NUM_ticket__c;
					 }
					 if (miembroCampanha.R2_CMM_TXT_class__c!=null){
						caso.R2_CAS_TXT_class__c= miembroCampanha.R2_CMM_TXT_class__c;
					 }
					 if (miembroCampanha.R2_CMM_TXT_CLTV__c!=null){
						caso.R2_CAS_TXT_CLTV__c= miembroCampanha.R2_CMM_TXT_CLTV__c;
					 }
					 /*
					 if (miembroCampanha.R2_CMM_TXT_card_type_code__c!=null){
						caso.R2_CAS_TXT_card_type_code__c= miembroCampanha.R2_CMM_TXT_card_type_code__c;
					 }
					 */
					 if (miembroCampanha.R2_CMM_TXT_company__c!=null){
						caso.R2_CAS_TXT_company__c= miembroCampanha.R2_CMM_TXT_company__c;
					 }
					 if (miembroCampanha.R2_CMM_TXT_personal_contact__c!=null){
						caso.R2_CAS_TXT_personal_contact__c= miembroCampanha.R2_CMM_TXT_personal_contact__c;
					 }
					 if (miembroCampanha.R2_CMM_TXT_dest__c!=null){
						caso.R2_CAS_TXT_dest__c= miembroCampanha.R2_CMM_TXT_dest__c;
					 }
					 if (miembroCampanha.R2_CMM_EMA_Email__c!=null){
						caso.R2_CAS_EMA_Email__c= miembroCampanha.R2_CMM_EMA_Email__c;
					 }
					//caso.R2_CAS_DAT_creation_date__c= miembroCampanha.R2_CMM_DAT_creation_date__c; date to string
					
					if (miembroCampanha.R2_CMM_DAT_flight_date2__c!=null){
						caso.R2_CAS_DAT_flight_date2__c = miembroCampanha.R2_CMM_DAT_flight_date2__c;
					}
					if (miembroCampanha.R2_CMM_DAT_flight_date__c!=null){
						caso.R2_CAS_DAT_flight_date__c = miembroCampanha.R2_CMM_DAT_flight_date__c;
					}
					if (miembroCampanha.R2_CMM_DAT_Answer_date__c!=null){
						caso.R2_CAS_DAT_Answer_date__c = miembroCampanha.R2_CMM_DAT_Answer_date__c;
					}
					if (miembroCampanha.R2_CMM_TXT_flag_seat_type__c!=null){
						caso.R2_CAS_TXT_flag_seat_type__c = miembroCampanha.R2_CMM_TXT_flag_seat_type__c;
					}
					
					if (miembroCampanha.R2_CMM_TXT_upg_flag__c!=null){
						caso.R2_CAS_TXT_upg_flag__c = miembroCampanha.R2_CMM_TXT_upg_flag__c;
					}
					
					if (miembroCampanha.R2_CMM_TXT_upg_flag_seg2__c!=null){
						caso.R2_CAS_TXT_upg_flag_seg2__c = miembroCampanha.R2_CMM_TXT_upg_flag_seg2__c;
					}
					if (miembroCampanha.R2_CMM_PKL_time_zone__c!=null){
						caso.R2_CAS_PKL_time_zone__c = miembroCampanha.R2_CMM_PKL_time_zone__c;
					}
					if (miembroCampanha.R2_CMM_TXT_Contact_schedule__c!=null){
						caso.R2_CAS_TXT_Contact_schedule__c = miembroCampanha.R2_CMM_TXT_Contact_schedule__c;
					}
					if (miembroCampanha.R2_CMM_NUM_frustation__c!=null){
						caso.R2_CAS_NUM_frustation__c = miembroCampanha.R2_CMM_NUM_frustation__c;
					}
					if (miembroCampanha.R2_CMM_gender__c!=null){
						caso.R2_CAS_gender__c = miembroCampanha.R2_CMM_gender__c;
					}
					if (miembroCampanha.R2_CMM_TXT_flight_hour__c!=null){
						caso.R2_CAS_TXT_flight_hour__c = miembroCampanha.R2_CMM_TXT_flight_hour__c;
					}
					if (miembroCampanha.R2_CMM_TXT_ib_order__c!=null){
						caso.R2_CAS_TXT_ib_order__c = miembroCampanha.R2_CMM_TXT_ib_order__c;
					}
					if (miembroCampanha.R1_CMM_PKL_Idioma__c!=null){
						caso.R1_CAS_PKL_Idioma__c = miembroCampanha.R1_CMM_PKL_Idioma__c;
					}
					if (miembroCampanha.R2_CMM_TXT_key__c!=null){
						caso.R2_CAS_TXT_key__c = miembroCampanha.R2_CMM_TXT_key__c;
					}
					if (miembroCampanha.R2_CMM_TXT_Amadeus_Locator__c!=null){
						caso.R2_CAS_TXT_Amadeus_Locator__c = miembroCampanha.R2_CMM_TXT_Amadeus_Locator__c;
					}
					if (miembroCampanha.R2_CMM_TXT_Resiber_Locator__c!=null){
						caso.R2_CAS_TXT_Resiber_Locator__c = miembroCampanha.R2_CMM_TXT_Resiber_Locator__c;
					}
					if (miembroCampanha.R2_CMM_PH_movile_phone__c!=null){
						caso.R2_CAS_PH_movile_phone__c = miembroCampanha.R2_CMM_PH_movile_phone__c;
					}
					if (miembroCampanha.R1_CMM_TXT_Card_Type__c!=null){
						caso.R1_CAS_TXT_Card_Type__c = miembroCampanha.R1_CMM_TXT_Card_Type__c;
					}
					if (miembroCampanha.R2_CMM_TXT_upg_name__c!=null){
						caso.R2_CAS_TXT_upg_name__c = miembroCampanha.R2_CMM_TXT_upg_name__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_euros__c!=null){
						caso.R2_CAS_NUM_number_upgs_euros__c = miembroCampanha.R2_CMM_NUM_number_upgs_euros__c;
					}
					if (miembroCampanha.R2_CMM_TXT_segment_number__c!=null){
						caso.R2_CAS_TXT_segment_number__c = miembroCampanha.R2_CMM_TXT_segment_number__c;
					}
					if (miembroCampanha.R2_CMM_TXT_Flight_number__c!=null){
						caso.R2_CAS_TXT_Flight_number__c = miembroCampanha.R2_CMM_TXT_Flight_number__c;
					}
					if (miembroCampanha.R2_CMM_TXT_iberiacom_number__c!=null){
						caso.R2_CAS_TXT_iberiacom_number__c = miembroCampanha.R2_CMM_TXT_iberiacom_number__c;
					}
					if (miembroCampanha.R2_CMM_TXT_flight_number_segment2__c!=null){
						caso.R2_CAS_TXT_flight_number_segment2__c = miembroCampanha.R2_CMM_TXT_flight_number_segment2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_order1__c!=null){
						caso.R2_CAS_NUM_order1__c = miembroCampanha.R2_CMM_NUM_order1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_order2__c!=null){
						caso.R2_CAS_NUM_order2__c = miembroCampanha.R2_CMM_NUM_order2__c;
					}
					if (miembroCampanha.R2_CMM_TXT_origin__c!=null){
						caso.R2_CAS_TXT_origin__c = miembroCampanha.R2_CMM_TXT_origin__c;
					}
					
					//segmento 1
					if (miembroCampanha.R2_CMM_DAT_time_flight_segment1__c!=null){
						caso.R2_CAS_DAT_time_flight_segment1__c= miembroCampanha.R2_CMM_DAT_time_flight_segment1__c;
					}
					if (miembroCampanha.R2_CMM_CUR_Highest_Price_Cash_Seg1__c!=null){
						caso.R2_CAS_CUR_Highest_Price_Cash_Seg1__c= miembroCampanha.R2_CMM_CUR_Highest_Price_Cash_Seg1__c;
					}
					if (miembroCampanha.R2_CMM_CUR_Highest_Price_Avios_Seg1__c!=null){
						caso.R2_CAS_CUR_Highest_Price_Avios_Seg1__c= miembroCampanha.R2_CMM_CUR_Highest_Price_Avios_Seg1__c;
					}
					if (miembroCampanha.R2_CMM_DAT_date_flight_segment1__c!=null){
						caso.R2_CAS_DAT_date_flight_segment1__c= miembroCampanha.R2_CMM_DAT_date_flight_segment1__c;
					}
					if (miembroCampanha.R2_CMM_TXT_destination_segment1__c!=null){
						caso.R2_CAS_TXT_destination_segment1__c= miembroCampanha.R2_CMM_TXT_destination_segment1__c;
					}
					if (miembroCampanha.R2_CMM_TXT_company_segment1__c!=null){
						caso.R2_CAS_TXT_company_segment1__c= miembroCampanha.R2_CMM_TXT_company_segment1__c;
					}
					if (miembroCampanha.R2_CMM_TXT_class_segment1__c!=null){
						caso.R2_CAS_TXT_class_segment1__c= miembroCampanha.R2_CMM_TXT_class_segment1__c;
					}
					if (miembroCampanha.R2_CMM_TXT_flight_number_segment1__c!=null){
						caso.R2_CAS_TXT_flight_number_segment1__c= miembroCampanha.R2_CMM_TXT_flight_number_segment1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_TP_S1__c!=null){
						caso.R2_CAS_NUM_number_upgs_TP_S1__c= miembroCampanha.R2_CMM_NUM_number_upgs_TP_S1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_TP_euros_S1__c!=null){
						caso.R2_CAS_NUM_number_upgs_TP_euros_S1__c= miembroCampanha.R2_CMM_NUM_number_upgs_TP_euros_S1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_bus_euros_S1__c!=null){
						caso.R2_CAS_NUM_number_upgs_bus_euros_S1__c= miembroCampanha.R2_CMM_NUM_number_upgs_bus_euros_S1__c;
					}
					if (miembroCampanha.R2_CMM_TXT_segment1_origin__c!=null){
						caso.R2_CAS_TXT_segment1_origin__c= miembroCampanha.R2_CMM_TXT_segment1_origin__c;
					}
					if (miembroCampanha.R2_CMM_NUM_avios_bus_seg1__c!=null){
						caso.R2_CAS_NUM_avios_bus_seg1__c= miembroCampanha.R2_CMM_NUM_avios_bus_seg1__c;//
					}
					if (miembroCampanha.R2_CMM_NUM_avios_TP_seg1__c!=null){
						caso.R2_CAS_NUM_avios_TP_seg1__c= miembroCampanha.R2_CMM_NUM_avios_TP_seg1__c;
					}
					//caso.R2_CAS_NUM_cash_bus_seg1__c= miembroCampanha.R2_CMM_NUM_cash_bus_seg1__c;//no existe en caso
					if (miembroCampanha.R2_CMM_NUM_cash_bus_seg1__c!=null){
						caso.R2_CAS_NUM_cash_bus_seg1__c= miembroCampanha.R2_CMM_NUM_cash_bus_seg1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_cash_TP_seg1__c!=null){
						caso.R2_CAS_NUM_cash_TP_seg1__c= miembroCampanha.R2_CMM_NUM_cash_TP_seg1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_bus_limit_seg1__c!=null){
						caso.R2_CAS_NUM_bus_limit_seg1__c= miembroCampanha.R2_CMM_NUM_bus_limit_seg1__c;
					}
					if (miembroCampanha.R2_CMM_NUM_TP_limit_seg1__c!=null){
						caso.R2_CAS_NUM_TP_limit_seg1__c= miembroCampanha.R2_CMM_NUM_TP_limit_seg1__c;
					}
					
					//segmento 2
					if (miembroCampanha.R2_CMM_DAT_time_flight_segment2__c!=null){
						caso.R2_CAS_DAT_time_flight_segment2__c = miembroCampanha.R2_CMM_DAT_time_flight_segment2__c;
					}
					if (miembroCampanha.R2_CMM_CUR_Highest_Price_Cash_Seg2__c!=null){
						caso.R2_CAS_CUR_Highest_Price_Cash_Seg2__c = miembroCampanha.R2_CMM_CUR_Highest_Price_Cash_Seg2__c;
					}
					if (miembroCampanha.R2_CMM_CUR_Highest_Price_Avios_Seg2__c!=null){
						caso.R2_CAS_CUR_Highest_Price_Avios_Seg2__c = miembroCampanha.R2_CMM_CUR_Highest_Price_Avios_Seg2__c;
					}
					if (miembroCampanha.R2_CMM_DAT_date_flight_segment2__c!=null){
						caso.R2_CAS_DAT_date_flight_segment2__c = miembroCampanha.R2_CMM_DAT_date_flight_segment2__c;
					}
					if (miembroCampanha.R2_CMM_TXT_destination_segment2__c!=null){
						caso.R2_CAS_TXT_destination_segment2__c = miembroCampanha.R2_CMM_TXT_destination_segment2__c;
					}
					if (miembroCampanha.R2_CMM_TXT_company_segment2__c!=null){
						caso.R2_CAS_TXT_company_segment2__c = miembroCampanha.R2_CMM_TXT_company_segment2__c;
					}
					if (miembroCampanha.R2_CMM_TXT_class_segment2__c!=null){
						caso.R2_CAS_TXT_class_segment2__c = miembroCampanha.R2_CMM_TXT_class_segment2__c;
					}
					if (miembroCampanha.R2_CMM_TXT_segment2_origin__c!=null){
						caso.R2_CAS_TXT_segment2_origin__c = miembroCampanha.R2_CMM_TXT_segment2_origin__c;
					}
					if (miembroCampanha.R2_CMM_PK_client_country__c!=null){
						caso.R2_CAS_PK_client_country__c = miembroCampanha.R2_CMM_PK_client_country__c;
						caso.R2_CAS_PKL_Country__c = miembroCampanha.R2_CMM_PK_client_country__c;
					}
					//caso.R2_CAS_NUM_avios_bus_seg2__c = miembroCampanha.R2_CMM_NUM_avios_bus_seg2__c;
					
					if (miembroCampanha.R2_CMM_CUR_avios_TP_seg2__c!=null){
						caso.R2_CAS_NUM_avios_TP_seg2__c = miembroCampanha.R2_CMM_CUR_avios_TP_seg2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_cash_bus_seg2__c!=null){
						caso.R2_CAS_NUM_cash_bus_seg2__c = miembroCampanha.R2_CMM_NUM_cash_bus_seg2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_TP_euros_S2__c!=null){
						caso.R2_CAS_NUM_number_upgs_TP_euros_S2__c = miembroCampanha.R2_CMM_NUM_number_upgs_TP_euros_S2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_TP_S2__c!=null){
						caso.R2_CAS_NUM_number_upgs_TP_S2__c = miembroCampanha.R2_CMM_NUM_number_upgs_TP_S2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_bus_limit_seg2__c!=null){
						caso.R2_CAS_NUM_bus_limit_seg2__c = miembroCampanha.R2_CMM_NUM_bus_limit_seg2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_TP_limit_seg2__c!=null){
						caso.R2_CAS_NUM_TP_limit_seg2__c = miembroCampanha.R2_CMM_NUM_TP_limit_seg2__c;
					}
					if (miembroCampanha.R2_CMM_NUM_number_upgs_bus_euros_S2__c!=null){
						caso.R2_CAS_NUM_number_upgs_bus_euros_S2__c = miembroCampanha.R2_CMM_NUM_number_upgs_bus_euros_S2__c;
					}
					if (miembroCampanha.R2_CMM_DAT_flight_date_seg2__c!=null){
						caso.R2_CAS_DAT_flight_date_seg2__c = miembroCampanha.R2_CMM_DAT_flight_date_seg2__c;
					}
					/*
					*/
					if (miembroCampanha.R2_CMM_NUM_number_upgs__c!=null){
						caso.R2_CAS_NUM_number_upgs__c = miembroCampanha.R2_CMM_NUM_number_upgs__c;
					}
					/*No existe R2_CAS_NUM_avios_bus_others__c en caso
					if (miembroCampanha.R2_CMM_NUM_avios_bus_others__c!=null){//
						caso.R2_CAS_NUM_avios_bus_others__c = miembroCampanha.R2_CMM_NUM_avios_bus_others__c;
					}
					*/
					
					if (miembroCampanha.R1_CMM_PKL_type__c!=null){
						caso.type = miembroCampanha.R1_CMM_PKL_type__c; //type standar
					}
					if (miembroCampanha.R2_CMM_TEL_phone2__c!=null){
						caso.R2_CAS_TEL_phone2__c = miembroCampanha.R2_CMM_TEL_phone2__c; 
					}
					if (miembroCampanha.R2_CMM_TEL_contact_phone__c!=null){
						caso.R2_CAS_TEL_contact_phone__c = miembroCampanha.R2_CMM_TEL_contact_phone__c;
					}
					if (miembroCampanha.Description!=null){
						caso.Description = miembroCampanha.Description;
					}
					if (miembroCampanha.R2_CMM_PK_answer_Seg2__c!=null){
						caso.R2_CAS_PK_answer_Seg2__c = miembroCampanha.R2_CMM_PK_answer_Seg2__c;
					}
					/*No existe R2_CAS_PK_result__c en caso */
					if (miembroCampanha.R2_CMM_PK_result__c!=null){
						caso.R2_CAS_PK_resul__c = miembroCampanha.R2_CMM_PK_result__c; //en caso: R2_CAS_PK_resul__c 
					}
					
					/*No existe result_Seg2__c en caso*/
					if (miembroCampanha.R2_CMM_PK_result_Seg2__c!=null){
						caso.R2_CAS_PK_resul_Seg2__c = miembroCampanha.R2_CMM_PK_result_Seg2__c;
					}
					if (miembroCampanha.R2_CMM_PK_result_Seg2__c!=null){
						caso.R2_CAS_PK_reason__c = miembroCampanha.R2_CMM_PK_reason__c;
					}
					if (miembroCampanha.R2_CMM_PK_result_Seg2__c!=null){
						caso.R2_CAS_PK_reason_Seg2__c = miembroCampanha.R2_CMM_PK_reason_Seg2__c;
					}
					if (miembroCampanha.R2_CMM_PK_result_Seg2__c!=null){
						caso.R2_CAS_CHK_Segment1__c = miembroCampanha.R2_CMM_CHK_Segment1__c;
					}
					if (miembroCampanha.R2_CMM_PK_result_Seg2__c!=null){
						caso.R2_CAS_NUM_upg_type_seg2__c = miembroCampanha.R2_CMM_NUM_upg_type_seg2__c;
					}
					
					
					 insert caso;
				 }
			 }
		}catch(Exception exc){
						R1_CLS_LogHelper.generateErrorLog('R2_CAM_TRG_CamMemTriggerMethods.insertarCasoPorMiembroCampnha()', '', exc.getmessage()+', '+exc.getLineNumber(), 'CampaignMember');
		}
		
	}
		
}