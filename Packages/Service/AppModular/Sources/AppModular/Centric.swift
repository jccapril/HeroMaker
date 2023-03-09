//
//  File.swift
//  
//
//  Created by jcc on 2023/3/9.
//

import Foundation

public protocol Centric: TypeNameable {
    static var queue: DispatchQueue { get }
}

public extension Centric {
    static var mainQueue: DispatchQueue { DispatchQueue.main }
}
