//
//  ApplePayPlugin.swift
//  Apple Pay Plugin
//
//  Created by Kondrat Kielar on 03/06/2022.
//  Copyright © 2022 Fresha. All rights reserved.
//

import Foundation
import Capacitor

@objc(ApplePayPlugin)
public class ApplePayPlugin: CAPPlugin {
    let service = ApplePayService()

    @objc func canMakePayments(_ call: CAPPluginCall) {
        guard let payload = call.options else {
            call.reject("Could not deserialize data.")
            return
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            let callObject = try JSONDecoder().decode(CanMakePaymentsDTO.self, from: jsonData)
            let canMakePayments = service.canMakePayments(callPayload: callObject)
            call.resolve(["canMakePayments": canMakePayments])
        } catch {
            call.reject(error.localizedDescription)
        }
    }

    @objc func initiatePayment(_ call: CAPPluginCall) {
        guard let payload = call.options else {
            call.reject("Missing payload.")
            return
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            let callObject = try JSONDecoder().decode(InitiatePaymentDTO.self, from: jsonData)

            service.initiatePayment(callPayload: callObject) { result in
                switch result {
                case .success(let response):
                    if let data = try? JSONEncoder().encode(response),
                       let callResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        call.resolve(callResponse)
                    } else {
                        call.reject("Could not serialize response.")
                    }
                case .failure(let error):
                    call.reject(error.localizedDescription)
                }
            }
        } catch {
            call.reject(error.localizedDescription)
        }
    }

    @objc func completeLastPayment(_ call: CAPPluginCall) {
        guard let payload = call.options else {
            call.reject("Missing payload.")
            return
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            let callObject = try JSONDecoder().decode(CompletePaymentDTO.self, from: jsonData)

            service.completeLastPayment(callPayload: callObject) { result in
                switch result {
                case .success:
                    call.resolve()
                case .failure(let error):
                    call.reject(error.localizedDescription)
                }
            }
        } catch {
            call.reject(error.localizedDescription)
        }
    }
}
