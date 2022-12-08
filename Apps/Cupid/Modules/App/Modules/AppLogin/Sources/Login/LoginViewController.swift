//
//  LoginViewController.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import CenterAPI
import UICore
import WeakDelegate

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
        bind()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.pin.all(view.pin.safeArea)
    }
}

// MARK: - Private

private extension LoginViewController {
    func setup() {
        contentView.x.add(to: view)
    }
    
    func bind() {
        contentView.loginButtonDelegator.delegate(on: self) {
            $0.loginButtonAction(username: $1.0, password: $1.1)
        }
    }
}


// MARK: - Internal

extension LoginViewController {
    
    func loginButtonAction(username: String?, password: String?) {
        
        guard let username = username, !username.isEmpty else {
            Toast.text("Error", subtitle: "用户名不能为空", config: ToastConfiguration(view: self.view)).show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        guard let password = password, !password.isEmpty else {
            Toast.text("Error", subtitle: "密码不能为空", config: ToastConfiguration(view: self.view)).show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        loginTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                logger.debug("logining usernmae:\(username) password:\(password)")
                try await provider.sign(username: username, password: password)
                Toast.text("Success", config: ToastConfiguration(view: self.view)).show()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
            } catch {
                Toast.text("Error", subtitle: "\(error)", config: ToastConfiguration(view: self.view)).show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        loginTask = task
    }
}
