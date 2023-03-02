//
//  SettingViewModel.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import ExtensionKit
import Foundation
import OrderedCollections
import UICore

class SettingViewModel: ViewModel {
    private(set) lazy var items: OrderedDictionary<SettingSection, [SettingItemViewModel]> = [
        
        SettingSection.account: [
            SettingItemViewModel(sectionID: 0, itemID: 0, title: "账户信息", separator: false, corners: .allCorners),
        ],
        SettingSection.privacy: [
            SettingItemViewModel(sectionID: 1, itemID: 0, title: "系统权限管理", corners: [.topLeft, .topRight]),
            SettingItemViewModel(sectionID: 1, itemID: 1, title: "个性化广告管理"),
            SettingItemViewModel(sectionID: 1, itemID: 2, title: "个人信息查看"),
            SettingItemViewModel(sectionID: 1, itemID: 3, title: "与第三方共用清单"),
            SettingItemViewModel(sectionID: 1, itemID: 4, title: "收集个人信息清单"),
            SettingItemViewModel(sectionID: 1, itemID: 5, title: "隐私保护声明", separator: false, corners: [.bottomLeft, .bottomRight]),
        ],
        SettingSection.app: [
            SettingItemViewModel(sectionID: 0, itemID: 1, title: "关于Cupid", separator: false, corners: .allCorners),
        ]
    ]
}

