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
        avatarView.x.add(to: contentView)
        timeLabel.x.add(to: contentView)
        contentLabel.x.add(to: contentView)
    }
    
    func layout() {
        
        avatarView.pin.width(40).height(40).top(margin).left(margin)
        
        timeLabel.pin.after(of: avatarView, aligned: .center).marginLeft(margin).sizeToFit()
        
        contentLabel.pin.below(of: avatarView).marginTop(margin).left(margin).sizeToFit()
        
    }
    
}


extension DiaryCell {
    func config(viewModel: DiaryItemViewModel) {
        avatarView.kf.setImage(with: viewModel.avatar)
        contentLabel.text = viewModel.content
        setNeedsLayout()
    }
}
