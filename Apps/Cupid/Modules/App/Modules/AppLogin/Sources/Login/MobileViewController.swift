//
//  MobileViewController.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class MobileViewController: ViewController {
    private lazy var contentView = MobileContentView()
    private lazy var provider = LoginProvider()
    private var sendSMStask: Task<Void, Never>? = .none
}


// MARK: - Override
extension MobileViewController {
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

private extension MobileViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    
    func setupNavigationBar() {
        title = "手机号登录/注册"
    }
    
    func bind() {
        contentView.sendSMSButtonDelegator.delegate(on: self) {
            $0.sendButtonAction(mobile: $1)
        }
    }
}


// MARK: - Internal

extension MobileViewController {
    
    func sendButtonAction(mobile: String?) {

        guard let mobile = mobile, !mobile.isEmpty else {
            Toast.text("Error", subtitle: "请输入手机号").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        sendSMStask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                logger.debug("send sms code with mobile:\(mobile)")
                try await provider.requestSMSCode(mobile: mobile)
                Router.push(to: "CodeViewController/\(mobile)")
                Toast.text("验证码发送成功").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        sendSMStask = task
    }
    
}

extension MobileViewController: TypeNameable {}

extension MobileViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        
        return  MobileViewController()
    }
    
    static let routeName: String = typeName
}



