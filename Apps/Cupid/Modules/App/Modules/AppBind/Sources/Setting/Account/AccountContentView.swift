//
//  AccountContentView.swift
//  AppBind
//
//  Created by jcc on 2023/3/2.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class AccountContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    let headerRefreshDelegator = Delegator<Refresher, Void>()
    
    private lazy var collectionView: CollectionView = .init(frame: .zero, collectionViewLayout: SettingCollectionViewLayout())
        .x
        .backgroundColor(.clear)
        .delegate(self)
        .register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: SettingCollectionViewCell.cellID)
        .register(SettingCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingCollectionHeaderView.cellID)
        .register(SettingCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SettingCollectionFooterView.cellID)
        .topRefresher(
            Refresher { [weak self] refresher in
                guard let self = self else { return }
                self.headerRefreshDelegator(refresher)
            }
        )
        .instance

    private lazy var dataSource = AccountCollectionViewDataSource(collectionView: collectionView)

    private(set) lazy var didSelectedItemDelegator = Delegator<IndexPath, Void>()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension AccountContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension AccountContentView {
    func setup() {
        // add subview
        backgroundColor = BindModule.color(name: "App.BackgourndColor.Main")
        collectionView.x.add(to: self)
        
    }
    
    func layout() {
        // pinlayout
        collectionView.pin.all()
    }
}


// MARK: - UICollectionViewDelegate

extension AccountContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedItemDelegator.call(indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
}


extension AccountContentView {
    func reloadData(viewModel: AccountViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<AccountSection, SettingItemViewModel>()
        let sections = AccountSection.allCases
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard let itemViewModels = viewModel.items[section] else { return }
            snapshot.appendItems(itemViewModels, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func beginHeaderRefresh() {
        collectionView.topRefresher?.beginRefreshing()
    }
}
