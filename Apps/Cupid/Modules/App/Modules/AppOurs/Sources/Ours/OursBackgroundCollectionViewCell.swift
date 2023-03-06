//
//  OursBackgroundCollectionViewCell.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import Foundation
import UICore
import Center
import UIKit

class OursBackgroundCollectionViewCell: CollectionViewCell {
    private lazy var subscriptions = Set<AnyCancellable>()
    private lazy var titleLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .headline))
        .textColor(.systemWhite)
        .instance
    
    private lazy var countdownLabel = UILabel(frame: .zero)
        .x
        .font(.preferredFont(forTextStyle: .headline))
//        .text("第 170 天 14 小时 03 分 03 秒")
        .textColor(.systemWhite)
        .instance
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var coupleInfo: CoupleInfo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension OursBackgroundCollectionViewCell {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension OursBackgroundCollectionViewCell {
    
    
    func setup() {
        contentView.backgroundColor = OursModule.color(name: "Primary--")
        titleLabel.x.add(to: contentView)
        countdownLabel.x.add(to: contentView)
        
        
    }
    
    func layout() {
        titleLabel.pin.center().marginBottom(20).sizeToFit()
        countdownLabel.pin.center().marginTop(20).sizeToFit()
    }
    
    func bind() {
        timer.receive(on: DispatchQueue.main).sink {[weak self] _ in
            guard let self = self else { return }
            guard let startedAt = Date.from(self.coupleInfo?.startedAt, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSXXX") else { return }
            self.showCountDown(startedAt: startedAt)
        }
        .store(in: &subscriptions)
    }
    
    
}


// MARK: - config data
extension OursBackgroundCollectionViewCell {
    func config(coupleInfo: CoupleInfo?) {
        self.coupleInfo = coupleInfo
        guard let coupleInfo = coupleInfo else { return }
        guard let selfName = UserCenter.userInfo?.name, let partnerName = coupleInfo.partner?.name else { return }
        titleLabel.text = "\(selfName) 💗 \(partnerName)"
        guard let startedAt = Date.from(coupleInfo.startedAt, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSXXX") else { return }
        showCountDown(startedAt: startedAt)
        
        setNeedsLayout()
    }
    
    func showCountDown(startedAt: Date) {
        var interval = -Int(startedAt.timeIntervalSinceNow)
        let day = 24 * 60 * 60
        let hour = 60 * 60
        let minute = 60
        
        let leftDay = interval / day
        interval -= leftDay * day
        let leftHour = interval / hour
        interval -= leftHour * hour
        let leftMinute = interval / minute
        interval -= leftMinute * minute
        let leftSecond = interval
        countdownLabel.text =  String(format: "第 %d 天 %02d 小时 %02d 分 %02d 秒", leftDay, leftHour, leftMinute, leftSecond)
        setNeedsLayout()
    }
    
}
