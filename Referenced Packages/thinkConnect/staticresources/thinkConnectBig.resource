(function(scope, document, logger, $) {
  'use strict';

  // Constantes
  var MAX_RETRIES = 2;

  var $cometd = scope.$cometd || $.cometd,
    _handlers = {},
    _state = {
      endpoint: '',
      restService: '',
      cometdService: '',
      connected: false,
      wasConnected: true,
      allowManualHandshake: true,
      forceReconnection: false,
      retries: 0,
      auth: {
        extension: '',
        siteid: '',
        linkType: '',
        password: '',
        username: '',
        teamid: null
        /*campaignid: null*/
        /*reason: null*/
      }
    },
    ACCESS_TOKEN = '',
    EXPIRES_IN = '';

    function roundRobin(list) {
      if(list.length > 0 && roundRobin.selected < list.length - 1){
        roundRobin.selected++;
      }else{
        roundRobin.selected = 0;
      }

      logger.log(logger.LOG_TYPE.CUSTOM, 'Using IP: ', list[roundRobin.selected].base);

      return list[roundRobin.selected];
    }

  /**
   * Funciones públicas del módulo
   */
  /**
   * Inicializa la conexión a CometD
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function init(settings) {
    var endpoint;
    logger.log(logger.LOG_TYPE.COMETD, 'Initializing CometD client');
    // 1 - Inicializamos y registramos los handlers
    settings = settings || {};
    settings.events = settings.events || {};

    _state.endpoints = settings.endpoints || [];
    roundRobin.selected = thc.settings.get().system.roundRobin ? Math.floor(Math.random() * _state.endpoints.length) : 0;
    endpoint = roundRobin(_state.endpoints);
    _state.endpoint = endpoint.base || '';
    _state.restService = endpoint.restService || '';
    _state.cometdService = endpoint.cometdService || '';
    _state.auth.extension = settings.extension || '';
    _state.auth.siteid = settings.siteId || '';
    _state.auth.linkType = settings.linkType || '';

    _state.auth.username = settings.username || '';
    _state.auth.password = settings.password || '';

    // Función de obtención de credenciales OAuth
    if (typeof(settings.getOAuthCredentials) === 'function') {
      getOAuthCredentials = settings.getOAuthCredentials;
    }

    for (var event in settings.events) {
      if (settings.events.hasOwnProperty(event)) {
        addHook(event, settings.events[event]);
      }
    }

    // 2 - Se revisa que los eventos del sistema tienen handler asociado y se lanza un error en caso contrario
    if (!_handlers.onConnectionEstablished || !_handlers.onConnectionRetry ||
      !_handlers.onConnectionBroken || !_handlers.onConnectionClosed ||
      !_handlers.onHandshakeSuccess || !_handlers.onHandshakeError ||
      !_handlers.onDisconnection || !_handlers.onRetryError) {
      throw new Error('Fatal Error. No callback registered for softphone system events. Please check the initialization config.');
    }

    // 3 - Se añaden los listeners a los canales de CometD:
    $cometd.addListener("/meta/handshake", _metaHandshake);
    $cometd.addListener("/meta/connect", _metaConnect);
    $cometd.addListener('/meta/disconnect', _metaDisconnect);

    // 4 - Se añade gestión de excepciones
    $cometd.onListenerException = function(exception, subscriptionHandle, isListener, message) {
      logger.log(logger.LOG_TYPE.ERROR, 'Ha ocurrido un error en el listener de CometD', exception, message);
    };

    logger.log(logger.LOG_TYPE.COMETD, 'CometD client reporting for duty!');

    // 5 - Get Access Token
    // getToken();
  }

  /**
   * Registra un hook para ejecutar un callback ante un evento de BIG/CometD
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function addHook(event, handler) {
    _handlers[event] = handler;
    _handlers[event.charAt(0).toUpperCase() + event.slice(1)] = handler;
  }

  /**
   * Elimina un hook para un evento determinado
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function removeHook(event, handler) {
    var capitalizedEvent = event.charAt(0).toUpperCase() + event.slice(1);

    if (_handlers[event]) {
      delete _handlers[event];
    }

    if (_handlers[capitalizedEvent]) {
      delete _handlers[capitalizedEvent];
    }
  }

  /**
   * Inicializa la comunicación CometD
   **
   * @author jmartinezpisson
   * @date 28/09/2017
   */
  function start(settings) {

    if (settings) {
      _state.auth.extension = (settings.extension || settings.extension === '') ? settings.extension : _state.auth.extension;
      _state.auth.username = (settings.username || settings.username === '') ? settings.username : _state.auth.username;
      _state.auth.password = (settings.password || settings.password === '') ? settings.password : _state.auth.password;
      _state.auth.siteid = settings.siteId || _state.auth.siteid;
      _state.auth.linkType = settings.linkType || _state.auth.linkType;
      _state.auth.teamid = settings.teamId || _state.auth.teamid;
      //_state.auth.campaignid = settings.campaignid || _state.auth.campaignid; // Comentado con miedo por axel

      _state.allowManualHandshake = settings.isRestart ? !settings.isRestart : true;
    }

    $cometd.configure({
      url: _state.cometdService
    });

    var additional = {
      extension: _state.auth.extension,
      apptype: 'desktop',
      siteid: _state.auth.siteid,
      linktype: _state.auth.linkType,
      agentname: _state.auth.username
    };

    getToken().then(function() {
      $cometd.handshake(additional);

    }).catch(function(error) {
      _handlers.onHandshakeError(_state.allowManualHandshake, settings && settings.hasOwnProperty('isRestart') ? settings.isRestart : false);
    });

  }

  /**
   * Actualiza los parametros internos de las peticiones
   */
  function updateAuth(settings) {
    if (settings) {
      _state.auth = Object.assign(_state.auth, settings);
    }
  }

  /**
   * Detiene la comunicación CometD
   **
   * @author jmartinezpisson
   * @date 28/09/2017
   */
  function stop(isReset) {
    $cometd.disconnect();

    if(!isReset) {
      var endpoint = roundRobin(_state.endpoints);

      _state.endpoint = endpoint.base || '';
      _state.restService = endpoint.restService || '';
      _state.cometdService = endpoint.cometdService || '';
      _state.allowManualHandshake = true;
      _handlers.onDisconnection();
    }
  }

  /**
   * Funciones privadas del módulo
   */

  /**
   * Util Functions
   */
  function _logCometd(channel, message) {
    logger.log(logger.LOG_TYPE.EVENT, 'Event received: "' + message.data.name + '" on channel ' + channel);
  }


  function _keysToCamelCase(target) {
    var stringToCamelCase = function(s) {
      return s.replace(/-([a-z])/g, function(g) {
        return g[1].toUpperCase();
      });
    }
    var i = 0;
    for (var key in target) {
      if (typeof target[key] !== 'undefined') {
        if (typeof target[key] === 'object' && !(target[key] instanceof Array)) {
          _keysToCamelCase(target[key]);
        }
        if (target[key] instanceof Array) {
          for (var i = 0; i < target[key].length; i++) {
            _keysToCamelCase(target[key][i]);
          }
        }
        if (~key.indexOf('_') || ~key.indexOf('-')) {
          var oldKey = key;
          key = key.replace(/_/g, '-');
          key = stringToCamelCase(key);
          target[key] = target[oldKey];
          delete target[oldKey];
        }
      }
      i = ++i;
    }
    return target;
  }

  /**
   * CometD - Hard Reset. Fuerza la desconexión y un nuevo handshake.
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function reset() {
    var endpoint = roundRobin(_state.endpoints);

    stop(true);

    _state.endpoint = endpoint.base || '';
    _state.restService = endpoint.restService || '';
    _state.cometdService = endpoint.cometdService || '';
    _state.allowManualHandshake = false;

    start();
  }

  /**
   * CometD - Hard Reset. Fuerza la desconexión y un nuevo handshake.
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function reconnect() {
    var endpoint = roundRobin(_state.endpoints);

    $cometd.disconnect();

    _state.endpoint = endpoint.base || '';
    _state.restService = endpoint.restService || '';
    _state.cometdService = endpoint.cometdService || '';
    _state.allowManualHandshake = false;
    _state.forceReconnection = true;

    $cometd.configure({
      url: _state.cometdService
    });

    $cometd.handshake({
      extension: _state.auth.extension,
      apptype: 'desktop',
      siteid: _state.auth.siteid,
      linktype: _state.auth.linkType,
      agentname: _state.auth.username
    });
  }
  /**
   * CometD - Handshake handler. Gestiona el handshake de CometD
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function _metaHandshake(handshake) {
    var isManualHandshake = _state.allowManualHandshake;

    logger.log(logger.LOG_TYPE.COMETD, 'Handshake: Successful? ' + handshake.successful + ' - isManualHandshake: ' + isManualHandshake + ' - ' + JSON.stringify(handshake));

    // 1 - Gestión del success
    if (handshake.successful) {
      if ($cometd.getAdvice() && $cometd.getAdvice().reconnect === 'handshake') {
        logger.log(logger.LOG_TYPE.COMETD, 'Received advice: handshake during a succesful handshake. Resetting...');
        return start();
      }

      logger.log(logger.LOG_TYPE.COMETD, 'Successful handshake');

      // 1.1 - Se ejecuta un callback para la gestión de un handshake exitoso, identificando si el handshake ha sido manual y bloqueando la ejecución de futuros
      _state.allowManualHandshake = false;
      _state.forceReconnection = false;
      _handlers.onHandshakeSuccess(isManualHandshake);


      // 1.2 - En algunas centralitas se realiza una gestión posterior del token para realizar la monitorización
      if (_handlers.onHandshakeTokenReceived) {
        // Datos que necesitamos de BIG (Token de acceso que necesitamos para la monitorizacion)
        if (handshake.ext && handshake.ext.token) {
          _handlers.onHandshakeTokenReceived(handshake.ext.token, isManualHandshake);
        } else {
          // No se ha recibido correctamente el Token; si no, es un error en el handshake
          if (handshake.ext) {
            _handlers.onHandshakeError(isManualHandshake);
          } else {
            logger.log(logger.LOG_TYPE.ERROR, 'Error on handshake, no "ext" found on handshake');
          }
        }
      }

      // 1.3 - Se (re)suscribe a los eventos de BIG
      _suscribeChannels(handshake);
    } else { // 2 - Gestión de errores en callbacks
      // 2.1 - Se evita un reintento en fallos graves de conexión
      if ((handshake.error && handshake.error.indexOf("403") === 0) || (handshake.failure && handshake.failure.reason.indexOf("Extra Connection") === 0)) {
        _state.forceReconnection = false;
      }

      // 2.2 - Si es una reconexión forzada, se reintenta
      if(_state.forceReconnection) {
        return reconnect();
      }

      // 2.3 - Se lanza el callback de gestión de errores en handshake
      _handlers.onHandshakeError(isManualHandshake);

      // 2.4 - Si el handshake es manual y falla no se reintenta la conexión.
      logger.log(logger.LOG_TYPE.COMETD, 'Manual handshake failed. isDisconnected: ' + $cometd.isDisconnected());
      if (_state.allowManualHandshake) {
        return $cometd.disconnect();
      }
    }
  }

  /**
   * CometD - Handshake handling. Función auxiliar para escuchar los canales y eventos de BIG
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   */
  function _suscribeChannels(handshake) {
    var bigChannelSubscribe = '/cti/' + _state.extension + '/*';

    if (handshake.ext && handshake.ext.bigchannel) {
      bigChannelSubscribe = handshake.ext.bigchannel;
    }

    $cometd.batch(function() {
      $cometd.subscribe(bigChannelSubscribe, function(message) {
        _logCometd('BigChannelSubscribe', message);
        handleMessage(message);
      });
    });
  }

  /**
   * CometD - Event Handling. Gestión avanzada de eventos de CometD
   **
  /**
   * Gestiona el evento CometD, realizando las acciones de pre y post procesamiento, y llamando al handler registrado
   **
   * @author jmartinezpisson
   * @date 21/12/2017
   */
  var beforeEvents = [],
    afterEvents = [],
    compoundEvents = [],
    MAX_WAIT_TIME = 250,
    eventHandlingPipeline = Promise.resolve();

  function BigEvent(eventData) {
    var isAfterCondition = null,
      isBeforeCondition = null,
      composeOptions = null,
      onWaitTimeout = null,
      deferred = false,
      waitFor,
      timeoutTimer = null;

    for (var prop in eventData) {
      this[prop] = eventData[prop];
    }

    /**
     * Retrasa la ejecución de un evento hasta la llegada de otro, y sintetiza un nuevo evento a partir de ambos.
     **
     * @param {Object} options - Opciones
     * @param {Function} options.after - Función que compara dos eventos. Configura el evento para ejecutarse después de la llegada de otor.  Obligatorio
     * @param {Function} options.before - Función que compara dos eventos. Obligatorio.
     * @param {Function} options.onWaitTimeout - Callback de tratamiento pasado el tiempo máximo de espera. Permite modificar el evento original de forma previa a l ainvocación del handler. Por defecto, se invoca el handler del evento original sin tratar.
     * @param {Function} options.waitFor - Tiempo máximo de espera para generar el nuevo evento, en milisegundos
     */
    this.defer = function(options) {
      var that = this;

      if (typeof options.after === 'function') {
        logger.log(logger.LOG_TYPE.EVENT_DEFERRAL, 'Defer event after "' + this.name + '"');
        isAfterCondition = options.after;
        deferred = true;
        waitFor = options.waitTime || MAX_WAIT_TIME;
        afterEvents.push(this);
      }

      if (typeof options.before === 'function') {
        logger.log(logger.LOG_TYPE.EVENT_DEFERRAL, 'Defer event before "' + this.name + '"');
        isBeforeCondition = options.before;
        deferred = true;
        waitFor = options.waitTime || MAX_WAIT_TIME;
        beforeEvents.push(this);
      }

      if (typeof options.onWaitTimeout) {
        onWaitTimeout = options.onWaitTimeout;
      }

      if (deferred && waitFor > 0) {
        //timeoutTimer = scope.setTimeout( handleNonHandledEvent.bind(onWaitTimeout ? onWaitTimeout(this) : this), waitFor);
          timeoutTimer = scope.setTimeout(function() {
            beforeEvents = beforeEvents.filter(function(event) {
              return event !== that;
            });

            afterEvents = afterEvents.filter(function(event) {
              return event !== that;
            });

            handleEvent(onWaitTimeout? onWaitTimeout(that):that);
          }, waitFor);
      }
    };

    /**
     * Retrasa la ejecución de un evento hasta la llegada de otro, y sintetiza un nuevo evento a partir de ambos.
     **
     * @param {Object} options - Opciones
     * @param {Function} options.with - Función que compara dos eventos. Obligatorio
     * @param {Function} options.create - Función que recibidos dos eventos, devuelve uno nuevo. Obligatorio.
     * @param {Function} options.onWaitTimeout - Callback de tratamiento pasado el tiempo máximo de espera. Por defecto, se invoca el handler del evento original sin tratar.
     * @param {Function} options.waitFor - Tiempo máximo de espera para generar el nuevo evento, en milisegundos
     */
    this.compose = function(options) {
      var that = this;

      if (typeof options.with === 'function' && typeof options.create === 'function') {
        logger.log(logger.LOG_TYPE.EVENT_COMPOSAL, 'Event "' + this.name + '" waiting for compose');
        composeOptions = options;
        compoundEvents.push(this);
        waitFor = options.waitTime || MAX_WAIT_TIME;

        if (typeof options.onWaitTimeout) {
          onWaitTimeout = options.onWaitTimeout;
        }

        if (waitFor > 0) {
          timeoutTimer = scope.setTimeout(function() {
            handleNonHandledEvent(onWaitTimeout ? onWaitTimeout(that) : that);
            compoundEvents = compoundEvents.filter(function(event) {
              return event !== that;
            });
          }, waitFor);
        }
      }
    };

    this.isComposingWith = function(event) {
      return composeOptions && composeOptions.with ? composeOptions.with(this, event) : false;
    };

    this.createWith = function(event) {
      var composed;

      logger.log(logger.LOG_TYPE.EVENT_COMPOSAL, 'Composing events "' + this.name + '" and "' + event.name + '"');

      if (composeOptions && composeOptions.create) {
        composed = composeOptions.create(this, event) || [event];
      }

      if (composed.length && composed.splice) {
        composed.forEach(function(event, index) { // Cambio amartinez 03/01/2018
          if (!(event instanceof BigEvent)) {
            composed[index] = new BigEvent(event);
          }
        });
      } else {
        return composed instanceof BigEvent ? [composed] : [new BigEvent(composed)];
      }

      return composed;
    };

    this.isAfter = function(event) {
      return isAfterCondition ? isAfterCondition(this, event) : true;
    };

    this.isBefore = function(event) {
      return isBeforeCondition ? isBeforeCondition(this, event) : true;
    };

    this.clear = function() {
      scope.clearInterval(timeoutTimer);
    }

    this.isDeferred = function() {
      return deferred || false;
    };

    this.isComposed = function() {
      return composeOptions !== null;
    };
  }

  function handleMessage(message) {
    var event = new BigEvent(message.data);
    logger.log(logger.LOG_TYPE.EVENT_DATA, event);

    composeEvent(event).forEach(function(event) {
      handleBeforeEvents(event);
      handleEvent(event);
      handleAfterEvents(event);
    });
  }

  function handleEvent(event) {
    eventHandlingPipeline = eventHandlingPipeline.then(function() {
      var handlerReturnValue = null;

      if (_handlers[event.name]) {
        handlerReturnValue = _handlers[event.name](event);
      } else {
        logger.log(logger.LOG_TYPE.ERROR, 'Event "' + event.name + '" has no handler registered');
      }

      return handlerReturnValue;
    }).catch(function(error) {
      logger.log(logger.LOG_TYPE.ERROR, 'An error happened while handling event "' + event.name + '". ', JSON.stringify(error));
    });
  }

  function composeEvent(event) {
    var compoundEventList = [event],
      compoundEventsIterator = compoundEvents.length;

    while (compoundEventsIterator--) {
      if (event !== compoundEvents[compoundEventsIterator] && compoundEvents[compoundEventsIterator].isComposingWith(event)) {
        compoundEvents[compoundEventsIterator].clear();
        compoundEventList = compoundEvents.splice(compoundEventsIterator, 1)[0].createWith(event);
      }
    }

    return compoundEventList;
  }

  function handleNonHandledEvent(thisEvent) {
    beforeEvents = beforeEvents.filter(function(event) {
      return event !== thisEvent;
    });

    afterEvents = afterEvents.filter(function(event) {
      return event !== thisEvent;
    });

    handleEvent(thisEvent);
  }

  /**
   * Gestiona los eventos retrasados para su gestión anterior a la llegada de otro evento
   **
   * @author jmartinezpisson
   * @date 21/12/2017
   * @param {Object} event - Evento CometD esperado
   */
  function handleBeforeEvents(event) {
    var beforeEventsIterator = beforeEvents.length;

    while (beforeEventsIterator--) {
      if (event !== beforeEvents[beforeEventsIterator] && beforeEvents[beforeEventsIterator].isBefore(event)) {
        beforeEvents[beforeEventsIterator].clear();
        handleEvent(beforeEvents.splice(beforeEventsIterator, 1)[0]);
      }
    }
  }

  /**
   * Gestiona los eventos retrasados para su gestión posterior a la llegada de otro evento
   **
   * @author jmartinezpisson
   * @date 21/12/2017
   * @param {Object} event - Evento CometD esperado
   */
  function handleAfterEvents(event) {
    var afterEventsIterator = afterEvents.length;

    while (afterEventsIterator--) {
      if (event !== afterEvents[afterEventsIterator] && afterEvents[afterEventsIterator].isAfter(event)) {
        afterEvents[afterEventsIterator].clear();
        handleEvent(afterEvents.splice(afterEventsIterator, 1)[0]);
      }
    }
  }

  /**
   * Gestiona el estado de la conexión al servidor Bayeux
   **
   * @author jmartinezpisson
   * @date 24/09/2017
   * @change 04/10/2017 jmartienzpisson Cambiada la gestión de reintentos para hacerla más robusta
   */
  function _metaConnect(message) {

    logger.log(logger.LOG_TYPE.METACONNECT, 'ID: ' + message.id + ' - Date: ' + new Date().toJSON());

    // 1 - Si CometD, se encuentra desconectado, se obvia el LongPolling. Para gestionar una desconexión completa, se usa el canal metadisconnect
    if ($cometd.isDisconnected()) {
      logger.log(logger.LOG_TYPE.METACONNECT, 'LongPolling obviado por desconexión de CometD');
      return;
    }

    // 2 - Se almacena el estado anterior de conexión y se verifica si la conexión es correcta
    _state.wasConnected = _state.connected;
    _state.connected = (message.successful === true);

    // 3 -Se actua en caso de (re)conexión, desconexión parcial (gestionada automáticamente por CometD)
    // y reintentos fallidos
    // 3.1 - Si se ha producido una conexión
    if (!_state.wasConnected && _state.connected) {
      logger.log(logger.LOG_TYPE.METACONNECT, 'Conexión establecida', message);
      _handlers.onConnectionEstablished(_state.retries);
      _state.retries = 0;

      // 3.2 - Si se ha producido una desconexión
    } else if (_state.wasConnected && !_state.connected) {
      logger.log(logger.LOG_TYPE.METACONNECT, 'Conexión rota', message);
      _handlers.onConnectionBroken();
      // 3.3 - Si se ha producido un reintento
    } else if (!_state.wasConnected && !_state.connected) {
      logger.log(logger.LOG_TYPE.METACONNECT, 'Intento de reconexión erróneo', message);
      _state.retries++;

      // 3.4 - Se realiza un reintento hasta el máximo de reintentos configurados
      if (_state.retries < MAX_RETRIES) {
        _handlers.onConnectionRetry(_state.retries);
      } else {
        // 3.5 - Si se supera el máximo de reintentos, y existe posibilidad de roundRobin, se realiza un reset de la conexión BIG, hasta llegar a 2 veces el número de reintentos
        if(_state.endpoints.length > 1) {
          reconnect();
        }
      }
    }
  }

  function _metaDisconnect(message) {
    logger.log(logger.LOG_TYPE.METACONNECT, 'Desconexión', message);

    // Independientemente de si la desconexión se produce en servidor, la libería CometD borra su estado interno, por lo que se considera una desconexión
    _state.connected = false;
    _state.wasConnected = false;
    _state.retries = 0;

    // Si se permite un handshake manual, se trata de una desconexión manual, y se lanza el handler
    if(_state.allowManualHandshake) {
      _handlers.onConnectionClosed();
    }
  }

  /**
   * BIG REST
   **/

  // <!--[if gte IE 9]><!-->
  $.ajaxSetup({
    cache: false
  });
  // <!--<![endif]-->

  //Funciones de OAuth2
  function getToken() {
    return new Promise(function(resolve, reject) {
      logger.log(logger.LOG_TYPE.TOKEN, 'Petición para recuperar token (getToken)');

      getOAuthCredentials().then(function(oAuthCredentials) {
        var credentials = Object.assign({
          grant_type: 'password'
        }, oAuthCredentials);

        $.ajax({
          url: _state.endpoint + "/api/token",
          type: "POST",
          dataType: "json",
          data: credentials,
          success: function(json) {
            ACCESS_TOKEN = json.access_token;
            EXPIRES_IN = json.expires_in;
            logger.log(logger.LOG_TYPE.TOKEN, 'Token recuperado. Token:', ACCESS_TOKEN, 'Expira en (s):', EXPIRES_IN);
            window.setTimeout(function() {
              refreshToken();
            }, EXPIRES_IN * 1000);

            resolve();
          },
          error: function(xhr, status, error) {
            logger.log(logger.LOG_TYPE.ERROR, 'Error al recuperar el token de OAuth.', status, xhr, error);
            reject(error);
          },
        });
      })
    });
  }

  function refreshToken() {
    return new Promise(function(resolve, reject) {
      logger.log(logger.LOG_TYPE.TOKEN, 'Petición para refrescar el token (refreshToken)');

      if (ACCESS_TOKEN) {

        getOAuthCredentials().then(function(oAuthCredentials) {
          var credentials = Object.assign({
            grant_type: 'refresh_token',
            refresh_token: ACCESS_TOKEN
          }, oAuthCredentials);

          $.ajax({
            url: _state.endpoint + "/api/token",
            type: "POST",
            dataType: "json",
            headers: {
              'Cache-Control': 'no-cache, no-store, max-age=0, must-revalidate',
              'Pragma': 'no-cache'
            },
            data: credentials,
            success: function(json) {
              ACCESS_TOKEN = json.access_token;
              EXPIRES_IN = json.expires_in;
              logger.log(logger.LOG_TYPE.TOKEN, 'Token refrescado. Token:', ACCESS_TOKEN, 'Expira en (s):', EXPIRES_IN);
              window.setTimeout(function() {
                refreshToken();
              }, EXPIRES_IN * 1000);

              resolve();
            },
            error: function(xhr, status, error) {
              logger.log(logger.LOG_TYPE.ERROR, 'Error al refrescar el token de OAuth', status, xhr, error);
              reject(error);
            },
          });
        });
      }
    });
  }

  //Funcion que devuelve una promesa con las credenciales del oAuth
  function getOAuthCredentials() {
    return new Promise(function(resolve, reject) {
      //Se simula que se obtienen las credenciales.
      //Esto HAY QUE MODIFICARLO PARA OBTENERLAS DE FUERA?
      var obj = {
        username: '',
        password: '',
        client_secret: '',
        client_id: ''
      }
      resolve(obj);
    });
  }

  // Name. def.name
  // ReturnValue: def.returnValueAttribute
  // Error: def.errorAttribute
  // useCredentials: true/false
  // useAccessToken: true/false
  function promisify(def) {
    return function(args, keepHyphens) {
      // 0 - Tratamiento parámetros
      args = args || {};

      if (def.useCredentials !== false) {
        args = Object.assign(args, _state.auth);
      }

      if (def.useAccessToken !== false) {
        args.access_token = ACCESS_TOKEN;
      }

      // 1 - Debug
      logger.log(logger.LOG_TYPE.REST_PETITION, 'Petición de "' + def.name + '"');
      logger.log(logger.LOG_TYPE.REST_PETITION_DATA, '"' + def.name + '"', args);

      // 2 - Llamada
      return new Promise(function(resolve, reject) {
        $.ajax({
          url: _state.restService + '/' + def.name,
          type: 'GET',
          async: false,
          contentType: "application/json",
          dataType: 'jsonp',
          headers: {
            'Cache-Control': 'no-cache, no-store, max-age=0, must-revalidate',
            'Pragma': 'no-cache'
          },
          data: formatParams(args),
          error: function(xhr, status, error) {
            logger.log(logger.LOG_TYPE.ERROR, 'Desconexión en petición REST "' + def.name + '"', status, xhr, error);
            reject(error);
          },
          success: function(json) {
            logger.log(logger.LOG_TYPE.REST_RESPONSE_DATA, '"' + def.name + '"', json);
            if (json.response === 'OK') {
              logger.log(logger.LOG_TYPE.REST_RESPONSE, 'Respuesta OK a REST "' + def.name + '"');

              if (!keepHyphens) {
                json = _keysToCamelCase(json);
              }

              if (typeof(def.returnValue) === 'function') {
                resolve(def.returnValue(json));
              } else {
                resolve(def.returnValue ?
                  json[def.returnValue] :
                  true
                );
              }

            } else {
              var error;

              if (def.errorAttribute) {
                error = json[def.errorAttribute];
              } else {
                error = json.failureDescription || json.failuredescription || json.failureCode;
              }

              logger.log(logger.LOG_TYPE.REST_RESPONSE, 'Respuesta KO a REST "' + def.name + '"', error);
              logger.log(logger.LOG_TYPE.ERROR, '(?) Posible error en petición REST previa');
              reject(error);
            }
          }
        });
      });
    }
  }

  function formatParams(args) {
    var params = [];

    for (var key in args) {
      if (args[key] || args[key] === '') {
        params.push(key + '=' + args[key]);
      }
    }

    return params.join('&');
  }

  var restDefinitions = {
    login: promisify({
      name: 'login',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        return response;
      }
    }),
    logout: promisify({
      name: 'logout',
      useCredentials: true,
      useAccessToken: true
    }),
    extension: promisify({
      name: 'extension',
      useCredentials: true,
      useAccessToken: true
    }),
    getStatusCalls: promisify({
      name: 'getstatuscalls',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        return {
          extension: _state.auth.extension,
          calls: response.calls
        }
      }
    }),
    //para conocer estado del agente que está usando extensión.
    getState: promisify({
      name: 'getstate',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        return {
          state: response.state,
          workMode: response.workmode,
          reason: response.reason,
          pendingState: response.pendingstate,
          pendingReason: response.pendingreason
        };
      }
    }),
    /*para conocer estado de otro agente.
    NOTA.: Hace falta modificar promisify para que sobreescriba extensión.
    getExternalState: function(extension) {
      return promisify({
        name: 'getstate',
        useCredentials: true,
        useAccessToken: true,
        returnValue: function(response) {
          return {
            state: response.state
          };
        }
      })(extension);
    },
    */
    getSessionInfo: promisify({
      name: 'getsessioninfo',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        return {
          services: {
            campaigns: response.sessionInfoList.serviceInfoList
          },
          session: {
            agentName: response.sessionInfoList.agentName
          }
        }
      }
    }),
    getCustomButtons: promisify({
      name: 'getcustombuttons',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'custombuttons'
    }),
    executeCustomButton: promisify({
      name: 'executecustombutton',
      useCredentials: true,
      useAccessToken: true
    }),
    setReady: promisify({
      name: 'setready',
      useCredentials: true,
      useAccessToken: true
    }),
    setNotReady: promisify({
      name: 'setnotready',
      useCredentials: true,
      useAccessToken: true
    }),
    makeCall: promisify({
      name: 'makecall',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        if (response.hasOwnProperty('sessionid')) {
          return response.sessionid;
        } else {
          return response.cid;
        }
      }
    }),
    makeCallInSession: promisify({
      name: 'makecallinsession',
      useCredentials: true,
      useAccessToken: true
    }),
    consultationCall: promisify({
      name: 'consultation',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    blindTransferCall: promisify({
      name: 'blindtransfer',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    transferCall: promisify({
      name: 'transfer',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    conference: promisify({
      name: 'conference',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    answerCall: promisify({
      name: 'answer',
      useCredentials: true,
      useAccessToken: true
    }),
    answerCallAltitude: promisify({
      name: 'answercall',
      useCredentials: true,
      useAccessToken: true
    }),
    clearCall: promisify({
      name: 'clearcall',
      useCredentials: true,
      useAccessToken: true
    }),
    clearAllCalls: promisify({
      name: 'clearallcalls',
      useCredentials: true,
      useAccessToken: true
    }),
    clearConnection: promisify({
      name: 'clearconnection',
      useCredentials: true,
      useAccessToken: true
    }),
    retrieveCall: promisify({
      name: 'retrieve',
      useCredentials: true,
      useAccessToken: true
    }),
    holdCall: promisify({
      name: 'hold',
      useCredentials: true,
      useAccessToken: true
    }),
    sendDtmf: promisify({
      name: 'senddtmf',
      useCredentials: true,
      useAccessToken: true
    }),
    // Presence/Altitude
    site: promisify({
      name: 'site',
      useCredentials: true,
      useAccessToken: true
    }),
    getStatus: promisify({
      name: 'getstatus',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        return {
          campaigns: response.campaigns,
          status: response.status,
          sessions: response.sessions
        };
      }
    }),
    getQCode: promisify({
      name: 'getqcode',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'listqcode'
    }),
    setQCode: promisify({
      name: 'setqcode',
      useCredentials: true,
      useAccessToken: true
    }),
    startSession: promisify({
      name: 'startsession',
      useCredentials: true,
      useAccessToken: true
    }),
    stopSession: promisify({
      name: 'stopsession',
      useCredentials: true,
      useAccessToken: true
    }),
    getLogoutReasons: promisify({
      name: 'getLogoutCode',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'reasons'
    }),
    closeContact: promisify({
      name: 'closecontact',
      useCredentials: true,
      useAccessToken: true
    }),
    getCurrentOutboundContact: promisify({
      name: 'getCurrentOutboundContact',
      useCredentials: true,
      useAccessToken: true,
      returnValue: function(response) {
        delete response.response;

        return response;
      }
    }),
    getCallData: promisify({
      name: 'getcalldata ',
      useCredentials: true,
      useAccessToken: true
    }),
    rescheduleContact: promisify({
      name: 'reschedulecontact',
      useCredentials: true,
      useAccessToken: true
    }),
    getNotReadyCode: promisify({
      name: 'getNotReadyCode',
      useCredentials: true,
      useAccessToken: true
    }),
    makeContactCall: promisify({
      name: 'makecontactcall',
      useCredentials: true,
      useAccessToken: true
    }),
    requestOutboundACDCall: promisify({
      name: 'requestoutboundacdcall',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignOpen: promisify({
      name: 'campaignopen',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignClose: promisify({
      name: 'campaignclose',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignSignOn: promisify({
      name: 'campaignsignon',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignSignOff: promisify({
      name: 'campaignsignoff',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignReady: promisify({
      name: 'campaignready',
      useCredentials: true,
      useAccessToken: true
    }),
    campaignNotReady: promisify({
      name: 'campaignnotready',
      useCredentials: true,
      useAccessToken: true
    }),
    abortDataTransaction: promisify({
      name: 'abortdatatransaction',
      useCredentials: true,
      useAccessToken: true
    }),
    endDataTransaction: promisify({
      name: 'enddatatransaction',
      useCredentials: true,
      useAccessToken: true
    }),
    discardDataTransaction: promisify({
      name: 'discarddatatransaction',
      useCredentials: true,
      useAccessToken: true
    }),
    consultationCallAltitude: promisify({
      name: 'consultcall',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    // Finesse
    getReasonsCodes: promisify({
      name: 'getreasonscodes',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'codes'
    }),
    getWrapupReasons: promisify({
      name: 'getwrapupreasons',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'reasons'
    }),
    setWrapup: promisify({
      name: 'setwrapup',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    getNotReadyReasons: promisify({
      name: 'getNotReadyCode',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'reasons'
    }),
    alternateCall: promisify({
      name: 'alternate',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'cid'
    }),
    //Recording Presence
    getRecordingSessionId: promisify({
      name: 'getrecordingsessionid',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'sessionid'
    }),
    startRecording: promisify({
      name: 'recordstart',
      useCredentials: true,
      useAccessToken: true,
      //returnValue: 'recordingState'?
    }),
    pauseRecording: promisify({
      name: 'recordpause',
      useCredentials: true,
      useAccessToken: true,
      //returnValue: 'recordingState'?
    }),
    stopRecording: promisify({
      name: 'recordstop',
      useCredentials: true,
      useAccessToken: true,
      //returnValue: 'recordingState'?
    }),
    //
    getExtensionForced: promisify({
      name: 'getextensionforced',
      useCredentials: true,
      useAccessToken: true,
      returnValue: 'forcedextension'
    }),
    getForcedExtension: function() {
      return new Promise(function(resolve, reject) {
        getToken().then(function() {
          restDefinitions.getExtensionForced().then(function(response) {
            resolve(response);
          }).catch(function(err) {
            reject(err);
          });
        }).catch(function(err) {
          reject(err);
        });
      });
    },
    // GENESYS
    getPlaces: function(data) {
      return getToken().then(function() {
        return promisify({
          name: 'loginGen',
          useCredentials: false,
          useAccessToken: true,
          returnValue: 'places'
        })(data);
      });
    },
    loginGenesys: promisify({
      name: 'loginPlaceGen',
      useCredentials: false,
      useAccessToken: true,
      returnValue: function(response) {
        return response;
      }
    }),
    // ASTERISK, POR FAVOR NO BORRAR
    monitorDevice: promisify({
      name: 'monitordevice',
      useCredentials: true,
      useAccessToken: true
    }),

    monitorStop: promisify({
      name: 'monitorstop',
      useCredentials: true,
      useAccessToken: true
    })
  };

  // Se expone las funciones públicas del módulo
  scope.thc = scope.thc || {};
  scope.thc.big = {
    init: init,
    start: start,
    update: updateAuth,
    stop: stop,
    addHook: addHook,
    removeHook: removeHook,
    rest: restDefinitions,
    registerExtension: function(extension) {
      extension({
        restDefinition: restDefinitions,
        handleMessage: handleMessage,
        bigHandlers: _handlers
      });
    }
  };
})(window, document, window.logger, window.jQuery);
