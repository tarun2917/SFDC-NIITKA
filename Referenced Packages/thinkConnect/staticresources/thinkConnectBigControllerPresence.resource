/**
 * Extensión del controlador de thinkConnect para su uso en Presence estructurado como otra extensión.
 * Sobreescribe aquellas acciones y eventos cuya funcionalidad no suple el controlador base
 **
 * @author acorrales, amartinez, jarina, jmartinezpisson
 **/
(function(scope, document, util, sforce, console, localStorage, $) {
  'use strict';

  // 1 - Comprobación de seguridad para determinar que el controlador principal está definido
  if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
    throw new Error('Big controller module not defined');
  }

  // 2 - Registro de la extensión Presence
  scope.thc.big.registerControllerMixin('presence', function(controller) {
    var base = controller;

    return {
      actions: {
        /**
         * Inicio de sesión en presence
         **
         * @author acorrales
         * @param {Object} credentials - Credenciales de login en presence
         * @param {string} credentials.extension - Extensión del usuario.
         * @param {string} credentials.username - Id. de agente de presence
         * @param {string} credentials.password - Contraseña
         */
        login: function(credentials) {
          // 1 - Se desconecta por precaución CometD
          thc.big.stop();
         
          // 2 - Se procesa el formulario de login, si se ha introducido la extesión
          if (credentials.extension) {
            // 2.1 - El estado se actualiza para identificar que el login esta en proceso
            base.store.reduceStore({
              isLoading: true,
              error: {
                type: "LOGIN",
                message: ''
              },
              session: {
                extension: credentials.extension,
                username: credentials.username,
                password: credentials.password
              },
              ui: {
                isCampaignsEnabled: true,
                isRecordingEnabled: false,
                isRecordingOpened :false,
                isAgentStatePanel: false,
                isCampaignsOpened: false,
                isRescheduleCapturable: true,
                showCallResultIn: ['ESTABLISHED', 'CLEARED', 'HELD', 'TRANSFERRED'],
                transactionActions: ['RESCHEDULE'],
                isStateDisplayed: true
              },
              services: {
                ready: false,
                wrapupsBackup: 'standard'
              }
            });

            // 2.2 - Se inicializa el módulo de BIG con las credenciales introducidas. El resto del proceso de login se realiza si el handshake de CometD es correcto (Ver events.onHandshakeSuccess y events.onHandshakeError)
            thc.big.start({
              extension: credentials.extension,
              username: credentials.username,
              password: credentials.password
            });

            // 3 - Si no se han introducido las credenciales, se actualiza el estado identificando el error en el Login
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
        /**
         * Cierra la sesión de usuario activa
         **
         * @author acorrales
         * @param {string} reason - Código de razón del cierre de sesión. Obligatorio
         */
        logout: function(reason) {
          // 0 - Es necesario que no haya campañas activas para poder hacer el logout
          var campaigns = base.store.getState().services.campaigns;
          var campaignsActive = typeof campaigns === 'undefined' ? false : campaigns.some(function(el) {
            return el.state === 'SS_STARTED'
          });

          if (campaignsActive) {
            base.store.reduceStore({
              notifications: {
                show: true,
                type: 'error',
                message: 'Campaigns have to be stopped before logging out'
              }
            });
            return;
          }
          // 1 - Si existe una razón se realiza el logout con esa razon
          if (reason) {
            thc.big.rest.logout({
                reason: reason
              })
              .then(function(logoutResult) {

                // 1.1 - integración omnichannel
                base.util.integration.listeners.removeEventListeners();  //se necesita para carga trabajo

                thc.big.stop();

                // Como estamos en Presence, ocultamos el botón de campañas/servicios
                base.store.reduceStore(function(state) {
                  state.session.isLogged = false;
                  state.session.isLoggingOut = false;

                  state.error = {
                    type: 'LOGOUT',
                    message: ''
                  };

                  state.notifications = {
                    message: '',
                    show: false,
                    type: ''
                  };

                  return state;
                });
              }).catch(function(logoutError) {
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
        /**
         * Cancela el proceso de cierre de sesión y mantiene al usuario con el softphone iniciado
         **
         * @author acorrales
         */
        cancelLogout: function() {

          // Pone el estado de forma que el agente vuelva a la pantalla de standby, estando en la pantalla de selección de razón para hacer logout
          base.store.reduceStore({
            session: {
              isLogged: true,
              isLoggingOut: false
            }
          });
        },
        /**
         * Setea el resultado de la llamada. Actualiza el contacto abierto de Presence con el QCode seleccionado y actualiza la tarea de Salesforce asociada a la llamada con dicho resultado
         **
         * @author amartinez
         * @param {object} callResult - QCode asociado al resultado de llamada
         */
        setCallResult: function(callResult) {
          var currentState = base.store.getState(),
            activeCall = base.util.call.getCurrent(currentState),
            transactionCall = currentState.transaction.list[activeCall.transactionId];

          if (transactionCall && transactionCall.campaignId && callResult.root !== 'rescheduled') {
            if (transactionCall.reschedule && transactionCall.reschedule.saved) {
              base.actions.cancelRescheduleCall();
            }
            // Si es una llamada de servicio, además envía el código de tipificación seleccionado a Presence
            thc.big.rest.setQCode({
              codeq: callResult[Object.keys(callResult)[0]]
            }).catch(function(err) {
              base.store.reduceStore({
                notifications: {
                  show: true,
                  type: 'error',
                  message: err
                }
              });
            });
          }
          base.actions.setCallResult(callResult);
        },
        /**
         * Actualiza la tarea
         **
         * @author amartinez, jmartinezpisson
         * @override base.actions.updateTask
         * @param {object} callResult - QCode asociado al resultado de llamada
         */
        updateTask: function() {
          return base.store.reduceStore(function(state) {
            var currentCall = state.phone.calls[state.phone.active],
              currentTransaction = state.transaction.list[currentCall.transactionId],
              transactionCallResult = currentTransaction.callResult;

            // 1 - Se actualiza la tarea
            return base.util.call.log.end(currentCall).then(function(task) {
              // 2 - Se muestra una notificacción con el id de la tarea generada
              state.notifications = {
                show: true,
                message: $Label.Tarea_actualizada + ' (' + task.taskId + ')',
                type: 'task',
                record: task.taskId
              };

              // 3 - Si la transacción es de tipo sesión (tiene un contacto), se necesita realizar el cierre/reprogramación de contacto
              if (currentTransaction.contact) {
                if (transactionCallResult.root === 'rescheduled') {
                  return base.util.contact.reschedule(currentTransaction.reschedule);
                } else {
                  return thc.big.rest.closeContact();
                }
              }

              return true;
              // 3 - Si el cierre del contacto ha sido correcto o no ha sido necesario cerrarlo, se realizan las acciones post-actualización
            }).then(function() {
              // 3.1 - Se controla la transacción; si era una transacción de sesión con contacto, al haberse cerrado, la transacción debe desaparecer junto con la tarea, así como todas las llamadas relacionadas
              if (currentTransaction.contact) {
                util.object.forEach(state.phone.calls, function(cId, call) {
                  if (call.transactionId === currentTransaction.id) {
                    state.phone.cleared[cId] = call;
                    delete state.phone.calls[cId];
                  }
                });

                // La transacción se elimina, ya que el contacto está cerrado
                delete state.transaction.list[currentTransaction.id];

                // 3.2 - Si la transacción es de tipo llamada, y es la principal, se elimina también la transacción
              } else if (currentTransaction.id === currentCall.cId) {
                delete state.transaction.list[currentTransaction.id];
              }

              // 3.3 - La llamada cerrada debe eliminarse del listado de Llamadas
              state.phone.cleared[currentCall.cId] = currentCall;
              delete state.phone.calls[currentCall.cId];

              // 3.4 - Se marca la llamada activa, y se añade la por defecto si aplica
              state.phone.active = base.util.phone.getActiveCall(state.phone);

              if (!state.phone.active && state.phone.active !== '0') {
                state.phone.dialing.push({
                  calledDevice: '',
                  status: 'STANDBY'
                });

                state.phone.active = '0';
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
        /**
         * Obtiene de Presence las razones por las que un agente puede ponerse en "No Preparado" con respecto a los servicios que tiene activos
         **
         * @author acorrales, jmartinezpisson
         */
        getNotReadyReasons: function() {
          return thc.big.rest.getNotReadyReasons().then(function(result) {
            return base.store.reduceStore({
              ui: {
                isSelectingNotReadyReason: true
              },
              services: {
                notReadyReasons: result
              }
            });
          }).catch(function(error) {
            return base.store.reduceStore({
              ui: {
                isSelectingNotReadyReason: false
              },
              notifications: {
                show: true
              },
              error: {
                type: 'warning',
                message: 'Error while getting Not Ready reasons: ' + error
              }
            });
          });
        },
        /**
         * Actualiza el texto de búsqueda usado como búsqueda en el selector de servicios (no sensible a mayúsculas)
         **
         * @author amartinez
         * @param {string} filter - Texto introducido como búsqueda
         */
        updateServiceSelectorFilter: function(filter) {
          base.store.reduceStore({
            ui: {
              serviceSelectorFilter: filter
            }
          });
        },
        /**
         * Se encarga de ejecutar las acciones correspondientes al mostrado/ocultado de la sección de servicios
         **
         * @author acorrales
         * @param {string} filter - Texto introducido como búsqueda
         */
        toggleServices: function() {
          if (base.actions.toggleServices()) {
            // Si se han mostrado, se solicitan los servicios disponibles por el agente
            Promise.all([
              thc.big.rest.getSessionInfo(),
              thc.big.rest.getCustomButtons()
            ]).then(function(results) {
              var sessionInfo = results[0],
                customButtons = results[1],
                buttonsByCampaign = {},
                alwaysEnabledButtons = [];

              sessionInfo.services.campaigns.forEach(function(campaign, index) {
                sessionInfo.services.campaigns[index].customButtons = [].concat(customButtons || []);
              });

              base.store.reduceStore(function(state) {
                state.services.campaigns = sessionInfo.services.campaigns;
                state.session.agentName = sessionInfo.session.agentName;
                return state;
              });
            }).catch(function(error) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error recibiendo servicios: ' + error
                }
              });
            });
          }
        },
        /**
         * Marca al agente como ready en sus servicios asignados, pudiendo comenzar a recibir llamadas de dichos servicios
         **
         * @author acorrales
         */
        readyAll: function() {
          thc.big.rest.startSession().then(function(result) {
            base.store.reduceStore({
              services: {
                ready: true
              }
            });
          }).catch(function(error) {
            base.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error modificando estado: ' + error
              }
            });
          });
        },
        /**
         * Marca al agente como Not Ready  en sus servicios asignados, dejando recibir llamadas de servicio.
         * El cambio no es aplicado de forma inmediata, ya que no es posible cambiar a estado Not Ready durante el curso de una sesión/llamada. El cambio de estado es alerado mediante el evento OnEventStateChanged
         **
         * @author acorrales
         */
        notReadyAll: function(reasonValue) {
          base.store.reduceStore({
            ui: {
              isStateChanging: true,
              isSelectingNotReadyReason: false,
            }
          });

          thc.big.rest.stopSession({
            reason: reasonValue
          }).catch(function(error) {
            base.store.reduceStore({
              ui: {
                isStateChanging: false
              },
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error modificando estado: ' + error
              }
            });
          });
        },
        // Al hacer una llamada saliente, esta función redirige a la petición Rest correspondiente en base a si es una llamada saliente normal
        // O una realizada como consecuencia de una llamada Preview
        launchCall: function(callId) {
          var currentState = base.store.getState(),
            actualCall = currentState.phone.calls[callId] || currentState.phone.dialing[callId],
            transaction = currentState.transaction.list[actualCall.transactionId];

          if (transaction && transaction.status === thc.TRANSACTION_STATUS.PREVIEW) {
            this.makeContactCall(actualCall);
          } else {
            this.makeCall(actualCall);
          }
        },
        // Acciones a realizar al aceptar la llamada recibida como consecuencia de un servicio de previsualización
        acceptPreviewCall: function(cId) {
          this.launchCall(cId);
        },
        // Acciones a realizar al rechazar la llamada recibida como consecuencia de un servicio de previsualización
        rejectPreviewCall: function(cId) {
          //base.actions.rejectPreviewCall(cId);
          this.hangPreviewCall();
        },
        /**
         * Al colgar una llamada, esta función determina al servicio rest al que llamar en base a si dicha llamada pertenecía a un servicio de previsualización o no
         **
         * @author acorrales
         */
        clearCall: function(cId) {
          var currentState = base.store.getState(),
            actualCall = currentState.phone.calls[cId] || currentState.phone.calls[currentState.phone.active],
            transaction = currentState.transaction.list[actualCall.transactionId];

          if (transaction && transaction.id === actualCall.cId && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
            this.clearAllCalls();
          } else {
            // Se cuelga exclusivamente la llamada actual
            base.actions.clearCall();
          }
        },
        /**
         * Se cuelgan todas las llamadas (tanto la fantasma, en caso de estar en una sesión de Preview, como todas las demás)
         **
         * @author acorrales
         */
        clearAllCalls: function() {
          thc.big.rest.clearAllCalls().catch(function(clearCallError) {
            base.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error colgando llamadas: ' + clearCallError
              }
            });
          });
        },
        // Cuelgue de la llamada Preview
        hangPreviewCall: function(cId) {
          thc.big.rest.clearCall({
            cid: cId
          });
        },
        // Esta función se invoca exclusivamente para realizar las llamadas salientes de un servicio Preview
        makeContactCall: function(actualCall) {
          var internalBinary = base.util.call.isInternal({
            type: thc.CALL_TYPE.OUTBOUND,
            dnis: actualCall.phone
          }) ? "0" : "1";

          thc.big.rest.makeContactCall({
              dialednumber: actualCall.phone,
              userinfo: '',
              serviceId: actualCall.campaignId,
              phonetype: internalBinary
            })
            .then(function() {
              base.store.reduceStore(function(state) {
                state.phone.dialing = state.phone.dialing.filter(function(call) {
                  return call !== actualCall;
                });

                return state;
              });
            })
            .catch(function(makeCallError) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error realizando llamada: ' + makeCallError
                }
              });
            });
        },
        // Pasos para llamadas salientes no pertenecientes del servicio de Preview: 1. paso de la llamada en Presence, se muestra el selector de servicios
        makeCall: function(dialingCall) {
          var currentState = base.store.getState(),
            transaction = currentState.transaction.list[currentState.transaction.active],
            phone = currentState.phone;


          if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
            return this.makeCallWithoutService(dialingCall);
          }

          base.store.reduceStore({
            ui: {
              isServiceSelectorShown: true
            }
          });
        },
        // 2. paso de la llamada en Presence, tras seleccionar si usar servicio o no
        makeCallConfirmation: function(dialingCall, service) {
          var phone = base.store.getState().phone,
            newCall = dialingCall || phone.dialing[phone.active];

          if (!service) {
            this.makeCallWithoutService(newCall);
          } else {
            this.makeCallWithService(newCall, service);
          }
          base.store.reduceStore({
            ui: {
              isServiceSelectorShown: false
            }
          });
        },

        // Cancelación de la realización de la llamada
        makeCallCancellation: function() {
          return base.store.reduceStore(function(state) {
            state.ui.isServiceSelectorShown = false;

            state.phone.dialing = state.phone.dialing.filter(function(call) {
              return !call.isClickToDial;
            });

            state.phone.active = base.util.phone.getActiveCall(state.phone);

            if (!state.phone.active && state.phone.active !== '0') {
              state.phone.dialing.push({
                calledDevice: '',
                status: 'STANDBY'
              });

              state.phone.active = '0';
            }

            return state;
          });
        },
        makeCallWithService: function(dialingCall, service) {

          // Siendo una llamada saliente no perteneciente a ningún servicio al comienzo de la misma, acciones a realizar tras seleccionar el servicio al que se determina
          // que va a pertenecer
          var phone = base.store.getState().phone,

            newCall = dialingCall || phone.dialing[phone.active],
            internalBinary = base.util.call.isInternal({
              type: thc.CALL_TYPE.OUTBOUND,
              dnis: newCall.dialedNumber || newCall.calledDevice
            }) ? "0" : "1";

          thc.big.rest.requestOutboundACDCall({
              phone: newCall.calledDevice,
              userinfo: '',
              serviceid: service,
              contactname: '',
              contactdescription: '',
              phonetype: internalBinary
            })
            .then(function() {
              phone.dialing = phone.dialing.filter(function(call) {
                return call !== dialingCall;
              });

              base.store.reduceStore({
                phone: phone
              }, base.callTreeReducer);
            })
            .catch(function(makeCallError) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error realizando llamada: ' + makeCallError
                }
              });
            });
        },
        makeCallWithoutService: function(dialingCall) {

          // Siendo una llamada saliente no perteneciente a ningún servicio al comienzo de la misma, acciones a realizar tras determinar que no va a pertenecer a ningún
          // servicio. Ahora mismo el único cambio es que no se envía dicha información en la petición REST
          var phone = base.store.getState().phone,

            newCall = dialingCall || phone.dialing[phone.active],
            internalBinary = base.util.call.isInternal({
              type: thc.CALL_TYPE.OUTBOUND,
              dnis: newCall.dialedNumber || newCall.calledDevice
            }) ? "0" : "1";

          thc.big.rest.makeCall({
              dialednumber: newCall.calledDevice ? newCall.calledDevice : phone.dialing[newCall].calledDevice,
              userinfo: '',
              phonetype: internalBinary
            })

            .then(function() {
              phone.dialing = phone.dialing.filter(function(call) {
                return call !== dialingCall;
              });

              base.store.reduceStore({
                phone: phone
              }, base.callTreeReducer);
            })
            .catch(function(makeCallError) {
              base.store.reduceStore({
                notifications: {
                  show: true
                },
                error: {
                  type: 'EVENT',
                  message: 'Error realizando llamada: ' + makeCallError
                }
              });
            });
        },
        confirmCall: function() {

          // Función que determina las acciones a realizar al pulsar el botón que ejecuta la acción de descolgar/emitir una llamada
          var phone = base.store.getState().phone,
            activeCall = phone.calls[phone.active];

          if (activeCall) {
            base.actions.answerCall(activeCall);
          } else if (phone.dialing[phone.active]) {
            this.makeCall(phone.dialing[phone.active]);
          }
        },
        filterCampaigns: function(value) {

          // Filtra los servicios por nombre
          base.actions.filterCampaigns(value);
        },
        //Métodos carga de trabajo omnichannel
        setWorkBusyFromOc: function(customStateBusy){
          var ready = base.store.getState().services.ready;
          if(ready){
            this.notReadyAll(customStateBusy);
          }
          return ready;
        },
        setWorkNotBusyFromOc: function(previousState){
          var ready = base.store.getState().services.ready;
          if(!ready && previousState){
            this.readyAll();
          }
        },
        //
        clickToDial: function(callId) {

          var phone = base.store.getState().phone;
          var newCall = {
            cId: callId,
            //ani:  ,
            dnis: callId,
            calledDevice: callId,
            isClickToDial: true,
            status: "STANDBY"
          };

          //1.1 consultation call
          if (phone.calls[phone.active]) {
            base.actions.consultationCall(newCall); //datos llamada

          } else {

            //1.2.1 se añade línea
            if (phone.dialing[phone.active].calledDevice) {
              base.store.reduceStore(function(state) {
                state.phone.dialing.push(newCall);
                state.phone.active = state.phone.dialing.length - 1;
                return state;
              });
            } else {
              base.store.reduceStore(function(state) {
                state.phone.dialing[phone.active] = newCall;
                return state;
              });
            }
            //1.2.2 mostramos modal
            base.store.reduceStore({
              ui: {
                isServiceSelectorShown: true
              }
            });
          }
        },
      },
      events: {
        onHandshakeSuccess: function(isManualHandshake) {
          var loginPromise = Promise.resolve(true);

         
          // 1 - Si es un handshake manual, se debe iniciar sesión
          if (isManualHandshake) {
            loginPromise = thc.big.rest.login().catch(function(loginErrors) {
              thc.big.stop();



              base.store.reduceStore({
                isLoading: false,
                error: {
                  type: 'LOGIN',
                  message: 'Error realizando login: ' + loginErrors
                },
                overlay: {
                  show: false
                }
              });

              return Promise.reject(loginErrors);
            });
          }

          loginPromise.then(function() {
            return Promise.all([
              thc.big.rest.getState(),
              thc.big.rest.getStatusCalls(),
              thc.big.rest.getSessionInfo(),
              thc.big.rest.getCustomButtons(),
              thc.big.rest.getCurrentOutboundContact().catch(function(error) {
                return {};
              })
            ]);
          }).then(function(getStatusResponses) {

            // 0 - integración omnichannel
            base.util.integration.listeners.addEventListeners(); //se necesita para carga trabajo

            return base.store.reduceStore(function(state) {
              var agentStateResponse = getStatusResponses[0],
                statusCallsResponse = getStatusResponses[1],
                sessionInfo = getStatusResponses[2],
                customButtons = getStatusResponses[3],
                currentContact = getStatusResponses[4],
                phone = state.phone,
                buttonsByCampaign = {},
                alwaysEnabledButtons = [],
                currentTransaction = state.transaction.list[state.transaction.active] || {};

              // 1 - Se marca al agente como logeado
              state.isLoading = false,
                state.session.isLogged = true;
              state.overlay = Object.assign(state.overlay || {}, {
                show: false
              });

              // 2 - Session Info
              sessionInfo.services.campaigns.forEach(function(campaign, index) {
                sessionInfo.services.campaigns[index].customButtons = [].concat(customButtons || []);
              });

              state.services.campaigns = sessionInfo.services.campaigns;
              state.session.agentName = sessionInfo.session.agentName;
              state.ui.sessionTransactionResult = true;

              // 3 - Transacción
              // 3.1 La transacción actual debe corresponderse con el contacto actual
              //if (!currentTransaction.id || currentTransaction.id !== currentContact.callId) {
              if (currentContact.callId) { // && !state.transaction.list[currentContact.callId]) {
                state.transaction.list[currentContact.callId] = Object.assign(state.transaction.list[currentContact.callId] || {}, {
                  id: currentContact.callId,
                  contact: currentContact,
                  type: thc.TRANSACTION_TYPE.SESSION,
                  status: thc.TRANSACTION_STATUS.ACTIVE,
                  campaignId: currentContact.serviceId
                });

                state.transaction.list[currentContact.callId].context = state.transaction.list[currentContact.callId].context || {};
                state.transaction.list[currentContact.callId].callResult = state.transaction.list[currentContact.callId].callResult || {};

                state.transaction.active = currentContact.callId;
                currentTransaction = state.transaction.list[state.transaction.active];
              } else {
                util.object.forEach(state.transaction.list, function(id, transaction) {
                  if (transaction.type === thc.TRANSACTION_TYPE.SESSION) {
                    delete state.transaction.list[id];
                  }
                });

                state.transaction.active = '';
              }
              //}

              // 4 - Calls
              var activeCallId = '',
                currentCallIds = {};

              statusCallsResponse.calls.forEach(function(call) {
                // 4.1 Si la llamada no existe
                if (!phone.calls[call.cid]) {
                  phone.calls[call.cid] = {
                    cId: call.cid,
                    userInfo: call.userinfo || {},
                    dnis: call.calleddevice,
                    ani: call.callingdevice,
                    //Call purpose?
                    callTime: 0,
                    type: statusCallsResponse.extension === call.callingdevice ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND,
                    holdTime: 0
                  };
                }

                if (!phone.calls[call.cid].transactionId) {
                  phone.calls[call.cid].transactionId = state.transaction.active || call.cid;
                }

                if (call.isselected) {
                  phone.active = call.cid;
                }

                if (call.callstate === 'ACTIVE') {
                  phone.calls[call.cid].status = 'ESTABLISHED';
                } else if (call.callstate === 'HELD') {
                  phone.calls[call.cid].status = 'HELD';
                } else {
                  phone.calls[call.cid].status = 'UNKNOWN';
                }

                currentCallIds[call.cid] = true;
              });


              // 4.2 - Aquellas llamadas finalizadas, se verifica si existe un log asociado en cuyo caso se pasa al estado cleared. Si no es así, se elimina
              util.object.forEach(phone.calls, function(cId, call) {
                if (!currentCallIds[cId]) {
                  if (call.log && call.log.taskId) {
                    call.status = 'CLEARED';
                  } else {
                    delete phone.calls[cId];
                  }
                }
              });

              // 5 - Si existe transacción pero no llamadas se genera una llamada ficticia a partir del callId del contacto que permita cerrarlo
              if (currentTransaction.id && !phone.calls[currentTransaction.id]) {
                phone.calls[currentTransaction.id] = phone.cleared[currentTransaction.id];

                // 5.1 - Si la llamada no estaba previamente eliminada, se genera
                if (!phone.calls[currentTransaction.id]) {
                  phone.calls[currentTransaction.id] = {
                    cId: currentTransaction.id,
                    transactionId: currentTransaction.id,
                    type: currentContact.contactType === 'INBOUND' ? thc.CALL_TYPE.INBOUND : thc.CALL_TYPE.OUTBOUND,
                    status: 'CLEARED',
                    callResult: {},
                    log: {
                      subject: 'Call',
                      disposition: ''
                    }
                  };
                }
              }

              // 6 - Por último, si no existen llamadas, se añade una nueva línea
              if (!phone.dialing.length && util.object.isEmpty(phone.calls)) {
                phone.dialing.push({
                  calledDevice: '',
                  status: 'STANDBY'
                });
                phone.active = '0';
              }

              return state;
            });

          }).catch(function(errors) {
            thc.big.stop();

            if (!isManualHandshake) {
              base.actions.resetState();
            }

            base.store.reduceStore({
              error: {
                type: 'LOGIN',
                message: 'Error during login:' + errors
              },
              overlay: {
                show: false
              }
            });
          });
        },
        onHandshakeError: function(isManualHandshake, isRestart) {
          if (isRestart) {
            base.actions.resetState();
            //base.actions.init();
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
        /**
         * Gestiona el evento OnAgentStateChanged de BIG, que alerta de un cambio del estado dela gente en centralita
         **
         * @author acorrales, amartinez, jmartinezpisson
         * @override base.events.onAgentStateChanged
         * @param {object} event - Datos del evento OnAgentStateChanged
         * @param {object} event.status - Nuevo estado del agente. Posibles valores: LOGOUT - LOGIN - NOTREADY - NOTREADY - READY - AVAILABLE - WORKNOTREADY - STARTED - STOPPED
         */
        onAgentStateChanged: function(event) {
          var phone = base.store.getState().phone;
          var promesa = Promise.resolve(); //cuidadín con los cambios introducidos, en teoría no debería haber afectado, pero testear.
          // 1 - Se actualiza el estado del agente - no aplica sobre la interfaz
          promesa = promesa.then(function(){
            return base.store.reduceStore({
              agent: {
                state: event.status
              }
            });
          });
          // 2 - En función del estado del agente, se actualiza el estado del agente
          switch (event.status) {
            // 2.1 Cierre de sesión (forzado/manual). Se limpia el estado del softphone y se realiza el deslogeo. TODO: jmartinezpisson => Refactorizar
            case 'LOGOUT':
              promesa = promesa.then(function(){
                return base.store.reduceStore(function(state) {
                  state.phone.calls = {};
                  state.phone.cleared = {};
                  state.phone.dialing.length = 0;
                  state.phone.active = '';
                  state.transaction.list = {};
                  state.transaction.active = '';
                  state.session = Object.assign(state.session, {
                    isLogged: false,
                    isLoggingOut: false
                  });;

                  return state;
                });
              });
              break;

              // 2.2 - Inicio de sesión correcto
            case 'LOGIN':
              promesa = promesa.then(function(){
                return base.store.reduceStore({
                  session: {
                    isLogged: true,
                    isLoggingOut: false
                  }
                });
              });
              break;

              // 2.2 - Agente en estado Ready para sus servicios asignados
            case 'AVAILABLE':
              var campaigns = base.store.getState().services.campaigns;
              for (var i = 0; i < campaigns.length; i++) {
                base.actions.getQCode(campaigns[i].serviceId);
              }

              Promise.all([
                thc.big.rest.getSessionInfo(),
                thc.big.rest.getCustomButtons()
              ]).then(function(results) {
                var sessionInfo = results[0],
                  customButtons = results[1],
                  buttonsByCampaign = {},
                  alwaysEnabledButtons = [];

                sessionInfo.services.campaigns.forEach(function(campaign, index) {
                  sessionInfo.services.campaigns[index].customButtons = [].concat(customButtons || []);
                });
                promesa = promesa.then(function(){
                  return base.store.reduceStore(function(state) {
                    state.services.campaigns = sessionInfo.services.campaigns;
                    state.session.agentName = sessionInfo.session.agentName;
                    return state;
                  });
                });
              }).catch(function(error) {
                promesa = promesa.then(function(){
                  return base.store.reduceStore({
                    notifications: {
                      show: true
                    },
                    error: {
                      type: 'EVENT',
                      message: 'Error recibiendo servicios: ' + error
                    }
                  });
                });
              });
              break;

              // 2.3 - Estado en el que se encuentra el agente cuando se encuentra en estado Preparado para los servicios que tiene disponibles
            case 'STARTED':
              promesa = promesa.then(function(){
                return base.store.reduceStore({
                  ui: {
                    isCampaignsOpened: true
                  }
                });
              });
              break;

              // 2.4 - Agente en estado Not Ready para sus servicios asignados
            case 'STOPPED':
              Promise.all([
                thc.big.rest.getSessionInfo(),
                thc.big.rest.getCustomButtons()
              ]).then(function(results) {
                var sessionInfo = results[0],
                  customButtons = results[1],
                  buttonsByCampaign = {},
                  alwaysEnabledButtons = [];

                sessionInfo.services.campaigns.forEach(function(campaign, index) {
                  sessionInfo.services.campaigns[index].customButtons = [].concat(customButtons || []);
                });

                promesa = promesa.then(function(){
                  return base.store.reduceStore(function(state) {
                    state.services.campaigns = sessionInfo.services.campaigns;
                    state.session.agentName = sessionInfo.session.agentName;
                    return state;
                  });
                });
              }).catch(function(error) {
                base.store.reduceStore({
                  notifications: {
                    show: true
                  },
                  error: {
                    type: 'EVENT',
                    message: 'Error recibiendo servicios: ' + error
                  }
                });
              });

              promesa = promesa.then(function(){
                return base.store.reduceStore(function(state) {
                  state.services.notReadyReasons = [];
                  state.services.ready = false;
                  state.ui.isStateChanging = false;

                  return state;
                });
              });
              break;
          }
          //Integraciones con Salesforce.
          if(!base.store.getState().presence.workLoaded){ //si no hay carga de trabajo
            promesa = promesa.then(function(){
              return base.util.integration.presence.synchronizeStatuses(event.status);
            });
          }

          return promesa;
          
          
        },
        /**
         * Gestiona el evento Established de BIG. En centralitas Presence, el único evento de telefonía cuya recepción está asegurada es el Established,
         * por lo que los demás son simulados a partir de los datos de este evento.
         **
         * @author amartinez, jmartinezpisson
         * @override base.events.onEventEstablished
         * @param {object} event - Evento de BIG emitido
         * @param {String} event.extension - Extension que emite el evento
         * @param {String} event.username - Extension que emite el evento
         * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
         * @param {String} event.calleddevice - Número de teléfono/terminal destino de la llamada. Requerido.
         * @param {String} event.callingdevice -  Número de teléfono/terminal origen de la llamada. Requerido.
         * @param {String} event.userinfo -  Información adicional de la llamada, incluyendo generalmente datos de contexto del sistema teléfonico. Se requiere parseo en formato JSON. Requerido.
         * @param {String} event.reserved - String JSON con información adicional. Por norma general, no incluye información adicional
         */
        onEventEstablished: function(event) {
          var state = base.store.getState(),
            phone = state.phone,
            calls = phone.calls,
            establishedCall = calls[event.cid] || {},
            currentTransaction = state.transaction.list[establishedCall.transactionId] || state.transaction.list[state.transaction.active],
            that = this,
            onEventEstablishedPromise = Promise.resolve();

          // 0 - Si existe AutoAnswer a nivel de centralita Presence, la llamada no ha pasado por el alerting - es imposible saber si se trata de una llamada de servicio
          if (!establishedCall.cId || !establishedCall.isAlerted) {
            onEventEstablishedPromise = that.onEventAlerting(event);
          }
          onEventEstablishedPromise = onEventEstablishedPromise.then(function() {
            return base.store.reduceStore(function(state) {
              var establishedCall = state.phone.calls[event.cid];

              establishedCall.callTime = 0;
              establishedCall.holdTime = 0;
              establishedCall.lastUpdated = new Date();
              establishedCall.status = 'ESTABLISHED';

              return state;
            });
          });



          /*if (!event.isComposed() && (!currentTransaction || currentTransaction.type !== thc.TRANSACTION_TYPE.SESSION)) {
            event.compose({
              with: function(thisEvent, withEvent) {
                return withEvent.name === 'OnEventOutboundCall' || withEvent.name === 'OnEventInboundCall';
              },
              create: function(thisEvent, withEvent) {
                return [Object.assign(withEvent, {
                  cid: thisEvent.cid,
                  userinfo: thisEvent.userinfo,
                  calleddevice: thisEvent.calleddevice,
                  callingdevice: thisEvent.callingdevice,
                  deliveringacd: thisEvent.deliveringacd,
                  answeringdevice: thisEvent.answeringdevice,
                  reddevice: thisEvent.reddevice,
                  queuetime: thisEvent.queuetime,
                })];
              },
              waitTime: 2000
            });

            return onEventEstablishedPromise;
          }*/

          // 1 - Se asignan los datos propios de Presence
          /*calls[event.cid] = Object.assign(calls[event.cid] || {}, {
            cId: event.cid,
            userInfo: userinfo
          });*/

          // 2 - Guardamos verintid (id Grabación) en la llamada
          /*onEventEstablishedPromise = onEventEstablishedPromise.then(function() {
            return thc.big.rest.getRecordingSessionId().then(function(verintid) {
              var phone = base.store.getState().phone,
                calls = phone.calls;

              calls[event.cid] = Object.assign(calls[event.cid] || {}, {
                verintId: verintid
              });

              base.store.reduceStore({
                phone: phone
              });
            }).catch(function(errors) {
              console.log(errors);
            });
          });*/

          // 3 - Obtenemos el calldata, que consiste en los datos de ysuerinfo de trasnferencia que no están disponibles cuando se recibe una llamada
          /*  onEventEstablishedPromise = onEventEstablishedPromise.then(function() {
              return thc.big.rest.getCallData().catch(function() {
                return {
                  uuiKeys: '',
                  uui: ''
                };
              }).then(function(userInfo) {
                var phone = base.store.getState().phone,
                  calls = phone.calls;

                calls[event.cid] = Object.assign(calls[event.cid] || {}, {
                  userInfo: userInfo
                });

                base.store.reduceStore({
                  phone: phone
                });
              }).catch(function(errors) {
                console.log(errors);
              });
            });*/




          return onEventEstablishedPromise.catch(function(error) {
            state.notifications = {
              type: 'error',
              show: true,
              message: error
            };

            return state;
          });
        },
        /**
         * Evento recibido cuando se genera una nueva llamada a la extensión, ya sea entrante (INBOUND) o saliente (OUTBOUND).
         **
         * @author jmartinezpisson, jarina
         * @override base.events.onEventAlerting
         * @param {BigEvent} event - Evento con los datos del OnEventAlerting.
         * @param {String} event.extension - Extension que emite el evento
         * @param {String} event.username - Extension que emite el evento
         * @param {String} event.cid - Call Identifier. Id. de la llamada en el sistema teléfonico. Obligatorio
         * @param {String} event.calleddevice - Número de teléfono/terminal destino de la llamada. Requerido.
         * @param {String} event.callingdevice -  Número de teléfono/terminal origen de la llamada. Requerido.
         * @param {String} event.userinfo -  Información adicional de la llamada, incluyendo generalmente datos de contexto del sistema teléfonico. Se requiere parseo en formato JSON. Requerido.
         * @param {String} event.reserved - String JSON con información adicional. Puede incluir o no el parámetro servicecall, que identifica si una llamada es de servicio. Requerido
         */
        onEventAlerting: function(event) {
          return base.store.reduceStore(function(state) {
            var phone = state.phone,
              calls = state.phone.calls,
              alertingCall = calls[event.cid] || {},
              transaction = state.transaction,
              currentTransaction = state.transaction.list[state.transaction.active] || {},
              onEventAlertingFinishedPromise = Promise.resolve(),
              initLogPromise;

            // 1 - Se actualiza la llamada con los datos del evento, asignando los datos del EventAlerting, y manteniendo los existentes de la llamada
            alertingCall = Object.assign(alertingCall, {
              cId: event.cid,
              dnis: event.calleddevice,
              ani: event.callingdevice,
              callTime: 0,
              holdTime: 0,
              userInfo: Object.assign(alertingCall.userInfo || {}, JSON.parse(event.userinfo || '{}')),
              reserved: Object.assign(alertingCall.reserved || {}, JSON.parse(event.reserved || '{}')),
              status: 'RINGING'
            });

            // 2 - Se clasifica la llamada por tipo y como Inbound/Outbound y como interna
            if (!alertingCall.type) {
              alertingCall.type = event.callingdevice === event.extension ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND;
              alertingCall.isInternal = base.util.call.isInternal(alertingCall);

              // 2.1 - Si la llamada es entrante, se activa el sonido del softphone
              if (alertingCall.type === thc.CALL_TYPE.INBOUND) {
                base.actions.ring();

                // 2.2 - Si es Outbound, gestionamos si se trata parte de una multillamada
              } else {
                // 2 - Se identifica el origen de la llamada como multilllamada, se extrae del marcado de teléfono y se marca como activa
                // 2.1 - Marcado de teléfono
                // Si existe una llamada encolada con número marcado, se marca la nueva llamada como llamada marcada
                phone.dialing = phone.dialing.filter(function(call) {
                  if (call.calledDevice) {
                    alertingCall.partyType = thc.PARTY_TYPE.NONE;

                    return false;
                  }

                  return true;
                });

                // 2.2 - Llamadas de consulta
                // Si existe una consulta encolada, se marca la nueva llamada como consulta
                if (phone.consulting.length) {
                  phone.consulting.pop();
                  alertingCall.partyType = thc.PARTY_TYPE.CONSULT;
                }

                // 2.3 - Llamadas de conferencia
                // Si existe una consulta encolada, se marca la nueva llamada como consulta
                if (phone.conferencing.length) {
                  phone.conferencing.pop();
                  alertingCall.partyType = thc.PARTY_TYPE.CONFERENCE;
                }
              }
            }

            // 3 - Se realiza el tratamiento de la transaccion actual
            // 3.1 - Si la llamada llega con un reserved.serviceCall = true, se trata de una llamada de campaña y por tanto generamos una transacción de tipo sesión
            if (alertingCall.reserved.servicecall) {
              transaction.list[event.cid] = {
                id: event.cid,
                type: thc.TRANSACTION_TYPE.SESSION,
                status: thc.TRANSACTION_STATUS.ACTIVE
              };
              currentTransaction = transaction.list[event.cid];

              // 3.2 - Si la llamada cuenta con transacción y esta existe, esta se marca como la transacción actual
            } else if (alertingCall.transactionId && transaction.list[alertingCall.transactionId]) {
              currentTransaction = transaction.list[alertingCall.transactionId];

              // 3.3 - Por último si no existe transacción en curso, se genera una nueva de tipo llamada cuyo origen es la propia llamada
            } else if (!currentTransaction.id) {
              transaction.list[event.cid] = {
                id: event.cid,
                type: thc.TRANSACTION_TYPE.CALL,
                status: thc.TRANSACTION_STATUS.ACTIVE
              };
              currentTransaction = transaction.list[event.cid];
            }

            // 4 - Se parsea el UUI del userinfo
            currentTransaction.context = Object.assign(currentTransaction.context || {}, {
              uui: base.util.call.uui.parse(alertingCall.userInfo.uui || '')
            });

            // 5 - Se actualiza la llamda en el árbol de llamadas, se marca la llamada y transacción actual como activa, y se elimina la linea STANDBY por defecto si aplica
            //     Se marca también que la llamada ha sido alertada
            alertingCall.isAlerted = true;
            alertingCall.transactionId = currentTransaction.id;
            calls[event.cid] = alertingCall;

            currentTransaction.status = thc.TRANSACTION_STATUS.ACTIVE;
            transaction.active = currentTransaction.id;
            phone.active = event.cid;

            if (base.util.phone.checkForDefaultLine(phone)) {
              phone.dialing = [];
            }

            // 6 - Generación del log/tarea asociada a la llamada y obtención del Id. de Verint de grabación
            // 6.1 - Obtención del verintId y log
            onEventAlertingFinishedPromise = thc.big.rest.getRecordingSessionId().catch(function() {
              return '';
            }).then(function(verintId) {
              calls[event.cid].verintId = verintId || '';

              // 6.2 - Inicialización del log
              return base.util.call.log.init(calls[event.cid]);
            }).then(function(task) {
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
                base.util.integration.presence.setBusy(true), // Se fuerza que Onmnichannel marque el estado Ocupado
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
            if (currentTransaction.id === event.cid) {
              // 7.1 - Se obtiene el contacto de la transacción directamente de Presence, si es elevento pertinente, si aplica
              if (!currentTransaction.contact) {
                onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
                  return thc.big.rest.getCurrentOutboundContact();
                }).catch(function() {
                  // TODO: Cambiar a transacción de tipo call??
                  return {};
                }).then(function(contact) {
                  if (contact.callId) {
                    currentTransaction.type = thc.TRANSACTION_TYPE.SESSION;
                    currentTransaction.contact = contact;
                    currentTransaction.campaignId = contact.serviceId;

                    calls[contact.callId] = Object.assign(calls[contact.callId] || {}, {
                      transactionId: contact.callId,
                      cId: contact.callId,
                      phone: contact.phone,
                      vdn: contact.vdn,
                      vdnDesc: contact.vdnDesc,
                      skill: contact.skill,
                      skillDesc: contact.skillDesc,
                      id: contact.id,
                      uCId: contact.ucid,
                      campaignId: contact.serviceId
                    });
                  }
                });
              }

              // 7.2 - Lanzamos la búsqueda del contexto: como en este punto, el contacto no tiene todos los datos necesarios para la búsqueda, solo se lanza si la transacción es de tipo CALL
              onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
                if (currentTransaction.type === thc.TRANSACTION_TYPE.SESSION) {
                  return {};
                }

                return base.util.call.getContext({
                  call: calls[event.cid],
                  transaction: currentTransaction
                });
              }).then(function(callContext) {
                currentTransaction.context = Object.assign(currentTransaction.context || {}, callContext.context || {});
                calls[event.cid].log = Object.assign(calls[event.cid].log || {}, callContext.log || {});
              });
            }

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
         * Gestiona el cuelgue de una llamada
         **
         * @author amartinez, jmartinezpisson
         * @override base.events.onEventCallConnectionCleared
         * @param {object} event - Datos del evento
         */
        onEventCallConnectionCleared: function(event) {
          return base.store.reduceStore(function(state) {
            if (state.transaction.active === event.cid && state.transaction.list[state.transaction.active]) {
              state.transaction.list[state.transaction.active].status = thc.TRANSACTION_STATUS.CLEARED;
            }

            return state;
          }).then(function() {
            return base.events.onEventCallConnectionCleared(event);
          });
        },
        /**
         * Gestiona el evento onEventOutboundCall de BIG, emitido cuando se carga un contacto de servicio/campaña de tipo Outbound.
         * Este evento identifica el inicio de una transacción real en Presence, asociando el correspondiente contacto a la transacción
         **
         * @author jmartinezpisson
         * @param {BigEvent} event - Datos del evento
         */
        onEventOutboundCall: function(event) {
          var state = base.store.getState(),
            eventContact = JSON.parse(event.contact) || {},
            contactCall = state.phone.calls[eventContact.callId] || {},
            currentTransaction = state.transaction.list[contactCall.transactionId] || state.transaction.list[state.transaction.active],
            that = this,
            onEventInboundCallPromise = Promise.resolve();

          // 0 - Si existe AutoAnswer a nivel de centralita Presence, la llamada no ha pasado por el alerting - es imposible saber si se trata de una llamada de servicio
          if (!contactCall.cId || !contactCall.isAlerted) {
            onEventInboundCallPromise = that.onEventAlerting(Object.assign(event, {
              extension: event.extension,
              callingdevice: eventContact.phone,
              calleddevice: event.extension,
              cid: eventContact.cid,
              reserved: JSON.stringify({
                servicecall: true
              }),
              userinfo: ''
            }));
          }

          // 1 - Se procesa el contacto activo
          return base.store.reduceStore(function(state) {
            var phone = state.phone,
              calls = state.phone.calls,
              transaction = state.transaction,
              settings = thc.settings.get(),
              eventContact = JSON.parse(event.contact) || {},
              call = calls[eventContact.cid] || {
                cId: eventContact.cid,
                uCId: event.ucid,
                deliveringAcd: event.ucid,
                userInfo: event.userinfo ? JSON.parse(event.userinfo || '{}') : {},
                answeringDevice: event.answeringdevice,
                redDevice: event.reddevice,
                queueTime: event.queuetime,
                lastUpdated: new Date(),
                contact: {}
              };

            // 1 - Se actualiza la transacción, identificando que se encuentra en una transacción de tipo sesión
            transaction.active = eventContact.cid;
            transaction.list[eventContact.cid] = {
              id: eventContact.cid,
              type: thc.TRANSACTION_TYPE.SESSION,
              campaignId: eventContact.serviceId,
              contact: Object.assign(call.contact || {}, {
                callState: eventContact.callState,
                contactId: eventContact.contactId,
                callerId: eventContact.callerId,
                lastQCodeId: eventContact.lastQCodeId,
                lastAgent: eventContact.lastAgent,
                lastHandlingDate: eventContact.lastHandlingDate,
                sourceId: eventContact.sourceId,
                serviceId: eventContact.serviceId,
                contactType: eventContact.contactType,
                defaultScheduledDateTime: eventContact.defaultScheduledDateTime,
                capturedLogin: eventContact.capturedLogin,
                name: eventContact.name,
                capturingAgent: eventContact.capturingAgent,
                customData1: eventContact.customData1,
                customData2: eventContact.customData2,
                customData3: eventContact.customData3,
                lastQCodeDescription: eventContact.lastQCodeDescription,
                vdn: eventContact.vdn,
                vdnDesc: eventContact.vdnDesc,
                callerName: eventContact.callerName,
              })
            };

            // 2 - Asignamos los datos correspondientes a la llamada fantasma, incluyendo la información correspondiente al contacto
            calls[eventContact.cid] = Object.assign(call, {
              transactionId: eventContact.cid,
              type: thc.CALL_TYPE.OUTBOUND,
              context: {},
              phone: eventContact.phone,
              ani: event.extension,
              dnis: eventContact.phone,
              serviceCall: true,
              isInternal: false,
              vdn: event.vdn || eventContact.vdn,
              vdnDesc: eventContact.vdnDesc,
              provider: event.provider,
              username: event.username,
              skill: event.skill || eventContact.skill,
              skillDesc: event.skillDesc || eventContact.skillDesc,
              id: eventContact.id,
              uCId: eventContact.ucid,
              campaignId: eventContact.serviceId
            });

            calls[eventContact.cid].status = calls[eventContact.cid].status || 'ESTABLISHED';
            phone.active = eventContact.cid;

            if (base.util.phone.checkForDefaultLine(phone)) {
              phone.dialing.pop();
            }

            // 3 - En función del estado de la llamada "Fantasma", la transacción ha de identificarse como Activa/En Preview/Cerrada
            switch (calls[eventContact.cid].status) {
              case 'HELD':
                transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.ACTIVE;
                break;
              case 'CLEARED':
                transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.CLEARED;
                break
              default:
                transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.ACTIVE;
                break;
            }

            if (eventContact.contactType === 'PREVIEW') {
              transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.PREVIEW;
              transaction.list[eventContact.cid].sessionStatus = thc.TRANSACTION_STATUS.PREVIEW;
            }

            // 6 - Generación del contexto de la llamada/transacción
            return base.util.call.getContext({
              call: calls[eventContact.cid],
              transaction: transaction.list[eventContact.cid]
            }).then(function(callContext) {
              // 6.1 - Asignamos el contexto a la transacción
              transaction.list[eventContact.cid].context = Object.assign(transaction.list[eventContact.cid].context || {}, callContext.context);
              calls[eventContact.cid].log = Object.assign(calls[eventContact.cid].log || {}, callContext.log);

              return state;
            }).catch(function(error) {
              state.notifications = {
                type: 'error',
                message: error,
                show: true
              };

              return state;
            });
          });
        },
        /**
         * Gestiona el evento onEventInboundCall de BIG, emitido cuando se carga un contacto de servicio/campaña de tipo Inbound.
         * Este evento identifica el inicio de una transacción en Presence
         **
         * @author amartinez, jmartinezpisson
         * @param {object} event - Datos del evento
         */
        onEventInboundCall: function(event) {
          var state = base.store.getState(),
            eventContact = JSON.parse(event.contact) || {},
            contactCall = state.phone.calls[eventContact.callId] || {},
            currentTransaction = state.transaction.list[contactCall.transactionId] || state.transaction.list[state.transaction.active],
            that = this,
            onEventInboundCallPromise = Promise.resolve();

          // 0 - Si existe AutoAnswer a nivel de centralita Presence, la llamada no ha pasado por el alerting - es imposible saber si se trata de una llamada de servicio
          if (!contactCall.cId || !contactCall.isAlerted) {
            onEventInboundCallPromise = that.onEventAlerting(Object.assign(event, {
              extension: event.extension,
              callingdevice: eventContact.phone,
              calleddevice: event.extension,
              cid: eventContact.callId,
              reserved: JSON.stringify({
                servicecall: true
              }),
              userinfo: ''
            }));
          }

          onEventInboundCallPromise = onEventInboundCallPromise.then(function() {
            return base.store.reduceStore(function(state) {
              var phone = state.phone,
                calls = state.phone.calls,
                transaction = state.transaction,
                settings = thc.settings.get(),
                eventContact = JSON.parse(event.contact) || {},
                call = calls[eventContact.callId] || {
                  cId: eventContact.cid,
                  uCId: event.ucid,
                  deliveringAcd: event.ucid,
                  userInfo: JSON.parse(event.userinfo || '{}'),
                  answeringDevice: event.answeringdevice,
                  redDevice: event.reddevice,
                  queueTime: event.queuetime,
                  lastUpdated: new Date(),
                  contact: {}
                };

              eventContact.cid = eventContact.callId;

              // 1 - Se actualiza la transacción, identificando que se encuentra en una transacción de tipo sesión
              transaction.active = eventContact.cid;
              transaction.list[eventContact.cid] = {
                id: eventContact.cid,
                type: thc.TRANSACTION_TYPE.SESSION,
                campaignId: eventContact.serviceId
              };

              transaction.list[eventContact.cid].contact = Object.assign(transaction.list[eventContact.cid].contact || {}, {
                callState: eventContact.callState,
                contactId: eventContact.contactId,
                callerId: eventContact.callerId,
                lastQCodeId: eventContact.lastQCodeId,
                lastAgent: eventContact.lastAgent,
                lastHandlingDate: eventContact.lastHandlingDate,
                sourceId: eventContact.sourceId,
                serviceId: eventContact.serviceId,
                contactType: eventContact.contactType,
                defaultScheduledDateTime: eventContact.defaultScheduledDateTime,
                capturedLogin: eventContact.capturedLogin,
                name: eventContact.name,
                capturingAgent: eventContact.capturingAgent,
                customData1: eventContact.customData1,
                customData2: eventContact.customData2,
                customData3: eventContact.customData3,
                lastQCodeDescription: eventContact.lastQCodeDescription,
                vdn: eventContact.vdn,
                vdnDesc: eventContact.vdnDesc,
                callerName: eventContact.callerName,
              });

              // 2 - Asignamos los datos correspondientes a la llamada fantasma, incluyendo la información correspondiente al contacto
              calls[eventContact.cid] = Object.assign(call, {
                transactionId: eventContact.cid,
                cId: eventContact.cid,
                type: thc.CALL_TYPE.INBOUND,
                phone: eventContact.phone,
                ani: eventContact.phone,
                dnis: event.extension,
                vdn: event.vdn || eventContact.vdn,
                vdnDesc: eventContact.vdnDesc,
                provider: event.provider,
                username: event.username,
                skill: event.skill || eventContact.skill,
                skillDesc: event.skillDesc || eventContact.skillDesc,
                id: eventContact.id,
                uCId: eventContact.ucid,
                campaignId: eventContact.serviceId
              });

              state.phone.active = eventContact.cid;
              calls[eventContact.cid].status = calls[eventContact.cid].status || 'ESTABLISHED';

              if (base.util.phone.checkForDefaultLine(phone)) {
                phone.dialing.pop();
              }

              // 3 - En función del estado de la llamada "Fantasma", la transacción ha de identificarse como Activa/En Preview/Cerrada
              switch (call.status) {
                case 'HELD':
                  transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.ACTIVE;
                  break;
                case 'CLEARED':
                  transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.CLEARED;
                  break
                default:
                  transaction.list[eventContact.cid].status = thc.TRANSACTION_STATUS.ACTIVE;
                  break;
              }


              // 4 - Generación del contexto de la llamada/transacción
              return base.util.call.getContext({
                call: calls[eventContact.cid],
                transaction: transaction.list[eventContact.cid]
              }).then(function(callContext) {
                transaction.list[eventContact.cid].context = Object.assign(transaction.list[eventContact.cid].context || {}, callContext.context);
                calls[eventContact.cid].log = Object.assign(calls[eventContact.cid].log || {}, callContext.log);

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
          });

          return onEventInboundCallPromise;
        },
        /**
         * Gestiona la recepción de un evento OnEventTransferred, recibido cuando una llamada es transferida. En Presence no ser reciben todos los parámetros del evento, pero se sabe de antemano que la transferencia es siempre hacia afuera
         **
         * @author jmartinezpisson
         * @override base.events.onEventTransferred
         * @param {BigEvent} event - Evento de BIG con los datos del OnEventTransferred.
         * @param {String} event.extension - Extensión del usuario actual. Obligatorio. No llega en Presence
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
          event.transferingdevice = event.extension;

          return base.events.onEventTransferred(event).then(function() {
            // 2 - Se verifica si la transacción es de tipo sesión Preview, y si lo es, se elimina la llamada transferida
            return base.store.reduceStore(function(state) {
              var transferredCall = state.phone.calls[event.primarycid] || {},
                callTransaction = state.transaction.list[transferredCall.transactionId] || {};

              if (transferredCall.cId && callTransaction.id && callTransaction.contact && callTransaction.contact.contactType === 'PREVIEW') {
                delete state.phone.calls[transferredCall.cId];
                state.phone.cleared[transferredCall.cId] = transferredCall;
                state.phone.active = base.util.phone.getActiveCall(state.phone);
              }

              state.notifications = {
                show: true,
                message: 'Call transferred',
                type: 'success'
              };

              return state;
            });
          });
        },
        /**
         * Gestiona la recepción de un evento onEventConferenced, recibido cuando una llamada es transferida o se recibe una llamada transferida desde otro origen.
         * Generalmente, solo es necesaria la gestión de la transferencia desde el terminal del usuario a otro destino.
         **
         * @author jmartinezpisson
         * @override base.events.onEventConferenced
         * @param {BigEvent} event - Evento de BIG con los datos del onEventConferenced.
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
          if (event.extension === event.confcontroller && event.extension !== event.addedparty) {
            return base.store.reduceStore(function(state) {
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
            return base.store.reduceStore(function(state) {
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
          return base.store.reduceStore(function(state) {
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
         * Gestiona el evento onEventFinalizeContact de BIG, recibido una vez se ha marcado un contacto como finalizado.
         * En Presence, el cierre de contacto identifica el final de la transacción.
         **
         * @author jmartinezpisson
         * @param {object} event - Datos del evento
         */
        onEventFinalizeContact: function(event) {
          base.store.reduceStore(function(state) {
            util.object.forEach(state.transaction.list, function(transactionId, transaction) {
              if (transaction.status === thc.TRANSACTION_STATUS.CLEARED) {
                delete state.transaction.list[transactionId];
              } else {
                transaction.active = transactionId;
              }
            });

            return state;
          });
        },
        /**
         * Gestiona el evento onEventPresenceServiceChange de BIG, emitido por Presence cada vez que un servicio ve modificado su estado.
         * Dicho cambio requiere refrescar todos los servicios
         **
         * @author jmartinezpisson
         * @param {object} event - Datos del evento
         */
        onEventPresenceServiceChange: function(event) {
          Promise.all([
            thc.big.rest.getSessionInfo(),
            thc.big.rest.getCustomButtons()
          ]).then(function(results) {
            var sessionInfo = results[0],
              customButtons = results[1],
              buttonsByCampaign = {},
              alwaysEnabledButtons = [];

            /*customButtons.forEach(function(customButton) {
              if (customButton.alwaysEnabled) {
                alwaysEnabledButtons.push(customButton);
              } else {
                buttonsByCampaign[customButton.serviceId] = buttonsByCampaign[customButton.serviceId] || [];
                buttonsByCampaign[customButton.serviceId].push(customButton);
              }
            });

            sessionInfo.services.campaigns.forEach(function(campaign, index) {
              sessionInfo.services.campaigns[index].customButtons = [].concat(alwaysEnabledButtons).concat(buttonsByCampaign[campaign.serviceId] || []);
            });*/

            sessionInfo.services.campaigns.forEach(function(campaign, index) {
              sessionInfo.services.campaigns[index].customButtons = [].concat(customButtons || []);
            });

            base.store.reduceStore(function(state) {
              state.services.campaigns = sessionInfo.services.campaigns;
              state.session.agentName = sessionInfo.session.agentName;

              return state;
            });
          }).catch(function(error) {
            base.store.reduceStore({
              notifications: {
                show: true
              },
              error: {
                type: 'EVENT',
                message: 'Error recibiendo servicios: ' + error
              }
            });
          });
        },
        onEventOutOfService: function(event) {
          base.store.reduceStore({
            session: {
              isLogged: false,
              isLoggingOut: false,
              extension: "",
              username: "",
              password: ""
            },
            error: {
              type: 'EVENT',
              message: 'Fuera de servicio. '
            }
          });
          thc.big.stop();
        }
      }
    };
  });
})(window, document, window.thc.util, window.sforce, window.console, window.localStorage, window.jQuery);
