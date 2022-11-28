//
//  Created by  on 2022/11/28.
//

import Foundation
import UIKit

open class NavigationController: UINavigationController {
    override private init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }

    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        pushViewController(rootViewController, animated: false)
    }

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { viewControllerDeinitBlock?(String(describing: self)) }
}

// MARK: - Override

extension NavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearBlock?(String(describing: self))
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearBlock?(String(describing: self))
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    override open var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    override open var childForStatusBarHidden: UIViewController? {
        topViewController
    }

    override open var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        precondition(viewController is ViewController, "\(viewController) must be subclass of ViewController")
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Custom Override

extension NavigationController {
    @objc
    open var navigationBarIsUserInteractionEnabled: Bool {
        guard let viewController = topViewController as? ViewController else { return true }
        return viewController.navigationBarIsUserInteractionEnabled
    }
}

// MARK: - Private

private extension NavigationController {
    func setup() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        let navigationBar = navigationBar as? NavigationBar
        navigationBar?.set(navigationController: self)
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        guard let topViewController = topViewController as? ViewController else { return false }
        return topViewController.isEnableScreenEdgePanGestureRecognizer
    }
}

// MARK: - Assert

extension NavigationController {
    @available(*, unavailable)
    override open func setNavigationBarHidden(_: Bool, animated _: Bool) {
        fatalError("DO NOT CALL THIS")
    }

    // swiftlint:disable unused_setter_value
    override open var isNavigationBarHidden: Bool {
        get { super.isNavigationBarHidden }
        set { fatalError("DO NOT CALL THIS") }
    }
}

