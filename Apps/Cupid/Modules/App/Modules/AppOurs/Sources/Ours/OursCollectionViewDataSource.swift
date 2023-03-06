//
//  OursCollectionViewDataSource.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import UIKit

class OursCollectionViewDataSource: UICollectionViewDiffableDataSource<OursSection, OursItemViewModel> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: Self.cellProvider)
    }
}

private extension OursCollectionViewDataSource {
    static func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: OursItemViewModel) -> UICollectionViewCell? {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OursBackgroundCollectionViewCell.cellID, for: indexPath)
                as? OursBackgroundCollectionViewCell
            cell?.config(coupleInfo: itemIdentifier.coupleInfo)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OursItemCollectionViewCell.cellID, for: indexPath)
                as? OursItemCollectionViewCell
            cell?.config(viewModel: itemIdentifier)
            return cell
        }
        
    }
}
