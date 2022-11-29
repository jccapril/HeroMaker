//
//  Created by jcc on 2022/11/29.
//

public extension Collection {
    static func == <A: Equatable, B: Equatable>(lhs: Self, rhs: Self) -> Bool where Element == (A, B) {
        guard lhs.count == rhs.count else { return false }

        return zip(lhs, rhs).allSatisfy(==)
    }
}

