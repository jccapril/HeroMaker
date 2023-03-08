//
//  File.swift
//  
//
//  Created by jcc on 2023/3/8.
//

import UIKit

public extension UITextView {
    
    private var placeholderLabel: UILabel? {
        return subviews.first(where: { $0 is UILabel && $0.tag == 100 })
            as? UILabel
    }

    func addPlaceholder(_ placeholder: String, color: UIColor = .lightGray) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = color
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.tag = 100
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }

    @objc private func handleTextDidChange() {
        placeholderLabel?.isHidden = !text.isEmpty
    }

}

