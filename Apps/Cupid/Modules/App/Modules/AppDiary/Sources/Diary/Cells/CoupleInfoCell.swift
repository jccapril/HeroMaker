//
//  CoupleInfoCell.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import UICore
import UIKit

class CoupleInfoCell: CollectionViewCell {
    
    
    private let margin: CGFloat = 10
    
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
    }
    
    func layout() {
        
    }
}
