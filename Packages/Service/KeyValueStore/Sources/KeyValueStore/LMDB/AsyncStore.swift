//
// Created by jcc on 2022/2/18.
//

import Dispatch
import LMDB

public struct AsyncStore {
    private weak var database: Database?
    private let queue: DispatchQueue
    private let callbackQueue: DispatchQueue

    public init(database: Database?, queue: DispatchQueue = .main, callbackQueue: DispatchQueue = .main) {
        self.database = database
        self.queue = queue
        self.callbackQueue = callbackQueue
    }
}

public extension AsyncStore {
    func put<V: DataConvertible, K: DataConvertible>(key: K, value: V, complete: @escaping (Result<Void, Error>) -> Void) {
        queue.async {
            do {
                try database?.put(key: key, value: value)
                callbackQueue.async { complete(.success(())) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }

    func get<V: DataConvertible, K: DataConvertible>(key: K, complete: @escaping (Result<V?, Swift.Error>) -> Void) {
        queue.async {
            do {
                let value: V? = try database?.get(key: key)
                callbackQueue.async { complete(.success(value)) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }

    func delete<K: DataConvertible>(key: K, complete: @escaping (Result<Void, Swift.Error>) -> Void) {
        queue.async {
            do {
                try database?.deleteValue(forKey: key)
                callbackQueue.async { complete(.success(())) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }
}

public extension AsyncStore {
    func put<StorableObject: Storable>(storableObject: StorableObject, complete: @escaping (Result<Void, Swift.Error>) -> Void) {
        queue.async {
            do {
                let key = StorableObject.key
                try database?.put(key: key, value: storableObject)
                callbackQueue.async { complete(.success(())) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }

    func get<StorableObject: Storable>(complete: @escaping (Result<StorableObject?, Swift.Error>) -> Void) {
        queue.async {
            do {
                let key = StorableObject.key
                let value: StorableObject? = try database?.get(key: key)
                callbackQueue.async { complete(.success(value)) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }
}

public extension AsyncStore {
    func empty(complete: @escaping (Result<Void, Swift.Error>) -> Void) throws {
        queue.async {
            do {
                try database?.empty()
                callbackQueue.async { complete(.success(())) }
            } catch {
                callbackQueue.async { complete(.failure(error)) }
            }
        }
    }
}
