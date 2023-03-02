//
//  AccountCollectionViewDataSource.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//

import UIKit

class AccountCollectionViewDataSource: UICollectionViewDiffableDataSource<AccountSection, SettingItemViewModel> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: Self.cellProvider)
//        supplementaryViewProvider = Self.supplementaryViewProvider
    }
}

private extension AccountCollectionViewDataSource {
    static func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: SettingItemViewModel) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.cellID, for: indexPath)
            as? SettingCollectionViewCell
        cell?.config(viewModel: itemIdentifier)
        return cell
    }
}

