//
//  Upload.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/10.
//

import Coder
import DataConvert
import Foundation


public struct UploadTokenResponse: Codable {

    public let tmpSecretID: String
    public let tmpSecretKey: String
    public let token: String
    public let bucket: String
    public let region: String
    public let path: String?
    public let prefix: String?
    public let tokenStartedAt: String
    public let tokenExpiredAt: String

}


extension UploadTokenResponse: DataConvertible {
    public func toData() throws -> Data {
        try JSONCoder.encode(object: self)
    }
    public init(data: Data) throws {
        self = try JSONCoder.decode(data: data)
    }
}

