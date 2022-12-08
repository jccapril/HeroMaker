//
//  UserCenter.Sign.swift
//  Center
//
//  Created by jcc on 2022/12/8.
//

import Foundation


public extension UserCenter {
    enum Sign {}
}

public extension UserCenter.Sign {
    static func auth(username: String, password: String) async throws -> UserInfo {
        try await APICenter.auth(username: username, password: password)
    }
}
