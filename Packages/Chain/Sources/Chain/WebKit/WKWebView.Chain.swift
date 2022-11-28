//
// Created by jcc on 2022/6/23.
//

#if canImport(WebKit)
import WebKit

public extension Box where T: WKWebView {
    @discardableResult
    func stopLoading() -> Box {
        subject.stopLoading()
        return subject.x
    }
}

#endif
