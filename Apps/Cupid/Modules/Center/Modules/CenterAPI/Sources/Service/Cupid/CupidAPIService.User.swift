//
//  CupidAPIService.User.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/7.
//

import Foundation


public extension CupidAPIService {
    func getUserInfo() async throws -> UserInfo? {
        let request = UserInfoRequest()
        return try await execute(request, headers: callOptions())
    }
}
