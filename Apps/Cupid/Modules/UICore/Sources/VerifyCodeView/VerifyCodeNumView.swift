//
//  VerifyCodeNumView.swift
//  VerifyCodeView
//
//  Created by jcc on 2023/2/25.
//

import UIKit
import UILayout
import BaseUI
import Chain

public class VerifyCodeNumView: View {
    /// 光标颜色
    var cursorColor = UIColor(hex: 0xDC3E7A)
    
    fileprivate lazy var numLabel: UILabel = UILabel(frame: .zero)
        .x
        .textAlignment(.center)
        .font(.boldSystemFont(ofSize: 24))
        .instance
    
    fileprivate lazy var lineView: UIView = UIView(frame: .zero)
        .x
        .backgroundColor(UIColor(hex: 0xe6e6e6))
        .instance
    
    /// 光标
    lazy var cursor: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = cursorColor.cgColor
        shapeLayer.add(opacityAnimation, forKey: "kOpacityAnimation")
        return shapeLayer
    }()
    
    /// 闪烁动画
    fileprivate var opacityAnimation: CABasicAnimation = {
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        // 属性初始值
        opacityAnimation.fromValue = 1.0
        // 属性要到达的值
        opacityAnimation.toValue = 0.0
        // 动画时间
        opacityAnimation.duration = 0.9
        // 重复次数(无穷大)
        opacityAnimation.repeatCount = HUGE
        /*
         removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
         */
        opacityAnimation.isRemovedOnCompletion = true
        // 决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
        opacityAnimation.fillMode = .forwards
        // 速度控制函数，控制动画运行的节奏
        /*
         kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
         kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
         kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
         kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
         */
        opacityAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
        return opacityAnimation
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    deinit {
          NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Override

extension VerifyCodeNumView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        // pinlayout
        layout()
    }
}

// MARK: - Private

fileprivate extension VerifyCodeNumView {
    
    func setup() {
        numLabel.x.add(to: self)
        lineView.x.add(to: self)
        layer.addSublayer(cursor)
        
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterBack), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func layout() {
        
        numLabel.pin.left(0).right(0).top(0).bottom(1)
        lineView.pin.below(of: numLabel).left(0).right(0).bottom(0)
        
        let path = UIBezierPath(rect: CGRect.init(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.1, width: 2, height: self.frame.size.height * 0.7))
        cursor.path = path.cgPath
    }
    
    /// 去后台
    @objc func enterBack() {
        // 移除动画
        cursor.removeAnimation(forKey: "kOpacityAnimation")
    }
    
    /// 回前台
    @objc func becomeActive() {
        // 重新添加动画
        cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
    }
}


// MARK: - 供外部调用方法
public extension VerifyCodeNumView {
    /// 设置光标是否隐藏
    ///
    /// - Parameter isHidden: 是否隐藏
    func setCursorStatus(_ isHidden: Bool) {
        if isHidden {
            cursor.removeAnimation(forKey: "kOpacityAnimation")
        } else {
            cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
        }
        UIView.animate(withDuration: 0.25) {
            self.cursor.isHidden = isHidden
        }
    }
    
    /// 验证码赋值，并修改线条颜色
    ///
    /// - Parameter num: 验证码
    func setNum(num: String?) {
        numLabel.text = num
    }
    
    /// 设置底部线条是否为焦点
    ///
    /// - Parameter isFocus: 是否是焦点
    func setBottomLineFocus(isFocus: Bool) {
        if isFocus {
            lineView.backgroundColor = UIColor(hex: 0x999999)
        } else {
            lineView.backgroundColor = UIColor(hex: 0xe6e6e6)
        }
    }
    
    /// 获取当前的验证码
    ///
    /// - Returns: 验证码
    func getNum() -> String {
        return numLabel.text ?? ""
    }
    
    /// 返回验证码值
    ///
    /// - Returns: 验证码数值
    func getNum() -> String? {
        return numLabel.text
    }
}
