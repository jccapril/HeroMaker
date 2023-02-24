//
//  MobileContentView.swift
//  AppLogin
//
//  Created by jcc on 2023/2/24.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class MobileContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private(set) lazy var sendSMSButtonDelegator = Delegator<String?, Void>()
    
    private lazy var mobileTextfield = UITextField(frame: .zero)
        .x
        .placeholder("请输入手机号")
        .returnKeyType(.done)
        .keyboardType(.numberPad)
        .delegate(self)
        .textColor(.systemBlack)
        .borderStyle(.roundedRect)
        .instance
    
    private lazy var sendSMSButton = UIButton(type: .custom)
        .x
        .corners(radius: 25)
        .setTitle("获取验证码", for: .normal)
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


// MARK: - Private

private extension MobileContentView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        mobileTextfield.x.add(to: self)
        sendSMSButton.x.add(to: self)
        
        sendSMSButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.sendSMSButtonDelegator(self.mobileTextfield.text)
        }
        .store(in: &subscriptions)
    }
}

extension MobileContentView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendSMSButtonDelegator(textField.text)
        return true
    }
    
}


// MARK: - Override

extension MobileContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // pinlayout
        mobileTextfield.pin.top(20).left(50).right(50).height(50)
        sendSMSButton.pin.below(of: mobileTextfield, aligned: .center).height(50).width(150).marginTop(80)
    }
}

