//
//  CompletePaymentDTO.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 10/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation
import PassKit

public class CompletePaymentDTO: NSObject, Codable {
    let status: String?

    func toPKResult() -> PKPaymentAuthorizationResult? {
        switch status {
        case "success":
            return PKPaymentAuthorizationResult(status: .success, errors: nil)
        case "failure":
            return PKPaymentAuthorizationResult(status: .failure, errors: nil)
        default:
            return nil
        }
    }
}
