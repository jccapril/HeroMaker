//
//  LoginViewController.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class LoginViewController: ViewController {
    private lazy var contentView = LoginContentView()
}

// MARK: - Override
extension LoginViewController {
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

private extension LoginViewController {
    func setup() {
        setupNavigationBar()
        contentView.x.add(to: view)
        bind()
    }
    
    func setupNavigationBar() {
        title = ""
    }
    
    func bind() {
        contentView.mobileLoginButtonDelegator.delegate(on: self) { _,_ in
            Router.push(to: "MobileViewController")
        }
    }
}


// MARK: - Internal

extension LoginViewController {
    

}


extension LoginViewController: TypeNameable {}

extension LoginViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return LoginViewController()
    }

    static let routeName: String = typeName
}
