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
   
    private(set) lazy var keys: [Int] = [-101]
    private(set) lazy var diaryListViewModels: OrderedDictionary<Int, [DiaryItemViewModel]> = [
        -101: [DiaryItemViewModel(coupleInfo: UserCenter.coupleInfo)]
    ]
    private(set) var index: UInt = 1
}

extension DiaryViewModel {
    
    func update(response: [Diary], isRefresh: Bool) {
        
        if isRefresh {
            self.diaryListViewModels.removeAll()
            self.keys.removeAll()
            keys.append(-101)
            self.diaryListViewModels[-101] = [DiaryItemViewModel(coupleInfo: UserCenter.coupleInfo)]
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
                keys.append(day)
            }
        }
        
    }
    
}
