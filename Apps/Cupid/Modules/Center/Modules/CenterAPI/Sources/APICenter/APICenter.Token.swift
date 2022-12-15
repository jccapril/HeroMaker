//
//  APICenter.APIKey.swift
//  CenterAPI
//
//  Created by jcc on 2022/11/30.
//

import Dispatch
import Foundation
import KeyValueStore

public extension APICenter {
    private(set) static var token: Optional<String> = .none
}

extension APICenter {
    static func bootstrapToken() {
        DispatchQueue(label: "Bootstrap").sync {
            do {
                token = try store.sync.get(key: key)
            } catch {
                logger.error("\(error)")
            }
        }
    }
}

private extension APICenter {
    static let name = typeName + ".token"
    static let key = "TOKEN_KEY"
    static let store: Store = {
        do {
            let store = try container[name]()
            return store
        } catch {
            fatalError("\(error)")
        }
    }()
}

public extension APICenter {
    static func setToken(_ token: String) {
        self.token = token
        enterAppCallback?()
        store.async.put(key: key, value: token) { result in
            switch result {
            case .success: logger.info("set token \(token) success")
            case let .failure(error): logger.error("\(error)")
            }
        }
    }

    static func resetToken() {
        token = .none
        enterAppCallback?()
        store.async.delete(key: key) { result in
            switch result {
            case .success: logger.info("reset token success")
            case let .failure(error): logger.error("\(error)")
            }
        }
    }
}

