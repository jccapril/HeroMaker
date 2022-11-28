//
// Created by jcc on 2022/6/23.
//

#if canImport(WebKit)
import WebKit

public extension Box where T: WKWebViewConfiguration {
    @available(iOS 11.0, *)
    @discardableResult
    func setURLSchemeHandler(_ urlSchemeHandler: WKURLSchemeHandler?, forURLScheme urlScheme: String) -> Box {
        subject.setURLSchemeHandler(urlSchemeHandler, forURLScheme: urlScheme)
        return subject.x
    }
}

#endif
