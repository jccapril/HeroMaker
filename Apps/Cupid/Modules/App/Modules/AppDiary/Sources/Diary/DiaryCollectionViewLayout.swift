//
//  DiaryCollectionViewLayout.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import UIKit

class DiaryCollectionViewLayout: UICollectionViewCompositionalLayout {

    convenience init() {
        self.init(sectionProvider: Self.sectionProvider)
    }
}

private extension DiaryCollectionViewLayout {
    
    static func sectionProvider(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        switch section {
        case 0:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
            return section
        default:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400))
    
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            section.boundarySupplementaryItems = [
                header,
                footer,
            ]
            return section
        }
        
        
    }
}
