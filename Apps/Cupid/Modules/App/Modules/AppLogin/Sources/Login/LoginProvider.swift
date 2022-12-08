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
    func sign(username: String, password: String) async throws -> UserInfo {
        let userInfo = try await APICenter.auth(username: username, password: password)
        return userInfo
    }
}
