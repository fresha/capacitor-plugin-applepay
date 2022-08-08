//
//  ApplePayService.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation
import PassKit

typealias PaymentInitHandler = (Result<PaymentCallResponseDTO, PaymentError>) -> Void
typealias PaymentCompletionHandler = (Result<Void, PaymentError>) -> Void

class ApplePayService: NSObject {

    private var paymentInitHandler: PaymentInitHandler?
    private var paymentCompletionHandler: ((PKPaymentAuthorizationResult) -> Void)?

    public func canMakePayments(callPayload: CanMakePaymentsDTO) -> Bool {
        if  let networks = callPayload.networks,
            let capabilities = callPayload.capabilities {

            let pkNetworks = PKPaymentNetwork.fromStringArray(networks: networks)
            let pkCapabilities = PKMerchantCapability(capabilities: capabilities)

            return PKPaymentAuthorizationController.canMakePayments(usingNetworks: pkNetworks,
                                                                    capabilities: pkCapabilities)
        }

        if  let networks = callPayload.networks {
            let pkNetworks = PKPaymentNetwork.fromStringArray(networks: networks)

            return PKPaymentAuthorizationController.canMakePayments(usingNetworks: pkNetworks)
        }
        return PKPaymentAuthorizationController.canMakePayments()
    }

    public func initiatePayment(callPayload: InitiatePaymentDTO, resultHandler: @escaping PaymentInitHandler) {
        self.paymentInitHandler = resultHandler
        let request = callPayload.toPKPaymentRequest()
        let paymentController = PKPaymentAuthorizationController(paymentRequest: request)
        paymentController.delegate = self
        DispatchQueue.main.async {
            paymentController.present { [weak self] (presented) in
                if !presented {
                    self?.paymentInitHandler?(.failure(.couldNotPresentSheet))
                }
            }
        }
    }

    public func completeLastPayment(callPayload: CompletePaymentDTO,
                                    resultHandler: @escaping PaymentCompletionHandler) {
        guard let paymentCompletionHandler = self.paymentCompletionHandler else {
            resultHandler(.failure(.paymentNotStarted))
            return
        }

        guard let result = callPayload.toPKResult() else {
            resultHandler(.failure(.couldNotParsePaymentCompletionStatus))
            return
        }
        resultHandler(.success(()))
        DispatchQueue.main.async {
            paymentCompletionHandler(result)
        }
        self.paymentCompletionHandler = nil
    }
}

// MARK: - PKPaymentAuthorizationControllerDelegate
extension ApplePayService: PKPaymentAuthorizationControllerDelegate {

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        self.paymentInitHandler?(.failure(.sheetClosed))
        controller.dismiss()
    }

    func presentationWindow(for controller: PKPaymentAuthorizationController) -> UIWindow? {
        return UIApplication.shared.keyWindow
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController,
                                        didAuthorizePayment payment: PKPayment,
                                        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let response = PaymentCallResponseDTO(with: payment)
        self.paymentInitHandler?(.success(response))
        // Reset handler, so it won't be called again for paymentAuthorizationControllerDidFinish
        self.paymentInitHandler = nil
        self.paymentCompletionHandler = completion
    }
}
