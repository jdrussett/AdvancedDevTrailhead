@IsTest
private with sharing class AccountManagerTest {
    private static final String URI = 'https://mindful-unicorn-6vazb3-dev-ed.trailblaze.my.salesforce.com/Accounts/[recordId]/contacts/';
    private static final String REST_GET = 'GET';

    @isTest
    private static void testGetAccount() {
        Account testAccount = new Account(Name = 'Test-Account');
        Database.insert(testAccount);

        Database.insert(
            new List<Contact>{
                new Contact(FirstName = 'Mike', LastName = 'Bradley', AccountId = testAccount.Id),
                new Contact(FirstName = 'Jeff', LastName = 'Thomas', AccountId = testAccount.Id)
            }
        );

        RestRequest request = new RestRequest();
        request.requestURI = URI.replace('[recordId]', testAccount.Id);
        request.httpMethod = REST_GET;
        RestContext.request = request;

        Account result;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            result = AccountManager.getAccount();
        }

        Assert.isNotNull(result, 'account should have been retrieved');
        Assert.areEqual(2, result.Contacts.size(), 'two contacts should have been retrieved');
    }
}
