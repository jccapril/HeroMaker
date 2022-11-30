//
// Created by jcc on 2022/2/18.
//

import LMDB

public struct SyncStore {
    private weak var database: Database?

    public init(database: Database?) { self.database = database }
}

public extension SyncStore {
    func put<Value: DataConvertible, Key: DataConvertible>(key: Key, value: Value) throws {
        try database?.put(key: key, value: value)
    }

    func get<Value: DataConvertible, Key: DataConvertible>(key: Key) throws -> Value? {
        try database?.get(key: key)
    }

    func delete<Key: DataConvertible>(key: Key) throws {
        try database?.deleteValue(forKey: key)
    }
}

public extension SyncStore {
    func put<StorableObject: Storable>(storableObject: StorableObject) throws {
        let key = StorableObject.key
        try put(key: key, value: storableObject)
    }

    func get<StorableObject: Storable>(key _: String? = nil) throws -> StorableObject? {
        let key = StorableObject.key
        return try get(key: key)
    }
}

public extension SyncStore {
    func empty() throws {
        try database?.empty()
    }
}
