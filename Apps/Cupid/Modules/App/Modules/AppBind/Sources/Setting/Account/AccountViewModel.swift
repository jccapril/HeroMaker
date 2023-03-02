//
//  AccountViewModel.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//

import ExtensionKit
import Foundation
import OrderedCollections
import UICore
import Center

class AccountViewModel: ViewModel {
    private(set) lazy var items: OrderedDictionary<AccountSection, [SettingItemViewModel]> = .init()
}


extension AccountViewModel {
    func update(user: UserInfo) {
        items[AccountSection.mobile] = [
            SettingItemViewModel(sectionID: 0, itemID: 0, title: "手机", detailText: user.mobile, separator: false, chevron: false, corners: .allCorners),
        ]
        var gender: String
        switch user.gender {
        case 1:
            gender = "男"
        case 2:
            gender = "女"
        default:
            gender = "未选择"
        }
        items[AccountSection.info] = [
            SettingItemViewModel(sectionID: 1, itemID: 0, title: "头像", corners: [.topLeft, .topRight]),
            SettingItemViewModel(sectionID: 1, itemID: 1, title: "昵称", detailText: user.name),
            SettingItemViewModel(sectionID: 1, itemID: 2, title: "性别", detailText: gender),
            SettingItemViewModel(sectionID: 1, itemID: 3, title: "生日", detailText: user.getFormatBirthday, separator: false, corners: [.bottomLeft, .bottomRight]),
        ]
        
        items[AccountSection.bind] = [
            SettingItemViewModel(sectionID: 2, itemID: 0, title: "微信", detailText: "未绑定", corners: .allCorners),
        ]
        
        items[AccountSection.action] = [
            SettingItemViewModel(sectionID: 3, itemID: 0, title: "退出登录", chevron: false, corners: .allCorners),
        ]
    }
}

