//
//  DiscoveryViewModel.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import Center
import Foundation
import UICore

class DiscoveryViewModel: ViewModel {
    private(set) lazy var wallpaperListViewModels: [DiscoveryItemViewModel] = .init()
}


extension DiscoveryViewModel {
    func update(list: [DiscoveryItemViewModel]) {
        wallpaperListViewModels.append(contentsOf: list)
    }
}
