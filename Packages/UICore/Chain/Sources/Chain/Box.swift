//
// Created by jcc on 2022/3/7.
//

@dynamicMemberLookup
public struct Box<T> {
    public let subject: T

    public init(subject: T) { self.subject = subject }

    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> (Value) -> Box<T> {
        var subject = subject
        return { value in
            subject[keyPath: keyPath] = value
            return Box(subject: subject)
        }
    }
}

public extension Box {
    var instance: T { subject }
    var done: Void { () }
}
