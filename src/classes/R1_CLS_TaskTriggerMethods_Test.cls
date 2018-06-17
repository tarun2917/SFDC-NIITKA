/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version     
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

@isTest
private class R1_CLS_TaskTriggerMethods_Test {
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version
    25/07/2017              David Barco             Add the thinkConnect__UUI__c field to call a mapUUIField method    
     14/09/2017              Daniel Cadalso          Modification 
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static testMethod void asignaCasos_insert_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case caso = new Case();
        caso.R1_CAS_TXT_Call__c = 'callTest';
        insert caso;
      
        CaseComment cc = new CaseComment(
            CommentBody = 'cuerpo',
            IsPublished = false,
            ParentId = caso.Id
        );
        insert cc;

        Task tarea = new Task();
        tarea.Subject= 'test';
        tarea.CallObject = caso.R1_CAS_TXT_Call__c;
        String uui = '00aa02b2c594ce98!36!1!0!ESP!0!N!1-3WY-810!12723391!1!PLATINO!!!!!!!!!!3S0E5SS11T4659UE52RV40MK7C00RJ0D!2!!PlatinoEspaol!146!1-U80R4Q!T-1027!Resources!IBPlus_Platino_Espaol_CED!222!!!!!!null!PlatinoEspaol!default!default!!12723391';
        tarea.thinkConnect__UUI__c = uui;

        Task tarea2 = new Task();
        tarea2.CallObject = caso.R1_CAS_TXT_Call__c;
        tarea2.Subject = 'test';
        tarea2.thinkConnect__UUI__c = uui;
        tarea2.CallDurationInSeconds = 3666;

        Test.startTest();
        insert tarea;
        insert tarea2;
        Test.stopTest();
    }
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Daniel Cadalso
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    14/09/2017            Daniel Cadalso             Initial Version   
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static testMethod void asignaCasos_insert_Test2(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case caso = new Case();
        caso.R1_CAS_TXT_Call__c = 'callTest';
        insert caso;
      
        CaseComment cc = new CaseComment(
            CommentBody = 'cuerpo',
            IsPublished = false,
            ParentId = caso.Id
        );
        insert cc;

        Task tarea = new Task();
        tarea.CallObject = caso.R1_CAS_TXT_Call__c;
        tarea.Subject = 'test';
        String uui = ''+cc.Id+'!!1!0!ESP!0!N!1-31G-1211!18519686!1!ORO!1!0!'+ UserInfo.getUserId()+'!noE!colaVirt!nGrpAg!1!Ag!scrName!rvqid!2!ruleSel!plus!171!plus2!T-1508!Res!IBPlus!308!21!10!Ccont!IT_path!RReq!null!plusnet!d!d!servObj';
        tarea.thinkConnect__UUI__c = uui;
        tarea.CallDurationInSeconds = 6;
        
        Task tarea2 = new Task();
        tarea2.Subject = 'test';
        tarea2.CallObject = caso.R1_CAS_TXT_Call__c;
        tarea2.thinkConnect__UUI__c = uui;
        tarea2.CallDurationInSeconds = 43950;

        Task tarea3 = new Task();
        tarea3.Subject = 'test';
        tarea3.CallObject = caso.R1_CAS_TXT_Call__c;
        tarea3.thinkConnect__UUI__c = uui;
        tarea3.CallDurationInSeconds = 12;

        Test.startTest();
        insert tarea;
        insert tarea2;
        insert tarea3;
        Test.stopTest();
    }


     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version     
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    static testMethod void asignaCasos_update_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        Case caso = new Case();
        caso.R1_CAS_TXT_Call__c = 'callTest';
        insert caso;
        
        Task tarea = new Task();
        tarea.Subject = 'test';
        tarea.CallObject = caso.R1_CAS_TXT_Call__c;
        insert tarea;
        tarea.Description = 'asdasdasd';
        
        Test.startTest();
        update tarea;
        Test.stopTest();
    }
    
     /*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:        Ruben Pingarron
    Company:       Accenture
    Description:   

    
    History: 
    
    <Date>                  <Author>                <Change Description>
    04/07/2017            Ruben Pingarron             Initial Version     
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/

    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = True;
        
        R1_CLS_TaskTriggerMethods.asignaCasos(null);
    }
}