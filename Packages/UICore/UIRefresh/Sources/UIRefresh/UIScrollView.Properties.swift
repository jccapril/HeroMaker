//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)
import UIKit

extension UIScrollView {
    var inset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return adjustedContentInset
        } else {
            return contentInset
        }
    }

    var topInset: CGFloat {
        get { inset.top }
        set { contentInset.top = newValue - (inset.top - contentInset.top) }
    }

    var bottomInset: CGFloat {
        get { inset.bottom }
        set { contentInset.bottom = newValue - (inset.bottom - contentInset.bottom) }
    }

    var leftInset: CGFloat {
        get { inset.left }
        set { contentInset.right = newValue - (inset.right - contentInset.right) }
    }

    var rightInset: CGFloat {
        get { inset.right }
        set { contentInset.left = newValue - (inset.left - contentInset.left) }
    }

    var offsetX: CGFloat {
        get { contentOffset.x }
        set { contentOffset.x = newValue }
    }

    var offsetY: CGFloat {
        get { contentOffset.y }
        set { contentOffset.y = newValue }
    }

    var contentWidth: CGFloat {
        get { contentSize.width }
        set { contentSize.width = newValue }
    }

    var contentHeight: CGFloat {
        get { contentSize.height }
        set { contentSize.height = newValue }
    }
}

#endif

