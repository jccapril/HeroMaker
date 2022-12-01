//
//  DiagnoseContentView.swift
//  AppBootstrap
//
//  Created by jcc on 2022/12/1.
//

import BaseUI
import Foundation
import UIExtensionsKit
import UIKit

class DiagnoseContentView: View {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DiagnoseContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension DiagnoseContentView {
    func setup() {
        backgroundColor = .systemWhite
    }

    func layout() {}
}
