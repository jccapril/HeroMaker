//
//  Created by jcc on 2022/12/1.
//

@propertyWrapper
public struct DelayInit<Value> {
    private var value: Value?

    public init() {}

    public var wrappedValue: Value {
        get {
            guard let value = value else {
                fatalError("Property accessed before being initialized.")
            }
            return value
        }
        set { value = newValue }
    }

    public mutating func reset() {
        value = nil
    }
}
