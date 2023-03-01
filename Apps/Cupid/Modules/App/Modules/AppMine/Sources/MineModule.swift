//
//  MineModule.swift
//  AppMine
//
//  Created by jcc on 2023/3/1.
//

import AppModular
import LoggerPool

class MineModule: Modular {}

extension MineModule {
    static let logger = Loggers[typeName]
}

typealias Module = MineModule

let logger = Module.logger


