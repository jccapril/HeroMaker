//
//  CupidAPIServiceContextual.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/7.
//

import Foundation

public protocol CupidAPIServiceContextual {
    // MARK: User

    var token: String { get }
    var guid: String { get }
    func unauthenticated()

    // MARK: App
//    var appVersionCode: Int64 { get }
//    var appVersion: String { get }
//    var appOS: Int64 { get }
}

