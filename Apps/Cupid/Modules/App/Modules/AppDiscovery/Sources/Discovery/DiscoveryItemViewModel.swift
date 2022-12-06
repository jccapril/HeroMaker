//
//  DiscoveryItemViewModel.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import Center
import Foundation
import UICore

class DiscoveryItemViewModel: ViewModel {
    let id: String
    let purity: String
    let color: UIColor


    init(id: String, purity: String, color: UIColor) {
        self.id = id
        self.purity = purity
        self.color = color
    }
}

extension DiscoveryItemViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: DiscoveryItemViewModel, rhs: DiscoveryItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

