//
//  SettingSection.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

enum SettingSection: CaseIterable {
    case app
    case privacy
}

extension SettingSection {
    var localizedTitle: String {
        switch self {
        case .app: return ""
        case .privacy: return "隐私"
    
        }
    }
}
