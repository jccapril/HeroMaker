//
//  COSConfigurationProvider.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import Foundation

public enum COSConfigurationProvider {}

extension COSConfigurationProvider {
    private(set) static var configuration: COSUploadConfiguration?
}

extension COSConfigurationProvider {
    static func asyncGetConfiguration(byType type: BusinessType = .image) async throws {
        if self.configuration != nil {
            return
        }
        configuration = try await TencentCOSCenter.context?.getUploadToken(type: Int(type.rawValue))
    }
}

