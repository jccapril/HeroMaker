//
//  DiaryViewModel.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Center
import Foundation
import UICore
import OrderedCollections

class DiaryViewModel: ViewModel {
   
    private static let infoKey = -101
    
    private(set) lazy var keys: [Int] = [Self.infoKey]
    private(set) lazy var diaryListViewModels: OrderedDictionary<Int, [DiaryItemViewModel]> = [
        Self.infoKey: [DiaryItemViewModel(id: Self.infoKey, coupleInfo: UserCenter.coupleInfo)]
    ]
    private(set) var index: UInt = 1
}

extension DiaryViewModel {
    
    func update(response: [Diary], isRefresh: Bool) {
        
        if isRefresh {
            self.diaryListViewModels.removeAll()
            self.keys.removeAll()
            keys.append(Self.infoKey)
            self.diaryListViewModels[Self.infoKey] = [DiaryItemViewModel(id: Self.infoKey, coupleInfo: UserCenter.coupleInfo)]
        }
        var diaryListViewModels = response.map {
            DiaryItemViewModel(diary: $0)
        }
        diaryListViewModels.sort(by: { $0.createdAt?.timeIntervalSinceNow ?? 0 > $1.createdAt?.timeIntervalSinceNow ?? 0
        })
        diaryListViewModels.forEach {
            guard let day = $0.day else { return }
            $0.isLast = true
            if var list = self.diaryListViewModels[day] {
                list.last?.isLast = false
                list.append($0)
                self.diaryListViewModels[day] = list
            } else {
                self.diaryListViewModels[day] = [$0]
                self.keys.append(day)
            }
        }
        
    }
    
}
