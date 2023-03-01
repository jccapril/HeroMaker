//
//  MineViewController.swift
//  AppMine
//
//  Created by jcc on 2023/3/1.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class MineViewController: ViewController {
    private lazy var contentView = MineContentView(frame: .zero)
    private lazy var provider = MineProvider()
    private var task: Task<Void, Never>? = .none
}


// MARK: - Override
extension MineViewController {
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

private extension MineViewController {
    func setup() {
        contentView.x.add(to: view)
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

extension MineViewController {
    
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

extension MineViewController: TypeNameable {}

extension MineViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return MineViewController()
    }
    
    static let routeName: String = typeName
}



