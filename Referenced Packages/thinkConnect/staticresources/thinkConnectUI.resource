(function (scope, util) {
	'use strict';

	var components = {},
		isInit = false;


	function checkForUpdate(props, oldProps) {
		/*for(var key in props) {
			if((props.hasOwnProperty(key) && !oldProps.hasOwnProperty(key))
				|| props[key] !== oldProps[key]) {
				return true;
			}
		}

		return false;*/
		return !util.object.is(props, oldProps);
	}

	// Exports
	scope.ui = {
		Component: 	function (init) {
			var props = init.props || {},
					oldProps = {},
					dirty = true,
					doInit = true;

			this.mapToProps = function(state) {

				init.mapToProps(props, state);

				if(checkForUpdate(props, oldProps)) {
					dirty = true;
					oldProps = util.object.clone(props);
				}
			}

			this.init = function() {
				if(doInit) {
					if(init.init) {
						init.init(props);
					}

					doInit = false;
					oldProps = util.object.clone(props);
				}
			}

			this.render = function() {
				init.render(props);
				dirty = false;
			}

			this.isDirty = function() {
				return dirty;
			}

			this.actions = init.actions || {};
		},
		registerComponent: function(name, component) {
			components[name] = component;

			return component;
		},
		render: function() {
			if(isInit) {
				for(var name in components) {
					if(components.hasOwnProperty(name) && components[name] && components[name].render && components[name].isDirty()) {
						components[name].render();
					}
				}

				thc.sforce.setSoftphoneHeight({heightPX: document.body.querySelector('div').clientHeight}).catch(function(errors) {});
			}
		},
		onStoreUpdate: function(state) {
			for(var name in components) {
				if(components.hasOwnProperty(name) && components[name] && components[name].mapToProps) {
					components[name].mapToProps(state);
				}
			}

			this.render();
		},
		init: function() {
			for(var name in components) {
				if(components.hasOwnProperty(name) && components[name] && components[name].mapToProps) {
					components[name].init();
					components[name].render();
				}
			}

			isInit = true;
		},
		util: {
			show: function(domElement) {
				domElement.classList.remove('slds-hide');
			},
			hide: function(domElement) {
				domElement.classList.add('slds-hide');
			},
			empty: function(domElement) {
				if(!domElement) {
					return;
				}

				while(domElement.firstChild) {
				    domElement.removeChild(domElement.firstChild);
				}
			},
			text: function(domElement, text) {
				domElement.innerText = text;
			},
			overflow: function(domElement) {
				var maxHeight = 0;

				if(domElement) {
					maxHeight = document.body.clientHeight - domElement.parentElement.getBoundingClientRect().y;

					domElement.parentNode.style.maxHeight = maxHeight + 'px';
					domElement.style.overflowY = 'scroll';
				}
			},
			getDatasetValue: function(domElement, key, parentElement) {
				var value, target;

				do {
					target = target? target.parentNode:domElement;
					value = target.dataset[key];

				} while(typeof(value) === 'undefined' && parentElement !== target);

				return value;
			},
			disable: function(domElement) {
				domElement.disabled = true;
			},
			enable: function(domElement) {
				domElement.disabled = false;
			}
		}
	};

})(window.thc, window.thc.util);
