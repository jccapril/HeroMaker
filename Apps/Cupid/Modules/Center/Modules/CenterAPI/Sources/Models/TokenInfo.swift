//
//  UserInfo.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/8.
//

import Coder
import DataConvert
import Foundation

public struct TokenInfo: Codable {
    public let accessToken: String
    public let expiresIn: Int
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}


extension TokenInfo: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}
