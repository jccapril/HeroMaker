//
//  Created by jcc on 2022/12/1.
//

import Foundation
import HummingbirdCore
import Logging
import NIO
import NIOHTTP1

class RootResponder {
    let logger: Logger
    let clientHandler: ClientHandle

    init(logger: Logger, clientHandler: ClientHandle) {
        self.logger = logger
        self.clientHandler = clientHandler
    }
}

extension RootResponder: HBHTTPResponder {
    func respond(to request: HBHTTPRequest, context: ChannelHandlerContext, onComplete: @escaping (Result<HBHTTPResponse, Error>) -> Void) {
        logger.debug("\(request)")

        clientHandler.execute(request: request, onComplete: onComplete)
    }
}
