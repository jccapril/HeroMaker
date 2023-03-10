//
//  UploadRequest.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/9.
//

import Foundation
import RestfulClient
import Coder

/// 发布日记
class GetUploadTokenRequest: BaseRequestable {
    let path: String = "/api/v1/upload/token"
    let method: HTTPMethod = .GET
    let queryItems: [URLQueryItem]?
    
    init(type: String) {
        self.queryItems = [URLQueryItem(name: "type", value: type)]
    }
}
