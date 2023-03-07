//
//  DiaryCollectionHeaderView.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import UICore
import UIKit

class DiaryHeaderView: CollectionReusableView {
    private lazy var titleLabel: UILabel = .init(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .textColor(DiaryModule.color(name: "Primary-"))
        .textAlignment(.center)
        .instance
    
    private lazy var seperator: UIView = .init(frame: .zero)
        .x
        .backgroundColor(DiaryModule.color(name: "Separator"))
        .instance

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DiaryHeaderView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension DiaryHeaderView {
    func setup() {
        backgroundColor = DiaryModule.color(name: "Cell.BackgroundColor.Main")
        titleLabel.x.add(to: self)
        seperator.x.add(to: self)
        
        self.x.corners([.topLeft, .topRight],radius: 20)
    }

    func layout() {
        titleLabel.pin.all()
        seperator.pin.left().right().bottom().height(1)
    }
}

extension DiaryHeaderView {
    func config(day: String) {
        titleLabel.text = "恋爱第\(day)天"
    }
}


