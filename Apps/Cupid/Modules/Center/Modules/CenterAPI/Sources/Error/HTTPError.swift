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

public struct HTTPBizError: Error {
    
    
    
    public let code: Int
    public let message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

extension HTTPBizError: CustomStringConvertible {
    public var description: String {
        message
    }
}


extension HTTPBizError {
    static let `internal` = HTTPBizError(code: 10086, message: "内部错误")
}
