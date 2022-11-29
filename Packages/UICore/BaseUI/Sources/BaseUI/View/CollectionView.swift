//
//  Created by  on 2022/11/28.
//

import UIKit

open class CollectionView: UICollectionView {
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupTapToDismissKeyboard()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

public extension CollectionView {
    func register<CellClass: CollectionViewCell>(_ cellClass: CellClass.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.cellID)
    }

    func dequeueReusableCell<CellClass: CollectionViewCell>(for indexPath: IndexPath) -> CellClass {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellClass.cellID, for: indexPath) as? CellClass else { fatalError("\(CellClass.cellID) dequeue for \(indexPath) error") }
        return cell
    }
}

private extension CollectionView {
    func setupTapToDismissKeyboard() {
        guard isEnableTapToDismissKeyboard else { return }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(tapGestureRecognizer:)))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    func tapGestureAction(tapGestureRecognizer: UITapGestureRecognizer) {
        endEditing(true)
    }
}

extension CollectionView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension CollectionView {
    open var isEnableTapToDismissKeyboard: Bool { false }
}
