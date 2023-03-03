//
//  File.swift
//  
//
//  Created by jcc on 2023/3/3.
//

import Foundation

public enum UIDialogManager {}

public extension UIDialogManager {
    
    static func setupDefaultAppearance() {
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color           = .clear
        overlayAppearance.blurEnabled     = false
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 20
    }
    
}


