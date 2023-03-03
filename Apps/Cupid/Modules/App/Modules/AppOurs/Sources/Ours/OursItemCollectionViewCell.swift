//
//  OursItemCollectionViewCell.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import Foundation
import UICore
import UIKit

class OursItemCollectionViewCell: CollectionViewCell {
    
    private lazy var imageView = UIImageView(frame: .zero)
        .x
        .instance
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .text("恋爱日记")
        .textAlignment(.center)
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension OursItemCollectionViewCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension OursItemCollectionViewCell {
    
    func setup() {
        contentView.backgroundColor = OursModule.color(name: "Cell.BackgroundColor.Main")
        imageView.x.add(to: contentView)
        titleLabel.x.add(to: contentView)
    }
    
    func layout() {
        titleLabel.pin.bottom().left().right().margin(10).sizeToFit(.width)
        imageView.pin.above(of: titleLabel, aligned: .center).top().aspectRatio(1.0)
    }
    
}

extension OursItemCollectionViewCell {
    func config(viewModel: OursItemViewModel) {
        titleLabel.text = viewModel.title
        if let corners = viewModel.corners {
            contentView.x.corners(corners, radius: 20)
        }else {
            contentView.x.corners(.allCorners, radius: 0)
        }
        contentView.backgroundColor = viewModel.backgroundColor
        
        setNeedsLayout()
        
    }
}

