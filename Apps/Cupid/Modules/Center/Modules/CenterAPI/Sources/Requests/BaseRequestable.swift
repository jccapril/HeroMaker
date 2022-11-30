//
//  BaseRequestable.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import Foundation
import RestfulClient

protocol BaseRequestable: Requestable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension BaseRequestable {
    var scheme: String { "https" }
    var host: String { "www.baidu.com" }
    var queryItems: [URLQueryItem]? { nil }

    public var url: String {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        let url: String = components.string.unsafelyUnwrapped
        return url
    }

    public var method: HTTPMethod { .GET }

    public var headers: HTTPHeaders {
        return [:]
    }

    public var body: [UInt8]? { nil }
}

