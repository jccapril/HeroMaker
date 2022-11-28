//
// Created by jcc on 2022/3/7.
//

#if canImport(UIKit)
import UIKit

public extension Box where T: UIButton {
    @discardableResult
    func setTitle(_ title: String?, for state: UIControl.State) -> Box {
        subject.setTitle(title, for: state)
        return subject.x
    }

    @discardableResult
    func setTitleColor(_ color: UIColor?, for state: UIControl.State) -> Box {
        subject.setTitleColor(color, for: state)
        return subject.x
    }

    @discardableResult
    func setImage(_ image: UIImage?, for state: UIControl.State) -> Box {
        subject.setImage(image, for: state)
        return subject.x
    }

    @discardableResult
    func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) -> Box {
        subject.setBackgroundImage(image, for: state)
        return subject.x
    }

    @available(iOS 13.0, *)
    @discardableResult
    func setPreferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration?, forImageIn state: UIControl.State) -> Box {
        subject.setPreferredSymbolConfiguration(configuration, forImageIn: state)
        return subject.x
    }

    @discardableResult
    func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) -> Box {
        subject.setAttributedTitle(title, for: state)
        return subject.x
    }
}

#endif
