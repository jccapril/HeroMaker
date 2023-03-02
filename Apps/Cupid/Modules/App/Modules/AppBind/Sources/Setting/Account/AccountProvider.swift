//
//  AccountProvider.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//

import Center
import Foundation
import UICore

class AccountProvider: Provider {}

extension AccountProvider {
    @discardableResult
    func loadUserInfo() async throws -> UserInfo? {
        return try await UserCenter.getUserInfo()
    }
    
    @discardableResult
    func updateUserInfo(name: String? = nil, gender: Int? = nil) async throws -> UserInfo?{
        try await UserCenter.updateUserInfo(name: name, gender: gender)
    }
}

