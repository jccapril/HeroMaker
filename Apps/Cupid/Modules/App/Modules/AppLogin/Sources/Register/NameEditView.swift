//
//  NameEditView.swift
//  AppLogin
//
//  Created by jcc on 2023/2/27.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class NameEditView: View {
    
    var nextAction: ((_ name: String) -> Void)?
    
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .text("1、昵称")
        .font(.boldSystemFont(ofSize: 20))
        .instance
    
    private lazy var textfield = UITextField(frame: .zero)
        .x
        .placeholder("请输入昵称")
        .returnKeyType(.done)
        .delegate(self)
        .textColor(.systemBlack)
        .corners(radius: 18)
        .clearButtonMode(.whileEditing)
        .leftViewMode(.always)
        .leftView(UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50)))
        .border(width: 2, color: LoginModule.color(name: "TextField.Border"))
        .instance
    
    private lazy var nextButton = UIButton(type: .custom)
        .x
        .corners(radius: 25)
        .setTitle("下一步", for: .normal)
        .setTitleColor(.systemWhite, for: .normal)
        .setBackgroundImage(UIImage(color: LoginModule.color(name: "Primary")), for: .normal)
        .instance
    
    var value: String? {
        get {
            textfield.text
        }
        set {
            textfield.text = newValue
        }
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension NameEditView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

// MARK: - Private

private extension NameEditView {
    func setup() {
        backgroundColor = .systemWhite
        // add subview
        titleLabel.x.add(to: self)
        textfield.x.add(to: self)
        nextButton.x.add(to: self)
        
        nextButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let self = self else { return }
            self.textfield.resignFirstResponder()
            guard let name = self.textfield.text, !name.isEmpty else {
                Toast.text("Error", subtitle: "请输入昵称").show()
                FeedbackGenerator.notification.shared.notificationOccurred(.error)
                return
            }
            self.nextAction?(name)
        }
        .store(in: &subscriptions)
        
        let blankTap = UITapGestureRecognizer()
        addGestureRecognizer(blankTap)
        blankTap.tapPublisher.receive(on: DispatchQueue.main).sink {[weak self] _ in
            guard let self = self else { return }
            self.textfield.resignFirstResponder()
        }
        .store(in: &subscriptions)
    }
    
    func layout() {
        // pinlayout
        titleLabel.pin.top(20).left(30).sizeToFit()
        textfield.pin.below(of: titleLabel).marginTop(20).left(30).right(30).height(50)
        nextButton.pin.below(of: textfield, aligned: .center).marginTop(30).height(50).width(150)
    }
}


// MARK: - UITextFieldDelegate

extension NameEditView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let name = self.textfield.text, !name.isEmpty else {
            Toast.text("Error", subtitle: "请输入昵称").show()
            FeedbackGenerator.notification.shared.notificationOccurred(.error)
            return true
        }
        self.nextAction?(name)
        return true
    }
    
}
