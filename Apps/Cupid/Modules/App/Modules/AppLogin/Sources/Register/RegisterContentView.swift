//
//  RegisterContentView.swift
//  AppLogin
//
//  Created by jcc on 2022/12/16.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class RegisterContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    private(set) lazy var registerButtonDelegator = Delegator<(String?, String?, String?, String?), Void>()
    
    
    private lazy var usernameTextField = UITextField(frame: .zero)
        .x
        .placeholder("请输入用户名")
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
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
    let newPasswordTextField = UITextField()

    
    private lazy var confirmPasswordTextField = UITextField(frame: .zero)
        .x
        .placeholder("请再次输入密码")
        .isSecureTextEntry(true)
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var registerButton = UIButton(type: .custom)
        .x
        .setTitle("立即注册", for: .normal)
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

private extension RegisterContentView {
    func setup() {
        backgroundColor = .systemWhite
        usernameTextField.x.add(to: self)
        mobileTextField.x.add(to: self)
        passwordTextField.x.add(to: self)
        confirmPasswordTextField.x.add(to: self)
        registerButton.x.add(to: self)

        registerButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.registerButtonDelegator((self.usernameTextField.text, self.mobileTextField.text, self.passwordTextField.text, self.confirmPasswordTextField.text))
        }
        .store(in: &subscriptions)
    }
}


// MARK: - Override

extension RegisterContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        usernameTextField.pin.top(50).left(50).right(50).height(50)
        mobileTextField.pin.below(of: usernameTextField).marginTop(10).left(50).right(50).height(50)
        passwordTextField.pin.below(of: mobileTextField).marginTop(10).left(50).right(50).height(50)
        confirmPasswordTextField.pin.below(of: passwordTextField).marginTop(10).left(50).right(50).height(50)
        registerButton.pin.below(of: confirmPasswordTextField, aligned: .center).marginTop(10).sizeToFit()
    }
}
