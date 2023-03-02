//
//  AccountViewController.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//


import CenterAPI
import UICore
import WeakDelegate
import Service
import Center

class AccountViewController: ViewController {
    private lazy var contentView = AccountContentView()
    private lazy var provider = AccountProvider()
    private lazy var viewModel = AccountViewModel()
    deinit {
        UserCenter.removeUserInfoChangeHandler(handler: self)
    }
}


// MARK: - Override
extension AccountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
        bind()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    

}

// MARK: - Private

private extension AccountViewController {
    func setup() {
        contentView.x.add(to: view)
        loadLocalData()
    }
    func layout() {
        contentView.pin.all(view.pin.safeAreaWithoutBottom)
    }
    
    func setupNavigationBar() {
        title = "账户信息"
    }
    
    func bind() {
        UserCenter.appendUserInfoChangeHandler(handler: self)
        contentView.headerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData()
                refresher.endRefreshing()
//                self.contentView.reloadData(viewModel: self.viewModel)
            }
        }
        contentView.didSelectedItemDelegator.delegate(on: self) { `self`, indexPath in
            switch (indexPath.section, indexPath.row) {
            case (1, 2):
                let actionSheet = UIAlertController(title: "选择性别", message: nil, preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "男", style: .default, handler: { _ in
                    Task {[weak self] in
                        guard let self = self else { return }
                        await self.changeGender(gender: 1)
                    }
                }))
                actionSheet.addAction(UIAlertAction(title: "女", style: .default, handler: { _ in
                    Task {[weak self] in
                        guard let self = self else { return }
                        await self.changeGender(gender: 2)
                    }
                }))
                
                actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel))
                
                self.present(actionSheet, animated: true)
                
            case (3, 0):
                let overlayAppearance = PopupDialogOverlayView.appearance()
                overlayAppearance.color           = .clear
                overlayAppearance.blurEnabled     = false
                let containerAppearance = PopupDialogContainerView.appearance()
                containerAppearance.cornerRadius = 20
                let dialog = PopupDialog(title: "确定退出登录吗？", message: "", buttonAlignment: .horizontal, transitionStyle: .zoomIn)
                let cancelButton = CancelButton(title: "取消", action: nil)
                let confirmButton = DefaultButton(title: "确定", dismissOnTap: false) {
                    UserCenter.Sign.signout()
                }
                dialog.addButtons([cancelButton, confirmButton])
                self.present(dialog, animated: true)
            default:
                logger.debug("section:\(indexPath.section), row:\(indexPath.row)")
                return
            }
        }
    }
    
    func loadLocalData() {
        guard let user = UserCenter.userInfo else {
            Toast.text("Error", subtitle: "用户信息不存在").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        viewModel.update(user: user)
        contentView.reloadData(viewModel: viewModel)
    }
    
    func loadData() async {
        do {
            try await provider.loadUserInfo()
        } catch {
            logger.error("\(error)")
        }
    }
    
    func changeGender(gender: Int) async {
        do {
            try await self.provider.updateUserInfo(gender: gender)
            Toast.text("修改成功").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.success)
        }catch {
            logger.error("\(error)")
            Toast.text("Error", subtitle: "修改失败").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
        }
    }
    
}

extension AccountViewController: UserInfoChangeProtocol {
    
    func userInfoDidChange() {
        loadLocalData()
    }
}


extension AccountViewController: TypeNameable {}

extension AccountViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return AccountViewController()
    }
    
    static let routeName: String = "Bind/\(typeName)"
}



