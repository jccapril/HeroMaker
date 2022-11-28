//
// Created by jcc on 2022/6/21.
//

import UIKit

@available(iOS 13.0, *)
class ProgressView: UIView {
    var color: UIColor = .systemBackground {
        didSet { setupLayers() }
    }

    private var progress: CGFloat = 0

    private var layerCircle = CAShapeLayer()
    private var layerProgress = CAShapeLayer()
    private var labelPercentage: UILabel = .init()

    override init(frame: CGRect) { super.init(frame: frame) }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    convenience init(_ color: UIColor) {
        self.init(frame: .zero)
        self.color = color
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayers()
    }
}

@available(iOS 13.0, *)
private extension ProgressView {
    func setupLayers() {
        subviews.forEach { $0.removeFromSuperview() }
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let width = frame.size.width
        let height = frame.size.height

        let center = CGPoint(x: width / 2, y: height / 2)
        let radiusCircle = width / 2
        let radiusProgress = width / 2 - 5

        let pathCircle = UIBezierPath(arcCenter: center, radius: radiusCircle, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        let pathProgress = UIBezierPath(arcCenter: center, radius: radiusProgress, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

        layerCircle.path = pathCircle.cgPath
        layerCircle.fillColor = UIColor.clear.cgColor
        layerCircle.lineWidth = 3
        layerCircle.strokeColor = color.cgColor

        layerProgress.path = pathProgress.cgPath
        layerProgress.fillColor = UIColor.clear.cgColor
        layerProgress.lineWidth = 7
        layerProgress.strokeColor = color.cgColor
        layerProgress.strokeEnd = 0

        layer.addSublayer(layerCircle)
        layer.addSublayer(layerProgress)

        labelPercentage.frame = bounds
        labelPercentage.textColor = color
        labelPercentage.textAlignment = .center
        addSubview(labelPercentage)
    }
}

@available(iOS 13.0, *)
extension ProgressView {
    func setProgress(_ value: CGFloat, duration: TimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progress
        animation.toValue = value
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        layerProgress.add(animation, forKey: "animation")

        progress = value
        labelPercentage.text = "\(Int(value * 100))%"
    }
}
