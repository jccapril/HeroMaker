//
//  Created by jcc on 2022/12/1.
//

@propertyWrapper
public struct Clamping<Value: Comparable> {
    private var value: Value
    private let range: ClosedRange<Value>

    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        value = wrappedValue
        self.range = range
    }

    public var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}

