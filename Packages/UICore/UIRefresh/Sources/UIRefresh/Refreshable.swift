//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)
import UIKit

public protocol Refreshable where Self: UIView {
    func animate(state: Refresher.State)
}
#endif

