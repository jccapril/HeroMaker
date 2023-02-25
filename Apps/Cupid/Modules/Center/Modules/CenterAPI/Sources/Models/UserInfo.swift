//
//  UserInfo.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/15.
//

import Coder
import DataConvert
import Foundation
import KeyValueStore

public struct UserInfo: Codable, Storable {
    public static let key: String = "USERINFO_KEY"
    public let guid: String
    public let mobile: String
    public let name: String?
    public let gender: Int?
    public let step: Int?
    @DateStringCoding
    public var birthday: Date?


//    enum CodingKeys: String, CodingKey {
//        case guid = "guid"
//        case name = "name"
//        case mobile = "mobile"
//        case gender = "gender"
//        case step = "step"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
}


extension UserInfo: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}

