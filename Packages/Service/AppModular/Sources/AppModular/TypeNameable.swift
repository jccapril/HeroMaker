//
//  Created by jcc on 2022/11/30.
//

public protocol TypeNameable {
    static var typeName: String { get }

    var typeName: String { get }
}

public extension TypeNameable {
    static var typeName: String { String(describing: self) }
    var typeName: String { String(describing: self) }
}
