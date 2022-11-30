//
//  Created by jcc on 2022/11/30.
//

import AsyncHTTPClient
import Foundation
import NIO

public struct Response {
    public let version: HTTPVersion
    public let status: HTTPResponseStatus
    public let headers: HTTPHeaders
    public let body: Data

    public init(version: HTTPVersion, status: HTTPResponseStatus, headers: HTTPHeaders, body: ByteBuffer) {
        self.version = version
        self.status = status
        self.headers = headers
        self.body = Data(buffer: body)
    }

    public init(version: HTTPVersion, status: HTTPResponseStatus, headers: HTTPHeaders, body: Data) {
        self.version = version
        self.status = status
        self.headers = headers
        self.body = body
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    static func `import`(httpClientResponse: HTTPClientResponse, body: ByteBuffer) -> Response {
        Response(
            version: httpClientResponse.version,
            status: httpClientResponse.status,
            headers: httpClientResponse.headers,
            body: body
        )
    }

    static func `import`(httpClientResponse: HTTPClient.Response) -> Response {
        Response(
            version: httpClientResponse.version,
            status: httpClientResponse.status,
            headers: httpClientResponse.headers,
            body: (httpClientResponse.body.map { Data(buffer: $0) }) ?? Data()
        )
    }
}

