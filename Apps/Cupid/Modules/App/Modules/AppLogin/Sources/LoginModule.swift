//
//  LoginModule.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import AppModular
import LoggerPool
import UIKit

class LoginModule: Modular {}

extension LoginModule {
    static let logger = Loggers[typeName]
}

typealias Module = LoginModule

let logger = Module.logger
