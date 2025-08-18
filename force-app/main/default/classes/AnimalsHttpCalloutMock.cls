@SuppressWarnings('PMD.AvoidGlobalModifier')
@IsTest
global with sharing class AnimalsHttpCalloutMock implements HttpCalloutMock {
    private static final String RESPONSEBODY = '{"animals": ["majestic badger", "fluffy bunner", "scary bear", "chicken", "mighty moose"]}';
    private static final Integer RESPONSESTATUSCODE = 200;
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(RESPONSEBODY);
        response.setStatusCode(RESPONSESTATUSCODE);
        return response;
    }
}
