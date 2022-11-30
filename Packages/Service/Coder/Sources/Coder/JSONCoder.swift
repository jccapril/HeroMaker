//
//  Created by jcc on 2022/11/30.
//

import ExtrasJSON
import struct Foundation.Data
import class Foundation.JSONDecoder
import class Foundation.JSONEncoder

public enum JSONCoder {}

private extension JSONCoder {
    static let xEncoder: XJSONEncoder = .init()

    static let xDecoder: XJSONDecoder = .init()

    static let appleEncoder: JSONEncoder = .init()

    static let appleDecoder: JSONDecoder = .init()
}

public extension JSONCoder {
    static func encode<Object: Encodable>(object: Object, vendor: Vendor = .extra) throws -> Data {
        switch vendor {
        case .extra:
            let bytes: [UInt8] = try xEncoder.encode(object)
            return Data(bytes)
        case .apple:
            let data = try appleEncoder.encode(object)
            return data
        }
    }

    static func decode<Object: Decodable>(data: Data, vendor: Vendor = .extra) throws -> Object {
        switch vendor {
        case .extra:
            return try xDecoder.decode(Object.self, from: data)
        case .apple:
            return try appleDecoder.decode(Object.self, from: data)
        }
    }
}

public extension JSONCoder {
    enum Vendor {
        case extra
        case apple
    }
}

