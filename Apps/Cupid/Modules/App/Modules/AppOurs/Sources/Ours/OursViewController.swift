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
    private lazy var viewModel = OursViewModel()
    private lazy var provider = OursProvider()
    private var task: Task<Void, Never>? = .none
}


// MARK: - Override
extension OursViewController {
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

private extension OursViewController {
    
    
    
    func setup() {
        contentView.x.add(to: view)
    }
    func layout() {
        contentView.pin.all()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Cupid"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        setupNavigationBar(theme: .translucent)
    }
    
    @objc
    func addAction() {
        
    }
    
    
    private enum NavigationBarTheme {
        case white // 导航栏呈白色，字体呈黑色
        case translucent// 导航栏透明，显示底部背景色，字体呈白色
    }
    
    private func setupNavigationBar(theme: NavigationBarTheme) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = theme == .white ? .systemWhite : .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: theme == .white ? UIColor.systemBlack : UIColor.systemWhite]
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = theme == .white ? UIColor.systemBlack : UIColor.systemWhite
    }
    
    func bind() {
        contentView.reloadData(viewModel: viewModel)
        
        contentView.didSelectedDelegator.delegate(on: self) { `self`, indexPath in
            switch (indexPath.section, indexPath.row) {
            case (1, 0):
                Router.push(to: "DiaryViewController")
            default:
                break
            }
            
        }
        
        contentView.didScrollDelegator.delegate(on: self) { `self`, offsetY in
            if offsetY > 100 {
                self.setupNavigationBar(theme: .white)
            }else {
                self.setupNavigationBar(theme: .translucent)
            }
        }
        
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



