//
//  BirthdayEditView.swift
//  AppLogin
//
//  Created by jcc on 2023/2/27.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class BirthdayEditView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    
    var nextAction: ((_ birthday: Date) -> Void)?
    
    var prevAction: (() -> Void)?
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("3、生日")
        .font(.boldSystemFont(ofSize: 20))
        .instance
    
    private lazy var picker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "zh_CN")
        return picker
    }()
    
    
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
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension BirthdayEditView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension BirthdayEditView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        titleLabel.x.add(to: self)
        picker.x.add(to: self)
        nextButton.x.add(to: self)
        prevButton.x.add(to: self)
    }
    
    func layout() {
        // pinlayout
        titleLabel.pin.top(20).left(30).sizeToFit()
        picker.pin.below(of: titleLabel).marginTop(30).hCenter(to: self.edge.hCenter).sizeToFit()
        nextButton.pin.below(of: picker).marginTop(50).hCenter(to: self.edge.hCenter).height(50).width(150)
        prevButton.pin.below(of: nextButton, aligned: .center).marginTop(20).height(50).width(150)
    }
    
    func bind() {
        
   
        
        nextButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else {
                return
            }
      
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




