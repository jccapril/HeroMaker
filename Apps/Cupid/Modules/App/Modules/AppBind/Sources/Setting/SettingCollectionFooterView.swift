//
//  SettingCollectionFooterView.swift
//  AppBind
//
//  Created by jcc on 2023/3/1.
//

import Foundation
import UICore
import UIKit

class SettingCollectionFooterView: CollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension SettingCollectionFooterView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension SettingCollectionFooterView {
    func setup() {
        backgroundColor = .systemGray6
    }

    func layout() {}
}

extension SettingCollectionFooterView {
    func config(section: SettingSection) {}
}

