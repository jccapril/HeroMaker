//
//  DiaryRequest.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/8.
//

import Foundation
import RestfulClient
import Coder

/// 发布日记
class PublishDiaryRequest: BaseRequestable {
    let path: String = "/api/v1/diary/publish"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    
    init(text: String? = nil, pictures:[String]? = nil) {
        let object = PublishDiaryRequestBody(text: text, pictures: pictures)
        body = try? JSONCoder.encode(object: object).bytes
    }
}

fileprivate struct PublishDiaryRequestBody: Codable {
    let text: String?
    let pictures: [String]?
}
