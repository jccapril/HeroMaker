//
//  DiaryViewController.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class DiaryViewController: ViewController {
    private lazy var contentView = DiaryContentView()
    private lazy var provider = DiaryProvider()
    private lazy var viewModel = DiaryViewModel()
    private var task: Task<Void, Never>? = .none
}


// MARK: - Override
extension DiaryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
        bind()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension DiaryViewController {
    func setup() {
        
        contentView.x.add(to: view)
        
        contentView.beginHeaderRefresh()
        
    }
    func layout() {
        contentView.pin.all()
    }
    
    func setupNavigationBar() {
        title = "日记"
    }
    
    func bind() {
        
        contentView.writeDelegator.delegate(on: self) { _ , _ in
            Router.push(to: "DiaryWriteViewController")
        }
        
        contentView.headerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData(isRefresh: true)
                refresher.endRefreshing()
                self.contentView.reloadData(viewModel: self.viewModel)
            }
        }
        contentView.footerRefreshDelegator.delegate(on: self) { (`self`, refresher: Refresher) in
            Task { [weak refresher, weak self] in
                guard let self = self else { return }
                guard let refresher = refresher else { return }
                await self.loadData(isRefresh: false)
                refresher.endRefreshing()
                self.contentView.reloadData(viewModel: self.viewModel)
            }
        }
    }
    
    
    func loadData(isRefresh: Bool) async {
        let item = DiaryItemViewModel(id: "101", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item1 = DiaryItemViewModel(id: "102", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
        let item2 = DiaryItemViewModel(id: "103", content: "测试测试", avatar: "https://www.baidu.com/img/pcdoodle_2a77789e1a67227122be09c5be16fe46.png")
       
        viewModel.update(items: [item, item1, item2])

    }
}


// MARK: - Internal

extension DiaryViewController {
    
//    func action() {
//        task.run { $0.cancel() }
//        let rtask = Task { @MainActor in
//            do {
//                
//                Toast.text("Success").show()
//                FeedbackGenerator.notification.shared.notificationOccurred(.success)
//            } catch {
//                Toast.text("Error", subtitle: "\(error)").show()
//                FeedbackGenerator.notification.shared.notificationOccurred(.error)
//                logger.error("\(error)")
//            }
//        }
//        task = rtask
//    }
    
}

extension DiaryViewController: TypeNameable {}

extension DiaryViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return DiaryViewController()
    }
    
    static let routeName: String = typeName
}



