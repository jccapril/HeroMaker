//
//  Created by jcc on 2022/11/28.
//

#if canImport(UIKit)

import UIKit

public protocol Routable where Self: UIViewController {
    static func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController?
    static var routeName: String { get }
}

public extension Routable {
    static var routeName: String { String(describing: self) }
}

#endif
