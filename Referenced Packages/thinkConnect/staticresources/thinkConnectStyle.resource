html, body {
	height: 100%;
}

.loginScreen {
	background-color: #1589ee;
}

#standbyPanel {
	/*height: 100%;*/
	max-width: 100%;
	padding: 5px 5px 0px 5px;
}

#outboundPanel {
	height: 100%;
	padding: 0px 5px 0px 5px;
}

#inboundPanel {
	height: 100%;
	padding: 10px;
	padding: 0px 5px 0px 5px;
	position: relative;
	z-index: 0;
}

#dialPanel {
	width: 160px;
	margin: 5px;
	margin-left: 10%;
	padding-bottom: 20px;
	min-height: 210px !important;
}

#outboundCallInfo {
	font-size: 0.90em;
}

#inboundCallInfo {
	font-size: 0.90em;
}

span.callRow {
	margin-bottom: 5px;
	font-family: Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
}

span.eventRow {
	margin-bottom: 5px;
	font-family: Helvetica, sans-serif;
	font-size: 11px;
}

.logoCompanyLogin {
	margin-top: 3px;
	max-height: 65px;
}

.logoCompany {
	margin-top: 3px;
	max-height: 18px;
}

.statusEvent {
	width: 200px;
	font-size: 10px;
	height: 150px;
	line-height: 19px;
	padding: 4px;
	border: 1px solid silver;
	overflow: auto;
	word-wrap: break-word;
	text-align: left;
}

h2 {
	font-size: 8px;
	font-weight: bold;
	margin: 0px;
	padding: 0px;
}

ul {
	list-style-type: none;
	display: inline;
}

.errorMessage {
    margin: auto;
    text-align: center;
	margin-top: 10px;
	color: white;
	font-family: Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	max-width: 200px;
}

.selector {
	background: rgba(0, 112, 210, 0.11);
	color: #585757;
	padding: 5px;
	margin: 0px 0px 5px 0px;
	font-size: 10px;
	line-height: 100%;
	border: 1px solid #C1C1C1;
	border-radius: 0;
	min-height: 27px;
}

.selectOption {
	padding: 5px;
}

.leftPanel {
	float: left;
}

.rightPanel {
	float: right;
}

.shadow {
	border-left: solid;
	border-color: #0CBCE9;
	border-width: 4px;
	font-weight: bold;
}

.shadow-dialing {
	border-left: solid;
	border-color: #CC9966;
	border-width: 4px;
	font-weight: bold;
}

.shadow-held {
	border-left: solid;
	border-color: #FFFF66;
	border-width: 4px;
	font-weight: bold;
}

.shadow-call {
	border-left: solid;
	border-color: #9FED94;
	border-width: 4px;
	font-weight: bold;
}

.dialing {
	background-color: #CC9966 !important;
	text-decoration: blink !important;
}

.onCall {
	background-color: #99FF66 !important;
}

.callHeld {
	background-color: #FFFF66 !important;
}

.holdTimer {
	color: red;
}

#resultPanel {
	padding: 10px;
	width: 85%;
	position: relative;
	z-index: 10;
	background: #f4f6f9;
	border: 1px solid #d8dde6;
	border-radius: 4px;
	margin-left: 7% !important;
}

/* Estilos nuevos */
.extensionHeader {
	z-index: -1;
	background-color: #1589ee;
	padding-top: 10px;
	width: 100%;
}

.stateSelect {
	margin-left: 10% !important;
	padding: 8px;
	width: 60% !important;
	font-size: 10px !important;
}

.transferLineSelect {
	padding: 8px;
	width: 75% !important;
	font-size: 10px !important;
	max-height: 70px;
}

.agentInfoPanel {
	font-family: 'SalesforceSans-Regular',Helvetica,Arial,sans-serif;
	color: white;
	font-size: 10px;
	padding: 5px;
	width: 90%;
	margin-top: 5px;
}

.dial-pad {
	box-sizing: content-box;
	width: 100%;
}
/****** Estilos para los botones *********/
/*.slds .slds-button {
	font-size: 12px !important;
}*/

.task-button {
	margin-top: 10px !important;
}
/****** Estilos para los placeholders de los input *******/
input,
input::-webkit-input-placeholder {
	font-size: 12px !important;
	line-height: 20px !important;
}

	input:-ms-input-placeholder {
		font-size: 12px !important;
		line-height: 20px !important;
	}
/****** Estilos para la cabecera de estado de agente *****/
.logoutIcon {
	float: right;
	margin-right: 8px;
	margin-top: 8px;
}
/***** Estilos para el popup de transferencia ****/
.dropdown-transferencia {
	font-size: 10px !important;
	display: none;
}

.dropdown-transferencia-input {
	width: 90%;
	height: 150px;
}



/*.slds-icon-standard-call {
	background-color: #9FED94;
}

.slds-icon-task {
	background-color: #4bc076;
}*/


/******** Estilos para el nuevo dial pad *******/
.dig {
	color: #654F4F;
	font-size: 12px;
	float: left;
	background-color: #E3EFFA;
	text-align: center;
	width: 40px;
	height: 40px;
	border-radius: 100%;
	border: solid 1px;
	border-color: #C7E4FF;
	margin: 3px 5px 5px 3px;
	padding-top: 4px;
	font-weight: 700;
	cursor: pointer;
}

	.dig:active {
		-webkit-transform: scale(0.8, 0.8);
		opacity: 1.0;
	}

.sub-dig {
	font-size: 9px;
	font-weight: 300;
	position: relative;
	top: -2px;
}


