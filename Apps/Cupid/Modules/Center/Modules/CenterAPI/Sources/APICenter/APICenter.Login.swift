//
//  APICenter.API.Login.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/28.
//

import Foundation


public extension APICenter {
    enum Login {}
}

public extension APICenter.Login {
    // 发送验证码
    static func requestMobileSMSCode(mobile: String) async throws {
        let request = MobileSMSCodeRequest(mobile: mobile)
        let _: NullResponse? = try await APICenter.execute(request)
    }
    
    // 登录/注册
    static func loginOrRegister(mobile: String, code: String) async throws -> TokenInfo {
        let request = MobileSMSCodeAuthRequest(mobile: mobile, code: code)
        guard let tokenInfo: TokenInfo = try await APICenter.execute(request) else{
            throw HTTPBizError.parse
        }
        APICenter.setToken(tokenInfo.accessToken)
        return tokenInfo
    }
}
