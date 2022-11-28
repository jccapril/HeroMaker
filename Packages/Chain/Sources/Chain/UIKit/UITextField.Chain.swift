//
//  Created by jcc on 2022/11/28.
//

#if canImport(UIKit)

import UIKit.UITextField

public extension Box where T: UITextField {
    @discardableResult
    func text(_ text: String?) -> Box {
        subject.text = text
        return subject.x
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Box {
        subject.attributedText = attributedText
        return subject.x
    }

    @discardableResult
    func textColor(_ textColor: UIColor?) -> Box {
        subject.textColor = textColor
        return subject.x
    }

    @discardableResult
    func font(_ font: UIFont?) -> Box {
        subject.font = font
        return subject.x
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Box {
        subject.textAlignment = textAlignment
        return subject.x
    }

    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Box {
        subject.borderStyle = borderStyle
        return subject.x
    }

    @discardableResult
    func defaultTextAttributes(_ defaultTextAttributes: [NSAttributedString.Key: Any]) -> Box {
        subject.defaultTextAttributes = defaultTextAttributes
        return subject.x
    }

    @discardableResult
    func placeholder(_ placeholder: String?) -> Box {
        subject.placeholder = placeholder
        return subject.x
    }

    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Box {
        subject.attributedPlaceholder = attributedPlaceholder
        return subject.x
    }

    @discardableResult
    func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> Box {
        subject.clearsOnBeginEditing = clearsOnBeginEditing
        return subject.x
    }

    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Box {
        subject.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return subject.x
    }

    @discardableResult
    func minimumFontSize(_ minimumFontSize: CGFloat) -> Box {
        subject.minimumFontSize = minimumFontSize
        return subject.x
    }

    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> Box {
        subject.delegate = delegate
        return subject.x
    }

    @discardableResult
    func background(_ background: UIImage?) -> Box {
        subject.background = background
        return subject.x
    }

    @discardableResult
    func disabledBackground(_ disabledBackground: UIImage?) -> Box {
        subject.disabledBackground = disabledBackground
        return subject.x
    }

    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Box {
        subject.allowsEditingTextAttributes = allowsEditingTextAttributes
        return subject.x
    }

    @discardableResult
    func typingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]?) -> Box {
        subject.typingAttributes = typingAttributes
        return subject.x
    }

    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> Box {
        subject.clearButtonMode = clearButtonMode
        return subject.x
    }

    @discardableResult
    func leftView(_ leftView: UIView?) -> Box {
        subject.leftView = leftView
        return subject.x
    }

    @discardableResult
    func leftViewMode(_ leftViewMode: UITextField.ViewMode) -> Box {
        subject.leftViewMode = leftViewMode
        return subject.x
    }

    @discardableResult
    func rightView(_ rightView: UIView?) -> Box {
        subject.rightView = rightView
        return subject.x
    }

    @discardableResult
    func rightViewMode(_ rightViewMode: UITextField.ViewMode) -> Box {
        subject.rightViewMode = rightViewMode
        return subject.x
    }

    @discardableResult
    func inputView(_ inputView: UIView?) -> Box {
        subject.inputView = inputView
        return subject.x
    }

    @discardableResult
    func inputAccessoryView(_ inputAccessoryView: UIView?) -> Box {
        subject.inputAccessoryView = inputAccessoryView
        return subject.x
    }

    @discardableResult
    func clearsOnInsertion(_ clearsOnInsertion: Bool) -> Box {
        subject.clearsOnInsertion = clearsOnInsertion
        return subject.x
    }
}

// MARK: - UITextInput

public extension Box where T: UITextField {
    @discardableResult
    func replace(_ range: UITextRange, withText text: String) -> Box {
        subject.replace(range, withText: text)
        return subject.x
    }

    @discardableResult
    func selectedTextRange(_ selectedTextRange: UITextRange?) -> Box {
        subject.selectedTextRange = selectedTextRange
        return subject.x
    }

    @discardableResult
    func markedTextStyle(_ markedTextStyle: [NSAttributedString.Key: Any]?) -> Box {
        subject.markedTextStyle = markedTextStyle
        return subject.x
    }

    @discardableResult
    func setMarkedText(_ markedText: String?, selectedRange: NSRange) -> Box {
        subject.setMarkedText(markedText, selectedRange: selectedRange)
        return subject.x
    }

    @discardableResult
    func unmarkText() -> Box {
        subject.unmarkText()
        return subject.x
    }

    @discardableResult
    func inputDelegate(_ inputDelegate: UITextInputDelegate?) -> Box {
        subject.inputDelegate = inputDelegate
        return subject.x
    }

    @discardableResult
    func selectionAffinity(_ selectionAffinity: UITextStorageDirection) -> Box {
        subject.selectionAffinity = selectionAffinity
        return subject.x
    }
}

// MARK: - UIInputTraits

public extension Box where T: UITextField {
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> Box {
        subject.autocapitalizationType = autocapitalizationType
        return subject.x
    }

    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Box {
        subject.autocorrectionType = autocorrectionType
        return subject.x
    }

    @discardableResult
    func spellCheckingType(_ spellCheckingType: UITextSpellCheckingType) -> Box {
        subject.spellCheckingType = spellCheckingType
        return subject.x
    }

    @available(iOS 11.0, *)
    @discardableResult
    func smartQuotesType(_ smartQuotesType: UITextSmartQuotesType) -> Box {
        subject.smartQuotesType = smartQuotesType
        return subject.x
    }

    @available(iOS 11.0, *)
    @discardableResult
    func smartDashesType(_ smartDashesType: UITextSmartDashesType) -> Box {
        subject.smartDashesType = smartDashesType
        return subject.x
    }

    @available(iOS 11.0, *)
    @discardableResult
    func smartInsertDeleteType(_ smartInsertDeleteType: UITextSmartInsertDeleteType) -> Box {
        subject.smartInsertDeleteType = smartInsertDeleteType
        return subject.x
    }

    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> Box {
        subject.keyboardType = keyboardType
        return subject.x
    }

    @discardableResult
    func keyboardAppearance(_ keyboardAppearance: UIKeyboardAppearance) -> Box {
        subject.keyboardAppearance = keyboardAppearance
        return subject.x
    }

    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Box {
        subject.returnKeyType = returnKeyType
        return subject.x
    }

    @discardableResult
    func enablesReturnKeyAutomatically(_ enablesReturnKeyAutomatically: Bool) -> Box {
        subject.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        return subject.x
    }

    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Box {
        subject.isSecureTextEntry = isSecureTextEntry
        return subject.x
    }

    @available(iOS 10.0, *)
    @discardableResult
    func textContentType(_ textContentType: UITextContentType?) -> Box {
        subject.textContentType = textContentType
        return subject.x
    }

    @available(iOS 12.0, *)
    @discardableResult
    func passwordRules(_ passwordRules: UITextInputPasswordRules?) -> Box {
        subject.passwordRules = passwordRules
        return subject.x
    }
}

// MARK: - UIContentSizeCategoryAdjusting

public extension Box where T: UITextField {
    @available(iOS 10.0, *)
    @discardableResult
    func adjustsFontForContentSizeCategory(_ adjustsFontForContentSizeCategory: Bool) -> Box {
        subject.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        return subject.x
    }
}

#endif

