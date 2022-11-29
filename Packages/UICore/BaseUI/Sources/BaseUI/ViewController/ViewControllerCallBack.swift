//
//  Created by  on 2022/11/28.
//

public typealias ViewControllerViewWillAppear = (_ name: String) -> Void
public typealias ViewControllerViewWillDisappear = (_ name: String) -> Void
public typealias ViewControllerDeinit = (_ name: String) -> Void

private(set) var viewWillAppearBlock: ViewControllerViewWillAppear?
private(set) var viewWillDisappearBlock: ViewControllerViewWillDisappear?
private(set) var viewControllerDeinitBlock: ViewControllerDeinit?

public func register(viewWillAppearAction: ViewControllerViewWillAppear?, viewWillDisappearAction: ViewControllerViewWillDisappear?) {
    viewWillAppearBlock = viewWillAppearAction
    viewWillDisappearBlock = viewWillDisappearAction
}

public func register(viewControllerDeinitAction: ViewControllerDeinit?) {
    viewControllerDeinitBlock = viewControllerDeinitAction
}

