//
//  BootstrapModule.swift
//  AppBootstrap
//
//  Created by jcc on 2022/12/1.
//

import AppModular
import Center
import LoggerPool
import Service
import UICore

typealias Module = BootstrapModule

let logger = Module.logger

class BootstrapModule: Modular {}

extension BootstrapModule {
    static let logger = Loggers[typeName]
}

extension BootstrapModule {
    static var bootComplete: Optional<BootComplete> = .none
}

extension BootstrapModule {
    static func boot() -> Result<Void, Error> {
        ServiceModule.bootstrap()
        CenterModule.bootstrap()
        UICoreModule.bootstrap()
        return .success
    }
}
