//
//  AppMine.swift
//  AppMine
//
//  Created by jcc on 2023/3/1.
//

import BaseUI
import UIRoute

public let mineNavigationControllerType: NavigationController.Type = MineNavigationController.self

public let routableViewControllers: [Routable.Type] = [
    MineViewController.self,
]

public let actions: [Actable.Type] = []
