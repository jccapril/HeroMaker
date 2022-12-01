//
//  TabBarModule.swift
//  AppTabBar
//
//  Created by jcc on 2022/12/1.
//

import AppModular
import LoggerPool

class TabBarModule: Modular {}

extension TabBarModule {
    static let logger = Loggers[typeName]
}

typealias Module = TabBarModule

let logger = Module.logger

