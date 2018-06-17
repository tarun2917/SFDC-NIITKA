public class R1_VIP_Lounge_Access_CLS{
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay
Company:        Accenture
Description:    Vip Lounge Validation Trigger Controller.

History:

<Date>              <Author>            <Description>
25/04/2017          Borja Gay     Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    
    public static void validaracceso(List<R1_VIP_Lounge_Access__c> acceso,integer intentos){
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         Borja Gay
Company:        Accenture
Description:    Method that indicates if the client is allowed to enter the VIP Lounge.

IN:         

OUT:           Void

History:

<Date>              <Author>            <Description>
25/04/2017          Borja Gay           Initial version
17/07/2017          David Barco         Change the owner of access to the user in this workspace
18/07/2017          David Barco         Fill the auxiliar field R1_VLI_DATH_Hora_real_embarque__
18/07/2017          Daniel Cadalso      Added American Airlines Frequent Flyer.
14/08/2017          David Barco         Added filter that only checks the rules if the flight's origin is MAD 
--------------------------------------------------------------------------------------------------------------------------------------------------------*/    
        try{
            boolean infinita=false;
            boolean infinitaP=false;
            boolean noCrear=false;
            boolean noBuscarCliente=false;
            if(acceso[0].R1_VLI_PKL_OneWolrd_code__c!='' && acceso[0].R1_VLI_PKL_OneWolrd_code__c!=null){
                System.debug('Entro aqui');
                acceso[0].R1_VLI_TXT_OneWolrd_code__c=acceso[0].R1_VLI_PKL_OneWolrd_code__c;
                
            }
            else{
                
                acceso[0].R1_VLI_PKL_OneWolrd_code__c=acceso[0].R1_VLI_TXT_OneWolrd_code__c;
                
            }
            String ff='';
            if(acceso[0].R1_VLI_TXT_Frecuent_Flyer_number__c!=null && acceso[0].R1_VLI_TXT_Frecuent_Flyer_number__c!=''){
                ff=acceso[0].R1_VLI_TXT_Frecuent_Flyer_number__c;
            }
            else{
                noBuscarCliente=true;
            }
            
            if(acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c==null && acceso[0].R1_VLI_TXT_Mkt_Flight__c==null){
                
                acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c=acceso[0].R1_VLI_TXT_Comp_Flight__c;
                acceso[0].R1_VLI_TXT_Mkt_Flight__c=acceso[0].R1_VLI_TXT_Flight_number__c;
                
            }else if(acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c==null && acceso[0].R1_VLI_TXT_Mkt_Flight__c!=null){
                noCrear=true;
            }else if(acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c!=null && acceso[0].R1_VLI_TXT_Mkt_Flight__c==null){
                noCrear=true;
            }
            
            if(acceso[0].R1_VLI_DAT_Date__c != null){
                String fecha = String.valueOf(acceso[0].R1_VLI_DAT_Date__c);
                String[] fechas = fecha.split('-');
                
                if(acceso[0].R1_VLI_NUM_departure_tieme_cki__c != null){
                    String hora = '';
                    String minuto = '';
                    if(acceso[0].R1_VLI_NUM_departure_tieme_cki__c.contains(':')){
                        hora = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subStringBefore(':');
                        minuto = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subStringAfter(':');
                    }else{
                        //String[] hora = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.split(':');
                        hora = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subString(0,2);
                        minuto = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subString(2,4);
                        System.debug( '======== hora ---> ' + hora + ' minuto ---> ' + minuto );
                    }
          
                    acceso[0].R1_VLI_DATH_Hora_real_embarque__c = DateTime.newInstance(Integer.valueOf(fechas[0]), Integer.valueOf(fechas[1]), Integer.valueOf(fechas[2]), Integer.valueOf(hora), Integer.valueOf(minuto), 0);
                }else{
                    acceso[0].R1_VLI_DATH_Hora_real_embarque__c = DateTime.newInstance(Integer.valueOf(fechas[0]), Integer.valueOf(fechas[1]), Integer.valueOf(fechas[2]), 0,0,0);
                }
            }
            
            
            acceso[0].R1_VLI_ATXT_Observations__c='';
            List<Salas_VIP__c> sala=[SELECT Sala_Vip__c, Puesto_de_Trabajo__c, UserId__c from Salas_VIP__c where Nombre_del_equipo__c=:acceso[0].R1_VLI_PKL_Sala_Vip__c Limit 1];
            if(sala.size()!=0){
                acceso[0].R1_VLI_PKL_Sala_Vip__c=sala[0].Sala_Vip__c;
                acceso[0].R1_VLI_PKL_Vip_lounge_position__c=sala[0].Puesto_de_Trabajo__c;
                
                if(sala[0].UserId__c != null && sala[0].UserId__c != ''){
                    acceso[0].OwnerId = sala[0].UserId__c;
                }
            }
            
            Date fecha;
            integer dia;
            String day;
            integer mes;
            String month;
            String year;
            List<R1_Flight__c> vuelo = new List<R1_Flight__c>();
            
            if(acceso[0].R1_VLI_DAT_Date__c != null){
                fecha=acceso[0].R1_VLI_DAT_Date__c;
                dia=fecha.day();
                day=string.valueOf(dia);
                mes=fecha.month();
                month=string.valueOf(mes);
                if(dia<10){
                    day='0'+dia;
                }
                if(mes<10){
                    month='0'+mes;
                }
                year = string.valueOF(fecha.year());
                String externa=acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c+acceso[0].R1_VLI_TXT_Mkt_Flight__c+month+day+year+acceso[0].R1_VLI_TXT_Origin__c;
                System.debug(externa);
                vuelo=[Select id,name from R1_Flight__c WHERE R1_FLG_TXT_External_ID__c=:externa];
            }
            else{
                noCrear=true;
            }
            if(vuelo.size()!=0){
                
                acceso[0].R1_VLI_LOO_Flight__c = vuelo[0].id;   
            }
            
            else if (noCrear==false && acceso[0].R1_VLI_TXT_Flight_number__c!=null && acceso[0].R1_VLI_TXT_Origin__c!=null && acceso[0].R1_VLI_DAT_Date__c!=null && acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c!=null){
                R1_Flight__c nVuelo = new R1_Flight__c();
                fecha=acceso[0].R1_VLI_DAT_Date__c;
                dia=fecha.day();
                day=string.valueOf(dia);
                mes=fecha.month();
                month=string.valueOf(mes);
                if(dia<10){
                    day='0'+dia;
                }
                if(mes<10){
                    month='0'+mes;
                }
                year = string.valueOF(fecha.year());
                if(acceso[0].R1_VLI_NUM_departure_tieme_cki__c!=null){
                    String horas = '';
                    String minutos = '';
                    if(acceso[0].R1_VLI_NUM_departure_tieme_cki__c.contains(':')){
                        horas = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subStringBefore(':');
                        minutos = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subStringAfter(':');
                    }else{
                        //String[] hora = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.split(':');
                        horas = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subString(0,2);
                        minutos = acceso[0].R1_VLI_NUM_departure_tieme_cki__c.subString(2,4);
                        System.debug( '======== hora ---> ' + horas + ' minuto ---> ' + minutos );
                    }
                    Time tiempo=time.newInstance(integer.valueOf(horas), integer.valueOf(minutos), 0, 0);
                    
                    nVuelo.R1_FLG_DATH_Schedule_depart_time__c=datetime.newInstance(fecha,tiempo);
                    
                }
                else{
                    Time tiempodummy=time.newInstance(0,0, 0, 0);
                    nVuelo.R1_FLG_DATH_Schedule_depart_time__c=datetime.newInstance(fecha,tiempodummy);                 
                }
                year=string.valueOf(fecha.year());
                nVuelo.Name=acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c+acceso[0].R1_VLI_TXT_Mkt_Flight__c+'_'+year+month+day;
                nVuelo.R1_FLG_TXT_External_ID__c=acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c+acceso[0].R1_VLI_TXT_Mkt_Flight__c+month+day+year+acceso[0].R1_VLI_TXT_Origin__c;
                nVuelo.R1_FLG_TXT_Flight_number__c=acceso[0].R1_VLI_TXT_Mkt_Flight__c;
                nVuelo.R1_FLG_TXT_Airport_depart__c=acceso[0].R1_VLI_TXT_Origin__c;
                nVuelo.R1_FLG_TXT_Airport_arrive__c=acceso[0].R1_VLI_TXT_Destination__c;
                nVuelo.R1_FLG_TXT_Carrier_code__c=acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c;
                nVuelo.R1_FLG_TXT_Carrier_code_oper__c=acceso[0].R1_VLI_TXT_Comp_Flight__c;
                nVuelo.R1_FLG_DAT_Flight_date_local__c=acceso[0].R1_VLI_DAT_Date__c;
                nVuelo.R1_FLG_TXT_Boarding_gate__c=acceso[0].R1_VLI_TXT_boarding_gate_cki__c;
                nVuelo.R1_FLG_TXT_Flight_no_oper__c=acceso[0].R1_VLI_TXT_Flight_number__c;
                
                
                System.debug(nVuelo.R1_FLG_DATH_Schedule_depart_time__c);
                insert nVuelo;
                acceso[0].R1_VLI_LOO_Flight__c=nVuelo.id;
                
            }
            if(acceso[0].R1_VLI_LOO_Cliente__c!=null){
                System.debug('Cliente IB');
                List<Account> cliente=[Select id,name,R1_ACC_PKL_Platinum_level_description__c from Account where id=:acceso[0].R1_VLI_LOO_Cliente__c];
                
                if(cliente.size()!=0){
                    acceso[0].R1_VLI_LOO_Cliente__c=cliente[0].id;
                    if(cliente[0].R1_ACC_PKL_Platinum_level_description__c=='04'){
                        infinita=true;
                        System.debug('Infinita');
                    }
                    else if(cliente[0].R1_ACC_PKL_Platinum_level_description__c=='05'){
                        infinitaP=true;
                        System.debug('Infinita Prime');
                    }
                }
            }
            else{
                if(noBuscarCliente==false){
                    List<Account> cliente=[Select id,name,R1_ACC_PKL_Platinum_level_description__c from Account where (R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c=:ff AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c!=null AND R1_ACC_TXT_Primary_Frecuent_Flyer_Card__c!='') AND (R1_ACC_CHK_Duplicate__c=false AND R1_ACC_CHK_Unsubscribe__c = false)];
                    if(cliente.size()!=0){
                        acceso[0].R1_VLI_LOO_Cliente__c=cliente[0].id;
                        if(cliente.size()!=0){
                            acceso[0].R1_VLI_LOO_Cliente__c=cliente[0].id;
                            if(cliente[0].R1_ACC_PKL_Platinum_level_description__c=='04'){
                                infinita=true;
                                System.debug('Infinita');
                            }
                            else if(cliente[0].R1_ACC_PKL_Platinum_level_description__c=='05'){
                                infinitaP=true;
                            }
                        }
                    }
                    else{
                        acceso[0].R1_VLI_ATXT_Observations__c+='Revisar Frequent Flyer: '+ acceso[0].R1_VLI_TXT_Frecuent_Flyer_number__c+'\n';
                    }
                }
            }
            
            System.debug('Infinita valor: '+infinita);
            
            //Se añade el filtro para que solo pueda acceder a la Sala VIP si el origen del vuelo es MAD
            //David Barco 14-8-17 
            System.debug(' Origen --> ' + acceso[0].R1_VLI_TXT_Origin__c);
            if( acceso[0].R1_VLI_TXT_Origin__c == 'MAD'){
                System.debug('El origen del vuelo es MAD');
                
                List<R1_VIP_Loung_access_rules__c> reglas;
                
                if(infinita){
                    reglas=[SELECT R1_VLR_TXT_Invited__c,R1_VLR_TXT_CHILD__c,R1_VLR_TXT_Value__c,R1_VLR_TXT_Observations__c FROM R1_VIP_Loung_access_rules__c WHERE 
                            ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='') AND ( R1_VLR_TXT_ID_AD_indicator__c!='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA'))))
                            OR
                            ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='') AND ( R1_VLR_TXT_ID_AD_indicator__c='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA'))))
                            OR
                            ((R1_VLR_TXT_Cia_Mark__c=:acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c AND R1_VLR_TXT_Cia_Mark__c!='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA'))))
                            ORDER BY R1_VLR_TXT_Invited__c DESC, R1_VLR_TXT_Observations__c DESC];
                }
                else{
                    if(infinitaP){
                        reglas=[SELECT R1_VLR_TXT_Invited__c,R1_VLR_TXT_CHILD__c,R1_VLR_TXT_Value__c,R1_VLR_TXT_Observations__c FROM R1_VIP_Loung_access_rules__c WHERE 
                                ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='') AND ( R1_VLR_TXT_ID_AD_indicator__c!='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA PRIME'))))
                                OR
                                ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='') AND ( R1_VLR_TXT_ID_AD_indicator__c='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA PRIME'))))
                                OR
                                ((R1_VLR_TXT_Cia_Mark__c=:acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c AND R1_VLR_TXT_Cia_Mark__c!='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c='INFINITA PRIME'))))
                                ORDER BY R1_VLR_TXT_Invited__c DESC, R1_VLR_TXT_Observations__c DESC];
                    }
                    else{
                        reglas=[SELECT R1_VLR_TXT_Invited__c,R1_VLR_TXT_CHILD__c,R1_VLR_TXT_Value__c,R1_VLR_TXT_Observations__c FROM R1_VIP_Loung_access_rules__c WHERE 
                                ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='')  AND ( R1_VLR_TXT_ID_AD_indicator__c!='') AND ((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND  (R1_VLR_TXT_FF_Iberia__c!='INFINITA' AND  R1_VLR_TXT_FF_Iberia__c!='INFINITA PRIME'))))
                                OR
                                ((R1_VLR_TXT_Cia_Ope__c=:acceso[0].R1_VLI_TXT_Comp_Flight__c AND R1_VLR_TXT_Cia_Ope__c!='')  AND ( R1_VLR_TXT_ID_AD_indicator__c='') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND  (R1_VLR_TXT_FF_Iberia__c!='INFINITA' AND  R1_VLR_TXT_FF_Iberia__c!='INFINITA PRIME'))))
                                OR
                                ((R1_VLR_TXT_Cia_Mark__c=:acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c AND R1_VLR_TXT_Cia_Mark__c!='') AND ( R1_VLR_TXT_ID_AD_indicator__c='ID/DA') AND((R1_VLR_TXT_Value__c=:acceso[0].R1_VLI_TXT_Class__c AND R1_VLR_TXT_Value__c!='') OR((R1_VLR_TXT_FF_Ow__c=:acceso[0].R1_VLI_TXT_OneWolrd_code__c AND R1_VLR_TXT_FF_Ow__c!='') AND (R1_VLR_TXT_FF_Iberia__c!='INFINITA' AND  R1_VLR_TXT_FF_Iberia__c!='INFINITA PRIME'))))
                                ORDER BY R1_VLR_TXT_Invited__c DESC, R1_VLR_TXT_Observations__c DESC];
                    }        
                }
                
                if(reglas.size()!=0){  
                    
                    if(reglas[0].R1_VLR_TXT_Invited__c==null){
                        acceso[0].R1_VLI_NUM_Guest_number__c=0;
                        reglas[0].R1_VLR_TXT_Invited__c='0';
                    }else {
                        acceso[0].R1_VLI_NUM_Guest_number__c=Integer.valueOF(reglas[0].R1_VLR_TXT_Invited__c);
                    }
                    
                    if(reglas[0].R1_VLR_TXT_Observations__c!=null){
                        acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                        acceso[0].R1_VLI_ATXT_Observations__c+=reglas[0].R1_VLR_TXT_Observations__c;
                        acceso[0].R1_VLI_NUM_Guest_number__c=Integer.valueOf(reglas[0].R1_VLR_TXT_Invited__c);
                    }
                    else{
                        acceso[0].R1_VLI_PKL_Access_status__c='Aprobado';
                        acceso[0].R1_VLI_NUM_Guest_number__c=Integer.valueOf(reglas[0].R1_VLR_TXT_Invited__c);
                    }
                    if(acceso[0].R1_VLI_DAT_Date__c == null){
                        acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                        acceso[0].R1_VLI_ATXT_Observations__c+='Fecha de Vuelo no suministrada, comprobar tarjeta de embarque manualmente.';
                    }
                }
                
                else{
                    if(infinita || InfinitaP){
                        acceso[0].R1_VLI_PKL_Access_status__c='Aprobado';
                        acceso[0].R1_VLI_NUM_Guest_number__c=0;   
                    }
                    else{
                        acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                        acceso[0].R1_VLI_NUM_Guest_number__c=0;
                    }
                }
            }//end If origin MAD rule
            else{
                acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                acceso[0].R1_VLI_ATXT_Observations__c='Tarjeta con origen distinto a MAD';
            }
            String externa = acceso[0].R1_VLI_TXT_Bn__c+acceso[0].R1_VLI_TXT_Comp_Mkt_flight__c+acceso[0].R1_VLI_TXT_Origin__c+acceso[0].R1_VLI_TXT_Flight_number__c+acceso[0].R1_VLI_DAT_Date__c;
            List<R1_VIP_Lounge_access__c> duplicado=[Select id,name,R1_VLI_PKL_Vip_lounge_position__c,R1_VLI_PKL_Sala_Vip__c from R1_VIP_Lounge_access__c where R1_VLI_TXT_Unique_Identifier__c=:externa];
            System.debug(duplicado.size());
            acceso[0].R1_VLI_TXT_Unique_Identifier__c=externa;
            System.debug('===== duplicados --> ' + duplicado);
            if(duplicado.size()>0 && duplicado[0].R1_VLI_PKL_Sala_Vip__c != null && duplicado[0].R1_VLI_PKL_Vip_lounge_position__c != null){
                acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                acceso[0].R1_VLI_ATXT_Observations__c='El cliente ya se encuentra en la sala '+duplicado[0].R1_VLI_PKL_Sala_Vip__c+' habiendo entrado por el '+ duplicado[0].R1_VLI_PKL_Vip_lounge_position__c;
                
            }
            DateTime dT = System.now();
            Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
            if(myDate>acceso[0].R1_VLI_DAT_Date__c){
                acceso[0].R1_VLI_PKL_Access_status__c='Denegado';
                acceso[0].R1_VLI_ATXT_Observations__c='La fecha sobrepasa la apuntada en la tarjeta de embarque';
                
            }
            System.debug('R1_VLI_PKL_Access_status__c --> ' + acceso[0].R1_VLI_PKL_Access_status__c);
            System.debug('Observaciones --> ' + acceso[0].R1_VLI_ATXT_Observations__c);
            
        }
        catch(Exception exc){
            if(exc.getMessage().contains('DUPLICATE_VALUE, duplicate value found') && intentos == 0){
                R1_VIP_Lounge_Access_CLS.validaracceso(acceso,1);
            }
            else{
                R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_Access_CLS__c', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
            }
        }
    }
    
    
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------
Author:         David Barco
Company:        Accenture
Description:    Method that assign a billing to the access when the access have the same values for company, lounge and date that a exists billing.

