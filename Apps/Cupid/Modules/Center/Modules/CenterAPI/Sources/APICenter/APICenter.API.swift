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
            throw HTTPBizError.internal
        }
        guard let result: Response<T> = try? JSONCoder.decode(data: response.body) else {
            throw HTTPBizError.internal
        }
        guard result.errorCode == 0 else { throw HTTPBizError(code: result.errorCode, message: result.message) }
        return result.data
     
    }
}

public extension APICenter {
    
    static func auth(mobile: String, password: String) async throws -> TokenInfo {
        let request = MobilePasswordAuthRequest(mobile: mobile, password: password)
        guard let tokenInfo: TokenInfo = try await execute(request) else {
            throw HTTPBizError.internal
        }
        return tokenInfo
    }
}

