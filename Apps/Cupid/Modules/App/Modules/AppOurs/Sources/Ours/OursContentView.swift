//
//  OursContentView.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class OursContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private lazy var collectionView: CollectionView = .init(frame: .zero, collectionViewLayout: OursCollectionViewLayout())
        .x
        .backgroundColor(.clear)
        .showsVerticalScrollIndicator(false)
        .register(OursBackgroundCollectionViewCell.self, forCellWithReuseIdentifier: OursBackgroundCollectionViewCell.cellID)
        .register(OursItemCollectionViewCell.self, forCellWithReuseIdentifier: OursItemCollectionViewCell.cellID)
        .instance
    
    private lazy var dataSource = OursCollectionViewDataSource(collectionView: collectionView)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension OursContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension OursContentView {
    func setup() {
        // add subview
        backgroundColor = OursModule.color(name: "App.BackgourndColor.Main")
        collectionView.x.add(to: self)
        
        collectionView.didScrollPublisher.receive(on: DispatchQueue.main).sink {[weak self] in
            
        }
        .store(in: &subscriptions)
        
        collectionView.didSelectItemPublisher.receive(on: DispatchQueue.main).sink { [weak self] indexPath in
            
        }
        .store(in: &subscriptions)
    }
    
    func layout() {
        // pinlayout
        collectionView.pin.all(UIEdgeInsets(top: -safeAreaInsets.top, left: 0, bottom: 0, right: 0))
    }
}




extension OursContentView {
    func reloadData(viewModel: OursViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<OursSection, OursItemViewModel>()
        let sections = OursSection.allCases
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard let itemViewModels = viewModel.items[section] else { return }
            snapshot.appendItems(itemViewModels, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}



