//
//  Created by jcc on 2022/11/30.
//

import AsyncHTTPClient
import Foundation
import Logging

open class Client {
    private let httpClient: HTTPClient
    private let logger: Logger

    public init(eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew, configuration: Configuration = Configuration(), logger: Logger) {
        self.logger = logger
        httpClient = HTTPClient(
            eventLoopGroupProvider: eventLoopGroupProvider,
            configuration: configuration.export(),
            backgroundActivityLogger: logger
        )
    }

    deinit {
        do {
            if #available(iOS 13.0, *) {
                Task {
                    try await httpClient.shutdown()
                }
            } else {
                try httpClient.syncShutdown()
            }
        } catch {
            logger.error("\(error)")
        }
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension Client {
    func execute<Request: Requestable>(request: Request) async throws -> Response {
        logger.debug("start request => \(request.method.rawValue) \(request.url)")
        let httpResponse = try await httpClient.execute(
            request.export(),
            timeout: .seconds(10),
            logger: logger
        )

        let body = try await httpResponse.body.collect(upTo: 10 * 1024 * 1024)

        let response: Response = .import(httpClientResponse: httpResponse, body: body)

        logger.debug("finish request => \(request.method.rawValue) \(request.url) response code : \(response.status.code)")

        return response
    }
}

public extension Client {
    func execute<Request: Requestable>(request: Request, onComplete: @escaping (Result<Response, Error>) -> Void) {
        logger.debug("start request => \(request.method.rawValue) \(request.url)")
        do {
            try httpClient.execute(request: request.export()).whenComplete {
                onComplete(
                    $0.map {
                        let response = Response.import(httpClientResponse: $0)
                        self.logger.debug("finish request => \(request.method.rawValue) \(request.url) response code : \(response.status.code)")
                        return response
                    }
                )
            }
        } catch {
            onComplete(.failure(error))
        }
    }
}

public extension Client {
    func execute(request: HTTPClient.Request, onComplete: @escaping (Result<Response, Error>) -> Void) {
        logger.debug("start request => \(request.method.rawValue) \(request.url)")
        httpClient.execute(request: request).whenComplete {
            onComplete(
                $0.map {
                    let response = Response.import(httpClientResponse: $0)
                    self.logger.debug("finish request => \(request.method.rawValue) \(request.url) response code : \(response.status.code)")
                    return response
                }
            )
        }
    }
}

