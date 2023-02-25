//
//  CodeContentView.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class CodeContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private(set) lazy var loginButtonDelegator = Delegator<String?, Void>()
    private(set) lazy var resendButtonDelegator = Delegator<Void, Void>()
    
    private lazy var largeTitleLabel = UILabel(frame: .zero)
        .x
        .textColor(.systemBlack)
        .font(.boldSystemFont(ofSize: 24))
        .text("请输入6位验证码")
        .instance
    
    private lazy var mobileLabel = UILabel(frame: .zero)
        .x
        .textColor(.placeholderText)
        .font(.systemFont(ofSize: 14))
        .text("短信已发送至xxxxxxxxxxxxxxxxxxx")
        .instance
    
    
    lazy var codeView: VerifyCodeView = {
        let codeView = VerifyCodeView(inputTextNum: 6)
        return codeView
    }()
    
    private lazy var resendButton = UIButton(type: .custom)
        .x
        .corners(radius: 25)
        .setTitle("重新获取", for: .normal)
        .setTitleColor(.systemWhite, for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Primary")), for: .normal)
        .instance
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension CodeContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        // pinlayout
        layout()
    }
}


// MARK: - Private

private extension CodeContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        largeTitleLabel.x.add(to: self)
        mobileLabel.x.add(to: self)
        codeView.x.add(to: self)
        resendButton.x.add(to: self)
        
        codeView.textFiled.becomeFirstResponder()
        codeView.inputFinish = {
            self.loginButtonDelegator($0)
        }
        resendButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.resendButtonDelegator()
        }
        .store(in: &subscriptions)

    }
    
    func layout() {
        
        largeTitleLabel.pin.top(20).left(20).sizeToFit()
        
        mobileLabel.pin.below(of: largeTitleLabel).marginTop(10).left(20).sizeToFit()
    
        codeView.pin.below(of: mobileLabel).marginTop(20).left(10).right(10).height(
            50)
        
        resendButton.pin.below(of: codeView, aligned: .center).height(50).width(150).marginTop(80)
    }
}



extension CodeContentView {
    func reloadData(viewModel: CodeViewModel) {
        mobileLabel.text = "短信已发送至\(viewModel.mobile)"
    }
}



