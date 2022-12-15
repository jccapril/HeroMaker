//
// Created by jcc on 2022/6/22.
//

import WebKit

public extension JavascriptBridge {
    enum Error: Swift.Error {
        case unknown(message: WKScriptMessage)
        case noHandler(message: Message)
    }
}
