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
    public let avatar: String?
    
//    @DateStringCoding
    public var birthday: String?

    
    public var getBirthday: Date? {
        guard let birthday = birthday else {
            return nil
        }
        return Self.dateFormatter.date(from: birthday)
    }

    public var getFormatBirthday: String? {
        guard let date = getBirthday else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
//    enum CodingKeys: String, CodingKey {
//        case guid = "guid"
//        case name = "name"
//        case mobile = "mobile"
//        case gender = "gender"
//        case step = "step"
//        case birthday = "birthday"
//    }

    private static let dateFormatter: DateFormatter = Self.createDateFormatter()
    private static func createDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        formatter.timeZone   = TimeZone(secondsFromGMT: 8)
        formatter.locale     = Locale(identifier: "zh_Hans_CN")
        return formatter
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

