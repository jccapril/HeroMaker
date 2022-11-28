//
// Created by jcc on 2022/6/22.
//

import UIKit

@available(iOS 13.0, *)
extension ProgressHUD {
    func keyboardHeight() -> CGFloat {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
           let inputSetContainerView = NSClassFromString("UIInputSetContainerView"),
           let inputSetHostView = NSClassFromString("UIInputSetHostView")
        {
            for window in UIApplication.shared.windows {
                if window.isKind(of: keyboardWindowClass) {
                    for firstSubView in window.subviews {
                        if firstSubView.isKind(of: inputSetContainerView) {
                            for secondSubView in firstSubView.subviews {
                                if secondSubView.isKind(of: inputSetHostView) {
                                    return secondSubView.frame.size.height
                                }
                            }
                        }
                    }
                }
            }
        }
        return 0
    }
}
