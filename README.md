# AdvancedDevTrailhead

## Deployment

All metadata spanning all included badges/modules deployable with [deploy.xml](packages/deploy.xml).

## Metadata

Contains solutions for many advanced developer topic related Trailhead badges &amp; modules

- [Apex Enterprise Patterns: Service Layer](https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl)
- [Apex Enterprise Patterns: Domain & Selector Layers](https://trailhead.salesforce.com/content/learn/modules/apex_patterns_dsl)
- [Apex Integration Services](https://trailhead.salesforce.com/content/learn/modules/apex_integration_services)
    - REST callouts
        - [AnimalsCallouts.cls](force-app/main/default/classes/AnimalsCallouts.cls)/[AnimalsCalloutsTest.cls](force-app/main/default/classes/AnimalsCalloutsTest.cls)
        - [AnimalsHttpCalloutMock.cls](force-app/main/default/classes/AnimalsHttpCalloutMock.cls)
        - [AnimalLocator.cls](force-app/main/default/classes/AnimalLocator.cls)/[AnimalLocatorTest.cls](force-app/main/default/classes/AnimalLocatorTest.cls)
        - [AnimalLocatorMock.cls](force-app/main/default/classes/AnimalLocatorMock.cls)
        - [GetAnimalResource.txt](force-app/main/default/staticresources/GetAnimalResource.txt)
    - SOAP callouts
        - [AwesomeCalculator.cls](force-app/main/default/classes/AwesomeCalculator.cls)/[AwesomeCalculatorTest.cls](force-app/main/default/classes/AwesomeCalculatorTest.cls)
        - [CalculatorCalloutMock.cls](force-app/main/default/classes/CalculatorCalloutMock.cls)
        - [calculator.wsdl](calculator.wsdl)
        - [ParkLocator.cls](force-app/main/default/classes/ParkLocator.cls)/[ParkLocatorTest.cls](force-app/main/default/classes/ParkLocatorTest.cls)
        - [ParkServiceMock.cls](force-app/main/default/classes/ParkServiceMock.cls)
        - [parks.wsdl](parks.wsdl)
    - Apex web services
        - [AccountManager.cls](force-app/main/default/classes/AccountManager.cls)/[AccountManagerTest.cls](force-app/main/default/classes/AccountManagerTest.cls)
        - [CaseManager.cls](force-app/main/default/classes/CaseManager.cls)/[CaseManagerTest.cls](force-app/main/default/classes/CaseManagerTest.cls)
- [Platform Events Basics](https://trailhead.salesforce.com/content/learn/modules/platform_events_basics)
    - [publish w/ Apex example](scripts/apex/publishPlatformEventsExample.apex)
    - [CloudNewsTrigger.trigger](force-app/main/default/triggers/CloudNewsTrigger.trigger)/[CloudNewsTriggerHandler.cls](force-app/main/default/classes/CloudNewsTriggerHandler.cls)/[CloudNewsTriggerHanlderTest.cls](force-app/main/default/classes/CloudNewsTriggerHandlerTest.cls)
    - [OrderEventTrigger.trigger](force-app/main/default/triggers/OrderEventTrigger.trigger)/[OrderEventTriggerHandler.cls](force-app/main/default/classes/OrderEventTriggerHandler.cls)
- [Build an Instant Notification App](https://trailhead.salesforce.com/content/learn/projects/workshop-platform-events) - *(Platform Events)*
    - [BearAlertTopicAssignmentTrigger.trigger](force-app/main/default/triggers/BearAlertTopicAssignmentTrigger.trigger)
    - [BearAlertTopicAssignmentTriggerHandler.cls](force-app/main/default/classes/BearAlertTopicAssignmentTriggerHandler.cls)
    - [notificationConsole LWC](force-app/main/default/lwc/notificationConsole/)
