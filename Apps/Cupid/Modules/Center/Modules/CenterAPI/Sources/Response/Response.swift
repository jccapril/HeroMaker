//
//  File.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/8.
//

import Foundation
import Coder
import DataConvert

public struct Response<T: Codable>: Codable  {
    
    let errorCode: Int
    let data: T?
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case data
        case message
    }
}


extension Response: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}
