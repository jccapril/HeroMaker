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
    
//    private lazy var seperator: UIView = .init(frame: .zero)
//        .x
//        .instance
    
    private lazy var seperatorLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = DiaryModule.color(name: "Separator").cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [2, 2] // 每 2 个点画一次，再跳过 2 个点
        return shapeLayer
    }()

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
        self.layer.addSublayer(seperatorLayer)
        self.x.corners([.topLeft, .topRight],radius: 20)
    }

    func layout() {
        titleLabel.pin.all()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.height -  1))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height -  1))
        seperatorLayer.path = path.cgPath
        
    }
}

extension DiaryHeaderView {
    func config(day: String) {
        titleLabel.text = "恋爱第\(day)天"
    }
}


