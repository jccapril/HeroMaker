//
//  DiscoveryContentView.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import Service
import UICore
import UIKit


class DiscoveryContentView: View {
    
    private lazy var viewA: View = .init(
        frame: .zero
    )
        .x
        .backgroundColor(.systemRed)
        .instance
    
    private lazy var viewB: View = .init(
        frame: .zero
    )
        .x
        .backgroundColor(.systemBlue)
        .instance
    
    private lazy var viewC: View = .init(
        frame: .zero
    )
        .x
        .backgroundColor(.systemYellow)
        .instance
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Private

private extension DiscoveryContentView {
    func setup() {
        backgroundColor = .systemWhite
        viewA.x.add(to: self)
        viewB.x.add(to: self)
        viewC.x.add(to: self)
    }
}

// MARK: - Override

extension DiscoveryContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        viewA.pin.top(20%).left(20%).size(CGSize(width: 200, height: 100))
        viewB.pin.below(of: viewA, aligned: .left).margin(10, 200).size(CGSize(width: 100, height: 100))
        viewC.pin.below(of: viewB, aligned: .right).margin(10, 200).size(CGSize(width: 150, height: 100))
    }
}
