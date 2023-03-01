//
//  SettingCollectionViewLayout.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import UIKit

class SettingCollectionViewLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        self.init(sectionProvider: Self.sectionProvider)
        
//        self.init(section: section)
    }
}


private extension SettingCollectionViewLayout {
    static func sectionProvider(section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        switch section {
        case 1:
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(36.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

    //        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1.0))
    //        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

            layoutSection.boundarySupplementaryItems = [
                header,
    //            footer,
            ]
        default:
            break             
        }

        return layoutSection
    }
}
