//
//  DiscoveryCollectionViewLayout.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import UIKit

class DiscoveryCollectionViewLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        self.init(sectionProvider: Self.sectionProvider)
    }
    
}

private extension DiscoveryCollectionViewLayout {
    static func sectionProvider(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        var group: NSCollectionLayoutGroup
        var behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
        var sectionInset: NSDirectionalEdgeInsets
        if(section == 0) {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 30), heightDimension: .fractionalWidth(9.0 / 16.0))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
            behavior = .groupPaging
            sectionInset = .init(top: 0, leading: 10, bottom: 0, trailing: 20)
        }else {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let subGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
            let subGroup = NSCollectionLayoutGroup.vertical(layoutSize: subGroupSize, subitem: item, count: 3)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width - 30), heightDimension: .fractionalWidth(9.0 / 16.0))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: subGroup, count: 1)
            group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
            behavior = .groupPaging
            sectionInset = .init(top: 0, leading: 10, bottom: 0, trailing: 20)
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.contentInsets = sectionInset
    

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerItem]

        return section
        
    }
}

