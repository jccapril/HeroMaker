//
//  OursNavigationController.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import UICore

class OursNavigationController: NavigationController {
    init() {
        super.init(rootViewController: OursViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension OursNavigationController {
    func setup() {
        tabBarItem = .init(title: "我们", image: .init(systemSymbol: .house), selectedImage: .init(UIImage(systemSymbol: .houseFill)))
        navigationBar.tintColor = .systemBlack
    }
}


