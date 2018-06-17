/*---------------------------------------------------------------------------------------------------------------------
    Author:         David Barco Infante
    Company:        Accenture
    Description:    Apex test class to 'R1_Bulk_alerts_CTRL'
    IN:             
    OUT:            

    History: 
     <Date>                <Author>                         <Change Description>
    24/07/2017             David Barco Infante              Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest (SeeAllData=true)
private class R1_Bulk_alerts_CTRL_TEST {
        /*---------------------------------------------------------------------------------------------------------------------
    Author:         David Barco Infante
    Company:        Accenture
    Description:    Metodo test para el constructor R1_Bulk_alerts_CTRL
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    24/07/2017             David Barco Infante                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/

	static testMethod void bulk_alert_test(){
		
		R1_Bulk_alerts_CTRL alerts = new R1_Bulk_alerts_CTRL();
		User u_ccpo = [SELECT Id, Name FROM User WHERE isActive = true AND Profile.Name = 'Call Center CCPO' AND UserPermissionsSupportUser = true limit 1];
        User u_vip = [SELECT Id, Name FROM User WHERE isActive = true AND Profile.Name = 'Vip lounge' AND UserPermissionsSupportUser = true limit 1];
		
		System.runAs(u_ccpo){
			alerts = new R1_Bulk_alerts_CTRL();
		}
        System.runAs(u_vip){
            alerts = new R1_Bulk_alerts_CTRL();
        }
	}
}