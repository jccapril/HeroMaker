//
//  DiaryWriteCell.swift
//  AppDiary
//
//  Created by jcc on 2023/3/13.
//

import Foundation
import UICore
import UIKit
import Photos

class DiaryWritePictureCell: CollectionViewCell {
    private lazy var subscriptions = Set<AnyCancellable>()
    private lazy var imageView = UIImageView(frame: .zero)
        .x
        .contentMode(.scaleAspectFill)
        .masksToBounds(true)
        .instance
    
    private lazy var deleteButton = UIButton(type: .custom)
        .x
//        .corners(radius: 10)
        .setImage(DiaryModule.image(name: "Picture.Delete"), for: .normal)
//        .backgroundColor(DiaryModule.color(name: "Picture.Delete"))
        .instance
    
    var deleteAction: (()->Void)?

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - override

extension DiaryWritePictureCell {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}


// MARK: - private

private extension DiaryWritePictureCell {
    
    func setup() {
        imageView.x.add(to: contentView)
        deleteButton.x.add(to: contentView)
        
        deleteButton.tapPublisher.receive(on: DispatchQueue.main).sink { [weak self] _ in
            guard let self = self else { return }
            self.deleteAction?()
        }
        .store(in: &subscriptions)

    }
    
    func layout() {
        imageView.pin.all()
        deleteButton.pin.top(4).right(4).width(24).height(24)
    }
    
}

// MARK: - Interal

extension DiaryWritePictureCell {
    
    func config(item: DiaryWritePictureItemViewModel) {
        if let image = item.picture {
            imageView.image = image
        }else {
            if let asset = item.asset {
                TZImageManager().getPhotoWith(asset) { image, _, _ in
                    if let image = image {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
}


class DiaryWriteCaremaCell: CollectionViewCell {
    
    private lazy var imageView = UIImageView(frame: .zero)
        .x
        .image(DiaryModule.image(name: "Diary.Carema"))
        .contentMode(.scaleAspectFill)
        .masksToBounds(true)
        .instance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - override

extension DiaryWriteCaremaCell {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}


// MARK: - private

private extension DiaryWriteCaremaCell {
    
    func setup() {
        contentView.backgroundColor = DiaryModule.color(name: "Primary--")
        imageView.x.add(to: contentView)
        
        addDashedBorder(to: contentView, withColor: DiaryModule.color(name: "Primary-"), andWidth: 2, andPattern: [4,4])
    }
    
    func layout() {
        imageView.pin.center().width(36).aspectRatio()
    }
    
    func addDashedBorder(to view: UIView, withColor color: UIColor, andWidth borderWidth: CGFloat, andPattern pattern: [NSNumber]) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineDashPattern = pattern
        shapeLayer.fillColor = UIColor.clear.cgColor
        let path = CGMutablePath()
        path.addRect(view.bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2))
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
}


