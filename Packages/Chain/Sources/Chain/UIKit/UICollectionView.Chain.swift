//
// Created by jcc on 2022/5/25.
//

#if canImport(UIKit)
import UIKit.UICollectionView

@available(iOS 13.0, *)
public extension Box where T: UICollectionView {
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) -> Box {
        subject.register(cellClass, forCellWithReuseIdentifier: identifier)
        return subject.x
    }

    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) -> Box {
        subject.register(nib, forCellWithReuseIdentifier: identifier)
        return subject.x
    }

    func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) -> Box {
        subject.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return subject.x
    }

    func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String) -> Box {
        subject.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return subject.x
    }
}

#endif
