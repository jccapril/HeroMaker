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
    var port: Int { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension BaseRequestable {
    var scheme: String { "http" }
    var host: String { "127.0.0.1" }
    var port: Int { 8888 }
    var queryItems: [URLQueryItem]? { nil }

    public var url: String {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems

        let url: String = components.string.unsafelyUnwrapped
        return url
    }

    public var method: HTTPMethod { .GET }

    public var headers: HTTPHeaders {
        switch APICenter.token {
        case .none: return [:]
        case let .some(token): return [.authorization(bearerToken: token)]
        }
    }

    public var body: [UInt8]? { nil }
}

