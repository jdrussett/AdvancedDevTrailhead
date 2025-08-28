trigger CloudNewsTrigger on Cloud_News__e (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        new CloudNewsTriggerHandler(Trigger.new).createCasesForUrgentEvents();
    }
}