//
// Created by jcc on 2022/6/23.
//

#if canImport(WebKit)
import WebKit

extension WKWebViewConfiguration: Compatible {}

extension WKProcessPool: Compatible {}

extension WKUserContentController: Compatible {}

extension WKWebsiteDataStore: Compatible {}

@available(iOS 13.0, *)
extension WKWebpagePreferences: Compatible {}

#endif
