public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext context) {
        List<Lead> leadsToUpdate = [SELECT Id FROM Lead WHERE LeadSource = '' WITH SYSTEM_MODE];
        for (Lead leadToUpdate : leadsToUpdate) {
            leadToUpdate.LeadSource = 'Dreamforce';
        }
        Database.update(leadsToUpdate, /* allOrNone */ false, AccessLevel.SYSTEM_MODE);
    }
}
