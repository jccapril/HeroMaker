//
//  Created by jcc on 2022/11/29.
//

#if canImport(UIKit)
import UIKit

public final class Refresher: UIView {
    private var scrollViewOriginalInset: UIEdgeInsets = .zero
    private weak var scrollView: UIScrollView?
    private var panGesture: UIPanGestureRecognizer?

    private var contentOffsetObservation: NSKeyValueObservation?
    private var contentSizeObservation: NSKeyValueObservation?
    private var panGestureStateObservation: NSKeyValueObservation?

    private var topInsetDelta: CGFloat = 0
    private var lastBottomDelta: CGFloat = 0

    private let animateView: Refreshable
    private var noMoreDataView: UIView?
    private let action: Action
    private var codeRefreshing: Bool = false

    public internal(set) var position: Position

    public var isEnable: Bool = true {
        didSet {
            if isEnable, position == .bottom {
                removeNoMoreDataView()
            }
        }
    }

    public var isRefreshing: Bool {
        state == .refreshing
    }

    private(set) var state: State = .idle {
        didSet {
            if oldValue === state { return }
            animateView.animate(state: state)
            if state == .idle {
                if oldValue != .refreshing { return }
                endAction()
            } else if state == .refreshing {
                refreshingAction()
            }
        }
    }

    public init(
        animateView: Refreshable = RefreshView(),
        position: Position = .top,
        height: CGFloat = 52,
        action: @escaping Action
    ) {
        self.animateView = animateView
        self.position = position
        self.action = action

        super.init(frame: .zero)
        frame.size.height = height
        prepare()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit {
        removeObservers()
    }
}

// MARK: - Public

public extension Refresher {
    func beginRefreshing() {
        if !isEnable { return }
        if state == .refreshing { return }
        codeRefreshing = true
        DispatchQueue.main.async {
            self.state = .pulling(progress: 1)
            self.state = .refreshing
        }
    }

    func endRefreshing(_ noMoreDataView: UIView? = nil) {
        self.noMoreDataView = noMoreDataView
        codeRefreshing = false
        DispatchQueue.main.async {
            self.setupNoMoreDataView()
            self.state = .idle
        }
    }
}

// MARK: - Override

public extension Refresher {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let newSuperview = newSuperview as? UIScrollView else {
            return
        }
        removeObservers()
        scrollView = newSuperview
        newSuperview.alwaysBounceVertical = true
        setupFrame()
        if #available(iOS 11.0, *) {
            scrollViewOriginalInset = newSuperview.adjustedContentInset
        } else {
            scrollViewOriginalInset = newSuperview.contentInset
        }

        addObservers()
    }
}

