//
//  SettingCollectionHeaderView.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import Foundation
import UICore
import UIKit

class SettingCollectionHeaderView: CollectionReusableView {
    private lazy var titleLabel: UILabel = .init(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .textColor(.systemBlack)
        .instance
    
    private lazy var seperator: UIView = .init(frame: .zero)
        .x
        .backgroundColor(.systemGray5)
        .instance

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension SettingCollectionHeaderView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension SettingCollectionHeaderView {
    func setup() {
        backgroundColor = UIColor(hex: 0xFFF5F5)
        titleLabel.x.add(to: self)
        seperator.x.add(to: self)
    }

    func layout() {
        titleLabel.pin.all(12)
        seperator.pin.left().right().bottom().height(1)
    }
}

extension SettingCollectionHeaderView {
    func config(section: Section) {
        titleLabel.text = section.title
    }
}

