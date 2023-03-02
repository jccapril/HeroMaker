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
    func loadUserInfo() async throws -> UserInfo? {
        return try await UserCenter.getUserInfo()
    }
}

