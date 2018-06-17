public with sharing class R1_CLS_MergeAccount {

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
	Author:        Alvaro Garcia 
	Company:       Accenture
	Description:   

	
	History: 
	
	<Date>                  <Author>                <Change Description>
	05/05/2017              Alvaro Garcia          	Initial Version     
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
	Author:        Alvaro Garcia 
	Company:       Accenture
	Description:   Receive a map of golden record duplicated and masters and merge the transactional object that are in a custom setting calling an auxiliar method

	
	History: 
	
	<Date>                  <Author>                <Change Description>
	05/05/2017              Alvaro Garcia          	Initial Version     
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/
	public static List<Id> mergeAccounts (map<String,String> map_DupMaster) {

		List<Id> errorId_list = new List<Id>();

		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

    		System.debug('map_DupMaster; ' + map_DupMaster);
			//Guarda todos los golden record en un set para hacer la query sobre esos registros
			Set<String> setCodExt = new Set<String>();

			setCodExt.addAll(map_DupMaster.keySet());
			setCodExt.addAll(map_DupMaster.values());
			
			//List<Account> lst_Account = [SELECT Id, R1_ACC_TXT_Id_Golden_record__c FROM Account WHERE R1_ACC_TXT_Id_Golden_record__c IN :setCodExt];

			//mapa que almacena las id de salesforce correspondientes a los golden record recibidos
			Map <String,Account> map_ExtId = new Map <String,Account>();

			for (Account acc : [SELECT Id, R1_ACC_TXT_Id_Golden_record__c, PersonContactId FROM Account WHERE R1_ACC_TXT_Id_Golden_record__c IN :setCodExt]) {
				map_ExtId.put(acc.R1_ACC_TXT_Id_Golden_record__c, acc);
			}

			//mapa que contiene el mismo mapa que se recibe pero con los id de salesforce en vez de los golden record
			Map <Id,Id> map_IdDupMaster = new Map <Id,Id>();
			Map <Id,Id> map_IdDupContact = new Map <Id,Id>();
			for (String key : map_DupMaster.keySet()) {
				map_IdDupMaster.put(map_ExtId.get(key).Id,map_ExtId.get(map_DupMaster.get(key)).Id);
				map_IdDupContact.put(map_ExtId.get(key).Id,map_ExtId.get(map_DupMaster.get(key)).PersonContactId);
			}
			System.debug('map_IdDupMaster; ' + map_IdDupMaster);

			//Obtiene del custom setting todos los objetos que han de ser pasados al cliente master
			Map<String,R1_IntegrationObject__c> map_IntObjetos = R1_IntegrationObject__c.getAll();

			//comprueba si nos envian los objetos que se actualizan
			Integer i = 0;
			String objAux;
			for (String obj : map_IntObjetos.keySet()) {
				if (obj == 'Entitlement' && i > 0) { 
					obj = objAux; 
				}
				if (i == 0) {
					objAux = obj;
					obj = 'Entitlement';
					i++;
				}
				//errorId_list.addAll(updateObject(map_IdDupMaster, obj, map_IntObjetos.get(obj).R1_Field__c));
				//para cuando se ponga el gr previo**********************************************************************************
				errorId_list.addAll(updateObject(map_IdDupMaster, map_IdDupContact, obj, map_IntObjetos.get(obj).R1_Field__c, map_IntObjetos.get(obj).R1_TXT_GR_previous__c));
			}
			System.debug('!!!errorId_list: ' + errorId_list);

		}catch(Exception exc){

			R1_CLS_LogHelper.generateErrorLog('R1_CLS_MergeAccount.mergeAccounts()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
		}
		return errorId_list;

	}

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
	Author:        Alvaro Garcia 
	Company:       Accenture
	Description:   Change the lookUp field for account from the duplicate account to the master account

	
	History: 
	
	<Date>                  <Author>                <Change Description>
	05/05/2017              Alvaro Garcia          	Initial Version     
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/
	//public static List<Id> updateObject (map<Id,Id> map_IdDupMast, String obj, String lookUpAcc) {
	//para cuando se ponga el gr previo**********************************************************************************
	public static List<Id> updateObject (map<Id,Id> map_IdDupMast, Map <Id,Id> map_IdDupContact, String obj, String lookUpAcc, String grPrevio) {

		List<Id> srId_List = new List<Id>();

		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

			List <Id> lst_Id = new List<Id>();
			lst_Id.addAll(map_IdDupMast.keySet());

			//Busca todos los registros, del objeto introducido por parametro, que tienen que ser traspasados al cliente master
			String query = '';
			Map<Id,Id> map_IdAccContact = new Map<Id,Id>();
			if (obj == 'Case') {
				query = 'SELECT ' + lookUpAcc + ', ContactId, ' + grPrevio + ' FROM ' + obj + ' WHERE ' + lookUpAcc + ' IN: lst_Id';
			}
			else {
				query = 'SELECT ' + lookUpAcc + ', ' + grPrevio + ' FROM ' + obj + ' WHERE ' + lookUpAcc + ' IN: lst_Id';
			}
			//String query = 'SELECT ' + lookUpAcc + ' FROM ' + obj + ' WHERE ' + lookUpAcc + ' IN: lst_Id';
			//para cuando se ponga el gr previo**********************************************************************************
			System.debug('query; ' + query);

			List<SObject> toProccess = Database.query(query);
			List<SObject> toUpdate = new List<SObject>();
			List<Id> lst_clienteDupId = new List<Id>();
			
			System.debug('!!!obj; ' + obj);

			//recorre los registros obtenidos en la query y cambia el campo lookUp por el del cliente master
			for(SObject proc: toProccess){
				
				//almacena el cliente duplicado por si falla el deduplicado
				lst_clienteDupId.add((Id)proc.get(lookUpAcc));
				//para cuando se ponga el gr previo**********************************************************************************
				proc.put(grPrevio, (Id)proc.get(lookUpAcc));
				proc.put(lookUpAcc, map_IdDupMast.get((Id)proc.get(lookUpAcc)));
				if (obj == 'Case') {
					proc.put('ContactId', map_IdDupContact.get((Id)proc.get(lookUpAcc)));
				}
				toUpdate.add(proc);

			}

			System.debug('!!!toUpdate; ' + toUpdate);
			
			//actualiza los registros asociados a clientes duplicados
			List<Database.SaveResult> srList = new List<Database.SaveResult>();	
			if (!toUpdate.isEmpty()) {
				srList = Database.update(toUpdate, false);
			}

			//comprueba si algun registro no ha podido actualizarse correctamente
			if (!srList.isEmpty()) {
				System.debug('!!!antes srList: ' + srList);
				System.debug('!!!size srList: ' + srList.size());

				for (Integer i = 0; i < srList.size(); i++) {
					System.debug('!!!srList: ' + srList);
				
					if (!srList[i].isSuccess()) {
						srId_List.add(lst_clienteDupId[i]);
					}
				}
				System.debug('!!!srId_List: ' + srId_List);
			}

		}catch(Exception exc){

			R1_CLS_LogHelper.generateErrorLog('R1_CLS_MergeAccount.updateObject()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
		}

		//devuleve los ids de los clientes que no se han podido deduplicar
		return srId_List;
	}

}