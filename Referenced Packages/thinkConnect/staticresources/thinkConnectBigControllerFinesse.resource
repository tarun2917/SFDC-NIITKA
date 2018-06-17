(function(scope, document, sforce, console, localStorage, $) {
    'use strict';

    if(!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
        throw new Error('Big controller module not defined');
    }

    scope.thc.big.registerControllerMixin('finesse', function(controller) {
        var base = controller;

        var callTreeReducer = function(state, changes) {
            if (state.phone && changes.phone) {
                state.phone = changes.phone;
            }

            return state;
        }

        function formatStatusCalls (calls) {
            var agentExtension;
            base.store.reduceStore({}, function(state, newState) { agentExtension = state.session.extension; return state; });
            for (var i = 0; i < calls.length; i++) {
                var call = calls[i];
                if (call.fromaddress) {
                    call.callingdevice = call.fromaddress;
                    delete call.fromaddress;
                }
                if (call.toaddress) {
                    call.calleddevice = call.toaddress;
                    delete call.toaddress;
                }
                call.partydevices = [];
                var ownParticipant;
                call.participants.forEach(function(val) {
                    call.partydevices.push( { partydevice: val.mediaaddress });
                    if(val.mediaaddress === agentExtension) {
                        ownParticipant = val;
                    }
                });
                if (call.mediaproperties && call.mediaproperties.calltype) {
                    call.callType = call.mediaproperties.calltype === 'IN'? 'Inbound': 'Outbound';
                }
                if (ownParticipant.state) {
                    switch (ownParticipant.state) {
                        case 'INITIATING':
                        case 'INITIATED':
                        case 'ALERTING':
                            call.status = 'ALERTING';
                            break;
                        case 'ACTIVE':
                            call.status = 'ESTABLISHED';
                            break;
                        case 'FAILED':
                        case 'DROPPED':
                        case 'WRAP_UP':
                            call.status = 'CLEARED';
                            break;
                        case 'HELD':
                            call.status = 'HELD';
                            break;
                        default:
                            call.status = 'ESTABLISHED';
                    }
                }
                call.ucid = call.cid;
                calls[i] = call;
            }
            return calls;
        };

        return {
            actions: {
                login: function(credentials) {
                    // 1 - Se desconecta por precaución CometD
                    thc.big.stop();

                    // 2 - Se procesa el formulario de login y se almacena en el estado
                    if(credentials.extension) {
                        base.store.reduceStore({
                            isLoading: true,
                            error: null,
                            session: {
                                extension: credentials.extension,
                                username: credentials.username,
                                password: credentials.password
                            },
                            ui: {
                                isAgentStatePanel: true,
                                showCallResultIn: ['ESTABLISHED']
                            },
                            services: {
                                show: false
                            }
                        });

                        thc.big.start({
                            extension: credentials.extension,
                            username: credentials.username,
                            password: credentials.password,
                            linkType: 'ciscofinesse'
                        });

                    } else {
                        base.store.reduceStore({
                            error: {
                                type: 'LOGIN',
                                message: scope.$Label.Softphone_introduce_data
                            }
                        });
                    }
                },
                logout: function(reason) {
                    // 1 - Si existe una razón se realiza el logout con esa razon
                    if (reason) {
                        thc.big.rest.logout({
                            reason: reason
                        })
                        .then(function(logoutResult) {
                            thc.big.stop();


                            // 1.1 - integración omnichannel
                            base.util.integration.listeners.removeEventListeners();  //se necesita para carga trabajo
                            // Como estamos en Presence, ocultamos el botón de campañas/servicios
                            //$('#campaignColumn').hide();

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
                    // 2 - Si no existe razón se recuperan las razones del servidor
                    } else {
                        thc.big.rest.getReasonsCodes({
                            category: 'LOGOUT'
                        })
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
                                var formattedReasons = [];
                                reasons.forEach(function(reason) {
                                    formattedReasons.push({
                                        name: reason.label,
                                        code: reason.code
                                    });
                                });
                                base.store.reduceStore({
                                    session: {
                                        logoutReasons: formattedReasons,
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
                    base.store.reduceStore({
                        session: {
                            isLogged: true,
                            isLoggingOut: false
                        }
                    });
                },
                setAgentState: function(state) {
                    console.log('Agent State ' + state);

                    if(state === '-1') {
                        thc.big.rest.setReady()
                        .catch(function(err) {

                        });
                    } else if (state === '0') {
                        thc.big.rest.setNotReady()
                        .catch(function(err) {

                        });
                    } else {
                        thc.big.rest.setNotReady({
                            reasonid: state
                        })
                        .catch(function(err) {

                        });
                    }
                },
                getWrapupCodes: function() {
                    thc.big.rest.getWrapupReasons()
                    .then(function (wrapupReasons) {
                        if (wrapupReasons && wrapupReasons.length > 0) {
                            var formattedReasons = {};
                            wrapupReasons.forEach(function (reason) {
                                formattedReasons[reason.label] = reason.id;
                            });

                            base.store.reduceStore({
                                services: {
                                    wrapups: formattedReasons
                                }
                            }, function (state, newState) {
                                state.services = state.services || {};
                                state.services.wrapups = newState.services.wrapups;
                                return state;
                            });
                        }
                    });
                },
                getNotReadyReasons: function() {

                },
                getStatusCalls: function() {
                    thc.big.rest.getStatusCalls()
                    .then(function (calls) {
                        calls = formatStatusCalls(calls);
                        base.actions.processStatusCalls(calls);
                    })
                    .catch(function (err) {
                        
                    });
                },
                setCallResult: function(result, callid, isRemote) {
                    var phone = base.getState().phone;
                    callid = callid || phone.active;
                    if (isRemote) {
                        var calls = phone.calls;

                        calls[callid] = Object.assign(calls[callid] || {}, {
                            callResult: result
                        });

                        base.store.reduceStore({
                            phone: phone
                        }, callTreeReducer);
                        
                        base.store.reduceStore({
                            wrapup: {
                                processing: true
                            }
                        });

                        thc.big.rest.setWrapup({
                            cid: callid,
                            reason: result
                        }).then(function (cid) {
                            base.actions.setCallResult(result, cid);

                            base.store.reduceStore({
                                wrapup: {
                                    processing: false
                                }
                            });
                        });
                    } else {
                        base.actions.setCallResult(result, callid);
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
                },
                //
                confirmCall: function() {
                    var phone = base.store.getState().phone;

                    if (base.util.call.getCurrent()) {
                        base.actions.answerCall(base.util.call.getCurrent());
                    } else if (phone.dialing[phone.active]) {
                        this.makeCall(phone.dialing[phone.active])
                    }
                },
                makeCall: function(dialingCall) {
                    var phone = base.store.getState().phone;
                    var dialingLine = phone.active;
                    var newCall = phone.dialing[phone.active];

                    var formattedNumber = base.util.call.formatPhoneNumber(newCall.calledDevice);

                    thc.big.rest.makeCall({
                        dialednumber: formattedNumber.isValid ? formattedNumber.phoneNumber : newCall.calledDevice,
                        userinfo: ''
                    })
                    .then(function() {
                        phone.dialing[dialingLine] = Object.assign(phone.dialing[dialingLine] || {}, {
                          dnis: newCall.calledDevice,
                          type: 'OUTBOUND',
                          status: 'RINGING'
                        });
                        phone.dialing[dialingLine].isInternal = base.util.call.isInternal(phone.dialing[dialingLine]);

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

            },
            events: {
                onHandshakeSuccess: function(isManualHandshake) {

                    // 1 - Si es un handshake manual, se debe iniciar sesión
                    if(isManualHandshake) {
                        thc.big.rest.login()
                        .then(function(loginResult) {
                            thc.controller.actions.getWrapupCodes();
                            return Promise.all([
                                thc.big.rest.getState(),
                                thc.big.rest.getReasonsCodes({
                                    category: 'NOT_READY'
                                })
                            ]);
                        })
                        .then(function(initializingRequests){

                            // 2 - integraciones Salesforce. isManualhandshake.
                            base.util.integration.presence.synchronizeStatuses("LOGIN");
                            base.util.integration.listeners.addEventListeners();  //se necesita para carga trabajo

                            var auxReasonCodes = thc.settings.get().auxReasonCodes;

                            console.log(initializingRequests);

                            var [state,
                                notReadyReasons] = initializingRequests;

                            // 3. Procesamos el estado de las llamadas
                            setTimeout(thc.controller.actions.getStatusCalls, 1500);
                            setTimeout(thc.controller.actions.getStatusCalls, 2500);

                            // 4. Procesamos los motivos de not ready
                            var reasons = [{
                                label: "Ready",
                                code: "-1"
                            }];

                            if (notReadyReasons.length === 0) {
                                reasons.push({
                                    label: auxReasonCodes.workNotReady? auxReasonCodes.workNotReady : "Not Ready",
                                    code: "0"
                                });
                            } else {
                                notReadyReasons.forEach(function (reason) {
                                    reason._code = reason.code;
                                    reason.code = reason.id;
                                });
                                reasons = reasons.concat(notReadyReasons);
                            }

                            base.store.reduceStore({
                                isLoading: false,
                                session: {
                                    isLogged: true
                                },
                                agent: {
                                    states: reasons
                                }
                            });
                            
                            base.actions.addLine();
                        })
                        .catch(function(loginErrors){
                            thc.big.stop();

                            base.store.reduceStore({
                                isLoading: false,
                                error: {
                                    type: 'LOGIN',
                                    message: 'Error realizando login: ' + loginErrors
                                }
                            });
                        });
                    }
                },
                onHandshakeError: function(isManualHandshake) {
                    if(isManualHandshake) {
                        base.store.reduceStore({
                            error:{
                                type: 'LOGIN',
                                message: 'Error realizando login: No ha sido posible realizar el handshake'
                            },
                            isLoading: false
                        });
                    }
                },
                onAgentStateChanged: function(eventData) {
                    var selectedState = '0';
                    var promesa = Promise.resolve();
                    switch(eventData.status) {
                        case 'NOT_READY':
                            selectedState = eventData.reason!=='-1'? eventData.reason: '0';
                            break;

                        case 'READY':
                            selectedState = '-1';
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
                    
                },
                onEventServiceInitiated: function(eventData) {
                    var phone = base.store.getState().phone;
                    var newCId = eventData.cid;
                    var dialingCall = phone.dialing[phone.active];

                    phone.active = eventData.cid;

                    phone.calls[newCId] = Object.assign(dialingCall || {}, {
                        cId: newCId,
                        ani: eventData.extension,
                        type: 'OUTBOUND',
                        status: 'RINGING'
                    });

                    phone.dialing = phone.dialing.filter(function(call) {
                      return call !== dialingCall;
                    });

                    base.store.reduceStore({
                        phone: phone
                    }, base.callTreeReducer);

                    // Recuperamos los codigos de wrapup al inicio de una llamada saliente
                    thc.controller.actions.getWrapupCodes();

                    base.events.onEventServiceInitiated(eventData);
                },
                onEventOriginated: function(eventData) {
                    var phone = base.store.getState().phone;

                    phone.calls[eventData.cid] = Object.assign(phone.calls[eventData.cid] || {}, {
                        cId: eventData.cid,
                        ani: eventData.callingdevice,
                        dnis: eventData.calleddevice
                    });

                    base.store.reduceStore({
                        phone: phone
                    }, callTreeReducer);

                    base.events.onEventOriginated(eventData);
                },
                onEventAlerting: function(eventData) {
                    var phone = base.store.getState().phone,
                    calls = phone.calls,
                    settings = thc.settings.get();

                    // 1 - Se actualiza la llamda con los datos del evento
                    calls[eventData.cid] = Object.assign(calls[eventData.cid] || {}, {
                        cId: eventData.cid,
                        uCId: eventData.ucid,
                        deliveringAcd: eventData.deliveringacd,
                        userInfo: eventData.userinfo? JSON.parse(eventData.userinfo): '',
                        dnis: eventData.calleddevice,
                        ani: eventData.callingdevice,
                        answeringDevice: eventData.answeringdevice,
                        redDevice: eventData.reddevice,
                        queueTime: eventData.queuetime,
                        callTime: 0,
                        holdTime: 0,
                        status: 'RINGING'
                    });

                    // Recuperamos los codigos de wrapup al inicio de una llamada entrante
                    thc.controller.actions.getWrapupCodes();

                    // 2 - Se identifica si la llamada es interna; si la llamada no se había identificado previamente como OUTBOUND, se considera directamente INBOUND
                    if (!calls[eventData.cid].type) {
                        calls[eventData.cid].type = 'INBOUND';
                        calls[eventData.cid].isInternal = false;
                    }

                    // 4 - Se actualiza el estado de las llamadas
                    base.store.reduceStore({
                        phone: phone
                    });

                    //base.events.onEventAlerting(eventData);
                }
            }
        };
    });
})(window, document, window.sforce, window.console, window.localStorage, window.jQuery);
