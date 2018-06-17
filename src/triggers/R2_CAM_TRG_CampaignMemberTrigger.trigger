/*---------------------------------------------------------------------------------------------------------------------
    Author:         
    Company:        Accenture
    Description:    Trigger para manejar Miembros de campanha 
    IN:             
    OUT:            
    ----------------------------------------------------------------------------------------------------------------------*/
trigger R2_CAM_TRG_CampaignMemberTrigger on CampaignMember (after insert) {
  
  List<CampaignMember> news = trigger.new;
    List<CampaignMember> olds = trigger.old;
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
          System.debug(LoggingLevel.Info,'Trigger CampaignMember: Creamos e insertamos nuevo caso');
          R2_CAM_TRG_CamMemTriggerMethods.insertarCasoPorMiembroCampnha(news, false);
        }
    }
    
}