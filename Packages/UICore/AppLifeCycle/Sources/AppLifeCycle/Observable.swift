//
//  Created by jcc on 2022/11/28.
//

import Foundation
import UIKit

public protocol Observable: AnyObject {
    func applicationWillTerminate()

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene)

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene)

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene)

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene)

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene)

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>)

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity)
}

public extension Observable {
    func applicationWillTerminate() {}

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_: UIScene) {}

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_: UIScene) {}

    @available(iOS 13.0, *)
    func sceneWillResignActive(_: UIScene) {}

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_: UIScene) {}

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_: UIScene) {}

    @available(iOS 13.0, *)
    func scene(_: UIScene, openURLContexts _: Set<UIOpenURLContext>) {}

    @available(iOS 13.0, *)
    func scene(_: UIScene, continue _: NSUserActivity) {}
}

