//
//  MineNavigationController.swift
//  AppMine
//
//  Created by jcc on 2023/3/1.
//

import UICore

class MineNavigationController: NavigationController {
    init() {
        super.init(rootViewController: MineViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension MineNavigationController {
    func setup() {
        tabBarItem = .init(title: "我", image: .init(systemSymbol: .person), selectedImage: .init(UIImage(systemSymbol: .personFill)))
        navigationBar.tintColor = .systemBlack
    }
}


