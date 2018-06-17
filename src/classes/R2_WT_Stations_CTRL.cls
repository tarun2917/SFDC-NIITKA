/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Controller R2_VF_WT_Stations.page
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    14/11/2017             Alberto Puerto Collado                  Initial Version
    ----------------------------------------------------------------------------------------------------------------------*/
public class R2_WT_Stations_CTRL {
	public R2_WT_Stations_CTRL(){

	}
	public String respStation{get;set;}{respStation = '';}
	public String inputEstacion{get;set;}{inputEstacion = 'MAD';}
	public String inputAirC{get;set;}{inputAirC = 'IB';}
	public String agent{get;set;}{agent = [SELECT Alias FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1].Alias;}

/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling listStations on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    17/11/2017             Alberto Puerto Collado                  Initial Version
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
	public void listStations(){      
        try{
        	if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 

			R2_CLS_WT_Bags_Management.WR_DisplayStationListWebReq req = new R2_CLS_WT_Bags_Management.WR_DisplayStationListWebReq();
			req.status = 'A';
			req.agentId = agent;
			req.airlineVendorId = 'IB'; //hard code always IB

			String jsonData = JSON.serialize(req);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);


			R2_CLS_WT_Bags_Management.WR_StationWebResp resultado = R2_CLS_WT_Bags_Management.DisplayStationList(jsonData,0);
			System.debug(':::Resultado DSL::::'+resultado);

			//respStation = resultado;
			//return ret;
			if(resultado.success == 'YES' || resultado.success == 'TRUE'){
				respStation = '';
				System.debug('Pintando respuesta success y warnings');
	            respStation += '</br><label class="apartadoModal"><strong>Lista de estaciones:</strong></label></br>';

	            for(Integer i=0; i<resultado.stations.stationProperty.size(); i++){
	            	respStation += '</br>&#10146<label class="propiedadTitle">'+ resultado.stations.stationProperty[i].stationPropertyDescription +'</label></br>';
	            	for(Integer s=0; s<resultado.stations.stationProperty[i].stationPropertySubType.size() ;s++){
	            		if(resultado.stations.stationProperty[i].stationPropertySubType[s].values.value[0] != 'NO CURRENT STATIONS'
	            			&& resultado.stations.stationProperty[i].stationPropertySubType[s].values.value[0] != 'NONE'){

	            			respStation += '&emsp;<label class="propiedadSub">&#8811; '+ resultado.stations.stationProperty[i].stationPropertySubType[s].stationPropertySubTypeDescription +':</label></br>';
	            			respStation += '<label ">';
	            			for(Integer v=0; v<resultado.stations.stationProperty[i].stationPropertySubType[s].values.value.size() ;v++){
	            				respStation += ''+ resultado.stations.stationProperty[i].stationPropertySubType[s].values.value[v] +'	&emsp;';
	            			}
	            			respStation += '</label></br></br>';
	            		}	            		
	            	}	            	
	            }
	            if(resultado.warnings != null && !resultado.warnings.isEmpty()){
	                for(Integer i=0; i<resultado.warnings.size(); i++){
	                    System.debug('Pintando warnings');
	                    respStation += '</br><label class="apartadoModal">Advertencias:</label></br>';
	                    respStation += resultado.warnings[i].warningCode + ' - ' + resultado.warnings[i].warningDescription + '\\n';
	                }
	            }    
			}else{
				System.debug('Pintando errores');
				respStation = '';
	            respStation += '</br><label class="apartadoModal">Error en los datos, por favor revíselos</label>';
	            for(Integer i=0; i<resultado.errors.size(); i++){
	                System.debug('Pintando errores en bucle');
	                //informeCrear += '</br>'+ resultado.errors[i].code + ' - ' + resultado.errors[i].reason + '\\n';
	                respStation += '</br>';
	                String codigo = resultado.errors[i].code;
	                codigo = codigo.toUpperCase();
	                if(!codigo.contains('UNKNOWN')){
	                    respStation += resultado.errors[i].code + ' - ';
	                }
	                respStation += resultado.errors[i].reason + '\\n';
	            }
			}
			CLS_INC_WT_Monitoring.watchingWT( 'listStations', 'Stations'); 
		}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_Stations_CTRL.listStations', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            //return null;
        }
	}
