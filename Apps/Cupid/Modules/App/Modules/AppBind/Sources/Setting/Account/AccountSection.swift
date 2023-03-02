//
//  AccountSection.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//

enum AccountSection: CaseIterable, Section {
    case mobile
    case info
    case bind
    case action
}

extension AccountSection {
    var title: String {
        switch self {
        case .mobile:
            return "手机"
        case .info:
            return "用户信息"
        case .bind:
            return "绑定"
        case .action:
            return ""
        }
    }
}
