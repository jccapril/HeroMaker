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
    let didSelectedDelegator = Delegator<IndexPath, Void>()

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
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
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
    }
    
    func layout() {
        // pinlayout
        collectionView.pin.all(UIEdgeInsets(top: -safeAreaInsets.top, left: 0, bottom: 0, right: 0))
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
        var snapshot = NSDiffableDataSourceSnapshot<String, DiaryItemViewModel>()
        snapshot.appendSections(["info","100","99","98"])
        let item1 = DiaryItemViewModel(id: "101", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item2 = DiaryItemViewModel(id: "102", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item3 = DiaryItemViewModel(id: "103", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item4 = DiaryItemViewModel(id: "104", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item5 = DiaryItemViewModel(id: "105", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item6 = DiaryItemViewModel(id: "106", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item7 = DiaryItemViewModel(id: "107", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item8 = DiaryItemViewModel(id: "108", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        snapshot.appendItems([item1], toSection: "info")
        snapshot.appendItems([item2, item3, item4], toSection: "100")
        snapshot.appendItems([item5, item6], toSection: "99")
        snapshot.appendItems([item7, item8], toSection: "98")
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func beginHeaderRefresh() {
        collectionView.topRefresher?.beginRefreshing()
    }
}
