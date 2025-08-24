@IsTest
public with sharing class AnimalLocatorTest {
    @isTest
    private static void testGETCallout() {
        AnimalLocatorMock mock = new AnimalLocatorMock();
        Test.setMock(HttpCalloutMock.class, mock);
        Integer animalId = 1;

        String response;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            response = AnimalLocator.getAnimalNameById(animalId);
        }
        Assert.isNotNull(response, 'response body should not be null');
    }
}
