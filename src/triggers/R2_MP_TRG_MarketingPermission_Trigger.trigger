trigger R2_MP_TRG_MarketingPermission_Trigger on R1_Marketing_Permission__c (before update) {

	if(Trigger.isBefore){
		if(Trigger.isUpdate){
			boolean enviado = false;
			//Primer Flujo
			R1_Marketing_Permission__c all = R2_CLS_MP_TriggerMethods.getALLMP(trigger.new[0].R1_MP_LOO_Client__c,trigger.new[0].R1_MP_LOO_Loyalty_card__c);
				
			if(all != null){
				if(trigger.newMap.get(all.id) != null){

				}
				else{
					if(all.R1_MP_CHK_Flag_enabled__c == true && R2_CLS_MP_TriggerMethods.comprobarBajaGDPR(trigger.new[0].R1_MP_LOO_Client__c)){
						System.debug('Aqui no entro');
						List<id> lisIdMKT = new List<id>(trigger.newMap.keyset());
						R2_CLS_MP_TriggerMethods.enviarMPAIBCOM(lisIdMKT);
						enviado = true;
					}
				}
			}	
				//
			if(enviado == false){
				System.debug('Primer enviado a False');
				List<R1_Marketing_Permission__c> lstMPTrue = new List<R1_Marketing_Permission__c>();
				List<R1_Marketing_Permission__c> lstMPFalse = new List<R1_Marketing_Permission__c>();
				lstMPTrue = R2_CLS_MP_TriggerMethods.encontrarMPUpdateTrue(trigger.new);
				lstMPFalse = R2_CLS_MP_TriggerMethods.encontrarMPUpdateFalse(trigger.new);
					//Envio mp desde mkt a atos
				if(!lstMPTrue.isEmpty() &&  UserInfo.getName() == 'MC System User'){
					System.debug('Es el usuario de mkt');
					List<String> lstMKT = R2_CLS_MP_TriggerMethods.filtrarPermisosMKT(lstMPTrue);
					R2_CLS_MP_TriggerMethods.enviarMPAIBCOM(lstMKT);
					R2_CLS_MP_TriggerMethods.actualizarAll(lstMPTrue);
					enviado = true;
				}
				else if(!lstMPTrue.isEmpty()){
					System.debug('Primer enviado a False lstMPTRUE no vacia');
					R2_CLS_MP_TriggerMethods.actualizarMPTrue(lstMPTrue,trigger.oldMap);					
				}

				if(!lstMPFalse.isEmpty()){
					System.debug('Primer enviado a False lstMPFalse no vacia');
					List<String> lstMKT = R2_CLS_MP_TriggerMethods.filtrarPermisosMKTFalse(lstMPFalse);
					R2_CLS_MP_TriggerMethods.enviarMPAIBCOM(lstMKT);
					R2_CLS_MP_TriggerMethods.actualizarAll(lstMPFalse);
					enviado = true;
				}
			}
		}
	}
}