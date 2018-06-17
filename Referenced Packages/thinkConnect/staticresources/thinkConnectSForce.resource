(function(scope, opencti, interaction, classicConsole, logger) {
  var sforceCti, sforceInteraction, sforceOpenCti, isLightning = false,
    isClassicConsole = false,
    isOmniChannelEnabled = false,
    screenPopNativeFunction = null,
    searchAndScrenPopNativeFunction = null;

  // Init
  try {
    interaction.isInConsole(function(response) {
      logger.log(logger.LOG_TYPE.SFORCE, 'OpenCTI - Classic Detected');

      if (response.result) {
        isClassicConsole = true;

        // Se detecta si OmniChannel está habilitado
        classicConsole.presence.getServicePresenceStatusId(function(response) {
          // Si se devuelve respuesta, está habilitado
          isOmniChannelEnabled = true
        });
      }

    });
  } catch (err) {
    isLightning = true;
  }

  try {
    opencti.getAppViewInfo({
      callback: function(response) {
        logger.log(logger.LOG_TYPE.SFORCE, 'OpenCTI - Lightning Detected');

      }
    });
    isLightning = true;
  } catch (err) {
    isLightning = false;
  }

  sforceInteraction = isLightning ? opencti : interaction;
  sforceOpenCti = isLightning ? opencti : interaction.cti;

  //classicMethod, lightningMethod, classicDefinition

  function listenify(def) {
    return function(callback) {

      logger.log(logger.LOG_TYPE.SFORCE_LISTENING, 'Listening for sforce event "' + (isLightning ? def.lightning.method.name : def.classic.method.name) + '" in ' + (isLightning ? 'lightning' : 'classic'));

      if (isLightning) {
        def.lightning.method.call(this, {
          listener: function(response) {
            var payload = response;

            logger.log(logger.LOG_TYPE.SFORCE_LISTENER_EVENT, 'Sforce event on "' + def.lightning.method.name + '"');
            logger.log(logger.LOG_TYPE.SFORCE_LISTENER_EVENT_DATA, payload);

            if (def.lightning.returnValue) {
              payload = typeof def.lightning.returnValue === 'function' ? def.lightning.returnValue(payload) : payload[def.lightning.returnValue];
            }

            callback(payload, response.errors);
          }
        });

      } else {
        def.classic.method.call(this, function(response) {
          var payload = JSON.parse(response.result);

          logger.log(logger.LOG_TYPE.SFORCE_LISTENER_EVENT, 'Sforce event on "' + def.classic.method.name + '"');
          logger.log(logger.LOG_TYPE.SFORCE_LISTENER_EVENT_DATA, payload);

          if (def.classic.returnValue) {
            payload = typeof def.classic.returnValue === 'function' ? def.classic.returnValue(payload) : payload[def.classic.returnValue];
          }
          callback(payload, [response.error]);
        });
      }
    }
  }

  function promisify(def) {
    return function(args) {
      return new Promise(function(resolve, reject) {

        if (isLightning && def.lightning.method || !isLightning && def.classic.method) {
          var methodName = (isLightning ? def.lightning.method.name : def.classic.method.name);
          if (methodName !== 'setSoftphoneHeight') {
            logger.log(logger.LOG_TYPE.SFORCE_REQUEST, 'Sforce request "' + methodName + '" in ' + (isLightning ? 'lightning' : 'classic'));
            logger.log(logger.LOG_TYPE.SFORCE_REQUEST_DATA, args);
          }
        }

        if (isLightning) {
          def.lightning.method.apply(this, [getLightningParams(args, getLightningCtiCallback(resolve, reject, def.lightning.returnValue, (def.lightning.method ? def.lightning.method.name : '')))]);

        } else {
          if (typeof def.classic === 'function') {
            def.classic(args)
              .then(function(result) {
                resolve(result);
              }, function(err) {
                reject(err);
              });
          } else {
            def.classic.method.apply(this, getClassicParams(args, def.classic.definition, getClassicCtiCallback(resolve, reject, def.classic.returnValue, (def.classic.method ? def.classic.method.name : ''))));
          }
        }
      });
    }
  }

  function getClassicCtiCallback(resolve, reject, returnValue, methodName) {
    return function(response) {

      if (methodName !== 'setSoftphoneHeight') {
        logger.log(logger.LOG_TYPE.SFORCE_RESPONSE, 'Sforce response to "' + methodName + '" received (classic)');
        logger.log(logger.LOG_TYPE.SFORCE_RESPONSE_DATA, response);
      }

      if (!response.error) {
        return resolve(returnValue ?
          returnValue(JSON.parse(response.result)) :
          JSON.parse(response.result)
        );
      }

      return reject([response.error]);
    }
  }

  function getLightningCtiCallback(resolve, reject, returnValue, methodName) {
    return function(response) {

      if (methodName !== 'setSoftphoneHeight') {
        logger.log(logger.LOG_TYPE.SFORCE_RESPONSE, 'Sforce response to "' + methodName + '" received (lightning)');
        logger.log(logger.LOG_TYPE.SFORCE_RESPONSE_DATA, response);
      }

      if (response.success) {
        return resolve(returnValue ? returnValue(response.returnValue) : response.returnValue);
      }

      return reject(response.errors);
    }
  }

  function getClassicMock(returnValue) {
    return function(callback) {
      callback({
        success: true,
        returnValue: returnValue
      });
    }
  }

  function getLightningMock(returnValue) {
    return function(args) {
      args.callback({
        success: true,
        returnValue: returnValue
      });
    }
  }

  // fluff up a 15 char id to return an 18 char id
  function caseSafeId(id) {
    var suffix = '';

    if (!id) return id;

    id = id.replace(/\"/g, ''); // scrub quotes from this id

    if (id.length !== 15) {
      return id;
    }

    for (var i = 0; i < 3; i++) {
      var flags = 0;

      for (var j = 0; j < 5; j++) {
        var c = id.charAt(i * 5 + j);

        if (c >= 'A' && c <= 'Z') {
          flags += 1 << j;
        }
      }
      if (flags <= 25) {
        suffix += "ABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(flags);
      } else {
        suffix += "012345".charAt(flags - 26);
      }
    }

    return id + suffix;
  }

  /**
   * Genera el objeto argumentos requerido por las funciones de la OpenCTI de Salesforce Classic, a partir los argumentos, definición y callback del método
   * @author jmartinezpisson
   * @returns {Object} Objeto argumentos con el formato esperado por la OpenCTI de Salesforce Classic
   */
  function getClassicParams(params, def, callback) {
    var args = Object.assign({}, params, {
        callback: callback
      }),
      classicParams = [];

    if (!def) {
      return [callback];
    }

    for (var i = 0; i < def.length; i++) {
      classicParams.push(getParam(params, def[i].split('.')));
    }

    classicParams.push(callback);

    return classicParams;
  }

  function getParam(params, keyArray) {
    return keyArray.length > 1 && params[keyArray[0]] ?
      getParam(params[keyArray[0]], keyArray.slice(1)) :
      params[keyArray[0]];
  }

  /**
   * Genera el objeto argumentos requerido por las funciones de la OpenCTI de Lightning, a partir del callback y los argumentos del método
   * @author jmartinezpisson
   * @returns {Object} Objeto argumentos con el formato esperado por la OpenCTI de Lightning
   */
  function getLightningParams(params, callback) {
    return Object.assign({}, params, {
      callback: callback
    });
  }

  /**
   * Obtiene los registros e ids de todas las pestañas abiertas en la consola de Classic
   * @author jmartinezpisson
   * @returns {Object} Objeto argumentos con el formato esperado por la OpenCTI de Lightning
   */
  function getConsoleContext() {
    var context = {
      tabId: null,
      subTabId: null,
      records: []
    };

    return Promise.all([
      sforce.console.getFocusedPrimaryTabId(),
      sforce.console.getFocusedSubtabId(),
      sforce.console.getPrimaryTabIds()
    ]).then(function(results) {
      var primaryTabIds = results[2],
        subTabIdPromises = [];

      context.tabId = results[0];
      context.subTabId = results[1];

      primaryTabIds.forEach(function(tabId) {
        if (tabId) {
          subTabIdPromises.push(sforce.console.getSubtabIds({
            primaryTabId: tabId
          }));
        }
      });

      return Promise.all(subTabIdPromises).then(function(subTabIdLists) {
        var pageInfoPromises = [];

        primaryTabIds.forEach(function(tabId) {
          if (tabId) {
            pageInfoPromises.push(sforce.console.getPageInfo({
              tabId: tabId
            }));
          }
        });

        subTabIdLists.forEach(function(subTabIds) {
          subTabIds.forEach(function(subTabId) {
            if (subTabId) {
              pageInfoPromises.push(sforce.console.getPageInfo({
                tabId: subTabId
              }));
            }
          });
        });

        return Promise.all(pageInfoPromises).then(function(pagesInfo) {
          context.records = pagesInfo || [];

          context.records.forEach(function(record) {
            record.recordId = record.objectId;
            record.objectType = record.object;
            record.IsPersonAccount = record.personAccount;

            if (record.contactId) {
              record.PersonContactId = record.contactId;
            }
          });

          return context;
        });
      });
    });
  }

  var sforce = {
    disableClickToDial: promisify({
      lightning: {
        method: sforceOpenCti.disableClickToDial
      },
      classic: {
        method: sforceOpenCti.disableClickToDial
      }
    }),

    enableClickToDial: promisify({
      lightning: {
        method: sforceOpenCti.enableClickToDial
      },
      classic: {
        method: sforceOpenCti.enableClickToDial
      }
    }),
    /**
     * Recupera la configuración de CallCenter para el usuario dado
     * @author jmartinezpisson
     * @returns {Promise} Returns the value of x for the equation.
     */
    getCallCenterSettings: promisify({
      lightning: {
        method: sforceOpenCti.getCallCenterSettings
      },
      classic: {
        method: sforceOpenCti.getCallCenterSettings
      }
    }),
    /**
     * Recupera la configuración de números de directorio
     * @returns {Promise} Promesa resuelta con una array de números de directorio
     */
    getDirectoryNumbers: promisify({
      lightning: {
        method: getLightningMock([]), // Not supported on LEX
      },
      classic: {
        method: sforceOpenCti.getDirectoryNumbers,
        definition: [
          'isGlobal',
          'callCenterName',
          'callback',
          'resultSetPage',
          'resultSetPageSize'
        ]
      }
    }),

    getPageInfo: promisify({
      lightning: {
        method: sforceOpenCti.getAppViewInfo,
        returnValue: function(returnValue) {

          if (returnValue.contactId) {
            returnValue.PersonContactId = returnValue.contactId;
          }

          return Object.assign(returnValue, {
            objectId: returnValue.recordId,
            object: returnValue.objectType,
            objectName: returnValue.recordName,
            IsPersonAccount: returnValue.personAccount || false
          });
        }
      },
      classic: {
        method: sforceInteraction.getPageInfo,
        returnValue: function(returnValue) {
          returnValue.objectId = caseSafeId(returnValue.objectId);
          if (returnValue.contactId) {
            returnValue.PersonContactId = returnValue.contactId;
          }

          return Object.assign(returnValue, {
            recordId: returnValue.objectId,
            objectType: returnValue.object,
            recordName: returnValue.objectName,
            IsPersonAccount: returnValue.personAccount || false
          });
        }
      }
    }),

    getSoftphoneLayout: promisify({
      lightning: {
        method: sforceOpenCti.getSoftphoneLayout
      },
      classic: {
        method: sforceOpenCti.getSoftphoneLayout
      }
    }),


    isInConsole: promisify({
      lightning: {
        method: getLightningMock(true) // Not supported on LEX
      },
      classic: {
        method: sforceInteraction.isInConsole
      }
    }),

    isVisible: promisify({
      lightning: {
        method: sforceOpenCti.isSoftphonePanelVisible
      },
      classic: {
        method: sforceOpenCti.isVisible
      }
    }),

    notifyInitializationComplete: promisify({
      lightning: {
        method: sforceOpenCti.notifyInitializationComplete
      },
      classic: {
        method: sforceOpenCti.notifyInitializationComplete
      }
    }),

    onClickToDial: listenify({
      lightning: {
        method: sforceOpenCti.onClickToDial
      },
      classic: {
        method: sforceOpenCti.onClickToDial,
        returnValue: function(payload) {
          payload.objectId = caseSafeId(payload.objectId);

          return {
            number: payload.number || '',
            recordId: payload.objectId || '',
            recordName: payload.objectName || '',
            objectType: null,
            accountId: payload.accountId || null,
            contactId: payload.contactId || null,
            personAccount: payload.personAccount || false,
            PersonContactId: payload.contactId || null,
            IsPersonAccount: payload.personAccount || false
          };
        }
      }
    }),

    // onNavigationChange
    onNavigationChange: listenify({
      lightning: {
        method: sforceInteraction.onNavigationChange
      },
      classic: {
        method: sforceInteraction.onFocus,
        returnValue: function(payload) {
          payload.objectId = caseSafeId(payload.objectId);
          if (payload.contactId) {
            payload.PersonContactId = payload.contactId;
          }

          return {
            url: payload.url || '',
            objectType: payload.object || '',
            recordId: payload.objectId || '',
            recordName: payload.objectName || '',
            accountId: payload.accountId || '',
            contactId: payload.contactId || '',
            PersonContactId: payload.PersonContactId || '',
            personAccount: payload.personAccount || false,
            IsPersonAccount: payload.personAccount || false
          };
        }
      }
    }),

    // refreshView
    refreshPage: promisify({
      lightning: {
        method: sforceInteraction.refreshView
      },
      classic: {
        method: sforceInteraction.refreshPage,
      }
    }),

    refreshRelatedList: promisify({
      lightning: {
        method: sforceInteraction.refreshView
      },
      classic: {
        method: sforceInteraction.refreshRelatedList,
      }
    }),

    reloadFrame: promisify({
      lightning: {
        method: sforceInteraction.refreshView
      },
      classic: {
        method: sforceInteraction.reloadFrame,
      }
    }),

    runApex: promisify({
      lightning: {
        method: sforceOpenCti.runApex
      },
      classic: {
        method: sforceOpenCti.runApex,
        definition: [
          'apexClass',
          'methodName',
          'methodParams'
        ]
      }
    }),

    saveLog: promisify({
      lightning: {
        method: sforceInteraction.saveLog
      },
      classic: {
        method: sforceInteraction.saveLog,
        definition: ['value.entityApiName', 'value.Id', 'value.param']
      }
    }),

    screenPop: promisify({
      lightning: {
        method: sforceOpenCti.screenPop
      },
      classic: {
        method: sforceInteraction.screenPop,
        definition: ['url', 'force']
      }
    }),

    // searchAndScreenPop
    //earchAndGetScreenPopUrl

    searchAndScreenPop: promisify({
      lightning: {
        method: sforceOpenCti.searchAndScreenPop
      },
      classic: {
        method: sforceInteraction.searchAndScreenPop,
        definition: ['searchParams', 'queryParams', 'callType'],
        returnValue: function(returnValue) {
          var result = {},
            newId = '';

          for (var id in returnValue) {
            newId = caseSafeId(id);
            result[newId] = returnValue[id];

            // Cuentas personales
            result[newId] = Object.assign(result[newId], {
              id: newId,
              recordId: newId,
              IsPersonAccount: result[newId].personAccount || false,
              PersonContactId: result[newId].contactId || false
            });
          }

          return result;
        }
      }
    }),
    setSoftphoneWidth: promisify({
      lightning: {
        method: sforceOpenCti.setSoftphonePanelWidth
      },
      classic: {
        method: sforceOpenCti.setSoftphoneWidth,
        definition: ['widthPX']
      }
    }),

    setSoftphoneHeight: promisify({
      lightning: {
        method: function(args) {
          if (args.heightPX < 240) {
            args.heightPX = 240;
          } else if (args.heightPX > 700) {
            args.heightPX = 700;
          }

          sforceOpenCti.setSoftphonePanelHeight(args);
        }
      },
      classic: {
        method: sforceOpenCti.setSoftphoneHeight,
        definition: ['heightPX']
      }
    }),

    // setSoftphonePanelVisibility
    setVisible: promisify({
      lightning: {
        method: sforceOpenCti.setSoftphonePanelVisibility
      },
      classic: {
        method: sforceInteraction.setVisible,
        definition: ['visible']
      }
    }),

    // Consola
    console: {
      // loginOnServicePresence
      loginOnServicePresence: promisify({
        lightning: {
          method: getLightningMock('') // Not yet supported on Lightning
        },
        classic: function(args) {
          if (!isOmniChannelEnabled) {
            return new Promise.reject(['Error: OmniChannel is disabled on Salesforce Setup']);
          }

          return new Promise(function(resolve, reject) {
            classicConsole.presence.login(args.statusId, function(response) {

              if (!response.success) {
                return reject(['Error login on OmniChannel']);
              }

              return resolve();
            });
          });
        }
      }),
      // getServicePresenceStatusId
      getServicePresenceStatusId: promisify({
        lightning: {
          method: getLightningMock('') // Not yet supported on Lightning
        },
        classic: function(args) {
          if (!isOmniChannelEnabled) {
            return new Promise.reject(['Error: OmniChannel is disabled on Salesforce Setup']);
          }

          return new Promise(function(resolve, reject) {
            classicConsole.presence.getServicePresenceStatusId(function(response) {

              if (!response.success) {
                return reject(['Error retrieving PresenceStatusId']);
              }

              resolve({
                statusName: response.statusName,
                statusApiName: response.statusApiName,
                statusId: response.statusId
              });
            });
          });
        }
      }),
      // setServicePresenceStatus
      setServicePresenceStatus: promisify({
        lightning: {
          method: getLightningMock('') // Not yet supported on Lightning
        },
        classic: function(args) {
          if (!isOmniChannelEnabled) {
            return new Promise.reject(['Error: OmniChannel is disabled on Salesforce Setup']);
          }

          return new Promise(function(resolve, reject) {
            classicConsole.presence.setServicePresenceStatus(args.stateId, function(response) {

              if (!response.success) {
                return reject(['Error setting PresenceStatusId']);
              }

              resolve({
                statusName: response.statusName,
                statusApiName: response.statusApiName,
                statusId: response.statusId,
                channels: JSON.parse(response.channels)
              });
            });
          });
        }
      }),
      // getFocusedPrimaryTabId
      getFocusedPrimaryTabId: promisify({
        lightning: {
          method: getLightningMock(null) // Not yet supported on Lightning
        },
        classic: function() {
          return new Promise(function(resolve, reject) {
            try {
              classicConsole.getFocusedPrimaryTabId(function(response) {

                if (!response.success) {
                  return resolve(null);
                }

                return resolve(response.id);
              });
            } catch (error) {
              return reject(error);
            }
          });
        }
      }),
      // getFocusedSubtabId
      getFocusedSubtabId: promisify({
        lightning: {
          method: getLightningMock(null) // Not yet supported on Lightning
        },
        classic: function() {
          return new Promise(function(resolve, reject) {
            try {
              classicConsole.getFocusedSubtabId(function(response) {

                if (!response.success) {
                  return resolve(null);
                }

                return resolve(response.id);
              });
            } catch (error) {
              return reject(error);
            }
          });
        }
      }),
      // getPrimaryTabIds
      getPrimaryTabIds: promisify({
        lightning: {
          method: getLightningMock([]) // Not yet supported on Lightning
        },
        classic: function() {
          return new Promise(function(resolve, reject) {
            classicConsole.getPrimaryTabIds(function(response) {

              if (!response.success) {
                return reject(['Error getting  tabIds']);
              }

              return resolve(response.ids);
            });
          });
        }
      }),
      // getSubtabIds
      getSubtabIds: promisify({
        lightning: {
          method: getLightningMock([]) // Not yet supported on Lightning
        },
        classic: function(args) {
          return new Promise(function(resolve, reject) {
            classicConsole.getSubtabIds(args.primaryTabId, function(response) {

              if (!response.success) {
                return reject(['Error getting subTabIds']);
              }

              return resolve(response.ids);
            });
          });
        }
      }),
      // getPageInfo
      getPageInfo: promisify({
        lightning: {
          method: getLightningMock({}) // Not yet supported on Lightning
        },
        classic: function(args) {
          return new Promise(function(resolve, reject) {
            classicConsole.getPageInfo(args.tabId, function(response) {
              var pageInfo;

              if (!response.success) {
                return reject(['Error getting pageInfo']);
              }

              pageInfo = JSON.parse(response.pageInfo);
              pageInfo.objectId = caseSafeId(pageInfo.objectId);

              if (pageInfo.contactId) {
                pageInfo.PersonContactId = pageInfo.contactId;
              }

              return resolve(Object.assign(pageInfo, {
                IsPersonAccount: pageInfo.personAccount || false,
                recordId: pageInfo.objectId,
                objectType: pageInfo.object,
              }));
            });
          });
        }
      }),
      // openPrimaryTab
      openPrimaryTab: promisify({
        lightning: {
          method: getLightningMock(null) // Not yet supported on Lightning
        },
        classic: {
          method: classicConsole.openPrimaryTab,
          definition: ['id', 'url', 'active', 'tabLabel', 'callback', 'name']
        }
      }),
      // openSubtab
      openSubtab: promisify({
        lightning: {
          method: getLightningMock(null) // Not yet supported on Lightning
        },
        classic: {
          method: classicConsole.openSubtab,
          definition: ['primaryTabId', 'url', 'active', 'tabLabel', 'id', 'callback', 'name']
        }
      }),
      // Interaction Log
      fireOnCallBegin: promisify({
        lightning: {
          method: getLightningMock(true) // Not yet supported on Lightning
        },
        classic: function(args) {
          return new Promise(function(resolve, reject) {
            classicConsole.cti.fireOnCallBegin(args.callObjectId, args.callType, args.callLabel, function(response) {

              if (!response.success) {
                return reject(['Error while initializing Interaction Log.']);
              }

              return resolve(true);
            });
          });
        }
      }),
      fireOnCallEnd: promisify({
        lightning: {
          method: getLightningMock(true) // Not yet supported on Lightning
        },
        classic: function(args) {
          return new Promise(function(resolve, reject) {
            classicConsole.cti.fireOnCallEnd(args.callObjectId, args.callDuration, args.callDisposition, function(response) {

              if (!response.success) {
                return reject(['Error while sending information to Interaction Log.']);
              }

              return resolve(true);
            });
          });
        }
      }),
      // Make softphone popoutable for multimonitor support
      setCustomConsoleComponentPopoutable: promisify({
        lightning: {
          method: getLightningMock(true)
        },
        classic: function(args) {
          if (isClassicConsole) {
            return new Promise(function(resolve, reject) {
              classicConsole.setCustomConsoleComponentPopoutable(args.popoutable, function(result) {
                if (!result.success) {
                  return reject(['Error while making component popoutable']);
                }

                return resolve(true);
              });
            });
          }
        }
      }),
      isCustomConsoleComponentPoppedOut: promisify({
        lightning: {
          method: getLightningMock(false)
        },
        classic: function(args) {
          if (isClassicConsole) {
            return new Promise(function(resolve, reject) {
              classicConsole.isCustomConsoleComponentPoppedOut(function(result) {
                if (!result.success) {
                  return reject(['Error checking making component popoutable']);
                }

                return resolve(result.poppedOut);
              });
            });
          }
        }
      }),
      addEventListener: function(args) {
        classicConsole.addEventListener(args.eventType, args.eventListener, args.additionalParams);
      },
      removeEventListener: function(args) {
        if (classicConsole) {
          classicConsole.removeEventListener(args.eventType, args.eventListener, args.additionalParams);
        }
      }
    },

    // Utils

    util: {
      isLightning: function() {
        return Promise.resolve(isLightning);
      },
      // Utilidades
      /**
       * Permite realizar un pop de una URL personalizada, supliendo las carencias de los modos de Salesforce que no admiten control de pestañas.
       **
       * @returns {Promise} Promesa resuelta con una array de números de directorio
       */
      popURL: function(args) {
        if (isClassicConsole) {

          return new Promise(function(resolve, reject) {
            if (args.tabId) {
              classicConsole.openSubtab(args.tabId, args.url, args.active, args.label, null, function(response) {
                if (response.success) {
                  return resolve(response.id);
                }

                // Se realiza un openTab normal
                classicConsole.openPrimaryTab(null, args.url, args.active, args.label, function(response) {
                  if (response.success) {
                    return resolve(response.id);
                  }

                  return reject('Error popping URL on console in a primary tab: ' + JSON.stringify(args));
                }, args.name);
              }, args.name);
            } else {
              classicConsole.openPrimaryTab(null, args.url, args.active, args.label, function(response) {
                if (response.success) {
                  return resolve(response.id);
                }

                return reject('Error popping URL on console in a primary tab: ' + JSON.stringify(args));
              }, args.name);
            }
          });
        } else {

          return sforce.screenPop({
            type: opencti.SCREENPOP_TYPE.URL,
            deferred: args.deferred || false,
            params: {
              url: args.url
            },
            force: true,
            url: args.url
          });
        }
      },
      /**
       * Permite realizar un pop de un registro
       **
       * @author jmartinezpisson
       * @param args.recordId Id de regisrto a popear
       * @returns {Promise} Promesa resuelta con el id. de pestaña, si aplica
       */
      screenPopRecord: function(args) {

        if (isClassicConsole) {
          return new Promise(function(resolve, reject) {
            classicConsole.openPrimaryTab(null, '/' + args.recordId, true, undefined, function(response) {
              if (response.success) {
                return resolve({ tabId: response.id });
              }

              return reject('Error popping URL on console in a primary tab: ' + JSON.stringify(args));
            });
          }).catch(function() {
            return sforce.screenPop({
              type: opencti.SCREENPOP_TYPE.SOBJECT,
              params: {
                recordId: args.recordId
              },
              force: true,
              url: '/' + args.recordId
            });
          });
        }

        return sforce.screenPop({
          type: opencti.SCREENPOP_TYPE.SOBJECT,
          params: {
            recordId: args.recordId
          },
          force: true,
          url: '/' + args.recordId
        });
      },
      /**
       * Permite realizar un pop dela página de búsqueda
       **
       * @author jmartinezpisson
       * @returns {Promise} Promesa resuelta con un true
       */
      screenPopSearch: function(args) {
        return sforce.screenPop({
          type: opencti.SCREENPOP_TYPE.SEARCH,
          deferred: args.deferred || false,
          params: {
            searchString: args.searchString
          },
          force: true,
          url: '/_ui/search/ui/UnifiedSearchResults?searchType=2&str=' + args.searchString
        });
      },
      /**
       * Permite realizar un pop dela página de búsqueda
       **
       * @author jmartinezpisson
       * @returns {Promise} Promesa resuelta con un true
       */
      screenPopCreateRecord: function(args) {
        return sforce.screenPop({
          type: opencti.SCREENPOP_TYPE.NEW_RECORD_MODAL,
          deferred: args.deferred || false,
          params: {
            defaultFieldValues: args.defaultFieldValues || {},
            entityName: args.sObjectType
          },
          force: true,
          url: args.url
        });
      },
      /**
       * Devuelve el contexto completo de registros de una App; si es la consola de Classic, este incluye todos los registros de todas las pestañas/subpestañas
       **
       * @author jmartinezpisson
       * @returns {Promise} Promesa resuelta con array de registros
       */
      getAppContext: function() {

        if (isClassicConsole) {
          return getConsoleContext();
        }

        return sforce.getPageInfo().then(function(pageInfo) {
          return {
            primaryTabId: null,
            subTabId: null,
            records: pageInfo.recordId ? [pageInfo] : []
          };
        });
      },
      /**
       * Inicializa el interaction Log. En caso de estar en Classic sin consola o en Lightning, se devuelve una promesa con true
       **
       * @author jmartinezpisson
       * @returns {Promise} Promesa resuelta con array de registros
       */
      initCallOnInteractionLog: function(args) {

        if (isClassicConsole) {
          return classicConsole.cti.fireOnCallBegin(args.callObjectId, args.callType, args.callLabel); //args
        }

        return Promise.resolve(true);
      },
      /**
       * Finaliza el interaction Log. En caso de estar en Classic sin consola o en Lightning, se devuelve una promesa con true
       **
       * @author jmartinezpisson
       * @returns {Promise} Promesa resuelta con array de registros
       */
      endCallOnInteractionLog: function(args) {

        if (isClassicConsole) {
          return classicConsole.cti.fireOnCallEnd(args.callObjectId, args.callDuration, args.callDisposition); //args
        }

        return Promise.resolve(true);
      }
    },
    deferUntilScreenPop: function(returnValue) {
      if (!classicConsole) {
        return Promise.resolve(returnValue);
      }

      return new Promise(function(resolve) {
        var timeoutId = scope.setTimeout(function() {
          classicConsole.removeEventListener(classicConsole.ConsoleEvent.OPEN_TAB, waitFor);
          resolve(returnValue);
        }, 1500);

        var waitFor = function() {
          resolve(returnValue);
          scope.clearTimeout(timeoutId);
          classicConsole.removeEventListener(classicConsole.ConsoleEvent.OPEN_TAB, waitFor);
        };

        classicConsole.addEventListener(classicConsole.ConsoleEvent.OPEN_TAB, waitFor);
      });
    }
  };

  // Module Exports
  scope.thc = scope.thc || {};
  scope.thc.sforce = sforce;

})(window, window.sforce.opencti, window.sforce.interaction, window.sforce.console, window.logger);
