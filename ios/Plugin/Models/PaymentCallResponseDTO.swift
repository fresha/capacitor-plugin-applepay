//
//  PaymentCallResponseDTO.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation
import PassKit

struct PaymentTokenDTO: Encodable {
    let transactionIdentifier: String
    /// base64 encoded data
    let paymentData: String
    let paymentMethod: PaymentMethodDTO?

    init (with pkPaymenToken: PKPaymentToken) {
        self.transactionIdentifier = pkPaymenToken.transactionIdentifier
        self.paymentData = pkPaymenToken.paymentData.base64EncodedString()
        self.paymentMethod = PaymentMethodDTO(with: pkPaymenToken.paymentMethod)
    }
}

struct BillingContactDTO: Encodable {
    let emailAddress: String?
    let postalAddess: PostalAddressDTO?
    let phoneNumber: String?
    let name: NameDTO?

    init(with pkContact: PKContact?) {
        self.emailAddress = pkContact?.emailAddress
        self.postalAddess = PostalAddressDTO(with: pkContact?.postalAddress)
        self.phoneNumber = pkContact?.phoneNumber?.stringValue
        self.name = NameDTO(with: pkContact?.name)
    }
}

typealias ShippingContactDTO = BillingContactDTO

struct NameDTO: Encodable {
    public let namePrefix: String?
    public let givenName: String?
    public let middleName: String?
    public let familyName: String?
    public let nameSuffix: String?
    public let nickname: String?

    init(with nameComponents: PersonNameComponents?) {
        self.namePrefix = nameComponents?.namePrefix
        self.givenName = nameComponents?.givenName
        self.middleName = nameComponents?.middleName
        self.familyName = nameComponents?.familyName
        self.nameSuffix = nameComponents?.nameSuffix
        self.nickname = nameComponents?.nickname
    }
}

struct PaymentMethodDTO: Encodable {
    let displayName: String?
    let network: String?
    let billingAddress: AddressDTO?

    init (with pkPaymentMethod: PKPaymentMethod) {
        self.displayName = pkPaymentMethod.displayName
        self.network = pkPaymentMethod.network?.rawValue
        if #available(iOS 13.0, *) {
            self.billingAddress = AddressDTO(with: pkPaymentMethod.billingAddress)
        } else {
            self.billingAddress = nil
        }
    }
}

struct AddressDTO: Encodable {
    let namePrefix: String?
    let givenName: String?
    let middleName: String?
    let familyName: String?
    let nameSuffix: String?
    let nickname: String?

    init(with cnContact: CNContact?) {
        self.namePrefix = cnContact?.namePrefix
        self.givenName = cnContact?.givenName
        self.middleName = cnContact?.middleName
        self.familyName = cnContact?.familyName
        self.nameSuffix = cnContact?.nameSuffix
        self.nickname = cnContact?.nickname
    }
}

struct PostalAddressDTO: Encodable {
    let street: String?
    let subLocality: String?
    let city: String?
    let subAdministrativeArea: String?
    let state: String?
    let postalCode: String?
    let country: String?
    let isoCountryCode: String?

    init(with cnPostalAddress: CNPostalAddress?) {
        self.street = cnPostalAddress?.street
        self.subLocality = cnPostalAddress?.subLocality
        self.city = cnPostalAddress?.city
        self.subAdministrativeArea = cnPostalAddress?.subAdministrativeArea
        self.state = cnPostalAddress?.state
        self.postalCode = cnPostalAddress?.postalCode
        self.country = cnPostalAddress?.country
        self.isoCountryCode = cnPostalAddress?.isoCountryCode
    }
}

struct PaymentCallResponseDTO: Encodable {
    let token: PaymentTokenDTO
    let billingContact: BillingContactDTO?
    let shippingContact: ShippingContactDTO?
    let shippingMethod: ShippingMethodDTO?

    init(with pkPayment: PKPayment) {
        self.token = PaymentTokenDTO(with: pkPayment.token)
        self.billingContact = BillingContactDTO(with: pkPayment.billingContact)
        self.shippingContact = ShippingContactDTO(with: pkPayment.shippingContact)
        self.shippingMethod = ShippingMethodDTO(with: pkPayment.shippingMethod)
    }
}
