//
//  TencentCosContext.swift
//  Center
//
//  Created by jcc on 2023/3/9.
//

import Foundation

class TencentCOSContext: TencentCOSCenterContextual {
    func getUploadToken(type: Int) async throws -> COSUploadConfiguration? {
        guard let response = try await APICenter.Upload.getUploadToken(type: type) else {
            return nil
        }
        return COSUploadConfiguration(secretID: response.tmpSecretID, secretKey: response.tmpSecretKey, token: response.token, startDate: response.tokenStartedAt, expirationDate: response.tokenExpiredAt, region: response.region, bucket: response.bucket, prefix: response.prefix, path: response.path)
    }
}
