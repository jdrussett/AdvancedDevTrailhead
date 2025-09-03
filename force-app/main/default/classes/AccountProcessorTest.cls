@IsTest
private with sharing class AccountProcessorTest {
    @testSetup
    private static void testSetup() {
        Account acc1 = new Account(Name = 'AAA - Test Account 1');
        Account acc2 = new Account(Name = 'BBB - Test Account 2');
        Account acc3 = new Account(Name = 'CCC - Test Account 3');

        Database.insert(new List<Account>{ acc1, acc2, acc3 });

        // account 1 contacts
        Contact ctc1 = new Contact(FirstName = 'Fred', LastName = 'Flinstone', AccountId = acc1.Id);
        Contact ctc2 = new Contact(FirstName = 'Amy', LastName = 'Winehouse', AccountId = acc1.Id);
        Contact ctc3 = new Contact(FirstName = 'Ben', LastName = 'Stiller', AccountId = acc1.Id);

        // account 2 contacts
        Contact ctc4 = new Contact(FirstName = 'Jerry', LastName = 'Seinfeld', AccountId = acc2.Id);
        Contact ctc5 = new Contact(FirstName = 'Chris', LastName = 'Stapleton', AccountId = acc2.Id);
        Contact ctc6 = new Contact(FirstName = 'Marty', LastName = 'Robbins', AccountId = acc2.Id);
        Contact ctc7 = new Contact(FirstName = 'John', LastName = 'Goodman', AccountId = acc2.Id);
        Contact ctc8 = new Contact(FirstName = 'Randy', LastName = 'Johnson', AccountId = acc2.Id);

        // account 3 contacts
        Contact ctc9 = new Contact(FirstName = 'Jennifer', LastName = 'Connelly', AccountId = acc3.Id);
        Contact ctc10 = new Contact(FirstName = 'H Jon', LastName = 'Benjamin', AccountId = acc3.Id);

        Database.insert(new List<Contact>{ ctc1, ctc2, ctc3, ctc4, ctc5, ctc6, ctc7, ctc8, ctc9, ctc10 });
    }

    @isTest
    private static void countContactsTest() {
        List<Id> accountIds = new List<Id>();
        for (Account a : [SELECT Id FROM Account]) {
            accountIds.add(a.Id);
        }

        Test.startTest();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            AccountProcessor.countContacts(accountIds);
        }
        Test.stopTest();

        List<Account> results = [SELECT Id, Name, Number_Of_Contacts__c FROM Account ORDER BY Name];
        Account testAccount1 = results[0];
        Account testAccount2 = results[1];
        Account testAccount3 = results[2];

        Assert.areEqual(3, testAccount1.Number_Of_Contacts__c, 'unexpected number of contacts on account: ' + testAccount1.Name);
        Assert.areEqual(5, testAccount2.Number_Of_Contacts__c, 'unexpected number of contacts on account: ' + testAccount2.Name);
        Assert.areEqual(2, testAccount3.Number_Of_Contacts__c, 'unexpected number of contacts on account: ' + testAccount3.Name);
    }
}
