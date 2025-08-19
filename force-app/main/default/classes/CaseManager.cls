/**
 * example of exposing an apex class as a REST web service
 */
@SuppressWarnings('PMD.AvoidGlobalModifier,PMD.ExcessiveParameterList')
@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Case getByCaseId() {
        String caseId = getCaseIdFromURI(RestContext.request);

        // get sobject records as results
        Case result = [
            SELECT CaseNumber, Subject, Status, Origin, Priority
            FROM Case
            WHERE Id = :caseId
            WITH SYSTEM_MODE
        ];
        return result;
    }

    @HttpPost
    global static Id createCase(String subject, String status, String origin, String priority) {
        Case newCase = new Case(Subject = subject, Status = status, Origin = origin, Priority = priority);
        Database.insert(newCase, AccessLevel.SYSTEM_MODE);
        return newCase.Id;
    }

    @HttpDelete
    global static Boolean deleteCase() {
        String caseId = getCaseIdFromURI(RestContext.request);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId WITH SYSTEM_MODE];
        Database.DeleteResult result = Database.delete(
            thisCase,
            /* allOrNone - false so we get a save result if it fails*/ false,
            AccessLevel.SYSTEM_MODE
        );
        return result.isSuccess();
    }

    @HttpPut
    global static Id upsertCase(String subject, String status, String origin, String priority, String id) {
        Case thisCase = new Case(Id = id, Subject = subject, Status = status, Origin = origin, Priority = priority);
        Database.upsert(thisCase, AccessLevel.SYSTEM_MODE);
        return thisCase.Id;
    }

    @HttpPatch
    global static Id updateCaseFields() {
        String caseId = getCaseIdFromURI(RestContext.request);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId WITH SYSTEM_MODE];
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.request.requestBody.toString()
        );
        for (String fieldName : params.keySet()) {
            thisCase.put(fieldName, params.get(fieldName));
        }
        Database.update(thisCase, AccessLevel.SYSTEM_MODE);
        return thisCase.Id;
    }

    private static String getCaseIdFromURI(RestRequest request) {
        // identify parameters from client REST request
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        return caseId;
    }
}
