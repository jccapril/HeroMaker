//
//  RegisterViewController.swift
//  AppLogin
//
//  Created by jcc on 2022/12/16.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class RegisterViewController: ViewController {
    private lazy var contentView = RegisterContentView()
    private lazy var provider = RegisterProvider()
    private var registerTask: Task<Void, Never>? = .none
}


// MARK: - Override
extension RegisterViewController {
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

private extension RegisterViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    
    func setupNavigationBar() {
        title = "注册"
    }
    
    func bind() {
        contentView.registerButtonDelegator.delegate(on: self) {
            $0.registerButtonAction(name: $1.0, mobile: $1.1, password: $1.2)
        }
    }
}


// MARK: - Internal

extension RegisterViewController {
    
    func registerButtonAction(name: String?, mobile: String?, password: String?) {
        
        guard let name = name, !name.isEmpty else {
            Toast.text("Error", subtitle: "用户名不能为空").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        guard let mobile = mobile, !mobile.isEmpty else {
            Toast.text("Error", subtitle: "手机号不能为空").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        guard let password = password, !password.isEmpty else {
            Toast.text("Error", subtitle: "密码不能为空").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }

        registerTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                logger.debug("registering nmae:\(name) mobile:\(mobile) password:\(password)")
                try await provider.register(name:  name, mobile: mobile, password: password)
                Toast.text("Success").show()
                enterAppCallback?()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        registerTask = task
    }
}

extension RegisterViewController: TypeNameable {}

extension RegisterViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return RegisterViewController()
    }

    static let routeName: String = typeName
}

