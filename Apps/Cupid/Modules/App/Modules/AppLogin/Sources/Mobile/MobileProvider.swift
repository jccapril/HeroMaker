//
//  MobileProvider.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import Center
import Foundation
import UICore

class MobileProvider: Provider {}


extension MobileProvider {
    @discardableResult
    func requestSMSCode(mobile: String) async throws -> Bool {
        try await APICenter.requestMobileSMSCode(mobile: mobile)
    }
    
    @discardableResult
    func login(mobile: String, code: String) async throws -> TokenInfo {
        try await APICenter.loginOrRegister(mobile: mobile, code: code)
    }
}


