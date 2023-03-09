//
//  DiaryCollectionViewDataSource.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import UIKit

class DiaryCollectionViewDataSource: UICollectionViewDiffableDataSource<Int, DiaryItemViewModel> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: Self.cellProvider)
        supplementaryViewProvider = self.customSupplementaryViewProvider
    }
}

private extension DiaryCollectionViewDataSource {
    static func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: DiaryItemViewModel) -> UICollectionViewCell? {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoupleInfoCell.cellID, for: indexPath) as? CoupleInfoCell
            cell?.config(couple: itemIdentifier.coupleInfo)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCell.cellID, for: indexPath)
                as? DiaryCell
            cell?.config(viewModel: itemIdentifier)
            return cell
        }
        
    }
    
    func customSupplementaryViewProvider(collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let day = self.snapshot().sectionIdentifiers[indexPath.section]
        let isLastSection = (self.snapshot().sectionIdentifiers.count - 1) == indexPath.section
        switch elementKind{
        case UICollectionView.elementKindSectionHeader:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: DiaryHeaderView.cellID, for: indexPath)
                as? DiaryHeaderView
            supplementaryView?.config(day: day)
            return supplementaryView
        case UICollectionView.elementKindSectionFooter:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: DiaryFooterView.cellID, for: indexPath)
                as? DiaryFooterView
            supplementaryView?.config(show: isLastSection)
            return supplementaryView
        default:
            return nil
        }
    }
}

