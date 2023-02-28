//
//  BindViewModel.swift
//  AppBind
//
//  Created by jcc on 2023/2/28.
//

import BaseUI
import Center
import Foundation

class BindViewModel: ViewModel {
    var code: String?
    var user: UserInfo?
    init(code: String? = nil) {
        super.init()
    }
}

