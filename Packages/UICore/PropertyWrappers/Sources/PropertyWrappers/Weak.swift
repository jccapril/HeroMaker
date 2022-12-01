//
//  Created by jcc on 2022/12/1.
//

@propertyWrapper
public struct Weak<T: AnyObject> {
    public weak var wrappedValue: T?

    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
}
