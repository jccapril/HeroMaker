//
//  OSSCenterModule.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import AppModular
import Foundation
import LoggerPool

class OSSCenterModule: Modular {
    static let logger = Loggers[typeName]
}

typealias Module = OSSCenterModule

let logger = Module.logger


