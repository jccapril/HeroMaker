//
// Created by jcc on 2022/3/10.
//

#if canImport(UIKit)
import UIKit

public extension Box where T: UIView {
    @discardableResult
    func corners(_ corners: UIRectCorner = .allCorners, radius: CGFloat, isReset: Bool = false) -> Box {
        subject.layoutIfNeeded()

        if #available(iOS 11, *) {
            subject.layer.cornerRadius = radius
            var maskedCorners = CACornerMask()
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            subject.layer.maskedCorners = maskedCorners
        } else {
            if corners == .allCorners {
                subject.layer.cornerRadius = radius
            } else {
                if isReset { subject.layer.cornerRadius = 0 }
                let path = UIBezierPath(roundedRect: subject.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                subject.layer.mask = mask
            }
        }

        subject.layer.masksToBounds = true

        return subject.x
    }

    @discardableResult
    func add(to supperView: UIView) -> T {
        supperView.addSubview(subject)
        return subject
    }
}

#endif
