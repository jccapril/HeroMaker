//
//  DiscoveryContentView.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import Service
import UICore
import UIKit


class DiscoveryContentView: View {
    
    private lazy var collectionView: CollectionView = .init(
        frame: .zero,
        collectionViewLayout: DiscoveryCollectionViewLayout()
            .x
            .instance
    )
    .x
    .backgroundColor(.clear)
    .register(DiscoveryCollectionViewCell.self, forCellWithReuseIdentifier: DiscoveryCollectionViewCell.cellID)
    .delegate(self)
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
        snapshot.appendSections(["main"])
        snapshot.appendItems(viewModel.wallpaperListViewModels)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
