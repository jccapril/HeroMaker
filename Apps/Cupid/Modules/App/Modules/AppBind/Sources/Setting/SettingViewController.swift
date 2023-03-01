//
//  SettingViewController.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class SettingViewController: ViewController {
    private lazy var viewModel = SettingViewModel()
    private lazy var contentView = SettingContentView()
}


// MARK: - Override
extension SettingViewController {
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

private extension SettingViewController {
    func setup() {
        view.backgroundColor = .systemGray6
        contentView.x.add(to: view)
        Task { @MainActor in
            contentView.reloadData(viewModel: viewModel)
        }
    }
    func layout() {
        contentView.pin.all(view.pin.safeArea)
    }
    
    func setupNavigationBar() {
        title = "设置"
    }
    
    func bind() {
        contentView.didSelectedItemDelegator.delegate(on: self) { _, indexPath in
            switch (indexPath.section, indexPath.row) {
            
            default:
                logger.debug("section:\(indexPath.section), row:\(indexPath.row)")
                return
            }
        }
    }
}


// MARK: - Internal

extension SettingViewController {
    
//    func action() {
//        task.run { $0.cancel() }
//        let rtask = Task { @MainActor in
//            do {
//
//                Toast.text("Success").show()
//                FeedbackGenerator.notification.shared.notificationOccurred(.success)
//            } catch {
//                Toast.text("Error", subtitle: "\(error)").show()
//                FeedbackGenerator.notification.shared.notificationOccurred(.error)
//                logger.error("\(error)")
//            }
//        }
//        task = rtask
//    }
    
}

extension SettingViewController: TypeNameable {}

extension SettingViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return SettingViewController()
    }
    
    static let routeName: String = "Bind/\(typeName)"
}



