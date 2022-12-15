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
    static let key = "USERINFO_KEY"
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
    

    
}
