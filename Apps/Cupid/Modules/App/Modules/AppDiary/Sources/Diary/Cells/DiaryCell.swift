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
        contentLabel.x.add(to: contentView).snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(margin)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.bottom.equalTo(-margin)
            
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
        contentLabel.text = viewModel.content
//        setNeedsLayout()
    }
}
