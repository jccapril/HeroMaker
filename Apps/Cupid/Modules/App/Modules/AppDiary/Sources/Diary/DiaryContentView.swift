//
//  DiaryContentView.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class DiaryContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    let headerRefreshDelegator = Delegator<Refresher, Void>()
    let footerRefreshDelegator = Delegator<Refresher, Void>()
    let didScrollDelegator = Delegator<CGFloat, Void>()
    let didSelectedDelegator = Delegator<IndexPath, Void>()
    let writeDelegator = Delegator<Void, Void>()
    
    
    private lazy var collectionView: CollectionView = .init(frame: .zero, collectionViewLayout: DiaryCollectionViewLayout())
        .x
        .backgroundColor(.clear)
        .delegate(self)
        .showsVerticalScrollIndicator(false)
        .register(CoupleInfoCell.self, forCellWithReuseIdentifier: CoupleInfoCell.cellID)
        .register(DiaryCell.self, forCellWithReuseIdentifier: DiaryCell.cellID)
        .register(DiaryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiaryHeaderView.cellID)
        .register(DiaryFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DiaryFooterView.cellID)
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
    
    private lazy var dataSource = DiaryCollectionViewDataSource(collectionView: collectionView)
    
    lazy var writeButton = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: DiaryModule.color(name: "Primary--")), for: .normal)
        .setImage(DiaryModule.image(name: "Button.Diary.Wirte"), for: .normal)
        .corners(radius: 30)
        .instance
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension DiaryContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()

    }
}

// MARK: - Private

private extension DiaryContentView {
    func setup() {
        backgroundColor = DiaryModule.color(name: "App.BackgourndColor.Main")
        // add subview
        collectionView.x.add(to: self)
        writeButton.x.add(to: self)
        

    }
    
    func bind() {
        writeButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.writeDelegator()
        }
        .store(in: &subscriptions)
        
        collectionView.didScrollPublisher.receive(on: DispatchQueue.main).sink {[weak self] in
            guard let self = self else { return }
            self.didScrollDelegator(self.collectionView.contentOffset.y)
        }
        .store(in: &subscriptions)
        
        collectionView.didSelectItemPublisher.receive(on: DispatchQueue.main).sink { [weak self] indexPath in
            guard let self = self else { return }
            self.didSelectedDelegator(indexPath)
        }
        .store(in: &subscriptions)
    }
    
    func layout() {
        // pinlayout
        collectionView.pin.all(UIEdgeInsets(top: -safeAreaInsets.top, left: 0, bottom: 0, right: 0))
        writeButton.pin.right(10).width(60).height(60).bottom(120)
    }
}


// MARK: - UICollectionViewDelegate

extension DiaryContentView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedDelegator(indexPath)
    }
    

}




// MARK: - Internal

extension DiaryContentView {
    func reloadData(viewModel: DiaryViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, DiaryItemViewModel>()
        let keys = viewModel.keys
        snapshot.appendSections(keys)
        keys.forEach {
            guard let itemViewModels = viewModel.diaryListViewModels[$0] else { return }
            snapshot.appendItems(itemViewModels, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func beginHeaderRefresh() {
        collectionView.topRefresher?.beginRefreshing()
    }
}
