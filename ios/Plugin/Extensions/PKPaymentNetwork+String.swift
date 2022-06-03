//
//  PKPaymentNetwork+String.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import PassKit

extension PKPaymentNetwork {
    public static var allCases: [PKPaymentNetwork] {
        var networks: [PKPaymentNetwork] = [
            .amex,
            .cartesBancaires,
            .chinaUnionPay,
            .discover,
            .eftpos,
            .electron,
            .idCredit,
            .interac,
            .JCB,
            .maestro,
            .masterCard,
            .privateLabel,
            .quicPay,
            .suica,
            .visa,
            .vPay
        ]

        if #available(iOS 12.1.1, *) {
            networks.append(.elo)
            networks.append(.mada)
        }

        if #available(iOS 14.0, *) {
            networks.append(.barcode)
            networks.append(.girocard)
        }

        if #available(iOS 14.5, *) {
            networks.append(.mir)
        }

        if #available(iOS 15.0, *) {
            networks.append(.waon)
            networks.append(.nanaco)
        }

        return networks
    }

    static func fromString(network: String) -> PKPaymentNetwork? {
        let matchingNetworks =  Self.allCases.compactMap({ pkNetwork in
            return pkNetwork.rawValue.lowercased() == network.lowercased() ? pkNetwork : nil
        })
        return matchingNetworks.first
    }

    static func fromStringArray(networks: [String]) -> [PKPaymentNetwork] {
        let lowercasedNetworks = networks.map { $0.lowercased() }
        return Self.allCases.compactMap({ pkNetwork in
            return lowercasedNetworks.contains(pkNetwork.rawValue.lowercased()) ? pkNetwork : nil
        })
    }
}
