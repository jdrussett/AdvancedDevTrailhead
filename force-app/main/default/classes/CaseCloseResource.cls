@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
  @HttpPost
  global static void closeCase(String closeReason) {
    RestRequest req = RestContext.request;
    List<String> uriComponents = req.requestURI.split('/');
    Id caseId = uriComponents[2];
    CaseService.closeCases(new Set<Id>{ caseId }, closeReason);
  }
}