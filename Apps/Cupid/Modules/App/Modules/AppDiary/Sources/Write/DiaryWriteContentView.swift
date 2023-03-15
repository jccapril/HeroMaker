//
//  DiaryWriteContentView.swift
//  AppDiary
//
//  Created by jcc on 2023/3/8.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class DiaryWriteContentView: View {
    
    lazy var albumDelegator = Delegator<Void, Void>()
    
    lazy var deleteDelegator = Delegator<Int, Void>()
    
    lazy var uploadDelegator = Delegator<(Int, String), Void>()
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private let margin: CGFloat = 10
    
    private lazy var container = UIView(frame: .zero)
        .x
        .backgroundColor(.systemWhite)
        .corners(radius: 20)
        .instance
    
    private lazy var textView = {
        let textView = UITextView(frame: .zero)
            .x
            .corners(radius: 20)
            .backgroundColor(.systemWhite)
            .contentInset(.init(top: margin, left: margin, bottom: margin, right: margin))
            .font(.preferredFont(forTextStyle: .body))
            .instance
        textView.isScrollEnabled = false
        textView.addPlaceholder("这一刻,我想说")
        return textView
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let padding = self.margin/2
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0/3.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            
            return section
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(DiaryWriteCaremaCell.self, forCellWithReuseIdentifier: DiaryWriteCaremaCell.cellID)
        collectionView.register(DiaryWritePictureCell.self, forCellWithReuseIdentifier: DiaryWritePictureCell.cellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
        
    }()
    
    var text: String? {
        get {
            textView.text
        }
    }
    
    private let minTextHeight: CGFloat = 120

    
    private var textHeight: CGFloat = 120
    
    private var dataSource: [DiaryWritePictureItemViewModel] = [] {
        didSet {
            collectionView.reloadData()
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension DiaryWriteContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension DiaryWriteContentView {
    func setup() {
        backgroundColor = DiaryModule.color(name: "App.BackgourndColor.Main")
        // add subview
        container.x.add(to: self)
        textView.x.add(to: container)
        collectionView.x.add(to: container)
       
    }
    
    func layout() {
        // pinlayout
        
        textView.pin.top().left().right().height(textHeight)
        var ratio: CGFloat
        if dataSource.count <= 3 {
            ratio = 3.0
        }else if dataSource.count <= 6 {
            ratio = 1.5
        }else {
            ratio = 1.0
        }
        collectionView.pin.below(of: textView).top().left().right().aspectRatio(ratio)
        container.pin.top(margin).left(margin).right(margin).bottom(to: collectionView.edge.bottom).marginBottom(-margin)
    }
    
    func bind() {
        
        textView.textPublisher.receive(on: DispatchQueue.main).sink { [weak self] _ in
            guard let self = self else { return }
            let height = self.textView.sizeThatFits(CGSize(width: self.textView.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
            self.textHeight = (height <= self.minTextHeight).map(true: self.minTextHeight, false: height)
            
            
            self.setNeedsLayout()
        }
        .store(in: &subscriptions)
        
        collectionView.didSelectItemPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            if self.dataSource[$0.row].pictureType == .Action {
                self.albumDelegator()
            }
        }
        .store(in: &subscriptions)
        
    }
}

// MARK: - UICollectionViewDataSource
extension DiaryWriteContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        (dataSource[indexPath.row].pictureType == .Action).map(true: {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryWriteCaremaCell.cellID, for: indexPath) as? DiaryWriteCaremaCell else { fatalError() }
            return cell
        }, false: {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryWritePictureCell.cellID, for: indexPath) as? DiaryWritePictureCell else { fatalError() }
            cell.config(item: dataSource[indexPath.row])
            cell.deleteAction = {
                self.deleteDelegator(indexPath.row)
            }
            cell.uploadAction = {
                self.uploadDelegator((indexPath.row, $0))
            }
            return cell
        })
        
    }
    
}

// MARK: - Internal
extension DiaryWriteContentView {
    
    func reloadViewModel(_ viewModel: DiaryWriteViewModel) {
        dataSource = viewModel.items
    }
    
}

