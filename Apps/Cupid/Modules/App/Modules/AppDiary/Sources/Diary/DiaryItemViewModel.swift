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
    let id: String
    let content: String?
    var avatar: URL?
    var images: [String]?

    init(id: String, content: String? = nil, avatar: String? = nil) {
        self.id = id
        self.content = content
        if let avatar = avatar {
            self.avatar = URL(string: avatar)
        }
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

