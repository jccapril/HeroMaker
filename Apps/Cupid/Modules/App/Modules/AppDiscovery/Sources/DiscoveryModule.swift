//
//  DiscoveryModule.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/2.
//

import AppModular
import LoggerPool

class DiscoveryModule: Modular {}

extension DiscoveryModule {
    static let logger = Loggers[typeName]
}

typealias Module = DiscoveryModule

let logger = Module.logger

