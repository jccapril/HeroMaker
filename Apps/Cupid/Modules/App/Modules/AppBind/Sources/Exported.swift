//
//  Exported.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import BaseUI
import UIRoute

public let bindNavigationControllerType: NavigationController.Type = BindNavigationController.self

public let routableViewControllers: [Routable.Type] = [
    BindViewController.self,
]

public let actions: [Actable.Type] = []

public typealias EnterAppCallback = () -> Void
public var enterAppCallback: EnterAppCallback?
