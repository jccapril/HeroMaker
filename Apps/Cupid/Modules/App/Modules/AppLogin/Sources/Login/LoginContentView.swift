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
    private(set) lazy var registerButtonDelegator = Delegator<Void, Void>()
    
    private lazy var mobileTextField = UITextField(frame: .zero)
        .x
        .placeholder("请输入手机号")
        .keyboardType(.numberPad)
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var passwordTextField = UITextField(frame: .zero)
        .x
        .placeholder("请输入密码")
        .isSecureTextEntry(true)
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var loginButton = UIButton(type: .custom)
        .x
        .setTitle("登录", for: .normal)
        .setTitleColor(.systemBlack, for: .normal)
        .instance
    
    private lazy var registerButton = UIButton(type: .custom)
        .x
        .setTitle("没有账号，去注册", for: .normal)
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
        mobileTextField.x.add(to: self)
        passwordTextField.x.add(to: self)
        loginButton.x.add(to: self)
        registerButton.x.add(to: self)
        
        loginButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.loginButtonDelegator((self.mobileTextField.text, self.passwordTextField.text))
        }
        .store(in: &subscriptions)
        
        registerButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.registerButtonDelegator()
        }
        .store(in: &subscriptions)
        
    }
}


// MARK: - Override

extension LoginContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        mobileTextField.pin.top(50).left(50).right(50).height(50)
        passwordTextField.pin.below(of: mobileTextField).marginTop(10).left(50).right(50).height(50)
        loginButton.pin.below(of: passwordTextField, aligned: .center).marginTop(10).sizeToFit()
        registerButton.pin.below(of: loginButton, aligned: .center).marginTop(10).sizeToFit()
    }
}
