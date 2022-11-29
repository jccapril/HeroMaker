//
//  Created by  on 2022/11/28.
//

import UIKit

open class TabBarViewController: UITabBarController {
    open private(set) var isFirstLoad: Bool = true

    public required init(viewControllers: [UIViewController]?, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewControllers = viewControllers
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { viewControllerDeinitBlock?(String(describing: self)) }
}

// MARK: - Override

extension TabBarViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearBlock?(String(describing: self))
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstLoad = false
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearBlock?(String(describing: self))
    }
}

// MARK: - Private

private extension TabBarViewController {
    func setup() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
    }
}

// MARK: - Override Config

public extension TabBarViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        viewControllers?[selectedIndex].preferredStatusBarStyle ?? .default
    }

    override var shouldAutorotate: Bool {
        viewControllers?[selectedIndex].shouldAutorotate ?? false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        viewControllers?[selectedIndex].supportedInterfaceOrientations ?? .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        viewControllers?[selectedIndex].preferredInterfaceOrientationForPresentation ?? .portrait
    }
}

