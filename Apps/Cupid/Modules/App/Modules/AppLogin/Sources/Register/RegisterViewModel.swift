//
//  RegisterViewModel.swift
//  AppLogin
//
//  Created by jcc on 2023/2/27.
//

import BaseUI
import Center
import Foundation

class RegisterViewModel: ViewModel {
    var name: String?
    var gender: Int?

    init(name: String? = nil, gender: Int? = nil) {
        self.name = name
        self.gender = gender
        super.init()
    }
}