IN:         

OUT:           Void

History:

<Date>              <Author>            <Description>
17/08/2017          David Barco         Initial version
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //public static void asignaFacturaccion(List<R1_VIP_Lounge_Access__c> accesos){
    //    try{
    //        List<R1_VIP_Lounge_Access__c> access_fill = new List<R1_VIP_Lounge_Access__c>();
    //        //Si el acceso ha sido aprobado, y tiene los campos sala, fecha y compañía rellenos los añadimos a la lista
    //        for(R1_VIP_Lounge_Access__c a: accesos){
    //            if( (a.R1_VLI_PKL_Access_status__c == 'Aprobado' || a.R1_VLI_PKL_Access_status__c == 'Forzado') && a.R1_VLI_TXT_Comp_Flight__c != null && a.R1_VLI_TXT_Comp_Flight__c != '' && a.R1_VLI_DAT_Date__c != null && a.R1_VLI_PKL_Sala_Vip__c != null && a.R1_VLI_PKL_Sala_Vip__c != ''){
    //                access_fill.add(a);
    //            }
    //        }
    
    //        System.debug('===== access_fill ---> ' + access_fill);
    //        // si la lista tiene algún valor, buscamos la facturación que tiene la misma sala, fecha y compañía que los accesos en la lista
    //        if(!access_fill.isEmpty()){
    //            String query = 'SELECT Id, R1_BIL_TXT_FF_company__c, R1_BIL_PCK_Lounge__c, R1_BIL_DAT_Date__c from R1_VIP_Lounge_Billing__c WHERE ';
    //            Boolean first = true;
    
    //            for(R1_VIP_Lounge_Access__c a: access_fill){
    //                if(!first){
    //                    query += ' OR ';
    //                }
    
    //                query += '(R1_BIL_TXT_FF_company__c == ' + a.R1_VLI_TXT_Comp_Flight__c + ' AND R1_BIL_PCK_Lounge__c == ' + a.R1_VLI_PKL_Sala_Vip__c + ' AND R1_BIL_DAT_Date__c == ' + a.R1_VLI_DAT_Date__c + ')';
    //                if(first){
    //                    first = !first;
    //                }
    //            }
    
    //            List<R1_VIP_Lounge_Billing__c> facturaciones = new List<R1_VIP_Lounge_Billing__c>();
    //            facturaciones = Database.query(query);
    //            System.debug('===== query facturaciones --> ' + Database.query(query));
    
    //              PROBAR RESULTADOS + MODIFICACIONES + TEST
    
    //        }
    
    
    
    //    }catch(Exception exc){
    //      R1_CLS_LogHelper.generateErrorLog('R1_VIP_Lounge_Access_CLS__c', '', exc.getmessage()+', '+exc.getLineNumber(), 'R1_VIP_Lounge_Access__c');
    //    }
    
    //}
    
}