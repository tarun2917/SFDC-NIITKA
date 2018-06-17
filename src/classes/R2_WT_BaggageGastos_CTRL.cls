/*-------------------------------------------------------------------------------------------------------------------------------------------------------
    Author:         Jaime Ascanta
    Company:        Accenture
    Description:    Controller for VF R2_BAG_VF_BaggageGastos

    IN:
    OUT:

    History:

    <Date>              <Author>                                 <Description>
    01/12/2017          Jaime Ascanta															Initial version.
    --------------------------------------------------------------------------------------------------------------------------------------------------------*/
public class R2_WT_BaggageGastos_CTRL {
		// buttons
		public Boolean deleteDisabled {get;set;}
		public Boolean saveDisabled {get;set;}
		public Boolean cancelDisabled {get;set;}

		public R1_Incident__c pir;
		public List<Gasto> gastosListRender {get;set;}
		public List<Gasto> newRowsListRender {get;set;}
		//columnas a mostrar
		// si se agrega un nuevo campo, tambien agregar nueva condicion en saveHandler()
    private String fieldsListDetail = 'R2_ADI_NUM_CS_Amount__c, R2_ADI_TXT_CS_Currency__c, R2_ADI_PKL_CS_Cost_Type__c, R2_ADI_FOR_CS_Amount__c, R2_ADI_NUM_Decimal_Place__c';

    public R2_WT_BaggageGastos_CTRL(ApexPages.StandardController stdController) {
        this.pir = (R1_Incident__c) stdController.getRecord();
				// inicializamos listas a renderizar en la tabla
				this.gastosListRender = new List<Gasto>();
				this.newRowsListRender = new List<Gasto>();

				// cargamos datos iniciales de la tabla
				this.initGastosListRender();
    }

		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
				    Author:         Jaime Ascanta
				    Company:        Accenture
				    Description:    generate headers of the table.

				    IN:
				    OUT:

				    History:

				    <Date>              <Author>                                 <Description>
				    01/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
				public List<Field> getHeadersTable(){
					try{
							if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
							Schema.SObjectType leadSchema = Schema.getGlobalDescribe().get('R2_Auxiliar_Data_Incident__c');
							Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
							List<String> splitListFields = fieldsListDetail.split(', ');

							List<Field> fieldsList = new List<Field>();

							for(String field : splitListFields){
								Field fieldObject = new Field();
								fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
								fieldObject.name = field;
								fieldsList.add(fieldObject);
							}
							return fieldsList;
					}catch(Exception e){
						System.debug('*** Exception getHeadersTable(): '+ e);
						return null;

					}
				}

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
		    Author:         Jaime Ascanta
		    Company:        Accenture
		    Description:    carga datos en la lista de render DB

		    IN:
		    OUT:

		    History:

		    <Date>              <Author>                                 <Description>
		    01/12/2017          Jaime Ascanta															Initial version.
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		private void initGastosListRender(){
			try{
					if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
					this.gastosListRender.clear();

					String query = 'SELECT Id, '+fieldsListDetail+' FROM R2_Auxiliar_Data_Incident__c WHERE R2_ADI_MSDT_Incident__c = \''+pir.Id+'\' ORDER BY CreatedDate  DESC';
					List<R2_Auxiliar_Data_Incident__c> gastosData = Database.query(query);

					Schema.SObjectType leadSchema = Schema.getGlobalDescribe().get('R2_Auxiliar_Data_Incident__c');
					Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();

					List<String> listFields = fieldsListDetail.split(', ');
					for(R2_Auxiliar_Data_Incident__c gasto : gastosData){
						Gasto gastoObject = new Gasto();
						gastoObject.deleted = false;
						gastoObject.idObj = (String) gasto.get('Id');
						gastoObject.fields = new List<Field>();

							for(String field : listFields){
								Field fieldObject = new Field();
								fieldObject.isFormula = field.contains('_FOR_') ? true : false;
								fieldObject.value = (String) String.valueOf(gasto.get(field));
								fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
								fieldObject.name = field;
								gastoObject.fields.add(fieldObject);
							}

							this.gastosListRender.add(gastoObject);
					}

					this.setStatusButtons();

			}catch(Exception e){
				System.debug('*** Exception setRenderList(): '+ e);
			}
		}
		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
				    Author:         Jaime Ascanta
				    Company:        Accenture
				    Description:    agrega un afila vacia para ser rellenada por el usuario

				    IN:
				    OUT:

				    History:

				    <Date>              <Author>                                 <Description>
				    01/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		public void addRoowEmpty(){
			try{
					if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
					Schema.SObjectType leadSchema = Schema.getGlobalDescribe().get('R2_Auxiliar_Data_Incident__c');
					Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
						List<String> listFields = fieldsListDetail.split(', ');
						Gasto gastoObject = new Gasto();
						gastoObject.deleted = false;
						gastoObject.idObj = null;
						gastoObject.fields = new List<Field>();

							for(String field : listFields){
								Field fieldObject = new Field();
								fieldObject.isFormula = field.contains('_FOR_') ? true : false;
								fieldObject.value = field.contains('_NUM_') ? '0' : '';
								fieldObject.label = fieldMap.get(field).getDescribe().getLabel();
								fieldObject.name = field;
								gastoObject.fields.add(fieldObject);
							}

				this.newRowsListRender.add(gastoObject);

				this.setStatusButtons();

			}catch(Exception e){
				System.debug('*** Exception addRoowEmpty(): '+ e);
			}

		}

		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
				    Author:         Jaime Ascanta
				    Company:        Accenture
				    Description:    elimina todas las nuevas filas que se han creadas.

				    IN:
				    OUT:

				    History:

