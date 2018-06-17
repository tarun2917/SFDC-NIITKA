global with sharing  class R1_CustomerAlertsPopUp_Ctrl {

    public String clientId{get;set;}

    R1_AlertFor__c alertForAll = R1_AlertFor__c.getOrgDefaults();
    Profile p = [Select Name from Profile where Id =: UserInfo.getProfileid()];
    String pname = p.name; 
    
    List<R1_AlertFor__c> alertForUser = alertForUser(pname);
    String query = queryMethod(alertForUser);

    public R2_Feedback__c feedback {get; set;}
    public List<SelectOption> optionTipoFeed {get;set;}
    // public String tipoFeedback {get; set;}
    // public String valorFeedback {get; set;}
    // public Integer count{get; set;}
    //List<String> alertfor = alertForUser[0].Alert_for__c.split(';');
    // String query = queryMethod(alertForUser);

    public  R1_CustomerAlertsPopUp_Ctrl() {
        feedback = new R2_Feedback__c();
        // valorFeedback = 'Test feedback';
        // tipoFeedback='Positivo';

        optionTipoFeed = new List<SelectOption>();
        optionTipoFeed.add(new SelectOption('', '--NONE--'));
        Schema.DescribeFieldResult fieldResult = R2_Feedback__c.R2_FDB_PKL_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            optionTipoFeed.add(new SelectOption(f.getValue(),f.getLabel()));
        }
    }
    
    
    public List<R1_Alert__c> lstAlerts{get{
        System.debug('COntroladora del pop up: '+ query);
        // List<R1_Alert__c> lstAlerts = [SELECT CreatedDate,Id,Name,R1_ATA_ATXTL_Description__c,
        //             R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c,
        //             R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c
        //             FROM R1_Alert__c
        //             WHERE R1_ATA_LOO_Client__c =: clientId
        //             AND (R1_ATA_PKL_Alert_for__c =: alertForAll.Alert_for__c
        //                 OR R1_ATA_PKL_Alert_for__c includes (:query))
        //             AND R1_ATA_PKL_State__c = 'Activada'
        //             ORDER BY  CreatedDate];
        System.debug('Variable rara: ' + alertForAll.Alert_for__c );
        String aux2;
        if(query != ''){
            aux2 = 'SELECT CreatedDate,R2_ATA_AUT_Alert_ID__c,R2_ATA_PKL_Type__c ,Id,Name,R1_ATA_ATXTL_Description__c,R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c, R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c FROM R1_Alert__c WHERE R1_ATA_LOO_Client__c =: clientId AND (R1_ATA_PKL_Alert_for__c =\''+ alertForAll.Alert_for__c +'\' OR R1_ATA_PKL_Alert_for__c includes (' + query + ')) AND R2_ATA_FOR_Status__c = \'Activa\' ORDER BY  CreatedDate desc';
            System.debug('VIene por donde no es system amdin');
        }else{
            aux2 = 'SELECT CreatedDate,R2_ATA_AUT_Alert_ID__c,Id,R2_ATA_PKL_Type__c ,Name,R1_ATA_ATXTL_Description__c,R1_ATA_DATH_Creation_date__c,R1_ATA_DATH_Expiry_date__c, R1_ATA_LOO_Client__c,R1_ATA_PKL_Alert_for__c,R1_ATA_PKL_State__c FROM R1_Alert__c WHERE R1_ATA_LOO_Client__c =: clientId AND (R1_ATA_PKL_Alert_for__c =\''+ alertForAll.Alert_for__c +'\' ) AND R2_ATA_FOR_Status__c = \'Activa\' ORDER BY  CreatedDate desc';
            System.debug('Viene por aqui porque es de admin');
        }
        System.debug(aux2);
        List<R1_Alert__c> lstAlerts = database.query(aux2);
        
        return lstAlerts;
        }set;}

    
    public List<R1_AlertFor__c> alertForUser(String pname){
        System.debug('Este es el name del usuario ' + pname);
        List<Profile> idPerfil = [SELECT Id, Name FROM Profile WHERE Name =:pname LIMIT 1];
        System.debug('Este es el name del usuario ' + idPerfil[0].Id);
        List<R1_AlertFor__c> alertForUser = [SELECT Alert_for__c FROM R1_AlertFor__c WHERE SetupOwnerId =: idPerfil[0].Id];
        System.debug('Este es el name del usuario ' + alertForUser);
        return alertForUser;
    }

    public String queryMethod(List<R1_AlertFor__c> alertfor){
        System.debug('Alerta para: ' + alertfor);
        String aux = '';
        
        if(alertfor.size() != 0){
            
            List<String> alertf = alertForUser[0].Alert_for__c.split(';');
            Integer j = alertf.size() -1;
            for(Integer i = 0; i <= j;i++){

                System.debug('Tamaño: '+ j);
                System.debug('i: '+ i);
                if(i < j){
                    aux += '\''+alertf[i]+'\'';
                    aux+= ',';
                    System.debug('Query + ; : ' + aux);
                }else{
                    aux += '\''+alertf[i]+'\'';
                    System.debug('Query final: ' + aux);
                }
            }
        }
        System.debug('Aqui monta la query: ' + aux);
        return aux;
    }

    @RemoteAction
    global static String guardarFeedback(String comentario, String tipo, String alerta){
        System.debug('Feedbaaaaaack: ' + comentario);
        System.debug('Feedbaaaaaack texto : ' + tipo);
        System.debug('Id Alerta: ' + alerta);
        R2_Feedback__c fdb = new R2_Feedback__c();

        if(tipo == 'Positivo'){
            fdb.R2_FDB_PKL_Type__c = 'Positivo';
        }else if(tipo == 'Negativo'){
            fdb.R2_FDB_PKL_Type__c = 'Negativo';
        }else{
            fdb.R2_FDB_PKL_Type__c = 'Neutral';
        }

        fdb.R2_FDB_TXT_Comments__c = comentario;
        fdb.R2_FDB_MSDT_Alert__c =alerta;

         insert fdb;
         PageReference p=new Pagereference('/'+'0019E00000cEmbQ');
        System.debug('Page reference: ' + p);
        p.setRedirect(true);
        String redirect = 'https://iberia--dev6.cs88.my.salesforce.com/0019E00000cEmbQ';
        return redirect;      


    }
    
    
}