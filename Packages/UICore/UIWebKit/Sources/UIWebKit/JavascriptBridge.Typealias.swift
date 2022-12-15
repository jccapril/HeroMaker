//
// Created by jcc on 2022/6/22.
//

public extension JavascriptBridge {
    typealias Callback = (_ responseData: Optional<Any>) -> Void
    typealias Handler = (_ parameters: Optional<[String: Any]>, _ callback: Optional<Callback>) -> Void
    typealias Message = [String: Any]

    typealias ConsoleCallback = (Any) -> Void
    typealias OnErrorCallback = (_ error: Swift.Error) -> Void
}
