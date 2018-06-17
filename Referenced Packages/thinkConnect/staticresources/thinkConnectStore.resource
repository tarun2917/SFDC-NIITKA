/**
 * Clase Store de thinkConnect
 **
 * @author jmartinezpisson
 **/
(function(scope, logger, util) {

  /**
   * Listener de cambios en el estado del store
   **
   * @author jmartinezpisson
   */
  function onStoreUpdate(onChangeListeners, state) {
    onChangeListeners.forEach(function(listener) {
      if (typeof listener === 'function') {
        listener(state);
      }
    });
  }

  /**
   * Reducer estándar del store
   **
   * @author jmartinezpisson
   */
  function reduceState(state, changes) {
    var newState = {},
      newValue,
      oldValue;

    for (var prop in changes) {
      if (state.hasOwnProperty(prop)) {
        oldValue = state[prop];
        newValue = changes[prop];

        if (oldValue && typeof(oldValue) === 'object') {
          if (newValue.getMonth && newValue.getTime) {
            newState[prop] = newValue;
          } else {
            newState[prop] = newValue.push && newValue.slice ? newValue : reduceState(oldValue, newValue);
          }
        } else {
          newState[prop] = newValue;
        }
      }
    }

    return Object.assign(state, changes, newState);
  }

  /**
   * Clase Store
   **
   * @author jmartinezpisson
   */
  function Store(initialState, onChangeListener) {
    var state = initialState || {},
      oldState = {},
      onChangeListeners = onChangeListener ? [onChangeListener] : [],
      reduceFinishedPromise = Promise.resolve(state);

    logger.log(logger.LOG_TYPE.STATE, state);

    this.reduceStore = function(reducer, legacyCustomReducer) {
      return new Promise(function(resolve, reject) {
        // 1 - Concatenamos la ejecución del reduce al último realizado
        reduceFinishedPromise = reduceFinishedPromise.then(function(state) {
          var reducedState, timeout;

          oldState = util.object.clone(state);

          if (typeof reducer === 'function') {
            reducedState = reducer(state);
          } else {
            reducedState = legacyCustomReducer ? legacyCustomReducer(state, reducer) : reduceState(state, reducer);
          }

          if (!reducedState) {
            logger.log(logger.LOG_TYPE.ERROR, 'Error using custom reducers, store invalid.', reducedState);
            return oldState;
          }

          return reducedState;
        }).catch(function(err) {
          logger.log(logger.LOG_TYPE.ERROR, 'Error when updating with reducers: ' + err);
          state = oldState;
          reject(err);

          return state;
        // 2 - Actualizamos el estado el store al nuevo y lanzamos el evento de estado cambiado
        }).then(function(reducedState) {
          state = reducedState;

          logger.log(logger.LOG_TYPE.DELTA_STATE, oldState, state);

          try {
            onStoreUpdate(onChangeListeners, state);
          } catch(err) {
            reject(err);
          }
          resolve();

          return state;
          // 3 - En caso de error, se devuelve el nuevo estado y se rechaza la promesa
        }).catch(function(err) {
          logger.log(logger.LOG_TYPE.ERROR, 'Error after updating store on onStoreUpdate listeners: ' + err);
          state = oldState;
          reject(err);

          return state;
        });
      });
    }

    this.restoreState = function() {
      state = oldState;
      onStoreUpdate(onChangeListeners, state);
    }

    this.getState = function() {
      return util.object.clone(state);
    }

    this.clearState = function() {
      state = {};
      onStoreUpdate(onChangeListeners, state);
    }

  }

  scope.Store = Store;
})(window.thc, window.logger, window.thc.util);
