//
//  Created by jcc on 2022/11/30.
//

import AsyncHTTPClient
import Foundation
import NIOHTTP1
import NIOSSL

public protocol Requestable {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var body: [UInt8]? { get }
}

public extension Requestable {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func export() -> HTTPClientRequest {
        var httpClientRequest = HTTPClientRequest(url: url)
        httpClientRequest.method = method
        httpClientRequest.headers = headers
        httpClientRequest.body = body.map { (raw: [UInt8]) -> HTTPClientRequest.Body in .bytes(raw) }
        return httpClientRequest
    }

    func export() throws -> HTTPClient.Request {
        let request = try HTTPClient.Request(url: url, method: method, headers: headers, body: body.map { (raw: [UInt8]) -> HTTPClient.Body in .bytes(raw) })
        return request
    }
}

