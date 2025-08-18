public with sharing class AnimalsCallouts {
    private static final String GET = 'GET';
    private static final String POST = 'POST';

    // run: AnimalsCallouts.makeGETCallout();
    public static HttpResponse makeGETCallout() {
        HttpRequest request = new HttpRequest();
        request.setMethod(GET);
        request.setEndpoint('callout:AnimalsCallout');
        HttpResponse response = new Http().send(request);
        return response;
    }
    
    // run: AnimalsCallouts.makePOSTCallout();
    public static HttpResponse makePOSTCallout() {
        HttpRequest request = new HttpRequest();
        request.setMethod(POST);
        request.setEndpoint('callout:AnimalsCallout');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name": "mighty moose"}');
        HttpResponse response = new Http().send(request);
        return response;
    }
}
