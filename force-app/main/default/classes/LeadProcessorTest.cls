@IsTest
private with sharing class LeadProcessorTest {
    @testSetup
    private static void testSetup() {
        List<Lead> testLeads = new List<Lead>();
        // only one batch can execute in a test method; max size of 200 records
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(
                new Lead(
                    Company = 'Salesforce',
                    Status = 'Working - Contacted',
                    LeadSource = 'Convention',
                    LastName = 'McDonald'
                )
            );
        }
        Database.insert(testLeads, /* allOrNone*/ true);
    }

    @isTest
    private static void testBatchUpdate() {
        Test.startTest();
        LeadProcessor batchClass = new LeadProcessor();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            Database.executeBatch(batchClass);
        }
        Test.stopTest();
        for (Lead updatedLead : [SELECT LeadSource FROM Lead]) {
            Assert.areEqual('Dreamforce', updatedLead.LeadSource, 'unexepcted lead source');
        }
    }
}
