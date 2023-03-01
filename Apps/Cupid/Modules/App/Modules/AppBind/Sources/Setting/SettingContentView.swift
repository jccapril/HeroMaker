//
//  SettingContentView.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import UICore
import UIKit
import WeakDelegate

class SettingContentView: View {
    private lazy var collectionView: CollectionView = .init(frame: .zero, collectionViewLayout: SettingCollectionViewLayout())
        .x
        .backgroundColor(.clear)
        .delegate(self)
        .register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: SettingCollectionViewCell.cellID)
        .register(SettingCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingCollectionHeaderView.cellID)
        .register(SettingCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SettingCollectionFooterView.cellID)
        .instance

    private lazy var dataSource = SettingCollectionViewDataSource(collectionView: collectionView)

    private(set) lazy var didSelectedItemDelegator = Delegator<IndexPath, Void>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension SettingContentView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension SettingContentView {
    func setup() {
        collectionView.x.add(to: self)
    }

    func layout() {
        collectionView.pin.all()
    }
}

// MARK: - UICollectionViewDelegate

extension SettingContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedItemDelegator.call(indexPath)
    }
}

extension SettingContentView {
    func reloadData(viewModel: SettingViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<SettingSection, SettingItemViewModel>()
        let sections = SettingSection.allCases
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard let itemViewModels = viewModel.items[section] else { return }
            snapshot.appendItems(itemViewModels, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

