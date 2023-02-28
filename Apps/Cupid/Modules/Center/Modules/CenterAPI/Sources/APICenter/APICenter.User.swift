//
//  APICenter.API.User.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/28.
//

import Foundation


public extension APICenter {
    enum User {}
}

public extension APICenter.User {
    // 获取用户信息
    static func getUserInfo() async throws -> UserInfo? {
        let request = UserInfoRequest()
        return try await APICenter.execute(request)
    }
    
    // 更新用户信息
    static func updateUserInfo(name: String? = nil, gender: Int? = nil, birthday: String? = nil, avatar: String? = nil) async throws -> UserInfo? {
        let request = UpdateUserInfoRequest(name: name, gender: gender, birthday: birthday, avatar: avatar)
        return try await  APICenter.execute(request)
    }
}
