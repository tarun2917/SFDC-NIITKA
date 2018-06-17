public class R2_CLS_GuPostPreviewer_CTRL{

public String idTemplate {get;set;}
public String bodyPreview {get;set;}
public string p3_lkid {get;set;}

public R2_CLS_GuPostPreviewer_CTRL(){

}

public void formatearBody(){
  p3_lkid = apexpages.currentpage().getparameters().get('p3_lkid');
  idTemplate = apexpages.currentpage().getparameters().get('idTemplate');
  Messaging.SingleEmailMessage[] previewEmails = new Messaging.SingleEmailMessage[]{};
  Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
  firstPreviewEmail.setUseSignature(false);
  firstPreviewEmail.setSaveAsActivity(false);
  firstPreviewEmail.setTargetObjectId(Label.ClienteDummyGuPost);
  firstPreviewEmail.setTemplateId(idTemplate);
  firstPreviewEmail.setWhatId(p3_lkid);
  previewEmails.add(firstPreviewEmail);
  Messaging.SingleEmailMessage secondPreviewEmail = new Messaging.SingleEmailMessage();
  previewEmails.add(secondPreviewEmail);
  try {
    List<Messaging.SendEmailResult> previewResult = Messaging.sendEmail(previewEmails);
  }
  catch (Exception e) {
    System.debug('Exception: ' + e.getMessage());
    System.debug('HTMLBody : '+firstPreviewEmail.getHtmlBody());
    System.debug('Body : '+firstPreviewEmail.getPlainTextBody());
    System.debug('Template Id: '+ firstPreviewEmail.getTemplateId());
    bodyPreview = firstPreviewEmail.getHtmlBody();  // Email body generated
  } 
}

public PageReference generarPDF(){
     PageReference pageRef = new PageReference('/apex/R2_VF_GuPostPDFView');
        pageRef.setRedirect(false);
        return pageRef;
}

}