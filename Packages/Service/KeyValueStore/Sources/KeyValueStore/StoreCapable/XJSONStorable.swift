//
// Created by jcc on 2022/2/17.
//

import Coder
import Foundation

public protocol XJSONStorable: Storable, Codable {}

public extension XJSONStorable {
    init(data: Data) throws {
        let object: Self = try JSONCoder.decode(data: data, vendor: .extra)
        self = object
    }

    func toData() throws -> Data {
        let data = try JSONCoder.encode(object: self, vendor: .extra)
        return data
    }
}
