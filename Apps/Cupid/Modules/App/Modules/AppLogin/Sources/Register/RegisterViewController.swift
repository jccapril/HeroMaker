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
import Center

class RegisterViewController: ViewController {
    private lazy var contentView = RegisterContentView()
    private lazy var viewModel = RegisterViewModel(name: UserCenter.userInfo?.name, gender: UserCenter.userInfo?.gender)
    private lazy var provider = RegisterProvider()
    private var updateTask: Task<Void, Never>? = .none
}


// MARK: - Override
extension RegisterViewController {
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

private extension RegisterViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    
    func layout() {
        contentView.pin.all(view.pin.safeArea)
    }
    
    func setupNavigationBar() {
        title = "完善信息"
    }
    
    func bind() {
        
        contentView.update(vm: viewModel)
        
        contentView.finishDelegator.delegate(on: self) {
            $0.finishAction(name: $0.viewModel.name, gender: $0.viewModel.gender)
            $1
        }
        
        contentView.nameChangeDelegator.delegate(on: self) {
            $0.viewModel.name = $1
        }
    
        contentView.genderChangeDelegator.delegate(on: self) {
            $0.viewModel.gender = $1
        }
        
        
    }
}


// MARK: - Internal

extension RegisterViewController {
    
    func finishAction(name: String?, gender: Int?) {
        guard let name = name, !name.isEmpty else {
            Toast.text("Error", subtitle: "请输入昵称").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        guard let gender = gender, gender != 0 else {
            Toast.text("Error", subtitle: "请选择昵称").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        updateTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                try await provider.updateUserInfo(name: name, gender: gender)
                Toast.text("修改成功").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
                enterAppCallback?()
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        updateTask = task
    }
    
}

extension RegisterViewController: TypeNameable {}

extension RegisterViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return RegisterViewController()
    }

    static let routeName: String = typeName
}

