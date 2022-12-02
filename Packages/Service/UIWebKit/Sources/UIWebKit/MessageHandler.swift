//
// Created by jcc on 2022/6/22.
//

import WebKit

class MessageHandler: NSObject {
    weak var bridger: Optional<Bridger>

    init(bridger: Optional<Bridger>) {
        self.bridger = bridger
        super.init()
    }
}

extension MessageHandler: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let pipeType = PipeType(rawValue: message.name) else {
            bridger.map { $0.handle(error: .unknown(message: message)) }
            return
        }

        switch pipeType {
        case .normal:
            guard let body = message.body as? String else { return }
            bridger.map { $0.flush(messageQueueString: body) }
        case .console:
            bridger.map { $0.console(data: message.body) }
        }
    }
}
