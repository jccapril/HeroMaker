//
//  File.swift
//  
//
//  Created by jcc on 2023/3/8.
//

#if canImport(UIKit)

import UIKit.UITextField

public extension Box where T: UITextView {
    
    @discardableResult
    func contentInset(_ contentInset: UIEdgeInsets) -> Box {
        subject.contentInset = contentInset
        return subject.x
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Box {
        subject.font = font
        return subject.x
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> Box {
        subject.keyboardType = keyboardType
        return subject.x
    }
    
    
    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Box {
        subject.returnKeyType = returnKeyType
        return subject.x
    }

    
}

#endif
