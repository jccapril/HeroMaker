//
// Created by jcc on 2022/3/7.
//

#if canImport(UIKit)

import UIKit

public extension Box where T: UIWindow {
    @discardableResult
    func becomeKey() -> Box {
        subject.becomeKey()
        return subject.x
    }

    @discardableResult
    func resignKey() -> Box {
        subject.resignKey()
        return subject.x
    }

    @discardableResult
    func makeKey() -> Box {
        subject.makeKey()
        return subject.x
    }

    @discardableResult
    func makeKeyAndVisible() -> Box {
        subject.makeKeyAndVisible()
        return subject.x
    }
}

#endif
