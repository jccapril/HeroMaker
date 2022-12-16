//
//  RegisterProvider.swift
//  AppLogin
//
//  Created by jcc on 2022/12/16.
//

import Center
import Foundation
import UICore

class RegisterProvider: Provider {}


extension RegisterProvider {
    @discardableResult
    func register(name: String, mobile: String, password: String) async throws -> TokenInfo {
        try await APICenter.register(name: name, mobile: mobile, password: password)
    }
}

