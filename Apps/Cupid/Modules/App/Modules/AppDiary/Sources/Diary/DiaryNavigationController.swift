//
//  DiaryNavigationController.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import UICore

class DiaryNavigationController: NavigationController {
    init() {
        super.init(rootViewController: DiaryViewController(nibName: nil, bundle: nil))
        setup()
    }
}

private extension DiaryNavigationController {
    func setup() {
        navigationBar.tintColor = .systemBlack
    }
}


