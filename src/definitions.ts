export declare type PaymentNetwork =
  | 'amex'
  | 'chinaUnionPay'
  | 'cartesBancaires'
  | 'discover'
  | 'eftpos'
  | 'electron'
  | 'idCredit'
  | 'interac'
  | 'JCB'
  | 'maestro'
  | 'masterCard'
  | 'privateLabel'
  | 'quicPay'
  | 'suica'
  | 'visa'
  | 'vPay'
  | 'mada';

export declare type PaymentSummaryItemType = 'pending' | 'final';
export declare type ContactField =
  | 'emailAddress'
  | 'name'
  | 'phoneNumber'
  | 'phoneticName'
  | 'postalAddress';
export declare type MerchantCapability =
  | 'capability3DS'
  | 'capabilityCredit'
  | 'capabilityDebit'
  | 'capabilityEMV';

export declare type PaymentCompletionStatus = 'success' | 'failure';

export interface CanMakePaymentsRequest {
  networks: PaymentNetwork[];
  capabilities?: MerchantCapability[];
}

export interface PersonNameComponents {
  familyName?: string;
  givenName?: string;
  namePrefix?: string;
  middleName?: string;
  nameSuffix?: string;
  nickname?: string;
}

export interface PaymentSummaryItem {
  label: string;
  amount: string;
  type?: PaymentSummaryItemType;
}

export interface PaymentContact {
  emailAddress: string;
  phoneNumber?: string;
  name?: PersonNameComponents;
  postalAddress?: {
    street?: string;
    city?: string;
    postalCode?: string;
    country?: string;
    isoCountryCode?: string;
    subAdministrativeArea?: string;
    subLocality?: string;
  };
}

export interface InitiatePaymentRequest {
  merchantIdentifier: string;
  countryCode: string;
  currencyCode: string;
  supportedCountries?: string[];
  supportedNetworks?: PaymentNetwork[];
  summaryItems: PaymentSummaryItem[];
  requiredShippingContactFields?: ContactField[];
  requiredBillingContactFields?: ContactField[];
  merchantCapabilities?: MerchantCapability[];
  billingContact?: PaymentContact;
  shippingContact?: PaymentContact;
}

export interface CompletePaymentRequest {
  status: PaymentCompletionStatus;
}

export interface InitiatePaymentResponse {
  token: {
    paymentData?: string;
    transactionIdentifier: string;
    paymentMethod: {
      displayName?: string;
      secureElementPass?: {
        deviceAccountNumberSuffix: string;
        deviceAccountIdentifier: string;
        primaryAccountIdentifier: string;
        primaryAccountNumberSuffix: string;
        devicePassIdentifier?: string;
        pairedTerminalIdentifier?: string;
      };
    };
  };
  billingContact?: PaymentContact;
  shippingContact?: PaymentContact;
}

export interface CanMakePaymentsResponse {
  canMakePayments: boolean;
}

export interface ApplePayPlugin {
  /**
   * Indicates whether the device supports Apple Pay.
   * @returns CanMakePaymentsResponse with boolean determining if the device supports making payments with Apple Pay
   */
  canMakePayments(): Promise<CanMakePaymentsResponse>;

  /**
   * Indicates whether the device supports Apple Pay and whether the user has an active card.
   * This allows more granular control than regular `canMakePayments()`
   * @param options - Supported networks and capabilities
   * @returns Promise<CanMakePaymentsResponse> with boolean that determines if the device supports
   * Apple Pay and there is at least one active card in Wallet that is qualified for payments on the web.
   */
  canMakePayments(
    options: CanMakePaymentsRequest,
  ): Promise<CanMakePaymentsResponse>;

  /**
   * Initiates a payment base on PaymentRequest object.
   * @param request - PaymentRequest object that will be used for the payment.
   * @returns Promise<PaymentResponse> containing token and additional data.
   * Promise will be rejected in case of errors, or when the flow is interrupted.
   */
  initiatePayment(request: InitiatePaymentRequest): Promise<InitiatePaymentResponse>;

  /**
   * Completes current payment
   * @param request - CompletePaymentRequest object containing status
   * @returns Promise<void> that will be resolved on success and rejected on failure.
   */
  completeLastPayment(request: CompletePaymentRequest): Promise<void>;
}
