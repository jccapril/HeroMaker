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
    
    static func bootstrapCoupleInfo() {
        DispatchQueue(label: "Bootstrap").sync {
            do {
                coupleInfo = try store.sync.get()
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
    
    
    static var isFinishUserInfo: Bool  {
        !((UserCenter.userInfo?.step == nil) || (UserCenter.userInfo?.step == 0))
    }
    
    static var hasCouple: Bool {
        coupleInfo != nil
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
    
    private(set) static var coupleInfo: CoupleInfo?
    {
        didSet {
            do {
                switch coupleInfo {
                case .none:
                    try store.sync.delete(key: CoupleInfo.key)
                case .some(let coupleInfo):
                    try store.sync.put(storableObject: coupleInfo)
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
    
    static func updateCoupleInfo(coupleInfo: CoupleInfo?) {
        self.coupleInfo = coupleInfo
    }
}


public extension UserCenter {
    @discardableResult
    static func getUserInfo() async throws -> UserInfo? {
        let userInfo = try await APICenter.getUserInfo()
        updateUserInfo(userInfo: userInfo)
        return userInfo
    }
    
    @discardableResult
    static func updateUserInfo(name: String? = nil, gender: Int? = nil, birthday: String? = nil, avatar: String? = nil) async throws -> UserInfo? {
        let userInfo = try await APICenter.updateUserInfo(name: name, gender: gender, birthday: birthday, avatar: avatar)
        updateUserInfo(userInfo: userInfo)
        return userInfo
    }
    
    @discardableResult
    static func getCoupleInfo() async throws -> CoupleInfo? {
        let coupleInfo = try await APICenter.getCoupleInfo()
        updateCoupleInfo(coupleInfo: coupleInfo)
        return coupleInfo
    }
    
    static func bootstrap() async throws {
        try await getUserInfo()
        try await getCoupleInfo()
    }
}



