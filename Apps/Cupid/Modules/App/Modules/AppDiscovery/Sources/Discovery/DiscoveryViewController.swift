//
//  DiscoveryViewController.swift
//  AppDiscovery
//
//  Created by jcc on 2022/12/5.
//

import CenterAPI
import UICore
import WeakDelegate

class DiscoveryViewController: ViewController {
    private lazy var subscriptions = Set<AnyCancellable>()
    private lazy var contentView = DiscoveryContentView()
    private lazy var provider = DiscoveryProvider()
    private lazy var viewModel = DiscoveryViewModel()
    private var userInfoTask: Task<Void, Never>? = .none
}

// MARK: - Override
extension DiscoveryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
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
    
    func bind() {
        contentView.didSelectedDelegator.delegate(on: self) { `self`, indexPath in
  
        }
        contentView.headerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData(isRefresh: true)
                refresher.endRefreshing()
            }
        }
        contentView.footerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData(isRefresh: false)
                refresher.endRefreshing()
            }
        }
    }
    
    func loadData() {
        let mock = provider.mock()
        viewModel.update(list: mock)
        contentView.reloadData(viewModel: self.viewModel)
        
        userInfoTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                logger.debug("getting user info")
                let userInfo = try await provider.loadUserInfo()
                logger.debug("get user info:\(userInfo.createdAt)")
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                logger.error("\(error)")
            }
        }
        userInfoTask = task
    }
    
    func loadData(isRefresh: Bool) async {
        do {
            let userInfo = try await provider.loadUserInfo()
            logger.debug("get user info:\(userInfo.createdAt)")
            let data = try userInfo.toData()
            logger.debug("get user info:\(data)")
        } catch {
            Toast.text("Error", subtitle: "\(error)").show()
            logger.error("\(error)")
        }
    }
}
