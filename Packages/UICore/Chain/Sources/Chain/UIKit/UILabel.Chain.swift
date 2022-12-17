//
//  Created by jcc on 2022/11/28.
//

#if canImport(UIKit)

import UIKit.UILabel

public extension Box where T: UILabel {
    @discardableResult
    func text(_ text: String?) -> Box {
        subject.text = text
        return subject.x
    }

    @discardableResult
    func font(_ font: UIFont) -> Box {
        subject.font = font
        return subject.x
    }

    @discardableResult
    func textColor(_ color: UIColor) -> Box {
        subject.textColor = color
        return subject.x
    }

    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> Box {
        subject.shadowColor = shadowColor
        return subject.x
    }

    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> Box {
        subject.shadowOffset = shadowOffset
        return subject.x
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Box {
        subject.textAlignment = textAlignment
        return subject.x
    }

    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Box {
        subject.lineBreakMode = lineBreakMode
        return subject.x
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Box {
        subject.attributedText = attributedText
        return subject.x
    }

    @discardableResult
    func highlightedTextColor(_ highlightedTextColor: UIColor?) -> Box {
        subject.highlightedTextColor = highlightedTextColor
        return subject.x
    }

    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Box {
        subject.isHighlighted = isHighlighted
        return subject.x
    }

    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Box {
        subject.isUserInteractionEnabled = isUserInteractionEnabled
        return subject.x
    }

    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Box {
        subject.isEnabled = isEnabled
        return subject.x
    }

    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Box {
        subject.numberOfLines = numberOfLines
        return subject.x
    }

    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Box {
        subject.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return subject.x
    }

    @discardableResult
    func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> Box {
        subject.baselineAdjustment = baselineAdjustment
        return subject.x
    }

    @discardableResult
    func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> Box {
        subject.minimumScaleFactor = minimumScaleFactor
        return subject.x
    }

    @available(iOS 9.0, *)
    func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> Box {
        subject.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return subject.x
    }

    @available(iOS 14.0, *)
    @discardableResult
    func lineBreakStrategy(_ lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> Box {
        subject.lineBreakStrategy = lineBreakStrategy
        return subject.x
    }

    @discardableResult
    func preferredMaxLayoutWidth(_ preferredMaxLayoutWidth: CGFloat) -> Box {
        subject.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        return subject.x
    }
}

#endif

