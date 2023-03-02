//
//  SettingCollectionViewDataSource.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import UIKit

class SettingCollectionViewDataSource: UICollectionViewDiffableDataSource<SettingSection, SettingItemViewModel> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: Self.cellProvider)
//        supplementaryViewProvider = Self.supplementaryViewProvider
    }
}

private extension SettingCollectionViewDataSource {
    static func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: SettingItemViewModel) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.cellID, for: indexPath)
            as? SettingCollectionViewCell
        cell?.config(viewModel: itemIdentifier)
        return cell
    }

//    static func supplementaryViewProvider(collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? {
//        switch elementKind {
//        case UICollectionView.elementKindSectionHeader:
//            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: SettingCollectionHeaderView.cellID, for: indexPath)
//                as? SettingCollectionHeaderView
//            supplementaryView?.config(section: SettingSection.allCases[indexPath.section])
//            return supplementaryView
//        case UICollectionView.elementKindSectionFooter:
//            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: SettingCollectionFooterView.cellID, for: indexPath)
//                as? SettingCollectionFooterView
//            supplementaryView?.config(section: SettingSection.allCases[indexPath.section])
//            return supplementaryView
//        default:
//            return nil
//        }
//    }
}

