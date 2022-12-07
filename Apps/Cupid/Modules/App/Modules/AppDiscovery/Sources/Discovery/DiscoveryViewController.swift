//
//  DiscoveryViewController.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import CenterAPI
import UICore

class DiscoveryViewController: ViewController {
    private lazy var subscriptions = Set<AnyCancellable>()
    private lazy var contentView = DiscoveryContentView()
    private lazy var provider = DiscoveryProvider()
    private lazy var viewModel = DiscoveryViewModel()
}

// MARK: - Override
extension DiscoveryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        loadData()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.pin.all(view.pin.safeArea)
    }
}

// MARK: - Private
private extension DiscoveryViewController {
    func setup() {
        contentView.x.add(to: view)
    }
    
    func loadData() {
        let mock = provider.mock()
        viewModel.update(list: mock)
        contentView.reloadData(viewModel: self.viewModel)
    }
}
