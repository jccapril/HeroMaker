//
//  BindModule.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import AppModular
import LoggerPool

class BindModule: Modular {}

extension BindModule {
    static let logger = Loggers[typeName]
}

typealias Module = BindModule

let logger = Module.logger

