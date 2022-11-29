//
// Created by jcc on 2022/6/21.
//

import UIKit

@available(iOS 13.0, *)
public extension ProgressHUD {
    class var animationType: AnimationType {
        get { shared.animationType }
        set { shared.animationType = newValue }
    }

    class var colorBackground: UIColor {
        get { shared.colorBackground }
        set { shared.colorBackground = newValue }
    }

    class var colorHUD: UIColor {
        get { shared.colorHUD }
        set { shared.colorHUD = newValue }
    }

    class var colorStatus: UIColor {
        get { shared.colorStatus }
        set { shared.colorStatus = newValue }
    }

    class var colorAnimation: UIColor {
        get { shared.colorAnimation }
        set { shared.colorAnimation = newValue }
    }

    class var colorProgress: UIColor {
        get { shared.colorProgress }
        set { shared.colorProgress = newValue }
    }

    class var fontStatus: UIFont {
        get { shared.fontStatus }
        set { shared.fontStatus = newValue }
    }

    class var imageSuccess: UIImage {
        get { shared.imageSuccess }
        set { shared.imageSuccess = newValue }
    }

    class var imageError: UIImage {
        get { shared.imageError }
        set { shared.imageError = newValue }
    }
}
