/*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Apex test de la clase apex "R1_CustomerAlertsPopUp_Ctrl"
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/04/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
@isTest
private class R1_CustomerAlertsPopUp_Ctrl_Test {
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test para la funcion clientId()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/04/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void clientId_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert cliente;
        
        R1_AlertFor__c alertForAll = R1_AlertFor__c.getOrgDefaults();
        R1_AlertFor__c alertForUser = R1_AlertFor__c.getInstance(UserInfo.getProfileId());
        
        List<R1_Alert__c> listAlerts = new List<R1_Alert__c>();
        for(Integer i=0; i<5;i++){
            R1_Alert__c alerta = new R1_Alert__c();
            alerta.Name = ' test ' + i;
            alerta.R1_ATA_LOO_Client__c = cliente.Id;
            //alerta.R1_ATA_PKL_Alert_for__c = alertForAll.Alert_for__c;
            alerta.R1_ATA_PKL_State__c = 'Activada';
            listAlerts.add(alerta);
        }
        insert listAlerts;  
        
        Test.startTest(); 
        /*List<R1_Alert__c> lstAlertas = [SELECT CreatedDate,Id,Name,R1_ATA_ATXTL_Description__c,
                    R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c,
                    R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c
                    FROM R1_Alert__c
                    WHERE R1_ATA_LOO_Client__c =: cliente.Id
                    AND (R1_ATA_PKL_Alert_for__c =: alertForAll.Alert_for__c
                        OR R1_ATA_PKL_Alert_for__c =: alertForUser.Alert_for__c)
                    AND R1_ATA_PKL_State__c = 'Activada'
                    ORDER BY  CreatedDate];*/
        R1_CustomerAlertsPopUp_Ctrl capu = new R1_CustomerAlertsPopUp_Ctrl();
        capu.clientId = cliente.Id;       
        //System.assertEquals(capu.lstAlerts, lstAlertas);
        Test.stopTest();
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:             Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para la funcion clientId()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/05/2018                  Ismael Yubero Moreno                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void guardarFeedbackdPositivo_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert cliente;
        
        R1_AlertFor__c alertForAll = R1_AlertFor__c.getOrgDefaults();
        R1_AlertFor__c alertForUser = R1_AlertFor__c.getInstance(UserInfo.getProfileId());
        
        List<R1_Alert__c> listAlerts = new List<R1_Alert__c>();
        for(Integer i=0; i<5;i++){
            R1_Alert__c alerta = new R1_Alert__c();
            alerta.Name = ' test ' + i;
            alerta.R1_ATA_LOO_Client__c = cliente.Id;
            //alerta.R1_ATA_PKL_Alert_for__c = alertForAll.Alert_for__c;
            alerta.R1_ATA_PKL_State__c = 'Activada';
            listAlerts.add(alerta);
        }
        insert listAlerts;  
        
        Test.startTest(); 
        /*List<R1_Alert__c> lstAlertas = [SELECT CreatedDate,Id,Name,R1_ATA_ATXTL_Description__c,
                    R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c,
                    R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c
                    FROM R1_Alert__c
                    WHERE R1_ATA_LOO_Client__c =: cliente.Id
                    AND (R1_ATA_PKL_Alert_for__c =: alertForAll.Alert_for__c
                        OR R1_ATA_PKL_Alert_for__c =: alertForUser.Alert_for__c)
                    AND R1_ATA_PKL_State__c = 'Activada'
                    ORDER BY  CreatedDate];*/
        String comentario = 'Comentario del feedback';
        String tipo = 'Positivo';
        R1_CustomerAlertsPopUp_Ctrl.guardarFeedback(comentario, tipo, listAlerts[0].Id); 
        R1_CustomerAlertsPopUp_Ctrl capu = new R1_CustomerAlertsPopUp_Ctrl();
        capu.lstAlerts = listAlerts;    
        //System.assertEquals(capu.lstAlerts, lstAlertas);
        Test.stopTest();
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:             Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para la funcion clientId()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/05/2018                  Ismael Yubero Moreno                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void guardarFeedbackdNegativo_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert cliente;
        
        R1_AlertFor__c alertForAll = R1_AlertFor__c.getOrgDefaults();
        R1_AlertFor__c alertForUser = R1_AlertFor__c.getInstance(UserInfo.getProfileId());
        
        List<R1_Alert__c> listAlerts = new List<R1_Alert__c>();
        for(Integer i=0; i<5;i++){
            R1_Alert__c alerta = new R1_Alert__c();
            alerta.Name = ' test ' + i;
            alerta.R1_ATA_LOO_Client__c = cliente.Id;
            //alerta.R1_ATA_PKL_Alert_for__c = alertForAll.Alert_for__c;
            alerta.R1_ATA_PKL_State__c = 'Activada';
            listAlerts.add(alerta);
        }
        insert listAlerts;  
        
        Test.startTest(); 
        /*List<R1_Alert__c> lstAlertas = [SELECT CreatedDate,Id,Name,R1_ATA_ATXTL_Description__c,
                    R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c,
                    R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c
                    FROM R1_Alert__c
                    WHERE R1_ATA_LOO_Client__c =: cliente.Id
                    AND (R1_ATA_PKL_Alert_for__c =: alertForAll.Alert_for__c
                        OR R1_ATA_PKL_Alert_for__c =: alertForUser.Alert_for__c)
                    AND R1_ATA_PKL_State__c = 'Activada'
                    ORDER BY  CreatedDate];*/
        String comentario = 'Comentario del feedback';
        String tipo = 'Negativo';
        R1_CustomerAlertsPopUp_Ctrl.guardarFeedback(comentario, tipo, listAlerts[0].Id);       
        //System.assertEquals(capu.lstAlerts, lstAlertas);
        Test.stopTest();
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:             Ismael Yubero Moreno
    Company:        Accenture
    Description:    Metodo test para la funcion clientId()
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/05/2018                  Ismael Yubero Moreno                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void guardarFeedbackdNeutral_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        Id recordTypeId = [SELECT Id FROM recordType WHERE Name like 'Cuenta personal' LIMIT 1].Id;
        Account cliente = new Account();
        cliente.RecordTypeId = recordTypeId;
        cliente.LastName = 'TestClient';
        cliente.PersonBirthdate = Date.newInstance(1990, 12, 31);
        insert cliente;
        
        R1_AlertFor__c alertForAll = R1_AlertFor__c.getOrgDefaults();
        R1_AlertFor__c alertForUser = R1_AlertFor__c.getInstance(UserInfo.getProfileId());
        
        List<R1_Alert__c> listAlerts = new List<R1_Alert__c>();
        for(Integer i=0; i<5;i++){
            R1_Alert__c alerta = new R1_Alert__c();
            alerta.Name = ' test ' + i;
            alerta.R1_ATA_LOO_Client__c = cliente.Id;
            //alerta.R1_ATA_PKL_Alert_for__c = alertForAll.Alert_for__c;
            alerta.R1_ATA_PKL_State__c = 'Activada';
            listAlerts.add(alerta);
        }
        insert listAlerts;  
        
        Test.startTest(); 
        /*List<R1_Alert__c> lstAlertas = [SELECT CreatedDate,Id,Name,R1_ATA_ATXTL_Description__c,
                    R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c,
                    R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c
                    FROM R1_Alert__c
                    WHERE R1_ATA_LOO_Client__c =: cliente.Id
                    AND (R1_ATA_PKL_Alert_for__c =: alertForAll.Alert_for__c
                        OR R1_ATA_PKL_Alert_for__c =: alertForUser.Alert_for__c)
                    AND R1_ATA_PKL_State__c = 'Activada'
                    ORDER BY  CreatedDate];*/
        String comentario = 'Comentario del feedback';
        String tipo = 'Neutral';
        R1_CustomerAlertsPopUp_Ctrl.guardarFeedback(comentario, tipo, listAlerts[0].Id);       
        //System.assertEquals(capu.lstAlerts, lstAlertas);
        Test.stopTest();
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test que cubre los catch
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    25/04/2017             Rubén Pingarrón Jerez                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/ 
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        R1_CustomerAlertsPopUp_Ctrl capu = new R1_CustomerAlertsPopUp_Ctrl();
    }
}