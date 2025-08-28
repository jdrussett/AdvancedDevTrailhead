public with sharing class CloudNewsTriggerHandler {
    private List<Cloud_News__e> triggerNew;
    private static Group ownershipQueue {
        get {
            if (ownershipQueue == null) {
                ownershipQueue = [
                    SELECT Id
                    FROM Group
                    WHERE Name = 'Regional Dispatch' AND Type = 'Queue'
                    WITH SYSTEM_MODE
                ];
            }
            return ownershipQueue;
        }
        set;
    }

    public CloudNewsTriggerHandler(List<Cloud_News__e> triggerNew) {
        this.triggerNew = triggerNew;
    }

    public void createCasesForUrgentEvents() {
        List<Case> toInsert = new List<Case>();
        for (Cloud_News__e event : this.triggerNew) {
            if (event.Urgent__c == true) {
                toInsert.add(
                    new Case(
                        Priority = 'High',
                        Subject = 'News team dispatch to ' + event.Location__c,
                        OwnerId = ownershipQueue.Id
                    )
                );
            }
        }
        if (!toInsert.isEmpty()) {
            Database.insert(toInsert, /* allOrNone */ true, AccessLevel.SYSTEM_MODE);
        }
    }
}
