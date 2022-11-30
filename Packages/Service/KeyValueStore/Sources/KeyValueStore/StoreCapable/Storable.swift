//
// Created by jcc on 2021/3/9.
//

import AppModular
import DataConvert

public protocol Storable: TypeNameable, DataConvertible {
    associatedtype KeyType: DataConvertible
    static var key: KeyType { get }
}