/***********************************************/
/*.commentBar {
	margin-left: 6% !important;
	padding-top: 3px;
}

.comments {
	font-size: 9px;
	margin-right: 3%;
	border-radius: 10px;
	padding-left: 3px;
	padding-right: 3px;
	background-color: #0070D2 !important;
	color: white !important;
	text-decoration: none !important;
}*/
/*********************************************/


.callsTodayLabel {
	margin-left: 25px;
	font-size: 11px;
}

.callTaskList {
	display: none;
	margin-top: 5px;
	margin-left: 10px;
	margin-top: 10px;
	max-height: 180px;
	overflow-y: scroll;
}

.calls-inbound {
	background-color: #9FED94;
}

.calls-outbound {
	background-color: #E06059;
}

.versionLabel {
	font-size: 9px;
	color: white;
	text-align: right;
	margin-right: 3px;
	position: relative;
	right: 0px;
	bottom: 0px;
}

/*.slds-form-element__control {
	margin-top: 10px;
	font-size: 10px;
}*/

select::-ms-expand {
	display: none;
}

/*.slds .slds-notify--toast {
	margin: 0px !important;
	min-width: 0px !important;
	margin-left: 6px !important;
	width: 99% !important;
	padding: 5px 24px !important;
}*/

.softphoneDisabled {
	opacity: 0.5 !important;
	pointer-events: none;
}

.button-create
{
	width: 140px !important;
	margin-left: 10px !important;
	font-size: 12px !important;
	color: #3f7dd3 !important;
}

.create-options
{
	display: none;
	margin-top: -10px !important;
	margin-right: 26px !important;
	text-transform: none !important;
	letter-spacing: 0 !important;
}

.colapsedTitle
{
	padding-bottom: 8px !important;
}

/**** Modificaciones para Firefox ******/
@-moz-document url-prefix() {
	.slds-form-element__control {
		margin-bottom: 10px;
	}

	.stateSelect {
		height: 34px !important;
	}
}

.deshabilitado-color
{
    opacity: .25;
}
.iconos
{
    padding: .12rem;
    border-radius: 50%;
    border: 1px solid rgba(0, 0, 0, 0.4) !important;
}
.icons {
	text-decoration: none !important;
}
.campaignButtons
{
    height: 13.59px;
    width: 13.59px;
}

.hoverLine
{
    margin-left: 18px;
}
.eraseLine
{
    display: none;
}

.altitudeSelect
{
    max-width : 100px;
    margin-left : 15px !important;
}

#campaignSelector
{
    font-size: 70%;
    text-align: center;
}

#campaignDropdown
{
    max-height: 200px;
    text-align: center;
}

.centered
{
    text-align: center;
}

#schedule
{
    line-height: 2em;
}

#DTColumn
{
    display: none;
    text-align: center;
}

#rescheduleOptions2
{
    z-index: 1;
    !important;
}

#adapterIframeDiv
{
    overflow: hidden;
}

#scc_widget_SoftphoneIframe
{
    overflow: hidden;
}

body
{
    overflow: hidden;
    !important;
}

[class*="botonera"]
{
    padding-bottom: 3px;
    padding-top: 2px;
}

[class*="opcionesGrabacion"]
{
    display: none;
}

[id*="mainrecordbutton"]
{
    display: none;
}

.xdsoft_datetimepicker
{
    z-index: 1;
    !important;
}
.btnCall
{
    background-color: #66e854 !important;
}

.option-question-unchosen {
	background-color: lightcoral;
	border-bottom: 1px solid lightblue;
}
.option-question-chosen {
	background-color: lightgreen;
	border-bottom: 1px solid lightblue;
}
.call-result-breadcrumbs {
    white-space: nowrap;
    overflow-x: hidden;
}
.call-result-question {
	max-width: 100% !important;
    border: 1px solid #d8dde6;
    margin-bottom: 3px;
    font-weight: normal;
    border-radius: 5px;
    background-color: white;
    color: black;
    padding: 3px;
    cursor: pointer;
    display: none;
}
.agent-status {
	float: left;
    vertical-align: middle;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    position: absolute;
    left: calc(0% + 6px);
    border-width: 1px;
    border-style: solid;
}
.agent-status--active {
	background: linear-gradient(to bottom, rgba(179,245,79,1) 0%, rgba(105,217,0,1) 100%);
	border-color: rgba(0, 133, 0, 0.7);
}
.agent-status--inactive {
	background: linear-gradient(to bottom, rgba(245,81,81,1) 0%, rgba(217,0,18,1) 100%);
	border-color: rgba(133, 0, 0, 0.7);
}
.dropdown-transferencia-input {
	height: inherit !important;
	margin-bottom: 10px;
}
a {
	outline: none !important;
}

#softphone .wrapup-timer {
	position: absolute;
	left: 0;
	top: 0;
	background-color: green;
	padding: 0.25rem;
	color: #FFF;
	border-radius: 0 0 0.25rem 0;
	font-size: 0.75rem;
	transition: background-color 0.5s ease;
}


.wrapup-timer__container {
	border-style: solid;
	border-with: 0.25rem;
	border-color: green;
}

.wrapup-timer__container.wrapup-timer--warning {
	border-color: yellow;
}

.wrapup-timer__container.wrapup-timer--alert {
	border-color: red;
}

#softphone .wrapup-timer.wrapup-timer--warning {
	background-color: orange;
}

#softphone .wrapup-timer.wrapup-timer--alert {
	background-color: red;
}

@media (min-width:600px){
    .spBody {
        flex-direction: row !important;
}
