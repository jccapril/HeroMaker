//
//  DiaryWriteViewController.swift
//  AppDiary
//
//  Created by jcc on 2023/3/8.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class DiaryWriteViewController: ViewController {
    private lazy var contentView = DiaryWriteContentView()
    private lazy var provider = DiaryProvider()
    private var publishTask: Task<Void, Never>? = .none
}


// MARK: - Override
extension DiaryWriteViewController {
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

private extension DiaryWriteViewController {
    func setup() {
        contentView.x.add(to: view)
    }
    func layout() {
        contentView.pin.all(view.pin.safeAreaWithoutBottom)
    }
    
    func setupNavigationBar() {
        let current = Date()
        title = "\(current.format("M月d日") ?? "写日记")"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: DiaryModule.image(name: "Diary.Submit"), style: .plain, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = DiaryModule.color(name: "Primary--")
    }
    
    func bind() {
        
    }
    
    @objc
    func submit() {
        publishAction(text: contentView.text)
    }
}


// MARK: - Internal

extension DiaryWriteViewController {
    
    func publishAction(text: String? = nil, pictures: [String]? = nil) {
        
        if text.isNilOrEmpty && pictures.isNilOrEmpty {
            Toast.text("Error", subtitle: "内容不能为空").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return
        }
        
        publishTask.run { $0.cancel() }
        let task = Task { @MainActor in
            do {
                try await provider.publish(text: text)
                Toast.text("发布成功").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.success)
                back()
            } catch {
                Toast.text("Error", subtitle: "\(error)").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                logger.error("\(error)")
            }
        }
        publishTask = task
    }
    
}

extension DiaryWriteViewController: TypeNameable {}

extension DiaryWriteViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        return DiaryWriteViewController()
    }
    
    static let routeName: String = typeName
}



