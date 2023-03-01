//
//  AppTabBarViewController.swift
//  AppTabBar
//
//  Created by jcc on 2022/12/1.
//

import UICore

class AppTabBarViewController: TabBarViewController {}

extension AppTabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension AppTabBarViewController {
    func setup() {
        tabBar.tintColor = .systemBlack
        tabBar.backgroundColor = TabBarModule.color(name: "Tabbar.BackgoundColor")
        tabBar.isTranslucent = true
        delegate = self
    }
}

extension AppTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        FeedbackGenerator.selection.shared.selectionChanged()
    }
}

