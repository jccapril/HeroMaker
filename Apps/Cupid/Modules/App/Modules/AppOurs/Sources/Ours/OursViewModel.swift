//
//  OursViewModel.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import ExtensionKit
import Foundation
import OrderedCollections
import UICore

class OursViewModel: ViewModel {
    private(set) lazy var items: OrderedDictionary<OursSection, [OursItemViewModel]> = [
        
        OursSection.background: [
            OursItemViewModel(sectionID: 0, itemID: 0, title: "")
        ],
        OursSection.main: [
            OursItemViewModel(sectionID: 1, itemID: 0, title: "恋爱日记",corners: [.topLeft, .bottomLeft]),
            OursItemViewModel(sectionID: 1, itemID: 1, title: "悄悄话"),
            OursItemViewModel(sectionID: 1, itemID: 2, title: "恋爱相册"),
            OursItemViewModel(sectionID: 1, itemID: 3, title: "纪念日"),
            OursItemViewModel(sectionID: 1, itemID: 4, title: "情侣闹钟", corners: [.topRight, .bottomRight]),
        ],
        OursSection.secondary: [
            OursItemViewModel(sectionID: 2, itemID: 0, title: "情侣攒钱",corners: .allCorners),
            OursItemViewModel(sectionID: 2, itemID: 1, title: "桌面传图", corners: .allCorners),
        ],
        OursSection.other: [
            OursItemViewModel(sectionID: 3, itemID: 0, title: "恋爱日记", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 1, title: "悄悄话", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 2, title: "时光相册", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 3, title: "免单商城", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 4, title: "情侣小镇", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 5, title: "恋爱日记", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 6, title: "悄悄话", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 7, title: "时光相册", backgroundColor: .clear),
            OursItemViewModel(sectionID: 3, itemID: 8, title: "免单商城", backgroundColor: .clear),
        ]
    ]
}
