//
// Created by jcc on 2022/6/22.
//

import Foundation
import Service
import UICore
import UIKit

class WebBrowserViewController: ViewController {
    private let viewModel: WebBrowserViewModel
    private lazy var contentView = WebBrowserContentView(frame: .zero)

    init(url: URL) {
        viewModel = WebBrowserViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension WebBrowserViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

private extension WebBrowserViewController {
    func setup() {
        contentView.x.add(to: view)
        contentView.reloadData(viewModel: viewModel)
        bind()
    }

    func layout() {
        contentView.pin.all(view.pin.safeArea)
    }

    func bind() {
        contentView.titleChangeDelegator.delegate(on: self) {
            $0.navigationItem.title = $1
        }
    }
}

extension WebBrowserViewController: TypeNameable {}

extension WebBrowserViewController: Routable {
    class func initialize(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
        guard let urlStringEncoded = values["urlString"] as? String else { return nil }
        guard let urlStringDecoded = urlStringEncoded.removingPercentEncoding else { return nil }
        guard let url = URL(string: urlStringDecoded) else { return nil }
        return WebBrowserViewController(url: url)
    }

    static let routeName: String = typeName + "/<string:urlString>"
}
