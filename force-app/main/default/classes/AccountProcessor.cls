public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accounts = [
            SELECT Id, (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :accountIds
            WITH USER_MODE
        ];
        for (Account acc : accounts) {
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        Database.update(accounts, /* allOrNone */ false, AccessLevel.USER_MODE);
    }
}
