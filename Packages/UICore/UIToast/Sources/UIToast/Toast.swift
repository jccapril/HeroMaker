import Foundation
import UIKit

import Foundation
import UIKit

public class Toast {
    public let view: Toastable

    private let config: ToastConfiguration

    public required init(view: Toastable, config: ToastConfiguration) {
        self.config = config
        self.view = view

        view.transform = initialTransform
    }
}

private extension Toast {
    var initialTransform: CGAffineTransform {
        CGAffineTransform(scaleX: 0.9, y: 0.9).translatedBy(x: 0, y: -100)
    }

    func topController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .filter(\.isKeyWindow).first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }
        }

        return nil
    }
}

public extension Toast {
    static func text(_ title: String, subtitle: String? = nil, config: ToastConfiguration = ToastConfiguration()) -> Toast {
        let view = AppleToastView(child: TextToastView(title, subtitle: subtitle))
        return self.init(view: view, config: config)
    }

    @available(iOS 13.0, *)
    static func `default`(image: UIImage, imageTint: UIColor? = .label, title: String, subtitle: String? = nil, config: ToastConfiguration = ToastConfiguration()) -> Toast {
        let view = AppleToastView(child: IconToastView(image: image, imageTint: imageTint, title: title, subtitle: subtitle))
        return self.init(view: view, config: config)
    }

    static func custom(view: Toastable, config: ToastConfiguration = ToastConfiguration()) -> Toast {
        self.init(view: view, config: config)
    }
}

public extension Toast {
    func show(after delay: TimeInterval = 0) {
        config.view?.addSubview(view) ?? topController()?.view.addSubview(view)
        view.createView(for: self)

        UIView.animate(withDuration: config.animationTime, delay: delay, options: [.curveEaseOut, .allowUserInteraction]) {
            self.view.transform = .identity
        } completion: { [self] _ in
            if config.autoHide {
                close(after: config.displayTime)
            }
        }
    }

    func close(after time: TimeInterval = 0, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: config.animationTime, delay: time, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.view.transform = self.initialTransform
        }, completion: { _ in
            self.view.removeFromSuperview()
            completion?()
        })
    }
}