/*---------------------------------------------------------------------------------------------------------------------
    Author:         Alberto Puerto Collado
    Company:        Accenture
    Description:    Calling screenStations on WT
    IN:             
    OUT:            

    History: 
     <Date>                     <Author>                         <Change Description>
    20/11/2017              Alberto Puerto Collado                  Initial Version
    07/05/2018				Alberto Puerto Collado					Displaying DSS with better format
    09/05/2018             Alberto Puerto Collado                  Calling CLS_INC_WT_Monitoring.watchingWT 
    ----------------------------------------------------------------------------------------------------------------------*/
	public void screenStations(){    
        try{
        	if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
    		 
    		
        	System.debug('*** inputEstacion: ' + inputEstacion);
        	System.debug('*** inputAirC: ' + inputAirC);
			R2_CLS_WT_Bags_Management.WR_DisplayStationScreenWebReq req = new R2_CLS_WT_Bags_Management.WR_DisplayStationScreenWebReq();
			R2_CLS_WT_Bags_Management.ReferenceStationAirline rsa = new R2_CLS_WT_Bags_Management.ReferenceStationAirline();
				rsa.stationCode = inputEstacion; //'MAD';
				rsa.airlineCode = inputAirC;//'IB';
			req.referenceStationAirline = rsa;
			req.agentId = agent;//'Test';

			String jsonData = JSON.serialize(req);

            jsonData = R2_CLS_WT_Bags_Management.helper_fixerJson(jsonData);
            System.debug('*** jsonData: ' + jsonData);

			R2_CLS_WT_Bags_Management.WR_StationWebResp resultado = R2_CLS_WT_Bags_Management.DisplayStationScreen(jsonData,0);

			//respStation = ret;
			if(resultado.success == 'YES' || resultado.success == 'TRUE'){
				respStation = '';
				System.debug('Pintando respuesta success y warnings');
	            respStation += '</br><label class="apartadoModal"><strong>Display Station Screen (DSS):</strong></label></br>';

	           
	            if(resultado.stationConfig != null){
	            	if(resultado.stationConfig.stationConfigAttributes != null){
	            		respStation += '&emsp;Station Screen: <strong>' + resultado.stationConfig.stationConfigAttributes.stationCode + resultado.stationConfig.stationConfigAttributes.airlineCode + '</strong> ';
	            		respStation += '&emsp;Last Update: ' + resultado.stationConfig.stationConfigAttributes.updateDate + '</br>';
	            	}
	            	if(resultado.stationConfig.handler != null){ // &#10146 &emsp;
	            		respStation += '&#10146; Handled by: </br>';
	            		if(resultado.stationConfig.handler.current != null){
	            			respStation += '&emsp;&#8811; Current: ' + resultado.stationConfig.handler.current + '</br>';
	            		}
	            		if(resultado.stationConfig.handler.newReplace != null){
	            			respStation += '&emsp;&#8811; NewReplace: ' + resultado.stationConfig.handler.newReplace + '</br>';
		            	}
		            	if(resultado.stationConfig.handler.effectiveDate != null){
		            		respStation += '&emsp;&#8811; EffectiveDate: ' + resultado.stationConfig.handler.effectiveDate + '</br>';
		            	}     	
	            	}
	            	if(resultado.stationConfig.participancy != null){
	            		respStation += '&#10146; Participancy:</br>'; //(World Tracer systems in which the airline participates)
	            		//MODULE VALUES: WT - World Tracer Tracing, WM - World Tracer Management, WI - World Tracer Claims Investigation
	            		for(Integer i = 0; i < resultado.stationConfig.participancy.size(); i++){
	            			respStation += '&emsp;&#8811; Module: ' + resultado.stationConfig.participancy[i].module;
	            			String valorStatus = resultado.stationConfig.participancy[i].status;
	            			if(valorStatus.equalsIgnoreCase('A')){
	            				valorStatus = 'Active';
            				}else if(valorStatus.equalsIgnoreCase('I')){
            					valorStatus = 'Inactive';
        					}else if(valorStatus.equalsIgnoreCase('T')){
        						valorStatus = 'Training';
        					}//else{same value}
	            			respStation += '&emsp;Status: ' + valorStatus;
	            			respStation += '&emsp;Access: ' + resultado.stationConfig.participancy[i].access + '</br>';
	            		}
	            	}
	            	if(resultado.stationConfig.defaultAddress != null){
	            		respStation += '&#10146; Default Addresses:</br>';
	            		if(resultado.stationConfig.defaultAddress.email != null){
	            			respStation += '&emsp;&#8811; Email: ' + resultado.stationConfig.defaultAddress.email + '</br>';
	            		}
	            		if(resultado.stationConfig.defaultAddress.tty != null){
	            			respStation += '&emsp;&#8811; TTY: ' + resultado.stationConfig.defaultAddress.tty + '</br>';

		            	}
	            	}
	            	if(resultado.stationConfig.matchDivryAttribs != null){
	            		respStation += '&#10146; Match Delivery Attributes:</br>';
	            		//Contains the details of the re-routing to be done after defined number of days of receiving a message
	            		for(Integer i = 0; i < resultado.stationConfig.matchDivryAttribs.size(); i++){
	            			if(resultado.stationConfig.matchDivryAttribs[i].seq != null){
	            				respStation += '&emsp;&#8811; Module: ' + resultado.stationConfig.matchDivryAttribs[i].seq;
	            			}
	            			if(resultado.stationConfig.matchDivryAttribs[i].days != null){
	            				respStation += '&emsp;Days: ' + resultado.stationConfig.matchDivryAttribs[i].days;//Number of days after which the re-routing needs to be done
	            			}
	            			if(resultado.stationConfig.matchDivryAttribs[i].stationCode != null || resultado.stationConfig.matchDivryAttribs[i].airlineCode != null){
	            				respStation += '&emsp;Station&Airline: ' + resultado.stationConfig.matchDivryAttribs[i].stationCode + resultado.stationConfig.matchDivryAttribs[i].airlineCode;
	            			}
	            			if(resultado.stationConfig.matchDivryAttribs[i].tty != null){
	            				respStation += '&emsp;TTY: ' + resultado.stationConfig.matchDivryAttribs[i].tty + '</br>';
	            			}		            			
	            		}
	            	}
	            	if(resultado.stationConfig.options != null){
	            		respStation += '&#10146; Options:</br>';
	            		if(resultado.stationConfig.options != null){
	            			//Yes indicates if the station is controlled by an LZ handler, else No; Default option is No
            				respStation += '&emsp;&#8811; LZ Controller: ' + resultado.stationConfig.options.lzControlled;
            			}
            			if(resultado.stationConfig.options != null){
            				//No indicates user with an in-house file reference number generation; Yes or blank indicates that SITA will generate file reference numbers; Default option is Yes
            				respStation += '&emsp;SITA Ref: ' + resultado.stationConfig.options.sitaRef;//Number of days after which the re-routing needs to be done
            			}
	            	}
	            	
	            }
	            if(resultado.warnings != null && !resultado.warnings.isEmpty()){
	                for(Integer i=0; i<resultado.warnings.size(); i++){
	                    System.debug('Pintando warnings');
	                    respStation += '</br><label class="apartadoModal">Advertencias:</label></br>';
	                    respStation += resultado.warnings[i].warningCode + ' - ' + resultado.warnings[i].warningDescription + '\\n';
	                }
	            }    
			}else{
				respStation = '';
				System.debug('Pintando errores');
	            respStation += '</br><label class="apartadoModal">Error en los datos, por favor revíselos</label>';
	            for(Integer i=0; i<resultado.errors.size(); i++){
	                System.debug('Pintando errores en bucle');
	                //informeCrear += '</br>'+ resultado.errors[i].code + ' - ' + resultado.errors[i].reason + '\\n';
	                respStation += '</br>';
	                String codigo = resultado.errors[i].code;
	                codigo = codigo.toUpperCase();
	                if(!codigo.contains('UNKNOWN')){
	                    respStation += resultado.errors[i].code + ' - ';
	                }
	                respStation += resultado.errors[i].reason + '\\n';
	            }
	        }
	        CLS_INC_WT_Monitoring.watchingWT( 'screenStations', 'Stations');
			
		}catch(Exception ex){
            R1_CLS_LogHelper.generateErrorLog('R2_WT_Stations_CTRL.screenStations', '', ex.getmessage()+', '+ex.getLineNumber(), 'R2_Incident__c');
            //return null;
        }
	}
}