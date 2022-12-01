//
//  Created by jcc on 2022/12/1.
//

#if canImport(UIKit)
import UIKit

public extension UIResponder {
    var parentViewController: UIViewController? {
        next as? UIViewController ?? next?.parentViewController
    }
}

#endif

