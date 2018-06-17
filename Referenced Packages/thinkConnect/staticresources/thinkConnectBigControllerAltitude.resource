(function(scope, document, sforce, console, localStorage, logger, $) {
    'use strict';

    if (!scope.thc || !scope.thc.big || !scope.thc.big.registerControllerMixin) {
        throw new Error('Big controller module not defined');
    }

    scope.thc.big.registerControllerMixin('altitude', function(controller) {
        var base = controller;

        var buttonConfiguration = [{
                // Status: RINGING | Call type: OUTBOUND
                when: function(call) {
                    return call.status === 'RINGING' && call.type === thc.CALL_TYPE.OUTBOUND;
                },
                enabled: ['clear'],
                disabled: ['call', 'hold', 'transferals']
            },
            {
                // Status: RINGING | Call type: INBOUND
                when: function(call) {
                    return call.status === 'RINGING' && call.type !== thc.CALL_TYPE.OUTBOUND;
                },
                enabled: ['call'],
                disabled: ['hold', 'transferals', 'clear']
            },
            {
                // Status: ESTABLISHED | Call party type: NONE
                when: function(call) {
                    return call.status === 'ESTABLISHED' && (!call.partyType || call.partyType === thc.PARTY_TYPE.NONE);
                },
                enabled: ['dtmf', 'clear', 'hold', 'transferals']
            },
            {
                // Status: ESTABLISHED | Call party type: CONFERENCE
                when: function(call) {
                    return call.status === 'ESTABLISHED' && call.partyType && call.partyType === thc.PARTY_TYPE.CONFERENCE;
                },
                enabled: ['dtmf', 'clear', 'remain'],
                disabled: ['conference']
            },
            {
                // Status: ESTABLISHED | Call party type: CONSULT
                when: function(call) {
                    return call.status === 'ESTABLISHED' && call.partyType && call.partyType === thc.PARTY_TYPE.CONSULT;
                },
                enabled: ['dtmf', 'clear', 'remain'],
                disabled: ['transfer']
            },
            {
                // Status: HELD | Call party type: NONE
                when: function(call) {
                    return call.status === 'HELD' && (!call.partyType || call.partyType === thc.PARTY_TYPE.NONE);
                },
                enabled: ['dtmf', 'resume'],
                disabled: ['clear', 'transferals']
            },
            {
                // Status: HELD | Call party type: CONFERENCE | Extend status: RINGING
                when: function(call) {
                    return call.status === 'HELD' && call.partyType && call.partyType === thc.PARTY_TYPE.CONFERENCE && call.extendedStatus !== 'ESTABLISHED';
                },
                enabled: ['dtmf', 'remain'],
                disabled: ['conference', 'clear']
            },
            {
                // Status: HELD | Call party type: CONSULT    | Extend status: RINGING
                when: function(call) {
                    return call.status === 'HELD' && call.partyType && call.partyType === thc.PARTY_TYPE.CONSULT && call.extendedStatus !== 'ESTABLISHED';
                },
                enabled: ['dtmf', 'remain'],
                disabled: ['transfer', 'clear']
            },
            {
                // Status: HELD | Call party type: CONFERENCE | Extend status: ESTABLISHED
                when: function(call) {
                    return call.status === 'HELD' && call.partyType && call.partyType === thc.PARTY_TYPE.CONFERENCE && call.extendedStatus === 'ESTABLISHED';
                },
                enabled: ['dtmf', 'remain', 'conference'],
                disabled: ['clear']
            },
            {
                // Status: HELD | Call party type: CONSULT    | Extend status: ESTABLISHED
                when: function(call) {
                    return call.status === 'HELD' && call.partyType && call.partyType === thc.PARTY_TYPE.CONSULT && call.extendedStatus === 'ESTABLISHED';
                },
                enabled: ['dtmf', 'remain', 'transfer'],
                disabled: ['clear']
            },
            {
                // Status: STANDBY | Is dialing: TRUE
                when: function(call) {
                    return call.status === 'STANDBY' && call.isDialing;
                },
                enabled: ['call'],
                disabled: ['clear', 'hold', 'transferals']
            },
            {
                // Status: STANDBY | Is dialing: FALSE
                when: function(call) {
                    return call.status === 'STANDBY' && !call.isDialing;
                },
                disabled: ['call', 'clear', 'hold', 'transferals']
            },
            {
                // Default
                when: function(call) {
                    return true;
                },
                disabled: ['call', 'clear', 'hold', 'transferals']
            }
        ];

        thc.settings.parse('internal', {
            buttonConfiguration: buttonConfiguration
        });

        var storeInit = {
            ui: {
                isCampaignsEnabled: true,
                isAgentStatePanel: false,
                isCampaignsOpened: false,
                showCallResultIn: ['ESTABLISHED', 'CLEARED', 'HELD', 'TRANSFERRED', 'STANDBY', 'RINGING', scope.thc.TRANSACTION_STATUS.PREVIEW],
                transactionActions: ['RESCHEDULE', thc.settings.get().callcenter.softphone.abortTransactionEnabled ? 'ABORT' : '', thc.settings.get().callcenter.softphone.discardTransactionEnabled ? 'DISCARD' : ''],
                isStateDisplayed: true,
                campaignsAllowIndividual: true,
                campaignsUseTwoSteps: true,
                isRescheduleLimitable: true,
                isRescheduleCapturable: false,
                sessionTransactionResult: true
            },
            services: {
                ready: false,
                wrapupsBackup: 'standard'
            }
        }

        var forcedExtension = null;

        var campaigns = [];
        var serviceWrapups = {};

        // Creamos o actualizamos la campaña con todos los datos que podamos obtener de campaign
        function updateCampaign(campaign, id, customData) {
            var mapped = {};
            customData = customData || {};
            if (campaign.hasOwnProperty('isopen')) {
                mapped.open = campaign.isopen === 'true';
            }
            if (campaign.hasOwnProperty('issignedon')) {
                mapped.signedOn = campaign.issignedon === 'true';
            }
            if (campaign.hasOwnProperty('isready')) {
                mapped.ready = campaign.isready === 'true';
            }
            if (campaign.hasOwnProperty('isrequestrunning')) {
                mapped.requestRunning = campaign.isrequestrunning === 'true';
            }
            if (campaign.hasOwnProperty('service')) {
                mapped.service = campaign.service;
            }
            if (campaign.hasOwnProperty('campaign')) {
                mapped.name = campaign.campaign;
            }
            if (campaign.hasOwnProperty('campaignid')) {
                mapped.id = campaign.campaignid;
            }
            if (campaign.hasOwnProperty('campaignstate')) {
                mapped.state = campaign.campaignstate;
            }
            if (id) {
                for (var i = 0; i < campaigns.length; i++) {
                    if (campaigns[i].id === id) {
                        campaigns[i] = Object.assign(campaigns[i], mapped, customData);
                        return;
                    }
                }
            }
            campaigns.push(Object.assign(customData, mapped));
        }

        var campaignsReducer = function(state, changes) {
            state.services = state.services || {};
            // Respetamos los manualNotReady
            var manualNotReadies = {};
            for (var campaign of state.services.campaigns) {
                if (campaign.manualNotReady) {
                    manualNotReadies[campaign.id] = true;
                }
            }
            state.services.campaigns = changes.services.campaigns;
            // Incorporamos los manualNotReady
            for (var campaign of state.services.campaigns) {
                if (manualNotReadies[campaign.id]) {
                    campaign.manualNotReady = true;
                }
            }
            return state;
        }

        var creds = {};

        // FAKE EVENTS. Para modificar el concepto de transaccion actual
        function onEventServiceInitiated(eventData, state) {
            // 1 - Se elimina la llamada realizada de entre las marcadas
            state.phone.dialing = state.phone.dialing.length === 1 ? state.phone.dialing.filter(function(call) {
                if (call.status !== 'STANDBY' || call.calledDevice !== '') {
                    return call;
                }
                return false;
            }) : state.phone.dialing;

            // 2 - Se inicializan los datos básicos de la llamada
            state.phone.calls[eventData.cid] = Object.assign(state.phone.calls[eventData.cid] || {}, {
                cId: eventData.cid,
                uCId: eventData.ucid
            });

            // 3 - Se marca la llamada actual como la activa
            state.phone.active = eventData.cid;

        }

        function onEventOriginated(eventData) {
            return base.store.reduceStore(function(state) {
                var transaction = state.transaction;
                var currentTransaction = base.util.transaction.getCurrent(state) || {};
                var phone = state.phone,
                    calls = state.phone.calls;

                // Si la llamada se origina desde una transaccion preview en estado CALL, se borran los datos de la antigua llamada
                if (currentTransaction.type === thc.TRANSACTION_TYPE.SESSION && currentTransaction.sessionStatus === 'CALL') {
                    phone.calls[eventData.cid] = {};
                }

                // 1 - Se asignan los datos básicos de la llamada
                phone.calls[eventData.cid] = Object.assign(phone.calls[eventData.cid] || {}, {
                    cId: eventData.cid,
                    uCId: eventData.ucid,
                    dnis: eventData.calleddevice,
                    ani: eventData.callingdevice,
                    type: thc.CALL_TYPE.OUTBOUND,
                    partyType: null,
                    status: 'RINGING'
                });

                // 2 - Se identifica el origen de la llamada como multilllamada, se extrae del marcado de teléfono y se marca como activa
                // 2.1 - Marcado de teléfono
                phone.dialing = phone.dialing.filter(function(call) {
                    if (call.calledDevice === phone.calls[eventData.cid].dnis) {
                        phone.calls[eventData.cid].partyType = thc.PARTY_TYPE.NONE;
                        if(call.clickToDialRecordId){
                            phone.calls[eventData.cid].clickToDialRecordId = call.clickToDialRecordId;
                        }
                        return false;
                    }

                    return true;
                });

                // 2.2 - Llamadas de consulta
                phone.consulting = phone.consulting.filter(function(call) {
                    if (call.calledDevice === phone.calls[eventData.cid].dnis) {
                        phone.calls[eventData.cid].partyType = thc.PARTY_TYPE.CONSULT;

                        return false;
                    }

                    return true;
                });

                // 2.3 - Llamadas de consulta
                phone.conferencing = phone.conferencing.filter(function(call) {
                    if (call.calledDevice === phone.calls[eventData.cid].dnis) {
                        phone.calls[eventData.cid].partyType = thc.PARTY_TYPE.CONFERENCE;

                        return false;
                    }

                    return true;
                });

                // 3 - Se realiza el tratamiento de la transacción, y se inicializa si esta no existía de forma previa. Si la sesión activa no es de tipo llamada o la llamada es de tipo consulta/transferencia/conferencia
                if (!calls[eventData.cid].transactionId && currentTransaction && currentTransaction.type !== thc.TRANSACTION_TYPE.CALL) {
                    calls[eventData.cid].transactionId = currentTransaction.id;
                } else if (calls[eventData.cid].transactionId) {
                    currentTransaction = transaction.list[calls[eventData.cid].transactionId];
                } else {
                    transaction.list[eventData.cid] = {
                        id: eventData.cid,
                        type: thc.TRANSACTION_TYPE.CALL,
                        status: thc.TRANSACTION_STATUS.ACTIVE
                    };

                    currentTransaction = transaction.list[eventData.cid];
                    calls[eventData.cid].transactionId = eventData.cid;
                }

                currentTransaction.status = thc.TRANSACTION_STATUS.ACTIVE;
                transaction.active = currentTransaction.id;

                // 3 - Se marca la llamada como activa
                phone.active = eventData.cid;

                // 4 - Se identifica si la llamada es interna
                phone.calls[eventData.cid].isInternal = base.util.call.isInternal(phone.calls[eventData.cid]);

                // 5 - Se inicializa el Call Log, generando la tarea correspondiente, sí y solo si la llamada es la principal de la transacción en curso
                if (phone.calls[eventData.cid].transactionId === eventData.cid) {
                    return base.util.call.log.init(phone.calls[eventData.cid]).then(function(task) {
                        phone.calls[eventData.cid].log = Object.assign(phone.calls[eventData.cid].log || {}, {
                            taskId: task.taskId,
                            subject: task.subject,
                            disposition: task.disposition
                        });

                        if (currentTransaction.type === thc.TRANSACTION_TYPE.SESSION) {
                            currentTransaction.taskIds = (currentTransaction.taskIds ? currentTransaction.taskIds : []).concat([task.taskId]);
                        }

                        return state;
                    });
                }

                return state;
            });
        }

        function onEventAlerting(eventData, handlerSettings) {
            // 0 - Valores por defecto del handler
            handlerSettings = Object.assign({
                getContext: true,
                updateTodayCalls: true,
                initPresence: true,
                parseUserinfoAsJSON: true
            }, handlerSettings);


            // 1 - Se procesa el evento y se actualizan los datos de llamadas/transacciÂ´n
            return base.store.reduceStore(function(state) {
                var phone = state.phone,
                    calls = state.phone.calls,
                    transaction = state.transaction,
                    currentTransaction = state.transaction.list[state.transaction.active],
                    onEventAlertingFinishedPromise = Promise.resolve();

                // 1 - Se actualiza la llamada con los datos del evento, asignando la transacción correspondiente
                calls[eventData.cid] = Object.assign(calls[eventData.cid] || {}, {
                    cId: eventData.cid,
                    uCId: eventData.ucid,
                    deliveringAcd: eventData.deliveringacd,
                    userInfo: eventData.userinfo ? (handlerSettings.parseUserinfoAsJSON ? JSON.parse(eventData.userinfo) : {
                        uui: eventData.userinfo
                    }) : {},
                    dnis: eventData.calleddevice,
                    ani: eventData.callingdevice,
                    answeringDevice: eventData.answeringdevice,
                    redDevice: eventData.reddevice,
                    queueTime: eventData.queuetime,
                    callTime: 0,
                    holdTime: 0
                });

                // 1.1 - Solo se actualiza el estado de la llamada si aplica
                if (calls[eventData.cid].status !== 'ESTABLISHED') {
                    calls[eventData.cid].status = 'RINGING';
                }

                // 2 - Se realiza el tratamiento de la transacción, si la llamada no se encuentra asociada con una
                // Si la transacción es de tipo llamada y no se encuentra asociada previamente, esta se considera una nueva transacción (la asociación se debería haber realizado previamente)
                if (!calls[eventData.cid].transactionId && currentTransaction && currentTransaction.type !== thc.TRANSACTION_TYPE.CALL) {
                    calls[eventData.cid].transactionId = currentTransaction.id;
                } else if (calls[eventData.cid].transactionId) {
                    currentTransaction = transaction.list[calls[eventData.cid].transactionId];
                } else {
                    transaction.list[eventData.cid] = {
                        id: eventData.cid,
                        type: thc.TRANSACTION_TYPE.CALL,
                        status: thc.TRANSACTION_STATUS.ACTIVE
                    };

                    currentTransaction = transaction.list[eventData.cid];
                }

                currentTransaction.status = thc.TRANSACTION_STATUS.ACTIVE;
                transaction.active = currentTransaction.id;

                // 3 - Se identifica si la llamada es interna; si la llamada no se había identificado previamente como OUTBOUND, se considera directamente INBOUND y se inicializa el call log
                if (!calls[eventData.cid].type) {
                    calls[eventData.cid].type = thc.CALL_TYPE.INBOUND;
                    calls[eventData.cid].isInternal = base.util.call.isInternal(calls[eventData.cid]);
                    base.actions.ring(); // AÑADIDO
                }

                // 5 - Se marca la llamada actual como activa
                phone.active = eventData.cid;

                // 6 - Post-procesamiento de la llamada
                // Solo se lanza la búsqueda del contexto y las integraciones sí y solo sí la llamada cumple las siguientes condiciones, indepedientemente de la configuración del handler vía handlerSettings
                //  - No es una llamada de conferencia/consulta => No es necesario buscar contexto
                //  - No es una llamada llamada fantasma de campañas Preview => La búsqueda debe esperar a los datos de contacto
                //  - No es una multillamada => La búsqueda ya se ha lanzado al recibir los datos de contacto de la llamada fantasma
                // En resumen, la llamada debe coincidir con la transacción en curso y ser de tipo CALL
                //TODO: Contexto de phone a transaction
                // if (currentTransaction && (currentTransaction.type !== thc.TRANSACTION_TYPE.CALL || currentTransaction.id !== eventData.cid)) {
                if (currentTransaction && (currentTransaction.context && currentTransaction.context.uui &&
                        currentTransaction.context.uui.records && currentTransaction.context.uui.records.length ||
                        currentTransaction.sessionStatus === 'CALL' || currentTransaction.id !== eventData.cid)) {
                    handlerSettings.getContext = false;
                }

                // 4 - Se parsea el UUI
                //TODO: Contexto de phone a transaction
                // calls[eventData.cid].context = {
                if (currentTransaction.sessionStatus !== 'CALL') {
                    // Si se trata de un clickToDial se añade el recordId obtenido 
                    if(calls[eventData.cid].clickToDialRecordId){
                        calls[eventData.cid].userInfo.uui = (calls[eventData.cid].userInfo.uui || '') + calls[eventData.cid].clickToDialRecordId;
                    }
                    currentTransaction.context = {
                        uui: base.util.call.uui.parse(calls[eventData.cid].userInfo.uui || '')
                    };
                }

                // 7 - Se inicializa el CallLog si no se ha inicializado de forma previa y el Id de la llamada se corresponde con el de la transacción
                // Se retorna el estado en el then. El store se asegura de ejecutar todo de forma atómica
                // || currentTransaction.sessionStatus !== 'CALL'
                if (!calls[eventData.cid].log && currentTransaction.id === eventData.cid) {
                    onEventAlertingFinishedPromise = base.util.call.log.init(calls[eventData.cid]).then(function(task) {
                        phone.calls[eventData.cid].log = Object.assign(phone.calls[eventData.cid].log || {}, {
                            taskId: task.taskId,
                            subject: task.subject,
                            disposition: task.disposition
                        });

                        if (currentTransaction.type === thc.TRANSACTION_TYPE.SESSION) {
                            currentTransaction.taskIds = (currentTransaction.taskIds ? currentTransaction.taskIds : []).concat([task.taskId]);
                        }
                    });
                }

                // 6 - Post-procesamiento de la llamada
                // 6.1 - Obtención del contexto de la llamada
                if (handlerSettings.getContext && calls[eventData.cid].transactionId === eventData.cid) {
                    onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
                        //Jmartinezpisson => Cambio uso getContext
                        return base.util.call.getContext({
                            call: calls[eventData.cid],
                            transaction: currentTransaction
                        });
                        /*return base.util.call.getContext(Object.assign({}, calls[eventData.cid], {
                          context: currentTransaction.context
                        }));*/
                    }).then(function(callWithContext) {
                        //TODO: Contexto de phone a transaction
                        // Object.assign(phone.calls[eventData.sessionid], callWithContext);
                        phone.calls[eventData.cid].log = Object.assign(phone.calls[eventData.cid].log || {}, callWithContext.log || {});
                        currentTransaction.context = Object.assign(currentTransaction.context || {}, callWithContext.context || {});
                    });
                }

                // 6.2 - Integración con OmniChannel
                // setBusy(true) cambiado en todas las centralitas de alerting al stablished
                if (handlerSettings.initPresence) {
                    if (!state.error.message) { //e.g si hay un invalid number como no se establece la llamada no cambiamos omni.
                        onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
                            return base.util.integration.presence.setBusy(true);
                        });
                    }
                }

                // 6.3 - Llamadas de hoy
                if (handlerSettings.updateTodayCalls) {
                    onEventAlertingFinishedPromise = onEventAlertingFinishedPromise.then(function() {
                        return Promise.all([ // AÑADIDO
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
                }

                // 8 - Se devuelve el estado en una Promesa para finalizar el reduceStore. (lo ideal sería el finally..)
                return onEventAlertingFinishedPromise.then(function() {
                    return state;
                }).catch(function(errors) {
                    state.notifications = {
                        show: true,
                        message: errors,
                        type: 'error'
                    };

                    return state;
                });
            });
        }

        function onEventEstablished(eventData, handlerSettings) {
            // 0 - Valores por defecto del handler
            handlerSettings = Object.assign({
                parseUserinfoAsJSON: true
            }, handlerSettings);

            var phone = base.store.getState().phone,
                calls = phone.calls;


            // 1  - Integraciones con Salesforce
            base.util.integration.presence.setBusy(true);

            // 2 - Se actualizan los datos y estado de la llamada
            calls[eventData.cid] = Object.assign(calls[eventData.cid] || {}, {
                cId: eventData.cid,
                uCId: eventData.ucid,
                deliveringAcd: eventData.ucid,
                userInfo: eventData.userinfo ? (handlerSettings.parseUserinfoAsJSON ? JSON.parse(eventData.userinfo) : {
                    uui: eventData.userinfo
                }) : {},
                answeringDevice: eventData.answeringdevice,
                redDevice: eventData.reddevice,
                queueTime: eventData.queuetime,
                status: 'ESTABLISHED',
                lastUpdated: new Date()
            });

            return base.store.reduceStore({
                phone: phone
            });
        }

        function onEventCallConnectionCleared(eventData) {
            var taskSettings = thc.settings.get().task,
                urlConfiguration = thc.settings.get().urlConfiguration;

            return base.store.reduceStore(function(state) {
                var phone = state.phone,
                    currentTransaction = null,
                    transactionCall = null,
                    onEventCallConnectionClearedFinishedPromise;

                //0  - Integraciones con Salesforce
                base.util.integration.presence.setBusy(false); // Se fuerza que Onmnichannel vuelva al estado anterior

                // si se finaliza una conferencia
                if (phone.calls[eventData.cid] && phone.calls[eventData.cid].conference) {
                    if (phone.calls[phone.active].conference.members.length > 0) {
                        onEventCallConnectionClearedFinishedPromise = base.util.integration.presence.setBusy("conferenceEnded"); // Se fuerza que Onmnichannel vuelva al estado anterior
                    }
                }

                // 1 - Se actualiza el estado de la llamada a CLEARED
                phone.calls[eventData.cid] = Object.assign(phone.calls[eventData.cid] || {}, {
                    cId: eventData.cid,
                    uCId: eventData.ucid,
                    clearCause: eventData.cause,
                    propagated: eventData.propagated,
                    lastUpdated: new Date(),
                    status: 'CLEARED'
                });

                // 2 - Se controla la transacción.
                currentTransaction = state.transaction.list[phone.calls[eventData.cid].transactionId] || {};
                transactionCall = phone.calls[currentTransaction.id];
                // TODO: Verificar si vale pa algo esta traza
                logger.log(logger.LOG_TYPE.CUSTOM, 'onEventCallConnectionCleared - cid:', eventData.cid, 'transactionId:', currentTransaction.id);

                // 3 - Se comprueba si existe una llamada cuyo contexto está asociado a la actual: si se ha configurado el softphone como corresponde se autoactualiza la tarea
                if (taskSettings.autoUpdate && transactionCall && transactionCall.log) {
                    base.util.call.log.end(transactionCall).then(function(task) {
                        if (task && task.taskId && phone.calls[eventData.cid]) {
                            phone.calls[eventData.cid].log = Object.assign(phone.calls[eventData.cid].log || {}, {
                                taskId: task.taskId,
                                subject: task.subject,
                                disposition: task.disposition
                            });
                        }
                    }).catch(function(errors) {
                        state.notifications = {
                            show: true,
                            message: 'Error while updating task: ' + errors,
                            type: 'error'
                        };
                    });
                }

                // 4 - Si la llamada no es la principal de la transacción, se debe eliminar la llamada
                if (eventData.cid !== currentTransaction.id) {
                    base.actions.deleteCall(eventData.cid);
                    return state;
                }

                // 5 - Si la llamada es la que mantiene la transacción, se realiza el procesamiento post-transaccción
                // 5.1 - Se marca la transacción como CLEARED, permitiendo su posterior cierre
                if (currentTransaction.type !== thc.TRANSACTION_TYPE.SESSION) {
                    currentTransaction.status = thc.TRANSACTION_STATUS.CLEARED;
                }

                // 5.2 - Por comodidad, se colapsan todos los paneles de llamada
                state.ui = Object.assign(state.ui, {
                    isCallInfoOpened: false,
                    isNoResultsPanelOpened: false,
                    isCallDetailCardOpened: false
                });

                // 5 - Si la transacción pasa a estar cleared, se lanza el customPop; de esta manera, el customPop se hace al finalizar la llamada o cuando finaliza una sesión que prmite multillamada.
                //  Tanto si se realiza de forma correctamente como si no, el estado es actualizado
                if (currentTransaction.sessionStatus === 'PREVIEW_ANALYSIS') {
                    currentTransaction.sessionStatus = 'CALL';
                    return state;
                } else {
                    return base.util.call.customPop(Object.assign({}, {
                        log: transactionCall.log,
                    }, {
                        call: transactionCall
                    }, {
                        context: currentTransaction.context
                    }, {
                        contact: currentTransaction.contact
                    }), urlConfiguration.callEnded, urlConfiguration.openAsSubtab).then(function() {
                        return state;
                    }, function(err) {
                        return state;
                    });
                }
            });
        }

        function onEventDiverted(eventData) {
            var state = base.store.getState(),
                call = state.phone.calls[eventData.cId];

            if (call) {
                return base.actions.deleteCall();
            }
        }

        function onEventFailed(eventData) {
            return base.store.reduceStore(function(state) {
                var phone = state.phone,
                    transactions = state.transaction;

                if (eventData.cid) {
                    if (transactions.list[eventData.cid] && transactions.list[eventData.cid].type === thc.TRANSACTION_TYPE.CALL) {
                        phone.calls[eventData.cid] = Object.assign(phone.calls[eventData.cid], {
                            cId: eventData.cid,
                            uCId: eventData.ucid,
                            clearCause: eventData.cause,
                            propagated: eventData.propagated,
                            status: 'CLEARED',
                            failed: true
                        });
                    } else {
                        delete state.phone.calls[eventData.cid];
                        state.phone.dialing = state.phone.dialing.filter(function(call) {
                            return call.calledDevice !== '';
                        });

                        if (state.phone.dialing.length === 0 && Object.keys(state.phone.calls).length === 0 && state.phone.conferencing.length === 0 && state.phone.consulting.length === 0) { //AÑADIDO
                            state.transaction.active = state.transaction.active || '';
                            state.phone.dialing.push({
                                calledDevice: '',
                                status: 'STANDBY',
                                transactionId: state.transaction.active,
                                failed: true
                            });
                            state.phone.active = '0';
                        } else if (state.phone.dialing.length) {
                            state.phone.active = '0';
                            state.transaction.active = state.phone.dialing[0].transactionId || '';
                        } else {
                            state.phone.active = Object.keys(state.phone.calls)[0];
                            state.transaction.active = Object.keys(state.phone.calls)[0] || '';
                        }
                    }
                }

                state.notifications = Object.assign(state.notifications || {}, { show: true });
                state.error = Object.assign(state.error || {}, { type: 'EVENT', message: 'Error: ' + eventData.cause });
                return state;

            });
        }


        return {
            actions: {
                login: function(credentials) {
                    // 1 - Se desconecta por precaución CometD
                    thc.big.stop();

                    if (credentials.source === 'manual') {
                        credentials = {
                            username: credentials.username,
                            password: credentials.password
                        };
                    }

                    // 2 - Se realiza el primer paso del login
                    if (credentials.username) {
                        forcedExtension = false;
                        creds = credentials;

                        return base.store.reduceStore({
                            isLoading: true,
                            error: {
                                type: "LOGIN",
                                message: ''
                            },
                            session: {
                                username: credentials.username,
                                password: credentials.password
                            }
                        }).then(function() {
                            return thc.big.start({
                                username: credentials.username,
                                password: credentials.password
                            });
                        });

                    } else {
                        return base.store.reduceStore({
                            error: {
                                type: 'LOGIN',
                                message: scope.$Label.Softphone_introduce_data
                            },
                            overlay: {
                                show: false
                            },
                            isLoading: false
                        });
                    }

                },
                site: function(site, team) {
                    var chainPromise = Promise.resolve(true);
                    // 2 - Se realiza el segundo paso del login, el site
                    if (site) {
                        return base.store.reduceStore({
                            isLoading: true,
                            error: {
                                type: "SITE",
                                message: ''
                            }
                        }).then(function() {

                            return thc.big.rest.site({
                                site: site,
                                team: team
                            }).then(function(siteData) {

                                var extension = forcedExtension || creds.extension;

                                chainPromise = chainPromise.then(function() {
                                    return base.store.reduceStore({
                                        login: {
                                            loggingInStep: 'extension'
                                        },
                                        error: {
                                            type: 'SITE',
                                            message: ''
                                        },
                                        session: {
                                            site: site,
                                            team: team
                                        }
                                    });
                                });

                                if (extension) {
                                    return chainPromise.then(function() {
                                        return thc.controller.actions.extension(extension);
                                    })
                                } else {
                                    return chainPromise.then(function() {
                                        return base.store.reduceStore({
                                            isLoading: false,
                                            overlay: {
                                                show: false
                                            }
                                        });
                                    });
                                }

                            }).catch(function(siteErrors) {
                                return base.store.reduceStore({
                                    isLoading: false,
                                    error: {
                                        type: 'SITE',
                                        message: siteErrors
                                    },
                                    overlay: {
                                        show: false
                                    }
                                });
                            });
                        });
                    } else {
                        return base.store.reduceStore({
                            isLoading: false,
                            error: {
                                type: 'SITE',
                                message: scope.$Label.Softphone_introduce_data
                            }
                        });
                    }
                },
                extension: function(extension) {
                    var phone = base.store.getState().phone;
                    var extensionPromise = Promise.resolve(true);

                    return base.store.reduceStore({
                        isLoading: true,
                        error: {
                            type: "EXTENSION",
                            message: ''
                        }
                    }).then(function() {
                        // 3 - Se realiza el ultimo paso del login, establecer la extension
                        extension = extension || forcedExtension;
                        if (extension) {
                            thc.big.update({
                                extension: extension
                            });

                            extensionPromise = extensionPromise.then(function() {
                                return thc.big.rest.extension({
                                    extension: extension
                                }).then(function(extensionData) {
                                    // 1 - Guardamos en el store todo lo apropiado para terminar el login
                                    return base.store.reduceStore(Object.assign(storeInit, {
                                        error: {
                                            type: 'LOGIN',
                                            message: ''
                                        },
                                        session: {
                                            extension: extension
                                        }
                                    }));

                                }).catch(function(extensionErrors) {
                                    return base.store.reduceStore({
                                        isLoading: false,
                                        error: {
                                            type: 'EXTENSION',
                                            message: extensionErrors
                                        },
                                        overlay: {
                                            show: false
                                        },
                                        session: {
                                            isLogged: false
                                        }
                                    }).then(function() {
                                        return Promise.reject(extensionErrors);
                                    });
                                });
                            });

                            return extensionPromise.then(function() {

                                // 1 - Guardamos el login como realizado
                                return base.store.reduceStore({
                                    agent: {
                                        state: 'LOGIN'
                                    },
                                    isLoading: false,
                                    login: {
                                        loggingInStep: 'login',
                                    },
                                    overlay: {
                                        show: false
                                    },
                                    session: {
                                        isLogged: true
                                    },
                                    phone: {
                                        active: '0',
                                        dialing: [{
                                            calledDevice: '',
                                            status: 'STANDBY'
                                        }]
                                    }

                                });

                            });
                        } else {
                            return base.store.reduceStore({
                                isLoading: false,
                                error: {
                                    type: 'EXTENSION',
                                    message: scope.$Label.Softphone_introduce_data
                                }
                            });
                        }
                    });

                },
                getStatus: function() {
                    return base.store.reduceStore({
                        overlay: {
                            show: true,
                            message: $Label.Softphone_Loading_thinkConnect
                        }
                    }).then(function() {
                        return thc.big.rest.getStatus()
                            .then(function(status) {
                                var state = base.store.getState();

                                // 1. Actualizamos las campañas
                                var manualNotReadies = {};
                                for (var campaign of state.services.campaigns) {
                                    if (campaign.manualNotReady) {
                                        manualNotReadies[campaign.id] = true;
                                    }
                                }

                                campaigns = [];
                                status.campaigns.forEach(function (campaign) {
                                    var extraInfo = {};
                                    if (manualNotReadies[campaign.campaignid]) {
                                        extraInfo = {
                                            manualNotReady: true
                                        };
                                    }
                                    updateCampaign(campaign, campaign.campaignid, extraInfo);
                                });

                                // 1.1 - Refrescamos el estado global de las campañas
                                var allNotReady = campaigns.every(function(campaign) {
                                    return !campaign.ready;
                                });

                                // 2. Actualizamos las llamadas
                                var phone = state.phone;
                                var transactions = state.transaction;

                                var transactionsPrev = base.store.getState().transaction.list;
                                var callsPrev = base.store.getState().phone.calls;
                                var callsAfter = [];

                                //Se limpia el dialing
                                phone.dialing = phone.dialing.filter(function(call) { return call.calledDevice !== ''});

                                status.sessions.forEach(function(session) {
                                    var status = '';
                                    var call, transaction;
                                    callsAfter.push(session.sessionid + '');

                                    // Indicamos el estado de la llamada
                                    switch (session.call.state) {
                                        case 'Dialing':
                                        case 'Alerting':
                                            status = 'RINGING';
                                            break;
                                        case 'Connected':
                                            status = 'ESTABLISHED';
                                            break;
                                        case 'Held':
                                        case 'Extended':
                                            status = 'HELD';
                                            break;
                                        case 'Cleared':
                                            status = 'CLEARED';
                                            break;
                                        case 'PreviewAlerting':
                                        case 'PreviewAnalysis':
                                        case 'PreviewRetry':
                                        case 'NewPending':
                                        case 'Disconnected':
                                        default:
                                            status = 'STANDBY';
                                    }

                                    var ani;
                                    if (session.call.dialednumber) {
                                        if (session.call.primaryparties) {
                                            ani = session.call.primaryparties.filter(function(party) {
                                                return party.number !== session.call.number;
                                            })[0].number + '';
                                        } else {
                                            ani = '';
                                        }
                                    } else {
                                        ani = session.call.number + '';
                                    }

                                    call = {
                                        cId: '' + session.sessionid,
                                        status: status,
                                        deliveringAcd: session.acd,
                                        type: session.call.dialednumber ? thc.CALL_TYPE.OUTBOUND : thc.CALL_TYPE.INBOUND,
                                        ani: ani,
                                        dnis: session.call.dialednumber ? session.call.dialednumber + '' : session.call.dnis + '',
                                        transactionId: '' + session.sessionid,
                                        lastUpdated: new Date()
                                    };

                                    // Creamos una transaccion de tipo llamada
                                    transaction = {
                                        id: '' + session.sessionid,
                                        type: thc.TRANSACTION_TYPE.CALL
                                    };

                                    // Si estamos en una llamada de campaña cambiamos los datos para tener una transaccion de tipo sesion
                                    if (session.campaignid !== -1) {
                                        call.campaignId = session.campaignid + '';
                                        transaction.campaignId = session.campaignid + '';
                                        transaction.type = thc.TRANSACTION_TYPE.SESSION;
                                    }

                                    // Si tenemos una linea extendida la añadimos a nuestra llamada
                                    if ((session.call.state === 'Extended' || session.call.state === 'Held') && session.call.extendparties.length > 0) {
                                        call.extendedLine = {
                                            ani: call.type === thc.CALL_TYPE.OUTBOUND ? call.ani + '' : call.dnis + '',
                                            dnis: session.call.extendparties.filter(function(party) {
                                                return party.number === (call.type === thc.CALL_TYPE.OUTBOUND ? call.ani : call.dnis);
                                            })[0].number,
                                            status: session.call.state === 'Held' ? 'RINGING' : 'ESTABLISHED',
                                            lastUpdated: new Date()
                                        };
                                    }

                                    // En el caso del preview alerting lo marcamos como tal
                                    if (session.call.state === 'PreviewAlerting') {
                                        call.dnis = session.call.number + '';
                                        call.type = thc.CALL_TYPE.OUTBOUND;
                                        transaction.status = thc.TRANSACTION_STATUS.PREVIEW;
                                        transaction.sessionStatus = 'PREVIEW_ALERTING';
                                    }

                                    // Y en el caso de tener mas de dos participantes, marcamos la linea como conferencia
                                    if (session.primaryparties && (callsPrev[session.sessionid + ''].conference || session.primaryparties.length > 2)) {
                                        call.conference = {
                                            members: session.primaryparties.map(function(party) {
                                                return party.number;
                                            }),
                                            controller: ''
                                        };
                                    }

                                    // Si la llamada es la que esta en curso (no pendiente) la marcamos como activa
                                    if (session.call.state !== 'NewPending' && !phone.active) {
                                        transactions.active = session.sessionid + '';
                                        phone.active = '' + session.sessionid;
                                    }

                                    // En el caso del preview analysis lo marcamos como tal
                                    if (session.call.state === 'PreviewAnalysis') {
                                        transaction.status = thc.TRANSACTION_STATUS.PREVIEW;
                                        // transaction.sessionStatus = 'PREVIEW_ANALYSIS';
                                        transaction.sessionStatus = 'CALL';
                                        // Solo añadimos la línea si no está previamente metida
                                        if (phone.dialing.filter(function(call) { return call.calledDevice === (session.call.number + ''); }).length === 0) {
                                            phone.dialing.push({
                                                calledDevice: session.call.number + '',
                                                status: "STANDBY",
                                                transactionId: '' + session.sessionid
                                            });
                                        }
                                    } else if (session.call.state === 'PreviewRetry' || session.call.stat === 'NewPending') { //AÑADIDO
                                        if (phone.dialing.filter(function(call) { return call.calledDevice === (session.call.number + ''); }).length === 0) {
                                            transaction.status = thc.TRANSACTION_STATUS.PREVIEW;
                                            transaction.sessionStatus = 'CALL';
                                            phone.dialing.push({
                                                calledDevice: session.call.number + '',
                                                status: "STANDBY",
                                                transactionId: '' + session.sessionid
                                            });
                                        }
                                    }
                                    // En caso de que el estado de la llamada sea analysis no se guarda la llamada en calls
                                    else {
                                        // Guardamos la llamada
                                        if (Object.keys(callsPrev).includes(session.sessionid + '')) {
                                            phone.calls[session.sessionid] = Object.assign({}, callsPrev[session.sessionid], call);
                                        } else {
                                            phone.calls[session.sessionid] = call;
                                        }
                                    }

                                    // Guardamos la transaccion
                                    if (Object.keys(transactionsPrev).includes(session.sessionid + '')) {
                                        transactions.list[session.sessionid] = Object.assign({}, transactionsPrev[session.sessionid], transaction);
                                    } else {
                                        transactions.list[session.sessionid] = transaction;
                                    }

                                });

                                // Se borran las líneas de llamada que ya no están activas
                                for (var call in phone.calls) {
                                    if (!callsAfter.includes(call) && phone.calls[call].status !== 'CLEARED') {
                                        delete phone.calls[call];
                                    }
                                }

                                // Se actualiza la llamada y transacción activa
                                if (phone.dialing.length === 0 && Object.keys(phone.calls).length === 0 && phone.conferencing.length === 0 && phone.consulting.length === 0) { //AÑADIDO
                                    transactions.active = transactions.active || '';
                                    phone.dialing.push({
                                        calledDevice: '',
                                        status: 'STANDBY',
                                        transactionId: transactions.active,
                                        failed: true
                                    });
                                    phone.active = '0';
                                } else if (phone.dialing.length) {
                                    phone.active = '0';
                                    transactions.active = phone.dialing[0].transactionId || '';
                                } else {
                                    phone.active = Object.keys(phone.calls)[0];
                                    transactions.active = phone.calls[phone.active] ? phone.calls[phone.active].transactionId : '';
                                }



                                // Guardamos todo el estado del telefono
                                return base.store.reduceStore(function(state) {
                                    state.phone = phone;
                                    state.transaction = transactions;
                                    if (state.agent) {
                                        state.agent.state = allNotReady ? 'STOPPED' : 'STARTED';
                                    }
                                    state.services = state.services || {};
                                    state.services.campaigns = campaigns;
                                    return state;
                                });

                            });
                    }).catch().then(function() {
                        return base.store.reduceStore({
                            overlay: {
                                show: false,
                                message: ''
                            }
                        });
                    });
                },
                forceLogout: function() {
                    return thc.big.rest.logout().then(function(logoutResult) {
                            thc.big.stop();
                            return base.actions.resetState();
                        })
                        .catch(function(logoutError) {
                            if (logoutError === 'Agent does not exist' || logoutError === 'Link undefined for extension') {
                                return base.store.reduceStore({
                                    isLoading: false,
                                    session: {
                                        isLogged: false,
                                        isLoggingOut: false
                                    },
                                    error: {
                                        type: 'LOGIN',
                                        message: ''
                                    }
                                });
                            } else {
                                return base.store.reduceStore({
                                    notifications: {
                                        type: 'error',
                                        show: true,
                                        message: logoutError
                                    }
                                });
                            }
                        });
                },
                logout: function(reason) {
                    return thc.controller.actions.forceLogout();
                },
                showLoginPanel: function() {
                    $('#loginPlaceError').text('');
                    $('[id$=personContainerAltitude]').show();
                    $('[id$=sitesAndTeamsContainerAltitude]').hide();
                    $('[id$=extensionsContainerAltitude]').hide();
                    $('#loginButtonAltitude').show();
                    $('#loginLoadingAltitude').hide();
                    return base.actions.showLoginPanel();
                },
                openCampaign: function(campaignId) {
                    updateCampaign({}, campaignId, {
                        requestRunning: true
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer).then(function() {
                        return thc.big.rest.campaignOpen({
                                campaignid: campaignId
                            })
                            .catch(function(error) {
                                updateCampaign({}, campaignId, {
                                    requestRunning: false
                                });
                                return base.store.reduceStore({
                                    services: {
                                        campaigns: campaigns
                                    }
                                }, campaignsReducer);
                            });
                    });

                },
                closeCampaign: function(campaignId) {
                    updateCampaign({}, campaignId, {
                        requestRunning: true
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer).then(function() {
                        return thc.big.rest.campaignClose({
                                campaignid: campaignId
                            })
                            .catch(function(error) {
                                updateCampaign({}, campaignId, {
                                    requestRunning: false
                                });
                                return base.store.reduceStore({
                                    services: {
                                        campaigns: campaigns
                                    }
                                }, campaignsReducer);
                            });
                    });
                },
                readyCampaign: function(campaignId) {
                    updateCampaign({}, campaignId, {
                        requestRunning: true
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer).then(function() {
                        return thc.big.rest.campaignSignOn({
                                campaignid: campaignId
                            }).then(function() {
                                return thc.big.rest.campaignReady({
                                    campaignid: campaignId
                                });
                            })
                            .catch(function(error) {
                                updateCampaign({}, campaignId, {
                                    requestRunning: false
                                });
                                return base.store.reduceStore({
                                    services: {
                                        campaigns: campaigns
                                    }
                                }, campaignsReducer);
                            });
                    });

                },
                selectSite: function(siteName) {
                    return base.store.reduceStore({
                        login: {
                            selectedSite: siteName
                        }
                    });
                },
                selectTeam: function(teamName) {
                    return base.store.reduceStore({
                        login: {
                            selectedTeam: teamName
                        }
                    });
                },
                getNotReadyReasons: function(campaignId) {
                    return base.store.reduceStore({
                        ui: {
                            isSelectingNotReadyReason: campaignId
                        }
                    });
                },
                notReadyCampaign: function(campaignId, reason) {
                    var campaign;

                    updateCampaign({}, campaignId, {
                        requestRunning: true
                    });

                    return base.store.reduceStore(function(state) {
                        campaign = state.services.campaigns.filter(function(campaign) {
                            return campaign.id === campaignId;
                        })[0];

                        state.services = state.services || {};
                        state.services.campaigns = campaigns;
                        state.ui = Object.assign(state.ui, {
                            isSelectingNotReadyReason: false
                        });
                        return state;
                    }).then(function(state) {
                        // Si está ready, le ponemos not ready, y si no esta ready, lo tomaremos como que aun tiene el signedOn activo
                        if (!campaign.ready) {
                            return thc.big.rest.campaignSignOff({
                                campaignid: campaignId
                            });

                        } else {
                            // Hacemos la peticion campaignNotReady
                            return thc.big.rest.campaignNotReady({
                                campaignid: campaignId,
                                reason: reason
                            })
                            .then(function() { // Flag para signOff (22/03/2018)
                                return base.store.reduceStore(function(state) {
                                    var campaigns = state.services.campaigns;
                                    for (var campaign of campaigns) {
                                        if (campaign.id == campaignId) {
                                            campaign.manualNotReady = true;
                                        }
                                    }
                                    return state;
                                });
                            })
                            .catch(function(error) {
                                updateCampaign({}, campaignId, {
                                    requestRunning: false
                                });
                                return base.store.reduceStore({
                                    services: {
                                        campaigns: campaigns
                                    }
                                }, campaignsReducer);
                            });
                        }

                    });

                },
                clickToDial: function(number, recordId) {
                    var state = base.store.getState();
                    var call = base.util.call.getCurrent(state);
                    var isClickToConsult = call ? (call.status === 'ESTABLISHED' || call.status === 'HELD') : false;
                    var transaction = base.util.transaction.getCurrent(state);
                    var dialCall = {
                        calledDevice: number,
                        status: "STANDBY",
                        clickToDialRecordId: recordId
                    };

                        // clickToConsult
                        if (isClickToConsult && thc.settings.get().callcenter.softphone.clickToConsult) {
                            return thc.controller.actions.consultationCall({
                                calledDevice: number,
                                type: thc.PARTY_TYPE.CONSULT
                            });
                        // clickToCall
                        } else {
                            // Se añade la línea y se realiza la llamada
                            return base.store.reduceStore(function(state) {
                                if (state.phone.dialing[state.phone.active] && state.phone.dialing[state.phone.active].calledDevice) {
                                    state.phone.dialing.push(dialCall);
                                    state.phone.active = "" + (state.phone.dialing.length - 1);
                                } else {
                                    state.phone.dialing[state.phone.active] = dialCall;
                                }
                                return state;
                            }).then(function() {
                                if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
                                    return thc.controller.actions.makeCallInSession(dialCall, transaction.id);
                                } else {
                                    return thc.controller.actions.makeCall(dialCall);
                                }
                            });
                        }
                },
                confirmCall: function() {
                    // Función que determina las acciones a realizar al pulsar el botón que ejecuta la acción de descolgar/emitir una llamada
                    var phone = base.store.getState().phone,
                        active = phone.calls[phone.active],
                        transaction = base.util.transaction.getCurrent();
                    if (active) {
                        return thc.controller.actions.answerCall(active);
                    } else if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) {
                        return thc.controller.actions.makeCallInSession(phone.dialing[phone.active], transaction.id);
                    } else if (phone.dialing[phone.active]) {
                        return thc.controller.actions.makeCall(phone.dialing[phone.active]);
                    }
                },
                answerCall: function() {
                    var phone = base.store.getState().phone;
                    return thc.big.rest.answerCallAltitude({
                            sessionid: phone.active
                        })
                        .catch(function(answerCallError) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true
                                },
                                error: {
                                    type: 'EVENT',
                                    message: 'Error respondiendo llamada: ' + answerCallError
                                }
                            });
                        });
                },
                makeCall: function(dialingCall) {
                    var phone = base.store.getState().phone,
                        newCall = dialingCall || phone.dialing[phone.active],
                        formattedNumber = base.util.call.formatPhoneNumber(newCall.calledDevice);

                    return thc.big.rest.makeCall({
                            number: formattedNumber.isValid ? formattedNumber.phoneNumber : newCall.calledDevice,
                            agent: ''
                        })
                        .catch(function(makeCallError) {
                            return base.store.reduceStore({
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
                makeCallInSession: function(dialingCall, sessionid) {
                    var phone = base.store.getState().phone,
                        transaction = base.util.transaction.getCurrent(),
                        newCall = dialingCall || phone.dialing[phone.active],
                        formattedNumber = base.util.call.formatPhoneNumber(newCall.calledDevice);


                    return thc.big.rest.makeCallInSession({
                            number: formattedNumber.isValid ? formattedNumber.phoneNumber : newCall.calledDevice,
                            agent: '',
                            sessionid: sessionid
                        })
                        .catch(function(makeCallError) {
                            return base.store.reduceStore({
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
                clearCall: function() {
                    var phone = base.store.getState().phone;
                    return thc.big.rest.clearCall({
                            sessionid: phone.active
                        })
                        .catch(function(clearCallError) {
                            return base.store.reduceStore({
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
                holdCall: function() {
                    var phone = base.store.getState().phone;
                    return thc.big.rest.holdCall({
                            sessionid: phone.active
                        })
                        .catch(function(answerCallError) {
                            return base.store.reduceStore({
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
                resumeCall: function() {
                    var phone = base.store.getState().phone;
                    return thc.big.rest.retrieveCall({
                            sessionid: phone.active
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
                },
                consultationCall: function(consultationCall) {
                    var phone = base.store.getState().phone,

                        activeCall = phone.calls[phone.active],
                        transaction = base.store.getState().transaction,
                        currentTransaction = transaction.list[transaction.active],
                        formattedNumber = base.util.call.formatPhoneNumber(consultationCall.calledDevice),
                        consultCall = {
                            calledDevice: formattedNumber.isValid ? formattedNumber.phoneNumber : consultationCall.calledDevice,
                            userInfo: consultationCall.userInfo
                        };

                    if (!consultCall.userInfo && currentTransaction && currentTransaction.context) {
                        consultCall.userInfo = base.util.call.uui.stringifyContextRecordsAsUUI(currentTransaction.context.records);
                    }

                    phone.calls[phone.active].partyType = consultationCall.type;

                    return base.store.reduceStore({
                        phone: phone
                    }).then(function(){
                        return thc.big.rest.consultationCallAltitude({
                            number: consultCall.calledDevice,
                            userinfo: consultCall.userInfo,
                            sessionid: activeCall.cId
                        }).catch(function(consultCallError) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true
                                },
                                error: {
                                    type: 'EVENT',
                                    message: 'Error realizando llamada: ' + consultCallError
                                }
                            });
                        });
                    });
                    
                },
                transferCall: function() {
                    var transaction = base.util.transaction.getCurrent();
                    return thc.big.rest.transferCall({
                        sessionid: transaction.id
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
                    var transaction = base.util.transaction.getCurrent();
                    return thc.big.rest.conference({
                        sessionid: transaction.id
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
                reduceRescheduleCall: function(data) {
                    return base.store.reduceStore(function(state) {
                        var currentTransaction = base.util.transaction.getCurrent(state);
                        return thc.big.rest.rescheduleContact({
                            // moment: moment(data.date + ' ' + data.timeHour+':'+data.timeMinute, 'DD/MM/YYYY HH:mm').utc().format('DD/MM/YYYY HH:mm'),
                            moment: data.date + ' ' + data.timeHour + ':' + data.timeMinute,
                            //limit: data.isLimitOpened ? moment(data.limitHour+':'+data.limitMinute, 'HH:mm').utc().format('HH:mm') : '',
                            limit: data.isLimitOpened ? data.limitHour + ':' + data.limitMinute : '',
                            phone: data.diffNumber ? data.number : '',
                            sessionid: currentTransaction.id
                        }).then(function(result) {
                            currentTransaction.reschedule = data;
                            return state;
                        }).catch(function() {
                            currentTransaction.reschedule = data;
                            return state;
                        });
                    });
                },
                showTransactionOptions: function() {
                    return base.store.reduceStore({
                        ui: {
                            isTransactionOptionsOpened: true
                        }
                    });

                },
                hideTransactionOptions: function() {
                    return base.store.reduceStore({
                        ui: {
                            isTransactionOptionsOpened: false
                        }
                    });

                },
                abortDataTransaction: function() {
                    var transaction = base.util.transaction.getCurrent();
                    return thc.big.rest.abortDataTransaction({
                            sessionid: transaction.id
                        })
                        .catch(function(abortTransactionError) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true
                                },
                                error: {
                                    type: 'EVENT',
                                    message: 'Error abortando transacción de datos: ' + abortTransactionError
                                }
                            });
                        });
                },
                discardDataTransaction: function() {
                    var transaction = base.util.transaction.getCurrent();
                    return thc.big.rest.discardDataTransaction({
                            sessionid: transaction.id
                        })
                        .catch(function(discardTransactionError) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true
                                },
                                error: {
                                    type: 'EVENT',
                                    message: 'Error descartando transacción de datos: ' + discardTransactionError
                                }
                            });
                        });
                },
                endDataTransaction: function(outcomes, sessid) {
                    var phone = base.store.getState().phone;
                    var sessionid = sessid || phone.active;
                    return base.store.reduceStore(function(state){
                        if(state.transaction.list[sessid]){
                          state.transaction.list[sessid].endDisabled = true;
                        }
                        return state;
                    }).then(function(){
                        return thc.big.rest.endDataTransaction({
                            sessionid: sessionid,
                            outcomes: outcomes ? JSON.stringify(outcomes) : ''
                        })
                        .catch(function(err) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true,
                                    type: 'error',
                                    message: 'endDataTransaction: ' + err
                                }
                            });
                        }).catch().then(function() {
                            return base.store.reduceStore(function(state){
                                if(state.transaction.list[sessid]){
                                  state.transaction.list[sessid].endDisabled = false;
                                }
                                return state;
                            });
                        });
                    });
                },

                //Métodos carga de trabajo omnichannel
                setWorkBusyFromOc: function(customStateBusy) {
                    var ready = base.store.getState().services.ready;
                    if (ready) {
                        thc.controller.actions.notReadyAll(customStateBusy);
                    }
                    return ready;
                },
                setWorkNotBusyFromOc: function(previousState) {
                    var ready = base.store.getState().services.ready;
                    if (!ready && previousState) {
                        thc.controller.actions.readyAll();
                    }
                },

                updateTask: function() {
                    var activeCall = base.util.call.getCurrent();
                    var activeTransaction = base.util.transaction.getCurrent();

                    var promise = Promise.resolve(true);
                    var outcomes;
                    if (!activeTransaction.endDisabled && activeTransaction.type === thc.TRANSACTION_TYPE.SESSION && activeTransaction.campaignId || activeTransaction.type === thc.TRANSACTION_TYPE.CALL) {
                        if (activeTransaction.callResult) {
                            outcomes = [];
                            for (var key in activeTransaction.callResult) {
                                var outcome = {};
                                outcome[key] = activeTransaction.callResult[key];
                                outcomes.push(outcome);
                            }
                        }

                        // Si hay una transacción en curso mandamos un endDataTransaction
                        if (activeTransaction && activeTransaction.campaignId) {
                            promise.then(function() {
                                return thc.controller.actions.endDataTransaction(outcomes, activeTransaction.id);
                            });
                        }

                        if (activeTransaction.type === thc.TRANSACTION_TYPE.CALL) {
                            promise.then(function() {
                                return base.actions.updateTask();
                            });
                        } else {
                            // base.actions.deleteCall(activeCall.cId);//AÑADIDO
                            promise.then(function() {
                                return base.store.reduceStore(function(state) {
                                    var phone = state.phone,
                                        currentTransaction = state.transaction.list[state.transaction.active],
                                        currentCall = phone.cleared[currentTransaction.id] || phone.calls[currentTransaction.id],
                                        transactionCallResult = outcomes ? JSON.stringify(outcomes) : ''; //AÑADIDO
                                    if (currentCall.log && currentCall.log.disposition && (typeof currentCall.log.disposition === 'object' || currentCall.status === 'preview')) {
                                        currentCall.log.disposition = transactionCallResult;
                                    }
                                    // 1 - Se actualiza la tarea
                                    return base.util.call.log.end(currentCall).then(function(task) {
                                        // 2 - Se muestra una notificacción con el id de la tarea generada
                                        state.notifications = {
                                            show: true,
                                            message: $Label.Tarea_actualizada + ' (' + task.taskId + ')',
                                            type: 'task',
                                            record: task.taskId
                                        };
                                        state.error.type = '';
                                        state.error.message = '';

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
                            });

                        }

                        return promise;
                      }
                },
                rejectPreviewCall: function(cId) {
                    //Deshabilitado.
                    //Override sobre el método del controlador base por si alguien lo intenta ejecutar aún estando deshabilitado en la interfaz
                },
                acceptPreviewCall: function(cId) {
                    return base.store.reduceStore(function(state) {
                            var phone = state.phone;

                            return thc.big.rest.answerCallAltitude({
                                sessionid: cId
                            }).then(function() {
                                phone.cleared[cId] = phone.calls[cId];
                                phone.dialing.push({
                                    calledDevice: phone.calls[cId].dnis,
                                    status: 'STANDBY',
                                    transactionId: cId
                                });

                                phone.active = '' + (phone.dialing.length - 1);
                                state.transaction.active = phone.calls[cId].transactionId;
                                base.util.transaction.getCurrent(state).status = thc.TRANSACTION_STATUS.ACTIVE;

                                delete phone.calls[cId];
                                return state;
                            });
                        })
                        .catch(function(answerCallError) {
                            return base.store.reduceStore({
                                notifications: {
                                    show: true
                                },
                                error: {
                                    type: 'EVENT',
                                    message: 'Error aceptando llamada: ' + answerCallError
                                }
                            });
                        });
                },

                setCallResult: function(callResult) {
                    return base.store.reduceStore(function(state) {
                        var transactionCall = state.phone.cleared[state.transaction.active] || state.phone.calls[state.transaction.active] || {},
                            currentTransaction = state.transaction.list[state.transaction.active];

                        if (typeof callResult === 'string') {
                            currentTransaction.callResult = callResult;
                            if (transactionCall.log) {
                                transactionCall.log.disposition = callResult;
                            }
                        } else {
                            var callResultObject = Object.assign(typeof currentTransaction.callResult === 'object' ? currentTransaction.callResult : {}, callResult);
                            currentTransaction.callResult = callResultObject;
                            if (transactionCall.log) {
                                transactionCall.log.disposition = callResultObject;
                            }
                        }

                        return state;
                    });
                },
                setCallResultPath: function(path) {
                    return base.store.reduceStore(function(state) {
                        var currentTransaction = state.transaction.list[state.transaction.active];
                        currentTransaction.callResultPath = path;
                        return state;
                    });
                }
            },
            events: {
                onHandshakeError: function(isManualHandshake, isRestart) {
                    if (isRestart) {
                        return base.actions.resetState();
                        //base.actions.init();
                    } else if (isManualHandshake) {
                        return base.store.reduceStore({
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
                onAgentExtensionChanged: function(eventData) {
                    //0. Integraciones con Salesforce.
                    //base.util.integration.presence.synchronizeStatuses("LOGIN");

                    return thc.big.update({
                        extension: eventData.extension
                    });
                },
                onAgentStateChanged: function(eventData) {
                    var chainPromise = Promise.resolve(true);
                    // 1 - Se actualiza el estado del agente
                    chainPromise = chainPromise.then(function() {
                        return base.store.reduceStore({
                            agent: {
                                state: eventData.state
                            }
                        });
                    });

                    // 2 - En función del estado del agente, se actualiza el estado del agente
                    switch (eventData.state.toUpperCase()) {
                        // 2.1 Cierre de sesión (forzado/manual). Se limpia el estado del softphone y se realiza el deslogeo.
                        case 'LOGOUT':
                            var phone = base.store.getState().phone;
                            phone.calls = {};
                            phone.cleared = {};
                            phone.dialing.length = 0;
                            phone.active = '';

                            chainPromise = chainPromise.then(function() {
                                return base.store.reduceStore(function(state) {
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
                                    state.transaction = { //AÑADIDO
                                        active: '',
                                        list: {}
                                    };
                                    return state;
                                });
                            });
                            break;
                    }

                    return chainPromise;
                },
                onSessionStarted: function(eventData) {
                    return base.store.reduceStore(function(state) {
                        state.transaction.list[eventData.sessionid] = {
                            id: eventData.sessionid + '',
                            type: thc.TRANSACTION_TYPE.CALL
                        };
                        state.transaction.active = eventData.sessionid + '';

                        return state;

                    });
                },



                onSessionEnded: function(eventData) {
                    return base.store.reduceStore(function(state) {
                        var phone = state.phone,
                            transaction = state.transaction.list[eventData.sessionid];

                        if (transaction && transaction.type === thc.TRANSACTION_TYPE.SESSION) { //AÑADIDO
                            // Se borran las líneas en dialing que tengan referencia a la sesión finalizada
                            phone.dialing = phone.dialing.filter(function(call) {
                                return call.transactionId !== transaction.id;
                            });

                            // Se borran las llamadas en call que tengan referencia a la sesión finalizada (Cuando se realiza abort o discard)
                            for (var call in phone.calls) {
                                if (phone.calls[call].transactionId === eventData.sessionid) {
                                    delete phone.calls[call];
                                }
                            }

                            // Se añade una línea vacía si no quedan
                            if (state.phone.dialing.length === 0 && Object.keys(state.phone.calls).length === 0 && state.phone.conferencing.length === 0 && state.phone.consulting.length === 0) { //AÑADIDO
                                state.phone.dialing.push({
                                    calledDevice: '',
                                    status: 'STANDBY'
                                });
                                state.phone.active = '0';
                                state.transaction.active = '';
                            } else if (state.phone.dialing.length) {
                                state.phone.active = '0';
                                state.transaction.active = state.phone.dialing[0].transactionId || '';
                            } else {
                                state.phone.active = Object.keys(state.phone.calls)[0];
                                state.transaction.active = Object.keys(state.phone.calls)[0] || '';
                            }
                        } else if (transaction && transaction.type === thc.TRANSACTION_TYPE.CALL) {
                            transaction.status = thc.TRANSACTION_STATUS.CLEARED;
                        }

                        return state;
                    });
                },

                onCallEstablished: function(eventData) {
                    var resolvePromise = Promise.resolve(true),
                    state = base.store.getState();
                    if(!state.phone.calls[eventData.sessionid] || !state.phone.calls[eventData.sessionid].hasOwnProperty('type')) {
                        resolvePromise = resolvePromise.then(function(){
                            return thc.controller.events.onEventOriginated({
                                cid: eventData.sessionid,
                                ucid: eventData.sessionid,
                                calleddevice: eventData.calleddevice,
                                callingdevice: eventData.callingdevice
                            });
                        });
                    }
                    return resolvePromise.then(function(){
                        thc.controller.events.onEventEstablished({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid,
                            calleddevice: eventData.calleddevice,
                            callingdevice: eventData.callingdevice,
                            userinfo: eventData.userinfo,
                            answeringdevice: eventData.answeringdevice,
                            reddevice: '',
                            queuetime: '',
                        }, {
                            parseUserinfoAsJSON: false
                        });
                    });

                },

                onCallHeld: function(eventData) {
                    return base.events.onEventCallHeld({
                        cid: eventData.sessionid,
                    });
                },

                onCallRetrieved: function(eventData) {
                    var phone = base.store.getState().phone,
                        chainPromise = Promise.resolve(true);


                    // Limpiamos la linea extendida si existe
                    if (phone.calls[eventData.sessionid] && phone.calls[eventData.sessionid].extendedLine) {
                        chainPromise = chainPromise.then(function() {
                            return thc.controller.events.onCallExtendCleared(eventData);
                        });
                    }

                    return chainPromise.then(function() {
                        return base.events.onEventCallRetrieved({
                            cid: eventData.sessionid,
                        });
                    });
                },

                onCallConnectionCleared: function(eventData) {
                    var state = base.store.getState(),
                        phone = state.phone,
                        transaction = state.transaction.list[eventData.sessionid];

                    // 0. En caso de agotarse el tiempo de espera en el preview alerting, se simula el evento onPreviewAnalysis
                    if (transaction.sessionStatus === 'PREVIEW_ALERTING') {
                        return base.store.reduceStore(function(state) {

                            var phone = state.phone;

                            base.util.transaction.getCurrent(state).status = thc.TRANSACTION_STATUS.ACTIVE;

                            delete phone.calls[eventData.sessionid];

                            state.phone.dialing = state.phone.dialing.filter(function(call) { //AÑADIDO
                                return call.calledDevice !== '';
                            });

                            if (state.phone.dialing.length === 0 && Object.keys(state.phone.calls).length === 0 && state.phone.conferencing.length === 0 && state.phone.consulting.length === 0) { //AÑADIDO
                                state.phone.dialing.push({
                                    calledDevice: '',
                                    status: 'STANDBY',
                                    transactionId: state.transaction.active
                                });
                                state.phone.active = '0';
                                state.transaction.active = state.transaction.active || '';
                            } else if (state.phone.dialing.length) {
                                state.phone.active = '0';
                                state.transaction.active = state.phone.dialing[0].transactionId || '';
                            } else {
                                state.phone.active = Object.keys(state.phone.calls)[0];
                                state.transaction.active = Object.keys(state.phone.calls)[0] || '';
                            }

                            return state;
                        }).then(function() {
                            return thc.controller.events.onCallPreviewAnalysis(eventData);

                        });

                    }

                    // 1. Es posible que llegue un onCallConnectionCleared en PREVIEW_ANALYSIS, en cuyo caso lo ignoramos
                    else if (transaction.sessionStatus === 'PREVIEW_ANALYSIS') {
                        return;
                    }

                    // 2. Si estamos en una transaccion con el estado 'CALL' significa que tenemos que limpiar la linea totalmente y actualizar la tarea
                    else if (transaction.sessionStatus === 'CALL') {

                        //Altitude devuelve un interactionkey a 0 con longitud de 40 caracteres si se ha desconectado por falta de tiempo o se ha finalizado la primera llamada
                        if (phone.calls[transaction.id] && phone.calls[transaction.id].log) { //AÑADIDO
                            return base.store.reduceStore(function(state) {
                                return base.util.call.log.end(phone.calls[transaction.id]).then(function() { //AÑADIDO
                                    //Se suma el tiempo a la tarea de la llamada principal (en preview se encuentra en cleared)
                                    if (state.phone.cleared[state.transaction.active]) { //AÑADIDO
                                        state.phone.cleared[state.transaction.active].callTime += state.phone.calls[eventData.sessionid].callTime;
                                    }
                                    delete state.phone.calls[eventData.sessionid];

                                    state.phone.dialing = state.phone.dialing.filter(function(call) {
                                        return call.calledDevice !== '';
                                    });

                                    if (state.phone.dialing.length === 0 && Object.keys(state.phone.calls).length === 0 && state.phone.conferencing.length === 0 && state.phone.consulting.length === 0) { //AÑADIDO
                                        state.phone.dialing.push({
                                            calledDevice: '',
                                            status: 'STANDBY',
                                            transactionId: state.transaction.active
                                        });
                                        state.phone.active = '0';
                                        state.transaction.active = state.transaction.active || '';
                                    } else if (state.phone.dialing.length) {
                                        state.phone.active = '0';
                                        state.transaction.active = state.phone.dialing[0].transactionId || '';
                                    } else {
                                        state.phone.active = Object.keys(state.phone.calls)[0];
                                        state.transaction.active = Object.keys(state.phone.calls)[0] || '';
                                    }

                                    return state;

                                }).catch(function(errors) {
                                    return base.store.reduceStore({
                                        notifications: {
                                            show: true,
                                            message: 'Error while updating task: ' + errors,
                                            type: 'error'
                                        }
                                    });
                                });
                                return state;
                            });
                        }

                        // 3. Si tenemos una línea extendida, este evento representa solo el borrado de la extendida
                    } else if (phone.calls[eventData.sessionid] && phone.calls[eventData.sessionid].extendedLine) {
                        thc.controller.events.onCallExtendCleared(eventData)

                        // 4. Si tenemos una conferencia, este evento representa la ida de uno de los participantes
                    } else if (phone.calls[eventData.sessionid] && phone.calls[eventData.sessionid].conference) {

                        if (eventData.releasingdevice !== state.session.extension) {
                            //4.1 Integraciones omnichannel
                            base.util.integration.presence.setBusy(false);

                            return base.store.reduceStore(function(state) {
                                var members = state.phone.calls[eventData.sessionid].conference.members;
                                members.splice(members.indexOf(eventData.releasingdevice), 1);
                                // if (members.length <= 2) {
                                //   delete state.phone.calls[eventData.sessionid].conference;
                                // }
                                return state;
                            });
                        } else {
                            return onEventCallConnectionCleared({
                                cid: eventData.sessionid,
                                ucid: eventData.sessionid,
                                propagated: false,
                                cause: 'NONE'
                            });

                        }

                        // 5. Si no es ningún caso especial, lanzamos el onEventCallConnectionCleared del base de manera normal
                    } else if (phone.calls[eventData.sessionid]) {
                        return onEventCallConnectionCleared({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid,
                            propagated: false,
                            cause: 'NONE'
                        });
                    }

                },

                onCallConferenced: function(eventData) {
                    return base.store.reduceStore(function(state) {
                        state.phone.calls[eventData.sessionid].conference = {
                            members: JSON.parse(eventData.confconnections),
                            controller: eventData.confcontroller
                        };
                        return state;
                    });
                },

                onCallFailed: function(eventData) {
                    return onEventFailed({
                        cid: eventData.sessionid,
                        ucid: eventData.sessionid,
                        propagated: false,
                        cause: eventData.cause
                    });
                },

                onCallConnectionDisconnected: function(eventData) {
                    return thc.controller.events.onCallConnectionCleared(eventData);
                },

                onCallTransferred: function(eventData) {
                    var phone = base.store.getState().phone;
                    var promise = Promise.resolve(true);
                    var isOutbound = (eventData.extension === eventData.transferingdevice);

                    // 1 - Si acabamos de hacer una transferencia,
                    if (isOutbound) {

                        // 1.1 - Limpiamos la linea extendida si existe
                        if (phone.calls[eventData.sessionid] && phone.calls[eventData.sessionid].extendedLine) {
                            promise = promise.then(function() {
                                thc.controller.events.onCallExtendCleared(eventData);
                            });
                        }

                        // 1.2 - Ejecutamos el callClear corriente
                        promise = promise.then(function() {
                            thc.controller.events.onCallConnectionCleared(eventData);
                        });

                    }

                    return promise;

                },

                onCallAlerting: function(eventData) {

                    if (!eventData.isComposed() && eventData.name === 'OnCallAlerting') {

                        eventData.compose({
                            with: function(thisEvent, withEvent) {
                                return withEvent.name === 'OnDataTransactionStarted';
                            },
                            create: function(thisEvent, withEvent) {
                                return [
                                    Object.assign(thisEvent, {
                                        campaignid: withEvent.campaignid,
                                        transferredattributes: withEvent.transferredattributes
                                    }),
                                    withEvent
                                ];
                            },
                            waitTime: 500
                        });

                        return Promise.resolve();
                    }

                    return base.store.reduceStore(function(state) {
                        var currentTransaction = state.transaction.list[eventData.sessionid];

                        onEventServiceInitiated({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid
                        }, state);


                        currentTransaction = Object.assign(currentTransaction || {}, {
                            id: eventData.sessionid,
                            type: currentTransaction && currentTransaction.type ? currentTransaction.type : thc.TRANSACTION_TYPE.CALL,
                            status: thc.TRANSACTION_STATUS.ACTIVE,
                            transferAttributes: eventData.transferredattributes ? base.util.services.formatWrapups(JSON.parse(eventData.transferredattributes), 'name', 'value') : {}
                        });

                        if (state.phone.calls[eventData.sessionid] && !state.phone.calls[eventData.sessionid].transactionId) {
                            state.phone.calls[eventData.sessionid].transactionId = eventData.sessionid;
                        }

                        if (eventData.campaignid) {
                            state.phone.calls[eventData.sessionid].campaignId = eventData.campaignid;
                        }

                        return state;
                    }).then(function() {
                        return onEventAlerting({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid,
                            calleddevice: eventData.calleddevice,
                            callingdevice: eventData.callingdevice,
                            deliveringacd: eventData.deliveringacd,
                            userinfo: eventData.userinfo,
                            answeringdevice: eventData.alertingdevice,
                            reddevice: '',
                            queuetime: '',
                            reserved: eventData.reserved
                        }, {
                            parseUserinfoAsJSON: false
                        });
                    });
                },

                onCallOriginated: function(eventData) {
                    var onOriginated = onEventOriginated;
                    var onAlerting = thc.controller.events.onCallAlerting;

                    return base.store.reduceStore(function(state) {
                        var transaction = state.transaction.list[eventData.sessionid];
                        if (transaction.sessionStatus === 'PREVIEW_ANALYSIS') {
                            transaction.sessionStatus = 'CALL';
                        }
                        return state;
                    }).then(function() {
                        return onOriginated({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid,
                            calleddevice: eventData.calleddevice,
                            callingdevice: eventData.callingdevice
                        }).then(function() {
                            return onAlerting(eventData);
                        });
                    });

                },
                onContactLoaded: function(eventData) {
                    var autoAcceptPreview = thc.settings.get().campaignOptions.autoAcceptPreview;

                    return base.store.reduceStore(function(state) {
                        var transaction = state.transaction.list[eventData.sessionid],
                            phone = state.phone,
                            onContactLoadedFinishedPromise = Promise.resolve(),
                            information = {};

                        onEventServiceInitiated({
                            cid: eventData.sessionid,
                            ucid: eventData.sessionid
                        }, state);

                        for (var info of JSON.parse(eventData.information)) {
                            if (info.value) {
                                information[info.name] = info.value;
                            }
                        }

                        phone.calls[eventData.sessionid] = Object.assign(phone.calls[eventData.sessionid], {
                            status: transaction.status === thc.TRANSACTION_STATUS.PREVIEW ? thc.TRANSACTION_STATUS.PREVIEW : 'ESTABLISHED'
                        });

                        phone.dialing = [];

                        transaction.context = {
                            uui: base.util.call.uui.parse(phone.calls[eventData.sessionid].userInfo.uui || '')
                        };

                        transaction.contact = information;

                        onContactLoadedFinishedPromise = onContactLoadedFinishedPromise.then(function() {

                            return base.util.call.log.init(phone.calls[eventData.sessionid]);

                        }).then(function(task) {
                            phone.calls[eventData.sessionid].log = Object.assign(phone.calls[eventData.sessionid].log || {}, {
                                taskId: task.taskId,
                                subject: task.subject,
                                disposition: task.disposition
                            });

                            if (transaction.type === thc.TRANSACTION_TYPE.SESSION) {
                                transaction.taskIds = (transaction.taskIds ? transaction.taskIds : []).concat([task.taskId]);
                            }

                            return base.util.call.getContext({
                                call: phone.calls[eventData.sessionid],
                                transaction: transaction
                            });

                        }).then(function(callWithContext) {
                            phone.calls[eventData.sessionid].log = Object.assign(phone.calls[eventData.sessionid].log || {}, callWithContext.log || {});
                            transaction.context = Object.assign(transaction.context || {}, callWithContext.context || {});

                            return Promise.resolve();
                        });

                        return onContactLoadedFinishedPromise.then(function() {
                            if (autoAcceptPreview && transaction && transaction.status === thc.TRANSACTION_STATUS.PREVIEW) {
                                thc.controller.actions.acceptPreviewCall(eventData.sessionid);
                            }
                            return state;
                        }).catch(function(errors) {

                            base.actions.showNotification(errors);
                            return state;
                        });

                    });
                },
                onCallPreviewAlerting: function(eventData) {
                    return base.store.reduceStore(function(state) {
                        var transaction = state.transaction.list[eventData.sessionid];
                        var phone = state.phone;

                        transaction = Object.assign(transaction || {}, {
                            status: thc.TRANSACTION_STATUS.PREVIEW,
                            sessionStatus: 'PREVIEW_ALERTING'
                        });

                        phone.active = eventData.sessionid;
                        transaction.active = eventData.sessionid;

                        phone.calls[eventData.sessionid] = {
                            cId: eventData.sessionid,
                            type: thc.CALL_TYPE.OUTBOUND,
                            dnis: eventData.devicetocall,
                            ani: eventData.extension,
                            callTime: 0,
                            transactionId: eventData.sessionid,
                            userInfo: {},
                            log: {},
                            lastUpdated: new Date()
                        };

                        phone.dialing = phone.dialing.filter(function(call) {
                            return call.calledDevice !== '';
                        });

                        return state;
                    }).then(function() {
                        return base.actions.ring().catch().then(function() {
                            return thc.sforce.setVisible({
                                visible: true
                            });
                        });
                    });
                },

                onCallPreviewAnalysis: function(eventData) {
                    return base.store.reduceStore(function(state) {
                        var transaction = state.transaction.list[eventData.sessionid];

                        transaction = Object.assign(transaction || {}, {
                            sessionStatus: 'PREVIEW_ANALYSIS'
                        });
                        return state;
                    });
                },

                onDataTransactionStarted: function(eventData) {
                    return base.store.reduceStore(function(state) {

                        if (state.phone.calls[eventData.sessionid]) {
                            state.phone.calls[eventData.sessionid].transactionId = eventData.sessionid;
                        }

                        state.transaction.list[eventData.sessionid] = Object.assign(state.transaction.list[eventData.sessionid] || {}, {
                            id: eventData.sessionid + '',
                            campaignId: eventData.campaignid,
                            type: thc.TRANSACTION_TYPE.SESSION
                        });

                        return state;

                    });
                },

                onDataTransactionEnded: function(eventData) {

                    var transaction, transactionCall;

                    return base.store.reduceStore(function(state) {

                        transaction = state.transaction.list[eventData.sessionid];

                        var phone = state.phone;
                        transactionCall = phone.cleared[transaction.id] || phone.calls[transaction.id];

                        transaction.status = thc.TRANSACTION_STATUS.CLEARED;

                        state.transaction.active = '';

                        return state;

                    }).then(function(state) {

                        var urlConfiguration = thc.settings.get().urlConfiguration;

                        return base.util.call.customPop(Object.assign({
                            log: {
                                taskId: transaction.taskIds.join(',')
                            },
                            call: transactionCall,

                            userInfo: {
                                uui: transactionCall.userInfo.uui
                            },
                            contact: transaction.contact
                        }, transaction), urlConfiguration.callEnded, urlConfiguration.openAsSubtab);

                    });

                },


                onAgentInCampaignCanOpen: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        canOpen: true
                    });


                    var wrapups = {};
                    wrapups[eventData.campaignid] = serviceWrapups[eventData.service];

                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer).then(function() {
                        return base.store.reduceStore({
                            services: {
                                wrapups: wrapups
                            }
                        });
                    });

                },
                onAgentInCampaignCannotOpen: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        canOpen: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer);
                },

                onAgentInCampaignOpen: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer);
                },
                onAgentInCampaignClose: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer);
                },

                onAgentInCampaignSignOn: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer);
                },
                onAgentInCampaignSignOff: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer);
                },

                onAgentInCampaignReady: function(eventData) {
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    return base.store.reduceStore({
                        services: {
                            campaigns: campaigns
                        }
                    }, campaignsReducer).then(function() {
                        return base.store.reduceStore({
                            agent: {
                                state: 'STARTED'
                            }
                        });
                    });

                    //0. Integraciones con Salesforce.
                    //base.util.integration.presence.synchronizeStatuses("STARTED");
                },
                onAgentInCampaignNotReady: function(eventData) {
                    var chainPromise = Promise.resolve(true);
                    // Guardamos la nueva información de la campaña
                    updateCampaign(eventData, eventData.campaignid, {
                        requestRunning: false
                    });
                    
                    chainPromise = chainPromise.then(function() {
                        return base.store.reduceStore({
                            services: {
                                campaigns: campaigns
                            }
                        }, campaignsReducer);
                    });

                    // Si todas las campañas estan not ready le marcamos como stopped
                    var allNotReady = campaigns.every(function(campaign) {
                        return !campaign.ready;
                    });
                    if (allNotReady) {
                        chainPromise = chainPromise.then(function() {
                            return base.store.reduceStore({
                                agent: {
                                    state: 'STOPPED'
                                }
                            });
                        });
                        //0. Integraciones con Salesforce.
                        //base.util.integration.presence.synchronizeStatuses("STOPPED");
                    }

                    // Y además hacemos un signoff, si la flag esta levantada (22/03/2018)
                    chainPromise = chainPromise.then(function () {
                        var isManualNotReady = false;

                        return base.store.reduceStore(function(state) {
                            var campaigns = state.services.campaigns;
                            
                            for (var campaign of campaigns) {
                                if (campaign.id == eventData.campaignid) {
                                    if (campaign.manualNotReady) {
                                        delete campaign.manualNotReady;
                                        isManualNotReady = true;
                                    }
                                }
                            }

                            return state;
                        }).then(function () {

                            if (isManualNotReady) {
                                return thc.big.rest.campaignSignOff({
                                    campaignid: eventData.campaignid
                                }).catch().then(function () {
                                    updateCampaign(eventData, eventData.campaignid, {
                                        requestRunning: true
                                    });

                                    return base.store.reduceStore({
                                        services: {
                                            campaigns: campaigns
                                        }
                                    }, campaignsReducer);
                                });
                            }

                        });
                    }); 

                    return chainPromise;
                },

                onHandshakeSuccess: function(isManualHanshake) {

                    if (isManualHanshake) {

                        return thc.big.rest.login().then(function(loginData) {
                            var chainPromise = Promise.resolve(true);
                            serviceWrapups = {};
                            if(loginData.services && loginData.services.length){
                                loginData.services.forEach(function(val) {
                                    var wraps = base.util.services.formatWrapups(val.enumeratedoutcomes, 'description', 'code');
                                    serviceWrapups[val.name] = wraps;
                                });
                            }

                            chainPromise = chainPromise.then(function() {
                                return base.store.reduceStore({
                                    isLoading: false,
                                    error: {
                                        type: 'LOGIN',
                                        message: ''
                                    },
                                    login: {
                                        forcedExtension: loginData.forceextension === 'true',
                                        defaultExtension: loginData.defaultextension,
                                        loggingInStep: 'site',
                                        sites: loginData.sites,
                                        teams: loginData.teams,
                                        defaultSite: loginData.defaultsite
                                    },
                                    services: {
                                        notReadyReasons: loginData.notreadyreasons
                                    }
                                });
                            });

                            forcedExtension = loginData.forceextension === 'true' ? loginData.defaultextension : null;

                            var site = loginData.sites.length === 1 ? loginData.sites[0] : creds.site;
                            var skipTeam = loginData.teams.length <= 1;
                            var team = loginData.teams.length <= 1 ? loginData.teams[0] : creds.team;

                            if (site && skipTeam) {
                                chainPromise = chainPromise.then(function() {
                                    return base.store.reduceStore({
                                        isLoading: true,
                                        error: {
                                            type: "EXTENSION",
                                            message: ''
                                        },
                                        login: {
                                            loggingInStep: 'extension'
                                        }
                                    }).then(function() {
                                        return thc.controller.actions.site(site, team);
                                    });
                                });

                            } else {
                                chainPromise = chainPromise.then(function() {
                                    return base.store.reduceStore({
                                        overlay: {
                                            show: false
                                        },
                                        login: {
                                            selectedSite: site,
                                            selectedTeam: team
                                        }
                                    });
                                });
                            }

                            return chainPromise;

                        }).catch(function(loginErrors) {
                            thc.big.stop();

                            return base.store.reduceStore({
                                isLoading: false,
                                error: {
                                    type: 'LOGIN',
                                    message: loginErrors
                                },
                                overlay: {
                                    show: false
                                }
                            });
                        });

                    } else {
                        return thc.controller.actions.getStatus();
                    }
                },
                onDisconnection: function(eventData) {
                    return base.events.onDisconnection(eventData);
                },
                onRetryError: function(eventData) {
                    return base.events.onRetryError(eventData);
                },
                onCallExtendOriginated: function(eventData) {
                    var phone = base.store.getState().phone;

                    phone.calls[eventData.sessionid] = Object.assign(phone.calls[eventData.sessionid] || {}, {
                        extendedLine: {
                            cid: eventData.sessionid,
                            ani: eventData.callingdevice,
                            dnis: eventData.calleddevice,
                            type: thc.CALL_TYPE.OUTBOUND,
                            status: 'RINGING'
                        }
                    });

                    return base.store.reduceStore({
                        phone: phone
                    });
                },
                onCallExtendEstablished: function(eventData) {
                    var phone = base.store.getState().phone;

                    //0  - Integraciones con Salesforce
                    base.util.integration.presence.setBusy(true);

                    phone.calls[eventData.sessionid] = Object.assign(phone.calls[eventData.sessionid] || {}, {
                        extendedLine: {
                            status: 'ESTABLISHED',
                            userinfo: eventData.userinfo,
                            answeringDevice: eventData.answeringdevice,
                            deliveringAcd: eventData.deliveringacd,
                            callTime: 0,
                            lastUpdated: new Date()
                        }
                    });

                    return base.store.reduceStore({
                        phone: phone
                    });
                },
                onCallExtendCleared: function(eventData) {
                    var phone = base.store.getState().phone;

                    delete phone.calls[eventData.sessionid].extendedLine;
                    phone.calls[eventData.sessionid].partyType = thc.PARTY_TYPE.NONE;

                    return base.store.reduceStore({
                        phone: phone
                    }, base.callTreeReducer);
                }
            }
        };
    });
})(window, document, window.sforce, window.console, window.localStorage, window.logger, window.jQuery);