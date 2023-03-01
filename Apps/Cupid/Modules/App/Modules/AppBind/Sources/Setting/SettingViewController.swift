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
//    private lazy var contentView = <#ContentView#>()
//    private lazy var provider = <#Provider#>()
//    private var task: Task<Void, Never>? = .none
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
        
    }
    func layout() {
        
    }
    
    func setupNavigationBar() {
        title = "设置"
    }
    
    func bind() {
        
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



