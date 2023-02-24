//
//  LoginContentView.swift
//  AppLogin
//
//  Created by jcc on 2022/12/7.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class LoginContentView: View {
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private(set) lazy var mobileLoginButtonDelegator = Delegator<Void, Void>()
    
    private lazy var mobileLoginButton = UIButton(type: .custom)
        .x
        .corners(radius: 18)
        .setTitle("手机号登录/注册", for: .normal)
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

private extension LoginContentView {
    func setup() {
        backgroundColor = .systemWhite
        mobileLoginButton.x.add(to: self)
        mobileLoginButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.mobileLoginButtonDelegator()
        }
        .store(in: &subscriptions)
    }
}


// MARK: - Override

extension LoginContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        mobileLoginButton.pin.left(80).right(80).height(50).bottom(200)
    }
}
