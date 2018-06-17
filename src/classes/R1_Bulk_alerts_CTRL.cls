public with sharing class R1_Bulk_alerts_CTRL {
    
    public String collaborationGroupId {get;set;}
    public R1_Bulk_alerts_CTRL() {
        
        List<Profile> profiles = [SELECT Id, Name FROM Profile];
        List<CollaborationGroupMember> memberGroups = [SELECT Id, CollaborationGroupId, CollaborationGroup.Name FROM CollaborationGroupMember WHERE MemberId =: UserInfo.getUserId()];

        Map<String,Id> map_collaboration_groups = new Map<String,Id>();
        for(CollaborationGroupMember cgm: memberGroups){
            map_collaboration_groups.put(cgm.CollaborationGroup.Name, cgm.CollaborationGroupId);
        }

        for(Profile p: profiles){
            if(UserInfo.getProfileId() == p.Id){
                if(p.Name == 'Administrador del sistema' || p.Name == 'System Administrator'){
                    collaborationGroupId = map_collaboration_groups.get('All Iberia lineas Aereas de Espana');
                }else if(p.Name == 'Call Center CCPO'){
                    collaborationGroupId = map_collaboration_groups.get('CCPO');
                }else if(p.Name == 'Vip lounge'){
                    collaborationGroupId = map_collaboration_groups.get('VIP Lounge');
                }
            }
        }
    }
}