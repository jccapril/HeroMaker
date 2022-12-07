//
//  DiscoveryProvider.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import Center
import Foundation
import UICore

class DiscoveryProvider: Provider {}


extension DiscoveryProvider {
    func mock() -> [DiscoveryItemViewModel] {
        let colors: [UIColor] = [.systemRed, .systemBrown, .systemBlue, .systemPink, .systemYellow, .systemPurple]
        var result: [DiscoveryItemViewModel] = .init()
        for i in 0..<99 {
            let vm = DiscoveryItemViewModel(id: "10\(String(format: "%02d", i))", purity: (i % 2) == 0 ? "aa" : "nsfw", color: colors[i%6])
            result.append(vm)
        }
        return result
    }
}
