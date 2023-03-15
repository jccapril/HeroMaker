//
//  DiaryProvider.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Center
import Foundation
import UICore
import Service

class DiaryProvider: Provider {}

extension DiaryProvider: TypeNameable {}

extension DiaryProvider {
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
    
    static let name = typeName + ".picture"
    static let store: Store = {
        do {
            let store = try container[name]()
            return store
        } catch {
            fatalError("\(error)")
        }
    }()
}

extension DiaryProvider {
    func publish(text: String? = nil, pictures: [String]? = nil) async throws {
        try await APICenter.Diary.publish(text: text, pictures: pictures)
    }
    
    @discardableResult
    func getDiaryList() async throws -> [Diary]? {
        try await APICenter.Diary.getDiaryList()
    }
    
}


