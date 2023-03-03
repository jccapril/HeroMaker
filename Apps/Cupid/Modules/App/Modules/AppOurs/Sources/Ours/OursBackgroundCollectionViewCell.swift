//
//  OursBackgroundCollectionViewCell.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import Foundation
import UICore
import UIKit

class OursBackgroundCollectionViewCell: CollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension OursBackgroundCollectionViewCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension OursBackgroundCollectionViewCell {
    
    
    func setup() {
        contentView.backgroundColor = OursModule.color(name: "Primary--")
    }
    
    func layout() {
        
    }
    
    
}
