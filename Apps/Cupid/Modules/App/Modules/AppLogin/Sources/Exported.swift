//
//  Exported.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import BaseUI
import UIRoute


public let loginNavigationControllerType: NavigationController.Type = LoginNavigationViewController.self

public let routableViewControllers: [Routable.Type] = []

public let actions: [Actable.Type] = []


public typealias EnterAppCallback = () -> Void
public var enterAppCallback: EnterAppCallback?
