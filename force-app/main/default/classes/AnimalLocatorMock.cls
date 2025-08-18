@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class AnimalLocatorMock implements HttpCalloutMock {
    private static final String RESPONSEBODY = '{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
    private static final Integer RESPONSESTATUSCODE = 200;
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(RESPONSEBODY);
        response.setStatusCode(RESPONSESTATUSCODE);
        return response;
    }
}
