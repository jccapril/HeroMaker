//
//  SettItemViewModel.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import UICore

class SettingItemViewModel: ViewModel {
    let sectionID: Int
    let itemID: Int
    let title: String
    let detailText: String?
    let separator: Bool
    let chevron: Bool
    init(sectionID: Int, itemID: Int, title: String, detailText: String? = nil, separator: Bool = true, chevron: Bool = true) {
        self.sectionID = sectionID
        self.itemID = itemID
        self.title = title
        self.detailText = detailText
        self.separator = separator
        self.chevron = chevron
        super.init()
    }
}

extension SettingItemViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sectionID)
        hasher.combine(itemID)
    }

    public static func == (lhs: SettingItemViewModel, rhs: SettingItemViewModel) -> Bool {
        lhs.sectionID == rhs.sectionID && lhs.itemID == rhs.itemID
    }
}
