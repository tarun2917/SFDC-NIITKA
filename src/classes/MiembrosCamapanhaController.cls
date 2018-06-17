public with sharing class MiembrosCamapanhaController {
	
	private final CampaignMember miembroCampanha;
	public Case caso{get;set;}
	public Contact contacto{get;set;}
	private ApexPages.StandardController con;
	
	
	
	public MiembrosCamapanhaController(ApexPages.StandardController stdController) {
		con = stdController;
        this.miembroCampanha = (CampaignMember)stdController.getRecord();
        String idCampanha = (String)Apexpages.currentPage().getParameters().get('campanhaId');
        System.debug(LoggingLevel.Info,'Se pasa el id de campanha: '+idCampanha);
        this.miembroCampanha.campaignId = idCampanha;
	}
    
	public PageReference save(){
    	try{
        	PageReference ref = con.save();
            return ref;
            //PageReference pageRef = new PageReference('/' +this.miembroCampanha.Id);         
            //pageRef.setRedirect(true);
            //return pageRef;
        }catch(Exception e){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage())); 
            return null;
        }
    	//return null;
    }    
	
	public PageReference cancel() {
		//PageReference pageRef = new PageReference('/apex/INC_Liquidaciones');
		PageReference pageRef = new PageReference('/'+ApexPages.currentPage().getParameters().get('campanhaId'));
		pageRef.setRedirect(true);
		return pageRef;

	}
	
	
	
	
    
}