/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SoftphoneController {
    global SoftphoneController() {

    }
    @RemoteAction
    global static thinkConnect.SoftphoneController.CTICredentials getCurrentUserCredentials() {
        return null;
    }
    @RemoteAction
    global static Boolean getDoNotCall(Id recordId) {
        return null;
    }
    @RemoteAction
    global static thinkConnect.SoftphoneController.OAuthCredentials getOAuthCredentials() {
        return null;
    }
    @RemoteAction
    global static List<String> getTaskRelatedTypes() {
        return null;
    }
    @RemoteAction
    global static List<Task> getTodayCalls() {
        return null;
    }
    @RemoteAction
    global static Map<String,Map<Id,SObject>> querySoftphoneRecordsById(List<Id> recordIds, Map<String,List<String>> fieldsToQueryBySObjectName) {
        return null;
    }
    @RemoteAction
    global static Map<String,Map<Id,SObject>> querySoftphoneRecords(Map<String,List<String>> fieldsToQueryBySObjectName, Map<String,Map<String,String>> clausesBySObjectName) {
        return null;
    }
    @RemoteAction
    global static Id saveCallTask(thinkConnect.SoftphoneController.Call call) {
        return null;
    }
    @RemoteAction
    global static Map<String,List<SObject>> searchAgenda(String searchString, List<String> sObjectsToSearch) {
        return null;
    }
global class CTICredentials {
}
global class Call {
    global Call() {

    }
}
global class OAuthCredentials {
}
}
