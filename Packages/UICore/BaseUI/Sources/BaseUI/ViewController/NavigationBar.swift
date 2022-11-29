//
//  Created by  on 2022/11/28.
//

import Foundation
import UIKit

public class NavigationBar: UINavigationBar {
    private weak var navigationController: NavigationController?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }
}

private extension NavigationBar {
    func setup() {
        isExclusiveTouch = true
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        shadowImage = UIImage()
    }
}

extension NavigationBar {
    func set(navigationController: NavigationController?) {
        self.navigationController = navigationController
    }
}

extension NavigationBar {
    override open var isHidden: Bool {
        get { super.isHidden }
        set {
            switch newValue {
            case true: fatalError("DO NOT HIDE NavigationBar")
            case false: super.isHidden = newValue
            }
        }
    }

    override open var prefersLargeTitles: Bool {
        get { true }
        set {
            switch newValue {
            case true: fatalError("DO NOT DISABLE THIS")
            case false: super.isHidden = newValue
            }
        }
    }

    override open var isUserInteractionEnabled: Bool {
        get {
            switch navigationController {
            case .none:
                return super.isUserInteractionEnabled
            case let .some(navigationController):
                return navigationController.navigationBarIsUserInteractionEnabled
            }
        }
        set { super.isUserInteractionEnabled = newValue }
    }
}

