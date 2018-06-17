(function(scope) {
  'use strict';

  var _settings = {};
  var availableEndpoints = [],
    roundRobinEnabled = false,
    selectedEndpoint = 0;

  function parseCallCenterSettings(callcenterSettings) {
    // 1 - Gestión de pool de IP/Puertos y endpoitns de servicio
    var pathService = callcenterSettings['/CTIEngineConfig/Path'] || '';
    var restService = callcenterSettings['/CTIEngineConfig/Rest'] || '';
    var ipPool = [
      callcenterSettings['/CTIEngineConfig/IPAddress1'] || '',
      callcenterSettings['/CTIEngineConfig/IPAddress2'] || '',
      callcenterSettings['/CTIEngineConfig/IPAddress3'] || '',
      callcenterSettings['/CTIEngineConfig/IPAddress4'] || '',
      callcenterSettings['/CTIEngineConfig/IPAddress5'] || ''
    ].filter(function(v) {
      return v !== '';
    });

    var portPool = [
      callcenterSettings['/CTIEngineConfig/Port1'] || '',
      callcenterSettings['/CTIEngineConfig/Port2'] || '',
      callcenterSettings['/CTIEngineConfig/Port3'] || '',
      callcenterSettings['/CTIEngineConfig/Port4'] || '',
      callcenterSettings['/CTIEngineConfig/Port5'] || ''
    ].filter(function(v) {
      return v !== '';
    });

    ipPool.forEach(function(ip, index) {
      var endpoint = '';

      if (ip && portPool[index]) {
        endpoint = 'https://' + ip + ':' + portPool[index] + pathService;

        availableEndpoints.push({
          base: endpoint,
          restService: endpoint + restService,
          cometdService: endpoint + '/cometd'
        });
      }
    });


    // 2 - Parseo de variables dependientes
    var _provider = callcenterSettings['/CTIEngineConfig/Provider'] || '';

    /** 3 - Variables de parseo de UUI - Preprocesado de la configuración
     * Se genera una estructura de datos que facilita el parseo posterior de la UUI de la llamada, dado por atributo - Posición UUI
     * EL formato de la cadena esperado es el dado por la configuración de UUI del fichero de CallCenter.
     * La estructura devuelta organiza los datos parseados en función de dicha configruación; p. ej, si en la posición 1 se espera el campo Account.Name, en la estructura se encontrará el valor { Account: { Name; 'Parsed Value'}}
     * En caso contrario, si en la configuración no se divide por punto, se toma directamente el valor como atributo; p.ej, si en la posición 2 se espera el valor Custom, en la estructura se encontrará el valor { Custom: 'Parsed Value' }
     */
    var parsingMap = {
        custom: {},
        objects: {}
      },
      uuiParsingSettings = [{
        position: parseInt(callcenterSettings['/ScreenPopOptions/UUIPos1'], 0) - 1,
        value: callcenterSettings['/ScreenPopOptions/UUI1']
      }, {
        position: parseInt(callcenterSettings['/ScreenPopOptions/UUIPos2'], 0) - 1,
        value: callcenterSettings['/ScreenPopOptions/UUI2']
      }, {
        position: parseInt(callcenterSettings['/ScreenPopOptions/UUIPos3'], 0) - 1,
        value: callcenterSettings['/ScreenPopOptions/UUI3']
      }, {
        position: parseInt(callcenterSettings['/ScreenPopOptions/UUIPos4'], 0) - 1,
        value: callcenterSettings['/ScreenPopOptions/UUI4']
      }, {
        position: parseInt(callcenterSettings['/ScreenPopOptions/UUIPos5'], 0) - 1,
        value: callcenterSettings['/ScreenPopOptions/UUI5']
      }].filter(function(v) {
        return (v.position || v.position === 0) && v.value;
      }).forEach(function(parsingSetting) {
        var attributeDefinition = parsingSetting.value.split('.');

        if (attributeDefinition.length === 1) {
          parsingMap.custom[parsingSetting.value] = parsingSetting.position;
        } else if (!attributeDefinition[0]) {
          parsingMap.custom[attributeDefinition[1]] = parsingSetting.position;
        } else {
          parsingMap.objects[attributeDefinition[0]] = parsingMap.objects[attributeDefinition[0]] || {};
          parsingMap.objects[attributeDefinition[0]][attributeDefinition[1]] = parsingSetting.position;
        }
      });


    /** 4 - Generación de nuevos registros
     * Estructura de generación de enlaces
     */
    var createRecordSettings, uuiSettings = [];

    if (callcenterSettings['/NewRecordOptions/useUuiParameters'] === 'Y') {
      uuiSettings = [
        callcenterSettings['/NewRecordOptions/UuiParameter1'] || '',
        callcenterSettings['/NewRecordOptions/UuiParameter2'] || '',
        callcenterSettings['/NewRecordOptions/UuiParameter3'] || '',
        callcenterSettings['/NewRecordOptions/UuiParameter4'] || '',
        callcenterSettings['/NewRecordOptions/UuiParameter5'] || ''
      ].filter(function(value) {
        return value !== ''
      });
    }

    createRecordSettings = {
      'Account': {
        url: callcenterSettings['/NewRecordOptions/newAccountUrl'] || callcenterSettings['/NewRecordOptions/newObjectPage'] || '/001/e',
        phoneClassicFieldId: callcenterSettings['/NewRecordOptions/AccountPhoneFieldId'] || callcenterSettings['/NewRecordOptions/telephoneParamenet'] || '',
        lightningPhoneField: callcenterSettings['/NewRecordOptions/AccountLightningPhoneField'] || '',
        isEnabled: callcenterSettings['/NewRecordOptions/newAccountAvailable'] === 'Y',
        uui: uuiSettings
      },
      'Contact': {
        url: callcenterSettings['/NewRecordOptions/newContactUrl'] || callcenterSettings['/NewRecordOptions/newObjectPage'] || '',
        phoneClassicFieldId: callcenterSettings['/NewRecordOptions/ContactPhoneFieldId'] || callcenterSettings['/NewRecordOptions/telephoneParamenet'] || '',
        lightningPhoneField: callcenterSettings['/NewRecordOptions/ContactLightningPhoneField'] || '',
        isEnabled: callcenterSettings['/NewRecordOptions/newContactAvailable'] === 'Y',
        uui: uuiSettings
      },
      'Lead': {
        url: callcenterSettings['/NewRecordOptions/newLeadUrl'] || callcenterSettings['/NewRecordOptions/newObjectPage'] || '',
        phoneClassicFieldId: callcenterSettings['/NewRecordOptions/LeadPhoneFieldId'] || callcenterSettings['/NewRecordOptions/telephoneParamenet'] || '',
        lightningPhoneField: callcenterSettings['/NewRecordOptions/LeadLightningPhoneField'] || '',
        isEnabled: callcenterSettings['/NewRecordOptions/newLeadAvailable'] === 'Y',
        uui: uuiSettings
      },
      'Case': {
        url: callcenterSettings['/NewRecordOptions/newCaseUrl'] || callcenterSettings['/NewRecordOptions/newObjectPage'] || '',
        phoneClassicFieldId: callcenterSettings['/NewRecordOptions/CasePhoneFieldId'] || callcenterSettings['/NewRecordOptions/telephoneParamenet'] || '',
        lightningPhoneField: callcenterSettings['/NewRecordOptions/CaseLightningPhoneField'] || '',
        isEnabled: callcenterSettings['/NewRecordOptions/newCaseAvailable'] === 'Y',
        uui: uuiSettings
      },
      'Opportunity': {
        url: callcenterSettings['/NewRecordOptions/newOpportunityUrl'] || callcenterSettings['/NewRecordOptions/newObjectPage'] || '',
        phoneClassicFieldId: callcenterSettings['/NewRecordOptions/OpportunityPhoneFieldId'] || callcenterSettings['/NewRecordOptions/telephoneParamenet'] || '',
        lightningPhoneField: callcenterSettings['/NewRecordOptions/CaseLightningPhoneField'] || '',
        isEnabled: callcenterSettings['/NewRecordOptions/newOpportunityAvailable'] === 'Y',
        uui: uuiSettings
      }
    };


    // 5 - Softphone Settings
    _settings = Object.assign(_settings, {
      // Configuración global del sistema
      system: {
        provider: _provider,
        siteId: callcenterSettings['/CTIEngineConfig/SiteId'] || '',
        linkType: _provider.toLowerCase(),
        endpoints: callcenterSettings['/CTIEngineConfig/enableRoundRobin'] === 'Y'? availableEndpoints:[availableEndpoints[0]],
        roundRobin: callcenterSettings['/CTIEngineConfig/enableRoundRobin'] === 'Y'
      },
      // Configuración del callcenter
      callcenter: {
        general: {
          callCenterName: callcenterSettings['/reqGeneralInfo/reqInternalName'],
          logoUrl: callcenterSettings['/reqGeneralInfo/reqCompanyLogo'],
          packagePrefix: callcenterSettings['/reqGeneralInfo/packagePrefix'],
        },
        dialing: {
          prefixForOutCall: callcenterSettings['/reqDialingOptions/reqOutsidePrefix'],
          prefixForInternational: callcenterSettings['/reqDialingOptions/reqInternationalPrefix'],
          internalCallRegexp: callcenterSettings['/reqDialingOptions/dialInternalLength'],
          prefixForLongDist: callcenterSettings['/reqDialingOptions/reqLongDistPrefix'],
          countryCode: callcenterSettings['/reqDialingOptions/dialCountryCode'],
          localNumberLength: callcenterSettings['/reqDialingOptions/dialLocalLength'],
          longDistanceLength: callcenterSettings['/reqDialingOptions/dialLongDistanceLength'],
          maxLines: callcenterSettings['/reqDialingOptions/numLinesPerAgent']
        },
        softphone: {
          clickToConsult: callcenterSettings['/SoftphoneOptions/clickToConsult'] === 'Y',
          isTransferEnabled: callcenterSettings['/SoftphoneOptions/transferEnabled'] === 'Y',
          isConferenceEnabled: callcenterSettings['/SoftphoneOptions/conferenceEnabled'] === 'Y',
          isAutoAnswerEnabled: callcenterSettings['/SoftphoneOptions/autoAnswerEnable'] === 'Y',
          isSidebarEnabled: callcenterSettings['/SoftphoneOptions/displayOnSideBar'] === 'Y',
          doNotCallCheck: callcenterSettings['/SoftphoneOptions/doNotCallCheck'] === 'Y',
          ringOnCall: callcenterSettings['/SoftphoneOptions/ringOnCall'] === 'Y',
          notificationOnCall: callcenterSettings['/SoftphoneOptions/notificationOnCall'] === 'Y',
          discardTransactionEnabled: callcenterSettings['/SoftphoneOptions/discardTransactionEnabled'] === 'Y',
          abortTransactionEnabled: callcenterSettings['/SoftphoneOptions/abortTransactionEnabled'] === 'Y'
        }
      },
      // LOgin settings
      login: {
        show: callcenterSettings['/loginScreenOptions/showLogginScreen'] === 'Y',
        auto: callcenterSettings['/loginScreenOptions/autoLogin'] === 'Y',
        forceExtension: false
      },
      // UUI
      screenPopOptions: {
        tranPop: callcenterSettings['/ScreenPopOptions/TranPop'],
        aniPop: callcenterSettings['/ScreenPopOptions/ANIPop'],
        dnis: callcenterSettings['/ScreenPopOptions/DNIS'],
        uui: {
          parsingMap: parsingMap,
          start: callcenterSettings['/ScreenPopOptions/UUIStart'],
          stop: callcenterSettings['/ScreenPopOptions/UUIStop'],
          separator: callcenterSettings['/ScreenPopOptions/UUISep'],
          show: callcenterSettings['/ScreenPopOptions/UUISep'],
          label: callcenterSettings['/ScreenPopOptions/UUILabel'],
          agent: callcenterSettings['/ScreenPopOptions/UUIAgent'],
        }
      },
      createRecord: createRecordSettings,
      task: {
        createTask: callcenterSettings['/taskOptions/createTask'] === 'Y',
        createInternalTask: callcenterSettings['/taskOptions/createInternalTask'] === 'Y',
        subject: callcenterSettings['/taskOptions/taskSubject'] || 'Call',
        appendTimeStampToSubject: callcenterSettings['/taskOptions/appendTimeStamp'] === 'Y',
        isInteractionLogEnabled: callcenterSettings['/taskOptions/useInteractionLog'] === 'Y',
        showCallLog: callcenterSettings['/taskOptions/callLogShow'] === 'Y',
        isCommentsEnabled: callcenterSettings['/taskOptions/hideCommentsPanel'] !== 'Y',
        preserveCallLogRelatedData: callcenterSettings['/taskOptions/callLogSelect'] === 'Y',
        isTaskRelatedDataNullable: callcenterSettings['/taskOptions/noneValueSelect'] === 'Y',
        saveCallLogCustomFields: callcenterSettings['/taskOptions/callLogCustom'] === 'Y',
        ucidURL: callcenterSettings['/taskOptions/ucidURL'],
        verintRecordingIdField: callcenterSettings['/taskOptions/verintRecordingIdField'] || '',
        autoUpdate: callcenterSettings['/taskOptions/updateTaskAutomatically'] === 'Y',
        defaultResult: callcenterSettings['/taskOptions/defaultResult'],
        transferResult: callcenterSettings['/taskOptions/transferResult'],
        results: [
          callcenterSettings['/taskOptions/CALLRESULT01'],
          callcenterSettings['/taskOptions/CALLRESULT02'],
          callcenterSettings['/taskOptions/CALLRESULT03'],
          callcenterSettings['/taskOptions/CALLRESULT04'],
          callcenterSettings['/taskOptions/CALLRESULT05'],
          callcenterSettings['/taskOptions/CALLRESULT06'],
          callcenterSettings['/taskOptions/CALLRESULT07'],
          callcenterSettings['/taskOptions/CALLRESULT08'],
          callcenterSettings['/taskOptions/CALLRESULT09'],
          callcenterSettings['/taskOptions/CALLRESULT10']
        ],
        comments: [
          callcenterSettings['/taskOptions/taskComment1'],
          callcenterSettings['/taskOptions/taskComment2'],
          callcenterSettings['/taskOptions/taskComment3'],
          callcenterSettings['/taskOptions/taskComment4'],
          callcenterSettings['/taskOptions/taskComment5'],
          callcenterSettings['/taskOptions/taskComment6'],
          callcenterSettings['/taskOptions/taskComment7'],
          callcenterSettings['/taskOptions/taskComment8'],
          callcenterSettings['/taskOptions/taskComment9']
        ],
        recordTypeId: callcenterSettings['/taskOptions/taskRecordType'],
        type: callcenterSettings['/taskOptions/taskType'],
        closeStatus: callcenterSettings['/taskOptions/closedTask'],
        recordingId: callcenterSettings['/taskOptions/recordingId']
      },
      contactMapping: (function() {
        var contactDefinition = {},
        mapping = [{
          obj: callcenterSettings['/contactMapping/ContactMapObj1'] || callcenterSettings['/dataMapping/dataMapObj1'] || '',
          sf: callcenterSettings['/contactMapping/ContactMapSF1'] || callcenterSettings['/dataMapping/dataMapSF1'] || ''
        }, {
          obj: callcenterSettings['/contactMapping/ContactMapObj2'] || callcenterSettings['/dataMapping/dataMapObj2'] || '',
          sf: callcenterSettings['/contactMapping/ContactMapSF2'] || callcenterSettings['/dataMapping/dataMapSF2'] || ''
        }, {
          obj: callcenterSettings['/contactMapping/ContactMapObj3'] || callcenterSettings['/dataMapping/dataMapObj3'] || '',
          sf: callcenterSettings['/contactMapping/ContactMapSF3'] || callcenterSettings['/dataMapping/dataMapSF3'] || ''
        }, {
          obj: callcenterSettings['/dataMapping/dataMapObj4'] || '',
          sf: callcenterSettings['/dataMapping/dataMapSF4'] || ''
        }, {
          obj: callcenterSettings['/dataMapping/dataMapObj5'] || '',
          sf: callcenterSettings['/dataMapping/dataMapSF5'] || ''
        }, {
          obj: callcenterSettings['/dataMapping/dataMapObj6'] || '',
          sf: callcenterSettings['/dataMapping/dataMapSF6'] || ''
        }].filter(function(value) {
          return value.sf && value.obj;
        }).forEach(function(fieldMapping) {
          var attributeDefinition = fieldMapping.sf.split('.');

          if (attributeDefinition.length === 2) {
            contactDefinition[attributeDefinition[0]] = contactDefinition[attributeDefinition[0]] || {};
            contactDefinition[attributeDefinition[0]][attributeDefinition[1]] = fieldMapping.obj;
          }
        });

        return contactDefinition;
      })(),
      auxReasonCodes: {
        enabled: (callcenterSettings["/ReasonCodesEnabled/AUXReasonEnabled"] === 'Y'),
        codes: [
          callcenterSettings['/AUXReasonCodes/AUX00'] || '',
          callcenterSettings['/AUXReasonCodes/AUX01'] || '',
          callcenterSettings['/AUXReasonCodes/AUX02'] || '',
          callcenterSettings['/AUXReasonCodes/AUX03'] || '',
          callcenterSettings['/AUXReasonCodes/AUX04'] || '',
          callcenterSettings['/AUXReasonCodes/AUX05'] || '',
          callcenterSettings['/AUXReasonCodes/AUX06'] || '',
          callcenterSettings['/AUXReasonCodes/AUX07'] || '',
          callcenterSettings['/AUXReasonCodes/AUX08'] || '',
          callcenterSettings['/AUXReasonCodes/AUX09'] || '',
          callcenterSettings['/AUXReasonCodes/AUX10'] || '',
          callcenterSettings['/AUXReasonCodes/AUX11'] || '',
          callcenterSettings['/AUXReasonCodes/AUX12'] || '',
          callcenterSettings['/AUXReasonCodes/AUX13'] || '',
          callcenterSettings['/AUXReasonCodes/AUX14'] || '',
          callcenterSettings['/AUXReasonCodes/AUX15'] || '',
          callcenterSettings['/AUXReasonCodes/AUX16'] || '',
          callcenterSettings['/AUXReasonCodes/AUX17'] || '',
          callcenterSettings['/AUXReasonCodes/AUX18'] || '',
          callcenterSettings['/AUXReasonCodes/AUX19'] || '',
          callcenterSettings['/AUXReasonCodes/AUX20'] || '',
        ].filter(function(value) {
          return value !== '';
        }),
        workNotReady: callcenterSettings['/AUXReasonCodes/WorkNotReady']
      },
      provider: {
        presence: {
          enabled: callcenterSettings["/presenceConfig/enablePresence"] === 'Y',
          busyStateId: callcenterSettings["/presenceConfig/presenceBusyState"],
          availableStateId: callcenterSettings["/presenceConfig/presenceAvailableState"],
          matchState: callcenterSettings["/presenceConfig/presenceAutoLogin"] === 'Y',
          autologinState: callcenterSettings["/presenceConfig/presenceAutoLoginState"]
        }
      },
      phoneFormat: {
        numberPrefixDelimiter: callcenterSettings["/TelephoneNumberFormat/NumberPrefixDelimiter"] || '',
        usePhoneFormatLibrary: callcenterSettings["/TelephoneNumberFormat/UseFormatLibrary"] === 'Y'
      },
      callPanelOptions: {
        showNoResultPanel: callcenterSettings["/CallPanelOptions/showNoResult"] === 'Y',
        showSearchInput: callcenterSettings["/CallPanelOptions/showSearchInput"] === 'Y',
        showCreateRecord: callcenterSettings["/CallPanelOptions/showCreateRecord"] === 'Y'
      },
      newRecordOptions: {
        newObjectUrl: callcenterSettings['/NewRecordOptions/newObjectPage'],
        telephoneParam: callcenterSettings['/NewRecordOptions/telephoneParamenet'],
        newAccountAvailable: callcenterSettings['/NewRecordOptions/newAccountAvailable'],
        newAccountUrl: callcenterSettings['/NewRecordOptions/newAccountUrl'],
        newAccountPhoneFieldId: callcenterSettings['/NewRecordOptions/AccountPhoneFieldId'],
        newContactAvailable: callcenterSettings['/NewRecordOptions/newContactAvailable'],
        newAContactUrl: callcenterSettings['/NewRecordOptions/newContactUrl'],
        newContactPhoneFieldId: callcenterSettings['/NewRecordOptions/ContactPhoneFieldId'],
        newLeadAvailable: callcenterSettings['/NewRecordOptions/newLeadAvailable'],
        newLeadUrl: callcenterSettings['/NewRecordOptions/newLeadUrl'],
        newLeadPhoneFieldId: callcenterSettings['/NewRecordOptions/LeadPhoneFieldId'],
        newCaseAvailable: callcenterSettings['/NewRecordOptions/newCaseAvailable'],
        newCaseUrl: callcenterSettings['/NewRecordOptions/newCaseUrl'],
        newCasePhoneFieldId: callcenterSettings['/NewRecordOptions/CasePhoneFieldId'],
        newOpportunityAvailable: callcenterSettings['/NewRecordOptions/newOpportunityAvailable'],
        newOpportunityUrl: callcenterSettings['/NewRecordOptions/newOpportunityUrl'],
        newOpportunityPhoneFieldId: callcenterSettings['/NewRecordOptions/OpportunityPhoneFieldId'],
        useUuiParams: callcenterSettings['/NewRecordOptions/useUuiParameters'] === 'Y',
        uuiParam1: callcenterSettings['/NewRecordOptions/UuiParameter1'] || '',
        uuiParam2: callcenterSettings['/NewRecordOptions/UuiParameter2'] || '',
        uuiParam3: callcenterSettings['/NewRecordOptions/UuiParameter3'] || '',
        uuiParam4: callcenterSettings['/NewRecordOptions/UuiParameter4'] || '',
        uuiParam5: callcenterSettings['/NewRecordOptions/UuiParameter5'] || ''
      },
      externalIntegration: {
        aniParsing: callcenterSettings['/externalIntegration/aniParsing'] || '',
        vdnList: callcenterSettings['/externalIntegration/vdnParsing'] ? callcenterSettings['/externalIntegration/vdnParsing'].split(';') : [],
        url: callcenterSettings['/externalIntegration/urlInvoke'] || '',
        addIVR: callcenterSettings['/externalIntegration/addIVR'] === 'Y',
        openAsSubtab: callcenterSettings['/externalIntegration/openTabOrSub']  === 'S',
        newTabName: callcenterSettings['/externalIntegration/newTabName'] || ''
      },
      urlConfiguration: {
        callStarted: callcenterSettings['/URLConfiguration/urlCallStarted'] || '',
        callEnded: callcenterSettings['/URLConfiguration/urlCallEnded'] || '',
        invokeSameTab: callcenterSettings['/URLConfiguration/urlInvokeSameTab'] === 'Y',
        openOnInboundCall: callcenterSettings['/URLConfiguration/urlInbOutInt'][0] === '1',
        openOnOutboundCall: callcenterSettings['/URLConfiguration/urlInbOutInt'][1] === '1',
        openOnInternalCall: callcenterSettings['/URLConfiguration/urlInbOutInt'][2] === '1',
        openAsSubtab: callcenterSettings['/URLConfiguration/urlOpenTabOrSub'] === 'S'
      },
      campaignOptions: {
        autoAcceptPreview: callcenterSettings['/campaignOptions/autoAcceptPreview'] === 'Y'
      }
    });
  }

  function parseSoftphoneLayoutSettings(softphoneLayout) {
    var outbound = {},
      inbound = {},
      internal = {},
      fieldLabels = {};


    for (var sObjectName in softphoneLayout.Outbound.objects) {
      if (!fieldLabels[sObjectName]) {
        fieldLabels[sObjectName] = {};
      }

      if (!outbound[sObjectName]) {
        outbound[sObjectName] = [];
      }

      softphoneLayout.Outbound.objects[sObjectName].forEach(function(field) {
        fieldLabels[sObjectName][field.apiName] = field.displayName;
        outbound[sObjectName].push(field.apiName);
      });
    }

    for (var sObjectName in softphoneLayout.Inbound.objects) {
      if (!fieldLabels[sObjectName]) {
        fieldLabels[sObjectName] = {};
      }

      if (!inbound[sObjectName]) {
        inbound[sObjectName] = [];
      }

      softphoneLayout.Inbound.objects[sObjectName].forEach(function(field) {
        fieldLabels[sObjectName][field.apiName] = field.displayName;
        inbound[sObjectName].push(field.apiName);
      });
    }

    for (var sObjectName in softphoneLayout.Internal.objects) {
      if (!fieldLabels[sObjectName]) {
        fieldLabels[sObjectName] = {};
      }

      if (!internal[sObjectName]) {
        internal[sObjectName] = [];
      }

      softphoneLayout.Internal.objects[sObjectName].forEach(function(field) {
        fieldLabels[sObjectName][field.apiName] = field.displayName;
        internal[sObjectName].push(field.apiName);
      });
    }

    // Exportamos al objetos settings
    _settings = Object.assign(_settings, {
      layout: {
        outbound: outbound,
        inbound: inbound,
        internal: internal,
        fieldLabels: fieldLabels
      }
    });
  }


    function parseCustomSettings(source, customSettings) {
      _settings.custom = _settings.custom || {};

      if (typeof customSettings === 'object') {
        _settings.custom[source] = Object.assign(_settings.custom[source] || {}, customSettings);
      } else {
        _settings.custom[source] = customSettings;
      }
    }

  function parseAudioResources(audioResources) {
    _settings.audio = _settings.audio || {};

    if (typeof audioResources === 'object') {
      for(var name in audioResources) {
        if(audioResources.hasOwnProperty(name)) {
          _settings.audio[name] = new Audio(audioResources[name]);
        }
      }
    }
  }

  function getSettings() {
    return _settings;
  }

  // Se exponen las funciones públicas del módulo
  scope.thc = scope.thc || {};
  scope.thc.settings = {
    get: getSettings,
    parse: function(source, settings) {
      switch (source) {
        case 'callcenter':
          parseCallCenterSettings(settings);
          break;
        case 'layout':
          parseSoftphoneLayoutSettings(settings);
          break;
        case 'audio':
          parseAudioResources(settings);
          break;
        default:
          parseCustomSettings(source, settings);
          break;
      }
    }
  };
})(window);
