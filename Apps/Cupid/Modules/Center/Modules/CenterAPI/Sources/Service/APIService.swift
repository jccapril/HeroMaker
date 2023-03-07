//
//  APIService.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import KeyValueStore
import Service
import Coder
import RestfulClient


open class APIService {
    
    private let eventGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private(set) var client: Client
    public init() {
        client =  .init(eventLoopGroupProvider: .shared(self.eventGroup), logger: logger)
    }
    
}

extension APIService: TypeNameable {}



extension APIService {
    
    func execute<T: Codable>(_ request: BaseRequestable, headers: HTTPHeaders) async throws -> T? {
        guard let response = try? await client.execute(request: request) else {
            throw HTTPBizError.serve
        }
//        if response.headers.contains(name: "new-token") {
//            guard let token = response.headers.first(name: "new-token") else {
//                resetToken()
//                throw HTTPBizError.token
//            }
//            setToken(token)
//        }
        
        guard let result = try? Response<T>.init(data: response.body) else {
            throw HTTPBizError.parse
        }

        guard response.status == HTTPResponseStatus.ok else {
            throw HTTPBizError(code: result.errorCode, message: result.message)
        }
//        guard result.errorCode == 0  else {
//            // jwt 错误
//            if result.errorCode/10000 == 103 {
//                resetToken()
//            }
//            throw HTTPBizError(code: result.errorCode, message: result.message)
//        }
        
        
        return result.data
     
    }
}
