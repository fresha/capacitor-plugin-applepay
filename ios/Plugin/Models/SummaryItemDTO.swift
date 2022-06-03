//
//  SummaryItemDTO.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 06/06/2022.
//  Copyright © 2022 Max Lynch. All rights reserved.
//

import PassKit

public class ShippingMethodDTO: Codable {

    let identifier: String?
    let detail: String?

    init(with shippingMethod: PKShippingMethod?) {
        self.identifier = shippingMethod?.identifier
        self.detail = shippingMethod?.detail
    }

    func toPKShippingMethod() -> PKShippingMethod {

        let method = PKShippingMethod()
        method.identifier = self.identifier
        method.detail = self.detail
        return method
    }
}

public class SummaryItemDTO: NSObject, Codable {
    let label: String
    let amount: String
    var type: String? = "final"

    init(label: String, amount: String, type: String) {
        self.label = label
        self.amount = amount
        self.type = type
    }

    func toPKPaymentSummaryItem() -> PKPaymentSummaryItem {
        let type: PKPaymentSummaryItemType = {
            switch self.type {
            case "pending":
                return .pending
            default:
                return .final
            }
        }()

        return PKPaymentSummaryItem(label: self.label,
                                    amount: NSDecimalNumber(string: self.amount),
                                    type: type)
    }
}
