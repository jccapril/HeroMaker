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
    private lazy var provider = BindProvider()
    private var task: Task<Void, Never>? = .none
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
    }
    
    func setupNavigationBar() {
        title = "绑定"
    }
    
    func bind() {
        
    }
}


// MARK: - Internal

extension BindViewController {
    
    
    func action() {
        task.run { $0.cancel() }
        let rtask = Task { @MainActor in
            do {
                
                Toast.text("Success").show()
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

extension BindViewController: TypeNameable {}

extension BindViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return BindViewController()
    }
    
    static let routeName: String = typeName
}



