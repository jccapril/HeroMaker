//
// Created by jcc on 2022/6/21.
//

import UIKit

@available(iOS 13.0, *)
public extension ProgressHUD {
    class func dismiss() {
        DispatchQueue.main.async {
            shared.hudHide()
        }
    }

    class func show(_ status: String? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, hide: false, interaction: interaction)
        }
    }

    class func show(_ status: String? = nil, icon: AlertIcon, interaction: Bool = true) {
        let image = icon.image?.withTintColor(shared.colorAnimation, renderingMode: .alwaysOriginal)

        DispatchQueue.main.async {
            shared.setup(status: status, staticImage: image, hide: true, interaction: interaction)
        }
    }

    class func show(_ status: String? = nil, icon animatedIcon: AnimatedIcon, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, animatedIcon: animatedIcon, hide: true, interaction: interaction)
        }
    }

    class func showSuccess(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, staticImage: image ?? shared.imageSuccess, hide: true, interaction: interaction)
        }
    }

    class func showError(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, staticImage: image ?? shared.imageError, hide: true, interaction: interaction)
        }
    }

    class func showSucceed(_ status: String? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, animatedIcon: .succeed, hide: true, interaction: interaction)
        }
    }

    class func showFailed(_ status: String? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, animatedIcon: .failed, hide: true, interaction: interaction)
        }
    }

    class func showAdded(_ status: String? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, animatedIcon: .added, hide: true, interaction: interaction)
        }
    }

    class func showProgress(_ progress: CGFloat, interaction: Bool = false) {
        DispatchQueue.main.async {
            shared.setup(progress: progress, hide: false, interaction: interaction)
        }
    }

    class func showProgress(_ status: String?, _ progress: CGFloat, interaction: Bool = false) {
        DispatchQueue.main.async {
            shared.setup(status: status, progress: progress, hide: false, interaction: interaction)
        }
    }
}
