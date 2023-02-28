//
//  BootProdiver.swift
//  AppBootstrap
//
//  Created by jcc on 2023/2/28.
//

import Center
import Foundation
import UICore

class BootProvider: Provider {}


extension BootProvider {
    func bootstrap() async throws{
        try await UserCenter.bootstrap()
    }
}


