//
//  ClientHandler.swift
//  CenterWebServer
//
//  Created by jcc on 2022/12/2.
//

import AsyncHTTPClient
import Foundation
import HummingbirdCore
import Logging
import NIO
import ProxyServer
import RestfulClient

class ClientHandler {
    let eventGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    let logger: Logger
    let client: Client

    init(logger: Logger) {
        self.logger = logger
        client = Client(eventLoopGroupProvider: .shared(eventGroup), configuration: Configuration(readTimeout: 15), logger: logger)
    }
}

extension ClientHandler: ClientHandle {
    func execute(request: HBHTTPRequest, onComplete: @escaping (Result<HBHTTPResponse, Error>) -> Void) {
        func forbidden() -> HBHTTPResponse {
            let header = HTTPResponseHead(version: .http1_1, status: .forbidden)
            let response = HBHTTPResponse(head: header, body: .empty)
            return response
        }

        do {
            guard let originalURLString = request.head.headers.first(name: HTTPHeaderField.originalURLForProxy) else { return onComplete(.success(forbidden())) }
            guard let originalURL = URL(string: originalURLString) else { return onComplete(.success(forbidden())) }
            var headers = request.head.headers
            headers.remove(name: HTTPHeaderField.host)
            headers.remove(name: HTTPHeaderField.originalURLForProxy)
            try client.execute(
                request: HTTPClient.Request(
                    url: originalURL,
                    method: request.head.method,
                    headers: headers,
                    body: request.body.buffer.map { HTTPClient.Body.byteBuffer($0) }
                )
            ) {
                onComplete(
                    $0.map {
                        HBHTTPResponse(head: .init(version: $0.version, status: $0.status, headers: $0.headers), body: .byteBuffer(ByteBuffer(data: $0.body)))
                    }
                )
            }
        } catch {
            return onComplete(.failure(error))
        }
    }
}
