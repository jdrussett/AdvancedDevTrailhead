@IsTest
private with sharing class DailyLeadProcessorTest {
    @isTest
    private static void testSchedulableApex() {
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(
                LastName = 'Johnson',
                Company = 'Salesforce',
                Status = 'Working - Contacted'
            ));
        }
        Database.insert(testLeads);

        Test.startTest();
        System.schedule('testingDailyLeadProcessorJob', '0 0 8 ? * MON *', new DailyLeadProcessor());
        Test.stopTest();

        for (Lead updatedLead : [SELECT LeadSource FROM Lead]) {
            Assert.areEqual('Dreamforce', updatedLead.LeadSource, 'unexpected lead source');
        }
    }
}
