//
// Created by jcc on 2021/3/10.
//

import Coder
import Foundation

public protocol JSONStorable: Storable, Codable {}

public extension JSONStorable {
    init(data: Data) throws {
        let object: Self = try JSONCoder.decode(data: data, vendor: .apple)
        self = object
    }

    func toData() throws -> Data {
        let data = try JSONCoder.encode(object: self, vendor: .apple)
        return data
    }
}
