(function (scope, document, sforce) {
	'use strict';

	var API_DEFINITIONS_KEY = 'apiDefinitions';

    var MESSAGE_FOR = {
    	SOFTPHONE: 'sp',
    	LIBRARY: 'lib'
    };

    var DEBUG_MODE = false;

	var _componentIdCount = 0;

	var apiDefinitions = {
        // blindTransferTo('9001')
        blindTransferTo: {
            name: 'blindTransferCall',
            args: [{ transferTo: '{!0}' }]
        },
        // consultationCallTo('9001')
        consultationCallTo: {
            name: 'consultationCall',
            args: [{ calledDevice: '{!0}' }]
        },
        // transfer()
        transfer: {
            name: 'transferCall'
        },
        // addCallResult('Finalizada con éxito'); addCallResult({'root': 108})
        addCallResult: {
            name: 'setCallResult'
        },
        // endCallResult()
        endCallResult: {
            name: 'updateTask'
        }
    }

    // Generamos un id unico para la libreria que solicita la llamada 
    function nextComponentId() {
    	return ('0000' + Math.floor(++_componentIdCount).toString(35)).slice(-4);
    }

    // Escuchamos para revisar los mensajes CTI que puedan llegar
	sforce.console.cti.onSendCTIMessage(function (result) {
		var message = JSON.parse(result.message);
		var data = message.data;
		var result;
		if (message.for === MESSAGE_FOR.SOFTPHONE && data.name !== undefined) {
			if (DEBUG_MODE) {
				console.log('[thinkConnect API listener] Receiving message ' + message.id + ' ...');
				console.log(data);
			}

			if (data.name === API_DEFINITIONS_KEY) {
				result = {
					internalId: nextComponentId(),
					actions: apiDefinitions
				}
			} else if (scope.thc && scope.thc.controller && scope.thc.controller.actions.hasOwnProperty(data.name)) {
				result = scope.thc.controller.actions[data.name].apply(this, data.args);
			} else {
				result = false;
			}

			var response = {
				id: message.id,
				data: result,
				for: MESSAGE_FOR.LIBRARY
			};

			if (DEBUG_MODE) {
				console.log('[thinkConnect API listener] Sending response ' + message.id + ' ...');
				console.log(response);
			}

			// Devolvemos el resultado en otro mensaje
			sforce.console.cti.sendCTIMessage(JSON.stringify(response));
		}
	});
	
})(window, document, window.sforce);