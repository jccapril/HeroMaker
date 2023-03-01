//
//  MineContentView.swift
//  AppMine
//
//  Created by jcc on 2023/3/1.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class MineContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension MineContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension MineContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
    }
    
    func layout() {
        // pinlayout
    }
}





