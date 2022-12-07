//
//  DiscoveryCollectionViewDataSource.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/6.
//

import UIKit

class DiscoveryCollectionViewDataSource: UICollectionViewDiffableDataSource<String, DiscoveryItemViewModel> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: Self.cellProvider)
        self.supplementaryViewProvider = Self.supplementaryViewProvider
    }
}

private extension DiscoveryCollectionViewDataSource {
    static func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: DiscoveryItemViewModel) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoveryCollectionViewCell.cellID, for: indexPath)
            as? DiscoveryCollectionViewCell
        cell?.config(viewModel: itemIdentifier)
        return cell
    }
    
    static func supplementaryViewProvider(collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: DiscoveryCollectionViewHeader.cellID, for: indexPath) as? DiscoveryCollectionViewHeader
        
        return header
    }
}

