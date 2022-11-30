//
// Created by jcc on 2022/3/14.
//

import LMDB

#if canImport(_Concurrency)
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public struct AwaitStore {
    private weak var database: Database?
    private let taskPriority: TaskPriority

    public init(database: Database?, taskPriority: TaskPriority = .userInitiated) {
        self.database = database
        self.taskPriority = taskPriority
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension AwaitStore {
    func put<Value: DataConvertible, Key: DataConvertible>(key: Key, value: Value) async throws {
        let task: Task<Void, Error> = Task.detached(priority: taskPriority) {
            try database?.put(key: key, value: value)
        }
        return try await task.value
    }

    func get<Value: DataConvertible, Key: DataConvertible>(key: Key) async throws -> Value? {
        let task: Task<Value?, Error> = Task.detached(priority: taskPriority) {
            try database?.get(key: key)
        }
        return try await task.value
    }

    func delete<Key: DataConvertible>(key: Key) async throws {
        let task: Task<Void, Error> = Task.detached(priority: taskPriority) {
            try database?.deleteValue(forKey: key)
        }
        return try await task.value
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension AwaitStore {
    func put<StorableObject: Storable>(storableObject: StorableObject) async throws {
        let key = StorableObject.key
        try await put(key: key, value: storableObject)
    }

    func get<StorableObject: Storable>(key _: String? = nil) async throws -> StorableObject? {
        let key = StorableObject.key
        return try await get(key: key)
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension AwaitStore {
    func empty() async throws {
        let task: Task<Void, Error> = Task.detached(priority: taskPriority) { () in
            try database?.empty()
        }
        return try await task.value
    }
}
#endif
