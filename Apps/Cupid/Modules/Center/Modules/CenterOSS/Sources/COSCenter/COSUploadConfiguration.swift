//
//  COSUploadConfiguration.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import Foundation
import Coder

public enum DataType: Int, Codable {
    case pic = 1
    case video = 2
    case audio = 3
}

public struct COSUploadConfiguration: Codable {
    public let secretID: String
    public let secretKey: String
    public let token: String
    public let startDate: String
    public let expirationDate: String
    public let regionName: String
    public let bucket: String
    public let prefix: String
    public let paths: [DataType: String]

    public init(secretID: String, secretKey: String, token: String, startDate: String, expirationDate: String, regionName: String, bucket: String, prefix: String, paths: [DataType: String]) {
        self.secretID = secretID
        self.secretKey = secretKey
        self.token = token
        self.startDate = startDate
        self.expirationDate = expirationDate
        self.regionName = regionName
        self.bucket = bucket
        self.prefix = prefix
        self.paths = paths
    }
}

