//
//  DiscoveryNavigationController.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import UICore

class DiscoveryNavigationViewController: NavigationController {
    init() {
        super.init(rootViewController: DiscoveryViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension DiscoveryNavigationViewController {
    func setup() {
        tabBarItem = .init(title: "发现", image: .init(systemSymbol: .house), selectedImage: .init(systemSymbol: .houseFill))
        navigationBar.tintColor = .systemBlack
    }
}

