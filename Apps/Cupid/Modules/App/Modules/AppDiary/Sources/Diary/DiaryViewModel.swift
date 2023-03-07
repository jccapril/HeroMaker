//
//  DiaryViewModel.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Center
import Foundation
import UICore

class DiaryViewModel: ViewModel {
    private(set) lazy var diaryListViewModels: [DiaryItemViewModel] = .init()
    private(set) var index: UInt = 1
}

extension DiaryViewModel {
    
    func update(items: [DiaryItemViewModel]) {
        self.diaryListViewModels = items
    }
    
//    func update(response: ListResponse, isRefresh: Bool) {
//        let wallpaperListViewModels = response.wallpapers.map {
//            DiscoveryItemViewModel(model: $0)
//        }
//        if isRefresh {
//            self.wallpaperListViewModels.removeAll()
//        }
//        index = response.meta.currentPage
//        self.wallpaperListViewModels.append(contentsOf: wallpaperListViewModels)
//    }
}
