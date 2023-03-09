//
//  APICenter.Upload.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/9.
//

import Foundation


public extension APICenter {
    enum Upload {}
}


public extension APICenter.Upload {
    // 获取OSS上传token
    static func getUploadToken<T: Codable>(type: Int) async throws -> T? {
        return nil
    }
}
