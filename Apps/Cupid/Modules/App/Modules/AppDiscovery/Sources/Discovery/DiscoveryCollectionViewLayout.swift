//
//  DiscoveryCollectionViewLayout.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import UIKit

class DiscoveryCollectionViewLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        let count = 2
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9.0 / 16.0 / CGFloat(count)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: count
        )
        let section = NSCollectionLayoutSection(group: group)

        self.init(section: section)
    }
}

