//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)
import UIKit

private extension UIScrollView {
    static var topRefresherKey: UInt8 = 0
    static var bottomRefresherKey: UInt8 = 0
}

public extension UIScrollView {
    var topRefresher: Refresher? {
        get { objc_getAssociatedObject(self, &Self.topRefresherKey) as? Refresher }

        set {
            if newValue != topRefresher {
                topRefresher?.removeFromSuperview()
                guard let refresher = newValue else { return }
                refresher.position = .top
                insertSubview(refresher, at: 0)
            }
            objc_setAssociatedObject(self, &Self.topRefresherKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var bottomRefresher: Refresher? {
        get { objc_getAssociatedObject(self, &Self.bottomRefresherKey) as? Refresher }

        set {
            if newValue != bottomRefresher {
                bottomRefresher?.removeFromSuperview()
                guard let refresher = newValue else { return }
                refresher.position = .bottom
                insertSubview(refresher, at: 0)
            }
            objc_setAssociatedObject(self, &Self.bottomRefresherKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

#endif

