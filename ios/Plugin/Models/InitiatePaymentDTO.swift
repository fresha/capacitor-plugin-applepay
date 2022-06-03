//
//  InitiatePaymentDTO.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation
import PassKit

public class InitiatePaymentDTO: NSObject, Codable {
    let summaryItems: [SummaryItemDTO]
    let merchantIdentifier: String
    let merchantCapabilities: [String]
    let countryCode: String
    let currencyCode: String
    let supportedNetworks: [String]
    let requiredShippingContactFields: [String]?
    let requiredBillingContactFields: [String]?
    let shippingMethods: [ShippingMethodDTO]?
}

extension InitiatePaymentDTO {
    func toPKPaymentRequest() -> PKPaymentRequest {

        let pkItems = self.summaryItems.map { $0.toPKPaymentSummaryItem() }
        let pkShippingMethods = self.shippingMethods?.map({ method in
            method.toPKShippingMethod()
        })

        let merchantCapabilities = PKMerchantCapability(capabilities: self.merchantCapabilities)
        let networks = PKPaymentNetwork.fromStringArray(networks: self.supportedNetworks)
        let shippingContact = PKContactField.fromStringArray(fields: requiredShippingContactFields ?? [])
        let billingContact = PKContactField.fromStringArray(fields: requiredBillingContactFields ?? [])
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = pkItems
        paymentRequest.merchantIdentifier = self.merchantIdentifier
        paymentRequest.merchantCapabilities = merchantCapabilities
        paymentRequest.countryCode = self.countryCode
        paymentRequest.currencyCode = self.currencyCode
        paymentRequest.supportedNetworks = networks
        paymentRequest.requiredShippingContactFields = shippingContact
        paymentRequest.requiredBillingContactFields = billingContact
        paymentRequest.shippingMethods = pkShippingMethods
        return paymentRequest
    }
}
