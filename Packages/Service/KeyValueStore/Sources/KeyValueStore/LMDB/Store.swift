//
// Created by jcc on 2022/2/18.
//

import LMDB

public class Store {
    public let name: String

    private let database: Database

    public lazy var async = AsyncStore(database: database)
    public lazy var sync = SyncStore(database: database)
    #if canImport(_Concurrency)
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public var await: AwaitStore {
        return AwaitStore(database: database)
    }
    #endif
    
 

    public init(name: String, environment: Environment) throws {
        precondition(!name.isEmpty, "name is empty")
        self.name = name
        database = try environment.openDatabase(name: name)
    }
}
