//
//  DiaryCell.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import UICore
import UIKit

class DiaryCell: CollectionViewCell {
    
    private lazy var avatarView = UIImageView(frame: .zero)
        .x
        .backgroundColor(DiaryModule.color(name: "Avatar.Default"))
        .corners(radius: 20)
        .instance
    
    private lazy var timeLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .text("今天")
        .textColor(DiaryModule.color(name: "Text.Gray"))
        .instance
        
    
    private lazy var contentLabel = UILabel(frame: .zero)
        .x
        .numberOfLines(0)
        .font(.preferredFont(forTextStyle: .body))
        .textColor(.systemBlack)
        .instance
    
    
    private var images: [String] = [] {
        didSet {
            collectionView.x.add(to: contentView).snp.remakeConstraints {
                $0.top.equalTo(contentLabel.snp.bottom)
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalTo(-margin)
                if images.count == 0 {
                    $0.height.equalTo(collectionView.snp.width).multipliedBy(0.0)
                }else if images.count <= 3 {
                    $0.height.equalTo(collectionView.snp.width).multipliedBy(1/3.0)
                }else if images.count <= 6 {
                    $0.height.equalTo(collectionView.snp.width).multipliedBy(2/3.0)
                }else {
                    $0.height.equalTo(collectionView.snp.width).multipliedBy(1.0)
                }
            }
            
           
            collectionView.reloadData()
        }
    }
    
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
        collectionView.register(DiaryImageCell.self, forCellWithReuseIdentifier: DiaryImageCell.cellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false 
        return collectionView
        
    }()
    
    private lazy var seperatorLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = DiaryModule.color(name: "Separator").cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [2, 2] // 每 2 个点画一次，再跳过 2 个点
        return shapeLayer
    }()
    
    private let margin: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension DiaryCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}

private extension DiaryCell {
    
    func setup() {
        contentView.backgroundColor = DiaryModule.color(name: "Cell.BackgroundColor.Main")
        avatarView.x.add(to: contentView).snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.top.equalTo(margin)
            $0.left.equalTo(margin)
        }
        timeLabel.x.add(to: contentView).snp.makeConstraints {
            $0.left.equalTo(avatarView.snp.right).offset(margin)
            $0.centerY.equalTo(avatarView)
        }
        contentLabel.x.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(margin)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
//            $0.bottom.equalTo(-margin)
        }
        
        collectionView.x.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(collectionView.snp.width).multipliedBy(0)
            $0.bottom.equalTo(-margin)
        
        }
        
        contentView.layer.addSublayer(seperatorLayer)
        
        
    }
    
    func layout() {
        
//        avatarView.pin.width(40).height(40).top(margin).left(margin)
//
//        timeLabel.pin.after(of: avatarView, aligned: .center).marginLeft(margin).sizeToFit()
//
//        contentLabel.pin.below(of: avatarView).marginTop(margin).left(margin).sizeToFit()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: contentView.bounds.height -  1))
        path.addLine(to: CGPoint(x: contentView.bounds.width, y: contentView.bounds.height -  1))
        seperatorLayer.path = path.cgPath
        
    }
    
}


extension DiaryCell {
    func config(viewModel: DiaryItemViewModel) {
        avatarView.kf.setImage(with: viewModel.avatar)
        contentLabel.text = viewModel.text
        if let images = viewModel.images {
            self.images = images
        }
        if viewModel.isLast {
            seperatorLayer.isHidden = true
            contentView.x.corners([.bottomLeft, .bottomRight] ,radius: 20)
        }else {
            seperatorLayer.isHidden = false
            contentView.x.corners(.allCorners ,radius: 0)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension DiaryCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count <= 9 ? images.count : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryImageCell.cellID, for: indexPath) as? DiaryImageCell else { fatalError() }
        let url = URL(string: images[indexPath.row])
        cell.config(url: url)
        return cell
    }
    
}
