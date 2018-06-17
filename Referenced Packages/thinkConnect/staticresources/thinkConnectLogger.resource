(function (scope, jsondiffpatch, JSZip, saveAs) {
	"use strict";

	var LOCAL_STORAGE_LOG_KEY = '_thinkConnect_log';

	// Deprecate: Viejo logger!
	Logger.useDefaults();
	var defaultLogger = Logger.get('Default');
	var loggerState = Logger.get('New State');
	var loggerMetaConnect = Logger.get('MetaConnect');
	var loggerBigRequest = Logger.get('Big Request');
	loggerState.setLevel(Logger.INFO); //por defecto se muestra el estado
	scope.console.logger = {
		log: function (msg) {
			defaultLogger.debug(msg);
		},
		info: function (msg) {
			defaultLogger.info(msg);
		},
		warn: function (msg) {
			defaultLogger.warn(msg);
		},
		error: function (msg) {
			defaultLogger.error(msg);
		},
		showState: function(){
			loggerState.setLevel(Logger.INFO);
		},
		hideState: function(){
			loggerState.setLevel(Logger.WARN);
		},
		logState: function(msg){
			loggerState.info(msg);
		},
		showMetaConnect : function(){
			loggerMetaConnect.setLevel(Logger.INFO);
		},
		hideMetaConnect : function(){
			loggerMetaConnect.setLevel(Logger.WARN);
		},
		logMetaConnect: function(msg){
			loggerMetaConnect.info(msg);
		},
		showBigRequest : function(){
			loggerBigRequest.setLevel(Logger.INFO);
		},
		hideBigRequest : function(){
			loggerBigRequest.setLevel(Logger.WARN);
		},
		logBigRequest: function(msg){
			loggerBigRequest.info(msg);
		}
	};

	// Nuevo logger-man
	var isDebug = false;

	// Último estado logueado
	var newState;

	var MAX_LOG_SIZE = 10000;
	var MAX_LOG_OVERFLOW = 1000;

	var masterLog = [];

	var LOG_TYPE = {
		ERROR: '0',
		ERROR_STACKTRACE: '0S',
		STATE: 'S-F',
		DELTA_STATE: 'S-D',
		COMETD: 'C',
		METACONNECT: 'M',
		EVENT: 'E',
		EVENT_DATA: 'E-F',
		EVENT_DEFERRAL: 'E-D',
		EVENT_COMPOSAL: 'E-C',
		REST_PETITION: 'RP',
		REST_PETITION_DATA: 'RP-F',
		REST_RESPONSE: 'RR',
		REST_RESPONSE_DATA: 'RR-F',
		SFORCE: 'SF',
		SFORCE_REQUEST: 'SF-RQ',
		SFORCE_REQUEST_DATA: 'SF-RQ-F',
		SFORCE_RESPONSE: 'SF-RE',
		SFORCE_RESPONSE_DATA: 'SF-RE-F',
		SFORCE_LISTENING: 'SF-L',
		SFORCE_LISTENER_EVENT: 'SF-LE',
		SFORCE_LISTENER_EVENT_DATA: 'SF-LE-D',
		TOKEN: 'T',
		PHONE_FORMAT: 'PF',
		CUSTOM: '\\(^w^)/',
		METALOG: 'ML'
	};

	var logTypeToText = {
		[LOG_TYPE.ERROR]: 'Error',
		[LOG_TYPE.ERROR_STACKTRACE]: 'ETrace',
		[LOG_TYPE.STATE]: 'State',
		[LOG_TYPE.DELTA_STATE]: 'ΔState',
		[LOG_TYPE.COMETD]: 'CometD',
		[LOG_TYPE.METACONNECT]: 'MetaConnect',
		[LOG_TYPE.EVENT]: 'Event',
		[LOG_TYPE.EVENT_DATA]: 'EvData',
		[LOG_TYPE.EVENT_DEFERRAL]: 'EvDeferral',
		[LOG_TYPE.EVENT_COMPOSAL]: 'EvComposal',
		[LOG_TYPE.REST_PETITION]: 'Rest > Send',
		[LOG_TYPE.REST_PETITION_DATA]: 'RestD> Send',
		[LOG_TYPE.REST_RESPONSE]: 'Rest < Receive',
		[LOG_TYPE.REST_RESPONSE_DATA]: 'RestD< Receive',
		[LOG_TYPE.SFORCE]: 'SForce',
		[LOG_TYPE.SFORCE_REQUEST]: 'Sf  >',
		[LOG_TYPE.SFORCE_REQUEST_DATA]: 'SfD >',
		[LOG_TYPE.SFORCE_RESPONSE]: 'Sf  <',
		[LOG_TYPE.SFORCE_RESPONSE_DATA]: 'SfD <',
		[LOG_TYPE.SFORCE_LISTENING]: 'SFLstn',
		[LOG_TYPE.SFORCE_LISTENER_EVENT]: 'SFEvn',
		[LOG_TYPE.SFORCE_LISTENER_EVENT_DATA]: 'SFEvnD',
		[LOG_TYPE.TOKEN]: 'Token',
		[LOG_TYPE.PHONE_FORMAT]: 'PhoneFormat',
		[LOG_TYPE.CUSTOM]: 'Custom',
		[LOG_TYPE.METALOG]: 'LogStr'
	};

	scope.logger = {
		log: log,
		LOG_TYPE: LOG_TYPE,
		LOG_TYPE_LABEL: logTypeToText,
		showLog: showLog
	};

	function log() {
		var logType = arguments[0];
		var message = '';

		// Si es un log de tipo delta estado, calculamos la diferencia de los dos ultimos y cambiamos... los argumentos?
		if (logType === LOG_TYPE.DELTA_STATE && arguments.length > 2) {
			var oldState = arguments[arguments.length - 2];
			newState = arguments[arguments.length - 1];
			var deltaState = jsondiffpatch.diff(oldState, newState);
			if (!deltaState) {
				return;
			}
			arguments[arguments.length - 2] = deltaState;
			delete arguments[arguments.length - 1];
			arguments.length -= 1;
		}

		// Si es un log de tipo estado, también lo guardamos
		if (logType === LOG_TYPE.STATE) {
			newState = arguments[1];
		}

		// Concatenamos el mensaje para guardar en el log
		for (var i = 1; i < arguments.length; i++) {
			if (typeof arguments[i] === 'string' || typeof arguments[i] === 'number') {
				message += arguments[i];
			} else {
				message += JSON.stringify(arguments[i]);
			}
		}

		// Guardamos un nuevo objeto de log
		var date = new Date();
		var obj = {
			type: logType,
			time: date,
			msg: message
		};
		masterLog.push(obj);

		// Si estamos en un entorno de desarrollo lo imprimimos por la consola (respetando los objetos!)
		if (isDebug) {
			var logArgs = [logToString(obj, true)];
			for (var i = 1; i < arguments.length; i++) {
				logArgs.push(arguments[i]);
			}

			// Los delta-estados no se imprimen al log, sino los state normales :)
			if (logType === LOG_TYPE.DELTA_STATE) {
				console.log.apply(this, [logToString(Object.assign({}, obj, { 
					type: LOG_TYPE.STATE 
				}), true), newState]);
			} else {
				console.log.apply(this, logArgs);
			}
		}

		// Si es un log de error, usamos una traza (desgraciadamente por ahora solo imprime 5 inútiles líneas)
		if (logType === LOG_TYPE.ERROR) {
			masterLog.push({
				type: LOG_TYPE.ERROR_STACKTRACE,
				time: date,
				msg: (new Error).stack
			});
			if (isDebug) {
				var st = logToString(obj, true) + 'Stacktrace';
				console.error(st);
			}
		}

		// Limitemos el log a, POR EJEMPLO, 100k registros
		if (masterLog.length > (MAX_LOG_SIZE + MAX_LOG_OVERFLOW)) {
			masterLog.splice(0, MAX_LOG_OVERFLOW);
		}
	};

	function logToString(log, customPrint) {
		if (log.constructor === Array) {
			return log.map(function (el) { return logToString(el); });
		}
		return '[' + log.time.toISOString().replace('T', ' ') + '] [' + (logTypeToText[log.type] + Array(6).join(' ')).substring(0, 6) + '] ' + (!customPrint? log.msg: '');
	}

	function showLog() {
		// Vamos a agregar el estado actual y no sé ni como, veamos...
		log(LOG_TYPE.STATE, newState);

		var timestamp = new Date().toISOString().replace('T', ' ');

		var logWindow = window.open('', 'log', 'height=800,width=600');
		var logStyle = 
			'html { font-family: monospace; } ' +
			'h2 { display: inline-block; } ' +
			'.log-button { margin-left: 10px; } ' +
			'.specs { background-color: lightblue; } ' + 
			'.log { background-color: pink; } ' + 
			'div { padding: 10px; white-space: nowrap; overflow: hidden; } ' +
			'div p { margin: 0; } ';

		var head = logWindow.document.head;
		var body = logWindow.document.body;

		head.innerHTML = '';
		body.innerHTML = '';

		var title = logWindow.document.createElement('title');
		title.innerText = 'thinkConnect log - ' + timestamp;
		head.appendChild(title);

		var style = logWindow.document.createElement('style');
		style.type = 'text/css';
		if (style.styleSheet){
			style.styleSheet.cssText = logStyle;
		} else {
			style.appendChild(document.createTextNode(logStyle));
		}
		head.appendChild(style);

		var mainTitle = logWindow.document.createElement('h2');
		mainTitle.innerText = 'thinkConnect log - ' + timestamp;
		body.appendChild(mainTitle);

		var copyButton = logWindow.document.createElement('button');
		copyButton.classList.add('log-button');
		copyButton.innerText = '[ Copy all ]';
		copyButton.addEventListener('click', function () {
			logWindow.document.querySelector('#text-copy').select();
			logWindow.document.execCommand('copy');
			logWindow.alert('Log copied to clipboard');
		});
		body.appendChild(copyButton);

		var downloadButton = logWindow.document.createElement('button');
		downloadButton.classList.add('log-button');
		downloadButton.innerText = '[ Download & close ]';
		downloadButton.addEventListener('click', function () {
			var zip = new JSZip();
			zip.file('log.txt', fullLog);
			zip.generateAsync({
				type : "blob",
				compression: "DEFLATE",
				compressionOptions: {
					level: 9
				}
			}).then(function (blob) {
				saveAs(blob, "log-tc-" + timestamp + '.zip');
			});
			logWindow.close();
		});
		body.appendChild(downloadButton);

		var divSpecs = logWindow.document.createElement('div');
		divSpecs.classList.add('specs');
		body.appendChild(divSpecs);

		var specs = {
			'Browser codename': navigator.appCodeName,
			'Browser name': navigator.appName,
			'Browser version': navigator.appVersion,
			'Cookies enabled': navigator.cookieEnabled,
			'Href': window.location.href,
			'Language': navigator.language,
			'Languages': navigator.languages.join(', '),
			'Platform': navigator.platform,
			'Screen size': window.screen.width + ' x ' + window.screen.height,
			'User agent': navigator.userAgent,
			'Vendor': navigator.vendor
		};

		for (var spec in specs) {
			var el = logWindow.document.createElement('p');
			var label = logWindow.document.createElement('b');
			label.innerText = spec + ': ';
			el.appendChild(label);
			var value = logWindow.document.createElement('span');
			value.innerText = specs[spec];
			el.appendChild(value);
			divSpecs.appendChild(el);
		}

		var divLog = logWindow.document.createElement('div');
		divLog.classList.add('log');
		divLog.innerText = logToString(masterLog).join('\n');
		body.appendChild(divLog);

		var fullLog = divSpecs.innerText + '\n' + '[LOG START]\n' + divLog.innerText;

		var textCopy = logWindow.document.createElement('textarea');
		textCopy.id = 'text-copy';
		textCopy.style.position = 'fixed';
		textCopy.style.top = 0;
		textCopy.style.left = 0;
		textCopy.style.width = '1px';
		textCopy.style.height = '1px';
		textCopy.style.padding = 0;
        textCopy.style.border = 'none';
        textCopy.style.outline = 'none';
        textCopy.style.boxShadow = 'none';
        textCopy.style.background = 'transparent';
		textCopy.value = fullLog;
		body.appendChild(textCopy);

		masterLog.splice(-1,1);
	}

	// Bindeamos el showLog al ALT+L
	window.addEventListener('keydown', function (key) {
		if (key.altKey && key.code === 'KeyL') {
			showLog();
		}
	});

	// Al descargar la página guardamos todo el masterLog
	window.addEventListener('unload', function () {
		log(LOG_TYPE.METALOG, 'Log guardado en el localStorage');
        localStorage.setItem(LOCAL_STORAGE_LOG_KEY, JSON.stringify(masterLog));
    });

    // Al cargar la página cargamos todo el masterLog de la memoria
    window.addEventListener('load', function () {
    	if (localStorage.getItem(LOCAL_STORAGE_LOG_KEY)) {
    		masterLog = JSON.parse(localStorage.getItem(LOCAL_STORAGE_LOG_KEY));
    		for (var l of masterLog) {
    			if (typeof l.time === 'string') {
    				l.time = new Date(l.time);
    			}
    		}
    		log(LOG_TYPE.METALOG, 'Log cargado del localStorage');
    		localStorage.removeItem(LOCAL_STORAGE_LOG_KEY);
    	}
    });

    // Además vamos a escuchar a los eventos de error
    window.addEventListener('error', function (ev) {
    	log(LOG_TYPE.ERROR, 'Error desconocido: ', ev.error? [ev.error.stack, ' at ' + ev.filename, ' at line no: ' + ev.lineno, ' at col no: ' + ev.colno].join('\n'): ev);
    });

})(window, window.jsondiffpatch, window.JSZip, window.saveAs);