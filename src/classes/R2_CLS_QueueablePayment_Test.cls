@isTest
private class R2_CLS_QueueablePayment_Test {
  
    static testMethod void execute_test(){
        R1_CLS_LogHelper.throw_exception = false;

        List<R1_CS_Endpoints__c> lst_ep=new List<R1_CS_Endpoints__c>();
        R1_CS_Endpoints__c ep=new R1_CS_Endpoints__c();
        ep.Name='Update Flight Status';
        ep.R1_CHK_Activo__c=true;
        ep.R1_TXT_EndPoint__c='PruebaUpdateFlightStatus';
        lst_ep.add(ep);
        R1_CS_Endpoints__c ep2 = new R1_CS_Endpoints__c();
        ep2.Name = 'ETL_Login';
        ep2.R1_CHK_Activo__c = true;
        ep2.R1_TXT_EndPoint__c = 'PruebaLogin';
        lst_ep.add(ep2);
        insert lst_ep;

        Test.setMock(HttpCalloutMock.class, new R1_CLS_Utilities.mockCallOut());

        Id rtExpediente = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Expediente').getRecordTypeId();
		Case cas = new Case();
		cas.RecordTypeId = rtExpediente;
		cas.Status = 'Abierto';
		cas.Origin = 'Email';
		cas.Type = 'Retraso';
        cas.R2_CAS_DIV_Sum_Compensation__c = 900;
		insert cas;

        R2_Payment_order__c payOr = new R2_Payment_order__c();
        payOr.R2_OPY_CHK_Flag_Escalation_PBuilder__c  = true;
        payOr.R2_OPY_LOO_File_associated__c = cas.Id;
        payOr.R2_OPY_PKL_PaymentType__c  = 'Seguimiento de Pagos';
        payOr.R2_OPY_PCK_Status__c  = 'Borrador';
        insert payOr;

        Test.startTest();
            List<R2_Payment_order__c> listPay = [SELECT Id,R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id=:payOr.Id];
            System.debug('*** payments before: '+ listPay);

            System.enqueueJob(new R2_CLS_QueueablePayments(listPay));
        
        Test.stopTest();

        List<R2_Payment_order__c> listPayUpdates = [SELECT Id,R2_OPY_PCK_Status__c FROM R2_Payment_order__c WHERE Id=:payOr.Id];
        
        System.debug('*** payments after: '+ listPayUpdates);


        System.assertEquals(0, [SELECT count() FROM R1_Log__c]);
    }
}