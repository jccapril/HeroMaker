//
// Created by jcc on 2022/3/10.
//

#if canImport(UIKit)

import UIKit.UIControl

public extension Box where T: UIControl {
    @discardableResult
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Box {
        subject.addTarget(target, action: action, for: controlEvents)
        return subject.x
    }
}

#endif
