//
//  SettingSection.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

enum SettingSection: CaseIterable, Section {
    case account
    case privacy
    case app
}

extension SettingSection {
    var title: String {
        switch self {
        case .account:
            return "账户信息"
        case .privacy:
            return "隐私"
        case .app:
            return "app"
        }
    }
}

