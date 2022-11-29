//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)
import UIKit

public final class RefreshView: UIView {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            return activityIndicator
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            return activityIndicator
        }
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

private extension RefreshView {
    func setup() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func transform(to progress: CGFloat) {
        activityIndicator.isHidden = false
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: progress, y: progress)
        transform = transform.rotated(by: CGFloat(Double.pi) * progress * 2)
        activityIndicator.transform = transform
    }
}


extension RefreshView: Refreshable {
    public func animate(state: Refresher.State) {
        switch state {
        case .idle:
            activityIndicator.stopAnimating()
        case let .pulling(progress):
            transform(to: progress)
        case .willRefresh:
            transform(to: 1)
        case .refreshing:
            activityIndicator.startAnimating()
        }
    }
}

#endif
