//
//  TencentCOSCenterContextual.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import Foundation

public protocol TencentCOSCenterContextual {
    func getUploadToken(type: Int) async throws -> COSUploadConfiguration?
}


