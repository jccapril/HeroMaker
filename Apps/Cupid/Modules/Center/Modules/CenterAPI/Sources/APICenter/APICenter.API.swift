//
//  APICenter.API.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import Coder
import RestfulClient

extension APICenter {
    static let eventGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    static let client: Client = .init(eventLoopGroupProvider: .shared(eventGroup), logger: logger)
}

extension APICenter {
    static func execute<T: Codable>(_ request: BaseRequestable) async throws -> T? {
        guard let response = try? await client.execute(request: request) else {
            throw HTTPBizError.serve
        }
        if response.headers.contains(name: "new-token") {
            guard let token = response.headers.first(name: "new-token") else {
                resetToken()
                throw HTTPBizError.token
            }
            setToken(token)
        }
        
//        
//        do {
//            try Response<T>.init(data: response.body)
//        }catch(let err) {
//            logger.error("\(err)")
//        }
    
        guard let result = try? Response<T>.init(data: response.body) else {
            throw HTTPBizError.parse
        }

        guard response.status == HTTPResponseStatus.ok else {
            throw HTTPBizError(code: result.errorCode, message: result.message)
        }
        guard result.errorCode == 0  else {
            // jwt 错误
            if result.errorCode/10000 == 103 {
                resetToken()
            }
            throw HTTPBizError(code: result.errorCode, message: result.message)
        }
        
        
        return result.data
     
    }
}

public extension APICenter {
    
    // 发送验证码
    static func requestMobileSMSCode(mobile: String) async throws {
        let request = MobileSMSCodeRequest(mobile: mobile)
        let _: NullResponse? = try await execute(request)
    }
    
    // 登录/注册
    static func loginOrRegister(mobile: String, code: String) async throws -> TokenInfo {
        let request = MobileSMSCodeAuthRequest(mobile: mobile, code: code)
        guard let tokenInfo: TokenInfo = try await execute(request) else{
            throw HTTPBizError.parse
        }
        setToken(tokenInfo.accessToken)
        return tokenInfo
    }
    
    // 获取用户信息
    static func getUserInfo() async throws -> UserInfo? {
        let request = UserInfoRequest()
        return try await execute(request)
    }
    
    // 更新用户信息
    static func updateUserInfo(name: String? = nil, gender: Int? = nil, birthday: String? = nil, avatar: String? = nil) async throws -> UserInfo? {
        let request = UpdateUserInfoRequest(name: name, gender: gender, birthday: birthday, avatar: avatar)
        return try await execute(request)
    }
    
    // 获取情侣信息
    static func getCoupleInfo() async throws -> CoupleInfo? {
        let request = CoupleInfoRequest()
        return try await execute(request)
    }
    
}

