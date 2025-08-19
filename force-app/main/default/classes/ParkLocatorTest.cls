@IsTest
private with sharing class ParkLocatorTest {
    @isTest
    private static void testCallout() {
        ParkServiceMock mock = new ParkServiceMock();
        Test.setMock(WebServiceMock.class, mock);

        String countryName = 'some_country';
        List<String> results = ParkLocator.country(countryName);
        List<String> expected = new List<String>{ 'park_one', 'park_two', 'park_three' };
        Assert.areEqual(expected, results, 'expected list of returned parks did not match');
    }
}
