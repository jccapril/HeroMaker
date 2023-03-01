//
//  BindDialog.swift
//  AppBind
//
//  Created by jcc on 2023/2/28.
//

import CenterAPI
import UICore
import WeakDelegate
import Service

class BindDialog: UIViewController {
    private lazy var subscriptions = Set<AnyCancellable>()
    var action: ((_ confirmed: Bool) -> Void)?
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("与TA一起使用Cupid")
        .font(.boldSystemFont(ofSize: 18))
        .textColor(.systemBlack)
        .instance
    
    private lazy var avatarView = UIImageView(frame: .zero)
        .x
        .backgroundColor(BindModule.color(name: "Avatar.Unbind"))
        .corners(radius: 40)
        .instance
    
    private lazy var nameLabel = UILabel(frame: .zero)
        .x
        .text("没有脖子的长颈鹿")
        .font(.boldSystemFont(ofSize: 14))
        .textColor(.systemBlack)
        .instance
    
    private lazy var mobileLabel = UILabel(frame: .zero)
        .x
        .text("18301787178")
        .font(.systemFont(ofSize: 14))
        .textColor(.systemBlack)
        .instance
    
    private lazy var cancelButton = UIButton(type: .custom)
        .x
        .setTitle("取消", for: .normal)
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Bind.Cancel")), for: .normal)
        .setTitleColor(.systemBlack, for: .normal)
        .corners(radius: 25)
        .instance
    
    private lazy var confirmButton = UIButton(type: .custom)
        .x
        .setTitle("绑定", for: .normal)
        .setTitleColor(.systemWhite, for: .normal)
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Primary")), for: .normal)
        .corners(radius: 25)
        .instance
}


// MARK: - Override
extension BindDialog {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

// MARK: - Internal

extension BindDialog {
    
    func reload(userInfo: UserInfo?) {

        guard let userInfo = userInfo else { return }
        nameLabel.text = userInfo.name
        let mobile = userInfo.mobile
        guard mobile.count == 11 else {
            fatalError("The phone number is not complete")
        }
        let intLetters = mobile.prefix(3)
        let endLetters = mobile.suffix(4)
        let stars = String(repeating: "*", count: mobile.count - 7)
        let result = intLetters + stars + endLetters
        mobileLabel.text = String(result)
        
    }
    
}

// MARK: - Private

private extension BindDialog {
    func setup() {
        titleLabel.x.add(to: view)
        avatarView.x.add(to: view)
        nameLabel.x.add(to: view)
        mobileLabel.x.add(to: view)
        cancelButton.x.add(to: view)
        confirmButton.x.add(to: view)
        
        cancelButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.action?(false)
        }
        .store(in: &subscriptions)
        
        confirmButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.action?(true)
        }
        .store(in: &subscriptions)
    }
    func layout() {
        titleLabel.pin.top(10).hCenter().sizeToFit()
        avatarView.pin.below(of: titleLabel, aligned: .center).marginTop(10).width(80).height(80)
        nameLabel.pin.below(of: avatarView, aligned: .center).marginTop(10).sizeToFit()
        mobileLabel.pin.below(of: nameLabel, aligned: .center).marginTop(2).sizeToFit()
        cancelButton.pin.below(of: mobileLabel).marginTop(16).right(to: view.edge.hCenter).marginRight(10).height(50).width(120)
        
        confirmButton.pin.below(of: mobileLabel).marginTop(16).left(to: view.edge.hCenter).marginLeft(10).height(50).width(120)
        
        self.view.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 16).isActive = true
    }
    

}


