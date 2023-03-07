//
//  DiaryModule.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import AppModular
import LoggerPool

class DiaryModule: Modular {}

extension DiaryModule {
    static let logger = Loggers[typeName]
}

typealias Module = DiaryModule

let logger = Module.logger



