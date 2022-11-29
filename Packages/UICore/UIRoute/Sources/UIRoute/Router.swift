//
//  Created by jcc on 2022/11/28.
//

#if canImport(UIKit)

import UIKit
import URLRoute

public enum Router {}

private extension Router {
    static let navigator = URLRouter()
    static let scheme: String = {
        let bundleName: String = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String).unsafelyUnwrapped
        return bundleName + "://"
    }()
}

public extension Router {
    typealias ViewControllerRegisterCallback = (_ urlPattern: String) -> Void
    typealias URLHandleRegisterCallback = (_ urlPattern: String) -> Void
    typealias ViewControllerNotFoundCallback = (_ urlPattern: String) -> Void

    @discardableResult
    static func register(viewControllerRegisterCallback: @escaping ViewControllerRegisterCallback) -> Router.Type {
        self.viewControllerRegisterCallback = viewControllerRegisterCallback
        return self
    }

    @discardableResult
    static func register(urlHandleRegisterCallback: @escaping URLHandleRegisterCallback) -> Router.Type {
        self.urlHandleRegisterCallback = urlHandleRegisterCallback
        return self
    }

    @discardableResult
    static func register(viewControllerNotFoundCallback: @escaping ViewControllerNotFoundCallback) -> Router.Type {
        self.viewControllerNotFoundCallback = viewControllerNotFoundCallback
        return self
    }
}

private extension Router {
    static var viewControllerRegisterCallback: ViewControllerRegisterCallback?
    static var urlHandleRegisterCallback: URLHandleRegisterCallback?
    static var viewControllerNotFoundCallback: ViewControllerNotFoundCallback?
}

public extension Router {
    static func register(routeName: String, factory: @escaping ViewControllerFactory) {
        let urlPattern = scheme + routeName
        navigator.register(urlPattern) { url, values, context in
            factory(url, values, context)
        }
        viewControllerRegisterCallback?(urlPattern)
    }

    static func register(actName: String, action: @escaping URLOpenHandlerFactory) {
        let urlPattern = scheme + actName
        navigator.handle(urlPattern) { url, values, context in
            action(url, values, context)
        }
        urlHandleRegisterCallback?(urlPattern)
    }
}

public extension Router {
    static func open(url: URL) {
        navigator.open(url)
    }

    static func push(to pattern: String) {
        let urlPattern = scheme + pattern
        switch navigator.push(urlPattern) {
        case .none:
            viewControllerNotFoundCallback?(urlPattern)
        case .some:
            return
        }
    }

    static func present(pattern: String) {
        let urlPattern = scheme + pattern
        switch navigator.present(urlPattern) {
        case .none:
            viewControllerNotFoundCallback?(urlPattern)
        case .some:
            return
        }
    }
}

#endif

