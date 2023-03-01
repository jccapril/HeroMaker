//
//  GenderEditView.swift
//  AppLogin
//
//  Created by jcc on 2023/2/27.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class GenderEditView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    var nextAction: ((_ gender: Int) -> Void)?
    
    var prevAction: (() -> Void)?
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("2、性别")
        .font(.boldSystemFont(ofSize: 20))
        .instance
    
    
    private lazy var femaleButton = UIButton(type: .custom)
        .x
        .setImage(LoginModule.image(name: "Gender.Female"), for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Gender.Default")), for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Gender.Female")), for: .selected)
        .corners(radius: 8)
        .instance
    
    private lazy var maleButton = UIButton(type: .custom)
        .x
        .setImage(LoginModule.image(name: "Gender.Male"), for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Gender.Default")), for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Gender.Male")), for: .selected)
        .corners(radius: 8)
        .instance
    
    private lazy var nextButton = UIButton(type: .custom)
        .x
        .corners(radius: 25)
        .setTitle("完成", for: .normal)
        .setTitleColor(.systemWhite, for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Primary")), for: .normal)
        .instance
    
    private lazy var prevButton = UIButton(type: .custom)
        .x
        .corners(radius: 25)
        .setTitle("返回", for: .normal)
        .setTitleColor(.systemWhite, for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Gender.Default")), for: .normal)
        .instance
    
    var value: Int? {
        get {
            if (!femaleButton.isSelected && !maleButton.isSelected) {
                return 0
            }
            return femaleButton.isSelected ? 2 : 1
        }
        set {
            if newValue == 1 {
                femaleButton.isSelected = false
                maleButton.isSelected = true
            }else if newValue == 2 {
                femaleButton.isSelected = true
                maleButton.isSelected = false
            }else  {
                femaleButton.isSelected = false
                maleButton.isSelected = false
            }
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension GenderEditView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension GenderEditView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        titleLabel.x.add(to: self)
        femaleButton.x.add(to: self)
        maleButton.x.add(to: self)
        nextButton.x.add(to: self)
        prevButton.x.add(to: self)
    }
    
    func layout() {
        // pinlayout
        titleLabel.pin.top(20).left(30).sizeToFit()
        femaleButton.pin.below(of: titleLabel).right(to: self.edge.hCenter).margin(20, 0, 0, 20).width(120).height(120)
        maleButton.pin.below(of: titleLabel).left(to: self.edge.hCenter).margin(20, 20, 0, 0).width(120).height(120)
        
        nextButton.pin.below(of: maleButton).marginTop(50).hCenter(to: self.edge.hCenter).height(50).width(150)
        prevButton.pin.below(of: nextButton, aligned: .center).marginTop(20).height(50).width(150)
    }
    
    func bind() {
        
        femaleButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else {
                return
            }
            self.femaleButton.isSelected = true
            self.maleButton.isSelected = false
        }
        .store(in: &subscriptions)
        
        maleButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else {
                return
            }
            self.femaleButton.isSelected = false
            self.maleButton.isSelected = true
        }
        .store(in: &subscriptions)
        
        nextButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else {
                return
            }
            if !self.femaleButton.isSelected && !self.maleButton.isSelected {
                Toast.text("Error", subtitle: "请选择性别").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                return
            }
            let gender = self.femaleButton.isSelected ? 2 : 1
            self.nextAction?(gender)
        }
        .store(in: &subscriptions)
        
        prevButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else {
                return
            }
            self.prevAction?()
        }
        .store(in: &subscriptions)
        
    }
}





