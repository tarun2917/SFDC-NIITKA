global class R1_BTCH_MergeClients implements Database.Batchable<sObject>,Database.Stateful { 

	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
	Author:        Alvaro Garcia 
	Company:       Accenture
	Description:   

	
	History: 
	
	<Date>                  <Author>                <Change Description>
	05/05/2017              Alvaro Garcia          	Initial Version     
	--------------------------------------------------------------------------------------------------------------------------------------------------------*/
	
	global Integer contador;

	global R1_BTCH_MergeClients(Integer cont) {
		contador = cont + 1;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {

		String query = 'SELECT R1_DUP_TXT_Golden_Record_Master__c, R1_DUP_TXT_Golden_Record_Duplicado__c, R1_DUP_CHK_No_Procesados__c FROM R1_Cliente_duplicado__c';

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<R1_Cliente_duplicado__c> scope) { 

   		List<Id> errorId_list = new List<Id>();

   		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

	   		System.debug('Batch: R1_BTCH_MergeClients --> scope: ' + scope);
			
			//crea el mapa con clave GR duplicado y valor GR master
	   		map <String, String> map_dup_Master = new map <String, String>();

	   		for (R1_Cliente_duplicado__c client : scope) {
	   			map_dup_Master.put(client.R1_DUP_TXT_Golden_Record_Duplicado__c, client.R1_DUP_TXT_Golden_Record_Master__c);
	   		}

	   		//comprueba si hay registros que procesar
	   		if (!map_dup_Master.isEmpty()) {
	   			System.debug(' entra map_dup_Master; ' + map_dup_Master);

	   			//llama a la funcion que va a realizar el merge y recogemos clientes que no hayan podido ser duplicados
		   		errorId_list = R1_CLS_MergeAccount.mergeAccounts(map_dup_Master);
		   		System.debug(' sale errorId_list; ' + errorId_list);
		   		//List<Account> accList = [SELECT R1_ACC_TXT_Id_Golden_record__c FROM Account WHERE Id = :errorId_list];
		   		
		   		Set <String> gr_Set = new Set <String>();
		   		
		   		//Obtiene los golden record de los clientes duplicados que no han podido unirse con el cliente master
		   		for(Account acc : [SELECT R1_ACC_TXT_Id_Golden_record__c FROM Account WHERE Id = :errorId_list]) {
		   			gr_Set.add(acc.R1_ACC_TXT_Id_Golden_record__c);
		   		}

		   		System.debug(' sale gr_Set; ' + gr_Set);

		   		List <R1_Cliente_duplicado__c> toDelete = new List<R1_Cliente_duplicado__c>();
		   		List <R1_Cliente_duplicado__c> toUpdate = new List<R1_Cliente_duplicado__c>();
		   		List <Account> lst_AccUpdate = new List <Account>();

		   		//recorre los clientes duplicados para comprobar si se ha hecho correctamente el merge para cada uno de ellos
		   		for (R1_Cliente_duplicado__c clientDuplicado : scope) {
		   			System.debug(' sale clientDuplicado; ' + clientDuplicado);
		   			System.debug(' sale gr_Set.contains(clientDuplicado.R1_DUP_TXT_Golden_Record_Duplicado__c); ' + gr_Set.contains(clientDuplicado.R1_DUP_TXT_Golden_Record_Duplicado__c));
		   			
		   			//comprueba que si los clientes duplicados han sido o no procesados
		   			if (!gr_Set.contains(clientDuplicado.R1_DUP_TXT_Golden_Record_Duplicado__c)) {
		   				toDelete.add(clientDuplicado);
		   				Account acc = new Account(R1_ACC_TXT_Id_Golden_record__c = clientDuplicado.R1_DUP_TXT_Golden_Record_Duplicado__c, R1_ACC_CHK_Duplicate__c = true);
		   				lst_AccUpdate.add(acc);
		   			}
		   			else {
		   				clientDuplicado.R1_DUP_CHK_No_Procesados__c = true;
		   				toUpdate.add(clientDuplicado);
		   			}
		   		}

		   		System.debug(' sale toDelete; ' + toDelete);

		   		if (!lst_AccUpdate.isEmpty()) {
		   			Database.UpsertResult [] updAcc = Database.upsert(lst_AccUpdate , Account.R1_ACC_TXT_Id_Golden_record__c,false);
		   		}
		   		//elimina los clientes duplicados que han sido procesados
		   		if (!toDelete.isEmpty()) {
		   			delete toDelete;
		   		}

		   		//actualiza los clientes duplicados que no han podido ser procesados con el valor de no procesados a true
		   		if (!toUpdate.isEmpty()) {
		   			update toUpdate;
		   		}
	   		} 
	   		
		
		}catch(Exception exc){

			R1_CLS_LogHelper.generateErrorLog('R1_BTCH_MergeClients.execute()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Cliente_duplicado__c');
		}

	}
	
	global void finish(Database.BatchableContext BC) {

		try{
    		if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;    

    		//query para comprobar si hay mas registros no procesados, en ese caso llamar al batch
    		List <R1_Cliente_duplicado__c> lst_Merge = [SELECT Id FROM R1_Cliente_duplicado__c LIMIT 1]; 

    		if (contador < 3 && lst_Merge.size() > 0) {
    			Database.executeBatch(new R1_BTCH_MergeClients(contador));
    		}
    		else {//en otro caso llamada al job con today +1 y la hora que este en el custom setting
    			//List <R1_Cliente_duplicado__c> lst_NoProcesados = [SELECT R1_DUP_CHK_No_Procesados__c FROM R1_Cliente_duplicado__c LIMIT 1];
    			
    			if (!lst_Merge.isEmpty()) {
					// Envia email
					/*List<User> destinatarios = [SELECT Id, Email FROM User WHERE Username = 'r.pingarron.jerez@accenture.com.service'
                                                AND Username = 'alvaro.garcia.tapia@accenture.com.service'];
                    List<String> correos = new List<String>();
                    for(User dest : destinatarios){
                        correos.add(dest.Email);
                    }
              			
                    if(!correos.isEmpty()){
                        R1_CLS_Utilities.enviarEmail(correos, 1);
                    }                        
                    */    
    				R1_CLS_LogHelper.generateErrorLog('R1_BTCH_MergeClients.finish()', '', 'Error: No han sido procesados todos los clientes duplicados', 'R1_Cliente_duplicado__c');

	    			//for (R1_Cliente_duplicado__c noProc : lst_NoProcesados) {
	    			//	noProc.R1_DUP_CHK_No_Procesados__c = true;
	    			//}

    				//update lst_NoProcesados;
    			}

    			Datetime fecha = DateTime.newInstance(date.today().addDays(1).year(), date.today().addDays(1).month(), date.today().addDays(1).day(), 00, 00, 00);
				Datetime fechaHora = fecha.addHours(R1_Job_Helper__c.getInstance('R1_Merge_JOB').R1_DT_Hora_inicio_Job__c.hour());
				System.debug('fechaHora: ' + fechaHora);
    			//Programamos el job para la siguiente ejecucion 
    			System.schedule('Merge_DeduplicatedClients_JOB' + DateTime.now(), R1_CLS_Utilities.generateStrProg(fechaHora), new R1_JOB_MergeClients());
    		}
	   		
		
		}catch(Exception exc){

			R1_CLS_LogHelper.generateErrorLog('R1_BTCH_MergeClients.finish()', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_Cliente_duplicado__c');
		}
	}
	
}