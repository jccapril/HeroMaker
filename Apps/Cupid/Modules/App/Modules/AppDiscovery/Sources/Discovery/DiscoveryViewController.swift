//
//  DiscoveryViewController.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import CenterAPI
import Foundation
import UICore
import WeakDelegate

class DiscoveryViewController: ViewController {
    private lazy var contentView = DiscoveryContentView()
}


extension DiscoveryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.pin.all(view.pin.safeArea)
    }
}

private extension DiscoveryViewController {
    func setup() {
        contentView.x.add(to: view)
    }
}
