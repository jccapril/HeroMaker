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
    static func execute<T: Codable>(_ request: BaseRequestable) async throws -> T {
 
        guard let response = try? await client.execute(request: request) else {
            throw HTTPBizError.internal
        }
        if response.headers.contains(name: "new-token") {
            guard let token = response.headers.first(name: "new-token") else {
                resetToken()
                throw HTTPBizError.token
            }
            setToken(token)
        }
        guard let result = try? Response<T>.init(data: response.body) else {
            throw HTTPBizError.parse
        }
        guard response.status == HTTPResponseStatus.ok else {
            if response.status == HTTPResponseStatus.unauthorized {
                resetToken()
            }
            throw HTTPBizError(code: result.errorCode, message: result.message)
        }
        guard let data = result.data else {
            throw HTTPBizError.internal
        }
        return data
     
    }
}

public extension APICenter {
    
    static func auth(mobile: String, password: String) async throws -> TokenInfo {
        let request = MobilePasswordAuthRequest(mobile: mobile, password: password)
        let tokenInfo: TokenInfo = try await execute(request)
        setToken(tokenInfo.accessToken)
        return tokenInfo
    }
    
    static func getUserInfo() async throws -> UserInfo {
        let request = UserInfoRequest()
        let userInfo: UserInfo = try await execute(request)
        return userInfo
    }
    
}

