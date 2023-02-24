//
//  WebBrowserModule.swift
//  AppWebBrowser
//
//  Created by jcc on 2022/12/2.
//

import AppModular
import LoggerPool

class WebBrowserModule: Modular {}

extension WebBrowserModule {
    static let logger = Loggers[typeName]
}

let logger = WebBrowserModule.logger
