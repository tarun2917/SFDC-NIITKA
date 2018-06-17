public with sharing class R2_CLS_TSK_New_SMS_CTRL {
/****************************************************************************************************************
    Author:         Ismael Yubero Moreno
    Company:        Accenture
    Description:    
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    18/09/2017             Ismael Yubero Moreno                  Initial Version
********************************************************************************************************************** */

    public  String telefono{get;set;}
    public  String body{get;set;}
    public  String codigoPais{get;set;}
    public  String numTlf{get;set;}
    public  boolean editar{get;set;}
    public  Account cliente;
    public String tflFinalO;
    public String tflFinalM;
    public String tflFinalOTratado;
    public String tflFinalMTratado;


    public R2_CLS_TSK_New_SMS_CTRL(ApexPages.StandardController controller) {
            String accId =  ApexPages.currentPage().getParameters().get('accId');
            cliente = [SELECT Id, Name,R1_ACC_TLF_Phone_Marketing__c,R1_ACC_TLF_Phone_Operative__c, R2_ACC_TLF_Phone_MarketingII__c, R2_ACC_TLF_Phone_OperativeII__c FROM Account WHERE id=: accId];
            
    }


    public void tratarTlf(){
        System.debug(telefono);
        if(telefono == 'Selecciona un teléfono'){
            System.debug('Entro aqui');
            editar = false;
            codigoPais = null;
            numTlf =  null;
        }
        else if(telefono == 'Teléfono Operacional'){
            codigoPais = null;
            numTlf = null;
            if(cliente.R2_ACC_TLF_Phone_OperativeII__c != null){        
                    editar = false;
                    String [] lstO = cliente.R1_ACC_TLF_Phone_Operative__c.split(' ');
                    codigoPais = lstO[0].remove('+');
                    numTlf =  lstO[1];
            }else{
                editar =  false;
            }
                        
        }else if(telefono == 'Teléfono Marketing'){
            codigoPais = null;
            //System.debug(cliente.R1_ACC_TLF_Phone_Operative__c);
            numTlf = null;
            if(cliente.R2_ACC_TLF_Phone_MarketingII__c != null){
                    editar = false;
                    String [] lstM = cliente.R1_ACC_TLF_Phone_Operative__c.split(' ');
                    codigoPais = lstM[0].remove('+');
                    numTlf =  lstM[1];
            }else{
                editar = false;
            }
        }else{
            codigoPais = null;
            numTlf = null;
            editar = true;
        }
                    

    }


    public void tratarTelefono(){
        System.debug('Se va a tratar el telefono');
         if(cliente.R1_ACC_TLF_Phone_Marketing__c!=null && cliente.R1_ACC_TLF_Phone_Marketing__c!=''){
                        if(cliente.R1_ACC_TLF_Phone_Marketing__c.startsWith('+')){
                            System.debug('Pasa por aqui: '+ cliente.R1_ACC_TLF_Phone_Marketing__c);
                            List<String> tlfPartido = cliente.R1_ACC_TLF_Phone_Marketing__c.subString(1).split(' ');
                            String tlf='';
                            for(String parte : tlfPartido){
                                tlf=tlf+parte;
                            }
                            codigoPais = tlfPartido[0];
                            numTlf = tlfPartido[1];
                            tflFinalM= tlf;
                            tflFinalMTratado =cliente.R1_ACC_TLF_Phone_Marketing__c;
                        }
                        else{

                            tflFinalM = '34' + cliente.R1_ACC_TLF_Phone_Marketing__c;
                            tflFinalMTratado = '+34 ' + cliente.R1_ACC_TLF_Phone_Marketing__c;
                            cliente.R2_ACC_TLF_Phone_MarketingII__c = cliente.R1_ACC_TLF_Phone_Marketing__c;
                        }
                    }
                    else{}
         if(cliente.R1_ACC_TLF_Phone_Operative__c!=null && cliente.R1_ACC_TLF_Phone_Operative__c!=''){
                        if(cliente.R1_ACC_TLF_Phone_Operative__c.startsWith('+')){
                            System.debug('Pasa por aqui: '+ cliente.R1_ACC_TLF_Phone_Operative__c);
                            List<String> tlfPartido = cliente.R1_ACC_TLF_Phone_Operative__c.subString(1).split(' ');
                            String tlf='';
                            for(String parte : tlfPartido){
                                tlf=tlf+parte;
                            }
                            tflFinalO = tlf;
                            tflFinalOTratado = cliente.R1_ACC_TLF_Phone_Operative__c;
                        }
                        else{
                            tflFinalO = '34' + cliente.R1_ACC_TLF_Phone_Operative__c;
                            tflFinalOTratado = '+34 ' + cliente.R1_ACC_TLF_Phone_Operative__c;
                            cliente.R2_ACC_TLF_Phone_OperativeII__c = cliente.R1_ACC_TLF_Phone_Operative__c;
                        }
                    }
                    else{}

        System.debug('telefono operativo tratado: '+ tflFinalO);
        System.debug('telefono marketing tratado: '+ tflFinalM);
        System.debug('telefono operativo tratado: '+ tflFinalOTratado);
        System.debug('telefono marketing tratado: '+ tflFinalMTratado);

        if(telefono == 'Selecciona un teléfono'){
            System.debug('Entro aqui');
            editar = false;
            codigoPais = null;
            numTlf =  null;
        }
        else if(telefono == 'Teléfono Operacional'){
            codigoPais = null;
            numTlf = null;
            if(cliente.R1_ACC_TLF_Phone_Operative__c != null && cliente.R1_ACC_TLF_Phone_Operative__c != ''){        
                    editar = false;
                    String [] lstO = tflFinalOTratado.split(' ');
                    codigoPais = lstO[0].remove('+');
                    numTlf =  lstO[1];
            }else{
                    numTlf = 'El cliente no tiene teléfono Operativo';
                    editar =  false;
            }
                        
        }else if(telefono == 'Teléfono Marketing'){
            codigoPais = null;
            //System.debug(cliente.R1_ACC_TLF_Phone_Operative__c);
            numTlf = null;
            if(cliente.R1_ACC_TLF_Phone_Marketing__c != null && cliente.R1_ACC_TLF_Phone_Marketing__c != ''){
                    editar = false;
                    String [] lstM = tflFinalMTratado.split(' ');
                    codigoPais = lstM[0].remove('+');
                    numTlf =  lstM[1];
            }else{
                numTlf = 'El cliente no tiene teléfono Marketing';
                editar = false;
            }
        }else{
            codigoPais = null;
            numTlf = null;
            editar = true;
        }



    }
    
  
    
    public PageReference guardarTask(){
                System.debug('Esto es una prueba para ver que se ejecuta la controladora');
                System.debug('telefono operativo tratado: '+ tflFinalO);
                System.debug('telefono marketing tratado: '+ tflFinalM);
                System.debug(cliente.Id);
                System.debug(telefono);
                System.debug(body);
                System.debug(numTlf);
                //tratarTelefono();
                Task tsk = new Task();
                tsk.WhatId = cliente.Id;
                tsk.Subject='SMS_'+cliente.Name+'_'+date.today().format();
                if(body != ''){
                    tsk.Description= body;
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debe rellenar el campo contenido')); 
                        return null;
                    }
                
                tsk.Status = 'Completed';
                tsk.Type='Sms';
                if(telefono != 'Selecciona un teléfono'){
                        if(telefono == 'Teléfono Operacional'){
                            System.debug('Prueba telefono opercional: '+cliente.R2_ACC_TLF_Phone_OperativeII__c);
                            if(cliente.R1_ACC_TLF_Phone_Operative__c !=  null && cliente.R1_ACC_TLF_Phone_Operative__c != ''){
                                tsk.R2_ACT_TLF_Phone__c = tflFinalO;
                                tsk.thinkConnect__DNIS__c = cliente.R1_ACC_TLF_Phone_Operative__c;
                                insert tsk;
                                
                            }else{
                                System.debug('No se ha insertado la task porque el telefono operacional es incorrecto');
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Falta el telefono  operacional')); 
                                return null;
                            }
                        }else if(telefono == 'Teléfono Marketing'){
                            if(cliente.R1_ACC_TLF_Phone_Marketing__c !=  null && cliente.R1_ACC_TLF_Phone_Marketing__c != ''){
                                tsk.R2_ACT_TLF_Phone__c = tflFinalM;
                                tsk.thinkConnect__DNIS__c = cliente.R1_ACC_TLF_Phone_Marketing__c;
                                insert tsk;
                            }else{
                                System.debug('No se ha insertado la task porque el telefono marketing es incorrecto');
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Falta el telefono  marketing')); 
                                return null;
                            }
                        }else if(telefono == 'Otro'){
                                System.debug('eooooooooooooooooooooooooooooooooo');
                                System.debug(codigoPais);
                                System.debug(numTlf);
                                if(numTlf.length() == 9){
                                    if(codigoPais=='34'){
                                        String tel = codigoPais + numTlf;
                                        System.debug(tel);
                                        tsk.R2_ACT_TLF_Phone__c = tel;
                                        tsk.thinkConnect__DNIS__c = tel;
                                        insert tsk;
                                    }
                                    else{
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Sólo se admite el prefijo "34"')); 
                                        return null;
                                    }
                                }else{
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Teléfono erroneo')); 
                                    return null;
                                }
                                
                            }else{
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debe seleccionar un teléfono')); 
                                return null;
                            
                            }
                            }           
                               
                
                PageReference pageRef = new PageReference('/' +tsk.Id);         
                pageRef.setRedirect(true);

                return pageRef;
    }           
}