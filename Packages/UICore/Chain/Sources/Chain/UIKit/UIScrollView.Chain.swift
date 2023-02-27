//
//  File.swift
//  
//
//  Created by jcc on 2023/2/27.
//

#if canImport(UIKit)
import UIKit

public extension Box where T: UIScrollView {
    @discardableResult
    func contentSize(_ size: CGSize) -> Box {
        subject.contentSize = size
        return subject.x
    }
    
    @discardableResult
    func pagingEnabled(_ enabled:Bool) -> Box {
        subject.isPagingEnabled = enabled
        return subject.x
    }
    
    @discardableResult
    func showsHorizontalScrollIndicator(_ isShow: Bool) -> Box {
        subject.showsHorizontalScrollIndicator = isShow
        return subject.x
    }
    
    @discardableResult
    func showsVerticalScrollIndicator(_ isShow: Bool) -> Box {
        subject.showsVerticalScrollIndicator = isShow
        return subject.x
    }
    
    @discardableResult
    func scrollEnabled(_ enabled: Bool) -> Box {
        subject.isScrollEnabled = enabled
        return subject.x
    }

    
}


#endif
