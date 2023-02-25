//
//  VerifyCodeView.swift
//  VerifyCodeView
//
//  Created by jcc on 2023/2/25.
//

import UIKit
import UILayout
import BaseUI
import Chain

public class VerifyCodeView: View {
    
    /// 输入值改变
    var textValueChange: ((_ text: String) -> Void)?
    
    /// 输入完成
    public var inputFinish: ((_ text: String) -> Void)?
    
    /// 验证码输入框个数
    var inputTextNum: Int = 6
    
    /// 输入框
    public lazy var textFiled: VerifyCodeTextView = {
        let textFiled = VerifyCodeTextView()
        textFiled.tintColor = .clear
        textFiled.backgroundColor = .clear
        textFiled.textColor = .clear
        textFiled.delegate = self
        textFiled.keyboardType = .decimalPad
        textFiled.addTarget(self, action: #selector(textFiledDidChange(_:)), for: .editingChanged)
        textFiled.addTarget(self, action: #selector(textFiledDidEnd(_:)), for: .editingDidEnd)
        return textFiled
    }()
    
    /// 验证码数量
    var codeViews: [VerifyCodeNumView] = []
    
    /// 验证码输入框距离两边的边距
    var padding: CGFloat = 15
    
    /// 每个验证码输入框间距
    var spacing: CGFloat = 10
    
    /// 是否在输入中
    var isInput = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(inputTextNum: Int) {
        self.init()
        self.inputTextNum = inputTextNum
        setup()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}



// MARK: - Override

extension VerifyCodeView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        // pinlayout
        layout()
    }
}




// MARK: - Private

private extension VerifyCodeView {
    
    func setup() {
        textFiled.x.add(to: self)
        for _ in 0..<inputTextNum {
            let codeNumView = VerifyCodeNumView()
            codeNumView.isUserInteractionEnabled = false
            codeNumView.setCursorStatus(true)
            self.addSubview(codeNumView)
            codeViews.append(codeNumView)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func layout() {
        textFiled.pin.left(padding).right(padding).top(0).bottom(0)
        
        // 每个验证码框宽度
        let itemWidth: CGFloat = (frame.width - padding * 2 - spacing * (CGFloat(inputTextNum) - 1)) / CGFloat(inputTextNum)
        
        for i in 0..<inputTextNum {
            let codeNumView = codeViews[i]
            codeNumView.pin.width(itemWidth).left(padding + CGFloat(i) * (spacing + itemWidth)).top(0).bottom(0)
        }
            
    }
}

// MARK: - 供外部调用方法
public extension VerifyCodeView {
    /// 清除所有输入
    func cleanCodes() {
        textFiled.text = ""
        textFiledDidChange(textFiled)
        allCursorHidden()
    }
    
    /// 隐藏所有输入光标
    func allCursorHidden() {
        DispatchQueue.main.async {
            for i in 0..<self.codeViews.count {
                let codeView = self.codeViews[i]
                codeView.setCursorStatus(true)
                if codeView.getNum().count == 0 {
                    codeView.setBottomLineFocus(isFocus: false)
                }
            }
        }
    }
}

// MARK: - 键盘显示隐藏
extension VerifyCodeView {
    
    @objc fileprivate func keyboardShow(note: Notification) {
        isInput = false
        textFiledDidChange(textFiled)
        isInput = true
    }
    
    @objc fileprivate func keyboardHidden(note: Notification) {
        allCursorHidden()
    }
}


// MARK: - UITextViewDelegate
extension VerifyCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 输入框已有的值
        var inputText = textFiled.text ?? ""
        
        if string.count == 0 { // 删除
            if range.location != inputText.count - 1 { // 删除的不是最后一个
                if inputText.count > 0 {
                    // 手动删除最后一位
                    textFiled.text?.removeLast()
                    textFiledDidChange(textFiled)
                }
                return false
            }
        }
        
        if let tempRange = Range.init(range, in: inputText) {
            // 拼接输入后的值
            inputText = inputText.replacingCharacters(in: tempRange , with: string)
            let meetRegx = "[0-9]*"
            let characterSet = NSPredicate.init(format: "SELF MATCHES %@", meetRegx)
            if characterSet.evaluate(with: inputText) == false {
                return false
            }
        }
        
        if inputText.count > inputTextNum {
            
            return false
        }
        
        return true
    }
    
    @objc func textFiledDidChange(_ textFiled: UITextField) {
        let inputStr = textFiled.text ?? ""
        
        textValueChange?(inputStr)
        
        for i in 0..<codeViews.count {
            let codeView = codeViews[i]
            if i < inputStr.count {
                codeView.setNum(num: inputStr[String.Index(utf16Offset: i, in: inputStr)].description)
                codeView.setBottomLineFocus(isFocus: true)
                codeView.setCursorStatus(true)
            } else {
                if inputStr.count == 0, i == 0 {
                    codeView.setCursorStatus(false)
                    codeView.setBottomLineFocus(isFocus: true)
                    codeView.setNum(num: nil)
                } else {
                    codeView.setCursorStatus(i != inputStr.count)
                    codeView.setNum(num: nil)
                    codeView.setBottomLineFocus(isFocus: i == inputStr.count)
                }
            }
        }
        
        if isInput, inputStr.count >= inputTextNum {
            // 结束编辑
            DispatchQueue.main.async {
                textFiled.resignFirstResponder()
            }
            allCursorHidden()
        }
        
    }
    
    @objc func textFiledDidEnd(_ textFiled: UITextField) {
        guard let inputStr = textFiled.text else { return }
        if isInput, inputStr.count >= inputTextNum {
            inputFinish?(inputStr)
        }
    }
}
