---
layout: default
parent: AISP
grand_parent: Resources and Data Models
permalink: standards/v3.1.2/resources-and-data-models/event-notifications/event-subscription
---
# Event Subscription - v3.1.2

1. [Overview](#overview)
2. [Endpoints](#endpoints)
   1. [Endpoints](#endpoints-1)
      1. [POST /event-subscriptions](#post-event-subscriptions)
      2. [GET /event-subscriptions](#get-event-subscriptions)
      3. [PUT /event-subscriptions/{EventSubscriptionId}](#put-event-subscriptionseventsubscriptionid)
      4. [DELETE /event-subscriptions/{EventSubscriptionId}](#delete-event-subscriptionseventsubscriptionid)
3. [Data Model](#data-model)
   1. [Event Subscription - Request](#event-subscription---request)
      1. [UML Diagram](#uml-diagram)
      2. [Notes](#notes)
      3. [Data Dictionary](#data-dictionary)
   2. [Event Subscription - Response](#event-subscription---response)
      1. [UML](#uml)
      2. [Data Dictionary](#data-dictionary-1)
   3. [Event Subscriptions - Response](#event-subscriptions---response)
      1. [UML](#uml-1)
      2. [Data Dictionary](#data-dictionary-2)
4. [Usage Examples](#usage-examples)
   1. [Create Event Subscription](#create-event-subscription)
      1. [POST Event Subscription Request](#post-event-subscription-request)
      2. [POST Event Subscription Response](#post-event-subscription-response)
   2. [Get Event Subscriptions](#get-event-subscriptions)
      1. [GET Event Subscription Request](#get-event-subscription-request)
      2. [GET Event Subscription Response](#get-event-subscription-response)

## Overview

The Event Subscription resource is used by a TPP to subscribe to events with an ASPSP.

This resource description should be read in conjunction with a compatible Event Notification Subscription Profile.

## Endpoints

A TPP will set up and maintain its event subscription details (URL, event types and version number) using the event-subscription resource.

### Endpoints

| Resource |HTTP Operation |Endpoint |Mandatory ? |Scope |Grant Type |Message Signing |Idempotency Key |Request Object |Response Object |
| --- |--- |--- |--- |--- |--- |--- |--- |--- |--- |
| event-subscription |POST |POST /event-subscriptions |Optional |accounts<br>payments<br>fundsconfirmations |Client Credentials |Signed Request<br><br>Signed Response |No |OBEventSubscription1 |OBEventSubscriptionResponse1 |
| event-subscription |GET |GET /event-subscriptions |Mandatory (if resource POST implemented) |accounts<br>payments<br>fundsconfirmations |Client Credentials |Signed Response |No |n/a |OBEventSubscriptionsResponse1 |
| event-subscription |PUT |PUT /event-subscriptions/{EventSubscriptionId} |Mandatory (if resource POST implemented) |accounts<br>payments<br>fundsconfirmations |Client Credentials |Signed Request<br><br>Signed Response |No |OBEventSubscriptionResponse1 |OBEventSubscriptionResponse1 |
| event-subscription |DELETE |DELETE /event-subscriptions/{EventSubscriptionId} |Mandatory (if resource POST implemented) |accounts<br>payments<br>fundsconfirmations |Client Credentials |n/a |No |n/a |n/a |


#### POST /event-subscriptions

The API endpoint allows the TPP to ask an ASPSP to create a new **event-subscription** resource.

* The POST action allows the TPP to register an event subscription for a TPP to access event notifications.
* The ASPSP creates the **event-subscription** resource and responds with a unique EventSubscriptionId to refer to the resource.
* An ASPSP **must** respond with a 409 error if an event-subscription exists for that TPP.

#### GET /event-subscriptions

The API endpoint allows the TPP to ask an ASPSP to retrieve its **event-subscription** resource.

* The ASPSP retrieves the **event-subscription** resource and responds with the resource.

#### PUT /event-subscriptions/{EventSubscriptionId}

The API endpoint allows the TPP to ask an ASPSP to update an **event-subscription** resource.

* The PUT action allows the TPP to update an event subscription for a TPP to access event notifications.
* The ASPSP updates the **event-subscription** resource and responds with the updated resource.

#### DELETE /event-subscriptions/{EventSubscriptionId}

The API endpoint allows the TPP to ask an ASPSP to delete an **event-subscription** resource.

* The ASPSP deletes the **event-subscription** resource.

## Data Model

### Event Subscription - Request

The OBEventSubscription1 object will be used for the call to:

* POST /event-subscriptions

#### UML Diagram

![OBEventSubscription1](images/OBEventSubscription1.gif)

#### Notes

For the OBEventSubscription1 object:

* EventTypes usage:
  * TPPs may provide a list of event types to subscribe to specific events.
  * TPPs may omit this field to subscribe to all supported events.


#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| --- |--- |--- |--- |--- |--- |--- |
| OBEventSubscription1 | |OBEventSubscription1 | |OBEventSubscription1 | | |
| Data |1..1 |OBEventSubscription1/Data | |OBEventSubscriptionData1 | | |
| CallbackUrl |0..1 |OBEventSubscription1/Data/CallbackUrl |Callback URL for a TPP hosted service. Will be used by ASPSPs, in conjunction with the resource name, to construct a URL to send event notifications to. |xs:anyURI | | |
| Version |1..1 |OBEventSubscription1/Data/Version |Version for the event notification. |Max10Text | | |
| EventTypes |0..n |OBEventSubscription1/Data/EventTypes |Array of event types the subscription applies to. |OBEventType1Code | | |


### Event Subscription - Response

The OBEventSubscriptionResponse1 object will be used for a response to a call to:

* POST /event-subscriptions
* PUT /event-subscriptions/{EventSubscriptionId}

The OBEventSubscriptionResponse1 object will also be used for the call to:

* PUT /event-subscriptions

#### UML

![OBEventSubscriptionResponse1](images/OBEventSubscriptionResponse1.gif)

#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| --- |--- |--- |--- |--- |--- |--- |
| OBEventSubscriptionResponse1 | |OBEventSubscriptionResponse1 | |OBEventSubscriptionResponse1 | | |
| Data |1..1 |OBEventSubscriptionResponse1/Data | |OBEventSubscriptionResponseData1 | | |
| EventSubscriptionId |1..1 |OBEventSubscriptionResponse1/Data/EventSubscriptionId |Unique identification as assigned by the ASPSP to uniquely identify the callback URL resource. |Max40Text | | |
| CallbackUrl |0..1 |OBEventSubscriptionResponse1/Data/CallbackUrl |Callback URL for a TPP hosted service. Will be used by ASPSPs, in conjunction with the resource name, to construct a URL to send event notifications to. |xs:anyURI | | |
| Version |1..1 |OBEventSubscriptionResponse1/Data/Version |Version for the event notification. |Max10Text | | |
| EventTypes |0..n |OBEventSubscriptionResponse1/Data/EventTypes |Array of event types the subscription applies to. |OBEventType1Code | | |

### Event Subscriptions - Response

The OBEventSubscriptionsResponse1 object will be used for a response to a call to:

* GET /event-subscriptions

#### UML

![OBEventSubscriptionsResponse1](images/OBEventSubscriptionsResponse1.gif)

#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| --- |--- |--- |--- |--- |--- |--- |
| OBEventSubscriptionsResponse1 | |OBEventSubscriptionsResponse1 | |OBEventSubscriptionsResponse1 | | |
| Data |1..1 |OBEventSubscriptionsResponse1/Data | |OBEventSubscriptionsResponseData1 | | |
| EventSubscription |0..n |OBEventSubscriptionsResponse1/Data/EventSubscription | |OBEventSubscriptionResponseData1 | | |
| EventSubscriptionId |1..1 |OBEventSubscriptionsResponse1/Data/EventSubscription/EventSubscriptionId |Unique identification as assigned by the ASPSP to uniquely identify the callback url resource. |Max40Text | | |
| Url |0..1 |OBEventSubscriptionsResponse1/Data/EventSubscription/Url |Callback URL for a TPP hosted service. Will be used by ASPSPs, in conjunction with the resource name, to construct a URL to send event notifications to. |xs:anyURI | | |
| Version |1..1 |OBEventSubscriptionsResponse1/Data/EventSubscription/Version |Version for the event notification. |Max10Text | | |
| EventTypes |0..n |OBEventSubscriptionsResponse1/Data/EventSubscription/EventTypes |Array of event types the subscription applies to. |OBEventType1Code | | |


## Usage Examples

### Create Event Subscription

#### POST Event Subscription Request

```
POST /event-subscriptions HTTP/1.1
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA
x-jws-signature: TGlmZSdzIGEgam91cm5leSBub3QgYSBkZXN0aW5hdGlvbiA=..T2ggZ29vZCBldmVuaW5nIG1yIHR5bGVyIGdvaW5nIGRvd24gPw==
x-fapi-interaction-id: 86ebcd82-8e38-4f2d-a79c-965b41d15865
Content-Type: application/json
Accept: application/json
```

```json
{
  "Data": {
	"CallbackUrl": "https://tpp.com/open-banking/v3.1/event-notifications",
	"Version": "3.1"
  }
}
```

#### POST Event Subscription Response

```
HTTP/1.1 201 Created
x-jws-signature: V2hhdCB3ZSBnb3QgaGVyZQ0K..aXMgZmFpbHVyZSB0byBjb21tdW5pY2F0ZQ0K
x-fapi-interaction-id: 86ebcd82-8e38-4f2d-a79c-965b41d15865
Content-Type: application/json
```

```json
{
	"Data": {
		"EventSubscriptionId": "CB-101",
		"CallbackUrl": "https://tpp.com/open-banking/v3.1/event-notifications",
		"Version": "3.1"
	},
	"Links": {
		"Self": "https://api.alphabank.com/open-banking/v3.1/event-subscriptions/CB-101"
	},
	"Meta": {}
}
```

### Get Event Subscriptions

#### GET Event Subscription Request

```
GET /event-subscriptions HTTP/1.1
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA
x-fapi-interaction-id: 86ebcd82-8e38-4f2d-a79c-965b41d15865
Accept: application/json
```

#### GET Event Subscription Response

```
GET/1.1 200 OK
x-jws-signature: V2hhdCB3ZSBnb3QgaGVyZQ0K..aXMgZmFpbHVyZSB0byBjb21tdW5pY2F0ZQ0K
x-fapi-interaction-id: 86ebcd82-8e38-4f2d-a79c-965b41d15865
Content-Type: application/json
```

```json
{
	"Data": {
		"EventSubscription": [{
			"EventSubscriptionId": "CB-101",
			"CallbackUrl": "https://tpp.com/open-banking/v3.1/event-notifications",
			"Version": "3.1"
		}]
	},
	"Links": {
		"Self": "https://api.alphabank.com/open-banking/v3.1/event-subscriptions/"
	},
	"Meta": {}
}
```
