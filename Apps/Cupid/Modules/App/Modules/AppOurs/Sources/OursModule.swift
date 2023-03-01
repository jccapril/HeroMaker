//
//  OursModule.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import AppModular
import LoggerPool

class OursModule: Modular {}

extension OursModule {
    static let logger = Loggers[typeName]
}

typealias Module = OursModule

let logger = Module.logger



