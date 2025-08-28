@IsTest
private with sharing class CloudNewsTriggerHandlerTest {
    @isTest
    private static void testNewCloudNewsEvent() {
        Cloud_News__e newEvent = new Cloud_News__e(
            Location__c = 'Mineapolis',
            Urgent__c = true,
            News_Content__c = 'Poor air quality today.'
        );

        Test.startTest();
        Database.SaveResult result = EventBus.publish(newEvent);
        Test.stopTest();

        Assert.isTrue(result.isSuccess(), 'platform event publish should have succeeded');
        Assert.areEqual(1, [SELECT COUNT() FROM Case], 'a case should have been created');
    }
}