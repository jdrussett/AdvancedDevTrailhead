public with sharing class OrderEventTriggerHandler {
    private List<Order_Event__e> triggerNew;

    public OrderEventTriggerHandler(List<Order_Event__e> triggerNew) {
        this.triggerNew = triggerNew;
    }

    public void createTasks() {
        List<Task> toInsert = new List<Task>();
        for (Order_Event__e event : this.triggerNew) {
            if (event.Has_Shipped__c == true) {
                toInsert.add(
                    new Task(
                        Priority = 'Medium',
                        Subject = 'Follow up on shipped order 105',
                        OwnerId = event.CreatedById
                    )
                );
            }
        }
        if (!toInsert.isEmpty()) {
            Database.insert(toInsert, /* allOrNone */ true, AccessLevel.SYSTEM_MODE);
        }
    }
}
