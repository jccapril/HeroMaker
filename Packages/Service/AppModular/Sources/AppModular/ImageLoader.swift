//
//  File.swift
//  
//
//  Created by jcc on 2023/2/27.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public protocol ImageLoader: AnyObject {
    static var bundle: Bundle { get }
    #if canImport(UIKit)
    static func image(name: String) -> UIImage
    #endif
}

public extension ImageLoader {
    #if canImport(UIKit)
    @available(iOS 11.0, *)
    static func image(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: bundle, compatibleWith: nil) else {
            fatalError("\(name) image not found in \(bundle)")
        }
        return image
    }
    #endif
}


