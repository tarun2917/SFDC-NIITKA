@isTest
public with sharing class R2_CAM_TRG_CamMemTriggerMethods_Test {
	
	@isTest
	static void insertarCasoPorMiembroCampnha_Test(){
		//insertar miembro de campaña
		//el created byId va a ser el usuario de test
		CampaignMember miembroCampanha = new CampaignMember();
		List<CampaignMember> miembros = new List<CampaignMember>();
		
		
        Contact contacto=new Contact(LastName='Contacto_Test');
        insert contacto;
        
	 	Campaign Campana = new Campaign();
        Campana.name = 'campanhaTest';
        
        insert Campana;
	 	
	 	miembroCampanha.campaignid = Campana.id;
	 	miembroCampanha.ContactId = contacto.id;
	 	
	 	miembros.add(miembroCampanha);
	 	
	 	//select para extraer el id del miembro de campaña
		
		//consultar caso
    	//ver que los campos coinciden
    	
    	Test.startTest();
    	insert miembros;
        //R2_CAM_TRG_CamMemTriggerMethods.insertarCasoPorMiembroCampnha(miembros);
        
        List<Case> casos =  [select id, R2_CAS_LOO_Campaigns__c,ContactId FROM case where R2_CAS_LOO_Campaigns__c =: Campana.id];
        System.assertEquals(miembroCampanha.campaignid, casos[0].R2_CAS_LOO_Campaigns__c);
		System.assertEquals(miembroCampanha.ContactId, casos[0].ContactId);
		Test.stopTest();
		
	}
	
}