//
//  LoginNavigationViewController.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import UICore

class LoginNavigationViewController: NavigationController {
    init() {
        super.init(rootViewController: LoginViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension LoginNavigationViewController {
    func setup() {
        navigationBar.tintColor = .systemBlack
    }
}