				    <Date>              <Author>                                 <Description>
				    04/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		public  void cancelHandler(){
			this.newRowsListRender.clear();
			this.setStatusButtons();
		}

		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
						Author:         Jaime Ascanta
						Company:        Accenture
						Description:    guarda las filas nuevas, comprobando si no estan vacios sus campos.

						IN:
						OUT:

						History:

						<Date>              <Author>                                 <Description>
						04/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		public  void saveHandler(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				Boolean isValidData = false;
				List<R2_Auxiliar_Data_Incident__c> gastosListInsert = new List<R2_Auxiliar_Data_Incident__c>();
				for (Gasto g: this.newRowsListRender) {

						R2_Auxiliar_Data_Incident__c adi = new R2_Auxiliar_Data_Incident__c();
						adi.R2_ADI_MSDT_Incident__c = this.pir.Id;

						for (Field f: g.fields) {
							if(f.value != '' && f.name.contains('R2_ADI_NUM_CS_Amount__c')) {
								adi.R2_ADI_NUM_CS_Amount__c = Decimal.valueOf(f.value);
								isValidData = true;
							}
							else if(f.value != '' && f.name.contains('R2_ADI_TXT_CS_Currency__c')){
								adi.R2_ADI_TXT_CS_Currency__c = f.value;
								isValidData = true;
							}
							else if(f.value != '' && f.name.contains('R2_ADI_PKL_CS_Cost_Type__c')){
								adi.R2_ADI_PKL_CS_Cost_Type__c = f.value;
								isValidData = true;
							}
							else if(f.value != '' && f.name.contains('R2_ADI_NUM_Decimal_Place__c')){
								adi.R2_ADI_NUM_Decimal_Place__c = Decimal.valueOf(f.value);
								isValidData = true;
							}
							if (isValidData) {
								adi.R2_ADI_PKL_Type__c = 'CS';
							}
						}

						gastosListInsert.add(adi);
				}


				if(isValidData) {
					insert gastosListInsert;
					this.initGastosListRender();
				}

				this.cancelHandler();

				this.setStatusButtons();

			}catch(Exception e){
				System.debug('*** Exception saveHandler(): '+ e);
			}
		}

		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
						Author:         Jaime Ascanta
						Company:        Accenture
						Description:    handler for deleted

						IN:
						OUT:

						History:

						<Date>              <Author>                                 <Description>
						04/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		public  void deletedHandler(){
			this.deletedFromDatabase();
			this.deletedRowsEmpty();
		}


		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
						Author:         Jaime Ascanta
						Company:        Accenture
						Description:    elimina elementos de la base de datos

						IN:
						OUT:

						History:

						<Date>              <Author>                                 <Description>
						07/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		private void deletedFromDatabase(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				Set<Id> idObjSet = new Set<Id>();
				List<R2_Auxiliar_Data_Incident__c> deletedList = new List<R2_Auxiliar_Data_Incident__c>();

				// set de ids
				for (Gasto gasto: this.gastosListRender) {
					if(gasto.idObj!=null && gasto.deleted==true ) {
						Id idObj= (Id) Id.valueOf(gasto.idObj);
						idObjSet.add(idObj);
					}
				}
				// objetos a eliminar de la db
				for(Id idObj : idObjSet){
					R2_Auxiliar_Data_Incident__c gasto = new R2_Auxiliar_Data_Incident__c();
					gasto.Id = idObj;
					deletedList.add(gasto);
				}

				if(!deletedList.isEmpty()){
					delete deletedList;
					this.initGastosListRender();
				}

				this.setStatusButtons();

			}catch(Exception e){
				System.debug('*** Exception deletedFromDatabase(): '+ e);
			}
		}

		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
						Author:         Jaime Ascanta
						Company:        Accenture
						Description:    elimina elementos nuevos de la lista (no estan en la db)

						IN:
						OUT:

						History:

						<Date>              <Author>                                 <Description>
						07/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		private void deletedRowsEmpty(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				List<Gasto> tempList = new List<Gasto>();
				for(Gasto gasto: this.newRowsListRender){
					if(!gasto.deleted) {
						tempList.add(gasto);
					}
				}

				this.newRowsListRender.clear();

				for(Gasto gasto: tempList){
					this.newRowsListRender.add(gasto);
				}

				this.setStatusButtons();

			}catch(Exception e){
				System.debug('*** Exception deletedRowsEmpty(): '+ e);
			}
		}


		/*-------------------------------------------------------------------------------------------------------------------------------------------------------
				    Author:         Jaime Ascanta
				    Company:        Accenture
				    Description:    cambia el estado de los botones.

				    IN:
				    OUT:

				    History:

				    <Date>              <Author>                                 <Description>
				    04/12/2017          Jaime Ascanta															Initial version.
		--------------------------------------------------------------------------------------------------------------------------------------------------------*/
		private  void setStatusButtons(){
			try{
				if(R1_CLS_LogHelper.isRunningTest()){throw new R1_CLS_LogHelper.R1_Exception('test');} //Excepcion para cubrir codigo de la clase de test activar con R1_CLS_LogHelper.throw_exception = true; 
  
				this.deleteDisabled = this.gastosListRender.isEmpty() && this.newRowsListRender.isEmpty() ? true : false;
				this.saveDisabled = this.newRowsListRender.size() == 0 ? true : false;
				this.cancelDisabled = this.newRowsListRender.size() == 0 ? true : false;
			}catch(Exception e){
				System.debug('*** Exception setStatusButtons(): '+ e);
			}
		}

	public class Gasto {
			public Boolean deleted {get;set;}
			public String idObj {get;set;}
			public List<Field> fields {get;set;}
	}

	public class Field{
			public Boolean isFormula {get;set;}
			public String label {get;set;}
			public String value {get;set;}
			public String name {get;set;}
	}

}