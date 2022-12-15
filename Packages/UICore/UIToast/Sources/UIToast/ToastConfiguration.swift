//
//  Created by  on 2022/11/28.
//

import Foundation
import UIKit

public struct ToastConfiguration {
    public let autoHide: Bool
    public let displayTime: TimeInterval
    public let animationTime: TimeInterval
    public let view: UIView?
    
    public init(autoHide: Bool = true, displayTime: TimeInterval = 2, animationTime: TimeInterval = 0.2, view: UIView? = nil) {
        self.autoHide = autoHide
        self.displayTime = displayTime
        self.animationTime = animationTime
        self.view = view
    }
}

