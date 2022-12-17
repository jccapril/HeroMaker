//
//  LoginViewController.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class LoginViewController: ViewController {
    private lazy var contentView = LoginContentView()
    private lazy var provider = LoginProvider()
    private var loginTask: Task<Void, Never>? = .none
}

// MARK: - Override
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.pin.all(view.pin.safeArea)
    }
}

// MARK: - Private

private extension LoginViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    
    func setupNavigationBar() {
        title = "登录"
    }
    
    func bind() {
        contentView.loginButtonDelegator.delegate(on: self) {
            $0.loginButtonAction(mobile: $1.0, password: $1.1)
        }
        
        contentView.registerButtonDelegator.delegate(on: self) {_,_ in
            Router.push(to: "RegisterViewController")
        }
    }
}


// MARK: - Internal

extension LoginViewController {
    
    func loginButtonAction(mobile: String?, password: String?) {
        
        guard let mobile = mobile, !mobile.isEmpty else {
            Toast.text("Error", subtitle: "请输入手机号").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        guard let password = password, !password.isEmpty else {
            Toast.text("Error", subtitle: "请输入密码").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        loginTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                logger.debug("logining mobile:\(mobile) password:\(password)")
                try await provider.login(mobile:mobile, password: password)
                Toast.text("Success").show()
                enterAppCallback?()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        loginTask = task
    }
}


extension LoginViewController: TypeNameable {}

extension LoginViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return LoginViewController()
    }

    static let routeName: String = typeName
}
