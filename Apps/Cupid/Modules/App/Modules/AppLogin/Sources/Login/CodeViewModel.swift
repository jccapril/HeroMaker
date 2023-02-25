//
//  CodeViewModel.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import BaseUI
import Center
import Foundation

class CodeViewModel: ViewModel {
    let mobile: String
   

    init(mobile: String) {
        self.mobile = mobile
        super.init()
    }
}

