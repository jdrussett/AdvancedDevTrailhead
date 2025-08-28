public with sharing class BearAlertTopicAssignmentTriggerHandler {
    private List<TopicAssignment> triggerNew = new List<TopicAssignment>();
    private Set<Id> feedIds = new Set<Id>();
    private Map<Id, FeedItem> feedItems {
        get {
            // Load FeedItem bodies
            if (feedItems == null) {
                feedItems = new Map<Id, FeedItem>([SELECT Body FROM FeedItem WHERE Id IN :this.feedIds]);
            }
            return feedItems;
        }
        set;
    }

    public BearAlertTopicAssignmentTriggerHandler(List<TopicAssignment> triggerNew) {
        this.triggerNew = triggerNew;
        for (TopicAssignment ta : this.triggerNew) {
            if (ta.EntityId.getSObjectType().getDescribe().getName().equals('FeedItem')) {
                this.feedIds.add(ta.EntityId);
            }
        }
    }

    public void publishNotifications() {
        // Create messages for each FeedItem that contains the BearAlert topic
        List<String> messages = new List<String>();
        for (TopicAssignment ta : [
            SELECT Id, EntityId, Topic.Name
            FROM TopicAssignment
            WHERE Id IN :this.triggerNew AND Topic.Name = 'BearAlert'
            WITH SYSTEM_MODE
        ]) {
            messages.add(this.feedItems.get(ta.EntityId).body.stripHtmlTags().abbreviate(255));
        }

        // Publish messages as notifications
        List<Notification__e> notifications = new List<Notification__e>();
        for (String message : messages) {
            notifications.add(new Notification__e(Message__c = message));
        }

        // Inspect publishing results
        List<Database.SaveResult> results = EventBus.publish(notifications);
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error returned: ' + error.getStatusCode() + ' - ' + error.getMessage());
                }
            }
        }
    }
}
