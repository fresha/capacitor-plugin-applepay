# @fresha/capacitor-plugin-applepay

[![npm version](https://badge.fury.io/js/@fresha%2Fcapacitor-plugin-applepay.svg)](https://www.npmjs.com/package/@fresha/capacitor-plugin-applepay)

This Apple Pay plugin provides interfaces that allow you to initiate an Apple Pay payment sheet based on provided PaymentRequest.
When transaction is authorized, Payment response is returned along with payment details and more importantly- a payment token that you should pass to your backend.

## Install

```bash
npm install @fresha/capacitor-plugin-applepay
npx cap sync
```

## Configuration

Before using this plugin, make sure that your project is correctly configured. Usually your Payment Services Processor will provide detailed instructions, so please read their docs first.

### Apple Developer Portal:

- Add your Merchant identifier
- Contact with your PSP who will generate CSR that you should pass into `Apple Pay Payment Processing Certificate`
- Send the generated certificate to your PSP
- Edit your App Identifier, add Apple Pay Payment Processing capability, select previously created merchant ID.
- Renew your provisioning profiles

### Xcode

- Add Apple Pay capability
- Select previously created merchant identifier
- Make sure you are using renewed provisioning profiles

## API

<docgen-index>

- [`canMakePayments()`](#canmakepayments)
- [`canMakePayments(...)`](#canmakepayments)
- [`initiatePayment(...)`](#initiatepayment)
- [`completeLastPayment(...)`](#completelastpayment)
- [Interfaces](#interfaces)
- [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### canMakePayments()

```typescript
canMakePayments() => Promise<CanMakePaymentsResponse>
```

Indicates whether the device supports Apple Pay.

**Returns:** <code>Promise&lt;<a href="#canmakepaymentsresponse">CanMakePaymentsResponse</a>&gt;</code>

---

### canMakePayments(...)

```typescript
canMakePayments(options: CanMakePaymentsRequest) => Promise<CanMakePaymentsResponse>
```

Indicates whether the device supports Apple Pay and whether the user has an active card.
This allows more granular control than regular `canMakePayments()`

| Param         | Type                                                                      | Description                           |
| ------------- | ------------------------------------------------------------------------- | ------------------------------------- |
| **`options`** | <code><a href="#canmakepaymentsrequest">CanMakePaymentsRequest</a></code> | - Supported networks and capabilities |

**Returns:** <code>Promise&lt;<a href="#canmakepaymentsresponse">CanMakePaymentsResponse</a>&gt;</code>

---

### initiatePayment(...)

```typescript
initiatePayment(request: InitiatePaymentRequest) => Promise<InitiatePaymentResponse>
```

Initiates a payment base on PaymentRequest object.

| Param         | Type                                                                      | Description                                                |
| ------------- | ------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **`request`** | <code><a href="#initiatepaymentrequest">InitiatePaymentRequest</a></code> | - PaymentRequest object that will be used for the payment. |

**Returns:** <code>Promise&lt;<a href="#initiatepaymentresponse">InitiatePaymentResponse</a>&gt;</code>

---

### completeLastPayment(...)

```typescript
completeLastPayment(request: CompletePaymentRequest) => Promise<void>
```

Completes current payment

| Param         | Type                                                                      | Description                                                                             |
| ------------- | ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| **`request`** | <code><a href="#completepaymentrequest">CompletePaymentRequest</a></code> | - <a href="#completepaymentrequest">CompletePaymentRequest</a> object containing status |

---

### Interfaces

#### CanMakePaymentsResponse

| Prop                  | Type                 |
| --------------------- | -------------------- |
| **`canMakePayments`** | <code>boolean</code> |

#### CanMakePaymentsRequest

| Prop                | Type                              |
| ------------------- | --------------------------------- |
| **`usingNetworks`** | <code>PaymentNetwork[]</code>     |
| **`capabilities`**  | <code>MerchantCapability[]</code> |

#### InitiatePaymentResponse

| Prop                  | Type                                                                                                                                                                                                                                                                                                                                                 |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`token`**           | <code>{ paymentData?: string; transactionIdentifier: string; paymentMethod: { displayName?: string; secureElementPass?: { deviceAccountNumberSuffix: string; deviceAccountIdentifier: string; primaryAccountIdentifier: string; primaryAccountNumberSuffix: string; devicePassIdentifier?: string; pairedTerminalIdentifier?: string; }; }; }</code> |
| **`billingContact`**  | <code><a href="#paymentcontact">PaymentContact</a></code>                                                                                                                                                                                                                                                                                            |
| **`shippingContact`** | <code><a href="#paymentcontact">PaymentContact</a></code>                                                                                                                                                                                                                                                                                            |

#### PaymentContact

| Prop                | Type                                                                                                                                                                   |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`emailAddress`**  | <code>string</code>                                                                                                                                                    |
| **`phoneNumber`**   | <code>string</code>                                                                                                                                                    |
| **`name`**          | <code><a href="#personnamecomponents">PersonNameComponents</a></code>                                                                                                  |
| **`postalAddress`** | <code>{ street?: string; city?: string; postalCode?: string; country?: string; isoCountryCode?: string; subAdministrativeArea?: string; subLocality?: string; }</code> |

#### PersonNameComponents

| Prop             | Type                |
| ---------------- | ------------------- |
| **`familyName`** | <code>string</code> |
| **`givenName`**  | <code>string</code> |
| **`namePrefix`** | <code>string</code> |
| **`middleName`** | <code>string</code> |
| **`nameSuffix`** | <code>string</code> |
| **`nickname`**   | <code>string</code> |

#### InitiatePaymentRequest

| Prop                                | Type                                                      |
| ----------------------------------- | --------------------------------------------------------- |
| **`merchantIdentifier`**            | <code>string</code>                                       |
| **`countryCode`**                   | <code>string</code>                                       |
| **`currencyCode`**                  | <code>string</code>                                       |
| **`supportedCountries`**            | <code>string[]</code>                                     |
| **`supportedNetworks`**             | <code>PaymentNetwork[]</code>                             |
| **`summaryItems`**                  | <code>PaymentSummaryItem[]</code>                         |
| **`requiredShippingContactFields`** | <code>ContactField[]</code>                               |
| **`requiredBillingContactFields`**  | <code>ContactField[]</code>                               |
| **`merchantCapabilities`**          | <code>MerchantCapability[]</code>                         |
| **`billingContact`**                | <code><a href="#paymentcontact">PaymentContact</a></code> |
| **`shippingContact`**               | <code><a href="#paymentcontact">PaymentContact</a></code> |

#### PaymentSummaryItem

| Prop         | Type                                                                      |
| ------------ | ------------------------------------------------------------------------- |
| **`label`**  | <code>string</code>                                                       |
| **`amount`** | <code>string</code>                                                       |
| **`type`**   | <code><a href="#paymentsummaryitemtype">PaymentSummaryItemType</a></code> |

#### CompletePaymentRequest

| Prop         | Type                                                                        |
| ------------ | --------------------------------------------------------------------------- |
| **`status`** | <code><a href="#paymentcompletionstatus">PaymentCompletionStatus</a></code> |

### Type Aliases

#### PaymentNetwork

<code>'amex' | 'chinaUnionPay' | 'cartesBancaires' | 'discover' | 'eftpos' | 'electron' | 'idCredit' | 'interac' | 'JCB' | 'maestro' | 'masterCard' | 'privateLabel' | 'quicPay' | 'suica' | 'visa' | 'vPay'</code>

#### MerchantCapability

<code>'capability3DS' | 'capabilityCredit' | 'capabilityDebit' | 'capabilityEMV'</code>

#### PaymentSummaryItemType

<code>'pending' | 'final'</code>

#### ContactField

<code>'emailAddress' | 'name' | 'phoneNumber' | 'phoneticName' | 'postalAddress'</code>

#### PaymentCompletionStatus

<code>'success' | 'failure'</code>

</docgen-api>
