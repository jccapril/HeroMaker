//
//  Created by jcc on 2022/11/28.
//

public struct AnyObservable {
    public private(set) weak var observable: Observable?

    public init(observable: Observable) { self.observable = observable }
}

public extension AnyObservable {
    var isRemovable: Bool { observable == nil }
}

