//
//  DiaryImageCell.swift
//  AppDiary
//
//  Created by jcc on 2023/3/8.
//

import Foundation
import UICore
import UIKit


class DiaryImageCell: CollectionViewCell {
    
    private lazy var imageView = UIImageView(frame: .zero)
        .x
        .contentMode(.scaleAspectFill)
        .masksToBounds(true)
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - override

extension DiaryImageCell {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}


// MARK: - private

private extension DiaryImageCell {
    
    func setup() {
        imageView.x.add(to: contentView)
    }
    
    func layout() {
        imageView.pin.all()
    }
    
}

// MARK: - Interal

extension DiaryImageCell {
    
    func config(url: URL?) {
        imageView.kf.setImage(with: url)
    }
    
}
