//
//  LoginProvider.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import Center
import Foundation
import UICore

class LoginProvider: Provider {}


extension LoginProvider {
    func sign(mobile: String, password: String) async throws -> TokenInfo {
        try await APICenter.auth(mobile: mobile, password: password)
    }
}