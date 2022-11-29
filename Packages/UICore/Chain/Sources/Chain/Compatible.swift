//
// Created by jcc on 2022/3/7.
//

public protocol Compatible {
    associatedtype CompatibleType
    var x: CompatibleType { get }
    static var x: CompatibleType.Type { get }
}

public extension Compatible {
    var x: Box<Self> { Box(subject: self) }

    static var x: Box<Self>.Type { Box.self }
}
