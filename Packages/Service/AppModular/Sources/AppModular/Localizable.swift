//
//  Created by jcc on 2022/11/30.
//

import Foundation

public protocol Localizable: AnyObject, TypeNameable {
    static var tableName: String { get }
    static var bundle: Bundle { get }

    static func localizedString(key: String, tableName: String, comment: String) -> String
}

public extension Localizable {
    static var tableName: String { typeName }

    static func localizedString(key: String, tableName: String = tableName, comment: String = "") -> String {
        NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: comment)
    }
}

