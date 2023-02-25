//
//  MobileProvider.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import Center
import Foundation
import UICore

class LoginProvider: Provider {}


extension LoginProvider {

    func requestSMSCode(mobile: String) async throws {
        try await UserCenter.Sign.sendSMSCode(mobile: mobile)
    }
    
    func login(mobile: String, code: String) async throws {
        try await UserCenter.Sign.auth(mobile: mobile, code: code)
    }
}


