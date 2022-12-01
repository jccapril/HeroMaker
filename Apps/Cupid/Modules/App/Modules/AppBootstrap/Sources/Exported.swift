//
//  Exported.swift
//  AppBootstrap
//
//  Created by jcc on 2022/12/1.
//

import BaseUI
import UIRoute

public let bootViewControllerType: ViewController.Type = BootViewController.self
public let diagnoseViewControllerType: ViewController.Type = DiagnoseViewController.self

public let routableViewControllers: [Routable.Type] = []

public let actions: [Actable.Type] = []

public typealias BootComplete = (Swift.Result<Void, Error>) -> Void

public func register(bootComplete: Optional<BootComplete>) {
    Module.bootComplete = bootComplete
}

