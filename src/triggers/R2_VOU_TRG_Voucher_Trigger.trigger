trigger R2_VOU_TRG_Voucher_Trigger on R2_Voucher__c (before insert, before update, after insert, after update) {
R1_byPass__c bypass = R1_byPass__c.getInstance();
    Set<String> objectByPass = R1_CLS_Utilities.splitText(bypass.R1_TXT_Objects__c);

    List<R2_Voucher__c> news = trigger.new;
    List<R2_Voucher__c> olds = trigger.old;

    if(Trigger.isBefore){
      if(Trigger.isInsert){
          R2_CLS_VoucherTriggerMethods.relateVoucher(news);
      }
    }
    else if(Trigger.isAfter){

        if(Trigger.isInsert){

            // Vouchers DNB, iberia conecta
            List<Id> listIdVouDNB = new List<Id>();
            for(R2_Voucher__c vou: news){
                if(vou.R2_VOU_TXT_Voucher__c == '' || vou.R2_VOU_TXT_Voucher__c ==null){
                    listIdVouDNB.add(vou.Id);
                    //R2_CLS_VOU_VoucherIntegrationMethods.createDNB(vou.Id);
                }
            }
            if(!listIdVouDNB.isEmpty()){
                //R2_CLS_VOU_VoucherIntegrationMethods.createDNB(listIdVouDNB);
            }
            //
            R2_CLS_VoucherTriggerMethods.organizarVoucherIBConecta(news);

            // voucher iberia.com
            if(news.size()==1){
                R2_CLS_Iberia_Voucher_TriggerMethods.insertarBonoIbcom(JSON.serialize(news));
			}
        }
        else if(Trigger.isUpdate){

            for(Integer i=0 ; i<news.size(); i++){
                if(olds[i].R2_VOU_TXT_Voucher__c !='' && olds[i].R2_VOU_TXT_Voucher__c != null && news[i].R2_VOU_PKL_Status__c != 'X'){
                    R2_CLS_VOU_VoucherIntegrationMethods.updateDNB(news[i].id);
                }
                
                if(olds[i].R2_VOU_DIV_Amount_value2_Avios__c!=news[i].R2_VOU_DIV_Amount_value2_Avios__c || olds[i].R2_VOU_DIV_Amount_value_Avios__c!=news[i].R2_VOU_DIV_Amount_value_Avios__c || olds[i].R2_VOU_DIV_Amount_Value2_Cash__c!=news[i].R2_VOU_DIV_Amount_Value2_Cash__c || olds[i].R2_VOU_DIV_Amount_Value_Cash__c!= news[i].R2_VOU_DIV_Amount_Value_Cash__c
                    || olds[i].R2_VOU_DIV_Amount_Value2_Check__c!= news[i].R2_VOU_DIV_Amount_Value2_Check__c || olds[i].R2_VOU_DIV_Amount_Value_Check__c!= news[i].R2_VOU_DIV_Amount_Value_Check__c || olds[i].R2_VOU_DIV_Amount_Value2_MCO__c!= news[i].R2_VOU_DIV_Amount_Value2_MCO__c || olds[i].R2_VOU_DIV_Amount_Value_MCO__c!=news[i].R2_VOU_DIV_Amount_Value_MCO__c
                    || olds[i].R2_VOU_DIV_Amount_Value_Prepaid__c!= news[i].R2_VOU_DIV_Amount_Value_Prepaid__c || olds[i].R2_VOU_DIV_Amount_Value2_Prepaid__c!=news[i].R2_VOU_DIV_Amount_Value2_Prepaid__c && news[i].R2_VOU_PKL_Status__c != 'X'){
                    R2_CLS_VOU_VoucherIntegrationMethods.updateDNBAmount(news[i].id);
                }

                if( olds[i].R2_VOU_PKL_Status__c!='X' && news[i].R2_VOU_PKL_Status__c == 'X'){
                    R2_CLS_VOU_VoucherIntegrationMethods.cancelDNB(news[i].id);
                }
            }
        }
    }
}