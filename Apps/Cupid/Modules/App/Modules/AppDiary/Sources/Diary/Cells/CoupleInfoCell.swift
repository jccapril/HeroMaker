//
//  CoupleInfoCell.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import UICore
import UIKit
import Center


class CoupleInfoCell: CollectionViewCell {
    
    
    private let margin: CGFloat = 10
    
    private lazy var container = UIView(frame: .zero)
        .x
        .backgroundColor(.systemWhite)
        .corners(radius: 40)
        .instance
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .subheadline))
        .textColor(.systemBlack)
        .instance
    
    private lazy var avatarView1 = UIImageView(frame: .zero)
        .x
        .backgroundColor(DiaryModule.color(name: "Avatar.Default"))
        .corners(radius: 16)
        .instance
    
    private lazy var avatarView2 = UIImageView(frame: .zero)
        .x
        .backgroundColor(DiaryModule.color(name: "Avatar.Default"))
        .corners(radius: 16)
        .instance
    
    private lazy var timeLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .textColor(DiaryModule.color(name: "Text.Gray"))
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


extension CoupleInfoCell {
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

private extension CoupleInfoCell {
    
    func setup() {
        contentView.backgroundColor = DiaryModule.color(name: "Primary--")
        
        let topInset = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        container.x.add(to: contentView).snp.makeConstraints {
            $0.height.equalTo(80)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.bottom.equalTo(-2*margin)
            $0.top.equalTo(topInset + 44 + margin)
        }

        titleLabel.x.add(to: container).snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.left.equalTo(margin*2)
        }
        
        avatarView1.x.add(to: container).snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.left.equalTo(margin*2)
            $0.bottom.equalTo(-margin)
        }
        
        avatarView2.x.add(to: container).snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.left.equalTo(avatarView1.snp.right).offset(-margin)
            $0.bottom.equalTo(-margin)
        }
        
        timeLabel.x.add(to: container).snp.makeConstraints {
            $0.centerY.equalTo(avatarView2)
            $0.left.equalTo(avatarView2.snp.right).offset(margin)
        }
        
    }
    
    func layout() {
//        container.pin.height(80).left(margin).right(margin).bottom(margin)
    }
}

extension CoupleInfoCell {
    
    func config(couple: CoupleInfo?) {
        guard let couple = couple else { return }
        guard let selfName = UserCenter.userInfo?.name, let partnerName = couple.partner?.name else { return }
        titleLabel.text = "\(selfName)💗\(partnerName)"
        let interval = -Int(Date.from(couple.startedAt)?.timeIntervalSinceNow ?? 0)
        let day = 24 * 60 * 60
        let leftDay = interval / day
        timeLabel.text = "\(leftDay)天"
    }
    
    
}
