//
//  BindContentView.swift
//  AppBind
//
//  Created by jcc on 2022/12/17.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class BindContentView: View {
    let headerRefreshDelegator = Delegator<Refresher, Void>()
    let bindDelegator = Delegator<String?, Void>()
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private lazy var scrollView = UIScrollView(frame: .zero)
        .x
        .topRefresher(
            Refresher { [weak self] refresher in
                guard let self = self else { return }
                self.headerRefreshDelegator(refresher)
            }
        )
        .instance
    
    private lazy var container = BindContainerView(frame: .zero)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension BindContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

}



// MARK: - Private

private extension BindContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        scrollView.x.add(to: self)
        container.x.add(to: scrollView)
    }
    
    func bind() {
        container.inner.invitationTextField.textPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.container.inner.bindButton.isEnabled = $0?.count == 6
        }
        .store(in: &subscriptions)
        
        container.inner.invitationTextField.returnPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.container.inner.invitationTextField.resignFirstResponder()
            self.bindDelegator(self.container.inner.invitationTextField.text)
        }
        .store(in: &subscriptions)
        
        container.inner.bindButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.container.inner.invitationTextField.resignFirstResponder()
            self.bindDelegator(self.container.inner.invitationTextField.text)
        }
        .store(in: &subscriptions)
        
        let blankTap = UITapGestureRecognizer()
        scrollView.addGestureRecognizer(blankTap)
        blankTap.tapPublisher.receive(on: DispatchQueue.main).sink {[weak self] _ in
            guard let self = self else { return }
            self.container.inner.invitationTextField.resignFirstResponder()
        }
        .store(in: &subscriptions)
    }
    
    func layout() {
        // pinlayout
        scrollView.pin.all()
        container.pin.top(30).left(20).right(20).sizeToFit(.width)
    }
}

extension BindContentView {
    
    func reload(viewModel: BindViewModel) {
        container.inner.code = viewModel.code
    }
    
    func beginHeaderRefresh() {
        scrollView.topRefresher?.beginRefreshing()
    }
}



// MARK: -  BindContainerView
fileprivate class BindContainerView: View {
    
    lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("我是情侣")
        .textColor(.systemWhite)
        .font(.boldSystemFont(ofSize: 20))
        .instance
    
    lazy var subtitleLabel = UILabel(frame: .zero)
        .x
        .text("通过配对码绑定另一半")
        .textColor(.systemWhite)
        .font(.systemFont(ofSize: 14))
        .instance
    
    lazy var gradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hex: 0xE29187).cgColor, UIColor(hex: 0xE273A5).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }()
    
    lazy var inner = BindInnerContainerView(frame: .zero)
    
    
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        autoSizeThatFits(size, layoutClosure: layout)
    }
}

private extension BindContainerView {
    func setup() {
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        titleLabel.x.add(to: self)
        subtitleLabel.x.add(to: self)
        inner.x.add(to: self)
    }

    func layout() {
        gradientLayer.pin.all()
        
        titleLabel.pin.top(20).left(20).sizeToFit()
        
        subtitleLabel.pin.below(of: titleLabel).marginTop(2).left(20).sizeToFit()
        
        inner.pin.below(of: subtitleLabel).marginVertical(10).left(8).right(8).sizeToFit(.width)
    }
}


// MARK: -  BindInnerContainerView
fileprivate class BindInnerContainerView: View {
    
    lazy var avatarView1 = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Avatar.Default")), for: .normal)
        .setTitle("待绑定", for: .normal)
        .font(.systemFont(ofSize: 14))
        .setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        .corners(radius: 40)
        .instance
    
    lazy var avatarView2 = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Avatar.Default")), for: .normal)
        .setTitle("待绑定", for: .normal)
        .font(.systemFont(ofSize: 14))
        .setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        .corners(radius: 40)
        .instance
    
    lazy var invitationTagLabel = UILabel(frame: .zero)
        .x
        .font(.boldSystemFont(ofSize: 12))
        .textColor(.systemBlack)
        .text("我的配对码")
        .instance
    
    lazy var invitationValueLabel = UILabel(frame: .zero)
        .x
        .font(.systemFont(ofSize: 18))
        .textColor(BindModule.color(name: "Primary"))
        .instance
    
    @Proxy(\BindInnerContainerView.invitationValueLabel.text)
    var code: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    lazy var invitationTextField = UITextField(frame: .zero)
        .x
        .placeholder("输入TA的配对码")
        .returnKeyType(.done)
        .leftView(UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40)))
        .leftViewMode(.always)
        .rightViewMode(.always)
        .rightView(UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40)))
        .border(width: 2, color: BindModule.color(name: "Primary"))
        .corners(radius: 20)
        .instance
    
    lazy var bindButton = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Primary")), for: .normal)
        .setTitle("绑定进入", for: .normal)
        .isEnabled(false)
        .setTitleColor(.systemWhite, for: .normal)
        .font(.systemFont(ofSize: 12))
        .corners(radius: 15)
        .instance
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        autoSizeThatFits(size, layoutClosure: layout)
    }
}

private extension BindInnerContainerView {
    func setup() {
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .systemWhite
        avatarView1.x.add(to: self)
        avatarView2.x.add(to: self)
        
        invitationTagLabel.x.add(to: self)
        invitationValueLabel.x.add(to: self)
        invitationTextField.x.add(to: self)
        
        bindButton.x.add(to: invitationTextField)
    }

    func layout() {
        avatarView1.pin.top(10).right(to: edge.hCenter).width(80).height(80)
        avatarView2.pin.top(10).left(to: edge.hCenter).width(80).height(80)
        
        invitationTagLabel.pin.below(of: avatarView1).marginTop(10).left(16).sizeToFit()
        invitationValueLabel.pin.right(of: invitationTagLabel, aligned: .center).marginLeft(6).sizeToFit()
        invitationTextField.pin.below(of: invitationTagLabel).marginVertical(10).left(16).right(16).height(40)
        
        bindButton.pin.right(10).height(30).width(80).vCenter()
    }
}


