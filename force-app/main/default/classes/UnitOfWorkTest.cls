@IsTest
private with sharing class UnitOfWorkTest {
  private static final Integer NUM_ACCOUNTS = 100;
  private static final Integer NUM_CONTACTS = 500;
  private static final Integer NUM_NOTES = 500;
  @isTest
  static void challengeComplete() {
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{
        Account.SObjectType,
        Contact.SObjectType,
        Note.SObjectType
      }
    );

    Integer numChildrenPerParent = NUM_CONTACTS / NUM_ACCOUNTS;

    for (Integer i = 0; i < NUM_ACCOUNTS; i++) {
      Account a = new Account(Name = 'Test Account ' + i);
      uow.registerNew(a);
      for (Integer j = 0; j < numChildrenPerParent; j++) {
        Contact c = new Contact(FirstName = 'Jake', LastName='Russett Test ' + (i+j));
        uow.registerNew(c, Contact.AccountId, a);
        Note n = new Note(Title='Test Note ' + (i+j), Body='Test Note Body');
        uow.registerNew(n, Note.ParentId, a);
      }
    }
    uow.commitWork();
    System.assertEquals(100, [SELECT Id FROM Account].size());
    System.assertEquals(500, [SELECT Id FROM Contact].size());
    System.assertEquals(500, [SELECT Id FROM Note].size());
  }
}