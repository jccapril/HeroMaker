//
//  DiaryProvider.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Center
import Foundation
import UICore

class DiaryProvider: Provider {}


extension DiaryProvider {
    func publish(text: String? = nil, pictures: [String]? = nil) async throws {
        try await APICenter.Diary.publish(text: text, pictures: pictures)
    }
    
    @discardableResult
    func getDiaryList() async throws -> [Diary]? {
        try await APICenter.Diary.getDiaryList()
    }
    
}


