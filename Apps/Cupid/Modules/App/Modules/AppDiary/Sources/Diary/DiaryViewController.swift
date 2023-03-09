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
       
        loadDefaultData()
        
    }
    func layout() {
        contentView.pin.all()
    }
    
    func setupNavigationBar() {
        title = "日记"
//        setupNavigationBar(theme: .translucent)
    }
    
    
    private enum NavigationBarTheme {
        case white // 导航栏呈白色，字体呈黑色
        case translucent// 导航栏透明，显示底部背景色，字体呈白色
    }
    
    private func setupNavigationBar(theme: NavigationBarTheme) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = theme == .white ? .systemWhite : .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: theme == .white ? UIColor.systemBlack : UIColor.systemWhite]
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = theme == .white ? .systemBlack : .systemWhite
        self.navigationItem.backBarButtonItem?.tintColor = theme == .white ? .systemBlack : .systemWhite
        self.navigationItem.leftBarButtonItem?.tintColor = theme == .white ? .systemBlack : .systemWhite
        self.navigationItem.rightBarButtonItem?.tintColor = theme == .white ? .systemBlack : .systemWhite
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
//                await self.loadData(isRefresh: false)
                refresher.endRefreshing()
                self.contentView.reloadData(viewModel: self.viewModel)
            }
        }
    }
    
    func loadDefaultData() {
        contentView.reloadData(viewModel: self.viewModel)
        Task { [weak self] in
            guard let self = self else { return }
            ProgressHUD.show()
            await self.loadData(isRefresh: true)
            self.contentView.reloadData(viewModel: self.viewModel)
            ProgressHUD.dismiss()
        }
    }
    
    func loadData(isRefresh: Bool) async {
        do {
            guard let diaryList = try await provider.getDiaryList() else { return }
            viewModel.update(response: diaryList, isRefresh: isRefresh)
        } catch {
            Toast.text("Error", subtitle: "\(error)").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            logger.error("\(error)")
        }
        

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



