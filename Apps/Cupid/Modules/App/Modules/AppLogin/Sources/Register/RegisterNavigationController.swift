//
//  RegisterNavigationController.swift
//  AppLogin
//
//  Created by jcc on 2023/2/25.
//

import UICore

class RegisterNavigationController: NavigationController {
    init() {
        super.init(rootViewController: RegisterViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension RegisterNavigationController {
    func setup() {
        navigationBar.tintColor = .systemBlack
    }
}


