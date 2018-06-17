(function(scope, util, Store, sforce, console, logger, $) {
  'use strict';

  // Init
  if (!scope.thc || !scope.thc.big) {
    throw new Error('Big main Module not defined');
  }

  var mixins = {};

  /**
   * Carga un valor almacenado en el localStorage. Por defecto, cargar el objeto state, que contiene el estado completo del softphone.
   * @return {Object} Estado almacenado del softphone en el localStorage
   */
  var LOCAL_STORAGE_STATE_KEY = 'state';

  function loadAllStorage() {
    return JSON.parse(localStorage.getItem(LOCAL_STORAGE_STATE_KEY) || '{}');
  }

  function saveAllToStorage(store, forceClean) {

    if (typeof(store) !== 'object') {
      throw 'saveAllToStorage: Cant\'t store individual values';
    }

    if (forceClean) {
      localStorage.clear();
    }

    for (var key in store) {
      localStorage.setItem(key, JSON.stringify(store[key]));
    }
  }

  function loadStateFromStorage() {
    var state = JSON.parse(localStorage.getItem(LOCAL_STORAGE_STATE_KEY) || '{}');

    localStorage.removeItem(LOCAL_STORAGE_STATE_KEY);

    return state;
  }

  /**
   * Guarda el estado en el localStorage. Puede ser un estado parcial, sin contener todos los valores del estado.
   */
  function saveStateToStorage(state) {
    var reducedState = Object.assign(loadStateFromStorage(), state) || {};

    localStorage.setItem(LOCAL_STORAGE_STATE_KEY, JSON.stringify(reducedState));
  }


  // Inner classes
  function bigController() {
    var that = {};
    var tickHandlers = {};
    var universalTiming = scope.setInterval(function() {
      for (var handlerName in tickHandlers) {
        tickHandlers[handlerName]();
      }
    }, 250);

    function getInitState() {
      return {
        session: {
          isLogged: false
        },
        login: {

        },
        overlay:{
          show: false
        },
        isLoading: false,
        presence: {

        },
        agent: {
          states: [],
          state: '-1'
        },
        phone: {
          calls: {},
          cleared: {},
          dialing: [],
          consulting: [],
          conferencing: [],
          active: ''
        },
        transaction: {
          active: '',
          list: {}
        },
        agenda: {
          isSearching: false,
          searchResults: [],
          searchString: ''
        },
        myLastCalls: [],
        ui: {
          isDialPadOpened: false,
          isCampaignsOpened: false,
          isStateChanging: false,
          isSelectingNotReadyReason: false,
          isAgentStatePanel: true,
          isMyLastCallsOpened: false,
          isCallInfoOpened: true,
          isNoResultsPanelOpened: true,
          isServiceSelectorShown: false,
          isCallDetailCardOpened: true,
          isTransactionEnabled: false,
          isTransactionOptionsOpened: false,
          isRecordingEnabled : false,
          isRecordingOpened : false,
          customActionsControl: {
            isOpened: false,
            filter: ''
          },
          serviceSelectorFilter: '',
          campaignsFilter: ''
        },
        notifications: {
          show: false,
          message: ''
        },
        error: {
          type: '',
          message: ''
        },
        services: {
          ready: false,
          campaigns: [],
          notReadyReasons: []
        }
      }
    }

    var statePrinted = false;

    that.store = new Store(
      getInitState(),
      function(newState) {
        thc.ui.onStoreUpdate(newState);
      });



    that.addTickListener = function(name, handler) {
      tickHandlers[name] = handler;
    }

    that.removeTickListener = function(name) {
      delete tickHandlers[name];
    }

    that.callTreeReducer = function(state, changes) {
      if (state.phone && changes.phone) {
        state.phone = changes.phone;
      }

      return state;
    }

    /**
     * Util methods for searchAndScreenPop
     **/

    /**
     * Formate un número mediante la librería PhoneFormat a partir de la configuración regional del softphone.
     **
     * @author jmartinezpisson
     * @param {String} phoneNumber - Número de teléfono a formatear
     * @return {Object} formattedPhoneNumber - Número formateado
     * @return {Object} formattedPhoneNumber.phoneNumber - Número formateado
     * @return {Object} formattedPhoneNumber.isValid - Identifica si el núemro es válido dentro de la configuración dada
     */
    function formatPhoneNumber(phoneNumber) {
      var dialingSettings = thc.settings.get().callcenter.dialing,
        phoneFormatSettings = thc.settings.get().phoneFormat,
        countryCode = null,
        formattedPhoneNumber = {
          phoneNumber: phoneNumber,
          isValid: true
        },
        samplePhoneNumber = null,
        nationalPrefix = null;

      if (!isInternalCall({
          type: thc.CALL_TYPE.OUTBOUND,
          dnis: phoneNumber
        })) {

        // Librería PhoneFormat
        if (phoneFormatSettings.usePhoneFormatLibrary) {
          //Se comprueba si el country code que se obtiene del número se corresponde con el definido en el call center
          countryCode = countryForE164Number(phoneNumber);

          if (countryCode) {
            if (countryCode === dialingSettings.countryCode) {
              //Llamada local
              logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Local call ' + countryCode);

              formattedPhoneNumber.phoneNumber = formatLocal(countryCode, phoneNumber);
              formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
            } else {
              //Llamada internacional
              logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'International call ' + countryCode);
              formattedPhoneNumber.phoneNumber = formatInternational(countryCode, phoneNumber);
              formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
            }
          } else {
            //El número no tiene un prefijo E164 reconocible. Existen dos opciones: que tenga el prefijo pero no en el formato adecuado para la librería (tiene el prefijo 34 o 0034 en lugar de +34), o que sea un número nacional
            logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Unknown prefix');
            phoneNumber = phoneNumber.replace(/\D/g, '');

            if (isValidNumber(phoneNumber, dialingSettings.countryCode)) {
              logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Valid number ' + phoneNumber);
              samplePhoneNumber = exampleMobileNumber(dialingSettings.countryCode);
              nationalPrefix = formatE164('ES', samplePhoneNumber).replace(samplePhoneNumber, '').replace(/\D/g, '');

              //Si el número contiene el prefijo local (ya sea en formato +34, 0034 o 34), se elimina. Si no lo contiene, se da por hecho que está en formato internacional

              if (phoneNumber.indexOf(nationalPrefix) > -1 && phoneNumber.indexOf(nationalPrefix) < 3) {
                logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Local call with bad prefix');

                formattedPhoneNumber.phoneNumber = formatLocal(dialingSettings.countryCode, phoneNumber);
                formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
              } else {
                logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'No bad prefix');

                if (phoneNumber.charAt(0) === '0') {
                  do {
                    phoneNumber = phoneNumber.slice(1);
                  } while (phoneNumber.charAt(0) === '0');

                  phoneNumber = '+' + phoneNumber;

                  countryCode = countryForE164Number(phoneNumber);
                  phoneNumber = phoneNumber.replace(/\D/g, '');

                  if (countryCode) {
                    logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Country code found: ' + countryCode);

                    if (countryCode === dialingSettings.countryCode) {
                      formattedPhoneNumber.phoneNumber = phoneNumber;
                      formattedPhoneNumber.isValid = true;
                    } else {
                      //Llamada internacional
                      formattedPhoneNumber.phoneNumber = (dialingSettings.prefixForInternational || '') + phoneNumber;
                      formattedPhoneNumber.isValid = true;
                    }
                  } else {
                    logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'No country code found');
                    //Llamada nacional
                    formattedPhoneNumber.phoneNumber = phoneNumber;
                    formattedPhoneNumber.isValid = true;
                  }
                } else {
                  logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Local number with no prefix');

                  formattedPhoneNumber.phoneNumber = phoneNumber.replace(/\D/g, '');
                  formattedPhoneNumber.isValid = true;
                }
              }
            } else {
              logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Invalid number');

              if (phoneNumber.indexOf('+') < 0) {
                //Si el número carece de el simbolo + (que es lo que la librería espera tener antes del prefijo), se le añade y se comprueba de nuevo.
                logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'No \'+\' found');
                phoneNumber = '+' + phoneNumber.replace(/\D/g, '');
                countryCode = countryForE164Number(phoneNumber);

                if (countryCode) {
                  if (countryCode === dialingSettings.countryCode) {
                    //Es una llamada local
                    logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Local call ' + countryCode);

                    formattedPhoneNumber.phoneNumber = formatLocal(countryCode, phoneNumber);
                    formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);

                  } else {
                    //Es una llamada internacional
                    logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'International call ' + dialingSettings.countryCode);

                    //Se comprueba si hay definido en el call center un prefijo para llamadas internacionales, y se le añade
                    formattedPhoneNumber.phoneNumber = formatInternational(dialingSettings.countryCode, phoneNumber);
                    formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
                    formattedPhoneNumber.phoneNumber = (dialingSettings.prefixForInternational || '') + formattedPhoneNumber.phoneNumber;
                  }
                } else {
                  logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Unknown prefix');
                  //Si áñadiendo el '+' aún no se reconoce ningún prefijo, se comprueba si el número comienza por '0's y se eliminan
                  phoneNumber = phoneNumber.replace(/\D/g, '');

                  while (phoneNumber.charAt(0) === '0') {
                    phoneNumber = phoneNumber.slice(1);
                  }

                  phoneNumber = '+' + phoneNumber;

                  logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Number with no 0s: ' + phoneNumber);

                  countryCode = countryForE164Number(phoneNumber);

                  if (countryCode) {
                    if (countryCode === dialingSettings.countryCode) {
                      //Es una llamada local
                      logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Local call ' + countryCode);

                      formattedPhoneNumber.phoneNumber = formatLocal(countryCode, phoneNumber);
                      formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
                    } else {
                      //Es una llamada internacional
                      logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'International call ' + countryCode);

                      //Se comprueba si hay definido en el call center un prefijo para llamadas internacionales, y se le añade
                      formattedPhoneNumber.phoneNumber = formatInternational(dialingSettings.countryCode, phoneNumber);
                      formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
                      formattedPhoneNumber.phoneNumber = (dialingSettings.prefixForInternational || '') + formattedPhoneNumber.phoneNumber;
                    }
                  } else {
                    logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Yet unknown prefix');
                    //El número pulsado no tiene un prefijo E164 reconocible
                    samplePhoneNumber = exampleMobileNumber(dialingSettings.countryCode);
                    nationalPrefix = formatE164('ES', samplePhoneNumber).replace(samplePhoneNumber, '').replace(/\D/g, '');

                    //Si el número contiene el prefijo local (ya sea en formato +34, 0034 o 34), se elimina. Si no lo contiene, se da por hecho que está en formato internacional
                    formattedPhoneNumber.phoneNumber = (phoneNumber.indexOf(nationalPrefix) > -1 && phoneNumber.indexOf(nationalPrefix) < 3) ? formatLocal(dialingSettings.countryCode, phoneNumber) : phoneNumber;
                    formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
                  }
                }
              } else {
                logger.log(logger.LOG_TYPE.PHONE_FORMAT, 'Number has \'+\' but unknown prefix');
                //El número pulsado no tiene un prefijo E164 reconocible
                samplePhoneNumber = exampleMobileNumber(dialingSettings.countryCode);
                nationalPrefix = formatE164('ES', samplePhoneNumber).replace(samplePhoneNumber, '').replace(/\D/g, '');

                //Si el número contiene el prefijo local (ya sea en formato +34, 0034 o 34), se elimina. Si no lo contiene, se da por hecho que está en formato internacional
                formattedPhoneNumber.phoneNumber = (phoneNumber.indexOf(nationalPrefix) > -1 && phoneNumber.indexOf(nationalPrefix) < 3) ? formatLocal(dialingSettings.countryCode, phoneNumber) : phoneNumber;
                formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
              }
            }
          }
        } else {
          formattedPhoneNumber.phoneNumber = phoneNumber.replace(/\D/g, '');
          formattedPhoneNumber.isValid = isValidNumber(formattedPhoneNumber.phoneNumber, dialingSettings.countryCode);
        }

        if (dialingSettings.prefixForOutCall) {
          formattedPhoneNumber.phoneNumber = dialingSettings.prefixForOutCall + formattedPhoneNumber.phoneNumber;
        }
      }

      // se limpia el número
      formattedPhoneNumber.phoneNumber = formattedPhoneNumber.phoneNumber.replace(/\s/g,'');

      return formattedPhoneNumber;
    }

    /**
     * Identifica si una llamada es interna o externa según la expresión regular dada en la configuración del softphone.
     **
     * @author jmartinezpisson
     * @param {Object} call - Datos de llamada
     * @param {String} call.type - Tipo de llamada (OUTBOUND/INBOUND). Valor del enum thc.CALL_TYPE. Obligatorio.
     * @param {String} call.dnis - Número destino de llamada. Obligatorio.
     * @param {String} call.ani - Número origen de llamada. Obligatorio.
     * @return {Boolean} Identifica si la llamada es interna (true) o no (false).
     */
    function isInternalCall(call) {
      if (call.type === thc.CALL_TYPE.OUTBOUND) {
        return new RegExp(thc.settings.get().callcenter.dialing.internalCallRegexp).test(call.dnis || '');
      }

      return new RegExp(thc.settings.get().callcenter.dialing.internalCallRegexp).test(call.ani || '');
    }


    function stringifyAndCleanUUI(uui) {
      var uuiSettings = thc.settings.get().screenPopOptions.uui;

      return uui && uui.substring ? uui.substring(0, uui.indexOf(uuiSettings.stop) + 1) : '';
    }

    function stringifyContextSources(contextRecords) {
      var sources = contextRecords.sources || {};

      return JSON.stringify({
        opened: stringifyContextSource(sources.opened),
        origin: stringifyContextSource(sources.origin),
        contact: stringifyContextSource(sources.contact),
        uui: stringifyContextSource(sources.uui),
        transfer: stringifyContextSource(sources.transfer),
        match: stringifyContextMatches(contextRecords.matched || {})
      });
    }

    function stringifyContextSource(sourceRecords) {
      var recordSet = new Set();

      if (sourceRecords) {
        sourceRecords.forEach(function(sourceRecord) {
          recordSet.add(sourceRecord.id);
        });
      }

      return Array.from(recordSet);
    }

    function stringifyContextMatches(matchedRecords) {
      var recordSet = new Set();

      if (matchedRecords.people) {
        matchedRecords.people.forEach(function(sourceRecord) {
          recordSet.add(sourceRecord.id);
        });
      }

      if (matchedRecords.objects) {
        matchedRecords.objects.forEach(function(sourceRecord) {
          recordSet.add(sourceRecord.id);
        });
      }

      return Array.from(recordSet);
    }


    /**
     * Concatena los Id. de registros matcheados en las búsquedas por; para pasarlos en la customPop
     **
     * @author jmartinezpisson
     * @param {Object} matchedRecords - Registros matcheados
     * @param {Object} call.type - Tipo de llamada (OUTBOUND/INBOUND). Valor del enum thc.CALL_TYPE. Obligatorio.
     * @param {String} call.dnis - Número destino de llamada. Obligatorio.
     * @param {String} call.ani - Número origen de llamada. Obligatorio.
     * @return {Boolean} Identifica si la llamada es interna (true) o no (false).
     */
    function stringifyContextRecordIds(matchedRecords) {
      var recordIds = [] , records = [];

      if (!matchedRecords) {
        return '';
      }

      matchedRecords = matchedRecords || {};
      records = [].concat(matchedRecords.people || []).concat(matchedRecords.objects || []);
      recordIds = recordIds.concat( records.map(function(record) { return record.id;}) );

      return recordIds.join(';');
    }

    function stringifyContextRecordsAsUUI(records) {
      var uuiSettings = thc.settings.get().screenPopOptions.uui,
        stringifiedRecords = [];

      if (!records) {
        return '';
      }

      util.object.forEach(records, function(object, recordsById) {
        stringifiedRecords = stringifiedRecords.concat(Object.keys(recordsById));
      });

      return uuiSettings.start + uuiSettings.separator + uuiSettings.separator + uuiSettings.separator + uuiSettings.separator + uuiSettings.stop + stringifiedRecords.join('!');
    }

    /**
     * Parsea la información de UUI de una llamada, dado en el formato de la centralita, y lo devuelve como una estructura/objeto.
     * EL formato de la cadena esperado es el dado por la configuración de UUI del fichero de CallCenter.
     * La estructura devuelta organiza los datos parseados en función de dicha configruación; p. ej, si en la posición 1 se espera el campo Account.Name, en la estructura se encontrará el valor { Account: { Name; 'Parsed Value'}}
     * En caso contrario, si en la configuración no se divide por punto, se toma directamente el valor como atributo; p.ej, si en la posición 2 se espera el valor Custom, en la estructura se encontrará el valor { Custom: 'Parsed Value' }
     **
     * @author jmartinezpisson
     * @param {String} uui - Información de UUI en el formato de la centralita actual, dado como cadena de texto
     * @return {Object} - UUI como estructura de datos
     */
    function parseUUI(uui) {
      var uuiSettings = thc.settings.get().screenPopOptions.uui,
        uuiParamList = uui.substring(
          uui.indexOf(uuiSettings.start) + 1,
          uui.indexOf(uuiSettings.stop)
        ).split(uuiSettings.separator),
        parsedUui = {
          objects: {},
          custom: {},
          records: {}
        };

      if (uui) {
        parsedUui = {
          objects: parseUUIObjects(uuiParamList, uuiSettings.parsingMap.objects),
          custom: parseUUICustomFields(uuiParamList, uuiSettings.parsingMap.custom),
          records: parseUUITransferRecords(uui.substring(uui.indexOf(uuiSettings.stop) + 1))
        };
      }

      return parsedUui;
    }

    function parseUUICustomFields(uuiList, uuiCustomParsingMap) {
      var uuiCustom = {};

      util.object.forEach(uuiCustomParsingMap, function(customAttributeName, customAttributeDefinition) {
        uuiCustom[customAttributeName] = uuiList[customAttributeDefinition];
      });

      return uuiCustom;
    }

    function parseUUIObjects(uuiList, uuiObjectsParsingMap) {
      var uuiObjects = {};

      for (var objectName in uuiObjectsParsingMap) {
        if (uuiObjectsParsingMap.hasOwnProperty(objectName)) {
          uuiObjects[objectName] = uuiObjects[objectName] || {};

          for (var fieldName in uuiObjectsParsingMap[objectName]) {

            if (uuiObjectsParsingMap[objectName].hasOwnProperty(fieldName)) {
              uuiObjects[objectName][fieldName] = uuiList[uuiObjectsParsingMap[objectName][fieldName]];
            }
          }
        }
      }

      return uuiObjects;
    }

    function parseUUITransferRecords(uui) {
      return uui ? uui.split('!') : [];
    }


    function processTransferRecords(records) {
      var promises = [];

      records.forEach(function(record) {
        promises.push(thc.sforce.screenPop({
          url: '/' + record.recordId,
          force: true
        }));
      });

      return Promise.all(promises);
    }


    function setServicePresenceStatus(isBusy) {
      var presenceSettings = thc.settings.get().provider.presence;
      //var actualStateId, newStateId;

      if (presenceSettings.enabled) {
        thc.sforce.console.getServicePresenceStatusId().then(function(stateId) {
          if (stateId) {
            that.store.reduceStore(function(state) {
              state.presence = state.presence || {};
              if(!state.presence.pilaBusies){state.presence.pilaBusies = [];} //para responder correctamente ante multiples llamadas y transferencias/conferencias.
              var removed = "";
              if(isBusy === "transferred" || isBusy ==="conferenceEnded"){
                state.presence.pilaBusies = [];
                state.presence.stateId =state.presence.oldStateId || presenceSettings.availableStateId;
                state.presence.oldStateId =stateId.statusId || presenceSettings.busyStateId;//state.presence.busyStateId;
              }else{
                if(isBusy){state.presence.pilaBusies.push(true);}else{removed = state.presence.pilaBusies.pop();}
                if (state.presence.pilaBusies.length === 0 && removed) {
                  state.presence.stateId =state.presence.oldStateId || presenceSettings.availableStateId;
                  state.presence.oldStateId =stateId.statusId || presenceSettings.busyStateId;//state.presence.busyStateId;
                } else {
                  if(state.presence.pilaBusies.length === 1 && isBusy){
                    state.presence.oldStateId =stateId.statusId || state.presence.stateId ||  presenceSettings.availableStateId;
                    state.presence.stateId = presenceSettings.busyStateId;//state.presence.busyStateId;
                  }
                }
              }
              if(stateId.statusId != state.presence.stateId ){
              //si se setea el mismo estado salta error.
                thc.sforce.console.setServicePresenceStatus({
                  stateId: state.presence.stateId
                });
              }


              return state;
            });
          }
        }).catch(function(errors) {
          logger.log(logger.LOG_TYPE.ERROR, 'Error al cambiar estado de omnichannel (setServicePresenceStatus)', errors);
        });
      }
    }

   function synchronizePresenceStatus(statusTC) {
      var presenceSettings = thc.settings.get().provider.presence;
      var promesaEstado = Promise.resolve();
      thc.sforce.console.getServicePresenceStatusId().then(function(stateId) {
        if (presenceSettings.matchState) { //setting de autologin omnichannel
          if(statusTC === "LOGIN"){
            if(stateId.statusId != presenceSettings.autologinState){  //si se setea el mismo estado salta error.
              promesaEstado = thc.sforce.console.setServicePresenceStatus({
                stateId: presenceSettings.autologinState
              });
            }
          }
        }
        if (presenceSettings.enabled) { //misma setting u otra nueva?
          promesaEstado.then(function(result){

              if (stateId) {
                var nuevoEstado;
                switch(statusTC){
                  case "STARTED":
                  case "READY":
                  case "AVAILABLE":{nuevoEstado = presenceSettings.availableStateId; break;}
                  case "STOPPED":
                  case "NOTREADY":
                  case "WORKNOTREADY":{nuevoEstado = presenceSettings.busyStateId; break;}

                  //por defecto estado no tratado deja omnichannel como está
                  //E.g login, logout...
                  default:{nuevoEstado = stateId.statusId; break;}
                }
                that.store.reduceStore(function(state) {
                  state.presence = state.presence || {};
                  state.presence.oldStateId = stateId.statusId || state.presence.stateId || presenceSettings.availableStateId
                  state.presence.stateId = nuevoEstado;

                  if(stateId.statusId != state.presence.stateId ){
                  //si se setea el mismo estado salta error.
                    thc.sforce.console.setServicePresenceStatus({
                      stateId: state.presence.stateId
                    });
                  }

                  return state;
                });
              }

          });
        }
      }).catch(function(errors) {
        logger.log(logger.LOG_TYPE.ERROR, 'Error al cambiar estado de omnichannel (synchronizePresenceStatus)', errors);
      });
    }


    /**
     * Obtiene los datos de contexto asociados a una llamada
     **
     * @author jmartinezpisson, jarina
     * @param {Object} args - Argumentos del método
     * @param {Object} args.call - Datos de la llamada sobre la que realizar la búsqueda. Requerido.
     * @param {String} args.call.type - Tipo de llamada. Inbound, Outbound, Internal
     * @param {Object} args.call.log - Log asociado a la transacción (Tarea)
     * @param {Object} args.transaction - Datos de la transacción de datos en curso. Requerido.
     * @param {Object} args.transaction.context - Datos de contexto existentes en la llamada.
     * @param {Object} args.transaction.context.uui - Datos de uui de la llamada, parseados y procesados.
     * @param {String[]} args.transaction.context.uui.records - Registros enviados en una transferencia
     * @param {Object} args.transaction.context.uui.objects - Datos de uui parseados.
     * @param {Object} args.transaction.contact - Datos del contacto asociado a la transacción. Existente en Presence/Altitude
     * @return {Promise} - Promesa resuelta con los datos de contexto y log actualizados.
     */
    function getCallContext(args) {
      var call = args.call || {},
        transaction = args.transaction || {},
        uui = transaction.context && transaction.context.uui ? transaction.context.uui : {},
        callContext = {
          context: {
            records: transaction.context && transaction.context.records ? transaction.context.records : {},
            matched: {
              people: [],
              objects: []
            },
            sources: {}
          },
          log: {
            whatId: null,
            whoId: null
          }
        };

      return new Promise(function(resolve, reject) {
        // 1 - Se lanza el searchAndScreenPop - Este ejecuta todas las búsquedas en Salesforce a partir de los datos propocionados en la llamada
        that.util.call.searchAndScreenPop({
          call: {
            dnis: call.dnis,
            ani: call.ani,
            type: call.type,
            isInternal: call.isInternal,
            isServiceCall: call.isServiceCall
          },
          uui: {
            records: uui.records,
            objects: uui.objects
          },
          contact: transaction.contact,
          transferAttributes: transaction.transferAttributes || {}
        }).then(function(searchResults) {
          var matchedRecordObject, matchedRecord;

          callContext.context.records = Object.assign(callContext.context.records, searchResults.records);
          callContext.context.matched = {
            people: searchResults.people,
            objects: searchResults.objects
          };
          callContext.context.sources = Object.assign(callContext.context.sources, searchResults.sources);

          // WhatId
          if(searchResults.objects.length) {
            matchedRecordObject = callContext.context.records[searchResults.objects[0].object] || {};
            matchedRecord = matchedRecordObject[searchResults.objects[0].id] || {};

            if(matchedRecord.IsPersonAccount && matchedRecord.PersonContactId) {
                callContext.log.whoId = matchedRecord.PersonContactId;
            } else {
              callContext.log.whatId = searchResults.objects[0].id;
            }
          }

          callContext.log.whoId = searchResults.people.length && !callContext.log.whoId? searchResults.people[0].id : callContext.log.whoId;

          if(callContext.ui && callContext.ui.tabId) {
            return {
              tabId: callContext.ui.tabId
            };
          }

          return thc.sforce.util.getAppContext();
        }).then(function(context) {
          var urlSettings = thc.settings.get().urlConfiguration;

          callContext.context.ui = {
            tabId: context.tabId || null,
            subTabId: context.subTabId || null
          };

          return that.util.call.customPop({
            call: call,
            contact: transaction.contact,
            context: callContext.context,
            log: call.log
          }, urlSettings.callStarted, urlSettings.openAsSubtab);
        }).then(function() {
          resolve(callContext);
        }).catch(function(err) {
          logger.log(logger.LOG_TYPE.ERROR, 'Error al recuperar el contexto de la llamada (getCallContext)', err);
          reject(err);
        });
      });
    }

    /**
     * Realiza las búsquedas del contexto de la llamada a partir de la informarción de transferencia, contacto de centralita, uui o número de teléfono, en función del contexto disponible.
     * Posteriormente, realiza el screenPop de los resultados obtenidos. La búsqueda prioriza los resultados en función de información de transferencia => Contacto => IVR de uui => Número de teléfono
     * Incluye la recuperación de los registros iniciales de la llamda
     **
     * @author jmartinezpisson
     * @param {Object} args - Argumentos para la realización de las búsquedas
     * @param {Object} args.call - Datos de llamada para la realización del searchAndScreenPop básico
     * @param {String} args.call.ani - Número origen de la llamada
     * @param {String} args.call.dnis - Número destino de la llamada
     * @param {String} args.call.type - Tipo de llamada (INBOUND/OUTBOUND)
     * @param {Boolean} args.call.isInternal - Identifica si la llamada es interna
     * @param {Boolean} args.call.isServiceCall - Identifica si la llamada es de servicio
     * @param {Object} args.uui - Datos procesados de uui de la llamada para la realización del searchAndScreenPop en transferencias, IVR y otros datos del UUI
     * @param {String[]} args.uui.records - Lista de ids. de registro a buscar obtenidos del UUI de una transferencia
     * @param {Object} args.uui.objects - Datos de búsqueda obtenidos a partir del IVR
     * @param {Object} args.contact - Datas del contacto de la llamada/transacción para la realización de la búsqueda por contacto. Estructura no definida
     * @param {Object} args.transferAttributes - Información de IVR proveniente de la centralita
     * @return {Object} Contexto de la llamada
     */
    function callSearchAndScreenPop(args) {
      var context = {},
        call = args.call || {},
        uui = args.uui || {},
        contact = args.contact || {},
        transferAttributes = args.transferAttributes || {},
        callSearchLayoutType = call.isInternal ? 'internal' : call.type.toLowerCase();

      return new Promise(function(resolve, reject) {
        Promise.all([
          queryRelatedRecordsById({
            records: uui.records,
            searchLayout: callSearchLayoutType
          }),
          queryDataRecords({
            data: contact,
            dataName: 'Contact',
            pointless: true,
            searchLayout: callSearchLayoutType
          }),
          queryRelatedRecords({
            objects: uui.objects,
            searchLayout: callSearchLayoutType
          }),
          thc.sforce.util.getAppContext(),
          queryDataRecords({
            data: transferAttributes,
            dataName: 'Transfer',
            searchLayout: callSearchLayoutType
          })
        ]).then(function(searchResults) {
          var records = {},
            matchedPeopleRecords = [],
            matchedRelatedToRecords = [],
            transferRecords = [],
            uuiRecords = [],
            originRecords = [],
            contactRecords = [],
            contactMapping = thc.settings.get().contactMapping,
            isPeopleMatch = false,
            isRelatedToMatch = false,
            dataSearches = {
              contact: searchResults[1],
              transfer: searchResults[4]
            },
            allDataSearches = {},
            sObjectName, screenPopRecord, recordId;

          // 0 - Juntamos todos los datos de las búsquedas de datos
          util.object.forEach(dataSearches, function(source, results) {
            allDataSearches = Object.assign(allDataSearches, results);
          });

          // 1 - Merge con los resultados de los datos de transferencia
          // Si existen datos, se detiene el procesamiento de búsqueda.
          util.object.forEach(searchResults[0], function(sObjectName, sObjectSearchResults) {
            util.object.forEach(sObjectSearchResults, function(searchResultId, searchResult) {
              var record = {
                object: sObjectName,
                id: searchResultId
              };

              if (sObjectName === 'Contact' || sObjectName === 'Lead') {
                matchedPeopleRecords.push(record);
              } else {
                matchedRelatedToRecords.push(record);
              }

              transferRecords.push(record);
              records[sObjectName] = records[sObjectName] || {};
              records[sObjectName][searchResultId] = Object.assign(records[sObjectName][searchResultId] || {}, searchResult);
            });
          });

          isPeopleMatch = matchedPeopleRecords.length !== 0;
          isRelatedToMatch = matchedRelatedToRecords.length !== 0;

          // 2 - Merge con los resultados de la Query con los datos de contacto
          // Se debe priorizar como match en función de los objetos configurados
          var lookFor = (function(sObjectsToSearch, searchResults) {
            var index = 0,
              lookFor = null;

            while (!lookFor && index < sObjectsToSearch.length) {
              if (Object.keys(searchResults[sObjectsToSearch[index]]).length > 0) {
                lookFor = sObjectsToSearch[index];
              }
              index = index + 1;
            }

            return lookFor;
          })(Object.keys(contactMapping), allDataSearches);

          // 2.1 - Buscamos en la parte de contacto primero
          util.object.forEach(dataSearches.contact, function(sObjectName, sObjectSearchResults) {
            util.object.forEach(sObjectSearchResults, function(searchResultId, searchResult) {
              var record = {
                object: sObjectName,
                id: searchResultId
              };

              if (!lookFor || lookFor === sObjectName) {
                if (!isPeopleMatch && (sObjectName === 'Contact' || sObjectName === 'Lead')) {
                  matchedPeopleRecords.push(record);
                  contactRecords.push(record);
                } else if (!isRelatedToMatch) {
                  matchedRelatedToRecords.push(record);
                  contactRecords.push(record);
                }
              }

              records[sObjectName] = records[sObjectName] || {};
              records[sObjectName][searchResultId] = Object.assign(records[sObjectName][searchResultId] || {}, searchResult)
            });
          });

          isPeopleMatch = matchedPeopleRecords.length !== 0;
          isRelatedToMatch = matchedRelatedToRecords.length !== 0;

          // 2.2 - Buscamos en la parte de transfer de datos
          util.object.forEach(dataSearches.transfer, function(sObjectName, sObjectSearchResults) {
            util.object.forEach(sObjectSearchResults, function(searchResultId, searchResult) {
              var record = {
                object: sObjectName,
                id: searchResultId
              };

              if (!lookFor || lookFor === sObjectName) {
                if (!isPeopleMatch && (sObjectName === 'Contact' || sObjectName === 'Lead')) {
                  matchedPeopleRecords.push(record);
                  transferRecords.push(record);
                } else if (!isRelatedToMatch) {
                  matchedRelatedToRecords.push(record);
                  transferRecords.push(record);
                }
              }

              records[sObjectName] = records[sObjectName] || {};
              records[sObjectName][searchResultId] = Object.assign(records[sObjectName][searchResultId] || {}, searchResult)
            });
          });

          isPeopleMatch = matchedPeopleRecords.length !== 0;
          isRelatedToMatch = matchedRelatedToRecords.length !== 0;


          // 3 - Merge con los resultados de la Query con los datos de IVR
          util.object.forEach(searchResults[2], function(sObjectName, sObjectSearchResults) {
            util.object.forEach(sObjectSearchResults, function(searchResultId, searchResult) {
              var record = {
                object: sObjectName,
                id: searchResultId
              };

              if (!isPeopleMatch && (sObjectName === 'Contact' || sObjectName === 'Lead')) {
                matchedPeopleRecords.push(record);
              } else if (!isRelatedToMatch) {
                matchedRelatedToRecords.push(record);
              }

              uuiRecords.push(record);
              records[sObjectName] = records[sObjectName] || {};
              records[sObjectName][searchResultId] = Object.assign(records[sObjectName][searchResultId] || {}, searchResult);
            });
          });

          isPeopleMatch = matchedPeopleRecords.length !== 0;
          isRelatedToMatch = matchedRelatedToRecords.length !== 0;


          // 4 - Inclusión de registros iniciales de la transferencia
          searchResults[3].records.forEach(function(record) {
            var originRecord = {
              object: record.objectType,
              id: record.recordId
            };

            if (record.objectType && record.recordId) {
              originRecords.push(originRecord);

              records[record.objectType] = records[record.objectType] || {};
              records[record.objectType][record.recordId] = Object.assign(records[record.objectType][record.recordId] || {}, record);
            }
          });

          // Si se han encontrado matches, se realiza el screenPop del registro principal y resolvemos la promesa
          if (isPeopleMatch || isRelatedToMatch) {
            if (isRelatedToMatch) {
              if (matchedRelatedToRecords.length === 1) {
                return thc.sforce.util.screenPopRecord({
                  recordId: matchedRelatedToRecords[0].id
                }).then(function(result) {
                  return resolve({
                    records: records,
                    people: matchedPeopleRecords,
                    objects: matchedRelatedToRecords,
                    sources: {
                      uui: uuiRecords,
                      transfer: transferRecords,
                      contact: contactRecords,
                      origin: originRecords
                    },
                    ui: {
                      tabId: result.tabId || null
                    }
                  });
                }).catch(function() {
                  return resolve({
                    records: records,
                    people: matchedPeopleRecords,
                    objects: matchedRelatedToRecords,
                    sources: {
                      uui: uuiRecords,
                      transfer: transferRecords,
                      contact: contactRecords,
                      origin: originRecords
                    },
                    ui: {
                      tabId: null
                    }
                  });
                });
              }
            } else if (isPeopleMatch) {
              if (matchedPeopleRecords.length === 1) {
                return thc.sforce.util.screenPopRecord({
                  recordId: matchedPeopleRecords[0].id
                }).then(function(result) {
                  return resolve({
                    records: records,
                    people: matchedPeopleRecords,
                    objects: matchedRelatedToRecords,
                    sources: {
                      uui: uuiRecords,
                      transfer: transferRecords,
                      contact: contactRecords,
                      origin: originRecords
                    },
                    ui: {
                      tabId: result.tabId || null
                    }
                  });
                }).catch(function() {
                  return resolve({
                    records: records,
                    people: matchedPeopleRecords,
                    objects: matchedRelatedToRecords,
                    sources: {
                      uui: uuiRecords,
                      transfer: transferRecords,
                      contact: contactRecords,
                      origin: originRecords
                    },
                    ui: {
                      tabId: null
                    }
                  });
                });
              }
            }

            return resolve({
              records: records,
              people: matchedPeopleRecords,
              objects: matchedRelatedToRecords,
              sources: {
                uui: uuiRecords,
                transfer: transferRecords,
                contact: contactRecords,
                origin: originRecords
              },
              ui: {
                tabId: null
              }
            });
          }

          return searchAndScreenPop(call).then(function(searchResults) {
            var records = {},
              matchedPeopleRecords = [],
              matchedRelatedToRecords = [];

            util.object.forEach(searchResults, function(recordId, screenPopRecord) {
              var sObjectName = screenPopRecord.object || screenPopRecord.RecordType;

              if (sObjectName === 'Contact' || sObjectName === 'Lead') {
                matchedPeopleRecords.push({
                  object: sObjectName,
                  id: recordId
                });
              } else {
                matchedRelatedToRecords.push({
                  object: sObjectName,
                  id: recordId
                });
              }

              records[sObjectName] = records[sObjectName] || {};
              records[sObjectName][recordId] = Object.assign(records[sObjectName][recordId] || {}, screenPopRecord);
            });

            return resolve({
              records: records,
              people: matchedPeopleRecords,
              objects: matchedRelatedToRecords,
              sources: {
                uui: uuiRecords,
                transfer: transferRecords,
                contact: contactRecords,
                origin: originRecords
              }
            });
          });
        });
      }).then(function(returnValue) {
        return thc.sforce.deferUntilScreenPop(returnValue);
      });
    }


    /**
     * Realiza una query sobre Salesforce para obtener los registros asociados a un listado de IDs provenientes de una transferencia
     **
     * @author jmartinezpisson
     * @param {Object} args - Argumentos de la llamada
     * @param {String[]} args.records - Lista de Ids. de Salesforce transferidos
     * @param {String} args.searchLayout - Layout de búsqueda de llamada a utilizar (inbound, outbound, internal) en la búsqueda. inbound por defecto.
     * @return {Object} Registros ordenados por tipo de sObject e Id. de Salesforce
     */
    function queryRelatedRecordsById(args) {
      var softphoneLayout = thc.settings.get().layout,
        searchLayout = args.searchLayout ? args.searchLayout.toLowerCase() : 'inbound',
        fieldsToQueryBySObjectName = softphoneLayout[searchLayout],
        recordIds = args.records ? args.records : [];

      // 1 - Si existe informacion en el uui relativa a una transferencia
      if (recordIds.length) {
        // 2- Se realiza la query y se procesan los datos
        return thc.sforce.controller.querySoftphoneRecordsById(recordIds, fieldsToQueryBySObjectName).catch(function() { return {}; }).then(function(records) {
          return formatQueryResult(records);
        });
      }

      // 3- En caso contrario se devuelve un objeto vacío
      return Promise.resolve({});
    }

    /**
     * Realiza una query sobre Salesforce para obtener la información asociada a datos de la centralita
     **
     * @author jmartinezpisson
     * @changes amartinez - Generalizada la función para soportar distintos tipos de búsquedas
     * @param {Object} args - Argumentos de la llamada
     * @param {Object} args.data - Objeto que representa las propiedades clave:valor usadas para realizar la búsqueda (name: 'Tim Barr')
     * @param {String} args.searchLayout - Layout de búsqueda de llamada a utilizar (inbound, outbound, internal) en la búsqueda. inbound por defecto.
     * @param {String} args.dataName - Indica con que campos de la sección datos del callcenter se va a mapear ('Contact', 'Transfer')
     * @param {Boolean} args.pointless - Indica si también se buscan los campos sin formato 'Objeto.Campo' con ese mismo nombre ('FirstName' = 'dataName.FirstNam')
     * @return {Object} Registros ordenados por tipo de sObject e Id. de Salesforce
     */
    function queryDataRecords(args) {
      var softphoneLayout = thc.settings.get().layout,
        contactMapping = thc.settings.get().contactMapping,
        searchLayout = args.searchLayout ? args.searchLayout.toLowerCase() : 'inbound',
        fieldsToQueryBySObjectName = softphoneLayout[searchLayout],
        data = args.data,
        dataName = args.dataName,
        whereClausesBySObjectName = {},
        transferAttributes = args.transferAttributes || {};

      // 1 - Si la llamada contiene información de contacto, se realiza una query
      if (contactMapping && args.data) {
        util.object.forEach(contactMapping, function(sfObjectName, contactFieldsBySObjectField) {
          whereClausesBySObjectName[sfObjectName] = {};

          util.object.forEach(contactFieldsBySObjectField, function(sObjectField, dataField) {
            if (args.pointless && !dataField.includes('.')) {
              whereClausesBySObjectName[sfObjectName][sObjectField] = data[dataField];
            } else if (dataField.includes('.') && dataField.split('.')[0] === dataName && data[dataField.split('.')[1]]) {
              whereClausesBySObjectName[sfObjectName][sObjectField] = data[dataField.split('.')[1]];
            }
          });
        });

        // 2- Se realiza la query y se procesan los datos - Se debe priorizar el primer objeto
        return queryRecords(fieldsToQueryBySObjectName, whereClausesBySObjectName).catch(function() { return {}; }).then(function(records) {
          return formatQueryResult(records);
        });
      }

      // 3- En caso contrario se devuelve un objeto vacío
      return Promise.resolve({});
    }

    /**
     * Realiza una query sobre Salesforce para obtener los registros asociados a la información de IVR proveniente de la centralita
     **
     * @author jmartinezpisson
     * @param {Object} args - Argumentos de la llamada
     * @param {Object} args.objects - Filtros a aplicar en la búsqueda, definido como un mapa de valores ordenados por sObject y campo ontenido del UUI de la llamadaa
     * @param {String} args.searchLayout - Layout de búsqueda de llamada a utilizar (inbound, outbound, internal) en la búsqueda. inbound por defecto.
     * @return {Object} Registros ordenados por tipo de sObject e Id. de Salesforce
     */
    function queryRelatedRecords(args) {
      var softphoneLayout = thc.settings.get().layout,
        searchLayout = args.searchLayout ? args.searchLayout.toLowerCase() : 'inbound',
        objects = args.objects,
        fieldsToQueryBySObjectName = {},
        whereClausesBySObjectName = null;

      // 1 - A partir de la info de UUI, se realizará una query para obtener objetos asociados
      if (objects) {
        whereClausesBySObjectName = Object.assign({}, objects);

        for (var sObjectName in whereClausesBySObjectName) {
          fieldsToQueryBySObjectName[sObjectName] = searchLayout[sObjectName] ? searchLayout[sObjectName] : [];
        }

        // 2- Se realiza la query y se procesan los datos
        return queryRecords(fieldsToQueryBySObjectName, whereClausesBySObjectName).catch(function() { return {}; }).then(function(records) {
          return formatQueryResult(records);
        });
      }

      // 3- En caso contrario se devuelve un objeto vacío
      return Promise.resolve({});
    }

    /**
     * Paraleliza una query sobre diversos objetos, realizando una query individual por cada uno de ellos.
     **
     * @author jmartinezpisson
     * @param {Object} args - Argumentos de la llamada
     * @param {Object} args.fieldsToQueryBySObjectName - Campos a buscar ordenados por nombre de objeto
     * @param {String} args.whereClausesBySObjectName - Condiciones OR a aplicar ordenadas por nombre de objeto
     * @return {Object} Registros ordenados por tipo de sObject e Id. de Salesforce
     */
    function queryRecords(fieldsToQueryBySObjectName, whereClausesBySObjectName) {
      var queryPromises = [];

      Object.keys(whereClausesBySObjectName).forEach(function(sObjectName) {
        var fieldsToQuery = {},
            whereClauses = {};

        fieldsToQuery[sObjectName] = fieldsToQueryBySObjectName[sObjectName];
        whereClauses[sObjectName] = whereClausesBySObjectName[sObjectName];
        queryPromises.push(thc.sforce.controller.querySoftphoneRecords(fieldsToQuery, whereClauses));
      });

      return Promise.all(queryPromises).then(function(queryResults) {
        var globalQueryResult = {};

        queryResults.forEach(function(queryResult) {
          Object.assign(globalQueryResult, queryResult);
        });

        return globalQueryResult;
      });
    }

    function formatQueryResult(records) {
      util.object.forEach(records, function(sObjectName, sObjectRecords) {
        util.object.forEach(sObjectRecords, function(recordId, record) {
          // 1 - Si la cuenta es personal, tendrá el campo PersonContactId relleno, y ha de introducirse como Contacto
          /*if (record.hasOwnProperty('PersonContactId')) {
            record.AccountId = record.Id;
            record.Id = record.PersonContactId;
            record.object = 'Contact';
            record.displayName = $Label.sObjectType.Contact ? $Label.sObjectType.Contact.label : 'Contact';

            records.Contact = records.Contact || {};
            records.Contact[record.Id] = record;

            delete records[sObjectName][recordId];
            // 2 - En caso contrario, se asignan los datos de label de objeto y nombre de objeto
          } else {
            record.object = sObjectName;
            record.displayName = $Label.sObjectType[sObjectName] ? $Label.sObjectType[sObjectName].label : sObjectName;
          }*/
          record.object = sObjectName;
          record.RecordType = sObjectName;
          record.displayName = $Label.sObjectType[sObjectName] ? $Label.sObjectType[sObjectName].label : sObjectName;
        });

      });

      return records;
    }

    /**
     * Realiza una query sobre Salesforce mediante el estándar searchAndScrenPop a partir del número de teléfono de la llamada
     **
     * @author jmartinezpisson
     * @return {Object} - Estructura de datos representando la llamada
     */
    function searchAndScreenPop(call) {
      var search = call.type === thc.CALL_TYPE.OUTBOUND ? call.dnis : call.ani;
      var callType;

      if (call.isInternal) {
        callType = sforce.opencti.CALL_TYPE.INTERNAL;
      } else if (call.type === thc.CALL_TYPE.OUTBOUND && !call.isServiceCall) {
        callType = sforce.opencti.CALL_TYPE.OUTBOUND;
      } else {
        callType = sforce.opencti.CALL_TYPE.INBOUND;
      }

      return thc.sforce.searchAndScreenPop({
        searchParams: search,
        queryParams: getScreenPopParamsFromCall(call),
        callType: callType,
        deferred: false
      }).catch(function(error) {
        logger.log(logger.LOG_TYPE.ERROR, 'Se ha llamado al searchAndScreenPop con los parámetros vacíos');

        return {};
      });
    }

    function getScreenPopParamsFromCall(call) {
      var params = [
        'calleddevice=' + call.dnis || '',
        'callingdevice=' + call.ani || '',
        'cid=' + call.cId || '',
        'calltype=' + call.type.toLowerCase(),
        'uui=' + (call.userInfo ? call.userInfo.uui : ''),
        'extraParam=' + call.ani || ''

      ];

      return scope.encodeURIComponent(params.join('&'));
    }

    /**
     * Realiza, si es necesario, el CustomPop de una llamada.
     **
     * @author jmartinezpisson
     * @param {Object} data - Llamada sobre la que realizar el Custom Pop
     * @param {Object} data.call - Datos de la llamada.
     * @param {Object} data.contact - Datos de la llamada.
     * @param {Object} data.log - Datos de la llamada.
     * @param {Object} data.context - Contexto de la llamada.
     * @param {Object} data.context.ui - Datos Contexto de la interfaz asociado a la llamada.
     * @param {String} data.context.ui.tabId - Id. de la pestaña principal asociada a la llamada.
     * @param {String} customURL - URL a abrir con los datos de la llamada
     * @param {Boolean} openAsSubtab - Abrir la URL como subpestaña de la pestaña asociada a la llamada. Solo en consola Salesforce Classic.
     * @return {Promise} Promesa resuelta sin valor cuando el custom pop se ha realizado. No garantiza que la pestaña/subpestña se haya abierto en el momento que se resuelve.
     */
    function popCustomURL(data, customURL, openAsSubtab) {
      var tabId = data.context && data.context.ui ? data.context.ui.tabId : null;

      if (customURL && shouldPopCustomURL(data.call)) {
        if (!openAsSubtab) {
          return thc.sforce.util.popURL({
            url: formatCustomPopURL({
              url: customURL,
              data: {
                call: data.call,
                contact: data.contact,
                log: data.log,
                context: data.context
              }
            }),
            active: true
          });
        } else {
          return thc.sforce.util.popURL({
            url: formatCustomPopURL({
              url: customURL,
              data: {
                call: data.call,
                contact: data.contact,
                log: data.log,
                context: data.context
              },
              tabId: tabId
            }),
            active: true,
            tabId: tabId
          });
        }
      }

      return Promise.resolve();
    }


    /**
     * Dada la configuración del softphone, comprueba si una llamada debe realizar el CustomPop
     **
     * @author jmartinezpisson
     * @param {Object} call - Datos de llamada
     * @param {String} call.type - Tipo de llamada (OUTBOUND/INBOUND). Valor del enum thc.CALL_TYPE. Obligatorio.
     * @param {Boolean} call.isInternal - - Identifica si se trata de una llamada interna.
     * @param {Boolean} call.isServiceCall - Identifica si se trata de una llamada fantasma de servicio/campaña.
     * @return {Boolean} Identifica si el CustomPop debe realizarse (true) o no (false).
     */
    function shouldPopCustomURL(call) {
      var settings = thc.settings.get();

      if (call.isInternal) {
        return settings.urlConfiguration.openOnInternalCall;
      } else if (call.type === thc.CALL_TYPE.OUTBOUND && !call.isServiceCall) {
        return settings.urlConfiguration.openOnOutboundCall;
      } else {
        return settings.urlConfiguration.openOnInboundCall;
      }
    }

    function formatCustomPopURL(args) {
      var formattedURL = args.url || '',
        tabId = args.tabId || '',
        data = args.data || {},
        call = data.call || {},
        contact = data.contact || {},
        log = data.log || {},
        context = data.context || {};

      // 1 - Propiedades generales
      formattedURL = formattedURL.replace('{\!ani}', call.ani || '');
      formattedURL = formattedURL.replace('{\!dnis}', call.dnis || '');
      formattedURL = formattedURL.replace('{\!cid}', call.cId || '');
      formattedURL = formattedURL.replace('{\!taskid}', log.taskId || '');
      formattedURL = formattedURL.replace('{\!calltype}', (call.isInternal ? 'Internal' : call.type) || '');

      formattedURL = formattedURL.replace('{\!contextid}', call.callContext || ''); // TODO: Incluir CallContext
      formattedURL = formattedURL.replace('{\!campaignid}', call.campaignId || '');
      formattedURL = formattedURL.replace('{\!tabid}', tabId || '');

      // 2- Propiedades de contacto
      for (var prop in contact) {
        formattedURL = formattedURL.replace("{\!contact." + prop + "}", contact[prop]);
      }

      formattedURL = formattedURL.replace(/{\!contact\..+?}/g, "");

      // 3 - Record Ids
      formattedURL = formattedURL.replace('{\!recordid}', stringifyContextRecordIds(context.matched));

      // 4 - UUI
      formattedURL = formattedURL.replace('{\!uui}', call.userInfo && call.userInfo.uui ? stringifyAndCleanUUI(call.userInfo.uui) : '');

      // 5 - ContextRecords By Source
      formattedURL = formattedURL.replace('{\!sources}', stringifyContextSources(context));

      // 6 - VDN
      formattedURL = formattedURL.replace('{\!vdn}', call.vdn || '');

      // 7 - timeStamp
      formattedURL += '&TimeStamp=' + new Date().toJSON().replace(' ', '');


      return formattedURL;
    }

    /**
     * Util methods for Tasks
     **/

    /**
     * Crea/actualiza una tarea asociada al CallLog de una llamada mediante el método SaveLog de la OpenCTI
     **
     * @author jmartinezpisson
     * @param {Object} call - Estructura de datos representando una llamada
     * @return {Promise} - Promesa cuyo resultado es el Call Log actualizado con el Id. de Salesforce
     */
    function initCallLog(call) {
      var log = call && call.log? call.log:{},
        callLog = {
          taskId: log.taskId || null,
          subject: log.subject || '',
          disposition: log.disposition || ''
        },
        taskSettings = thc.settings.get().task;

      // 1 - Se lanza el interactionLog si está habilitado
      initInteractionLog(call);

      // 2 - Si la tarea no se ha inicializado, y el CallLog se muestra, se guarda la tarea. Si no, se genera pero no se guarda en SF
      if (!call.log || !call.log.taskId) {
        return saveTask(call, !taskSettings.showCallLog);
      }

      // 3 - Se pasan los datos de la tarea creada - taskId seguirá siendo null si la tarea no se ha configurado
      return Promise.resolve(callLog);
    }

    /**
     * Inicializa el Interaction Log de la consola
     **
     * @author jmartinezpisson
     * @param {Object} call - Estructura de datos representando una llamada
     * @return {Promise} - Promesa cuyo resultado es true.
     */
    function initInteractionLog(call) {
      var taskSettings = thc.settings.get().task,
        isInteractionLogEnabled = taskSettings.isInteractionLogEnabled,
        timestamp = new Date().toString(),
        taskSubject = taskSettings.appendTimeStampToSubject ? taskSettings.subject + '-' + timestamp.substring(0, timestamp.lastIndexOf(':') + 3) : taskSettings.subject;

      if (isInteractionLogEnabled) {
        return thc.sforce.util.initCallOnInteractionLog({
          callObjectId: call.cId,
          callType: call.type,
          callLabel: taskSubject
        }).then(function() {
          return taskSubject;
        });
      }

      return Promise.resolve(taskSubject);
    }

    /**
     * Finaliza/actualiza una tarea asociada al CallLog de una llamada mediante el método SaveLog de la OpenCTI
     **
     * @author jmartinezpisson
     * @param {Object} call - Estructura de datos representando una llamada
     * @return {Promise} - Promesa cuyo resultado es el Call Log actualizado con el Id. de Salesforce
     */
    function endCallLog(call) {
      var taskSettings = thc.settings.get().task;

      call = call || that.util.call.getCurrent();

      // 2 - Si la tarea no tiene una taskId, se devuelve null
      if (taskSettings.showCallLog && (!call.log || !call.log.taskId)) {
        return Promise.resolve(null);
      }

      // 3 - Se actualiza la tarea con los cambios
      return saveTask(call);
    }

    /**
     * Finaliza el Interaction Log de la consola
     **
     * @author jmartinezpisson
     * @param {Object} call - Estructura de datos representando una llamada
     * @return {Promise} - Promesa cuyo resultado es true.
     */
    function endInteractionLog(call) {
      var taskSettings = thc.settings.get().task,
        isInteractionLogEnabled = taskSettings.isInteractionLogEnabled;

      if (isInteractionLogEnabled) {
        return thc.sforce.util.endCallOnInteractionLog({
          callObjectId: call.cId,
          callDuration: call.callTime,
          callLabel: call.log ? call.log.disposition : ''
        }).then(function() {
          return true;
        });
      }

      return Promise.resolve(true);
    }

    function saveTask(call, skipSave) {
      var taskSettings = thc.settings.get().task,
        callLog = call.log || {},
        timestamp = new Date().toString(),
        taskSubject = taskSettings.appendTimeStampToSubject ? taskSettings.subject + '-' + timestamp.substring(0, timestamp.lastIndexOf(':') + 3) : taskSettings.subject,
        taskDisposition = call.status === 'TRANSFERRED' ? taskSettings.transferResult : callLog.disposition || taskSettings.defaultResult,
        customAttributes = {};

      if ((call.isInternal && taskSettings.createInternalTask) ||
        (!call.isInternal && taskSettings.createTask)
      ) {

        if (taskSettings.verintRecordingIdField) {
          customAttributes[taskSettings.verintRecordingIdField] = call.verintId || '';
        }

        if(skipSave) {
          return Promise.resolve({
            taskId: null,
            disposition: taskDisposition,
            subject: taskSubject
          });
        }

        return thc.sforce.controller.saveCallTask({
          cId: call.cId,
          ani: call.ani,
          dnis: call.dnis,
          type: call.isInternal ? 'Internal' : (call.type === thc.CALL_TYPE.OUTBOUND ? thc.CALL_TYPE.OUTBOUND : 'Inbound'),
          taskRecordId: callLog.taskId,
          subject: taskSubject,
          taskType: taskSettings.type,
          taskDate: new Date().toUTCString(),
          description: callLog.description || '',
          duration: call.callTime,
          disposition: taskDisposition,
          recordTypeId: taskSettings.recordTypeId || null,
          taskCloseStatus: taskSettings.closeStatus,
          whoId: callLog.whoId || null,
          whatId: callLog.whatId || null,
          uui: call.userInfo ? (call.userInfo.uui || '') : '',
          ucid: call.uCId,
          ucidURL: call.uCIdURL || '',
          customAttributes: customAttributes
        }).then(function(taskId) {
          return {
            taskId: taskId,
            disposition: taskDisposition,
            subject: taskSubject
          };
        })
      }

      return Promise.resolve(null);
    }

    function createRecord(sObjectType, call) {
      var createRecordSettings = thc.settings.get().createRecord[sObjectType],
          numberPrefixDelimiter = thc.settings.get().phoneFormat.numberPrefixDelimiter || '',
        defaultFieldValues = {},
        url = '',
        urlParams = [];

      if (createRecordSettings) {
        url = createRecordSettings.url;

        if (createRecordSettings.phoneClassicFieldId) {
          urlParams.push(createRecordSettings.phoneClassicFieldId + '=' + numberPrefixDelimiter + (call.type === thc.CALL_TYPE.INBOUND ? call.ani : call.dnis));
        }

        createRecordSettings.uui.forEach(function(uuiParam) {

        });

        if (urlParams.length) {
          url += '?' + scope.encodeURIComponent(urlParams.join('&'));
        }

        thc.sforce.util.screenPopCreateRecord({
          url: url,
          defaultFieldValues: defaultFieldValues,
          sObjectType: sObjectType
        });
      }
    }

    /**
     * Timer para la gestión del tiempo de llamada. Listener del timer universal del controlador.
     **
     * @author jmartinezpisson, jarina
     */
    that.addTickListener('callTimer', function() {
      var triggerCallChange = false,
        actualTime = new Date(),
        phone = that.store.getState().phone;

      for (var cId in phone.calls) {
        if (phone.calls.hasOwnProperty(cId)) {
          switch (phone.calls[cId].status) {
            case 'ESTABLISHED':
              phone.calls[cId].lastUpdated = new Date(phone.calls[cId].lastUpdated) || new Date();
              if ((actualTime.getTime() - phone.calls[cId].lastUpdated.getTime()) / 1000 > 1) {
                phone.calls[cId].callTime++;
                phone.calls[cId].lastUpdated = new Date();
                triggerCallChange = true;
              }
              break;
            case 'HELD':
              phone.calls[cId].lastUpdated = new Date(phone.calls[cId].lastUpdated) || new Date();
              if ((actualTime.getTime() - phone.calls[cId].lastUpdated.getTime()) / 1000 > 1) {
                phone.calls[cId].holdTime++;
                phone.calls[cId].lastUpdated = new Date();
                triggerCallChange = true;
              }
              break;
          }
          if (phone.calls[cId].hasOwnProperty('extendedLine')) {//AÑADIDO
            switch (phone.calls[cId].extendedLine.status) {
              case 'ESTABLISHED':
                phone.calls[cId].extendedLine.lastUpdated = new Date(phone.calls[cId].extendedLine.lastUpdated) || new Date();
                if ((actualTime.getTime() - phone.calls[cId].extendedLine.lastUpdated.getTime()) / 1000 > 1) {
                  phone.calls[cId].extendedLine.callTime++;
                  phone.calls[cId].extendedLine.lastUpdated = new Date();
                  triggerCallChange = true;
                }
                break;
              case 'HELD':
                phone.calls[cId].extendedLine.lastUpdated = new Date(phone.calls[cId].extendedLine.lastUpdated) || new Date();
                if ((actualTime.getTime() - phone.calls[cId].extendedLine.lastUpdated.getTime()) / 1000 > 1) {
                  phone.calls[cId].extendedLine.holdTime++;
                  phone.calls[cId].extendedLine.lastUpdated = new Date();
                  triggerCallChange = true;
                }
                break;
            }
          }
        }
      }

      if (triggerCallChange) {
        that.store.reduceStore(function(state) {
          util.object.forEach(state.phone.calls, function(cId, call) {
            if (phone.calls[cId]) {
              state.phone.calls[cId].lastUpdated = phone.calls[cId].lastUpdated || new Date();
              state.phone.calls[cId].callTime = phone.calls[cId].callTime || 0;
              state.phone.calls[cId].holdTime = phone.calls[cId].holdTime || 0;
              if (phone.calls[cId].extendedLine) {
                state.phone.calls[cId].extendedLine.lastUpdated = phone.calls[cId].extendedLine.lastUpdated || new Date();
                state.phone.calls[cId].extendedLine.callTime = phone.calls[cId].extendedLine.callTime || 0;
                state.phone.calls[cId].extendedLine.holdTime = phone.calls[cId].extendedLine.holdTime || 0;
              }
            }
          });

          return state;
        });
      }
    });

    /**
     * Formatea un arbol con distintos atributos a formato mapa en un objeto javascript
     **
     * @author amartinez
     */
    function formatTreeAsMap(tree, nameLabel, codeLabel) {
      if (Array.isArray(tree)) {
        var obj = {}
        tree.forEach(function(el) {
          obj[el[nameLabel]] = formatTreeAsMap(el[codeLabel], nameLabel, codeLabel);
        });
        return obj;
      } else if (typeof tree === 'object') {
        return {
          [tree[nameLabel]]: formatTreeAsMap(tree[codeLabel], nameLabel, codeLabel)
        };
      } else {
        return tree;
      }
    }

    /**
     * Recupera la llamada en curso, transaccion en curso y opciones del uui. Métodos de acceso rápido al estado.
     **
     * @author amartinez
     */
    function getCurrentCall(state) {
      var state = state || that.store.getState();
      return state.phone.calls[state.phone.active] || state.phone.dialing[state.phone.active];
    }

    function getUIOptions(state) {
      var state = state || that.store.getState();
      return state.ui;
    }

    function getCurrentTransaction(state) {
      var state = state || that.store.getState();
      return state.transaction.list[state.transaction.active];
    }
    /*TODO pensar donde cargar los listeners y testear. Actualmente se cargan en handshakeSuccess
     y se eliminan en logout.*/
    function addEventListeners(){
      var changedWork = {
        eventType : sforce.console.ConsoleEvent.PRESENCE.WORKLOAD_CHANGED,
        eventListener : omnichannelChangedWork
      }
      thc.sforce.console.addEventListener(changedWork);
    }
    function removeEventListeners(){
      var changedWork = {
        eventType : sforce.console.ConsoleEvent.PRESENCE.WORKLOAD_CHANGED,
        eventListener : omnichannelChangedWork
      }
      thc.sforce.console.removeEventListener(changedWork);
    }
    /*
    * Al ser añadido o eliminado un trabajo al omnichannel consultamos los trabajos que posee, si coincide
    * con el máximo que puede tener seteamos estado a customBusy, si estaba en el máximo y deja de estarlo,
    * el softphone deberá volver al estado anterior.
    *
    * Cuando hay un cambio de estado de presencia también nos llega este evento con la carga del canal nuevo. Si la bidireccionalidad está activa y entra al canal disponible un trabajo
    * de capacidad 100% o superior, seteamos estado agente a busy, y por la bidireccionalidad en el omnichannel también, por lo que se vuelve a emitir este evento, y como la carga nueva
    * recibida es inferior a 100% se setea estado agente a available de nuevo.
    * Solución -> no gestionar cambio carga si estado es diferente de available. TODO Â¿Cómo eliminan los trabajos los agentes de manera normal? Â¿Cómo eliminan trabajos del canal available estando en busy?
    */
    function omnichannelChangedWork(evento){
      sforce.console.presence.getAgentWorks(function(result) {
        if (result.success) {
          thc.sforce.console.getServicePresenceStatusId().then(function(stateId) {
            var presenceAvailableId = thc.settings.get().provider.presence.availableStateId;
            if (stateId.statusId === presenceAvailableId ) {
              if( Number(evento.newWorkload) >= Number(evento.configuredCapacity)){
                that.store.reduceStore(function(state) {
                  state.presence = state.presence || {};
                  if(!state.presence.workLoaded){
                    state.presence.workLoaded = true;
                    state.presence.agentOldState = thc.controller.actions.setWorkBusyFromOc("customBusyState"); //debería estar en settings
                  }
                  return state;
                });
              }else{
                that.store.reduceStore(function(state) {
                  state.presence = state.presence || {};
                  if(state.presence.workLoaded){
                    state.presence.workLoaded = false;
                    thc.controller.actions.setWorkNotBusyFromOc(state.agent.oldState);
                  }
                  return state;
                });
              }
            }
          });
        }
      });

    }

    /**
     * Métodos de utilidad generales a todas las centralitas
     **
     * @author jmartinezpisson
     */
    that.util = {
      call: {
        searchAndScreenPop: callSearchAndScreenPop,
        customPop: popCustomURL,
        isInternal: isInternalCall,
        formatPhoneNumber: formatPhoneNumber,
        getContext: getCallContext,
        getCurrent: getCurrentCall,
        log: {
          init: initCallLog,
          end: endCallLog
        },
        uui: {
          parse: parseUUI,
          stringifyContextRecordsAsUUI: stringifyContextRecordsAsUUI
        },
        userInfo: {
          parse: function(userInfo) {
            return userInfo;
          }
        }
      },
      phone: {
        /**
         * Devuelve el cId de la llamada Activa, o en su defecto el valor de la línea de marcado activa. Si es null, no existen líneas activas.
         **
         * @author jmartinezpisson
         */
        getActiveCall: function(phone) {
          var cId = null;

          if (!util.object.isEmpty(phone.calls)) {
            if (phone.calls[phone.active]) {
              cId = phone.active;
            } else {
              util.object.forEach(phone.calls, function(callId, call) {
                if (call.status === 'ESTABLISHED') {
                  cId = callId;
                }

                if (!cId) {
                  cId = callId;
                }
              });
            }
          } else if (phone.dialing && phone.dialing.length) {
            if (phone.dialing[phone.active]) {
              cId = phone.dialing[phone.active] ? phone.active : '0';
            }
          }

          return cId;
        },
        /**
         * Devuelve true si existe una línea por defecto activa
         **
         * @author jmartinezpisson
         */
        checkForDefaultLine: function(phone) {
          return phone.dialing && phone.dialing.length === 1 && !phone.dialing[0].calledDevice;
        },
        /**
         * Devuelve true si existe una línea por defecto activa
         **
         * @author jmartinezpisson
         */
        processStatusCalls: function(args) {
          var transaction = args.transaction || {},
            phone = args.phone || {},
            phoneCalls = phone.calls || {},
            statusCalls = args.statusCalls || [],
            callsById = {},
            newPhone = {},
            newTransaction = {};



          return {
            transaction: newTransaction,
            phone: newPhone
          };
        }
      },
      integration: {
        presence: {
          setBusy: setServicePresenceStatus,
          synchronizeStatuses : synchronizePresenceStatus
        },
        listeners : {
          addEventListeners : addEventListeners,
          removeEventListeners : removeEventListeners
        },
      },
      services: {
        formatWrapups: formatTreeAsMap
      },
      transaction: {
        getCurrent: getCurrentTransaction
      },
      ui: {
        getOptions: getUIOptions
      },
      contact: {
        reschedule: function(args) {
          var formattedNumber,
            rescheduleCallParams = {};

          if (args.diffNumber) {
            formattedNumber = this.call.formatPhoneNumber(args.number);
            if (formattedNumber.isValid) {
              rescheduleCallParams = {
                phone: formattedNumber.phoneNumber
              };
            }
          }

          Object.assign(rescheduleCallParams, {
            captured: args.captured,
            scheduledate: moment(args.date + ' ' + args.timeHour + ':' + args.timeMinute, 'DD/MM/YYYY HH:mm').utc().format('DD/MM/YYYY HH:mm')
          });

          return thc.big.rest.rescheduleContact(rescheduleCallParams);
        }
      }
    };

    that.events = {
      // System events
      /**
       * Evento de gestión de conexión
       **
       * @param {Boolean} isReconnection - Identifica es una reconexión inicial
       * @author jmartinezpisson
       */
      onConnectionEstablished: function(isReconnection) {
        if(isReconnection) {
          return that.store.reduceStore({
            overlay: {
              show: false
            }
          });
        }

        return Promise.resolve();
      },
      /**
       * Handler que gestiona un reintento de conexión CometD a BIG
       **
       * @author jmartinezpisson
       */
      onConnectionRetry: function() {

      },
      /**
       * Handler que gestiona la rotura de la conexión CometD a BIG
       **
       * @author jmartinezpisson
       */
      onConnectionBroken: function() {
        // 1 - Si perdemos la conexión se muestra un mesaje de conexión perdida
        return that.store.reduceStore({
          overlay: {
            message: $Label.Softphone_Connection_Lost,
            show: true
          }
        });
      },
      /**
       * Evento recibido si la conexión CometD a BIG se cierra
       **
       * @author jmartinezpisson
       */
      onConnectionClosed: function() {

      },
      /**
       * Evento recibido si el softphone se conecta correctamente a CometD
       **
       * @author jmartinezpisson
       */
      onHandshakeSuccess: function() {

      },
      /**
       * Evento recibido si se produce un error durante el handshake del sofpthone
       **
       * @author jmartinezpisson
       */
      onHandshakeError: function() {

      },
      onDisconnection: function() {

      },
      onRetryError: function() {
        return that.store.reduceStore({
          overlay: {
            show: true,
            message: 'Unable to reconnect. Disconnecting'
          }
        });
      },
      /**
       * Evento recibido durante la inicialización del servicio de telecomunicación.
       * Inicializa la llamada, si esta no existe de forma previa.
       **
       * @author jmartinezpisson
       */
      onEventServiceInitiated: function(event) {

        return that.store.reduceStore(function(state) {
          // 1 - Se elimina la llamada realizada de entre las marcadas
          state.phone.dialing = state.phone.dialing.length === 1 ? state.phone.dialing.filter(function(call) {
            if (call.status !== 'STANDBY' || call.calledDevice !== '') {
              return call;
            }

            return false;
          }) : state.phone.dialing;

          // 2 - Se inicializan los datos básicos de la llamada
          state.phone.calls[event.cid] = Object.assign(state.phone.calls[event.cid] || {}, {
            cId: event.cid,
            uCId: event.ucid
          });

          // 3 - Se marca la llamada actual como la activa
          state.phone.active = event.cid;

          return state;
        });
      },
      /**
       * Evento recibido durante la marcación de una llamada saliente. Indica que se ha aceptado la marcación de destino y se va a intentar realizar la llamada
       * Identifica la llamada como Outbound, se asignan el ANI y el DNIS y se inicializa el Call Log: de esta forma, se generan logs si el cliente no acepta la llamada
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento con los datos del OnEventOriginated.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       * @param {String} event.ucid - Universal Call Identifier. Identificador único de la llamada en el sistema teléfonico, estando la unicidad garantizada. Opcional.
       * @param {String} event.calleddevice - Número de teléfono/terminal destino de la llamada.
       * @param {String} event.callingdevice -  Número de teléfono/terminal origen de la llamada.
       */
      onEventOriginated: function(event) {
        return that.store.reduceStore(function(state) {
          var transaction = state.transaction;
          var currentTransaction = that.util.transaction.getCurrent(state);
          var phone = state.phone,
            calls = state.phone.calls;

          // 1 - Se asignan los datos básicos de la llamada
          phone.calls[event.cid] = Object.assign(phone.calls[event.cid] || {}, {
            cId: event.cid,
            uCId: event.ucid,
            dnis: event.calleddevice,
            ani: event.callingdevice,
            type: thc.CALL_TYPE.OUTBOUND,
            partyType: null,
            status: 'RINGING'
          });

          // 2 - Se identifica el origen de la llamada como multilllamada, se extrae del marcado de teléfono y se marca como activa
          // 2.1 - Marcado de teléfono
          // Si existe una llamada encolada con número marcado, se marca la nueva llamada como llamada marcada
          phone.dialing = phone.dialing.filter(function(call) {
            if (call.calledDevice) { // === formatPhoneNumber(phone.calls[event.cid].dnis)) {
              phone.calls[event.cid].partyType = thc.PARTY_TYPE.NONE;
              if(call.clickToDialRecordId){
                phone.calls[event.cid].clickToDialRecordId = call.clickToDialRecordId;
              }
              return false;
            }

            return true;
          });

          // 2.2 - Llamadas de consulta
          // Si existe una consulta encolada, se marca la nueva llamada como consulta
          if (phone.consulting.length) {
            phone.consulting.pop();
            phone.calls[event.cid].partyType = thc.PARTY_TYPE.CONSULT;
          }

          // 2.3 - Llamadas de conferencia
          // Si existe una consulta encolada, se marca la nueva llamada como consulta
          if (phone.conferencing.length) {
            phone.conferencing.pop();
            phone.calls[event.cid].partyType = thc.PARTY_TYPE.CONFERENCE;
          }

          // 3 - Se realiza el tratamiento de la transacción, y se inicializa si esta no existía de forma previa. Si la sesión activa no es de tipo llamada o la llamada es de tipo consulta/transferencia/conferencia
          /*if (!calls[event.cid].transactionId && currentTransaction && currentTransaction.type !== thc.TRANSACTION_TYPE.CALL) {
            calls[event.cid].transactionId = currentTransaction.id;
          } else if (calls[event.cid].transactionId) {
            currentTransaction = transaction.list[calls[event.cid].transactionId];
          } else {
            transaction.list[event.cid] = {
              id: event.cid,
              type: thc.TRANSACTION_TYPE.CALL,
              status: thc.TRANSACTION_STATUS.ACTIVE
            };

            currentTransaction = transaction.list[event.cid];
            calls[event.cid].transactionId = event.cid;
          }

          currentTransaction.status = thc.TRANSACTION_STATUS.ACTIVE;
          transaction.active = currentTransaction.id;*/
          phone.active = event.cid;

          // 4 - Se identifica si la llamada es interna
          phone.calls[event.cid].isInternal = that.util.call.isInternal(phone.calls[event.cid]);

          // 5 - Se inicializa el Call Log, generando la tarea correspondiente, sí y solo si la llamada es la principal de la transacción en curso
          /*if (phone.calls[event.cid].transactionId === event.cid) {
            return that.util.call.log.init(phone.calls[event.cid]).then(function(task) {
              phone.calls[event.cid].log = Object.assign(phone.calls[event.cid].log || {}, {
                taskId: task.taskId,
                subject: task.subject,
                disposition: task.disposition
              });

              return state;
            });
          }*/

          return state;
        });
      },
      /**
       * Evento recibido cuando se genera una nueva llamada a la extensión, ya sea entrante (INBOUND) o saliente (OUTBOUND).
       **
       * @author jmartinezpisson, jarina
       * @param {object} event - Datos del evento,
       * @param {BigEvent} event - Evento con los datos del OnEventOriginated.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       * @param {String} event.ucid - Universal Call Identifier. Identificador único de la llamada en el sistema teléfonico, estando la unicidad garantizada. Opcional.
       * @param {String} event.calleddevice - Número de teléfono/terminal destino de la llamada. Requerido.
       * @param {String} event.callingdevice -  Número de teléfono/terminal origen de la llamada. Requerido.
       * @param {String} event.answeringdevice - Número de teléfono/terminal que recibe la llamada, generalmente idéntico a calleddevice. Opcional
       * @param {String} event.reddevice -  Redirecting device. Número de teléfono/terminal que ha redireccionado la llamada. Opcional.
       * @param {String} event.queuetime - Tiempo de la llamada en cola. Opcional
       * @param {String} event.deliveringacd - Delivering Automatic Call Distributor.  Número de teléfono/terminal que ha enrutado la llamada, generalmente el VDN de la cola que encola la llamada. Requerido.
       * @param {String} event.userinfo -  Información adicional de la llamada, incluyendo generalmente datos de contexto del sistema teléfonico. Se requiere parseo en formato JSON. Requerido.
       * @param {object} handlerSettings - Permite bloquear la ejecución del procesamiento de la llamada
       * @param {boolean} handlerSettings.getContext - Realiza la búsqueda de contexto a través del searchAndScreenPop y el contexto actual, y se lanza la integración vía customPop
       * @param {boolean} handlerSettings.updateTodayCalls - Actualiza las llamadas de hoy
       * @param {boolean} handlerSettings.initPresence - Lanza las integraciones con OmniChannel
       * @param {boolean} handlerSettings.parseUserinfoAsJSON - Parsea el campo userinfo como objeto JSON, y en caso contrario, como string
       */
      onEventAlerting: function(event, handlerSettings) {
        // 0 - Valores por defecto del handler
        handlerSettings = Object.assign({
          getContext: true,
          updateTodayCalls: true,
          initPresence: true,
          parseUserinfoAsJSON: true
        }, handlerSettings);


        // 1 - Se procesa el evento y se actualizan los datos de llamadas/transacción
        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            calls = state.phone.calls,
            alertingCall = calls[event.cid] || {},
            transaction = state.transaction,
            currentTransaction = state.transaction.list[state.transaction.active] || {},
            onEventAlertingFinishedPromise = Promise.resolve();

          // 1 - Se actualiza la llamada con los datos del evento, asignando los datos del OnEventAlerting, y manteniendo los existentes de la llamada
          alertingCall = Object.assign(alertingCall, {
            cId: event.cid,
            uCId: event.ucid,
            deliveringAcd: event.deliveringacd,
            dnis: event.calleddevice,
            ani: event.callingdevice,
            answeringDevice: event.answeringdevice,
            redDevice: event.reddevice,
            queueTime: event.queuetime,
            callTime: 0,
            holdTime: 0,
            status: 'RINGING'
          });

          // 2 - Se identifica si la llamada es interna; si la llamada no se había identificado previamente como OUTBOUND, se considera directamente INBOUND y se inicializa el call log
          if (!alertingCall.type) {
            alertingCall.type = thc.CALL_TYPE.INBOUND;
            alertingCall.isInternal = that.util.call.isInternal(alertingCall);
            alertingCall.partyType = thc.PARTY_TYPE.NONE;
            that.actions.ring();

            if(thc.settings.get().callcenter.softphone.isAutoAnswerEnabled) {
              that.actions.autoAnswerCall(alertingCall, 2);
            };
          }

          // 3 - Se realiza el tratamiento de la transaccion actual
          // 3.1 - Si la llamada cuenta con transacción y esta existe, esta se marca como la transacción actual
          if (alertingCall.transactionId && transaction.list[alertingCall.transactionId] && transaction.list[alertingCall.transactionId].status !== thc.TRANSACTION_STATUS.CLEARED) {
            currentTransaction = transaction.list[alertingCall.transactionId];
          // 3.2 - Por el contrario si no existe transacción en curso, se genera una nueva de tipo llamada cuyo origen es la propia llamada
          } else if (!currentTransaction.id) {
            transaction.list[event.cid] = {
              id: event.cid,
              type: thc.TRANSACTION_TYPE.CALL,
              status: thc.TRANSACTION_STATUS.ACTIVE
            };
            currentTransaction = transaction.list[event.cid];
          }

          // 4 - Se parsea el userInfo y el UUI
          alertingCall.userInfo = event.userinfo ? (handlerSettings.parseUserinfoAsJSON ? JSON.parse(event.userinfo) : {
            uui: event.userinfo
          }) : {};

          // Si se trata de un clickToDial se añade el recordId obtenido
          if(alertingCall.clickToDialRecordId){
            alertingCall.userInfo.uui = (alertingCall.userInfo.uui || '') + alertingCall.clickToDialRecordId;
          }

          currentTransaction.context = Object.assign(currentTransaction.context || {}, {
            uui: that.util.call.uui.parse(alertingCall.userInfo.uui || '')
          });

          // 5 - Se actualiza la llamada en el árbol de llamadas, se marca la llamada y transacción actual como activa, y se elimina la linea STANDBY por defecto si aplica
          //     Se marca también que la llamada ha sido alertada
          alertingCall.isAlerted = true;
          alertingCall.transactionId = currentTransaction.id;
          calls[event.cid] = alertingCall;

          currentTransaction.status = thc.TRANSACTION_STATUS.ACTIVE;
          transaction.active = currentTransaction.id;
          phone.active = event.cid;

          if (that.util.phone.checkForDefaultLine(phone)) {
            phone.dialing = [];
          }

          // 6 - Generación del log/tarea asociada a la llamada
          // 6.1 - Log de tarea
          onEventAlertingFinishedPromise = that.util.call.log.init(calls[event.cid]).then(function(task) {
            calls[event.cid].log = Object.assign(calls[event.cid].log || {}, {
              taskId: task.taskId,
              subject: task.subject,
              disposition: task.disposition
            });
          });

          // 6.2 - Integraciones con Salesforce
          onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
            return Promise.all([
              thc.sforce.controller.getTodayCalls(), // Se recuperan las llamadas

              thc.sforce.setVisible({
                visible: true
              }) // Se obliga al softphone a estar visible
            ]);
          }).then(function(responses) {
            var todayCalls = responses[0];

            if (todayCalls) {
              state.myLastCalls = todayCalls;
            }
          });

          // 7 - Si la llamada alertada actual gestiona la transacción y es de tipo llamada, se debe lanzar la búsqueda de contexto
          if (currentTransaction.id === event.cid && calls[event.cid].partyType === thc.PARTY_TYPE.NONE && handlerSettings.getContext) {
            // 7.1 - Lanzamos la búsqueda del contexto: como en este punto, el contacto no tiene todos los datos necesarios para la búsqueda, solo se lanza si la transacción es de tipo CALL
            onEventAlertingFinishedPromise = that.util.call.getContext({
                call: calls[event.cid],
                transaction: currentTransaction
              }).then(function(callContext) {
                currentTransaction.context = Object.assign(currentTransaction.context || {}, callContext.context || {});
                calls[event.cid].log = Object.assign(calls[event.cid].log || {}, callContext.log || {});
              });
          }

          // 8 - Finalizado el procesamiento, se devuelve el estado
          return onEventAlertingFinishedPromise.then(function() {
            return state;
          }).catch(function(error) {
            state.notifications = {
              type: 'error',
              show: true,
              message: error
            };

            return state;
          });
        });
      },
      /**
       * Evento recibido cuando se establece una llamada a la extensión.
       **
       * @author jmartinezpisson
       * @param {object} event - Datos del evento,
       * @param {BigEvent} event - Evento con los datos del onEventEstablished.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       * @param {String} event.ucid - Universal Call Identifier. Identificador único de la llamada en el sistema teléfonico, estando la unicidad garantizada. Opcional.
       * @param {String} event.answeringdevice - Número de teléfono/terminal que recibe la llamada, generalmente idéntico a calleddevice. Opcional
       * @param {String} event.deliveringacd - Delivering Automatic Call Distributor.  Número de teléfono/terminal que ha enrutado la llamada, generalmente el VDN de la cola que encola la llamada. Requerido.
       * @param {String} event.reddevice -  Redirecting device. Número de teléfono/terminal que ha redireccionado la llamada. Opcional.
       * @param {String} event.queuetime - Tiempo de la llamada en cola. Opcional
       * @param {object/String} event.userinfo -  Información adicional de la llamada, incluyendo generalmente datos de contexto del sistema teléfonico. Puede requerir parseo en formato JSON. Opcional.
       * @param {object} handlerSettings - Permite personalizar el funcionamiento del evento
       * @param {boolean} handlerSettings.parseUserinfoAsJSON - Parsea el campo userinfo como objeto JSON, y en caso contrario, como string
       */
      onEventEstablished: function(event, handlerSettings) {
        // 0 - Valores por defecto del handler
        handlerSettings = Object.assign({
          parseUserinfoAsJSON: true
        }, handlerSettings);

        // 1 - Integraciones omnichannel
        that.util.integration.presence.setBusy(true); // Se fuerza que Onmnichannel marque el estado Ocupado

        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            calls = phone.calls;

          // 2 - Se actualizan los datos y estado de la llamada
          calls[event.cid] = Object.assign(calls[event.cid] || {}, {
            cId: event.cid,
            uCId: event.ucid,
            deliveringAcd: event.ucid,
            userInfo: event.userinfo ? (handlerSettings.parseUserinfoAsJSON ? JSON.parse(event.userinfo) : {
              uui: event.userinfo
            }) : {},
            answeringDevice: event.answeringdevice,
            redDevice: event.reddevice,
            queueTime: event.queuetime,
            status: 'ESTABLISHED',
            lastUpdated: new Date()
          });

          return state;
        });
      },
      /**
       * Gestion la recepción de un evento CometD onEventCallHeld, recibido si una llamada es pausada por el receptor o emisor.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del onEventCallHeld.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       */
      onEventCallHeld: function(event) {
        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            transaction = that.util.transaction.getCurrent(state),
            calls = phone.calls;

          // 1 - Estado de la llamada
          calls[event.cid] = Object.assign(calls[event.cid] || {}, {
            cId: event.cid,
            status: 'HELD',
            lastUpdated: new Date(),
            holdTime: 0
          });

          // 2 - Si la transacción actual es de tipo sesión y la llamada pausada es la correspondiente a la maestra de la transacción, se marca la transacción como activa
          if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
            transaction.status = thc.TRANSACTION_STATUS.ACTIVE;
          }

          return state;
        });
      },
      /**
       * Gestion la recepción de un evento CometD OnEventCallRetrieved, recibido si una llamada se encontraba pausada y es recuperada por la parte pausada
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventCallRetrieved.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       */
      onEventCallRetrieved: function(event) {
        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            transaction = that.util.transaction.getCurrent(state),
            calls = phone.calls,
            call = calls[event.cid] || {};

          // 1 - Estado de la llamada
          calls[event.cid] = Object.assign(calls[event.cid] || {}, {
            cId: event.cid,
            status: 'ESTABLISHED',
            callTime: (call.callTime || 0) + (call.holdTime || 0),
            lastUpdated: new Date()
          });

          // 2 - Si la transacción actual es de tipo sesión y la llamada pausada es la correspondiente a la maestra de la transacción, se marca la transacción como activa
          if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
            transaction.status = thc.TRANSACTION_STATUS.ACTIVE;
          }

          return state;
        });
      },
      /**
       * Gestion la recepción de un evento OnEventCallConnectionCleared, recibido cuando una llamada es colgada por uno de los extremos.
       * Se reciben tantos eventos como participantes existan en dicha llamada.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventCallConnectionCleared.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
       * @param {String} event.ucid - Universal Call Identifier. Identificador único de la llamada en el sistema teléfonico, estando la unicidad garantizada. Opcional.
       * @param {String} event.cause - Causa del cierre de la llamada. Opcional.
       * @param {Boolean} event.propagated - Identifica si el cierre de la llamada se ha propagado desde el emisor. Opcional.
       */
      onEventCallConnectionCleared: function(event) {
        var taskSettings = thc.settings.get().task,
          urlSettings = thc.settings.get().urlConfiguration,
          onEventCallConnectionClearedPromise,
          createTaskPromise = Promise.resolve(), forceCloseTask = false;

        onEventCallConnectionClearedPromise = that.store.reduceStore(function(state) {
          var phone = state.phone,
            currentTransaction = null,
            transactionCall = null,
            onEventCallConnectionClearedFinishedPromise = Promise.resolve();

          // 0 - Integraciones con Salesforce
          onEventCallConnectionClearedFinishedPromise = that.util.integration.presence.setBusy(false);

            // si se finaliza una conferencia
          if(phone.calls[event.cid] && phone.calls[event.cid].conference){
            if(phone.calls[phone.active].conference.members.length>0){
              onEventCallConnectionClearedFinishedPromise = that.util.integration.presence.setBusy("conferenceEnded"); // Se fuerza que Onmnichannel vuelva al estado anterior
            }
          }

          // 1 - Se actualiza el tiempo de la llamada, si estaba en pausa
          if (phone.calls[event.cid] && phone.calls[event.cid].status === 'HELD' && !isNaN(phone.calls[event.cid].holdTime)) {
            phone.calls[event.cid].callTime = phone.calls[event.cid].holdTime + phone.calls[event.cid].callTime;
          }

          // 2 - Se actualiza el estado de la llamada a CLEARED
          phone.calls[event.cid] = Object.assign(phone.calls[event.cid] || {}, {
            cId: event.cid,
            uCId: event.ucid,
            clearCause: event.cause,
            propagated: event.propagated,
            lastUpdated: new Date(),
            status: 'CLEARED'
          });

          // 3 - Se controla la transacción.
          currentTransaction = state.transaction.list[phone.calls[event.cid].transactionId] || {};
          transactionCall = phone.calls[currentTransaction.id];

          // 4 - Se comprueba si existe una llamada cuyo contexto está asociado a la actual: si se ha configurado el softphone como corresponde se autoactualiza la tarea
          if (taskSettings.autoUpdate && transactionCall && transactionCall.log) {
            createTaskPromise = that.util.call.log.end(transactionCall).then(function(task) {
              if(task && task.taskId) {
                transactionCall.log.taskId = task.taskId;
              }
            }).catch(function(errors) {
              return that.store.reduceStore({
                notifications: {
                  show: true,
                  message: 'Error while updating task: ' + errors,
                  type: 'error'
                }
              });
            });
          }

          // 5 - Si la llamada no es la principal de la transacción, se debe eliminar la llamada
          if (event.cid !== currentTransaction.id) {
            that.actions.deleteCall(event.cid);

            return state;
          }


          // 6 - Si la llamada es la que mantiene la transacción, se realiza el procesamiento post-transaccción
          // 6.1 - Se marca la transacción como CLEARED, permitiendo su posterior cierre
          if (currentTransaction.type !== thc.TRANSACTION_TYPE.SESSION) {
            currentTransaction.status = thc.TRANSACTION_STATUS.CLEARED;
          }

          // 6.2 - Si la configuración así lo dice, se autocierra la llamada
          forceCloseTask = !taskSettings.showCallLog;

          // 7 - Si la transacción pasa a estar cleared, se lanza el customPop; de esta manera, el customPop se hace al finalizar la llamada o cuando finaliza una sesión que prmite multillamada.
          //  Tanto si se realiza de forma correctamente como si no, el estado es actualizado
          if (currentTransaction.sessionStatus === 'PREVIEW_ANALYSIS') {
            currentTransaction.sessionStatus = 'CALL';
            return state;
          } else {
            return that.util.call.customPop({
              call: phone.calls[event.cid],
              contact: currentTransaction.contact,
              context: currentTransaction.context,
              log: phone.calls[event.cid].log
            }, urlSettings.callEnded, urlSettings.openAsSubtab).then(function() {
              return state;
            }, function(err) {
              return state;
            });
          }
        });

        // 8 - Si no se muestra el callLog, se actualiza la tarea como si el botón se hubiese pulsado
          onEventCallConnectionClearedPromise = onEventCallConnectionClearedPromise.then(function() {
            if(forceCloseTask) {
              createTaskPromise = createTaskPromise.then(function() {
                that.actions.updateTask();
              });
            }

            return createTaskPromise;
          });


        return onEventCallConnectionClearedPromise;
      },
      /**
       * Gestiona la recepción de un evento OnEventTransferred, recibido cuando una llamada es transferida o se recibe una llamada transferida desde otro origen.
       * Generalmente, solo es necesaria la gestión de la transferencia desde el terminal del usuario a otro destino.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventTransferred.
       * @param {String} event.extension - Extensión del usuario actual. Obligatorio.
       * @param {String} event.provider -Servidor. Opcional.
       * @param {String} event.transferingdevice - Número de teléfono/termina que realiza la transferencia. Opcional.
       * @param {String} event.transfereddevice - Número de teléfono/terminal al auqe se ha transferido. Opcional.
       * @param {String} event.partydevices - Terminales participantes en la llamada
       * @param {String} event.primarycid - Primary Call Identifier. Id. de la llamada en el sistema teléfonico que se ha transferido. Obligatorio.
       * @param {String} event.secondarycid - Secondary Call Identifier. Id. de la llamada sobre la que se ha transferido en el sistema teléfonico. Obligatorio.
       * @param {String} event.cause - Causa del cierre de la llamada. Opcional.
       * @param {Boolean} event.propagated - Identifica si el cierre de la llamada se ha propagado desde el emisor. Opcional.
       */
      onEventTransferred: function(event) {

        // 0 - Integraciones con Salesforce
         that.util.integration.presence.setBusy("transferred"); // Se fuerza que Onmnichannel vuelva al estado anterior

        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            transferredCall = phone.calls[event.primarycid] || {},
            currentTransaction = state.transaction.list[transferredCall.transactionId] || {},
            secondaryCall = phone.calls[event.secondarycid] || null,
            isOutbound = event.extension === event.transferingdevice;
          // || transferredCall.status === 'ESTABLISHED' || transferredCall.status === 'HELD');
          // 1 - Si la transferencia es hacia fuera, se realiza el procesamiento automático de las dos tareas?? Revisar
          //     Se considera trasnferencias saliente si la extensión es distinta del transferingDevice o la llamada existe en el softphone y el estado es HELD o ESTABLISHED
          if (isOutbound) {
            // 1 - Se marca la llamada como transferida
            phone.calls[event.primarycid] = Object.assign(transferredCall, {
              clearCause: event.cause,
              propagated: event.propagated,
              lastUpdated: new Date(),
              status: 'TRANSFERRED'
            });


            // 2 - Si existía una llamada secundaria (consultiva) se elimina
            if (secondaryCall && event.primarycid !== event.secondarycid) {
              phone.cleared[secondaryCall.cId] = secondaryCall;
              delete state.phone.calls[event.secondarycid];
            }

            // 3 - Si la llamada es la principal de la transacción, se marca esta como CLEARED
            if (transferredCall.cId === transferredCall.transactionId) {
              state.transaction.list[transferredCall.transactionId].status = thc.TRANSACTION_STATUS.CLEARED;
            }


            // 4 - Si la transacción es de tipo CALL, se genera la tarea y se eliminan tanto la llamada como la transacción
            if (currentTransaction.type === thc.TRANSACTION_TYPE.CALL) {
              return that.util.call.log.end(transferredCall).then(function() {
                // 4.1 - Se muestra el mensaje de llamada transferida
                state.notifications = {
                  show: true,
                  message: 'Call transferred',
                  type: 'success'
                };

                // 4.2 - Se elimina la llamada transferida así como la transacción asociada
                phone.cleared[transferredCall.cId] = transferredCall;
                delete state.phone.calls[transferredCall.cId];
                delete state.transaction.list[currentTransaction.id];

                // 4.3 - Se obtiene la llamada activa o en su defecto, se genera una nueva
                phone.active = that.util.phone.getActiveCall(phone);

                if (!phone.active) {
                  state.transaction.active = '';
                  phone.active = '0';
                  phone.dialing.push({
                    calledDevice: '',
                    status: 'STANDBY'
                  });
                }

                // 4.4 - Se realiza el customPop de la llamada eliminada
                return that.util.call.customPop({
                  call: phone.cleared[event.cid],
                  contact: currentTransaction.contact,
                  context: currentTransaction.context,
                  log: phone.cleared[event.cid].log
                }).catch().then(function() {
                  return state;
                });
              });
            }
          }


          return state;
        });
      },
      /**
       * Gestiona la recepción de un evento OnEventTransferred, recibido cuando una llamada es transferida o se recibe una llamada transferida desde otro origen.
       * Generalmente, solo es necesaria la gestión de la transferencia desde el terminal del usuario a otro destino.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventTransferred.
       * @param {String} event.extension - Extensión del usuario actual. Obligatorio.
       * @param {String} event.provider -Servidor. Opcional.
       * @param {String} event.addedparty - Número de teléfono/termina que realiza la transferencia. Opcional.
       * @param {String} event.transfereddevice - Número de teléfono/terminal al auqe se ha transferido. Opcional.
       * @param {String} event.confconnections - Conexiones participantes en la llamada. Necesario parsear como JSONString
       * @param {Object[]} event.confconnections.partydevices - Terminales participantes en la llamada. Cada terminal viene identificado como un objeto cuyo atributo partydevice es la extensión de dicho terminal
       * @param {String} event.confcontroller - Número principal controlador de la conferencia
       * @param {String} event.confconnections - Terminales participantes en la llamada
       * @param {String} event.primarycid - Primary Call Identifier. Id. de la llamada en el sistema teléfonico que se ha transferido. Obligatorio.
       * @param {String} event.secondarycid - Secondary Call Identifier. Id. de la llamada sobre la que se ha transferido en el sistema teléfonico. Obligatorio.
       * @param {String} event.cause - Causa del cierre de la llamada. Opcional.
       */
      onEventConferenced: function(event) {
        // 0 - Se parsea el contenido de confconnections
        event.confconnections = JSON.parse(event.confconnections);

        // 2 - Si la extensión actual es el controlador de la transferencia
        if (event.extension === event.confcontroller) {
          return that.store.reduceStore(function(state) {
            var phone = state.phone,
              newCall = phone.calls[event.cid] || {},
              primaryCall = phone.calls[event.primarycid] || {},
              secondaryCall = phone.calls[event.secondarycid] || {},
              currentTransaction = state.transaction.list[newCall.transactionId] || {};

            // 1.1 - Al conferenciar la llamada principal se fusiona con la secundaria y generando/manteniendo la correspondiente al event.cid
            phone.active = event.cid;
            state.transaction.active = event.cid;
            phone.calls[event.cid].conference = {
              members: event.confconnections.partydevices.map(function(partyDevice) {
                return partyDevice.partydevice;
              }),
              controller: event.confcontroller
            };
            phone.calls[event.cid].partyType = thc.PARTY_TYPE.NONE;

            // 1.2 - Se gestiona la transacción asociada a la nueva llamada - esta dependerá de la llamada fusionada. La llamada conferenciada debe mantener la transacción actual, así como el log de tarea
            if (event.cid !== currentTransaction.id) {
              phone.calls[event.cid].log = phone.calls[currentTransaction.id].log;
              phone.calls[event.cid].context = phone.calls[currentTransaction.id].context;
              state.transaction.active = event.cid;
              state.transaction.list[event.cid] = currentTransaction;
              delete state.transaction.list[currentTransaction.id];

              currentTransaction.id = event.cid;
              phone.calls[event.cid].transactionId = event.cid;
            }

            // 1.3 - Se elimina la llamada de consulta conferenciada//llamada eliminada al fusionar En ocasionaas el secondarcid es idéntico al primarycid, por lo que esta llamada debe eliminarse por inferencia del tipo
            // 1.3.1 - Si la llamada eliminada es el primarycid
            if (event.cid !== event.primarycid) {
              phone.cleared[event.primarycid] = primaryCall;
              delete state.phone.calls[event.primarycid];
            } else if (event.cid !== event.secondarycid) {
              phone.cleared[event.secondarycid] = secondaryCall;
              delete state.phone.calls[event.secondarycid];
            } else {
              // 1.3.2 - Se busca por tipo la llamada conferenciada
              util.object.forEach(phone.calls, function(cId, call) {
                if (call.partyType === thc.PARTY_TYPE.CONFERENCE) {
                  delete state.transaction.list[cId];
                  delete phone.calls[cId];
                }
              });
            }

            return state;
          });
          // 2 - Si la extensión es la que se ha añadido a la conferencia, significa que la conferencia es entrante
        } else if (event.extension === event.addedparty) {
          return that.store.reduceStore(function(state) {
            var phone = state.phone,
              conferencedCall = phone.calls[event.secondarycid] || {},
              currentTransaction = state.transaction.list[conferencedCall.transactionId] || {};

            // 2.1 - Al conferenciar la llamada principal se sustituye por la secundaria; se intercambian los cid de llamadas y así mantenemos el contexto actual.
            conferencedCall.cId = event.primarycid;
            phone.calls[event.primarycid] = conferencedCall;
            delete phone.calls[event.secondarycid];
            phone.active = conferencedCall.cId;

            // 2.2 - la transacción debe pasar al nuevo cid, si el transactionId es el mismo que el de la llamada conferenciada antigua
            if (currentTransaction.id === event.secondarycid) {
              currentTransaction.id = event.primarycid;
              conferencedCall.transactionId = event.primarycid;
              state.transaction.list[event.primarycid] = currentTransaction;
              state.transaction.active = event.primarycid;
              delete state.transaction.list[event.secondarycid];
            }

            // 2.3 - Se asigna a la llamada los terminales participantes en la llamada
            phone.calls[event.primarycid].conference = {
              members: event.confconnections.partydevices.map(function(partyDevice) {
                return partyDevice.partydevice;
              }),
              controller: event.confcontroller
            };

            // 2.4 - Se marca el partyType como llamada única
            phone.calls[event.primarycid].partyType = thc.PARTY_TYPE.NONE;

            return state;
          });

        }

        // 3 - En caso contrario, se actualizan los datos de los partyDevices
        return that.store.reduceStore(function(state) {
          var phone = state.phone;

          phone.calls[event.primarycid] = Object.assign(phone.calls[event.primarycid] || {}, {
            conference: {
              members: event.confconnections.partydevices.map(function(partyDevice) {
                return partyDevice.partydevice;
              }),
              controller: event.confcontroller
            }
          });

          return state;
        });
      },
      /**
       * Gestiona la recepción de un evento OnEventDiverted, recibido si una llamada se encontraba sonando en el terminal del usuario
       * y se ha redireccionado a otro terminal pasado el tiempo máximo de respuesta.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventCallConnectionCleared.
       * @param {String} event.extension - Extensión del usuario actual. Obligatorio.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico que se derivado. Obligatorio.
       */
      onEventDiverted: function(event) {
        that.actions.deleteCall(event.cid);
      },

      /**
       * Se presupone que el onEventEstablished llega antes que onEventRecording
       */
      onEventRecording : function(event){
        return that.store.reduceStore(function(state){
          var recordingState = "";
          switch (event.action) {
            case "start" : recordingState = "recording"; break;
            case "resume" : recordingState = "recording"; break;
            case "pause" : recordingState = "paused"; break ;
            case "stop" : recordingState = "stopped";  break;
            default: recordingState = "stopped"; break ;
          }
          var phone = state.phone;
          if(phone.calls[phone.active]){
            phone.calls[phone.active].recording = Object.assign(phone.calls[phone.active].recording || {},{
              state : recordingState
            });
            if(phone.calls[phone.active]){
              if(recordingState === "start"){
                phone.calls[phone.active].recording = Object.assign(phone.calls[phone.active].recording || {},{
                  recordingId : event.recordid
                });
              }
            }
          }
          return state;
        });
      },
      /**
       * Gestiona la recepción de un evento OnEventFailed, recibido ante errores general durante la gestión interna de llamadas por parte del sistema teléfonico.
       **
       * @author jmartinezpisson
       * @param {BigEvent} event - Evento de BIG con los datos del OnEventCallConnectionCleared.
       * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico relacionada con el error. Opcional
       * @param {String} event.ucid - Universal Call Identifier. Identificador único de la llamada en el sistema teléfonico, estando la unicidad garantizada. Opcional.
       * @param {String} event.cause - Causa del error. Opcional.
       * @param {Boolean} event.propagated - Identifica si el error se ha propagado desde otro terminal. Opcional.
       */
      onEventFailed: function(event) {
        return that.store.reduceStore(function(state) {
          state.notifications.show = true;
          state.error.type = 'EVENT';
          state.error.message = 'Error: ' + event.cause;

          if (event.cid) {
            return thc.big.rest.getStatusCalls().catch(function() {
              return [];
            }).then(function(statusCalls) {
              var checkedState = that.util.phone.processStatusCalls({
                statusCalls: statusCalls.calls,
                phone: state.phone,
                transaction: state.transaction,
                extension: event.extension
              });

              if (checkedState.phone.calls && checkedState.phone.calls[event.cid]) {
                state.phone.calls[event.cid].status = checkedState.phone.calls[event.cid].status;
              }

              return state;
            });
          }

          return state;
        });
      }
    };

    that.actions = {

      addLine: function(call) {
        var settings = thc.settings.get(),
          currentTransaction = that.util.transaction.getCurrent(),
          newCall = call || {
            calledDevice: '',
            status: 'STANDBY'
          };

        return that.store.reduceStore(function(state) {
          var callNum = Object.keys(state.phone.calls).length + state.phone.conferencing.length + state.phone.consulting.length + state.phone.dialing.length;
          var maxLines = parseInt(thc.settings.get().callcenter.dialing.maxLines);

          if (callNum < maxLines) {
            if (currentTransaction && currentTransaction.type === thc.TRANSACTION_TYPE.SESSION && currentTransaction.status !== thc.TRANSACTION_STATUS.CLEARED) {
              newCall = Object.assign(newCall, {}, {
                transactionId: currentTransaction.id
              })
            }
            state.phone.dialing.push(newCall);

            if (!state.phone.active) {
              state.phone.active = '' + (state.phone.dialing.length - 1);
            }
          }

          return state;
        });
      },
      /**
       * Añade un conjunto de registros a los registros del contexto de la transacción activa. Si es un único registro, se relaciona la transacción directamente con el nuevo registro
       **
       * @author jmartinezpisson
       * @param {Array} records - Array de objetos, en el formato devuelto por los listeners onFocus/onNavigationChange de la librería OpenCTI
       * @param {String} source - Origen de los registros. Almacena en la llamada los ids. relacionados con dicho origen
       */
      addRecordsToActiveTransaction: function(records, source) {
        var whatIdAllowedSObjects = thc.settings.get().custom.whatIdAllowedSObjects,
            preserveCallLogRelatedData = thc.settings.get().task.preserveCallLogRelatedData,
            NONEOptionSelectable = thc.settings.get().task.isTaskRelatedDataNullable;

        return that.store.reduceStore(function(state) {

          var currentCall = state.phone.cleared[state.transaction.active] || state.phone.calls[state.phone.active] || state.phone.dialing[state.phone.active] || {},//AÑADIDO
            transactionCall = state.phone.cleared[currentCall.transactionId] || state.phone.calls[currentCall.transactionId] || state.phone.dialing[currentCall.transactionId] || {},//AÑADIDO
            currentTransaction = state.transaction.list[transactionCall.transactionId],
            sourceRecords = [];

          if (transactionCall && currentTransaction) {
            currentTransaction.context = currentTransaction.context || {};
            currentTransaction.context.records = currentTransaction.context.records || {};

            records.forEach(function(record) {
              if (record.personAccount || record.IsPersonAccount) {
                record.IsPersonAccount = record.personAccount || record.IsPersonAccount || false;
                record.PersonContactId = record.contactId || record.PersonContactId || null;
              }
              /*if (record.personAccount || record.IsPersonAccount) {
                currentTransaction.context.records.Contact = currentTransaction.context.records.Contact || {};
                currentTransaction.context.records.Contact[record.recordId] = Object.assign(currentTransaction.context.records.Contact[record.recordId] || {}, record);

                sourceRecords.push({
                  object: 'Contact',
                  id: record.contactId || record.PersonContactId
                });

              } else if (whatIdAllowedSObjects[record.objectType] || record.objectType === 'Lead' || record.objectType === 'Contact') {
                currentTransaction.context.records[record.objectType] = currentTransaction.context.records[record.objectType] || {};
                currentTransaction.context.records[record.objectType][record.recordId] = Object.assign(currentTransaction.context.records[record.objectType][record.recordId] || {}, record);

                sourceRecords.push({
                  object: record.objectType,
                  id: record.recordId
                });
              }*/
              if (whatIdAllowedSObjects[record.objectType] || record.objectType === 'Lead' || record.objectType === 'Contact') {
               currentTransaction.context.records[record.objectType] = currentTransaction.context.records[record.objectType] || {};
               currentTransaction.context.records[record.objectType][record.recordId] = Object.assign(currentTransaction.context.records[record.objectType][record.recordId] || {}, record);

               sourceRecords.push({
                 object: record.objectType,
                 id: record.recordId
               });
             }
            });

            if (source) {
              currentTransaction.context.sources = currentTransaction.context.sources || {};
              currentTransaction.context.sources[source] = currentTransaction.context.sources[source] || [];
              currentTransaction.context.sources[source] = currentTransaction.context.sources[source].concat(sourceRecords);
            }

            if (records.length === 1 && records[0].recordId && transactionCall.log && (!preserveCallLogRelatedData || (!NONEOptionSelectable || preserveCallLogRelatedData) && ( (records[0].objectType === 'Lead' || records[0].objectType === 'Contact' || records[0].personAccount) && !transactionCall.log.whoId || records[0].objectType !== 'Lead' && records[0].objectType !== 'Contact' && !transactionCall.log.whatId ))) {
              if (records[0].personAccount) {
                transactionCall.log.whoId = records[0].PersonContactId;
              } else if (records[0].objectType === 'Lead' || records[0].objectType === 'Contact') {
                transactionCall.log.whoId = records[0].recordId;
              } else if (whatIdAllowedSObjects[records[0].objectType]) {
                transactionCall.log.whatId = records[0].recordId;
              }
            }
          }

          return state;
        });

      },
      setActiveCall: function(callId) {
        that.store.reduceStore(function(state) {
          var currentCall = state.phone.calls[callId] || state.phone.dialing[callId];

          state.phone.active = callId;

          if (currentCall) {
            state.transaction.active = currentCall.transactionId || '';
          }

          return state;
        });
      },
      popTask: function(taskId) {
        if (taskId) {
          thc.sforce.util.popURL({
            url: '/' + taskId,
            active: true
          });
        }
      },
      resetState: function() {
        that.store.reduceStore(function(state) {
          return getInitState();
        });
      },
      setTransactionCallComment: function(comment) {
        that.store.reduceStore(function(state) {
          var currentCall = state.phone.cleared[state.transaction.active] || state.phone.calls[state.phone.active] || {},//AÑADIDO
            transactionCall = state.phone.cleared[currentCall.transactionId] || state.phone.calls[currentCall.transactionId] || {};//AÑADIDO

          if (transactionCall.log) {
            transactionCall.log.description = comment;
          }

          return state;
        });
      },
      setTransactionWhoID: function(whoId) {
        that.store.reduceStore(function(state) {
          var currentCall = state.phone.cleared[state.transaction.active] || state.phone.calls[state.phone.active] || {},//AÑADIDO
            transactionCall = state.phone.cleared[currentCall.transactionId] || state.phone.calls[currentCall.transactionId] || {};//AÑADIDO

          if (transactionCall.log) {
            transactionCall.log.whoId = whoId;
          }

          return state;
        });
      },
      setTransactionWhatID: function(whatId) {
        that.store.reduceStore(function(state) {
          var currentCall = state.phone.cleared[state.transaction.active] || state.phone.calls[state.phone.active] || {},//AÑADIDO
            transactionCall = state.phone.cleared[currentCall.transactionId] || state.phone.calls[currentCall.transactionId] || {};//AÑADIDO

          if (transactionCall.log) {
            transactionCall.log.whatId = whatId;
          }

          return state;
        });
      },
      /**
       * Acepta/realiza la llamada en curso
       **
       * @author jmartinezpisson
       */
      confirmCall: function() {
        var phone = that.store.getState().phone;

        if (phone.calls[phone.active]) {
          that.actions.answerCall(phone.calls[phone.active]);
        } else if (phone.dialing[phone.active]) {
          that.actions.makeCall(phone.dialing[phone.active])
        }
      },
      /**
       * Responde la llamada pasada como parámetro
       **
       * @author jmartinezpisson
       * @param {Object} call - Llamada a aceptar. Si no se recibe, se toma por defecto la llamada activa
       * @param {String} call.cId - Call Id único de la llamada
       */
      answerCall: function(call) {
        var cId = call && call.cId ? call.cId : that.store.getState().phone.active;

        return thc.big.rest.answerCall({
            cid: cId
        }).catch(function(answerCallError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error realizando llamada: ' + answerCallError
              }
            });
          });
      },
      /**
       * Contesta a la llamada en curso pasados los segundos indicados
       **
       * @author jmartinezpisson
       * @param {Object} call - Llamada a aceptar. Si no se recibe, se toma por defecto la llamada activa
       * @param {String} call.cId - Call Id único de la llamada
       */
      autoAnswerCall: function(call, time) {
        var call = call || {},
            time = parseInt(time || 2, 0);

        if (call.cId && call.status === 'RINGING' && call.type === thc.CALL_TYPE.INBOUND) {
          scope.setTimeout(function() {
            var currentPhoneState = that.store.getState().phone,
                callToAnswer = currentPhoneState.calls[call.cId] || {};

                if(callToAnswer.status === 'RINGING') {
                  thc.big.rest.answerCall({
                    cid: call.cId
                  }).catch(function(answerCallError) {
                    console.log('Error autorespondiendo llamada ' + answerCallError);
                  });
                }
          }, time * 1000);
        }
      },
      /**
       * Realiza una llamada de consulta
       **
       * @author jmartinezpisson
       * @param {Object} consultationCall - Llamada a consultar
       * @param {String} call.calledDevice - Número de teléfono a marcar. Este se formatea mediante la librería PhoneNumber
       * @param {String} call.userInfo - Información adicional a incluir en la llamada. Si no se pasa, se toma el contexto de la transacción activa.
       */
      consultationCall: function(consultationCall) {
        var formattedNumber = formatPhoneNumber(consultationCall.calledDevice),
          consultCall = {
            calledDevice: formattedNumber.isValid ? formattedNumber.phoneNumber : consultationCall.calledDevice,
            userInfo: consultationCall.userInfo
          };

        // 1 - Actualizamos el estado de la aplicación, obteniendo además el contexto asociado a la llamada consultiva
        return that.store.reduceStore(function(state) {
          var currentTransaction = that.util.transaction.getCurrent(state);

          // 1.1 si la llamada consultiva no tiene userInfo, se le pasa el contexto de la transacción
          if (!consultCall.userInfo && currentTransaction && currentTransaction.context) {
            consultCall.userInfo = that.util.call.uui.stringifyContextRecordsAsUUI(currentTransaction.context.records);
          }

          // 1.2 - Se incluye la llamada en el listado de llamadas consultivas
          if (consultationCall.type === thc.PARTY_TYPE.CONFERENCE) {
            state.phone.conferencing.push(consultCall);
          } else {
            state.phone.consulting.push(consultCall);
          }

          return state;
        }).then(function() {
          // 2 - Se realiza la llamada de consulta al número marcado y con el contexto asociado
          return thc.big.rest.consultationCall({
            dialednumber: consultCall.calledDevice,
            userinfo: consultCall.userInfo
          }).catch(function(consultCallError) {
            return that.store.reduceStore(function(state){
              state.notifications.show = true;
              state.error = Object.assign(state.error, {
                  type: 'EVENT',
                  message: 'Error realizando llamada: ' + consultCallError
              });

              // Se borra la llamada del listado de consultas (Se realiza de esta manera ya que
              // el OnEventOriginated se gestiona antes de la resolución de la consulta a la API)
              if (consultationCall.type === thc.PARTY_TYPE.CONFERENCE) {
                state.phone.conferencing.pop();
              } else {
                state.phone.consulting.pop();
              }
              return state;
            });
          });
        });
      },
      transferCall: function() {
        thc.big.rest.transferCall().catch(function(transferError) {
          that.store.reduceStore({
            notifications: {
              show: true
            },
            error: {
              type: 'EVENT',
              message: 'Error realizando llamada: ' + transferError
            }
          });
        });
      },
      blindTransferCall: function(blindTransferCall) {
        var activeCall = that.util.call.getCurrent(),
          state = that.store.getState(),
          phone = state.phone,
          currentTransaction = that.util.transaction.getCurrent(state) || {},
          formattedNumber = formatPhoneNumber(blindTransferCall.transferTo),
          blindTransfer = {
            transferTo: formattedNumber.isValid ? formattedNumber.phoneNumber : blindTransferCall.transferTo,
            userInfo: blindTransferCall.userInfo
          };

        if (!blindTransfer.userInfo && currentTransaction && currentTransaction.context) {
          blindTransfer.userInfo = that.util.call.uui.stringifyContextRecordsAsUUI(currentTransaction.context.records);
        }

        thc.big.rest.blindTransferCall({
            transferto: blindTransfer.transferTo,
            dialednumber: blindTransfer.transferTo,
            number: blindTransfer.transferTo,
            userinfo: blindTransfer.userInfo,
            cid: phone.active,
            sessionid: phone.active
          })
          .catch(function(blindTransferError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error realizando llamada: ' + blindTransferError
              }
            });
          });
      },
      rescheduleCall: function() {
        var formattedNumber,
          rescheduleParams = {},
          reschedule = that.util.transaction.getCurrent().reschedule;
        if (reschedule.diffNumber) {
          formattedNumber = formatPhoneNumber(reschedule.number);
          if (formattedNumber.isValid) {
            rescheduleParams = {
              phone: formattedNumber.phoneNumber
            };
          }
        }

        Object.assign(rescheduleParams, {
          captured: reschedule.captured,
          scheduledate: moment(reschedule.date + ' ' + reschedule.timeHour + ':' + reschedule.timeMinute, 'DD/MM/YYYY HH:mm').utc().format('DD/MM/YYYY HH:mm')
        });

        thc.big.rest.rescheduleContact(rescheduleParams).then(function() {
            that.actions.updateTask();
            that.actions.cancelRescheduleCall();
          })
          .catch(function(rescheduleCallError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error reprogramando llamada: ' + rescheduleCallError
              }
            });
          });
      },
      popCreateRecord: function(sObjectType) {
        createRecord(sObjectType, that.util.call.getCurrent());
      },
      popSearch: function(searchString) {
        thc.sforce.util.screenPopSearch({
          searchString: searchString
        });
      },
      clearCall: function() {
        var phone = that.store.getState().phone;
        thc.big.rest.clearCall({
            cid: phone.active
          })
          .catch(function(clearCallError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error colgando llamada: ' + clearCallError
              }
            });
          });
      },
      getQCode: function(serviceId) {
        var reasons = {};

        thc.big.rest.getQCode({
            serviceID: serviceId
          })
          .then(function(result) {
            var formattedResult = that.util.services.formatWrapups(result, 'description', 'code');
            reasons[serviceId] = formattedResult;
            that.store.reduceStore({
              services: {
                wrapups: reasons
              }
            });
          }).catch(function(error) {
            logger.log(logger.LOG_TYPE.ERROR, 'Error en getQCode', error);
          });
      },
      setQCode: function(reason) {
        thc.big.rest.setQCode({
            codeq: reason
          })
          .then(function(result) {
            // basura
          }).catch(function(error) {
            logger.log(logger.LOG_TYPE.ERROR, 'Error en setQCode', error);
          });
      },
      resumeCall: function() {
        var phone = that.store.getState().phone;
        thc.big.rest.retrieveCall({
            cid: phone.active
          })
          .catch(function(resumeCallError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error resumiendo llamada: ' + resumeCallError
              }
            });
          });
      },
      holdCall: function() {
        var phone = that.store.getState().phone;
        thc.big.rest.holdCall({
            cid: phone.active
          })
          .catch(function(answerCallError) {
            that.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error pausando llamada: ' + answerCallError
              }
            });
          });
      },
      acceptPreviewCall: function(cId) {
        var phone = that.store.getState().phone;
        phone.calls[cId] = Object.assign(phone.calls[cId] || {}, {
          sessionStatus: 'PREVIEW',
        });
        that.store.reduceStore({
          phone: phone
        });
      },
      rejectPreviewCall: function(cId) {
        var phone = that.store.getState().phone;
        phone.calls[cId] = Object.assign(phone.calls[cId] || {}, {
          sessionStatus: '',
        });
        that.store.reduceStore({
          phone: phone
        });
      },
      makeCall: function(dialingCall) {
        var phone = that.store.getState().phone,
          newCall = dialingCall || phone.dialing[phone.active],
          internalBinary = that.util.call.isInternal({
            type: thc.CALL_TYPE.OUTBOUND,
            dnis: newCall.calledDevice
          }) ? "0" : "1",
          formattedNumber = formatPhoneNumber(newCall.calledDevice);

        thc.big.rest.makeCall({
          dialednumber: formattedNumber.isValid ? formattedNumber.phoneNumber : newCall.calledDevice,
          userinfo: ''
        }).catch(function(makeCallError) {
          that.store.reduceStore({
            notifications: {
              show: true
            },
            error: {
              type: 'EVENT',
              message: 'Error realizando llamada: ' + makeCallError
            }
          });

          return Promise.reject(makeCallError);
        });

      },
      setCallResult: function(callResult) {
        that.store.reduceStore(function(state) {
          var currentCall = state.phone.calls[state.phone.active],
            currentTransaction = state.transaction.list[currentCall.transactionId],
            transactionCall = state.phone.calls[currentCall.transactionId] || {};

          if (typeof callResult === 'string') {
            currentTransaction.callResult = callResult;

            if (currentCall.log) {
              currentCall.log.disposition = callResult;
            }
          } else {
            var callResultObject = Object.assign(typeof currentTransaction.callResult === 'object' ? currentTransaction.callResult : {}, callResult);

            currentTransaction.callResult = callResultObject;
            if (currentCall.log) {
              currentCall.log.disposition = callResultObject;
            }
          }

          return state;
        });
      },
      setCallResultPath: function(path) {
        that.store.reduceStore(function(state) {
          //var currentTransaction = state.transaction.list[state.transaction.active];// TODO: Â¿Es correcto? Si hay más de una transacción...
          var currentTransaction = state.transaction.list[state.transaction.active];

          currentTransaction.callResultPath = path;

          return state;
        });
      },
      closeNotification: function() {
        that.store.reduceStore({
          notifications: {
            show: false,
            message: false,
            record: null,
            type: null
          },
          error: {
            type: '',
            message: ''
          }
        });
      },
      showNotification: function(message) {
        that.store.reduceStore({
          notifications: {
            show: true,
            message: message
          },
          error: {
            type: '',
            message: ''
          }
        });
      },
      /**
       * Colapsa/expande el teclado del softphone
       **
       * @author jmartinezpisson
       */
      toggleDialPad: function() {
        that.store.reduceStore(function(state) {
          state.ui.isDialPadOpened = !state.ui.isDialPadOpened ? true : false;

          return state;
        });
      },
      /**
       * Colapsa/expande las últimas llamadas
       **
       * @author jarina
       */
      toggleLastCalls: function() {
        that.store.reduceStore(function(state) {
          state.ui.isMyLastCallsOpened = !state.ui.isMyLastCallsOpened;

          if (state.ui.isMyLastCallsOpened) {
            state.ui.isCampaignsOpened = false;
          }

          return state;
        });
      },
      /**
       * Colapsa/expande el panel de información de la llamada
       **
       * @author jmartinezpisson
       */
      toggleCallInfo: function() {
        that.store.reduceStore(function(state) {
          state.ui.isCallInfoOpened = !state.ui.isCallInfoOpened ? true : false;

          return state;
        });
      },
      /**
       * Ejecuta un acción de botón personalizado. Generalmente, solo existen botones personalizados en Presence
       **
       * @author jmartinezpisson
       * @param args {Object} Argumnentos de la llamada
       * @param args.id {String} id del botón personalizado a ejecutar
       */
      executeCustomAction: function(args) {
        if (args.id) {
          thc.big.rest.executeCustomButton({
            custombuttonid: args.id
          }).then(function(result) {
            that.store.reduceStore({
              notifications: {
                show: true,
                message: 'Acción ejecutada correctamente.',
                type: 'success'
              }
            });
          }).catch(function(error) {
            that.store.reduceStore({
              notifications: {
                show: true,
                message: error,
                type: 'error'
              }
            });
          });
        }
      },
      /**
       * Filtra las acciones personalizadas disponibles en base a la cadena de búsqueda
       **
       * @author jmartinezpisson
       * @param args {Object} Argumnentos de la llamada
       * @param args.searchString {String} Texto a buscar
       */
      searchCustomAction: function(args) {
        that.store.reduceStore(function(state) {
          state.ui.customActionsControl.filter = args.searchString ? args.searchString : '';
          return state;
        });
      },
      /**
       * Muestra/Oculta el panel de acciones personalizadas
       **
       * @author jmartinezpisson
       */
      toggleCustomActions: function(forcedClose) {
        that.store.reduceStore(function(state) {
          state.ui.customActionsControl = state.ui.customActionsControl || {};
          state.ui.customActionsControl.isOpened = forcedClose ? false : !state.ui.customActionsControl.isOpened;
          if(state.ui.isRecordingOpened){
            state.ui.isRecordingOpened = false;
          }
          return state;
        });
      },

      //actions recording
      toggleRecordingControl: function(forcedClose){
        that.store.reduceStore(function(state) {
          state.ui.isRecordingOpened = forcedClose ? false : !state.ui.isRecordingOpened;
          if(state.ui.customActionsControl){
            if(state.ui.customActionsControl.isOpened){
              state.ui.customActionsControl.isOpened = false;
            }
          }
          return state;
        });
      },
      pauseRecording:function(){
        return thc.big.rest.pauseRecording();
      },
      continueRecording: function(){
        return thc.big.rest.startRecording();
      },
      stopRecording: function(){
        return thc.big.rest.stopRecording();
      },


      /**
       * Colapsa/expande el panel de detalle la llamada
       **
       * @author jmartinezpisson
       */
      toggleCallDetailCard: function() {
        that.store.reduceStore(function(state) {
          state.ui.isCallDetailCardOpened = !state.ui.isCallDetailCardOpened ? true : false;

          return state;
        });
      },
      /**
       * Colapsa/expande el panel Sin resultados de la llamada
       **
       * @author jmartinezpisson
       */
      toggleNoResultsPanel: function() {
        that.store.reduceStore(function(state) {
          state.ui.isNoResultsPanelOpened = !state.ui.isNoResultsPanelOpened ? true : false;

          return state;
        });
      },
      reduceRescheduleCall: function(data) {
        var pObj = {},
          currentState = that.store.getState(),
          transactions = currentState.transaction,
          transaction = transactions.list[transactions.active];

        pObj[that.util.transaction.getCurrent(currentState).campaignId] = {
          root: {
            'reschedule call': 'rescheduled'
          }
        };
        // reschedule = data;
        transaction = Object.assign(transaction || {}, {
          reschedule: data
        });
        that.store.reduceStore({
          transaction: transactions,
          services: {
            wrapups: pObj
          }
        });

        that.actions.setCallResult({
          root: 'rescheduled'
        });
        that.actions.setCallResultPath([]);

      },
      /**
       * Elimina una línea de marcado
       **
       * @author jarina
       * @param {Integer} line - Línea a eliminar
       */
      removeLine: function(line) {
        that.store.reduceStore(function(state) {
          var dialingCallLine = state.phone.dialing[line]

          if (dialingCallLine && dialingCallLine.status === 'STANDBY') {
            if (state.phone.dialing.length > 1) {
              state.phone.active = '0';
            } else if (Object.keys(state.phone.calls).length > 0) {
              state.phone.active = Object.keys(state.phone.calls)[0];
              state.transaction.active = state.phone.calls[state.phone.active].transactionId || '';
            }
            state.phone.dialing.splice(line, 1);
          } else {
            logger.log(logger.LOG_TYPE.ERROR, 'Error en removeLine (línea ocupada?)');
          }

          return state;
        });
      },
      /**
       * Marca un número sobre la llamada en curso, diferenciando si la llamada se encuentra en curso o no existe llamada actual.
       **
       * @author jmartinezpisson
       * @param {String} number - Número a marcar. Puede ser un caracter especial
       */
      dial: function(number) {
        that.store.reduceStore(function(state) {
          var call = that.util.call.getCurrent(state);

          if (call) {
            if (call.status !== 'STANDBY') {

              return thc.big.rest.sendDtmf({
                dtmf: number || '',
                sessionid: call.cId
              }).catch(function(error) {
                state.notifications.show = true;
                state.error = {
                  type: 'EVENT',
                  message: 'Error: ' + error
                };

              }).then(function() {
                return state;
              });

            } else {
              call.calledDevice = (number.length > 1 ? '' : call.calledDevice) || '';

              if (number === 'C') {
                call.calledDevice = call.calledDevice.length > 0 ? call.calledDevice.substring(0, call.calledDevice.length - 1) : '';
              } else if (number === 'CLEAR') {
                call.calledDevice = '';
              } else if (number === '10') {
                call.calledDevice += '*';
              } else if (number === '11') {
                call.calledDevice += '#';
              } else {
                call.calledDevice += number;
              }
            }
          }

          return state;
        });
      },
      /**
       * Envia una secuencia de tonos a la llamada actual
       **
       * @author jmartinezpisson
       * @param {String} number - Número a marcar. Puede ser un caracter especial
       */
      dtmf: function(number) {
        return thc.big.rest.sendDtmf({
          dtmf: number || ''
        }).catch(function(error) {
          that.actions.showNotification(error);
        });
      },
      /**
       * Muestra la modal de opciones de transferencia de llamada
       **
       * @author amartinez
       */
      showTransferModal: function(type) {
        that.store.reduceStore({
          transfer: {
            type: type
          },
          ui: {
            isTransferModalShown: true
          }
        });
      },
      /**
       * Oculta la modal de opciones de transferencia de llamada
       **
       * @author amartinez
       */
      hideTransferModal: function(type) {
        that.store.reduceStore({
          ui: {
            isTransferModalShown: false
          }
        });
      },
      /**
       * Muestra la modal de replanificación de transacción
       **
       * @author jarina
       */
      showRescheduleModal: function() {
        that.store.reduceStore({
          ui: {
            isRescheduleModalShown: true
          }
        });
      },
      /**
       * Oculta la modal de replanificación de transacción
       **
       * @author jarina
       */
      hideRescheduleModal: function() {
        that.store.reduceStore({
          ui: {
            isRescheduleModalShown: false
          }
        });
      },
      /**
       * Muestra el filtro de búsqueda sobre campañas
       **
       * @author amartinez
       */
      showCampaignSearchFilter: function() {
        that.store.reduceStore({
          ui: {
            isCampaignFilterShown: true
          }
        });
      },
      /**
       * Oculta el filtro de búsqueda sobre campañas
       **
       * @author amartinez
       */
      hideCampaignSearchFilter: function() {
        that.store.reduceStore({
          ui: {
            isCampaignFilterShown: false
          }
        });
      },
      /**
       * Cancel la replanificación de la llamada en curso
       **
       * @author jarina
       */
      cancelRescheduleCall: function() {
        return that.store.reduceStore(function(state) {
          var currentTransaction = that.util.transaction.getCurrent(state) || {};

          // 1  - Por seguridad, se elimina el valor Reeschedule Call del árbol de resultado de llamadas
          if (currentTransaction && state.services && state.services.wrapups &&
            state.services.wrapups[currentTransaction.campaignId] && state.services.wrapups[currentTransaction.campaignId].root
          ) {
            delete state.services.wrapups[currentTransaction.campaignId].root['reschedule call'];
            that.actions.setCallResultPath(['root']);
          }

          currentTransaction.reschedule = {
            date: '',
            timeHour: '',
            timeMinute: '',
            limitHour: '',
            limitMinute: '',
            isLimitOpened: false,
            captured: 0,
            diffNumber: false,
            number: '',
            saved: false
          };

          return state;
        });
      },
      /**
       * Realiza una búsqueda en Salesforce sobre los objetos para los cuales se puede transferir una llamada
       **
       * @author amartinez
       * @param {String} searhString - Cadena de texto a buscar
       * @param {Array<String>} types - Objetos de Salesforce sobre los que realizar la búsqueda
       */
      searchTransferAgenda: function(searchString, types) {
        var searchTransferPromise = Promise.resolve({}),
          searchResults = null,
          searchErrors = null;

        if (searchString && searchString.length > 2) {
          searchTransferPromise = thc.sforce.controller.searchAgenda(searchString, types || ['User', 'AdditionalNumber']);
        }

        that.store.reduceStore({
          transfer: {
            isSearching: true
          }
        });

        searchTransferPromise.then(function(results) {
          searchResults = results;
        }).catch(function(errors) {
          searchErrors = errors;
        }).then(function() {
          that.store.reduceStore(function(state) {
            state.transfer = Object.assign(state.transfer || {}, {
              isSearching: false,
              searchResults: searchResults
            });

            if (searchErrors && searchErrors.length) {
              state.error.type = 'EVENT';
              state.error.message = 'Error: ' + searchErrors.join(', ');
              state.notifications.show = true;
            }

            return state;
          });
        });
      },
      searchAgenda: function(searchString) {
        if (searchString && searchString.length > 2) {
          thc.sforce.controller.searchAgenda(searchString, ['Account', 'Contact', 'Lead', 'User'])
            .then(function(searchResults) {
              that.store.reduceStore(function(state) {
                state.agenda = {
                  isSearching: false,
                  searchResults: searchResults
                };

                return state;
              });
            })
            .catch(function(errors) {
              that.store.reduceStore({
                agenda: {
                  isSearching: false,
                  searchResults: {}
                },
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error: ' + errors.join(', ')
                }
              });
            });

          that.store.reduceStore({
            agenda: {
              isSearching: true
            }
          });
        } else {
          that.store.reduceStore(function(state) {
            state.agenda = {
              searchResults: {},
              isSearching: false
            };

            return state;
          });
        }
      },
      deleteCall: function(cId) {
        var currentState = that.store.getState(),
          phone = currentState.phone,
          transaction = currentState.transaction,
          call = phone.calls[cId],
          callTransaction = call ? transaction.list[call.transactionId] : {};

        // 1 - Solo eliminamos la llamada si existe y estado en un estado inactivo
        if (call && (call.status === 'CLEARED' || call.status === 'TRANSFERRED')) {
          // 2 - Historificamos la llamada y la eliminamos de las llamadas activas
          phone.cleared[call.cId] = call;
          delete phone.calls[cId];

          // 3 - Si la llamada eliminada es la activa, se necesita reasignar
          if (phone.active === cId) {
            // 3.1 - Si quedan más llamadas activasa, asignamos la inicial
            if (!util.object.isEmpty(phone.calls)) {
              phone.active = Object.keys(phone.calls)[0];
              transaction.active = phone.calls[phone.active].transactionId || '';
              // 3.2 - Si existe alguna línea abierta, se selecciona
            } else if (phone.dialing.length) {
              phone.active = '0';
              transaction.active = phone.dialing[phone.active].transactionId || '';
              // 3.3 - En caso contrario, se añade una línea por defecto
            } else {
              phone.dialing.push({
                calledDevice: '',
                status: 'STANDBY'
              });
              phone.active = '0';
              transaction.active = '';
            }
          }

          // 4 - Se actualiza la transacción, eliminándola si se encuentra en CLEARED
          // (Por defecto, reduceStore no elimina valores)
          if (callTransaction && callTransaction.status === thc.TRANSACTION_STATUS.CLEARED) {
            transaction.list[callTransaction.id];
          }

          that.store.reduceStore(function(state) {
            state.phone = phone;
            state.transaction = transaction;

            return state;
          });
        }
      },
      updateTask: function() {
        return that.store.reduceStore(function(state) {
          var phone = state.phone,
            currentCall = phone.calls[phone.calls[phone.active].transactionId],
            // var currentCall = state.phone.calls[state.phone.active],
            currentTransaction = state.transaction.list[currentCall.transactionId],
            transactionCallResult = currentTransaction.callResult;

          // 1 - Se actualiza la tarea
          return that.util.call.log.end(currentCall).then(function(task) {
            // 2 - Se muestra una notificacción con el id de la tarea generada
            state.notifications = {
              show: true,
              message: $Label.Tarea_actualizada + ' (' + task.taskId + ')',
              type: 'task',
              record: task.taskId
            };
            state.error.type = '';
            state.error.message = '';

            // 3 - Si la transacción es de tipo llamada, y es la principal, se elimina también la transacción
            if (currentTransaction.id === currentCall.cId && currentTransaction.type == thc.TRANSACTION_TYPE.CALL) {
              delete state.transaction.list[currentTransaction.id];
            }

            // 4 - La llamada cerrada debe eliminarse del listado de Llamadas

            state.phone.cleared[currentCall.cId] = currentCall;
            delete state.phone.calls[currentCall.cId];


            // 5 - Se marca la llamada activa, y se añade la por defecto si aplica
            state.phone.active = that.util.phone.getActiveCall(state.phone);

            if (!state.phone.active && state.phone.active !== '0') {
              state.phone.dialing.push({
                calledDevice: '',
                status: 'STANDBY'
              });
              state.transaction.active = '';
              state.phone.active = '0';
            }else{
              state.transaction.active = state.phone.calls[state.phone.active].transactionId || '';
            }

            return state;
          }).catch(function(error) {
            state.notifications = {
              show: true,
              type: 'error',
              message: error
            };

            return state;
          });
        });
      },
      getLogoutReasons: function() {
        return [];
      },
      getStatusCalls: function() {
        thc.big.rest.getStatusCalls().then(function(response) {
          that.actions.processStatusCalls(response.extension, response.calls);
        });
      },
      ring: function() {
        var ringOnCall = thc.settings.get().callcenter.softphone.ringOnCall,
          ringingAudio = thc.settings.get().audio.ringing;

        if (ringOnCall) {
          ringingAudio.play();
        }

        return Promise.resolve();
      },
      processStatusCalls: function(extension, calls) {
        var phone = that.store.getState().phone,
          currentCallIds = {};

        // 1 - Calls
        calls.forEach(function(call) {
          // 1.1 Si la llamada no existe
          if (!phone.calls[call.cid]) {
            phone.calls[call.cid] = {
              cId: call.cid,
              uCId: call.ucid,
              deliveringAcd: call.deliveringacd,
              userInfo: call.userinfo || {},
              dnis: call.servicecall && call.contact ? call.contact.phone : call.calleddevice,
              ani: call.callingdevice,
              answeringDevice: call.answeringdevice,
              redDevice: call.reddevice,
              queueTime: call.queuetime,
              callTime: 0,
              type: extension === call.callingdevice ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND,
              context: {},
              holdTime: 0,
              serviceCall: call.servicecall
            };
          }

          if (call.connectionstate === 'TALKING' || call.connectionstate === 'ACTIVE' || call.state === 3) {
            phone.calls[call.cid].status = phone.calls[call.cid].status || 'ESTABLISHED';
          } else if (call.connectionstate === 'HELD' || call.state === 5) {
            phone.calls[call.cid].status = 'HELD';
          } else if (call.state === 2 || call.state === 4) {
            phone.calls[call.cid].status = 'RINGING';
          } else {
            phone.calls[call.cid].status = 'UNKNOWN';
          }

          currentCallIds[call.cid] = true;
        });

        // 2 - Aquellas llamadas finalizadas, se verifica si existe un log asociado en cuyo caso se pasa al estado cleared. Si no es así, se elimina
        util.object.forEach(phone.calls, function(cId, call) {
          if (!currentCallIds[cId]) {
            if (call.log && call.log.taskId) {
              call.status = 'CLEARED';
            } else {
              delete phone.calls[cId];
            }
          }
        });

        return that.store.reduceStore({
          phone: phone
        }, that.callTreeReducer);
      },
      /**
       * Colapsa/expande el panel de selección de campañañs/servicios
       **
       * @author jarina
       */
      toggleServices: function() {
        that.store.reduceStore(function(state) {
          state.ui.isCampaignsOpened = !state.ui.isCampaignsOpened;

          if (state.ui.isCampaignsOpened) {
            state.ui.isMyLastCallsOpened = false;
          }

          return state;
        });
      },
      filterCampaigns: function(text) {
        that.store.reduceStore({
          ui: {
            campaignsFilter: text
          }
        });
      },
      saveState: function() {
        saveStateToStorage(that.store.getState(), true);
      },
      loadState: function() {
        var state = loadStateFromStorage();

        that.store.reduceStore(loadStateFromStorage());
      },
      /**
       * Inicializa la aplicación. Debe sobreescribirse para cada controlador
       **
       * @author jmartinezpisson
       * @param args {Object} Argumnentos de la llamada
       * @param args.onLoadedState {Function}
       * @param args.onForcedExtension {Function}
       * @param args.onAutoLogin {Function}
       */
      init: function(args) {
        // 1 - Se carga el estado inicial
        var loadedState = loadStateFromStorage(),
          autoLogin = thc.settings.get().login.auto;

        if (!util.object.isEmpty(loadedState) && loadedState.session && loadedState.session.isLogged) {
          // 1.1 - Se reasignan las variables expuestas del estado al controlador y se recarga el estado
          loadedState.ui.isStateChanging = false;
          loadedState.overlay = {
            show: true,
            message: $Label.Softphone_Loading_thinkConnect
          };

          if (args && args.onLoadedState) {
            args.onLoadedState(loadedState);
          }

          that.store.reduceStore(loadedState);

          // 1.2 - Si se mantiene sesión del estado anterior, se debe reconectar con CometD. El onHandshakeSuccess de cada centralita realizará el resto
          thc.big.start({
            extension: loadedState.session.extension,
            username: loadedState.session.username,
            password: loadedState.session.password,
            isRestart: true
          });
        } else {
          // 2 - Si en el estado no tenemos sesión iniciada, se lanza el autologin y la extensión forzada
          if (autoLogin) {
            that.store.reduceStore({
              overlay: {
                show: true,
                message: $Label.Softphone_Autologin_loading
              }
            });
          }

          thc.big.rest.getForcedExtension().catch(function(error) {
            return '';
          }).then(function(forcedExtension) {
            that.store.reduceStore({
              login: {
                forcedExtension: forcedExtension
              }
            });

            if (autoLogin) {
              thc.sforce.controller.getCredentials().then(function(credentials) {
                // if (forcedExtension) {
                //   credentials.extension = forcedExtension;
                // }

                if ($.isEmptyObject(credentials) || (!$.isEmptyObject(credentials) && !credentials.extension && !credentials.password && !credentials.username)) {
                  that.store.reduceStore({
                    overlay: {
                      show: false
                    }
                  });
                  return;
                }

                thc.controller.actions.login(Object.assign(credentials, {
                  source: 'autologin'
                }));

                if (args && args.onAutoLogin) {
                  args.onAutoLogin();
                }
              });
            }
          });
        }
      },
      clickToDial: function(callId, recordId) {
        var state = that.store.getState();
        var phone = state.phone;
        var call = that.util.call.getCurrent(state);
        var isClickToConsult = call ? (call.status === 'ESTABLISHED' || call.status === 'HELD') : false;
        var newCall = {
          cId: callId,
          dnis: callId,
          calledDevice: callId,
          isClickToDial: true,
          status: "STANDBY",
          clickToDialRecordId: recordId
        };

        //1.1 consultation call
        if (isClickToConsult && thc.settings.get().callcenter.softphone.clickToConsult) {
          return thc.controller.actions.consultationCall(newCall); //datos llamada
        } else {
          // 1.2 Se añade la línea y se realiza la llamada
          return that.store.reduceStore(function(state) {
            if (state.phone.dialing[state.phone.active] && state.phone.dialing[state.phone.active].calledDevice) {
              state.phone.dialing.push(newCall);
              state.phone.active = "" + (state.phone.dialing.length - 1);
            } else {
              state.phone.dialing[state.phone.active] = newCall;
            }
            return state;
          }).then(function() {
            return thc.controller.actions.makeCall({
              calledDevice: callId
            });
          });
        }
      },
      conference: function() {
        var transaction = that.util.transaction.getCurrent();

        thc.big.rest.conference({
          cid: transaction.id //sessionid: transaction.id
        }).catch(function(transferError) {
          that.store.reduceStore({
            notifications: {
              show: true
            },
            error: {
              type: 'EVENT',
              message: 'Error realizando conferencia: ' + transferError
            }
          });
        });
      }
    };

    return that;
  }
  // Exports del módulo
  scope.thc.big.registerControllerMixin = function(name, mixin) {
    mixins[name] = mixin;
  };
  scope.thc.init = function(settings) {
    scope.thc.controller = (function() {
      var controller = bigController(),
        providerExtensions,
        providerController = {};

      if (settings.provider && mixins[settings.provider]) {
        providerExtensions = mixins[settings.provider](controller);

        for (var extension in providerExtensions) {

          if (providerExtensions.hasOwnProperty(extension)) {

            if (typeof(providerExtensions[extension]) === 'object' && controller.hasOwnProperty(extension)) {

              for (var inheritableProperty in controller[extension]) {

                if (controller[extension].hasOwnProperty(inheritableProperty) &&
                  !providerExtensions[extension].hasOwnProperty(inheritableProperty)
                ) {
                  providerExtensions[extension][inheritableProperty] = controller[extension][inheritableProperty];
                }
              }
            }
          }
        }

        return providerExtensions;
      }

      return controller;
    })();

    thc.big.init({
      events: scope.thc.controller.events,
      endpoints: settings.endpoints,
      siteId: settings.siteId,
      linkType: settings.linkType,
      getOAuthCredentials: thc.sforce.controller.getOAuthCredentials
    });

    thc.controller.actions.init();
  };
})(window, window.thc.util, thc.Store, window.sforce, window.console, window.logger, window.jQuery);
