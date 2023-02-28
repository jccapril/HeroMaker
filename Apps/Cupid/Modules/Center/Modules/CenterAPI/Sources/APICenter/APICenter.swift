//
//  APICenter.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import Foundation
import KeyValueStore
import Service
import Coder
import RestfulClient

public enum APICenter {}

extension APICenter: TypeNameable {}

public extension APICenter {
    static func bootstrap() {
        bootstrapToken()
    }
}

extension APICenter {
    static let container: Container = {
        do {
            let containerDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("KeyValueStores")
            let containerURL = containerDirectoryURL.appendingPathComponent(typeName)
            if !FileManager.default.fileExists(atPath: containerURL.path) {
                try FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
            }
            let container = try Container(path: containerURL.path, maxStore: 256)
            return container
        } catch {
            fatalError("\(error)")
        }
    }()
}

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




