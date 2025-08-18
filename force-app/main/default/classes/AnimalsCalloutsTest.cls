@IsTest
private with sharing class AnimalsCalloutsTest {
    /**
     * this mock testing framework is for GET requests
     * uses GetAnimalResource.txt static resource
     */
    @isTest
    private static void testGETCallout() {
        // mock response using static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');

        // associate the test context's callout with the mock response
        Test.setMock(HttpCalloutMock.class, /* mocked callout response via static resource */ mock);

        // test by simulating the callout
        HttpResponse response = AnimalsCallouts.makeGETCallout();
        Assert.areNotEqual(null, response, 'callout response should not be null');
        Assert.areEqual(200, response.getStatusCode(), 'callout response status code should be 200');
        Assert.areEqual(
            'application/json;charset=UTF-8',
            response.getHeader('Content-Type'),
            'content type header of response is incorrect'
        );

        Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> animals = (List<Object>) responseBody.get('animals');
        Integer animalsCount = animals.size();
        Assert.areEqual(3, animalsCount, 'three animals should have been returned');
    }

    /**
     * this mock testing framework is for POST requests
     */
    @isTest
    private static void testPOSTCallout() {
        // associate the test context's callout with the mock response
        AnimalsHttpCalloutMock mock = new AnimalsHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, /* mocked callout response via AnimalsHttpCalloutMock */ mock);

        // test by simulating the callout - posting new animal mighty moose to web content
        // response in this case will come from AnimalsHttpCalloutMock mock respond() method
        HttpResponse response = AnimalsCallouts.makePOSTCallout();
        Assert.areEqual(
            'application/json;charset=UTF-8',
            response.getHeader('Content-Type'),
            'content type header of response is incorrect'
        );
        Assert.areEqual(200, response.getStatusCode(), 'callout response status code should be 200');
        Assert.areEqual(
            '{"animals": ["majestic badger", "fluffy bunner", "scary bear", "chicken", "mighty moose"]}',
            response.getBody(),
            'response body did not match what was expected'
        );
    }
}
