//
//  SettingCollectionViewCell.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import Foundation
import UICore
import UIKit

class SettingCollectionViewCell: CollectionViewCell {
    private lazy var titleLabel: UILabel = .init(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .body))
        .textColor(.systemBlack)
        .instance

    private lazy var detailLabel: UILabel = .init(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .footnote))
        .textColor(.systemGray)
        .instance
    
    private lazy var chevronIcon: UIImageView = .init(frame: .zero)
        .x
        .image(UIImage(systemSymbol: .chevronRight))
        .tintColor(.systemGray3)
        .instance
    
    private lazy var seperator: UIView = .init(frame: .zero)
        .x
        .backgroundColor(BindModule.color(name: "Separator"))
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension SettingCollectionViewCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension SettingCollectionViewCell {
    func setup() {
        contentView.backgroundColor = BindModule.color(name: "Cell.BackgroundColor.Main")
        titleLabel.x.add(to: contentView)
        detailLabel.x.add(to: contentView)
        chevronIcon.x.add(to: contentView)
        seperator.x.add(to: contentView)
    }

    func layout() {
        titleLabel.pin.vCenter().left(20).sizeToFit()
        chevronIcon.pin.vCenter().right(20).height(14).aspectRatio(1)
        detailLabel.pin.before(of: chevronIcon).marginRight(10).vCenter().sizeToFit()
        seperator.pin.left(20).right(20).bottom().height(0.5)
    }
}


extension SettingCollectionViewCell {
    func config(viewModel: SettingItemViewModel) {
        titleLabel.text = viewModel.title
        detailLabel.text = viewModel.detailText
        chevronIcon.isHidden = !viewModel.chevron
        seperator.isHidden = !viewModel.separator
        if let corners = viewModel.corners {
            contentView.x.corners(corners, radius: 10)
        }else {
            contentView.x.corners(.allCorners, radius: 0)
        }
        setNeedsLayout()
        
    }
}

