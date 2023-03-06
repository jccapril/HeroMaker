//
//  File.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import UIKit

class OursCollectionViewLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        self.init(sectionProvider: Self.sectionProvider)
    }
}


private extension OursCollectionViewLayout {
    static func sectionProvider(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize
        var item: NSCollectionLayoutItem
        var groupSize: NSCollectionLayoutSize
        var group: NSCollectionLayoutGroup
        var layoutSection: NSCollectionLayoutSection
        
        switch section {
        case 0:
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            item = NSCollectionLayoutItem(layoutSize: itemSize)
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            layoutSection = NSCollectionLayoutSection(group: group)
        case 1:
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            item = NSCollectionLayoutItem(layoutSize: itemSize)
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 5
            )
            layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.contentInsets = .init(top: -40, leading: 10, bottom: 10, trailing: 10)
        case 2:
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 2
            )
            layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        case 3:
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
            item = NSCollectionLayoutItem(layoutSize: itemSize)
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 4
            )
            layoutSection = NSCollectionLayoutSection(group: group)
        default:
            fatalError("首页只有4组样式")
        }
        return layoutSection
    }
}
