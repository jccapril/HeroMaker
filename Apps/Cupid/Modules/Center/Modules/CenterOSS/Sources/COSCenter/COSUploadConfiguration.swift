//
//  COSUploadConfiguration.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import Foundation
import Coder

public enum DataType: String, Codable {
    case pic = "pic"
    case video = "video"
    case audio = "audio"
}

public struct COSUploadConfiguration: Codable {
    public let tmpSecretID: String
    public let tmpSecretKey: String
    public let token: String
    public let bucket: String
    public let region: String
    public let path: String?
    public let prefix: String?
    public let tokenStartedAt: Date?
    public let tokenExpiredAt: Date?
   
    public init(secretID: String, secretKey: String, token: String, startDate: String, expirationDate: String, region: String, bucket: String, prefix: String?, path: String?) {
        self.tmpSecretID = secretID
        self.tmpSecretKey = secretKey
        self.token = token
        self.tokenExpiredAt = Date.from(expirationDate)
        self.tokenStartedAt = Date.from(startDate)
        self.region = region
        self.bucket = bucket
        self.prefix = prefix
        self.path = path
    }
}

