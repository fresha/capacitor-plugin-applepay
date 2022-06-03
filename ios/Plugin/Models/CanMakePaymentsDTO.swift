//
//  CanMakePaymentsCall.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation

public class CanMakePaymentsDTO: NSObject, Codable {
    let networks: [String]?
    let capabilities: [String]?

    init(networks: [String]? = nil, capabilities: [String]? = nil) {
        self.networks = networks
        self.capabilities = capabilities
    }
}
