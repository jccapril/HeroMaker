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
    var host: String { "10.10.242.41" }
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
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        let build = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
        let language = Bundle.main.preferredLocalizations.first ?? ""
        let regionCode = Locale.current.regionCode ?? ""
        var defaultHeaders = [
            ("X-CUPID-BID", bundleID),
            ("X-CUPID-VERSION", version),
            ("X-CUPID-BUILD", build),
            ("X-CUPID-LANGUAGE", language),
            ("X-CUPID-REGIONCODE", regionCode),
        ]
        if let token = APICenter.token {
            defaultHeaders.append(("Authorization", "Bearer \(token)"))
        }
        return HTTPHeaders(defaultHeaders)
    }

    public var body: [UInt8]? { nil }
}

