@IsTest(IsParallel=true)
public with sharing class AddPrimaryContactTest {
    @testSetup
    private static void testSetup() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + String.valueOf(i + 1), BillingState = 'NY'));
        }
        Database.insert(testAccounts);
    }

    @isTest
    private static void testQueueable() {
        Contact testContact = new Contact(LastName = 'Robinson', Email = 'tim@ithinkyoushouldleave.com');
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(testContact, 'NY'));
        Test.stopTest();
        Assert.areEqual(
            200,
            [SELECT COUNT() FROM Contact WHERE LastName = 'Robinson'],
            'there should now be two hundred contacts in the org'
        );
    }
}
