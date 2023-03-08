//
//  Diary.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/8.
//

import Coder
import DataConvert
import Foundation


public struct Diary: Codable {

    public let id: Int
    public let createdBy: String
    public let coupleID: Int
    public let text: String?
    public let pictures: [String]?
    public let createdAt: String
    public let updatedAt: String
    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case coupleID = "couple_id"
        case text
        case pictures
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

}


extension Diary: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}



