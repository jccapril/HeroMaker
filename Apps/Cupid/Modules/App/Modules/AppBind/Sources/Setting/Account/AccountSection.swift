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
        return ""
    }
}
