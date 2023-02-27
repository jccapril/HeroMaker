//
//  CoupleInfo.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/27.
//

import Coder
import DataConvert
import Foundation
import KeyValueStore

public struct CoupleInfo: Codable, Storable {
    public static let key: String = "CoupleINFO_KEY"
    public let name: String
    public let status: Int
    public let partner: UserInfo
}


extension CoupleInfo: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}


