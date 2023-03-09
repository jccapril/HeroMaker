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
    
    private enum NavigationBarTheme {
        case white // 导航栏呈白色，字体呈黑色
        case translucent// 导航栏透明，显示底部背景色，字体呈白色
    }
    
    private var navigationBarTheme: NavigationBarTheme = .translucent {
        didSet {
            setupNavigationBar(theme: navigationBarTheme)
        }
    }

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(theme: navigationBarTheme)
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
    }
    
    @objc
    func addAction() {
        
    }
    
    
    private func setupNavigationBar(theme: NavigationBarTheme) {
        setNavigationBarBackgroundImage(image:  theme == .white ? UIImage(color: .systemWhite) : UIImage())
        setNavigationBarTintColor(tintColor: theme == .white ? .systemBlack : .systemWhite)
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

            if offsetY > 80 {
                self.navigationBarTheme = .white
            }else {
                self.navigationBarTheme = .translucent
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



