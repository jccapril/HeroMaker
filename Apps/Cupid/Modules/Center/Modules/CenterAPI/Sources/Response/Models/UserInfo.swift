//
//  UserInfo.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/15.
//

import Coder
import DataConvert
import Foundation

public struct UserInfo: Codable {
    public let id: Int
    public let name: String
    public let mobile: String
    
    @DateStringCoding
    public var createdAt: Date
    
    @DateStringCoding
    public var updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case mobile = "mobile"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


extension UserInfo: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}

