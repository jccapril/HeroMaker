//
//  UserCenter.UserInfo.swift
//  Center
//
//  Created by jcc on 2022/12/8.
//

import Foundation
import KeyValueStore
import Service

private extension UserCenter {
    static let name = typeName + ".userinfo"
    static let store: Store = {
        do {
            let store = try container[name]()
            return store
        } catch {
            fatalError("\(error)")
        }
    }()
}


public extension UserCenter {
    
    private(set) static var token: String? = {
        APICenter.token
    }() {
        didSet {
            switch token {
            case .none:
                APICenter.resetToken()
            case .some(let token):
                APICenter.setToken(token)
            }
        }
    }
    
    
    private(set) static var userInfo: UserInfo? = {
        do {
            guard let userInfo: UserInfo = try store.sync.get() else { return nil }
            return userInfo
        } catch {
            logger.error("\(error)")
            return nil
        }
    }() {
        didSet {
            do {
                switch userInfo {
                case .none:
                    try store.sync.delete(key: UserInfo.key)
                case .some(let userInfo):
                    try store.sync.put(storableObject: userInfo)
                }
            } catch {
                logger.error("\(error)")
            }
        }
    }
    
    
}

extension UserCenter {
    static func updateToken(token: String) {
        self.token = token
    }
    
    static func updateUserInfo(userInfo: UserInfo?) {
        self.userInfo = userInfo
    }
}


public extension UserCenter {
    @discardableResult
    static func getUserInfo() async throws -> UserInfo {
        let userInfo = try await APICenter.getUserInfo()
        updateUserInfo(userInfo: userInfo)
        return userInfo
    }
}

