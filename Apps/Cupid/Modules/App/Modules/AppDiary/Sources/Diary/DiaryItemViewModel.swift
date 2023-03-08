//
//  DiaryItemViewModel.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Center
import Foundation
import UICore

class DiaryItemViewModel: ViewModel {
    let id: Int
    var text: String?
    var avatar: URL?
    var images: [String]?
    var guid: String?
    var createdAt: Date?
    var day: Int?
    var coupleInfo: CoupleInfo?
    
    var isLast: Bool = false
    
    init(id:Int, coupleInfo:CoupleInfo?) {
        self.id = id
        self.coupleInfo = coupleInfo
    }
    
    init(diary: Diary) {
        self.id = diary.id
        self.text = diary.text
        self.guid = diary.createdBy
        self.createdAt = Date.from(diary.createdAt)
        
        guard let startedAt = Date.from(UserCenter.coupleInfo?.startedAt) else { return }
        guard let createdAt = self.createdAt else { return }
        let seconds =  Int(createdAt.timeIntervalSince1970 - startedAt.timeIntervalSince1970)
        self.day = seconds/(60*60*24)
    }
    
}

extension DiaryItemViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: DiaryItemViewModel, rhs: DiaryItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

