/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:

    History:

    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class R1_CAS_CaseTriggerMethods {
	/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        David Barco
    Company:       Accenture
    Description:   Método que crea asignaciones en las cuentas relacionadas a los casos que se están insertando
    			   si dichas cuentas no tienen una asignación previa
    			   Method that create entitlement in the related account of the case of the trigger.new
    			   if this related accounts haven´t entitlement

    History:

    <Date>                  <Author>                <Change Description>
    27/07/2017              David Barco             Initial Version
		05/12/2017              Jaime Ascanta           add recortypes condition
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
	public static void creaEntitlement(List<Case> news){
    try{
      //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true;
      if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');}

			// solo para estos RT
			Map<ID, RecordType> mapRT = new Map<ID, RecordType>([SELECT Id, DeveloperName, Name FROM RecordType WHERE DeveloperName IN ('R1_Claims','R1_Assistance', 'R1_Outbound_campaigns','R1_Iberia_Plus_Program','R1_Call_Pass_Througth_JBA','R1_Congratulation','R1_Help_Desk_OW','R1_Iberia_com','R1_Proactivity','R1_Outgoing','R1_Transferred','R1_Flights_in_obtaining','R1_Flights_in_redemption') ]);

      Set<Id> setAccIds = new Set<Id>();
      for(Case c :news){
        if(c.AccountId != null &&  !setAccIds.contains(c.AccountId) && mapRT.containsKey(c.RecordTypeId) ){
          setAccIds.add(c.AccountId);
        }
      }

      if(!setAccIds.isEmpty()){
        //lista para comprobar si ya existe una asignacion para la cuenta relacionada a ese caso
        Set<Id> set_ent_accId = new Set<Id>();
        for(Entitlement e :[SELECT Id, AccountId, Account.Name FROM Entitlement WHERE AccountId IN :setAccIds]){
          set_ent_accId.add(e.AccountId);
          System.debug('===== Existe asignación para la cuenta ' + e.Account.Name);
        }

        //listado de cuentas que están relacionados a los casos nuevos
        List<Account> lst_acc = [SELECT Id, Name FROM Account WHERE Id IN :setAccIds];

        if(!lst_acc.isEmpty()){

          //para obtener su id dinamicamente en cada entorno
          SlaProcess slaProcess = [SELECT Id FROM SlaProcess WHERE Name = 'SLA CCPO' AND IsActive = true LIMIT 1];

          List<Entitlement> lst_ent = new List<Entitlement>();
          for(Account acc :lst_acc){
            //Filtro para que no se cree una asignación cuando la cuenta relacionada con el caso ya tenga una
            if(!set_ent_accId.contains(acc.Id)){
              System.debug('===== Se crea una asignación para la cuenta ' + acc.Name);
              Entitlement e = new Entitlement();
              e.AccountId = acc.Id;
              e.Name = 'Standard Web Support';

              if(slaProcess != null){
                e.SlaProcessId = slaProcess.Id;
              }

              e.StartDate = Date.today();
              e.Type = 'Web Support';

              lst_ent.add(e);
            }else{
              System.debug('===== La cuenta ' + acc.Name + ' ya tiene una asignación creada');
            }
          }
          insert lst_ent;

          for(Entitlement e: [SELECT Id, AccountId FROM Entitlement WHERE AccountId IN :setAccIds]){
            for(Case c :news){
              if(c.AccountId == e.AccountId){
                c.EntitlementId = e.Id;
              }
            }
          }
        }
      }
    }catch(Exception exc){
	    R1_CLS_LogHelper.generateErrorLog('R1_CLS_AccountTriggerMethods.callIntegrationMDM()', '', exc.getmessage()+', '+exc.getLineNumber(), 'Account');
	}
  }
}