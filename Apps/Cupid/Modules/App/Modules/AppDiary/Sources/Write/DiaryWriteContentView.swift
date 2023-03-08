//
//  DiaryWriteContentView.swift
//  AppDiary
//
//  Created by jcc on 2023/3/8.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class DiaryWriteContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()
    private let margin: CGFloat = 10
    private lazy var textView = {
        let textView = UITextView(frame: .zero)
            .x
            .corners(radius: 20)
            .backgroundColor(.systemWhite)
            .contentInset(.init(top: margin, left: margin, bottom: margin, right: margin))
            .font(.preferredFont(forTextStyle: .body))
            .instance
        textView.addPlaceholder("这一刻,我想说")
        return textView
    }()
    
    var text: String? {
        get {
            textView.text
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

extension DiaryWriteContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
}

// MARK: - Private

private extension DiaryWriteContentView {
    func setup() {
        backgroundColor = DiaryModule.color(name: "App.BackgourndColor.Main")
        // add subview
        textView.x.add(to: self)
       
    }
    
    func layout() {
        // pinlayout
        textView.pin.top(margin).left(margin).right(margin).height(200)
    }
}




