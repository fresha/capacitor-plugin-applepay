/* eslint-disable @typescript-eslint/no-unused-vars */
import { WebPlugin } from '@capacitor/core';

import type {
  ApplePayPlugin,
  CanMakePaymentsRequest,
  CanMakePaymentsResponse,
  CompletePaymentRequest,
  InitiatePaymentRequest,
  InitiatePaymentResponse,
} from './definitions';

export class ApplePayWeb extends WebPlugin implements ApplePayPlugin {
  canMakePayments(): Promise<CanMakePaymentsResponse>;
  canMakePayments(
    options: CanMakePaymentsRequest,
  ): Promise<CanMakePaymentsResponse>;
  canMakePayments(_options?: any): boolean | Promise<CanMakePaymentsResponse> {
    throw new Error('Method not implemented.');
  }

  initiatePayment(
    _request: InitiatePaymentRequest,
  ): Promise<InitiatePaymentResponse> {
    throw new Error('Method not implemented.');
  }

  completeLastPayment(_request: CompletePaymentRequest): Promise<void> {
    throw new Error('Method not implemented.');
  }
}
