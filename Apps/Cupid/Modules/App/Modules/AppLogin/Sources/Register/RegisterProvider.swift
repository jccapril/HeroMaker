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
    func updateUserInfo(name: String, gender: Int) async throws -> UserInfo?{
        try await UserCenter.updateUserInfo(name: name, gender: gender)
    }
}

