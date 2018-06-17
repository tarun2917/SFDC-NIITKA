/*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Clase test de la clase R2_CLS_ATT_TriggersMethods          

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
@isTest
private class R2_CLS_ATT_TriggersMethods_Test {
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test del metodo valorParentId()         

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void valorParentId_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        EmailMessage ema = new EmailMessage(); 
        Case caso = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',true,true);
        insert caso;
        ema.ParentId = caso.Id;//'5007E000005M5kFQAS';
        insert ema;
        
        Blob blobTest = Blob.valueOf('Hola soy un archivo de prueba');
        
        Attachment att = new Attachment();
        att.ParentId = ema.Id;
		att.Name = 'TestAtt';
		att.Body = blobTest;         
        
        Test.startTest();
        insert att;
        
        Attachment attParent = [SELECT Id, ParentId FROM Attachment WHERE Id = :att.Id LIMIT 1];
        System.assertEquals(attParent.ParentId, caso.Id);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    /*---------------------------------------------------------------------------------------------------------------------
    Author:         Rubén Pingarrón Jerez
    Company:        Accenture
    Description:    Metodo test del metodo valorParentId()         

    History: 
     <Date>                     <Author>                         <Change Description>
    05/09/2017             Rubén Pingarrón Jerez                   Initial Version
    05/09/2017             Alberto Puerto Collado                   Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void valorParentId_LISTA_Test(){
        R1_CLS_LogHelper.throw_exception = false;
        
        EmailMessage ema = new EmailMessage(); 

        Case caso = R1_CLS_Utilities.helper_Case_constructor('Demora, con deterioro',true,true);
        insert caso;
        ema.ParentId = caso.Id;//'5007E000005M5kFQAS';
        insert ema;
        
        Blob blobTest = Blob.valueOf('Hola soy un archivo de prueba');
        
        List<Attachment> attLST = new List<Attachment>();
        Attachment att1 = new Attachment();
        att1.ParentId = ema.Id;
        system.debug(ema.ParentId);
		att1.Name = 'TestAtt2';
		att1.Body = blobTest; 
		Attachment att2 = new Attachment();
        att2.ParentId = ema.Id;
		att2.Name = 'TestAtt1';
		att2.Body = blobTest; 

		attLST.add(att1);  
		attLST.add(att2);    
        //System.debug('LISTA LST -> ' + attLST);
        
        
        Test.startTest();
        insert attLST;

        Set<Id> setId = new Set<Id>();
        setId.add(att1.Id);
        setId.add(att2.Id);
        //System.debug('LISTA SET -> ' + setId);

        List<Attachment> attParent = [SELECT Id, ParentId FROM Attachment WHERE Id IN :setId];//= :att1.Id OR Id = :att2.Id];
        System.debug('LISTA Parent -> ' + attParent[0].ParentId + '--------- ' + caso.Id);
        System.assertEquals(attParent[0].ParentId, caso.Id);
        System.assertEquals(attParent[1].ParentId, caso.Id);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
    
    /*---------------------------------------------------------------------------------------------------------------------
	Author:         Rubén Pingarrón Jerez
	Company:        Accenture
	Description:    Metodo test para cubrir los catch       

	History: 
	 <Date>                     <Author>                         <Change Description>
	17/08/2017       	   Rubén Pingarrón Jerez                   Initial Version
	17/08/2017				Sara Torres Bermúdez					Initial Version
	----------------------------------------------------------------------------------------------------------------------*/
    static testMethod void exception_Test(){
        R1_CLS_LogHelper.throw_exception = true;
        
        R2_CLS_ATT_TriggersMethods.valorParentId(null);
    }
}