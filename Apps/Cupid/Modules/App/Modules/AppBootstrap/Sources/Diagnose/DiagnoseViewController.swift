//
//  DiagnoseViewController.swift
//  AppBootstrap
//
//  Created by jcc on 2022/12/1.
//

import BaseUI
import Chain
import ExtensionKit
import Foundation
import UILayout
import UIRoute

class DiagnoseViewController: ViewController {
    private lazy var contentView = DiagnoseContentView(frame: .zero)

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DiagnoseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

private extension DiagnoseViewController {
    func setup() {
        contentView.x.add(to: view)
    }

    func layout() {
        contentView.pin.all(view.pin.safeArea)
    }
}

