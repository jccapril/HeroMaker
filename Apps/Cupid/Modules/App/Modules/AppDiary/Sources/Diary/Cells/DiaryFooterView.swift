//
//  DiaryFooterView.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import UICore
import UIKit

class DiaryFooterView: CollectionReusableView {
    private lazy var titleLabel: UILabel = .init(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .caption1))
        .textAlignment(.center)
        .textColor(DiaryModule.color(name: "Text.Gray"))
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DiaryFooterView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension DiaryFooterView {
    func setup() {
        backgroundColor = .clear
        titleLabel.x.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func layout() {
//        titleLabel.pin.all()
        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension DiaryFooterView {
    func config(show: Bool) {
        if show {
            titleLabel.text = "我有尽头，但爱你没有尽头"
        }else {
            titleLabel.text = nil
        }
    }
}

