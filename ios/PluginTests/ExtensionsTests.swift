//
//  ExtensionsTests.swift
//  PluginTests
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import XCTest
import PassKit

class ExtensionsTests: XCTestCase {

    func testPKPaymentNetworkFromString() throws {
        let visaNetwork = PKPaymentNetwork.fromString(network: "visa")
        XCTAssertEqual(visaNetwork, PKPaymentNetwork.visa)

        let masterCardNetwork = PKPaymentNetwork.fromString(network: "mastercard")
        XCTAssertEqual(masterCardNetwork, PKPaymentNetwork.masterCard)

        let amexNetwork = PKPaymentNetwork.fromString(network: "amex")
        XCTAssertEqual(amexNetwork, PKPaymentNetwork.amex)

        let unknownNetwork = PKPaymentNetwork.fromString(network: "unknownNetwork")
        XCTAssertNil(unknownNetwork)
    }

    func testPKPaymentNetworkFromStringArray() throws {
        let stringNetworks = ["Visa", "Mastercard", "Amex"]
        let pkNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]

        let resolvedNetworks = PKPaymentNetwork.fromStringArray(networks: stringNetworks)

        let pkSet = Set(pkNetworks)
        let resolvedSet = Set(resolvedNetworks)

        XCTAssert(pkSet.count == resolvedSet.count)
        XCTAssertEqual(pkSet, resolvedSet)
    }

    func testPKPaymentNetworkFromStringArrayWillFail() throws {
        let stringNetworks = ["Visa", "Mastercard", "Unknown"]
        let pkNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]

        let resolvedNetworks = PKPaymentNetwork.fromStringArray(networks: stringNetworks)

        let pkSet = Set(pkNetworks)
        let resolvedSet = Set(resolvedNetworks)

        XCTAssert(pkSet.count != resolvedSet.count)
        XCTAssertNotEqual(pkSet, resolvedSet)
    }

    func testPKMerchantCapabilityFromStringArray() throws {
        var expectedCapabilities: PKMerchantCapability = PKMerchantCapability()
        expectedCapabilities.insert(.capabilityCredit)
        expectedCapabilities.insert(.capabilityEMV)
        expectedCapabilities.insert(.capabilityDebit)
        expectedCapabilities.insert(.capability3DS)

        let stringCapabilities = ["capability3DS", "capabilityemv", "capabilityCredit", "capabilitydebit"]
        let resolvedCapability = PKMerchantCapability(capabilities: stringCapabilities)

        XCTAssertEqual(expectedCapabilities, resolvedCapability)

        let emptyCapability = PKMerchantCapability()

        XCTAssertNotEqual(emptyCapability, resolvedCapability)
    }

    func testPKContactFieldFromString() throws {
        XCTAssertEqual(PKContactField.name, PKContactField(field: "name"))
        XCTAssertEqual(PKContactField.phoneNumber, PKContactField(field: "phoneNumber"))
        XCTAssertEqual(PKContactField.phoneticName, PKContactField(field: "phoneticName"))
        XCTAssertEqual(PKContactField.postalAddress, PKContactField(field: "postaladdress"))
        XCTAssertEqual(PKContactField.emailAddress, PKContactField(field: "emailAddress"))

        XCTAssertNotEqual(PKContactField.emailAddress, PKContactField(field: "noSuch Field"))
        XCTAssertNil(PKContactField(field: "shouldReturnNilForMissingField"))

    }

    func testPKContactFieldFromStringArray() throws {
        let stringFields = ["name", "phoneNumber", "phoneticName", "postalAddress", "emailAddress"]
        let pkFields: [PKContactField] = [.name, .phoneNumber, .phoneticName, .postalAddress, .emailAddress]

        let resolvedFields = PKContactField.fromStringArray(fields: stringFields)
        XCTAssertEqual(Set(pkFields), resolvedFields)

        let emptyResolvedFields = PKContactField.fromStringArray(fields: [])
        XCTAssertEqual(Set(), emptyResolvedFields)

        let unknownFields = ["This should", "Return", "empty", "array"]
        let expectedFieldsFromUknown: [PKContactField] = []
        let resolvedUnknownFields = PKContactField.fromStringArray(fields: unknownFields)
        XCTAssertEqual(Set(expectedFieldsFromUknown), resolvedUnknownFields)
    }
}
