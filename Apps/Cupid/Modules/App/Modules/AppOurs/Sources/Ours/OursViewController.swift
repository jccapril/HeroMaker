//
//  OursViewController.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class OursViewController: ViewController {
    private lazy var contentView = OursContentView(frame: .zero)
    private lazy var provider = OursProvider()
    private var task: Task<Void, Never>? = .none
}


// MARK: - Override
extension OursViewController {
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

private extension OursViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    func layout() {
        
    }
    
    func setupNavigationBar() {
//        title = ""
    }
    
    func bind() {
        
    }
}


// MARK: - Internal

extension OursViewController {
    
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

extension OursViewController: TypeNameable {}

extension OursViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return OursViewController()
    }
    
    static let routeName: String = typeName
}



