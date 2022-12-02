//
// Created by jcc on 2022/6/22.
//

import Foundation

class Bridger {
    private weak var delegate: Optional<Delegate>
    private var responseCallbacks = [String: Callback]()
    private var uniqueID = 0

    private var consoleCallback: Optional<ConsoleCallback> = .none
    private var onErrorCallback: Optional<OnErrorCallback> = .none

    var messageHandlers = [String: Handler]()

    init(delegate: Optional<Delegate>) { self.delegate = delegate }
}

extension Bridger {
    typealias Callback = JavascriptBridge.Callback
    typealias Handler = JavascriptBridge.Handler
    typealias Message = JavascriptBridge.Message

    typealias ConsoleCallback = JavascriptBridge.ConsoleCallback
    typealias OnErrorCallback = JavascriptBridge.OnErrorCallback

    typealias Delegate = BridgerDelegate
    typealias Error = JavascriptBridge.Error
}

extension Bridger {
    func register(consoleCallback: Optional<ConsoleCallback>) {
        self.consoleCallback = consoleCallback
    }

    func register(onErrorCallback: Optional<OnErrorCallback>) {
        self.onErrorCallback = onErrorCallback
    }
}

extension Bridger {
    func reset() {
        responseCallbacks.removeAll()
        uniqueID = 0
    }

    func send(handlerName: String, data: Optional<Any>, callback: Optional<Callback>) {
        var message = Message()
        message["handlerName"] = handlerName
        if data != nil {
            message["data"] = data
        }
        if callback != nil {
            uniqueID += 1
            let callbackID = "objc_cb_\(uniqueID)"
            responseCallbacks[callbackID] = callback
            message["callbackId"] = callbackID
        }
        dispatch(message: message)
    }

    func flush(messageQueueString: String) {
        guard let message: Message = deserialize(messageJSON: messageQueueString) else { return }

        switch message["responseId"] as? String {
        case let .some(responseID):
            guard let callback = responseCallbacks[responseID] else { return }
            callback(message["responseData"])
            responseCallbacks.removeValue(forKey: responseID)
        case .none:
            let callback: Callback
            switch message["callbackId"] as? String {
            case let .some(callbackID):
                callback = { (_ responseData: Optional<Any>) in
                    let msg = ["responseId": callbackID, "responseData": responseData ?? NSNull()] as Message
                    self.dispatch(message: msg)
                }
            case .none:
                callback = { (_: Optional<Any>) in }
            }

            guard let handlerName = message["handlerName"] as? String else { return }
            guard let handler = messageHandlers[handlerName] else {
                onErrorCallback.map { $0(Error.noHandler(message: message)) }
                return
            }
            handler(message["data"] as? Message, callback)
        }
    }

    func console(data: Any) {
        consoleCallback.map { $0(data) }
    }

    func handle(error: Error) {
        onErrorCallback.map { $0(error) }
    }
}

private extension Bridger {
    func dispatch(message: Message) {
        guard var messageJSON = serialize(message: message, pretty: false) else { return }

        messageJSON = messageJSON.replacingOccurrences(of: "\\", with: "\\\\")
        messageJSON = messageJSON.replacingOccurrences(of: "\"", with: "\\\"")
        messageJSON = messageJSON.replacingOccurrences(of: "\'", with: "\\\'")
        messageJSON = messageJSON.replacingOccurrences(of: "\n", with: "\\n")
        messageJSON = messageJSON.replacingOccurrences(of: "\r", with: "\\r")
        messageJSON = messageJSON.replacingOccurrences(of: "\u{000C}", with: "\\f")
        messageJSON = messageJSON.replacingOccurrences(of: "\u{2028}", with: "\\u2028")
        messageJSON = messageJSON.replacingOccurrences(of: "\u{2029}", with: "\\u2029")

        let javascriptCommand = "WebViewJavascriptBridge.handleMessageFromNative('\(messageJSON)');"
        if Thread.current.isMainThread {
            delegate?.evaluateJavascript(javascript: javascriptCommand)
        } else {
            DispatchQueue.main.async {
                self.delegate?.evaluateJavascript(javascript: javascriptCommand)
            }
        }
    }
}

private extension Bridger {
    func serialize(message: Message, pretty: Bool) -> Optional<String> {
        var result: Optional<String> = .none
        do {
            let data = try JSONSerialization.data(withJSONObject: message, options: pretty ? [.prettyPrinted] : [])
            result = String(data: data, encoding: .utf8)
        } catch {
            onErrorCallback.map { $0(error) }
        }
        return result
    }

    func deserialize(messageJSON: String) -> Optional<Message> {
        var result: Optional<Message> = .none
        guard let data = messageJSON.data(using: .utf8) else { return nil }
        do {
            result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Message
        } catch {
            onErrorCallback.map { $0(error) }
        }
        return result
    }
}
