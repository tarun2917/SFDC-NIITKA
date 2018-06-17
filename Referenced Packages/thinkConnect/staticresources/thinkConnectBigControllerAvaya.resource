(function(scope, document, sforce, console, localStorage, $) {
  'use strict';

  if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
    throw new Error('Big controller module not defined');
  }

  scope.thc.big.registerControllerMixin('avaya', function(controller) {
    var base = controller,
      phone = base.store.getState().phone;

    // Aux Functions
    function getNotReadyReasons() {
      var auxReasonCodes = thc.settings.get().auxReasonCodes;
      var reasons = [{
        label: "Ready",
        code: "-1"
      }];

      if (auxReasonCodes.enabled) {
        auxReasonCodes.codes.forEach(function(reason, index) {
          if (reason) {
            reasons.push({
              label: reason,
              code: '' + index
            });
          }
        });
      } else {
        reasons.push({
          label: auxReasonCodes.workNotReady ? auxReasonCodes.workNotReady : "Not Ready",
          code: "0"
        });
      }

      return Promise.resolve(reasons);
    }

    // Controller Extension
    return {
      actions: {
        login: function(credentials) {
          // 1 - Se desconecta por precaución CometD
          thc.big.stop();

          // 2 - Se procesa el formulario de login y se almacena en el estado
          if (credentials.extension) {
            base.store.reduceStore({
              isLoading: true,
              error: {
                type: "LOGIN",
                message: undefined
              },
              session: {
                extension: credentials.extension,
                username: credentials.username,
                password: credentials.password
              },
            });

            thc.big.start({
              extension: credentials.extension,
              username: credentials.username,
              password: credentials.password
            });

            // El login se gestiona directamente al obtenr la conexión
          } else {
            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: scope.$Label.Softphone_introduce_data
              },
              overlay: {
                show: false
              }
            });
          }
        },
        logout: function() {
          // 1 - Se desconecta CometD
          thc.big.rest.logout()
            .then(function(logoutResult) {
              thc.big.stop();
              // 2 - integración omnichannel
              base.util.integration.listeners.removeEventListeners();  //se necesita para carga trabajo
              base.actions.resetState();
            })
            .catch(function(logoutError) {
              base.store.reduceStore({
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
        }
      },
      events: {
        onHandshakeSuccess: function(isManualHandshake) {
          var loginPromise = Promise.resolve(true);

          base.store.reduceStore({
            overlay: {
              show: false
            }
          });

          // 1 - Si es un handshake manual, se debe iniciar sesión
          if (isManualHandshake) {
            loginPromise = thc.big.rest.login().then(function(loginResult) {

                base.store.reduceStore({
                  phone: phone,
                  isLoading: false,
                  session: {
                    isLogged: true
                  }
                });
              })
              .catch(function(loginErrors) {
                thc.big.stop();

                base.store.reduceStore({
                  isLoading: false,
                  error: {
                    type: 'LOGIN',
                    message: 'Error realizando login: ' + loginErrors
                  }
                });

                return Promise.reject(loginErrors);
              });
          }

          loginPromise.then(function() {
            return Promise.all([
              thc.big.rest.getState(),
              thc.big.rest.getStatusCalls(),
              getNotReadyReasons()
            ]);
          }).then(function(getStatusResponses) {
            var statusCalls = getStatusResponses[1],
                agentStates = getStatusResponses[2],
                phoneState = base.store.getState().phone;

            // 0 - integraciones Salesforce
            if (isManualHandshake) {
              base.util.integration.presence.synchronizeStatuses("LOGIN");
              base.util.integration.listeners.addEventListeners();  //se necesita para carga trabajo
            }

            // 1 - Se procesan las llamadas
            base.actions.processStatusCalls(statusCalls.extension, statusCalls.calls);

            // 2 - Si el teléfono no tiene líneas, se añade una nueva
            if (Object.keys(phoneState.calls).length === 0 && phoneState.dialing.length === 0) {
              base.actions.addLine();
            }

            // 2 - Se actualiza el store, pasando los estdos posibles del agente
            base.store.reduceStore({
              agent: {
                states: agentStates
              },
              isLoading: false,
              session: {
                isLogged: true
              }
            });
          }).catch(function(err) {
            if (!isManualHandshake) {
              thc.big.stop();
              base.actions.resetState();
              base.actions.init();
            }

            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: 'Error during login:' + err
              },
            });
          });
        },
        onHandshakeError: function(isManualHandshake) {
          if (isManualHandshake) {
            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: 'Error realizando login: No ha sido posible realizar el handshake'
              },
              isLoading: false
            });
          }

        },
        onEventCallConnectionCleared: function(eventData) {
          // 1 - Solo se gestiona el evento si la extensión del usuario es la que ha cortado la conexión
          if (eventData.extension !== eventData.releasingdevice) {
            return Promise.resolve();
          }

          return base.events.onEventCallConnectionCleared(eventData);
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
          if(!base.store.getState().presence.workLoaded){ //si no hay carga de trabajo
            promesa = promesa.then(function(){
              return base.util.integration.presence.synchronizeStatuses(eventData.status);
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
