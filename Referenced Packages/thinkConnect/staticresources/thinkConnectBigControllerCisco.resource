(function(scope, document, sforce, console, localStorage, $) {
  'use strict';

  if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
    throw new Error('Big controller module not defined');
  }

  scope.thc.big.registerControllerMixin('cisco', function(controller) {
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
          var token = base.store.getState().session.token;
          // 1 - Se desconecta CometD
          return thc.big.rest.monitorStop({
            token: token
          }).then(function(logoutResult) {
              thc.big.stop();
              //EN CISCO NO HAY ESTADO
              //base.util.integration.listeners.removeEventListeners();  //se necesita para carga trabajo
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
        setAgentState: function(state) {

          if (state === '-1') {
            thc.big.rest.setReady()
              .catch(function(err) {
                base.store.reduceStore({
                  notifications: {
                    show: true,
                    message: 'Error cambiando estado: ' + err,
                    type: 'warning'
                  }
                });
              });
          } else {
            thc.big.rest.setNotReady({
                reason: state
              })
              .catch(function(err) {

                base.store.reduceStore({
                  notifications: {
                    show: true,
                    message: 'Error cambiando estado: ' + err,
                    type: 'warning'
                  }
                });
              });
          }
        },
        conference: function() {
          return thc.big.rest.conference().then(function(){
            return base.store.reduceStore(function(state) {
              var active = state.phone.active;
              state.phone.calls[active].status = 'ESTABLISHED';
              return state;
            });
          })
          .catch(function(transferError) {
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
        //Métodos carga de trabajo omnichannel
        /*EN CISCO NO HAY ESTADO
        setWorkBusyFromOc: function(customStateBusy){
          thc.big.rest.setNotReady();
        },
        setWorkNotBusyFromOc: function(previousState){
          thc.big.rest.setReady();
        },*/
        //
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
              var newCalls = JSON.parse(response.calls);

              newCalls.forEach(function(call) {
                var status = '',
                isInbound = state.session.extension === call.calleddevice,
                partydevices = call.partydevices ? JSON.parse(call.partydevices) : '',
                newCall, transaction;
                callsAfter.push(call.cid+'');

                // Indicamos el estado de la llamada
                switch (call.terminals[0][Object.keys(call.terminals[0])].connectionstate) {
                  case 'RINGING':
                    status = 'RINGING';
                    break;
                  case 'TALKING':
                    status = 'ESTABLISHED';
                    break;
                  case 'HELD':
                    status = 'HELD';
                    break;

                  default:
                    status = 'UNKNOWN';
                }

                newCall = {
                  cId: '' + call.cid,
                  uCId: call.ucid,
                  status: status,
                  reserved: call.reserved,
                  type: isInbound ? thc.CALL_TYPE.INBOUND : thc.CALL_TYPE.OUTBOUND,
                  ani: call.callingdevice.split(' ')[0].replace(/"/g, '') || '-',
                  dnis: '' + call.calleddevice || '-',
                  transactionId: '' + call.cid,
                  callTime: 0,
                  holdTime: 0,
                  userinfo: call.userinfo ?  { uui: call.userinfo } : {}
                }

                if(newCall.status === 'ESTABLISHED'){
                  newCall.lastUpdated = new Date();
                }

                // Creamos una transaccion de tipo llamada
                transaction = {
                  id:  '' + call.cid,
                  type: thc.TRANSACTION_TYPE.CALL
                }

                 // Guardamos la llamada y la transaccion
                if(Object.keys(callsPrev).includes(call.cid+'')){
                  phone.calls[call.cid+''] = Object.assign({}, callsPrev[call.cid+''], newCall);
                  transactions.list[call.cid+''] = Object.assign({}, transactionsPrev[call.cid+''], transaction);
                }
                else{
                  //Si no existía previo al realizar getStatusCalls, no se le asigna transacción, pues no existe ninguna tarea asociado a la llamada
                  delete newCall.transaction;
                  phone.calls[call.cid+''] = newCall;
                }

                // Y en el caso de tener mas de dos participantes, marcamos la linea como conferencia
                if (partydevices && partydevices.length > 2) {
                  phone.calls[call.cid+''].conference = {
                    members: partydevices.map(function(party) {
                      return party.partydevice;
                    }),
                    controller: ''
                  };
                }
                else if(phone.calls[call.cid+''] && phone.calls[call.cid+''].conference){
                    delete phone.calls[call.cid+''].conference;
                }

              });

              // Se borran las líneas de llamada que ya no están activas
              for (var call in phone.calls) {
                if (!callsAfter.includes(call) && phone.calls[call].status !== 'CLEARED'){
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

              // Guardamos tod0 el estado del telefono
              return base.store.reduceStore(function(state) {
                state.phone = phone;
                state.transaction = transactions;
                return state;
              });

            });
        }
      },
      events: {
        onHandshakeTokenReceived: function (token, isManualHandshake) {
          var loginPromise = Promise.resolve(true);

          // TODO: necesario monitordevice para tener controlado el último token y tener disponible monitorstop
          // if (isManualHandshake) {
            loginPromise = thc.big.rest.monitorDevice({
              token: token
            }).then(function(monitorResult) {
              return base.store.reduceStore({
                isLoading: false,
                session: {
                  isLogged: true,
                  token: token
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
          /*loginPromise.then(function(){ EN CISCO NO HAY ESTADO
            base.util.integration.listeners.addEventListeners(); //se necesita para carga trabajo
          });*/

          //1.1 integraciones Salesforce
          if (isManualHandshake) {
            base.util.integration.presence.synchronizeStatuses("LOGIN");
          }
          loginPromise.then(function(){
            // 1 - Se procesan las llamadas
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
            })
          }).then(function(){
              return base.store.reduceStore(function(state){
                // 2 - Si el teléfono no tiene líneas, se añade una nueva
                if (Object.keys(state.phone.calls).length === 0 && state.phone.dialing.length === 0) {
                  return base.actions.addLine();
                }

                return state;
                
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
          var handlerSettings = {},
          phone = base.store.getState().phone,
          newType = phone.calls[eventData.cid] && eventData.extension === eventData.callingdevice;
          if(eventData.userinfo){
            handlerSettings = {parseUserinfoAsJSON: false};
          }

          return base.events.onEventAlerting(eventData, handlerSettings).then(function(){
            return base.store.reduceStore(function(store){
              // Cuando se recibe una transferencia ciega hacia otro número, 
              // si se recibe el mismo cid hay que actualizar el type de la llamada.
              // EJEMPLO;: Somos 4022, nos llama 4021 y después 4021 transfiere a 8075
              if(newType){
                store.phone.calls[eventData.cid].type = thc.CALL_TYPE.OUTBOUND;
              }
              return store;
            });
          });
         
        },
        onEventEstablished: function(eventData){
          var handlerSettings = {};
          if(eventData.userinfo){
            handlerSettings = {parseUserinfoAsJSON: false};
          }

          return base.events.onEventEstablished(eventData, handlerSettings);
        },
        onEventDiverted: function(eventData){
          return base.events.onEventCallConnectionCleared(eventData);
        },
        onEventTransferred: function(eventData){
          var state = base.store.getState(),
          phone = state.phone,
          transaction = state.transaction;

          if(eventData.extension === eventData.transferingdevice){
            return base.events.onEventTransferred(eventData);
          }else if (phone.calls[eventData.secondarycid]) {
            phone.calls[eventData.primarycid] = Object.assign(phone.calls[eventData.secondarycid] || {}, {
              cId: eventData.primarycid,
              transactionId: eventData.primarycid
            });

            delete phone.calls[eventData.secondarycid];
            phone.active = eventData.primarycid;

            transaction.list[eventData.primarycid] = Object.assign(transaction.list[eventData.secondarycid] || {}, { id: eventData.primarycid, status: thc.TRANSACTION_STATUS.ACTIVE });
            transaction.active = eventData.primarycid;
            delete transaction.list[eventData.secondarycid];
          }

          if(phone.calls[eventData.cid].status !== 'ESTABLISHED'){
            phone.calls[eventData.cid].status = 'ESTABLISHED';
          }

          return base.store.reduceStore(function(state){
            state.phone = phone;
            state.transaction = transaction;
            return state;
          });
        },
        onEventCallConnectionCleared: function(eventData) {
          // 1 - Solo se gestiona el evento si la extensión del usuario es la que ha cortado la conexión
          if (eventData.extension !== eventData.releasingdevice) {
              return base.store.reduceStore(function(state) {
                if(state.phone.calls[eventData.cid] && state.phone.calls[eventData.cid].conference){
                  var members = state.phone.calls[eventData.cid].conference.members;
                  members.splice(members.indexOf(eventData.releasingdevice), 1);
                  // if (members.length <= 2) {
                  //   delete state.phone.calls[eventData.cid].conference;
                  // }
                }
                return state;
              });
          }

          return base.events.onEventCallConnectionCleared(eventData);
        },
        OnEventMonitorEnded: function(eventData){
              thc.big.stop();

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
        },
        onAgentStateChanged: function(eventData) {
          var auxReasonCodes = thc.settings.get().auxReasonCodes;
          var reasonsEnabled = auxReasonCodes.enabled;
          var selectedState = '0';

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

          base.store.reduceStore({
            agent: {
              state: selectedState
            }
          });
          //Integraciones con Salesforce. EN CISCO NO HAY ESTADO, ESTE EVENTO NO LLEGA
          /*if(!base.store.getState().presence.workLoaded){ //si no hay carga de trabajo
            promesa = promesa.then(function(){
              base.util.integration.presence.synchronizeStatuses(eventData.status);
            });
          }*/
         
        }
      }
    };
  });
})(window, document, window.sforce, window.console, window.localStorage, window.jQuery);
