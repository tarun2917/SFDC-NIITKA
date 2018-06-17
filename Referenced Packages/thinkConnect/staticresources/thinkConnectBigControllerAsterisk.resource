(function(scope, document, sforce, console, localStorage, $) {
  'use strict';

  if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
    throw new Error('Big controller module not defined');
  }

  scope.thc.big.registerControllerMixin('asterisk', function(controller) {
    var base = controller;

    var storeInit = {
      ui: {
        isCampaignsEnabled: false,
        isAgentStatePanel: false
      }
    };

    // Controller Extension
    return {
      actions: {
        login: function(credentials) {
          // 1 - Se desconecta por precaución CometD
          thc.big.stop();

          // 2 - Se procesa el formulario de login y se almacena en el estado
          if (credentials.extension) {
            return base.store.reduceStore(Object.assign(storeInit, {
                isLoading: true,
                error: {
                  type: "LOGIN",
                  message: undefined
                },
                session: {
                  extension: credentials.extension
                }
              })).then(function(){
                  thc.big.start({
                    extension: credentials.extension
                  });
            });

            // El login se gestiona directamente al obtenr la conexión
          } else {
            return base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: scope.$Label.Softphone_introduce_data
              }
            });
          }
        },
        logout: function() {
          // 1 - Se desconecta CometD
          return thc.big.rest.monitorStop()
            .then(function(logoutResult) {
              thc.big.stop();

              // 0 - integración omnichannel
              //base.util.integration.listeners.removeEventListeners();  //se necesita para carga trabajo  (hay estado en asterisk?)

              var state = base.store.getState(),
              phone = state.phone,
              transaction = state.transaction;

              phone.calls = {};
              phone.cleared = {};
              phone.dialing.length = 0;
              phone.active = '';
              phone.consulting = [];
              phone.conferencing = [];
              
              transaction.list = {};
              transaction.active = '';

              return base.store.reduceStore(function(state) {
                state.phone = phone;
                state.transaction = transaction;
                state.myLastCalls = [];
                state.isLoading = false;
                state.session = Object.assign(state.session, {
                  isLogged: false
                });
                state.overlay = Object.assign(state.overlay, {
                  show: false
                });
                state.error = {
                  message: '',
                  type: ''
                }
                return state;
              });

            })
            .catch(function(logoutError) {
              return base.store.reduceStore({
                notifications: {
                  show: true,
                  message: 'Error haciendo logout: ' + logoutError,
                  type: 'warning'
                }
              });
            });
        },
        consultationCall: function(consultationCall) {
          var formattedNumber = base.util.call.formatPhoneNumber(consultationCall.calledDevice),
          activeCall = base.util.call.getCurrent(),
          cid = activeCall.cId,
          //DEMO active y cid
            consultCall = {
              calledDevice: formattedNumber.isValid ? formattedNumber.phoneNumber : consultationCall.calledDevice,
              userInfo: consultationCall.userInfo
            };

          // 1 - Actualizamos el estado de la aplicación, obteniendo además el contexto asociado a la llamada consultiva
          return base.store.reduceStore(function(state) {
            var currentTransaction = base.util.transaction.getCurrent(state);

            // 1.1 si la llamada consultiva no tiene userInfo, se le pasa el contexto de la transacción
            if (!consultCall.userInfo && currentTransaction && currentTransaction.context) {
              consultCall.userInfo = base.util.call.uui.stringifyContextRecordsAsUUI(currentTransaction.context.records);
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
              userinfo: consultCall.userInfo,
              cid: ''
              //DEMO cid: ''
            }).catch(function(consultCallError) {
              return base.store.reduceStore(function(state){
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
          var activeCall = base.util.call.getCurrent(),
          cid = activeCall.cId;

          return thc.big.rest.transferCall({
            cid: ''
          }).then(function(){
             return base.store.reduceStore(function(state) {
              var phone = state.phone;
              
              // 1 si la llamada consultiva existe
              if (phone.calls[cid]) {
                  // 1.1 - Se elimina la llamada transferida así como la transacción asociada
                  phone.cleared[cid] = phone.calls[cid];
                  delete phone.calls[cid];
                  if( state.transaction.list[cid]){
                    state.transaction.list[cid].status = thc.TRANSACTION_STATUS.CLEARED;
                  }
                  state.transaction.active = '';
              }

              var callKeys = Object.keys(phone.calls);

              if (callKeys.length === 0 && phone.dialing.length === 0) {
                  state.transaction.active = '';
                    phone.active = '0';
                    phone.dialing.push({
                      calledDevice: '',
                      status: 'STANDBY'
                  });
              }
              else {
                if(callKeys.length !== 0) {
                  phone.active = callKeys[0];
                  state.transaction.active = phone.calls[callKeys[0]].transactionId || callKeys[0];
                }
                else if(phone.dialing.length !== 0) {
                  phone.active = '0';
                  state.transaction.active = '';
                }
              }

              return state;
            });

          }).catch(function(transferError) {
            return base.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error realizando transferencia: ' + transferError
              }
            });
          });
        }, 
        conference: function() {
          // var transaction = base.util.transaction.getCurrent();
          return thc.big.rest.conference({
            cid: ''
            // transaction.id
          }).catch(function(transferError) {
            return base.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error realizando conferencia: ' + transferError
              }
            });
          });
        },
        resumeCall: function() {
          var phone = base.store.getState().phone,
          alternate = false;
          for(var id in phone.calls){
            if(id !== phone.active && phone.calls[id].status === 'ESTABLISHED'){
              alternate = true;
              break;
            }
          }
          if(alternate){
            return thc.big.rest.alternateCall({
              cid: ''
            })
            .catch(function(alternateCallError) {
              return base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error alternando llamada: ' + alternateCallError
                }
              });
            });

          }else{
            return thc.big.rest.retrieveCall({
              cid: phone.active
            })
            .catch(function(resumeCallError) {
              return base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error resumiendo llamada: ' + resumeCallError
                }
              });
            });
          } 
        },
        getStatusCalls: function() {
          return thc.big.rest.getStatusCalls()
            .then(function(response) {
              console.log('GET STATUS');
              console.log(response);


              var state = base.store.getState();
              var phone = state.phone;
              var transactions = state.transaction;

              var callsPrev = base.store.getState().phone.calls;
              var transactionsPrev = base.store.getState().transaction.list;
              var callsAfter = [];
              var callKeys;
              var noMatched = [];


              response.calls.forEach(function(call) {
                var status = '',
                isInbound = state.session.extension === call.calleddevice,
                partydevices = call.partydevices ? JSON.parse(call.partydevices) : '',
                newCall, transaction;
                callsAfter.push(call.cid+'');

                // Indicamos el estado de la llamada
                switch (call.connectionstate) {
                  case 'RINGING':
                    status = 'RINGING';
                    break;
                  case 'TALKING':
                    status = 'ESTABLISHED';
                    break;
                  case 'HOLD':
                    status = 'HELD';
                    break;

                  default:
                    status = 'UNKNOWN';
                }

                newCall = {
                  cId: '' + call.cid,
                  ucid: call.ucid,
                  status: status,
                  reserved: call.reserved,
                  type: isInbound ? thc.CALL_TYPE.INBOUND : thc.CALL_TYPE.OUTBOUND,
                  ani: call.callingdevice.split(' ')[0].replace(/"/g, '') || '-',
                  dnis: '' + call.calleddevice || '-'
                };

                // Creamos una transaccion de tipo llamada
                transaction = {
                  id:  '' + call.cid,
                  type: thc.TRANSACTION_TYPE.CALL
                };

                 // Guardamos la llamada y la transaccion
                if(Object.keys(callsPrev).includes(call.cid+'')){
                  phone.calls[call.cid+''] = Object.assign({}, callsPrev[call.cid+''], newCall);
                  transactions.list[call.cid+''] = Object.assign({}, transactionsPrev[call.cid+''], transaction);
                }
                else{
                  noMatched.push(call.cid +'');
                  //Si no existía previo al realizar getStatusCalls, no se le asigna transacción, pues no existe ninguna tarea asociado a la llamada
                  // delete newCall.transactionId;
                  newCall = Object.assign(newCall, {callTime: 0, holdTime: 0, lastUpdated: new Date()});
                  phone.calls[call.cid+''] = newCall;
                }

                // Y en el caso de tener mas de dos participantes, marcamos la linea como conferencia
                if (partydevices && (phone.calls[call.cid+''].conference || partydevices.length > 2)) {
                  phone.calls[call.cid+''].conference = {
                    members: partydevices.map(function(party) {
                      return party.partydevice;
                    }),
                    controller: ''
                  };
                }
                // else if(phone.calls[call.cid+''] && phone.calls[call.cid+''].conference){
                //     delete phone.calls[call.cid+''].conference;
                // }

              });

              // Se borran las líneas de llamada que ya no están activas
              for (var call in phone.calls) {
                if (!callsAfter.includes(call) && phone.calls[call].status !== 'CLEARED'){
                  //Se fusionan las restantes**** ÑAPA  NO VÁLIDA
                  if(noMatched.length){
                    phone.calls[noMatched[0]] = Object.assign({}, phone.calls[call], {cId: noMatched[0], transactionId: noMatched[0]});
                    transactions.list[noMatched[0]] = Object.assign({}, transactions.list[call], {id: noMatched[0]});
                    noMatched.pop();
                  }else{
                    console.log('+ÑAPA, este ya no existe. Cambiarlo por uno que sí existe');
                    console.log(call);
                    console.log('cambiar por :?');
                    console.log(phone.calls[callsAfter[0]]);
                  }
                  delete phone.calls[call];
                  delete transactions.list[call];
                }
              }

              callKeys = Object.keys(phone.calls);

              if (callKeys.length === 0 && phone.dialing.length === 0) {
                  transactions.active = '';
                    phone.active = '0';
                    phone.dialing.push({
                      calledDevice: '',
                      status: 'STANDBY'
                  });
              }
              else {
                if(callKeys.length !== 0) {
                  phone.active = callKeys[0];
                  transactions.active = phone.calls[callKeys[0]].transactionId || callKeys[0];
                }
                else if(phone.dialing.length !== 0) {
                  phone.active = '0';
                  transactions.active = '';
                }
              }

              // Guardamos todo el estado del telefono
              return base.store.reduceStore(function(state) {
                state.phone = phone;
                state.transaction = transactions;
                return state;
              });

            });
        },
        //Métodos carga de trabajo omnichannel
        setWorkBusyFromOc: function(customStateBusy){
          var ready = base.store.getState().agent.state;
          if(ready === "-1"){
            this.setAgentState("0"); 
          }
          return ready;
        },
        setWorkNotBusyFromOc: function(previousState){
          var ready = base.store.getState().services.ready;
          if(!ready && previousState){
            this.setAgentState(previousState);
          }
        },
        //
        setAgentState: function(state) {

          if (state === '-1') {
            return thc.big.rest.setReady()
              .catch(function(err) {
                return base.store.reduceStore({
                  notifications: {
                    show: true,
                    message: 'Error cambiando estado: ' + err,
                    type: 'warning'
                  }
                });
              });
          } else {
            return thc.big.rest.setNotReady({
                reason: state
              })
              .catch(function(err) {
                return base.store.reduceStore({
                  notifications: {
                    show: true,
                    message: 'Error cambiando estado: ' + err,
                    type: 'warning'
                  }
                });
              });
          }
        }
      },
      events: {
        onHandshakeTokenReceived: function (token, isManualHandshake) {
          var loginPromise = Promise.resolve(true);

          // 1 - Si es un handshake manual, se debe iniciar sesión
          // if (isManualHandshake) {
            loginPromise = thc.big.rest.monitorDevice({
              token: token
            }).then(function(monitorResult) {

            //1.1 integraciones Salesforce
            base.util.integration.presence.synchronizeStatuses("LOGIN");
            //base.util.integration.listeners.addEventListeners();  //se necesita para carga trabajo (hay estado en asterisk?)

              return base.store.reduceStore({
                isLoading: false,
                session: {
                  isLogged: true
                }
              });
            })
            .catch(function(monitorError) {
              thc.big.stop();

              return base.store.reduceStore({
                isLoading: false,
                error: {
                  type: 'LOGIN',
                  message: 'Error on monitorDevice: ' + monitorError
                }
              }).then(function(){
                  return Promise.reject(monitorError);
              });
            });
          // }

          loginPromise.then(function() {
            return thc.controller.actions.getStatusCalls().then(function(){
                return base.store.reduceStore({
                    isLoading: false,
                    session: {
                      isLogged: true
                    },
                    overlay: {
                      show: false
                    }
                  });
            });
          }).catch(function(err) {
            if (!isManualHandshake) {
              thc.big.stop();
              base.actions.resetState();
              base.actions.init();
            }

            return base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: 'Error during getStatus requests:' + err
              },
              overlay: {
                show: false
              }
            });
          });

        },
        onHandshakeError: function(isManualHandshake) {
          if (isManualHandshake) {
            return base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: $Label.Softphone_Wrong_extension
              },
              overlay: {
                show: false
              },
              isLoading: false
            });
          }

        },
        onEventAlerting: function(eventData){
          var handlerSettings = {};
          if(eventData.userinfo){
            handlerSettings = {parseUserinfoAsJSON: false};
          }
          return base.events.onEventAlerting(eventData, handlerSettings);
        },
        onEventEstablished: function(eventData){
          var handlerSettings = {};
          if(eventData.userinfo){
            handlerSettings = {parseUserinfoAsJSON: false};
          }

          return base.events.onEventEstablished(eventData, handlerSettings);
        },
        onEventCallConnectionCleared: function(eventData){
          var state = base.store.getState(),
           phone = state.phone;

          // 1 - Se gestiona el evento si la extensión del usuario no es la que ha cortado la conexión
          if (eventData.extension !== eventData.releasingdevice) {
            if(!Object.keys(phone.calls).includes(eventData.cid)){
              for(var i in phone.calls) {
                if (phone.calls[i].hasOwnProperty('conference')){
                    if(phone.calls[i].conference.members.length > 2){
                        return setTimeout(function(){
                            return thc.controller.actions.getStatusCalls();
                        },1000);
                    }else{
                        return base.events.onEventCallConnectionCleared(Object.assign(eventData, {cid: i}));
                    } 
                }
              }
              return Promise.resolve();   
            }else{
              return base.store.reduceStore(function(state) {
                phone.calls[eventData.cid].conference.members.map(function(members) {
                  return members.partydevice !== eventData.releasingdevice;
                });
              });
            }
          }

          return base.events.onEventCallConnectionCleared(eventData);
          
        },
        onEventConferenced: function(event){
            // 0 - Se parsea el contenido de confconnections
            event.confconnections = JSON.parse(event.confconnections);

            // 1 - Si la extensión actual es el controlador de la transferencia
            if (event.extension === event.confcontroller) {
              return base.store.reduceStore(function(state) {
                var phone = state.phone,

                  secondaryCall = phone.calls[event.cid] || {},
                  primaryCall = phone.calls[secondaryCall.transactionId] || {},
                  currentTransaction = state.transaction.list[primaryCall.transactionId] || {};

                // 1.1 - Al conferenciar la llamada principal se fusiona con la secundaria y generando/manteniendo la correspondiente al event.cid
                phone.active = primaryCall.cId;
                state.transaction.active = currentTransaction.id;
                primaryCall.conference = {
                  members: event.confconnections.partydevices.map(function(partyDevice) {
                    return partyDevice.partydevice;
                  }),
                  controller: event.confcontroller
                };
                primaryCall.partyType = thc.PARTY_TYPE.NONE;
                if(primaryCall.status === 'HELD'){
                  primaryCall.status = 'ESTABLISHED';
                }
                

                // 1.2 - Se elimina la llamada distinta al cid resultante de la conferencia. En este caso la original
                if (event.cid !== currentTransaction.id) {
                  phone.cleared[secondaryCall.cId] = secondaryCall;
                  delete state.phone.calls[secondaryCall.cId];
                }

                return state;
              });
              
            } // 2 - Si la extensión es la que se ha añadido a la conferencia, significa que la conferencia es entrante
            else{
              // Como no nos referencian la llamada de la que proviene con un cid en secondarycid.. Buscamos la llamada con la referencia de confcontroller
              return base.store.reduceStore(function(state) {
                var oldCall,
                calls = state.phone.calls,
                transactions = state.transaction;
                for(var cid in calls){
                  if(calls[cid].dnis === event.confcontroller || calls[cid].ani === event.confcontroller){
                    oldCall = calls[cid];
                    break;
                  }
                }
                if(oldCall){
                  transactions.list[event.cid] = Object.assign({}, transactions.list[oldCall.transactionId || oldCall.cId], {id: event.cid});
                  calls[event.cid] = Object.assign({}, oldCall, {cId: event.cid, transactionId: event.cid, status: 'ESTABLISHED'});
                  // Si la llamada principal no concuerda con el cid de la conferencia a crear...
                  if(event.cid !== oldCall.cId){
                    delete transactions.list[oldCall.cId];
                    delete calls[oldCall.cId];
                  }
                  state.phone.active = event.cid;
                  transactions.active = event.cid;
                  calls[event.cid].conference = {
                    members: event.confconnections.partydevices.map(function(partyDevice) {
                      return partyDevice.partydevice;
                    }),
                    controller: event.confcontroller
                  };
                }
                
                return state;
              });
            }
            
        },
        onEventTransferred: function(eventData) {
            var state = base.store.getState(),
              phone = state.phone,
              transactions = state.transaction,
              secondaryCall = phone.calls[eventData.cid] || {},
              currentTransaction = state.transaction.list[secondaryCall.transactionId] || {},
              primaryCall = phone.calls[secondaryCall.transactionId] || {},

              active = state.phone.calls[state.phone.active] || {},
              
              isOutbound = eventData.extension === eventData.transferingdevice;
            
            // 1 - Si la transferencia es hacia fuera, se realiza el procesamiento automático de las dos tareas?? Revisar
            if (isOutbound) {
                //Se realiza un mapeo de campos para reutilizar el evento del controlador base
                eventData.cid = eventData.secondarycid;
                eventData.secondarycid = eventData.primarycid;
                eventData.primarycid = eventData.cid;
                return base.events.onEventTransferred(eventData);
            } 
             else {

                return thc.controller.actions.getStatusCalls();
              //TODO: Teniendo la llamada anterior intentar realizarlo de una como en las conferencias
              // return base.store.reduceStore(function(state) {
              //   var oldCall,
              //   calls = state.phone.calls,
              //   transactions = state.transaction;
              //   for(var cid in calls){
              //     if(calls[cid].dnis !== eventData.transferingdevice && calls[cid].ani !== eventData.transferingdevice){
              //       oldCall = calls[cid];
              //       break;
              //     }
              //   }
              //   if(oldCall && oldCall.cId){
              //     active.transactionId = active.cId;
              //     state.transaction.active = active.cId;
              //     state.transaction.list[active.cId] = Object.assign({}, state.transaction.list[eventData.primarycid], {id: active.cId});
              //     delete state.transaction.list[eventData.primarycid];
              //     delete state.phone.calls[eventData.primarycid];
              //   }else{
              //     console.log('Transferido por consulta');
              //     state.phone.calls[eventData.primarycid].status = 'ESTABLISHED';
              //   }
                
              //   return state;
              // });
              // Recibir una transferencia ciega. Se gestiona con la línea previa para mantener la información 
            }
        },
        onAgentStateChanged: function(eventData) {
          var auxReasonCodes = thc.settings.get().auxReasonCodes;
          var reasonsEnabled = auxReasonCodes.enabled;
          var selectedState = '0';
          var promesa = Promise.resolve();

          switch (eventData.status) {
            case 'NOTREADY':
              selectedState = reasonsEnabled ? eventData.reason || '0' : '0';
              break;

            case 'READY':
              selectedState = '-1';
              break;

            case 'AVAILABLE':
              selectedState = reasonsEnabled ? eventData.reason : '-1';
              break;

            case 'WORKNOTREADY':
              selectedState = '-100';
              break;

            default:
              selectedState = '0';
              break;
          }
          //Integraciones con Salesforce.
          if(!base.store.getState().presence.workLoaded){ //si no hay carga de trabajo
            promesa = promesa.then(function(){
              base.util.integration.presence.synchronizeStatuses(eventData.status);
            });
          }
         
          return promesa.then(function(){
            return base.store.reduceStore({
              agent: {
                state: selectedState
              }
            });
          });
        }
      }
    };
  });
})(window, document, window.sforce, window.console, window.localStorage, window.jQuery);
