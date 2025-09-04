public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String queryString = 'SELECT Id FROM Lead';
        return Database.getQueryLocator(queryString);
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        for (Lead l : scope) {
            l.LeadSource = 'Dreamforce';
        }
        Database.update(scope);
    }

    public void finish(Database.BatchableContext bc) {
    }
}