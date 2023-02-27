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

extension UserCenter {
    static func bootstrapUserInfo() {
        DispatchQueue(label: "Bootstrap").sync {
            do {
                userInfo = try store.sync.get()
            } catch {
                logger.error("\(error)")
            }
        }
    }
}



public extension UserCenter {
    
    static var isLogined: Bool  {
        (!Self.token.isNilOrEmpty) && (Self.userInfo != nil)
    }
    
    
    static var token: String?  {
        APICenter.token
    }
    
    
    private(set) static var userInfo: UserInfo? 
    {
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
        APICenter.setToken(token)
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
    
    @discardableResult
    static func updateUserInfo(name: String? = nil, gender: Int? = nil, birthday: String? = nil, avatar: String? = nil) async throws -> UserInfo {
        let userInfo = try await APICenter.updateUserInfo(name: name, gender: gender, birthday: birthday, avatar: avatar)
        updateUserInfo(userInfo: userInfo)
        return userInfo
    }
}

