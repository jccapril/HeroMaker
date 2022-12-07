//
//  DiscoveryCollectionViewHeader.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/7.
//

import UICore
import UIKit

class DiscoveryCollectionViewHeader: CollectionReusableView {
        
    private lazy var titleLabel: UILabel = UILabel(frame: .zero)
        .x
        .text("标题")
        .textColor(.systemBlack)
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


private extension DiscoveryCollectionViewHeader {
    func setup() {
        titleLabel.x.add(to: self)
    }
}

extension DiscoveryCollectionViewHeader  {
    override open func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin.centerStart(10).sizeToFit()
    }
}
