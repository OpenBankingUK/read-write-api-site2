---
layout: default
parent: AISP
grand_parent: Resources and Data Models
permalink: standards/v3.1.2/resources-and-data-models/pisp/domestic-standing-orders
---
# Domestic Standing Orders - v3.1.2

1. [Overview](#overview)
2. [Endpoints](#endpoints)
   1. [POST /domestic-standing-orders](#post-domestic-standing-orders)
      1. [Status](#status)
   2. [GET /domestic-standing-orders/{DomesticStandingOrderId}](#get-domestic-standing-ordersdomesticstandingorderid)
      1. [Status](#status-1)
   3. [GET /domestic-standing-orders/{DomesticStandingOrderId}/payment-details](#get-domestic-standing-ordersdomesticstandingorderidpayment-details)
      1. [Status](#status-2)
   4. [State Model](#state-model)
      1. [Payment Order](#payment-order)
         1. [Multiple Authorisation](#multiple-authorisation)
3. [Data Model](#data-model)
   1. [Reused Classes](#reused-classes)
      1. [OBDomesticStandingOrder3](#obdomesticstandingorder3)
   2. [Domestic Standing Order - Request](#domestic-standing-order---request)
      1. [UML Diagram](#uml-diagram)
      2. [Notes](#notes)
      3. [Data Dictionary](#data-dictionary)
   3. [Domestic Standing Order - Response](#domestic-standing-order---response)
      1. [UML Diagram](#uml-diagram-1)
      2. [Notes](#notes-1)
      3. [Data Dictionary](#data-dictionary-1)
   4. [Domestic Standing Order - Payment Details - Response](#domestic-standing-order---payment-details---response)
      1. [UML Diagram](#uml-diagram-2)
      2. [Data Dictionary](#data-dictionary-2)
4. [Usage Examples](#usage-examples)
   1. [Create a Domestic Standing Order](#create-a-domestic-standing-order)
      1. [POST /domestic-standing-orders request](#post-domestic-standing-orders-request)
      2. [POST /domestic-standing-orders response](#post-domestic-standing-orders-response)

## Overview

The Domestic Standing Orders resource is used by a PISP to initiate a Domestic Standing Order.

This resource description should be read in conjunction with a compatible Payment Initiation API Profile.

## Endpoints

| Resource |HTTP Operation |Endpoint |Mandatory ? |Scope |Grant Type |Message Signing |Idempotency Key |Request Object |Response Object |
| -------- |-------------- |-------- |----------- |----- |---------- |--------------- |--------------- |-------------- |--------------- |
| domestic-standing-orders |POST |POST /domestic-standing-orders |Conditional |payments |Authorization Code |Signed Request Signed Response |Yes |OBWriteDomesticStandingOrder3 |OBWriteDomesticStandingOrderResponse4 |
| domestic-standing-orders |GET |GET /domestic-standing-orders/{DomesticStandingOrderId} |Mandatory (if resource POST implemented) |payments |Client Credentials |Signed Response |No |NA |OBWriteDomesticStandingOrderResponse4 |
| payment-details |GET |GET /domestic-standing-orders/{DomesticStandingOrderId}/payment-details |Optional |payments |Client Credentials |Signed Response |No |NA |OBWritePaymentDetailsResponse1 |

### POST /domestic-standing-orders

Once the domestic-standing-order-consent has been authorised by the PSU, the PISP can proceed to submitting the domestic-standing-order for processing:

* This is done by making a POST request to the **domestic-standing-orders** endpoint.
* This request is an instruction to the ASPSP to begin the domestic standing order journey. The PISP must submit the domestic standing order immediately, however, there are some scenarios where the ASPSP may not warehouse the domestic standing order immediately (e.g. busy periods at the ASPSP).
* The PISP **must** ensure that the Initiation and Risk sections of the domestic-standing-order match the corresponding Initiation and Risk sections of the domestic-standing-order-consent resource. If the two do not match, the ASPSP **must not** process the request and **must** respond with a 400 (Bad Request).
* Any operations on the domestic-standing-order resource will not result in a Status change for the domestic-standing-order resource.

#### Status

A domestic-standing-order can only be created if its corresponding domestic-standing-order-consent resource has the status of "Authorised".

The domestic-standing-order resource that is created successfully must have one of the following Status codes:

| Status |
| --- |
| InitiationPending |
| InitiationFailed |
| InitiationCompleted |

### GET /domestic-standing-orders/{DomesticStandingOrderId}

A PISP can retrieve the domestic-standing-order to check its status.

#### Status

The domestic-standing-order resource must have one of the following Status codes:

| Status |
| --- |
| InitiationPending |
| InitiationFailed |
| InitiationCompleted |
| Cancelled |

### GET /domestic-standing-orders/{DomesticStandingOrderId}/payment-details

A PISP can retrieve the Details of the underlying payment transaction via this endpoint. This resource allows ASPSPs to return richer list of Payment Statuses, and if available payment scheme related statuses.

#### Status

The domestic-standing-orders - payment-details must have one of the following PaymentStatusCode code-set enumerations:

| Status |
| --- |
| Accepted |
| AcceptedCancellationRequest |
| AcceptedTechnicalValidation |
| AcceptedCustomerProfile |
| AcceptedFundsChecked |
| AcceptedWithChange |
| Pending |
| Rejected |
| AcceptedSettlementInProcess |
| AcceptedSettlementCompleted |
| AcceptedWithoutPosting |
| AcceptedCreditSettlementCompleted |
| Cancelled |
| NoCancellationProcess |
| PartiallyAcceptedCancellationRequest |
| PartiallyAcceptedTechnicalCorrect |
| PaymentCancelled |
| PendingCancellationRequest |
| Received |
| RejectedCancellationRequest |

### State Model

#### Payment Order

The state model for the domestic-standing-order resource describes the initiation status only. I.e., not the subsequent execution of the domestic-standing-order.

![Payment Order](images/DomesticScheduledStatusModel.png)

The definitions for the Status:

|  |Status |Payment Status Description |
| --- |------ |-------------------------- |
| 1 |InitiationPending |The initiation of the payment order is pending. |
| 2 |InitiationFailed |The initiation of the payment order has failed. |
| 3 |InitiationCompleted |The initiation of the payment order is complete. |
| 4 |Cancelled |Payment initiation has been successfully cancelled after having received a request for cancellation. |

##### Multiple Authorisation

If the payment-order requires multiple authorisations, the Status of the multiple authorisations will be updated in the MultiAuthorisation object.

![Multiple Authorisation](images/image2018-6-29_16-36-34.png)

The definitions for the Status:

|  | Status |Status Description |
| --- |------ |------------------ |
| 1 |AwaitingFurtherAuthorisation |The payment-order resource is awaiting further authorisation. |
| 2 |Rejected |The payment-order resource has been rejected by an authoriser. |
| 3 |Authorised |The payment-order resource has been successfully authorised by all required authorisers. |

## Data Model

The Data Dictionary section gives the detail on the payload content for the Domestic Standing Order API flows.

### Reused Classes

#### OBDomesticStandingOrder3

The OBDomesticStandingOrder3 class is defined in the [domestic-standing-order-consents](./domestic-standing-order-consents.md#OBDOBDomesticstandingorder3) page.

### Domestic Standing Order - Request

The OBWriteDomesticStandingOrder3 object will be used for a call to:

* POST /domestic-standing-orders

#### UML Diagram

![Domestic Standing Order - Request](images/OBWriteDomesticStandingOrder3.png)

#### Notes

The domestic-standing-order **request** object contains the:

* ConsentId.
* The full Initiation and Risk objects from the domestic-standing-order-consent request.
* The **Initiation** and **Risk** sections of the domestic-standing-order request **must** match the **Initiation** and **Risk** sections of the corresponding domestic-standing-order-consent request.

#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| ---- |---------- |----- |------------------ |----- |----- |------- |
| OBWriteDomesticStandingOrder3 | |OBWriteDomesticStandingOrder3 | |OBWriteDomesticStandingOrder3 | | |
| Data |1..1 |OBWriteDomesticStandingOrder3/Data | |OBWriteDataDomesticStandingOrder3 | | |
| ConsentId |1..1 |OBWriteDomesticStandingOrder3/Data/ConsentId |OB: Unique identification as assigned by the ASPSP to uniquely identify the consent resource. |Max128Text | | |
| Initiation |1..1 |OBWriteDomesticStandingOrder3/Data/Initiation |The Initiation payload is sent by the initiating party to the ASPSP. It is used to request movement of funds from the debtor account to a creditor for a domestic standing order. |OBDomesticStandingOrder3 | | |
| Risk |1..1 |OBWriteDomesticStandingOrder3/Risk |The Risk section is sent by the initiating party to the ASPSP. It is used to specify additional details for risk scoring for Payments. |OBRisk1 | | |

### Domestic Standing Order - Response

The OBWriteDomesticStandingOrderResponse4 object will be used for a response to a call to:

* POST /domestic-standing-orders
* GET /domestic-standing-orders/{DomesticStandingOrderId}

#### UML Diagram

![Domestic Standing Order - Response](images/OBWriteDomesticStandingOrderResponse4.png)

#### Notes

The domestic-standing-order **response** object contains the:

* DomesticStandingOrderId.
* ConsentId.
* CreationDateTime the domestic-standing-order resource was created.
* Status and StatusUpdateDateTime of the domestic-standing-order resource.
* Charges array - for the breakdown of applicable ASPSP charges.
* The Initiation object from the domestic-standing-order-consent.
* The MultiAuthorisation object if the domestic-standing-order resource requires multiple authorisations.

#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| ---- |---------- |----- |------------------ |----- |----- |------- |
| OBWriteDomesticStandingOrderResponse4 | |OBWriteDomesticStandingOrderResponse4 | |OBWriteDomesticStandingOrderResponse4 | | |
| Data |1..1 |OBWriteDomesticStandingOrderResponse4/Data | |OBWriteDataDomesticStandingOrderResponse4 | | |
| DomesticStandingOrderId |1..1 |OBWriteDomesticStandingOrderResponse4/Data/DomesticStandingOrderId |OB: Unique identification as assigned by the ASPSP to uniquely identify the domestic standing order resource. |Max40Text | | |
| ConsentId |1..1 |OBWriteDomesticStandingOrderResponse4/Data/ConsentId |OB: Unique identification as assigned by the ASPSP to uniquely identify the consent resource. |Max128Text | | |
| CreationDateTime |1..1 |OBWriteDomesticStandingOrderResponse4/Data/CreationDateTime |Date and time at which the resource was created. |ISODateTime | | |
| Status |1..1 |OBWriteDomesticStandingOrderResponse4/Data/Status |Specifies the status of the payment order resource. |OBExternalStatus1Code |InitiationCompleted InitiationFailed InitiationPending Cancelled | |
| StatusUpdateDateTime |1..1 |OBWriteDomesticStandingOrderResponse4/Data/StatusUpdateDateTime |Date and time at which the resource status was updated. |ISODateTime | | |
| Charges |0..n |OBWriteDomesticStandingOrderResponse4/Data/Charges |Set of elements used to provide details of a charge for the payment initiation. |OBCharge2 | | |
| Initiation |1..1 |OBWriteDomesticStandingOrderResponse4/Data/Initiation |The Initiation payload is sent by the initiating party to the ASPSP. It is used to request movement of funds from the debtor account to a creditor for a domestic standing order. |OBDomesticStandingOrder3 | | |
| MultiAuthorisation |0..1 |OBWriteDomesticStandingOrderResponse4/Data/MultiAuthorisation | |OBMultiAuthorisation1 | | |

### Domestic Standing Order - Payment Details - Response

The OBWritePaymentDetailsResponse1 object will be used for a response to a call to:

* GET /domestic-standing-orders/{DomesticStandingOrderId}/payment-details

#### UML Diagram

![Domestic Standing Order - Payment Details - Response](images/OBWritePaymentDetailsResponse1.png)

#### Data Dictionary

| Name |Occurrence |XPath |EnhancedDefinition |Class |Codes |Pattern |
| ---- |---------- |----- |------------------ |----- |----- |------- |
| OBWritePaymentDetailsResponse1 | |OBWritePaymentDetailsResponse1 | |OBWritePaymentDetailsResponse1 | | |
| Data |1..1 |OBWritePaymentDetailsResponse1/Data | |OBWriteDataPaymentOrderStatusResponse1 | | |
| PaymentStatus |0..unbounded |OBWritePaymentDetailsResponse1/Data/PaymentStatus |Payment status details. |OBWritePaymentDetails1 | | |

## Usage Examples

### Create a Domestic Standing Order

#### POST /domestic-standing-orders request

```
POST /domestic-standing-orders HTTP/1.1
Authorization: Bearer eYJQLMQLMQLM
x-idempotency-key: FRESNO.1317.GFX.22
x-jws-signature: TGlmZSdzIGEgam91cm5leSBub3QgYSBkZXN0aW5hdGlvbiA=..T2ggZ29vZCBldmVuaW5nIG1yIHR5bGVyIGdvaW5nIGRvd24gPw==
x-fapi-auth-date:  Sun, 10 Sep 2017 19:43:31 GMT
x-fapi-customer-ip-address: 104.25.212.99
x-fapi-interaction-id: 93bac548-d2de-4546-b106-880a5018460d
Content-Type: application/json
Accept: application/json
```

```json
{
  "Data": {
	"ConsentId": "SOC-100",
    "Initiation": {
	  "Frequency": "EvryDay",
	  "Reference": "Pocket money for Damien",
	  "FirstPaymentDateTime": "1976-06-06T06:06:06+00:00",
	  "FirstPaymentAmount": {
        "Amount": "6.66",
        "Currency": "GBP"
	  },
	  "RecurringPaymentAmount": {
        "Amount": "7.00",
        "Currency": "GBP"
	  },
	  "FinalPaymentDateTime": "1981-03-20T06:06:06+00:00",
	  "FinalPaymentAmount": {
        "Amount": "7.00",
        "Currency": "GBP"
	  },
      "DebtorAccount": {
        "SchemeName": "UK.OBIE.SortCodeAccountNumber",
        "Identification": "11280001234567",
        "Name": "Andrea Smith"
      },
      "CreditorAccount": {
        "SchemeName": "UK.OBIE.SortCodeAccountNumber",
        "Identification": "08080021325698",
        "Name": "Bob Clements"
      }
    }
  },
  "Risk": {
    "PaymentContextCode": "PartyToParty"
  }
}

```

#### POST /domestic-standing-orders response

```
HTTP/1.1 201 Created
x-jws-signature: V2hhdCB3ZSBnb3QgaGVyZQ0K..aXMgZmFpbHVyZSB0byBjb21tdW5pY2F0ZQ0K
x-fapi-interaction-id: 93bac548-d2de-4546-b106-880a5018460d
Content-Type: application/json
```

```json
{
  "Data": {
	"DomesticStandingOrderId": "SO-SOC-100",
	"ConsentId": "SOC-100",
	"CreationDateTime": "1976-01-01T06:06:06+00:00",
	"Status": "InitiationCompleted",
	"StatusUpdateDateTime": "1976-06-06T06:06:06+00:00",
    "Initiation": {
	  "Frequency": "EvryDay",
	  "Reference": "Pocket money for Damien",
	  "FirstPaymentDateTime": "1976-06-06T06:06:06+00:00",
	  "FirstPaymentAmount": {
        "Amount": "6.66",
        "Currency": "GBP"
	  },
	  "RecurringPaymentAmount": {
        "Amount": "7.00",
        "Currency": "GBP"
	  },
	  "FinalPaymentDateTime": "1981-03-20T06:06:06+00:00",
	  "FinalPaymentAmount": {
        "Amount": "7.00",
        "Currency": "GBP"
	  },
      "DebtorAccount": {
        "SchemeName": "UK.OBIE.SortCodeAccountNumber",
        "Identification": "11280001234567",
        "Name": "Andrea Smith"
      },
      "CreditorAccount": {
        "SchemeName": "UK.OBIE.SortCodeAccountNumber",
        "Identification": "08080021325698",
        "Name": "Bob Clements"
      }
    }
  },
  "Risk": {
    "PaymentContextCode": "PartyToParty"
  },
  "Links": {
    "Self": "https://api.alphabank.com/open-banking/v3.1/pisp/domestic-standing-orders/SO-SOC-100"
  },
  "Meta": {}
}
```
