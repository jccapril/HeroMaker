//
// Created by jcc on 2022/2/18.
//

import LMDB
import Locks

public class Container {
    public let path: String
    private let environment: Environment
    private let readWriteLock = ReadWriteLock()

    private var stores: [String: Store] = [:]

    public init(path: String, maxStore: UInt32 = 256) throws {
        self.path = path
        environment = try Environment(path: path, maxDBs: maxStore)
    }
}

public extension Container {
    subscript(name: String) -> () throws -> Store {
        { [self] in try store(name: name) }
    }
}

private extension Container {
    func store(name: String) throws -> Store {
        let store = try readWriteLock.withReaderLock { stores[name] } ?? readWriteLock.withWriterLock {
            let store = try Store(name: name, environment: environment)
            return store
        }
        return store
    }
}
