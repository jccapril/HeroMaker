//
//  Created by jcc on 2022/11/28.
//

public protocol Actable {
    static func act(url: URLConvertible, values: [String: Any], context: Any?) -> Bool
    static var actName: String { get }
}

public extension Actable {
    static var actName: String { String(describing: self) }
}

