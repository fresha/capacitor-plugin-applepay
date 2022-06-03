//
//  PaymentCallError.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation

enum PaymentError: Error, LocalizedError, Encodable {
    case sheetClosed
    case couldNotPresentSheet
    case paymentNotStarted
    case couldNotParsePaymentCompletionStatus

    var errorDescription: String? {
        switch self {
        case .sheetClosed:
            return "User dismissed the sheet with X button."
        case .couldNotPresentSheet:
            return "Could not present payment sheet."
        case .paymentNotStarted:
            return "Payment not started."
        case .couldNotParsePaymentCompletionStatus:
            return "Could not create payment completion Status"
        }
    }
}
