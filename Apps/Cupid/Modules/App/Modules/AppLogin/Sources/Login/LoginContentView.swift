//
//  LoginContentView.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import UICore
import UIKit

class LoginContentView: View {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}



// MARK: - Private

private extension LoginContentView {
    func setup() {
        backgroundColor = .systemWhite

    }
}


// MARK: - Override

extension LoginContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
