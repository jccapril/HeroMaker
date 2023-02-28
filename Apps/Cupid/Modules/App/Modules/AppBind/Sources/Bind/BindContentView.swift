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
    
    private lazy var containerView = UIView(frame: .zero)
        .x
        .corners(radius: 10)
        .instance
    
    private lazy var containerGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hex: 0xE29187).cgColor, UIColor(hex: 0xE273A5).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }()
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("我是情侣")
        .textColor(.systemWhite)
        .font(.boldSystemFont(ofSize: 20))
        .instance
    
    private lazy var subcontainerView = UIView(frame: .zero)
        .x
        .corners(radius: 10)
        .backgroundColor(.systemWhite)
        .instance
    
    private lazy var subtitleLabel = UILabel(frame: .zero)
        .x
        .text("通过配对码绑定另一半")
        .textColor(.systemWhite)
        .font(.systemFont(ofSize: 14))
        .instance
    
    private lazy var avatarView1 = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Avatar.Unbind")), for: .normal)
        .setTitle("待绑定", for: .normal)
        .font(.systemFont(ofSize: 14))
        .setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        .corners(radius: 40)
        .instance
    
    private lazy var avatarView2 = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Avatar.Unbind")), for: .normal)
        .setTitle("待绑定", for: .normal)
        .font(.systemFont(ofSize: 14))
        .setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        .corners(radius: 40)
        .instance
    
    private lazy var invitationTagLabel = UILabel(frame: .zero)
        .x
        .font(.boldSystemFont(ofSize: 12))
        .textColor(.systemBlack)
        .text("我的配对码")
        .instance
    
    private lazy var invitationValueLabel = UILabel(frame: .zero)
        .x
        .font(.systemFont(ofSize: 18))
        .textColor(BindModule.color(name: "Primary"))
        .instance
    
    private lazy var bindButton = UIButton(type: .custom)
        .x
        .setBackgroundImage(UIImage(color: BindModule.color(name: "Primary")), for: .normal)
        .setTitle("绑定进入", for: .normal)
        .isEnabled(false)
        .setTitleColor(.systemWhite, for: .normal)
        .font(.systemFont(ofSize: 12))
        .corners(radius: 15)
        .instance
    
    private lazy var invitationTextField = UITextField(frame: .zero)
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
        containerView.x.add(to: scrollView)
        containerView.layer.insertSublayer(containerGradientLayer, at: 0)
        
        titleLabel.x.add(to: containerView)
        subtitleLabel.x.add(to: containerView)
        
        subcontainerView.x.add(to: containerView)
        
        avatarView1.x.add(to: subcontainerView)
        avatarView2.x.add(to: subcontainerView)
        
        invitationTagLabel.x.add(to: subcontainerView)
        invitationValueLabel.x.add(to: subcontainerView)
        invitationTextField.x.add(to: subcontainerView)
        
        bindButton.x.add(to: invitationTextField)
    
        
    }
    
    func bind() {
        
        invitationTextField.textPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.bindButton.isEnabled = $0?.count == 6
        }
        .store(in: &subscriptions)
        
        invitationTextField.returnPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.invitationTextField.resignFirstResponder()
            self.bindDelegator(self.invitationTextField.text)
        }
        .store(in: &subscriptions)
        
        bindButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.invitationTextField.resignFirstResponder()
            self.bindDelegator(self.invitationTextField.text)
        }
        .store(in: &subscriptions)
        
        let blankTap = UITapGestureRecognizer()
        scrollView.addGestureRecognizer(blankTap)
        blankTap.tapPublisher.receive(on: DispatchQueue.main).sink {[weak self] _ in
            guard let self = self else { return }
            self.invitationTextField.resignFirstResponder()
        }
        .store(in: &subscriptions)
    }
    
    func layout() {
        // pinlayout
        scrollView.pin.all()
        
        containerView.pin.top(30).left(20).right(20).height(300)
        containerGradientLayer.pin.all()
        
        titleLabel.pin.top(20).left(20).sizeToFit()
        
        subtitleLabel.pin.below(of: titleLabel).marginTop(2).left(20).sizeToFit()
        
        subcontainerView.pin.below(of: subtitleLabel).marginTop(12).left(8).right(8).bottom(8)
        
        avatarView1.pin.top(10).right(to: subcontainerView.edge.hCenter).width(80).height(80)
        avatarView2.pin.top(10).left(to: subcontainerView.edge.hCenter).width(80).height(80)
        
        
        invitationTagLabel.pin.below(of: avatarView1).marginTop(10).left(16).sizeToFit()
        
        invitationValueLabel.pin.right(of: invitationTagLabel, aligned: .center).marginLeft(6).sizeToFit()
        
        invitationTextField.pin.below(of: invitationTagLabel).marginTop(10).left(16).right(16).height(40)
        
        bindButton.pin.right(10).height(30).width(80).vCenter()
        
    }
}

extension BindContentView {
    
    
    func reload(viewModel: BindViewModel) {

        invitationValueLabel.text = viewModel.code
        invitationValueLabel.pin.right(of: invitationTagLabel, aligned: .center).marginLeft(6).sizeToFit()
        
    }
    
    func beginHeaderRefresh() {
        scrollView.topRefresher?.beginRefreshing()
    }
}



