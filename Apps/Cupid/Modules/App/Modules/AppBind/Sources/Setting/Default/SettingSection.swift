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
        return ""
    }
}

