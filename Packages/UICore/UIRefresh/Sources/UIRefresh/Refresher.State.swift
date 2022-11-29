//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)

import UIKit

public extension Refresher {
    enum State {
        case idle
        case pulling(progress: CGFloat)
        case willRefresh(overOffset: CGFloat)
        case refreshing
    }
}

extension Refresher.State: Equatable {
    public static func == (lhs: Refresher.State, rhs: Refresher.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.pulling, .pulling): return true
        case (.willRefresh, .willRefresh): return true
        case (.refreshing, .refreshing): return true
        default: return false
        }
    }
}

public extension Refresher.State {
    static func === (lhs: Refresher.State, rhs: Refresher.State) -> Bool {
        switch (lhs, rhs) {
        case let (.pulling(lhsProgress), .pulling(rhsProgress)):
            return lhsProgress == rhsProgress
        case let (.willRefresh(lhsOverOffset), .willRefresh(rhsOverOffset)):
            return lhsOverOffset == rhsOverOffset
        default:
            return lhs == rhs
        }
    }
}

#endif
