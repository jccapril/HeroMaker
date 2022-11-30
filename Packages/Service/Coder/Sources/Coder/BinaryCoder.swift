//
// Created by jcc on 2021/9/8.
//

import BinaryCodable
import struct Foundation.Data

public enum BinaryCoder {}

private extension BinaryCoder {
    static let encoder: BinaryDataEncoder = .init()

    static let decoder: BinaryDataDecoder = .init()
}

public extension BinaryCoder {
    static func encode<Object: BinaryEncodable>(object: Object) throws -> Data {
        let data: Data = try encoder.encode(object)
        return data
    }

    static func decode<Object: BinaryDecodable>(data: Data) throws -> Object {
        try decoder.decode(Object.self, from: data)
    }
}
