//
//  DiscoveryContentView.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import UICore
import UIKit
import WeakDelegate

class DiscoveryContentView: View {
    
    let headerRefreshDelegator = Delegator<Refresher, Void>()
    let footerRefreshDelegator = Delegator<Refresher, Void>()
    let didSelectedDelegator = Delegator<IndexPath, Void>()
    
    private lazy var collectionView: CollectionView = .init(
        frame: .zero,
        collectionViewLayout: DiscoveryCollectionViewLayout()
            .x
            .instance
    )
    .x
    .backgroundColor(.clear)
    .register(DiscoveryCollectionViewCell.self, forCellWithReuseIdentifier: DiscoveryCollectionViewCell.cellID)
    .register(DiscoveryCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoveryCollectionViewHeader.cellID)
    .delegate(self)
    .topRefresher(
        Refresher { [weak self] refresher in
            guard let self = self else { return }
            self.headerRefreshDelegator(refresher)
        }
    )
    .bottomRefresher(
        Refresher { [weak self] refresher in
            guard let self = self else { return }
            self.footerRefreshDelegator(refresher)
        }
    )
    .instance
    
    private lazy var dataSource = DiscoveryCollectionViewDataSource(collectionView: collectionView)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Private

private extension DiscoveryContentView {
    func setup() {
        backgroundColor = .systemWhite
        collectionView.x.add(to: self)
    }
}

// MARK: - Override

extension DiscoveryContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}


// MARK: - UICollectionViewDelegate

extension DiscoveryContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - Internal

extension DiscoveryContentView {
    func reloadData(viewModel: DiscoveryViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<String, DiscoveryItemViewModel>()
        snapshot.appendSections(["main", "sub"])
        
        let main = Array(viewModel.wallpaperListViewModels[0..<3]) as! [DiscoveryItemViewModel]
        let sub = Array(viewModel.wallpaperListViewModels[3..<12]) as! [DiscoveryItemViewModel]
       
        snapshot.appendItems(main, toSection: "main")
        snapshot.appendItems(sub, toSection: "sub")
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
