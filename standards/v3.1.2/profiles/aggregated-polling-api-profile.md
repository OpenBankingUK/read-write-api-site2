---
layout: default
parent: Profiles
grand_parent: Version 3.1.2
permalink: standards/v3.1.2/profiles/aggregated-polling-api-profile
---
# Aggregated Polling API Profile - v3.1.2

1. [Overview](#overview)
2. [Basics](#basics)
   1. [Overview](#overview-1)
      1. [Steps](#steps)
      2. [Sequence Diagram](#sequence-diagram)
      3. [Grants Types](#grants-types)

## Overview

The Aggregated Polling API Profile describes the flows and common functionality for the Aggregated Polling API, which allows a ASPSPs to deliver multiple signed event notifications to TPPs though the use of polling. It is intended as an alternative or complement to Real Time Notification in that:

* It can be used as the sole method to collect event notifications by a TPP.
* It offers a means to catch-up following a period where the TPP's Real Time Notification endpoint has been offline.

Implementation of the Aggregated Polling API is **optional** for ASPSPs.

This profile should be read in conjunction with a compatible Read/Write Data API Profile, a compatible Event Notification API Profile and compatible individual resources.

## Basics

### Overview

The steps below provide a general outline of an aggregated notification flow for all resources in the R/W APIs.

#### Steps

Step 1: Initial Polling

This is the first time a TPP calls the ASPSP to poll for events:

* A TPP calls an ASPSP to poll for events.
* The ASPSP responds with an array of awaiting events encoded as signed event notifications.

Step 2a: Acknowledge Only

Following the initial poll the TPP has the option to only acknowledge receipt if they do not wish to receive further events at a given time:

* A TPP calls an ASPSP to acknowledge the event notifications that have been successfully processed.
* If required, the TPP also sends indicators of event notifications which they could not process due to an error.
* The ASPSP responds positively but sends no further events.

Step 2b: Poll and Acknowledge

Following the initial poll the TPP can then repeatedly poll the ASPSP, acknowledging successfully processed event notifications and requesting more:

* A TPP calls an ASPSP to acknowledge the event notifications that have been successfully processed with appropriate parameters to receive more.
* If required, the TPP also sends event notifications which they could not process due to an error.
* The ASPSP responds positively and responds with an array of awaiting event notifications encoded as signed event notifications.

#### Sequence Diagram

![Aggregated Polling](images/AggregatedPolling.png)

<details>
  <summary>Diagram source</summary>

  ```
participant TPP
participant ASPSP Authorisation Server
participant ASPSP Event Polling Service

note over TPP, ASPSP Event Polling Service
Step 1: Initial Polling
end note

TPP <-> ASPSP Authorisation Server: Establish TLS 1.2 MA
TPP -> ASPSP Authorisation Server: Initiate Client Credentials Grant
ASPSP Authorisation Server -> TPP: access-token

TPP -> ASPSP Event Polling Service: Poll for events
ASPSP Event Polling Service -> TPP: HTTP 200 (Zero or more events)

note over TPP, ASPSP Event Polling Service
Step 2a: Acknowledge Only
end note

TPP <-> ASPSP Authorisation Server: Establish TLS 1.2 MA
TPP -> ASPSP Authorisation Server: Initiate Client Credentials Grant
ASPSP Authorisation Server -> TPP: access-token

TPP -> ASPSP Event Polling Service: Acknowledge events
ASPSP Event Polling Service -> TPP: HTTP 200 (Zero events)

note over TPP, ASPSP Event Polling Service
Step 2b: Poll and Acknowledge
end note

TPP <-> ASPSP Authorisation Server: Establish TLS 1.2 MA
TPP -> ASPSP Authorisation Server: Initiate Client Credentials Grant
ASPSP Authorisation Server -> TPP: access-token

TPP <-> ASPSP Event Polling Service: Establish TLS 1.2 MA
TPP -> ASPSP Event Polling Service: Acknowledge events
ASPSP Event Polling Service -> TPP: HTTP 200 (Zero or more events)

option footer=bar
```

</details>

### Acknowledgement by the TPP

draft-ietf-secevent-http-poll-01 specifies that recipients of event notifications must acknowledge them. This is manifested in one of two ways:

* Through positive acknowledgement in that the event notification has been received and successfully processed.
* Through negative acknowledgement where the event notification has been received but the TPP encountered an error in processing.

ASPSPs can evict positively acknowledged event notifications from their stores. It is implicit that TPPs are responsible for retaining a record of event notifications appropriate to their needs once positively acknowledged.

### Event Recycling Frequency

ASPSPs are responsible for documenting the frequency at which JWT Identifiers will be recycled and reused in their developer portal.

### Polling Frequency

ASPSPs are responsible for documenting the interval at which TPPs should call the polling endpoint and any further restrictions in their developer portal.

### Polling Parameters

TPPs can send two parameters to indicate the polling behaviours:

* The maximum number of events to be transmitted by the ASPSP.
* Whether the ASPSP should return a response immediately, or allow the TPP to maintain a connection to support long polling.

Given the implications of long polling (described [here](https://tools.ietf.org/html/rfc6202#page-4)) supporting long polling is **optional**.

ASPSPs are responsible for documenting in their developer portal any upper bound for the maximum number of events parameter and their support for long polling.

### Security

#### Authentication

ASPSPs must secure their aggregated polling endpoint using MA-TLS.

draft-ietf-secevent-http-poll-01 allows for the use signed event notifications for authentication. The conditions under which this is permissible are not met by the Read/Write API standards, so this approach should not be implemented.

#### Scopes

The access tokens required for accessing the Aggregated Polling API must have at least the following scope:

```
eventpolling: Ability to poll for, acknowledge and receive Security Event Tokens
```

#### Grants Types

Consumers **must** use a client credentials grant to obtain a token to make POST requests to the **events** endpoint. In the specification, this grant type is referred to as "Client Credentials".
