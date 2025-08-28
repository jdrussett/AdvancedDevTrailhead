trigger OrderEventTrigger on Order_Event__e (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        new OrderEventTriggerHandler(Trigger.new).createTasks();
    }
}