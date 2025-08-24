@IsTest
private with sharing class CaseManagerTest {
    private static final String URI = 'https://mindful-unicorn-6vazb3-dev-ed.trailblaze.my.salesforce.com/Cases/';
    private static final String REST_GET = 'GET';
    private static final String REST_POST = 'POST';
    private static final String REST_PUT = 'PUT';
    private static final String REST_PATCH = 'PATCH';
    private static final String REST_DELETE = 'DELETE';

    /**
     * tests @HttpGet
     */
    @isTest
    private static void testGetCaseById() {
        Id recordId = createTestRecord();

        /**
         * instantiate new rest request for testing purposes;
         * CaseManager.getByCaseId() references the RestContext
         */
        RestRequest request = new RestRequest();
        request.requestURI = URI + String.valueOf(recordId);
        request.httpMethod = REST_GET;
        RestContext.request = request;

        Case thisCase;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            thisCase = CaseManager.getByCaseId();
        }

        Assert.isNotNull(thisCase, 'test case should not be null');
        Assert.areEqual('Test Case', thisCase.Subject, 'test case subject does not match');
    }

    /**
     * tests @HttpPost
     */
    @isTest
    private static void testCreateCase() {
        Id recordId = CaseManager.createCase('Ferocious chipmunk', 'New', 'Phone', 'Low');

        Case thisCase;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            thisCase = [SELECT Id, Subject FROM Case WHERE Id = :recordId];
        }

        Assert.isNotNull(recordId, 'record was not properly created by CaseManager.createCase()');
        Assert.isNotNull(thisCase, 'case record should have been retrieved');
        Assert.areEqual('Ferocious chipmunk', thisCase.Subject, 'unexpected subject for test case');
    }

    /**
     * tests @HttpDelete
     */
    @isTest
    private static void testDeleteCase() {
        Id recordId = createTestRecord();

        /**
         * instantiate new rest request for testing purposes;
         * CaseManager.deleteCase() references the RestContext
         */
        RestRequest request = new RestRequest();
        request.requestURI = URI + String.valueOf(recordId);
        request.httpMethod = REST_DELETE;
        RestContext.request = request;

        Boolean result;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            result = CaseManager.deleteCase();
        }
        Assert.isTrue(result, 'delete did not succeed');

        List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
        Assert.isTrue(cases.isEmpty(), 'no cases should have been queried');
    }

    /**
     * tests @HttpPut
     */
    @isTest
    private static void testUpsertCase() {
        User runAsUser = new User(Id = UserInfo.getUserId());
        Id caseOneId;
        System.runAs(runAsUser) {
            caseOneId = CaseManager.upsertCase('Ferocious chipmunk', 'New', 'Phone', 'Low', null);
        }
        Assert.isNotNull(caseOneId, 'case id should be populated after inserting');

        Case caseOne = [SELECT Id, Subject FROM Case WHERE Id = :caseOneId];
        Assert.isNotNull(caseOne, 'caseOne should have been queried by id');
        Assert.areEqual('Ferocious chipmunk', caseOne.Subject, 'unexpected case subject');

        Id caseTwoId;
        System.runAs(runAsUser) {
            caseTwoId = CaseManager.upsertCase('Ferocious chipmunk', 'Working', 'Phone', 'Low', caseOneId);
        }
        Assert.areEqual(caseOneId, caseTwoId, 'case should have been updated by upsert, not inserted');

        Case caseTwo = [SELECT Id, Status FROM Case WHERE Id = :caseTwoId];
        Assert.isNotNull(caseTwo, 'caseTwo should have been queried by id');
        Assert.areEqual('Working', caseTwo.Status, 'unexpected case status');
    }

    /**
     * tests @HttpPatch
     */
    @isTest
    private static void testUpdateCaseFields() {
        Id recordId = createTestRecord();

        /**
         * instantiate new rest request for testing purposes;
         * CaseManager.updateCaseFields() references the RestContext
         */
        RestRequest request = new RestRequest();
        request.requestURI = URI + String.valueOf(recordId);
        request.httpMethod = REST_PATCH;
        request.addHeader('Content-Type', 'application-json');
        request.requestBody = Blob.valueOf('{"status" : "Working"}');
        RestContext.request = request;

        Id caseId;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            caseId = CaseManager.updateCaseFields();
        }
        Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :caseId];

        Assert.isNotNull(caseId, 'case Id should not be null');
        Assert.isNotNull(thiscase, 'case should not be null');
        Assert.areEqual('Working', thisCase.Status, 'unexpected case status');
    }

    private static Id createTestRecord() {
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Phone', Priority = 'Medium');
        Database.insert(testCase);
        return testCase.Id;
    }
}
