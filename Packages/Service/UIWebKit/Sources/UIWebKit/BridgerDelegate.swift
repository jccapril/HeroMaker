//
// Created by jcc on 2022/6/22.
//

protocol BridgerDelegate: AnyObject {
    typealias CompletionHandler = (Optional<Any>, Optional<Error>) -> Void
    func evaluateJavascript(javascript: String, completion: CompletionHandler?)
}

extension BridgerDelegate {
    func evaluateJavascript(javascript: String) {
        evaluateJavascript(javascript: javascript, completion: .none)
    }
}
