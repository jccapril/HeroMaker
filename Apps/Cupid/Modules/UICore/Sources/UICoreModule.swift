//
//  UICoreModule.swift
//  UICore
//
//  Created by jcc on 2022/12/1.
//

import Service
import ProxyServer

public enum UICoreModule {}

public extension UICoreModule {
    static func bootstrap() {
        Router
            .register(viewControllerRegisterCallback: {
                routerLogger.debug("ViewController registered => \($0)")
            })
            .register(urlHandleRegisterCallback: {
                routerLogger.debug("URLHandler registered => \($0)")
            })
            .register(viewControllerNotFoundCallback: {
                routerLogger.error("no view controller for \($0)")
            })
        
        AsyncImageManager.setupProxy(host: "127.0.0.1", port: 9528, originalHeaderField: HTTPHeaderField.originalURLForProxy).setupCache()
        
        UIDialogManager.setupDefaultAppearance()
        
    }
}

private extension UICoreModule {
    static let routerLogger = Loggers[String(describing: Router.self)]
}

