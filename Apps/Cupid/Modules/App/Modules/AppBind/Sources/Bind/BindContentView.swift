//
//  BindContentView.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class BindContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - Private

private extension BindContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
    }
}


// MARK: - Override

extension BindContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // pinlayout
    }
}


