/**
 * Módulo base de thinkConnect, que incluye constantes y métodos estáticos de utilidad interna
 **
 * @author jmartinezpisson
 **/
(function(scope) {
  var thc = {};

  // Constantes
  thc.CALL_TYPE = {
    INBOUND: 'INBOUND',
    OUTBOUND: 'OUTBOUND'
  };

  thc.PARTY_TYPE = {
    NONE: 'none',
    CONSULT: 'consult',
    BLIND_TRANSFER: 'transfer',
    CONFERENCE: 'conference'
  };

  thc.TRANSACTION_TYPE = {
    CALL: 'call',
    SESSION: 'session'
  };

  thc.TRANSACTION_STATUS = {
    ACTIVE: 'active',
    CLEARED: 'cleared',
    PREVIEW: 'preview'
  };

  thc.KEY_CODES = {
    ESCAPE: 27,
    ENTER: 13
  };

  // Métodos estáticos de utilidad
  thc.util = {
    object: {
      /**
       * Itera a través de las propiedades enumerables de un objeto
       **
       * @author jmartinezpisson
       */
      forEach: function(obj, iterator) {
        for (var key in obj) {
          if (obj.hasOwnProperty(key)) {
            iterator(key, obj[key]);
          }
        }
      },
      /**
       * Clona un objeto POJ, incluyendo arrays y dates
       **
       * @author jmartinezpisson
       */
      clone: function(clonedObj) {
        var obj = {},
          value;

        for (var prop in clonedObj) {

          if (clonedObj.hasOwnProperty(prop)) {
            value = clonedObj[prop];

            if (value && typeof(value) === 'object') {
              if (value.getMonth && value.getTime) {
                obj[prop] = new Date(value.getTime());
              } else {
                obj[prop] = value.concat && value.slice ? [].concat(value) : this.clone(value);
              }
            } else {
              obj[prop] = value;
            }
          }
        }

        return obj;
      },
      /**
       * Realiza un comparación entre objetos tipo deepEqual.
       **
       * @author jmartinezpisson
       */
      is: function(obj1, obj2) {
        var areEqual = false;

        if (obj1 === obj2) {
          areEqual = true;
        } else if (obj1.getTime && obj2.getTime) {
          areEqual = obj1.getTime() && obj2.getTime();
        } else if (!obj1 || !obj2 || typeof obj1 != 'object' && typeof obj2 != 'object') {
          areEqual = obj1 == obj2;
        } else {
          areEqual = JSON.stringify(obj1) === JSON.stringify(obj2);
        }

        return areEqual;
      },
      /**
       * Verifica si un objeto se encuentra vacío
       **
       * @author jmartinezpisson
       */
      isEmpty: function(obj) {
        return Object.keys(obj).length === 0 && obj.constructor === Object;
      }
    }
  };

  scope.thc = thc;
})(window);
