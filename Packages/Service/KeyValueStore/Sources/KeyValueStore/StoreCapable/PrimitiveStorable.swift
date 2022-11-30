//
// Created by jcc on 2021/3/10.
//

import DataConvert
import Foundation

public protocol PrimitiveStorable: Storable {
    associatedtype Value: DataConvertible
    var value: Value { get }
    init(value: Value)
}

public extension PrimitiveStorable {
    init(data: Data) throws {
        let value = try Value(data: data)
        self.init(value: value)
    }

    func toData() throws -> Data {
        try value.toData()
    }
}
