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
import Center

class DiaryWritePictureCell: CollectionViewCell {
    private lazy var subscriptions = Set<AnyCancellable>()
    private lazy var imageView = UIImageView(frame: .zero)
        .x
        .contentMode(.scaleAspectFill)
        .masksToBounds(true)
        .instance
    
    private lazy var deleteButton = UIButton(type: .custom)
        .x
        .setImage(DiaryModule.image(name: "Picture.Delete"), for: .normal)
        .instance
    
    
    private lazy var progressLayer = {
        let layer = CAShapeLayer()
        let width = contentView.frame.size.width
        let path = UIBezierPath(arcCenter: contentView.center, radius: width/2, startAngle: -.pi/2.0, endAngle: .pi*3.0/2.0, clockwise: true)
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = DiaryModule.color(name: "Picture.Upload.Progress").cgColor
        layer.lineWidth = width;
        layer.strokeStart = 0;
        layer.strokeEnd = 1.0;
        layer.path = path.cgPath
        return layer
    }()
    
    var deleteAction: (()->Void)?
    var uploadAction: ((String) ->Void)?

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
        
        contentView.layer.masksToBounds = true
        
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
            if item.url == nil {
                upload(image: image)
            }
        }else {
            if let asset = item.asset {
                TZImageManager().getPhotoWith(asset) { image, _, _ in
                    if let image = image {
                        self.imageView.image = image
                        if item.url == nil {
                            self.upload(image: image)
                        }
                    }
                }
            }
        }
    }
    
    func upload(image: UIImage) {
        
        contentView.layer.addSublayer(progressLayer)
        progressLayer.strokeStart = 0.0
        TencentCOSCenter.upload(imageData: image.pngData()) { presenting in
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn))
            CATransaction.setAnimationDuration(0.5)
            self.progressLayer.strokeStart = CGFloat(presenting)
            CATransaction.commit()
        } complete: { result in
            self.progressLayer.removeFromSuperlayer()
            switch result {
            case .success(let url):
                self.uploadAction?(url)
            case .failure(let err):
                self.upload(image: image)
                logger.error("上传失败：\(err)")
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


