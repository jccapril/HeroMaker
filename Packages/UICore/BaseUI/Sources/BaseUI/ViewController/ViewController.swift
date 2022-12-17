//
//  Created by  on 2022/11/28.
//

import Foundation
import UIKit
import SFSafeSymbols

open class ViewController: UIViewController {
    open private(set) var isFirstLoad: Bool = true

    deinit { viewControllerDeinitBlock?(String(describing: self)) }
}

// MARK: - Public

public extension ViewController {
    var isInNavigationController: Bool {
        guard let navigationController = navigationController else { return false }
        return navigationController is NavigationController
    }

    func addDefaultLeftBarButtonItem(image: UIImage?, tintColor: UIColor? = nil) {
        let barButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        barButtonItem.tintColor = tintColor
        navigationItem.leftBarButtonItem = barButtonItem
    }

    /**
     设置头部元素的颜色，包括title,leftBarButtonItem,rightBarButtonItem
     - parameter tintColor: 色值
     */
    func setNavigationBarTintColor(tintColor: UIColor) {
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
    }

    /**
     设置头部标题的颜色
     - parameter titleColor: 色值
     */
    func setTitleAttributes(titleColor: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
    }

    /**
     设置LargeTitle的颜色
     - parameter titleColor: 色值
     */
    @available(iOS 13.0, *)
    func setLargeTitleAttributes(titleColor: UIColor) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
    }
}

// MARK: - Override

extension ViewController {
    @objc
    open func back() {
        navigationController?.popViewController(animated: true)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isChild { return }
        if parent?.isMember(of: ViewController.self) ?? false { return }

        viewWillAppearBlock?(String(describing: self))
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstLoad = false
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isChild { return }
        if parent?.isMember(of: ViewController.self) ?? false { return }

        viewWillDisappearBlock?(String(describing: self))
    }
}

// MARK: - Override Config

extension ViewController {
    @objc
    open var isChild: Bool { false }

    @objc
    open var isEnableScreenEdgePanGestureRecognizer: Bool { true }

    @objc
    open var backBarButtonItemImage: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemSymbol: .chevronLeft)
        }
        return nil
    }

    @objc
    open var itemTintColor: UIColor? {
        if #available(iOS 13.0, *) {
            return .label
        }
        return nil
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle { .default }

    override open var hidesBottomBarWhenPushed: Bool {
        get { (navigationController?.viewControllers.count ?? 0) > 1 }
        set { super.hidesBottomBarWhenPushed = newValue }
    }

    override open var shouldAutorotate: Bool { true }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { .portrait }

    @objc
    open var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { .never }

    @objc
    open var navigationBarIsUserInteractionEnabled: Bool { true }
}

// MARK: - Private

private extension ViewController {
    func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.setHidesBackButton(true, animated: true)
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        }

        if navigationController?.viewControllers.count ?? 0 > 1 {
            if let backBarButtonItemImage = backBarButtonItemImage {
                addDefaultLeftBarButtonItem(image: backBarButtonItemImage, tintColor: itemTintColor)
            }
        }
    }
}

