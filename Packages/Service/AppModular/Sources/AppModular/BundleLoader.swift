//
//  Created by jcc on 2022/11/30.
//

import Foundation

public protocol BundleLoader: AnyObject {
    static var bundle: Bundle { get }
}

public extension BundleLoader {
    static var bundle: Bundle {
        Bundle(for: self)
    }
}

public extension BundleLoader {
    static func path(forResource name: String?, ofType ext: String?) -> String? {
        bundle.path(forResource: name, ofType: ext)
    }
}

