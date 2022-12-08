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

public extension APICenter {
    
    static func auth(username: String, password: String) async throws -> UserInfo {
        let signRequest = SignRequest(username: username, password: password)
        let response = try await client.execute(request: signRequest)
        let result: Response<UserInfo> = try JSONCoder.decode(data: response.body)
        guard result.errorCode == 0 else { throw HTTPBizError(code: result.errorCode, message: result.message) }
        guard let userInfo = result.data else { throw HTTPBizError.internal }
        return userInfo
    }
}
