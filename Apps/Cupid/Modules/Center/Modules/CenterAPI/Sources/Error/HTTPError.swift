//
//  HTTPError.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import NIOHTTP1

public struct HTTPError: Error {
    public let code: UInt
    private let httpResponseStatus: HTTPResponseStatus

    init(httpResponseStatus: HTTPResponseStatus) {
        self.httpResponseStatus = httpResponseStatus
        code = httpResponseStatus.code
    }
}

extension HTTPError: CustomStringConvertible {
    public var description: String {
        httpResponseStatus.reasonPhrase
    }
}

