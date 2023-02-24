//
//  CodeViewController.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class CodeViewController: ViewController {
    private let viewModel: CodeViewModel
    private lazy var contentView = CodeContentView()
    private lazy var provider = MobileProvider()
    private var task: Task<Void, Never>? = .none
    
    init(mobile: String) {
        viewModel = CodeViewModel(mobile: mobile)
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - Override
extension CodeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension CodeViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
        Task {
            contentView.reloadData(viewModel: viewModel)
        }
    }
    
    func layout() {
        contentView.pin.all(view.pin.safeArea)
    }
    
    func setupNavigationBar() {
        title = "手机号登录/注册"
    }
    
    func bind() {
        contentView.loginButtonDelegator.delegate(on: self) {
            $0.loginButtonAction(mobile: $0.viewModel.mobile, code: $1)
        }
    }
}


// MARK: - Internal

extension CodeViewController {
    
    func loginButtonAction(mobile: String?, code: String?) {
        guard let mobile = mobile, !mobile.isEmpty else {
            Toast.text("Error", subtitle: "请输入手机号").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        guard let code = code, !code.isEmpty else {
            Toast.text("Error", subtitle: "请输入验证码").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        task.run { $0.cancel() }
        let rtask = Task { @MainActor in
            do {
                logger.debug("login with mobile:\(mobile) code:\(code)")
                try await provider.login(mobile: mobile, code: code)
                Toast.text("登录成功").show()
                enterAppCallback?()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        task = rtask
    }
    
}

extension CodeViewController: TypeNameable {}

extension CodeViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        guard let mobile = values["mobile"] as? String else { return nil }
        return  CodeViewController(mobile: mobile)
    }
    
    static let routeName: String = typeName + "/<string:mobile>"
}





