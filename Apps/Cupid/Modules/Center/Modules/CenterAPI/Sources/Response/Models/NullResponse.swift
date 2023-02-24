//
//  NullResponse.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/24.
//
import Coder
import DataConvert
import Foundation

public struct NullResponse: Codable {

}


extension NullResponse: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }

    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}
