//
//  APICenterModule.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import AppModular
import Foundation
import LoggerPool

class APICenterModule: Modular {
    static let logger = Loggers[typeName]
}

typealias Module = APICenterModule

let logger = Module.logger

