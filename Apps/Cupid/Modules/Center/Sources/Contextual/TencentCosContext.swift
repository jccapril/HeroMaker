//
//  TencentCosContext.swift
//  Center
//
//  Created by jcc on 2023/3/9.
//

import Foundation

class TencentCOSContext: TencentCOSCenterContextual {
    func getUploadToken(type: Int) async throws -> COSUploadConfiguration? {
        try await APICenter.Upload.getUploadToken(type: type)
    }
}
