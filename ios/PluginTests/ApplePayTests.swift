import XCTest
@testable import Plugin

class ApplePayTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCanMakePayments() {
        let implementation = ApplePayService()
        let canMakePaymentsCall = CanMakePaymentsDTO(networks: ["mastercard"], capabilities: ["capability3DS"])
        let result = implementation.canMakePayments(callPayload: canMakePaymentsCall)

        XCTAssertEqual(true, result)
    }

    func testInitiatePayment() {
        let callJSON = """
            {
             "summaryItems": [
                    {
                        "label": "item",
                        "amount": "2.0",
                        "type": "final",
                    }
                ],
                "merchantIdentifier": "merchant.com.adyen.freshaeu.test",
                "merchantCapabilities": ["capability3DS"],
                "countryCode": "PL",
                "currencyCode": "PLN",
                "supportedNetworks": ["mastercard", "visa"],
                "requiredBillingContactFields": ["name", "phoneNumber", "phoneticName", "postalAddress"]
            }
        """
        let initializeCall = try! JSONDecoder().decode(InitiatePaymentDTO.self,
                                                       from: callJSON.data(using: .utf8)!)

        XCTAssertEqual(initializeCall.merchantIdentifier, "merchant.com.adyen.freshaeu.test")
        XCTAssertEqual(initializeCall.merchantCapabilities, ["capability3DS"])
        XCTAssertEqual(initializeCall.countryCode, "PL")
        XCTAssertEqual(initializeCall.currencyCode, "PLN")
        XCTAssertEqual(initializeCall.supportedNetworks, ["mastercard", "visa"])
        XCTAssertEqual(initializeCall.requiredBillingContactFields, ["name",
                                                                     "phoneNumber",
                                                                     "phoneticName",
                                                                     "postalAddress"])
        XCTAssertNil(initializeCall.requiredShippingContactFields)
        XCTAssertEqual(initializeCall.summaryItems.count, 1)

        let expectedObject = SummaryItemDTO(label: "item", amount: "2.0", type: "final")
        let parsedObject = initializeCall.summaryItems.first!
        XCTAssertEqual(parsedObject.amount, expectedObject.amount)
        XCTAssertEqual(parsedObject.label, expectedObject.label)
        XCTAssertEqual(parsedObject.type, expectedObject.type)
    }
}
