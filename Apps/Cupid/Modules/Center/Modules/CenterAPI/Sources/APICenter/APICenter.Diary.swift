//
//  APICenter.Diary.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/8.
//

import Foundation


public extension APICenter {
    enum Diary {}
}


public extension APICenter.Diary {
    // 发布日记
    static func publish(text: String? = nil, pictures: [String]? = nil) async throws {
        let request = PublishDiaryRequest(text: text, pictures: pictures)
        let _: NullResponse? = try await APICenter.execute(request)
    }
    
    // 获取日记列表
    static func getDiaryList() async throws -> [Diary]? {
        let request = GetDiaryListRequest()
        return try await APICenter.execute(request)
    }
    
}

