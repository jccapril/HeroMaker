//
//  Application.swift
//  App
//
//  Created by jcc on 2022/12/1.
//

import Foundation
import Service
import UICore
import UIKit

public enum Application {}

extension Application: TypeNameable {}

public extension Application {
    static let logger = Loggers[typeName]

    @DelayInit
    private(set) static var window: UIWindow
}

public extension Application {
    static func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) -> UIWindow? {
        guard let windowScene = (scene as? UIWindowScene) else { return nil }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        defer { setup() }
        return window
    }
}

private extension Application {
    static func setup() {
        switch diagnose() {
        case true:
            enterDiagnose()
        case false:
            enterBoot()
        }
    }

    static func diagnose() -> Bool {
        false
    }

    static func enterBoot() {
        AppBootstrap.register(bootComplete: bootComplete)
        window.rootViewController = AppBootstrap.bootViewControllerType.init()
    }

    static func enterDiagnose() {
        window.rootViewController = AppBootstrap.diagnoseViewControllerType.init()
    }

    static func bootComplete(result: Result<Void, Error>) {
        switch result {
        case .success:
            registerRoute().registerUI().enterUI()
        case let .failure(error):
            logger.error("\(error)")
        }
    }

    @discardableResult
    static func registerRoute() -> Self.Type {
        let routableList = AppTabBar.routableViewControllers +
            AppWebBrowser.routableViewControllers
        routableList.forEach {
            Router.register(routeName: $0.routeName, factory: $0.initialize)
        }

        let actionList = AppTabBar.actions
        actionList.forEach {
            Router.register(actName: $0.actName, action: $0.act)
        }
        return self
    }

    @discardableResult
    static func registerUI() -> Self.Type {
        BaseUI.register(
            viewWillAppearAction: {
                logger.trace("\($0) viewWillAppear")
            },
            viewWillDisappearAction: {
                logger.trace("\($0) viewWillDisappear")
            }
        )
        BaseUI.register(viewControllerDeinitAction: {
            logger.debug("\($0) deinit")
        })
        return self
    }

    @discardableResult
    static func enterUI() -> Self.Type {
        window.rootViewController = AppTabBar.appTabBarViewControllerType.init(viewControllers: [
            AppBootstrap.diagnoseViewControllerType.init(),
            AppBootstrap.diagnoseViewControllerType.init()
        ])
        return self
    }
}