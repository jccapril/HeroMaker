//
//  Created by jcc on 2022/11/29.
//

public extension Bool {

    /// Get Bool Map
    ///
    ///     let foo: Bool = true
    ///     print(foo.map(true: "foo", false: "bar")) -> "foo"
    ///
    /// - Parameters:
    ///   - true: value to return if self is true.
    ///   - false: value to return if self is false.
    /// - Returns: value if true or value if false
    func map<T>(true: T, false: T) -> T {
        switch self {
        case true:
            return `true`
        case false:
            return `false`
        }
    }

    
    /// Get Bool Map
    ///
    ///     let foo: Bool = true
    ///     let bar: String = foo.map(true: {
    ///         return "foo"
    ///     }, false: {
    ///         return "bar"
    ///     })
    ///     print(bar) -> "foo"
    ///
    /// - Parameters:
    ///   - true: value to return if self is true.
    ///   - false: value to return if self is false.
    /// - Returns: value if true or value if false
    func map<T>(true: () -> T, false: () -> T) -> T {
        switch self {
        case true:
            return `true`()
        case false:
            return `false`()
        }
    }
}

