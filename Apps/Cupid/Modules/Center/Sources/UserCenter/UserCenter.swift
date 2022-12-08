//
//  UserCenter.swift
//  Center
//
//  Created by jcc on 2022/12/8.
//

import Foundation
import KeyValueStore
import Service

public enum UserCenter {}

extension UserCenter: TypeNameable {}

extension UserCenter {
    static let container: Container = {
        do {
            let containerDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("KeyValueStores")
            let containerURL = containerDirectoryURL.appendingPathComponent(typeName)
            if !FileManager.default.fileExists(atPath: containerURL.path) {
                try FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
            }
            let container = try Container(path: containerURL.path, maxStore: 256)
            return container
        } catch {
            fatalError("\(error)")
        }
    }()
}


