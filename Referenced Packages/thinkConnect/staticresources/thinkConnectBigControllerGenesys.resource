(function(scope, util, document, sforce, console, localStorage, $) {
  'use strict';

  if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
    throw new Error('Big controller module not defined');
  }

  scope.thc.big.registerControllerMixin('genesys', function(controller) {
    var base = controller;

    function getCallStatusFromState(state) {
      var status = 'UNKNOWN';

      switch(state) {
        case 2:
          status = 'RINGING';
          break;
        case 4:
          status = 'RINGING';
          break;
        case 3:
          status = 'ESTABLISHED';
          break;
        case 5:
          status = 'HELD';
          break;
        default:
          status = 'UNKNOWN';
      }

      return status;
    }

    base.util.phone.processStatusCalls = function (args) {
      var transaction = args.transaction || {},
          phone = args.phone || {},
          phoneCalls = phone.calls || {},
          transactionList = transaction.list || {},
          statusCalls = args.statusCalls || [],
          callsById = {}, activeCallId = '', activeTransaction = {}, newPhone = {}, newTransaction = {},
          extension = args.extension;

      statusCalls.forEach(function(call) {
        // 1 - Se ordenan las status calls en un mapa por cid
        callsById[call.cid] = call;
        phoneCalls[call.cid] = phoneCalls[call.cid] || {};

        // 2 - se actualizan los datos de la llamada, de lo recibido en datos
        phoneCalls[call.cid] = Object.assign(phoneCalls[call.cid] || {}, {
          cId: call.cid,
          status: getCallStatusFromState(call.state),
          type: extension === call.callingdevice ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND,
          dnis: call.calleddevice || phoneCalls[call.cid].dnis,
          ani: call.callingdevice || phoneCalls[call.cid].ani
        });

        phoneCalls[call.cid].log = Object.assign(phoneCalls[call.cid].log || {}, {});
        phoneCalls[call.cid].context = phoneCalls[call.cid].context || {};
        phoneCalls[call.cid].callTime = phoneCalls[call.cid].callTime || 0;
        phoneCalls[call.cid].holdTime = phoneCalls[call.cid].holdTime || 0;


        // 3 - Se busca el cid de la llamada activa
        if(phoneCalls[call.cid].status === 'ESTABLISHED' || !activeCallId) {
          activeCallId = call.cid;
        }
      });


      // 4 - Se recorren todas las llamadas del teléfono y se tratan aquellas que no se encuentran en la memoria de BIG. En tal caso, se marcan como CLEARED
      util.object.forEach(phoneCalls, function(cId , call) {
        if(!callsById[cId]) {
            phoneCalls[cId].status = 'CLEARED';
        }
      });

      return {
        transaction: transaction,
        phone: phone
      };
    }

    // Sobrescribimos la funcionalidad de stringifyContextRecordsAsUUI puesto que en Genesys ya nos añade el UUI previamente
    base.util.call.uui.stringifyContextRecordsAsUUI = function(records) {
      var uuiSettings = thc.settings.get().screenPopOptions.uui,
        stringifiedRecords = [];

      if (!records) {
        return '';
      }

      thc.util.object.forEach(records, function(object, recordsById) {
        stringifiedRecords = stringifiedRecords.concat(Object.keys(recordsById));
      });

      return stringifiedRecords.join('!');
    }

    // Aux Functions
    function getNotReadyReasons() {
      var auxReasonCodes = thc.settings.get().auxReasonCodes;


      return thc.big.rest.getNotReadyReasons().catch(function() {
        return [];
      }).then(function(notReadyReasons) {
        var reasons = [];

        notReadyReasons.forEach(function(reason) {
          reasons.push({
            label: reason.name,
            code: reason.code
          });
        });

        reasons.push({
          label: "Ready",
          code: "-1"
        });

        reasons.push({
          label: auxReasonCodes.workNotReady? auxReasonCodes.workNotReady : "Not Ready",
          code: "0"
        });

        return reasons;
      });
    }

    // Controller Extension
    return {
      actions: {
        // En Genesys, se hace login a través de Person (username), password y Place. Este último viene en un segundo paso, por lo que login solo sirve para avanzar hacia este
        login: function(credentials) {
          var username = credentials.username || '',
              password = credentials.password,
              place = credentials.place || '';
          // 1 - Se desconecta por precaución CometD
          thc.big.stop();

          // 2 - Si se han introducido credenciales de usuario/place, realizamos  un login directo mediante setPlace
          if(!credentials.username) {
            return base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: scope.$Label.Softphone_introduce_data
              }
            });
          }


          if(place) {
            return this.setPlace(credentials);
          }

          // 3 - Si se han introducido credenciales de usuario/contraseña/, realizamos login del usuario mediante getPlaces - si este es correcto, devuelve los placeListGenesys
          return thc.big.rest.getPlaces({
            username: credentials.username,
            password: credentials.password
          }).then(function(places) {
            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: ""
              },
              overlay: {
                show: false
              },
              login: {
                username: username,
                places: places,
                loggingInStep: 'place'
              }
            });
          }).catch(function(error) {
            return base.store.reduceStore({
              isLoading: false,
              overlay: {
                show: false
              },
              error: {
                type: 'LOGIN',
                message: 'Error realizando login: ' + error
              }
            });
          });
        },
        setPlace: function(credentials) {
           var username = credentials.username || base.store.getState().login.username || '',
               place = credentials.place || '';

            if(!username || !place) {
              return base.store.reduceStore({
                error: {
                  type: 'LOGIN',
                  message: scope.$Label.Softphone_introduce_data
                }
              });
            }

            // 1 - Se desconecta por precaución CometD
            thc.big.stop();

            // 2 - Se invoca el login de genesys - este devuelve loginId y extensión, del que interesa únicamente la extensión
            thc.big.rest.loginGenesys({
              username: username,
              place: place
            }).then(function(loginResult) {
              // 3 - Si el login es correcto, se inicializa CometD y se almacenan las credenciales de usuario
              base.store.reduceStore({
                isLoading: true,
                login: {
                  place: place
                },
                error: {
                  type: "LOGIN",
                  message: ""
                },
                session: {
                  username: loginResult.loginid, // No se guarda el loginId, ya que este es el nombre que se muestra en el panel de agente
                  extension: loginResult.extension
                }
              });

              thc.big.start({
                extension: loginResult.extension,
                username: loginResult.loginid
              });
            }).catch(function(loginErrors) {
              base.store.reduceStore({
                isLoading: false,
                overlay: {
                  show: false
                },
                error: {
                  type: 'LOGIN',
                  message: 'Error realizando login: ' + loginErrors
                }
              });
            });

        },
        /*login: function(credentials) {
          // 1 - Se desconecta por precaución CometD
          thc.big.stop();



          var extension = credentials.extension;

          if (extension) {

            // 3.1 - Se procesa el formulario de login y se almacena en el estado
            var state = base.store.getState().session;
            var username = credentials.username; // ? credentials.username : state.username;
            var password = credentials.password; // ? credentials.password : state.pasword;
            var place = extension;

            base.store.reduceStore({
              isLoading: true,
              error: {
                type: "LOGIN",
                message: ""
              },
              session: {
                username: username,
                password: password
              },
            });

            // 2.2 - Se realiza primero el loginPlaceGen para obtener la extensión asociada al place
            thc.big.rest.loginGenesys({
              place: place
            }).then(function(loginResult) {

              thc.big.start({
                extension: loginResult.extension,
                username: username,
                password: password
              });

              base.store.reduceStore({
                error: {
                  type: 'LOGIN',
                  message: ""
                },
                session: {
                  extension: loginResult.extension,
                },
                overlay: {
                  show: false
                },
                login: {
                  defaultExtension: place,
                  place: place
                }
              });

            }).catch(function(loginError) {

              thc.big.stop();

              base.store.reduceStore({
                isLoading: false,
                error: {
                  type: 'LOGIN',
                  message: 'Error realizando login: ' + loginError
                },
                overlay: {
                  show: false
                }
              });

              return Promise.reject(loginError);

            });

          } else {
            // 3.2 - Se muestra panel intermedio
            thc.big.rest.getPlaces({
              username: credentials.username,
              password: credentials.password
            }).then(function(response) {
              response()
                .then(function(response) {
                  var login = base.store.getState().login;
                  login = Object.assign(login, {
                    loggingInStep: "extension",
                    possibleExtensions: response.places
                  });
                  base.store.reduceStore({
                    login: login,
                    error: {
                      type: "LOGIN",
                      message: ""
                    },
                    session: {
                      username: credentials.username,
                      password: credentials.password
                    },
                    overlay: {
                      show: false
                    }
                  });
                }).catch(function(result) {
                  base.store.reduceStore({
                    error: {
                      type: 'LOGIN',
                      message: "Usuario y contraseña erróneos"
                    },
                    overlay: {
                      show: false
                    }
                  });
                });
            });
          }
        },*/
        logout: function(reason) {
          // 1 - Si existe una razón se realiza el logout con esa razon
          if (reason) {
            thc.big.rest.logout({
                reason: reason
              })
              .then(function(logoutResult) {
                thc.big.stop();
                //base.util.integration.listeners.removeEventListeners();
                var login = base.store.getState().login;
                login = Object.assign(login, {
                  loggingInStep: "login"
                });

                base.store.reduceStore({
                  login: login,
                  error: {
                    type: "LOGIN",
                    message: ""
                  },
                  session: {
                    isLogged: false,
                    isLoggingOut: false
                  }
                });
              })
              .catch(function(logoutError) {
                if (!logoutError || logoutError === 'No user to logout') {
                  thc.big.stop();
                  var phone = base.store.getState().phone;
                  phone.calls = {};
                  phone.cleared = {};
                  phone.dialing.length = 0;
                  phone.active = '';

                  base.store.reduceStore(function(state) {
                    state.phone = phone;
                    state.loading = false;
                    state.session = Object.assign(state.session, {
                      isLogged: false,
                      isLoggingOut: false
                    });
                    state.error = Object.assign(state.error, {
                      type: "LOGIN",
                      message: ""
                    });
                    state.login = Object.assign(state.login, {
                      loggingInStep: 'login'
                    });
                    state.overlay = Object.assign(state.overlay, {
                      show: false
                    });
                    return state;
                  });
                } else {
                  base.store.reduceStore({
                    error: {
                      type: 'LOGOUT',
                      message: logoutError
                    },

                    notifications: {
                      message: logoutError,
                      show: true,
                      type: 'error'
                    }

                  });
                }
              });
            // 2 - Si no existe razón se recuperan las razones del servidor
          } else {
            thc.big.rest.getLogoutReasons()
              .then(function(reasons) {
                // 2.1 - Si no hay ninguna razón se realiza el logout simple
                if (reasons.length === 0) {
                  thc.big.rest.logout()
                    .then(function(logoutResult) {
                      thc.big.stop();
                      //base.actions.resetState();
                      base.store.reduceStore({
                        session: {
                          isLogged: false,
                          isLoggingOut: false
                        }
                      });
                    })
                    .catch(function(logoutError) {
                      base.store.reduceStore({
                        error: {
                          type: 'LOGOUT',
                          message: logoutError
                        }
                      });
                    });
                  // 2.2 - Si existen razones se guardan y se cambia el estado a isLoggingOut
                } else {
                  base.store.reduceStore({
                    session: {
                      logoutReasons: reasons,
                      isLogged: false,
                      isLoggingOut: true
                    }
                  });
                }
              })
              .catch(function(err) {

              });
          }
        },
        cancelLogout: function() {

          // Pone el estado de forma que el agente vuelva a la pantalla de standby, estando en la pantalla de selección de razón para hacer logout
          base.store.reduceStore({
            session: {
              isLogged: true,
              isLoggingOut: false
            }
          });
        },
        initScreen: function() {
          var login = base.store.getState().login;
          login = Object.assign(login, {
            loggingInStep: "login"
          });
          base.store.reduceStore({
            login: login,
            error: {
              type: 'LOGIN',
              message: ""
            },
            isLoading: false,
            session: {
              isLogged: false,
              isLoggingOut: false
            }
          });
        },
        setAgentState: function(state) {
          if (state === '-1') {  // Podemos estar indicando que estamos READY (-1)
            thc.big.rest.setReady().catch(function(err) {
                base.store.reduceStore({
                  notifications: {
                    show: true,
                    message: 'Error cambiando estado: ' + err,
                    type: 'warning'
                  }
                });
              });
          } else if (state === '0') {  // Si recibimos cero es que queremos ponernos en AFTERCALLWORK
            thc.big.rest.setWrapup().catch(function (err) {
              base.store.reduceStore({
                notifications: {
                  show: true,
                  message: 'Error en setWrapup: '+ err,
                  type: 'warning'
                }
              })
            });
          } else {  // En cualquier otro caso nos marcamos con NOTREADY con el estado apropiado
            thc.big.rest.setNotReady({
              reason: state
            }).catch(function(err) {
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
        clearCall: function() {
          var state = base.store.getState();
          var phone = state.phone;
          var currentCall = base.util.call.getCurrent(state);
          var currentCid = phone.active;
          if (currentCall.conference) {
            thc.big.rest.clearConnection({
              cid: currentCid
            })
            .catch(function (clearConnectionError) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error colgando conexion: ' + clearConnectionError
                }
              })
            });
          } else {
            thc.big.rest.clearCall({
              cid: currentCid
            })
            .catch(function(clearCallError) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error colgando llamada: ' + clearCallError
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
            //thc.big.rest.stopSession();
          }
          return ready;
        },
        setWorkNotBusyFromOc: function(previousState){
          var ready = base.store.getState().services.ready;
          if(!ready && previousState){
            this.setAgentState(previousState);
            //thc.big.rest.startSession();
          }
        },
        //
        processStatusCalls: function(extension, calls) {
          base.store.reduceStore(function(state) {
            var phone = state.phone,
              transaction = state.transaction,
              currentCallIds = {};

            // 1 - Calls
            calls.forEach(function(call) {
              // 1.1 Si la llamada no existe
              if (!phone.calls[call.cid]) {
                phone.calls[call.cid] = {
                  cId: call.cid,
                  transactionId: call.cid,
                  dnis: call.calleddevice,
                  ani: call.callingdevice,
                  callTime: 0,
                  type: extension === call.callingdevice ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND,
                  context: {},
                  holdTime: 0
                };
              }

              if (call.state === 3) {
                phone.calls[call.cid].status = phone.calls[call.cid].status || 'ESTABLISHED';
              } else if (call.state === 5) {
                phone.calls[call.cid].status = 'HELD';
              } else if (call.state === 4 || call.state === 2) {
                phone.calls[call.cid].status = 'RINGING';
              } else {
                phone.calls[call.cid].status = 'UNKNOWN';
              }

              if (!transaction.list[call.cid]) {
                transaction.list[call.cid] = {
                  id: call.cid,
                  type: 'call',
                  status: phone.calls[call.cid].status != 'UNKNOWN' ? thc.TRANSACTION_STATUS.ACTIVE : thc.TRANSACTION_STATUS.CLEARED
                };
              }

              currentCallIds[call.cid] = true;
            });

            // 2 - Aquellas llamadas finalizadas, se verifica si existe un log asociado en cuyo caso se pasa al estado cleared. Si no es así, se elimina
            thc.util.object.forEach(phone.calls, function(cId, call) {
              if (!currentCallIds[cId]) {
                if (call.log && call.log.taskId) {
                  call.status = 'CLEARED';
                } else {
                  delete phone.calls[cId];
                }
              }
            });

            return state;
          });
        }
      },
      events: {
        onHandshakeSuccess: function(isManualHandshake) {
          var loginPromise = Promise.resolve(true);

          loginPromise.then(function() {
            return Promise.all([
              //thc.big.rest.getState(),
              thc.big.rest.getStatusCalls(),
              getNotReadyReasons()
            ]);

          }).then(function(getStatusResponses) {
            var statusCalls = getStatusResponses[0],
              agentStates = getStatusResponses[1],
              phoneState = base.store.getState().phone;

            // 1 - Se procesan las llamadas
            thc.controller.actions.processStatusCalls(statusCalls.extension, statusCalls.calls);

            // 2 - Si el teléfono no tiene líneas, se añade una nueva
            if (Object.keys(phoneState.calls).length === 0 && phoneState.dialing.length === 0) {
              base.actions.addLine();
            }

            // 3 - Se actualiza el store, pasando los estados posibles del agente
            base.store.reduceStore({
              agent: {
                state: agentStates[0].code,
                states: agentStates
              },
              isLoading: false,
              session: {
                isLogged: true
              },
              overlay: {
                show: false
              }
            });
          }).catch(function(err) {
            thc.big.stop();

            if (!isManualHandshake) {
              base.actions.resetState();
            }

            base.store.reduceStore({
              isLoading: false,
              error: {
                type: 'LOGIN',
                message: 'Error during login: ' + err
              },
              overlay: {
                show: false
              }
            });
          });
          // 4 - integración omnichannel
          //base.util.integration.listeners.addEventListeners(); //se necesita para carga trabajo
        },
        onHandshakeError: function(isManualHandshake, isRestart) {
          if (isRestart) {
            base.actions.resetState();
          } else if (isManualHandshake) {
            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: 'Error realizando login: No ha sido posible realizar el handshake'
              },
              isLoading: false,
              overlay: {
                show: false
              }
            });
          }
        },

        onEventCallConnectionCleared: function(eventData) {
          var state = base.store.getState(),
           phone = state.phone;
          // 1 - Se gestiona el evento si la extensión del usuario no es la que ha cortado la conexión
          if (eventData.extension !== eventData.releasingdevice) {
            if (phone.calls[eventData.cid] && phone.calls[eventData.cid].conference) {

              //2 Integraciones omnichannel
              base.util.integration.presence.setBusy(false);

              return base.store.reduceStore(function(state) {
                var members = state.phone.calls[eventData.cid].conference.members;
                members.splice(members.indexOf(eventData.releasingdevice));
                if (members.length <= 2) {
                  delete state.phone.calls[eventData.cid].conference;
                }
                return state;
              });
            }

            return Promise.resolve();
          }

          return base.events.onEventCallConnectionCleared(eventData);
        },

        /**
         * Gestiona la recepción del evento OnEventOriginated recibido durante la marcación de una llamada saliente. Indica que se ha aceptado la marcación de destino y se va a intentar realizar la llamada
         * Identifica la llamada como Outbound, se asignan el ANI y el DNIS y se inicializa el Call Log: de esta forma, se generan logs si el cliente no acepta la llamada
         * Sobreescribe el funcionamiento normal del evento; en Genesys, la marcación de llamadas salientes a extensiones no registradas en la centralita no genera un evento OnEventAlerting, por lo que solo se emite OnEventOriginated
         * Este se retrasa para su ejecución previa al OnEventAlerting; si este no se recibe, se simula dicha recepción
         **
         * @author jmartinezpisson
         * @override base.events.onEventOriginated
         * @param {object} event - Datos del evento,
         * @param {BigEvent} event - Evento con los datos del OnEventOriginated.
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
        onEventOriginated: function(event) {
          var onEventOriginatedPromise = Promise.resolve();

          // 1 - Si el evento no se ha retrasado, se procesa y se retrasa hasta la llegada del OnEventAlerting
          if (!event.isDeferred()) {
            onEventOriginatedPromise = base.events.onEventOriginated(event);

            event.defer({
              before: function(deferredEvent, waitEvent) {
                return waitEvent.name === 'OnEventAlerting' && deferredEvent.cid === waitEvent.cid;
              },
              onWaitTimeout: function(thisEvent) {
                thisEvent.name = 'OnEventAlerting'

                return thisEvent;
              },
              waitTime: 1500
            });
          }

          return onEventOriginatedPromise;
        },
        /**
         * Evento recibido cuando se establece una llamada a la extensión.
         **
         * @author jmartinezpisson
         * @param {object} event - Datos del evento,
         * @param {BigEvent} event - Evento con los datos del OnEventOriginated.
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

          var phone = base.store.getState().phone,
            calls = phone.calls;


          // 1  - Integraciones con Salesforce
          base.util.integration.presence.setBusy(true);


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

          base.store.reduceStore({
            phone: phone
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
          base.util.integration.presence.setBusy("transferred"); // Se fuerza que Onmnichannel vuelva al estado anterior

          return base.store.reduceStore(function(state) {
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
                return base.util.call.log.end(transferredCall).then(function() {
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
                  phone.active = base.util.phone.getActiveCall(phone);

                  if (!phone.active || phone.active !== '0') {
                    state.transaction.active = '';
                    phone.active = '0';
                    phone.dialing.push({
                      calledDevice: '',
                      status: 'STANDBY'
                    });
                  } else {
                    state.transaction.active = phone.calls[phone.active].transactionId;
                  }

                  // 4.4 - Se realiza el customPop de la llamada eliminada
                  return base.util.call.customPop({
                    call: phone.cleared[event.cid],
                    contact: currentTransaction.contact,
                    context: currentTransaction.context,
                    log: phone.cleared[event.cid].log
                  }).catch().then(function() {
                    return state;
                  });
                });
              }
            } else {
              if (event.cause === 'Transfer') {
                var transferredConn = JSON.parse(event.transferredconnections);
                if (transferredConn.partydevices.length > 2) {
                  phone.calls[event.cid].conference = {
                    members: transferredConn.partydevices.map(function(partyDevice) {
                      return partyDevice.partydevice;
                    }),
                    controller: event.confcontroller
                  };
                } else {
                  /*phone.calls[event.secondarycid].ani = transferredConn.partydevices.filter(function(party) {
                    return party.partydevice !== event.transferreddevice;
                  })[0].partydevice;*/
                  if (phone.calls[event.secondarycid]) {

                    phone.calls[event.primarycid] = Object.assign(phone.calls[event.secondarycid] || {}, {
                      cId: event.primarycid,
                      transactionId: event.primarycid
                    });

                    delete phone.calls[event.secondarycid];

                    phone.active = event.primarycid;

                    state.transaction.list[event.primarycid] = Object.assign(state.transaction.list[event.secondarycid] || {}, { id: event.primarycid, status: thc.TRANSACTION_STATUS.ACTIVE });
                    state.transaction.active = event.primarycid;
                  }
                }
              }
            }

            return state;

          });
        },
        onAgentStateChanged: function(eventData) {
          var selectedState = '0';

          switch (eventData.status) {
            case 'LOGIN':
              base.store.reduceStore({
                isLoading: false,
                session: {
                  isLogged: true
                }
              });

              eventData.reason = '1';
            case 'NOTREADY':
              // Solo procesamos los eventos de not ready si el reason no es 0 o -1, estos son los estados locales de NOT READY y AFTERCALLWORK
              if (eventData.reason !== '0' && eventData.reason !== '-1') {
                var notReadyReasons = base.store.getState().agent.states;
                if (notReadyReasons.some(function (e) { return e.code === eventData.reason })) {
                  selectedState = eventData.reason;
                } else {
                  selectedState = notReadyReasons[0].code;
                }
              }
              break;

            case 'READY':
              selectedState = '-1';
              break;

            case 'AVAILABLE':
              selectedState = eventData.reason || '-1';
              break;

            case 'WORKNOTREADY':
              selectedState = '0';
              break;

            case 'LOGOUT':
              var phone = base.store.getState().phone;
              phone.calls = {};
              phone.cleared = {};
              phone.dialing.length = 0;
              phone.active = '';

              base.store.reduceStore(function(state) {
                state.phone = phone;
                state.loading = false;
                state.session = Object.assign(state.session, {
                  isLogged: false,
                  isLoggingOut: false
                });
                state.login = Object.assign(state.login, {
                  loggingInStep: 'login'
                });
                state.overlay = Object.assign(state.overlay, {
                  show: false
                });
                return state;
              });
              break;



            default:
              selectedState = '0';
              break;
          }

          return base.store.reduceStore({
            agent: {
              state: selectedState
            }
          });
        }
      }
    };
  });
})(window, window.thc.util, document, window.sforce, window.console, window.localStorage, window.jQuery);
