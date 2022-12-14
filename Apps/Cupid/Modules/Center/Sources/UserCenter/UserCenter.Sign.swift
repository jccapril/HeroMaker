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
    static func auth(mobile: String, password: String) async throws -> TokenInfo {
        try await APICenter.auth(mobile: mobile, password: password)
    }
}
