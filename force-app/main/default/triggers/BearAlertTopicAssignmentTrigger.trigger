trigger BearAlertTopicAssignmentTrigger on TopicAssignment(after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        new BearAlertTopicAssignmentTriggerHandler(Trigger.new).publishNotifications();
    }
}
