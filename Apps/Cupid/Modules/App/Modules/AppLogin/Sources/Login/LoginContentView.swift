//
//  LoginContentView.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class LoginContentView: View {
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private(set) lazy var loginButtonDelegator = Delegator<(String?, String?), Void>()
    
    private lazy var usernameTextField = UITextField(frame: .zero)
        .x
        .placeholder("请输入用户名")
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var passwordTextField = UITextField(frame: .zero)
        .x
        .placeholder("请输入密码")
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var loginButton = UIButton(type: .custom)
        .x
        .setTitle("登录", for: .normal)
        .setTitleColor(.systemBlack, for: .normal)
        .instance
    
    
    
    
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
        usernameTextField.x.add(to: self)
        passwordTextField.x.add(to: self)
        loginButton.x.add(to: self)
        
        loginButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.loginButtonDelegator((self.usernameTextField.text, self.passwordTextField.text))
        }
        .store(in: &subscriptions)
        
    }
}


// MARK: - Override

extension LoginContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        usernameTextField.pin.top(50).left(50).right(50).height(50)
        passwordTextField.pin.below(of: usernameTextField).marginTop(10).left(50).right(50).height(50)
        loginButton.pin.below(of: passwordTextField, aligned: .center).marginTop(10).sizeToFit()
        
    }
}
