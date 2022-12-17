//
//  BindNavigationController.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import UICore

class BindNavigationController: NavigationController {
    init() {
        super.init(rootViewController: BindViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension BindNavigationController {
    func setup() {
        navigationBar.tintColor = .systemBlack
    }
}


