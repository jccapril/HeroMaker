//
//  OursContentView.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class OursContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension OursContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension OursContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
    }
    
    func layout() {
        // pinlayout
    }
}