private extension Refresher {
    func prepare() {
        autoresizingMask = .flexibleWidth
        backgroundColor = .clear
        addSubview(animateView)
        animateView.frame = bounds
        animateView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setupFrame() {
        guard let scrollView = scrollView else { return }
        frame.size.width = scrollView.frame.width
        frame.origin.x = -scrollView.leftInset
        frame.origin.y = position == .top ? -frame.height : scrollView.contentHeight
    }

    func removeNoMoreDataView() {
        DispatchQueue.main.async {
            self.noMoreDataView?.removeFromSuperview()
            self.noMoreDataView = nil
            self.animateView.isHidden = false
        }
    }

    func setupNoMoreDataView() {
        guard let noMoreDataView = noMoreDataView, position == .bottom else { return }
        isEnable = false

        noMoreDataView.alpha = 0
        noMoreDataView.frame.size.width = frame.width
        if noMoreDataView.frame.height <= 0 {
            noMoreDataView.frame.size.height = frame.height
        }
        noMoreDataView.autoresizingMask = [.flexibleWidth]
        addSubview(noMoreDataView)

        UIView.animate(withDuration: 0.1) {
            noMoreDataView.alpha = 1
            self.animateView.alpha = 0
        } completion: { _ in
            self.animateView.isHidden = true
            self.animateView.alpha = 1
        }
    }

    func resetInset() {
        guard let scrollView = scrollView else { return }
        let originalInsetTop = scrollViewOriginalInset.top

        var topInset = max(-scrollView.offsetY, originalInsetTop)
        topInset = min(frame.height + originalInsetTop, topInset)

        topInsetDelta = originalInsetTop - topInset

        if scrollView.topInset != topInset {
            scrollView.topInset = topInset
        }
    }

    func addObservers() {
        contentOffsetObservation = scrollView?.observe(\.contentOffset, options: [.old, .new]) { [weak self] scrollView, change in
            guard scrollView.isUserInteractionEnabled else { return }
            self?.scrollViewContentOffsetDidChange(change)
        }
        contentSizeObservation = scrollView?.observe(\.contentSize, options: [.old, .new]) { [weak self] scrollView, change in
            guard scrollView.isUserInteractionEnabled else { return }
            self?.scrollViewContentSizeDidChange(change)
        }

        panGesture = scrollView?.panGestureRecognizer
        panGestureStateObservation = panGesture?.observe(\.state, options: [.old, .new]) { [weak self] _, change in
            self?.scrollViewPanGestureStateDidChange(change)
        }
    }

    func removeObservers() {
        contentOffsetObservation?.invalidate()
        contentOffsetObservation = nil
        contentSizeObservation?.invalidate()
        contentSizeObservation = nil
        panGestureStateObservation?.invalidate()
        panGestureStateObservation = nil
        panGesture = nil
    }

    func topRefresherContentOffsetChangeAction() {
        guard let scrollView = scrollView else { return }
        if state == .refreshing {
            resetInset()
            return
        }
        scrollViewOriginalInset = scrollView.inset

        let offsetY = scrollView.offsetY
        let appearOffsetY = getAppearOffsetY()

        if offsetY > appearOffsetY { return }

        let normal2pullingOffsetY = appearOffsetY - frame.height
        let pullingPercent = (appearOffsetY - offsetY) / frame.height

        if scrollView.isDragging {
            if state == .idle || state == .pulling(progress: -1), offsetY >= normal2pullingOffsetY {
                state = .pulling(progress: min(pullingPercent, 1.0))
            } else if state == .pulling(progress: 1.0) || state == .willRefresh(overOffset: -1), offsetY < normal2pullingOffsetY {
                if state == .pulling(progress: 1.0) {
                    state = .pulling(progress: 1.0)
                }
                state = .willRefresh(overOffset: normal2pullingOffsetY - offsetY)
            } else if state == .willRefresh(overOffset: -1), offsetY >= normal2pullingOffsetY {
                state = .pulling(progress: min(pullingPercent, 1.0))
            }
        } else if state == .willRefresh(overOffset: -1) {
            state = .refreshing
        }
    }

    func bottomRefresherContentOffsetChangeAction() {
        guard let scrollView = scrollView else { return }
        if state == .refreshing {
            return
        }
        scrollViewOriginalInset = scrollView.inset
        let offsetY = scrollView.offsetY
        let appearOffsetY = getAppearOffsetY()

        if offsetY <= appearOffsetY { return }

        let normal2pullingOffsetY = appearOffsetY + frame.height
        let pullingPercent = (offsetY - appearOffsetY) / frame.height

        if scrollView.isDragging {
            if state == .idle || state == .pulling(progress: -1), offsetY < normal2pullingOffsetY {
                state = .pulling(progress: min(pullingPercent, 1.0))
            } else if state == .pulling(progress: 1.0) || state == .willRefresh(overOffset: -1), offsetY >= normal2pullingOffsetY {
                if state == .pulling(progress: 1.0) {
                    state = .pulling(progress: 1.0)
                }
                state = .willRefresh(overOffset: offsetY - normal2pullingOffsetY)
            } else if state == .willRefresh(overOffset: -1), offsetY < normal2pullingOffsetY {
                state = .pulling(progress: min(pullingPercent, 1.0))
            }
        } else if state == .willRefresh(overOffset: -1) {
            state = .refreshing
        }
    }

    func refreshingAction() {
        guard let scrollView = scrollView else { return }
        guard scrollView.panGestureRecognizer.state != .cancelled else {
            action(self)
            return
        }
        UIView.animate(withDuration: 0.25) {
            if self.position == .top {
                let top = self.scrollViewOriginalInset.top + self.frame.height
                scrollView.topInset = top
                var offset = scrollView.contentOffset
                offset.y = -top
                scrollView.setContentOffset(offset, animated: false)
            } else if !self.codeRefreshing {
                var bottom = self.frame.height + self.scrollViewOriginalInset.bottom
                let deltaHeight = self.heightForContentBreakView()
                if deltaHeight < 0 {
                    bottom -= deltaHeight
                }
                self.lastBottomDelta = bottom - scrollView.bottomInset
                scrollView.bottomInset = bottom
                var offset = scrollView.contentOffset
                offset.y = self.getAppearOffsetY() + self.frame.height
                scrollView.setContentOffset(offset, animated: false)
            }
        } completion: { _ in
            self.action(self)
        }
    }

    func endAction() {
        guard let scrollView = scrollView else { return }
        UIView.animate(withDuration: 0.35) {
            if self.position == .top {
                scrollView.topInset += self.topInsetDelta
            } else if !self.codeRefreshing {
                self.lastBottomDelta -= (self.noMoreDataView?.frame.height ?? 0)
                scrollView.bottomInset -= self.lastBottomDelta
            }
        }
    }

    func scrollViewContentOffsetDidChange(_ change: NSKeyValueObservedChange<CGPoint>?) {
        if !isEnable { return }
        if position == .top {
            topRefresherContentOffsetChangeAction()
        } else {
            bottomRefresherContentOffsetChangeAction()
        }
    }

    func scrollViewContentSizeDidChange(_ change: NSKeyValueObservedChange<CGSize>?) {
        guard let scrollView = scrollView else { return }
        guard position == .bottom else { return }
        frame.origin.y = scrollView.contentHeight
    }

    func scrollViewPanGestureStateDidChange(_ change: NSKeyValueObservedChange<UIPanGestureRecognizer.State>?) {
        if position == .top, panGesture?.state == .ended, state == .pulling(progress: -1) {
            state = .idle
        }
    }

    func heightForContentBreakView() -> CGFloat {
        guard let scrollView = scrollView else { return 0 }
        let h = scrollView.frame.height - scrollViewOriginalInset.bottom - scrollViewOriginalInset.top
        return scrollView.contentSize.height - h
    }

    func getAppearOffsetY() -> CGFloat {
        if position == .bottom {
            let deltaHeight = heightForContentBreakView()
            if deltaHeight > 0 {
                return deltaHeight - scrollViewOriginalInset.top
            }
        }
        return -scrollViewOriginalInset.top
    }
}

#endif
