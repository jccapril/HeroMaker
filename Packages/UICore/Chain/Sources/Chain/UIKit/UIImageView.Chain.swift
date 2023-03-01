//
//  Created by jcc on 2022/11/28.
//

#if canImport(UIKit)

import UIKit.UIImageView

public extension Box where T: UIImageView {

    @discardableResult
    func image(_ image: UIImage?) -> Box {
        subject.image = image
        return subject.x
    }

    @discardableResult
    func highlightedImage(_ highlightedImage: UIImage?) -> Box {
        subject.highlightedImage = highlightedImage
        return subject.x
    }

    @available(iOS 13.0, *)
    @discardableResult
    func preferredSymbolConfiguration(_ preferredSymbolConfiguration: UIImage.SymbolConfiguration?) -> Box {
        subject.preferredSymbolConfiguration = preferredSymbolConfiguration
        return subject.x
    }

    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Box {
        subject.isUserInteractionEnabled = isUserInteractionEnabled
        return subject.x
    }

    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Box {
        subject.isHighlighted = isHighlighted
        return subject.x
    }

    @discardableResult
    func animationImages(_ animationImages: [UIImage]?) -> Box {
        subject.animationImages = animationImages
        return subject.x
    }

    @discardableResult
    func highlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) -> Box {
        subject.highlightedAnimationImages = highlightedAnimationImages
        return subject.x
    }

    @discardableResult
    func animationDuration(_ animationDuration: TimeInterval) -> Box {
        subject.animationDuration = animationDuration
        return subject.x
    }

    @discardableResult
    func animationRepeatCount(_ animationRepeatCount: Int) -> Box {
        subject.animationRepeatCount = animationRepeatCount
        return subject.x
    }

    @discardableResult
    func tintColor(_ tintColor: UIColor?) -> Box {
        subject.tintColor = tintColor
        return subject.x
    }

    @discardableResult
    func startAnimating() -> Box {
        subject.startAnimating()
        return subject.x
    }

    @discardableResult
    func stopAnimating() -> Box {
        subject.stopAnimating()
        return subject.x
    }
}

#endif

