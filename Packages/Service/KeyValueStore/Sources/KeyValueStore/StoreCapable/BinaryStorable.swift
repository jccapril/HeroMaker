//
// Created by jcc on 2022/2/17.
//

import Coder
import Foundation

public protocol BinaryStorable: Storable, BinaryCodable {}

public extension BinaryStorable {
    init(data: Data) throws {
        let object: Self = try BinaryCoder.decode(data: data)
        self = object
    }

    func toData() throws -> Data {
        let data = try BinaryCoder.encode(object: self)
        return data
    }
}
