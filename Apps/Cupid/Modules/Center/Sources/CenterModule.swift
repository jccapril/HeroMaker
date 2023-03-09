//
//  CenterModule.swift
//  Center
//
//  Created by jcc on 2022/11/30.
//

import Service


public enum CenterModule {}

private extension CenterModule {
    static let logger = Loggers[String(describing: CenterModule.self)]
}

public extension CenterModule {
    static func bootstrap() {
        APICenter.bootstrap()
        UserCenter.bootstrap()
        WebServerCenter.bootstrap()
        TencentCOSCenter.register(context: TencentCOSContext())
    }
}

typealias Module = CenterModule

let logger =  Module.logger
