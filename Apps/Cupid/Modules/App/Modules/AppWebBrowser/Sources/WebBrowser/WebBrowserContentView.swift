//
// Created by jcc on 2022/6/22.
//

import ExtensionKit
import Foundation
import UICore
import UIKit
import WeakDelegate
import WebKit

class WebBrowserContentView: View {
    private lazy var uiDelegator = WebBrowserUIDelegator()
    private lazy var navigationDelegator = WebBrowserNavigationDelegator()

    private lazy var webViewObservations = [NSKeyValueObservation]()

    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
            .x
            .allowsInlineMediaPlayback(true)
            .mediaTypesRequiringUserActionForPlayback(.all)
            .instance
        let webView = WKWebView(frame: .zero, configuration: configuration)
            .x
            .backgroundColor(.systemWhite)
            .uiDelegate(uiDelegator)
            .navigationDelegate(navigationDelegator)
            .allowsLinkPreview(false)
            .instance

        webViewObservations.append(webView.observe(\.url, options: [.new]) { [weak self] (view: WKWebView, change: NSKeyValueObservedChange<URL?>) in
            guard let self = self else { return }
            self.observe(webView: view, valueChanged: change)
        })
        webViewObservations.append(webView.observe(\.title, options: [.new]) { [weak self] (view: WKWebView, change: NSKeyValueObservedChange<String?>) in
            guard let self = self else { return }
            self.observe(webView: view, valueChanged: change)
        })
        webViewObservations.append(webView.observe(\.estimatedProgress, options: [.new]) { [weak self] (view: WKWebView, change: NSKeyValueObservedChange<Double>) in
            guard let self = self else { return }
            self.observe(webView: view, valueChanged: change)
        })
        webViewObservations.append(webView.observe(\.canGoBack, options: [.new]) { [weak self] (view: WKWebView, change: NSKeyValueObservedChange<Bool>) in
            guard let self = self else { return }
            self.observe(webView: view, valueChanged: change)
        })
        webViewObservations.append(webView.observe(\.canGoForward, options: [.new]) { [weak self] (view: WKWebView, change: NSKeyValueObservedChange<Bool>) in
            guard let self = self else { return }
            self.observe(webView: view, valueChanged: change)
        })

        return webView
    }()

    private lazy var bridge = JavascriptBridge(webView: webView)

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: .zero)
            .x
            .items([
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backwardBarButtonItemAction(barButtonItem:))).x.isEnabled(false).instance,
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: #selector(forwardBarButtonItemAction(barButtonItem:))).x.isEnabled(false).instance,
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            ])
            .tintColor(.systemBlack)
            .isTranslucent(false)
            .isExclusiveTouch(true)
            .instance
        return toolBar
    }()

    private lazy var progressBar: UIProgressView = .init(progressViewStyle: .bar)
        .x
        .tintColor(.label)
        .instance

    private(set) lazy var titleChangeDelegator = Delegator<String, Void>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension WebBrowserContentView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension WebBrowserContentView {
    func setup() {
        backgroundColor = .systemWhite
        toolBar.x.add(to: self)
        progressBar.x.add(to: toolBar)
        webView.x.add(to: self)
        bridge.register(consoleCallback: { logger.debug("\($0)") })
        bridge.register(onErrorCallback: { logger.error("\($0)") })
    }

    func layout() {
        toolBar.pin.left().right().bottom().height(50)
        progressBar.pin.left().right().top().sizeToFit()
        webView.pin.left().right().top().above(of: toolBar)
    }

    func refreshToolBar() {
        toolBar.items.map { $0[safe: 2].map { $0.isEnabled = webView.canGoBack } }
        toolBar.items.map { $0[safe: 5].map { $0.isEnabled = webView.canGoForward } }
    }
}

// MARK: - Observers

private extension WebBrowserContentView {
    func observe(webView: WKWebView, valueChanged: NSKeyValueObservedChange<URL?>) {}

    func observe(webView: WKWebView, valueChanged: NSKeyValueObservedChange<String?>) {
        guard let title: String = valueChanged.newValue.flatten() else { return }
        titleChangeDelegator.call(title)
    }

    func observe(webView: WKWebView, valueChanged: NSKeyValueObservedChange<Double>) {
        let progress: Double = valueChanged.newValue.unwrapped(or: 0)
        switch progress {
        case 1:
            UIView.animate(withDuration: 2) {
                self.progressBar.setProgress(Float(progress), animated: true)
            } completion: {
                if $0 {
                    self.progressBar.isHidden = true
                    self.progressBar.setProgress(0, animated: false)
                }
            }
        case 0:
            progressBar.setProgress(Float(progress), animated: false)
        default:
            progressBar.setProgress(Float(progress), animated: true)
            progressBar.isHidden = false
        }
    }

    func observe(webView: WKWebView, valueChanged: NSKeyValueObservedChange<Bool>) {
        refreshToolBar()
    }
}

// MARK: - ToolBar Button Item Actions

private extension WebBrowserContentView {
    @objc
    func backwardBarButtonItemAction(barButtonItem: UIBarButtonItem) {
        guard webView.canGoBack else { return }
        webView.goBack()
    }

    @objc
    func forwardBarButtonItemAction(barButtonItem: UIBarButtonItem) {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
}

extension WebBrowserContentView {
    func reloadData(viewModel: WebBrowserViewModel) {
        let request = URLRequest(url: viewModel.url)
        webView.load(request)
    }
}
