//
//  RegisterContentView.swift
//  AppLogin
//
//  Created by jcc on 2022/12/16.
//

import UICore
import UIKit
import UICombine
import WeakDelegate

class RegisterContentView: View {
    private lazy var subscriptions = Set<AnyCancellable>()

    private(set) lazy var finishDelegator = Delegator<Void, Void>()
    private(set) lazy var nameChangeDelegator = Delegator<String?, Void>()
    private(set) lazy var genderChangeDelegator = Delegator<Int?, Void>()
    
    private lazy var scrollView = UIScrollView(frame: .zero)
        .x
        .showsVerticalScrollIndicator(false)
        .showsHorizontalScrollIndicator(false)
        .scrollEnabled(false)
        .pagingEnabled(true)
        .instance
    
    private lazy var nameEditView = NameEditView(frame: .zero)

    
    private lazy var genderEditView = GenderEditView(frame: .zero)

//    private lazy var birthdayEditView = BirthdayEditView(frame: .zero)
    
    private var currentPage = 0
    private let total = 2


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - Override

extension RegisterContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    
    }
}


// MARK: - Private

private extension RegisterContentView {
    func setup() {
        backgroundColor = .systemWhite
        scrollView.x.add(to: self)
        nameEditView.x.add(to: scrollView)
        genderEditView.x.add(to: scrollView)
//        birthdayEditView.x.add(to: scrollView)
    }
    
    func layout() {
        scrollView.pin.all()
        scrollView.contentSize = CGSize(width: self.bounds.width * 2, height: self.bounds.height)
        nameEditView.pin.top().left().bottom().width(bounds.width)
        genderEditView.pin.right(of: nameEditView).top().bottom().width(bounds.width)
//        birthdayEditView.pin.right(of: genderEditView).top().bottom().width(bounds.width)
    }
    
    func bind() {
        nameEditView.nextAction = { [weak self] name in
            guard let self = self else {
                return
            }
            self.nameChangeDelegator(name)
            self.nextPage()
        }
        
        genderEditView.nextAction = { [weak self] gender in
            guard let self = self else {
                return
            }
            self.genderChangeDelegator(gender)
            self.finishDelegator()
        }
        
        genderEditView.prevAction = { [weak self]  in
            guard let self = self else {
                return
            }
            self.prevPage()
        }
        
//        birthdayEditView.prevAction =  { [weak self]  in
//            guard let self = self else {
//                return
//            }
//            self.prevPage()
//        }
        
    }
    
    func nextPage() {
        if(currentPage == (total - 1)) {
            return
        }
        currentPage+=1
        self.scrollView.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(currentPage), y: 0), animated: true)
    }
    
    func prevPage() {
        if(currentPage == 0) {
            return
        }
        currentPage-=1
        self.scrollView.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(currentPage), y: 0), animated: true)
    }
}



// MARK: - Internal

extension RegisterContentView {
    
    func update(vm: RegisterViewModel) {
        nameEditView.value = vm.name
        genderEditView.value = vm.gender
    }
    
    
}

