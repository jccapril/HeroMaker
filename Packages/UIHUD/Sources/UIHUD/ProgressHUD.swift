//
// Created by jcc on 2022/6/21.
//

import UIKit

@available(iOS 13.0, *)
public class ProgressHUD: UIView {
    var viewBackground: UIView?
    var toolbarHUD: UIToolbar?
    var labelStatus: UILabel?

    var viewProgress: ProgressView?
    var viewAnimation: UIView?
    var viewAnimatedIcon: UIView?
    var staticImageView: UIImageView?

    var timer: Timer?

    var animationType = AnimationType.systemActivityIndicator

    var colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var colorHUD = UIColor.systemGray
    var colorStatus = UIColor.label
    var colorAnimation = UIColor.lightGray
    var colorProgress = UIColor.lightGray

    var fontStatus = UIFont.boldSystemFont(ofSize: 24)
    var imageSuccess = UIImage.checkmark.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
    var imageError = UIImage.remove.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)

    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
        alpha = 0
    }

    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
}
