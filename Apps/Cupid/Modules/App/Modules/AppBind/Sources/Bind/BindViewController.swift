//
//  BindViewController.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import CenterAPI
import UICore
import WeakDelegate
import Service


class BindViewController: ViewController {
    private lazy var contentView = BindContentView()
    private lazy var viewModel = BindViewModel()
    private lazy var provider = BindProvider()
    private var bindTask: Task<Void, Never>? = .none
}


// MARK: - Override
extension BindViewController {
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

private extension BindViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
        contentView.beginHeaderRefresh()
    }
    
    func setupNavigationBar() {
        title = "绑定情侣"
    }
    
    func bind() {
        contentView.headerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData()
                refresher.endRefreshing()
                self.contentView.reload(viewModel: self.viewModel)
            }
        }
        
        contentView.bindDelegator.delegate(on: self) {
            $0.bindAction(code: $1)
        }
    }
    

    
    func loadData() async {
        do {
            let code = try await provider.getCode()
            viewModel.code = code
            viewModel.user = nil
        } catch {
            logger.error("\(error)")
        }
    }
    
    func bindCouple(code: String, guid: String) async {
        ProgressHUD.show()
        do {
            try await provider.bind(code: code, guid: guid)
            enterAppCallback?()
        } catch {
            logger.error("\(error)")
            Toast.text("Error", subtitle: "\(error)").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
        }
        ProgressHUD.dismiss()
    }
}


// MARK: - Internal

extension BindViewController {
    
    func bindAction(code: String?) {
        
        

        
        guard let code = code, !code.isEmpty else {
            Toast.text("Error", subtitle: "配对码不能为空").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        bindTask.run { $0.cancel() }
        let task = Task { @MainActor in
            ProgressHUD.show()
            do {
                let user = try await provider.getCoupleUser(code: code)
                viewModel.user = user
                popupDialog(user: viewModel.user) { [weak self] in
                    guard let self = self else { return }
                    Task { @MainActor in
                        await self.bindCouple(code:code, guid: user?.guid ?? "")
                    }
                }
            } catch {
                
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
            ProgressHUD.dismiss()
        }
        bindTask = task
    }
    
    func popupDialog(user: UserInfo?, confirm: @escaping (()->Void) ) {
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color           = .clear
        overlayAppearance.blurEnabled     = false
        
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 20
        
        let vc = BindDialog()
        vc.reload(userInfo: user)
        // Create the dialog
        let dialog = PopupDialog(viewController: vc,
                                 transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        vc.action = { confirmed in
            dialog.dismiss(animated: true)
            if confirmed {
                confirm()
            }
        }
        present(dialog, animated: true)
    }
    
}

extension BindViewController: TypeNameable {}

extension BindViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return BindViewController()
    }
    
    static let routeName: String = typeName
}



