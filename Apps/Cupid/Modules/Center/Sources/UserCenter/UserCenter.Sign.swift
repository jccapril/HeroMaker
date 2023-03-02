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
    
    static func sendSMSCode(mobile: String) async throws {
        try await APICenter.Login.requestMobileSMSCode(mobile: mobile)
    }
    
    static func auth(mobile:String, code: String) async throws {
        // 登录一下接口获取Token
        let tokenInfo = try await APICenter.Login.loginOrRegister(mobile: mobile, code: code)
        UserCenter.updateToken(token: tokenInfo.accessToken)
        try await UserCenter.bootstrap()
    }
    
    static func signout() {
        UserCenter.updateToken(token: nil)
        UserCenter.updateUserInfo(userInfo: nil)
        UserCenter.updateCoupleInfo(coupleInfo: nil)
    }
}
