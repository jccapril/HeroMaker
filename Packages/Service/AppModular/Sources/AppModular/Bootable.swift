//
//  File.swift
//  
//
//  Created by jcc on 2022/11/30.
//

public protocol Bootable {
    static var environment: Environmental { get }

    @discardableResult
    static func register(environment: Environmental) -> Self.Type

    @discardableResult
    static func bootstrap() -> Self.Type
}

