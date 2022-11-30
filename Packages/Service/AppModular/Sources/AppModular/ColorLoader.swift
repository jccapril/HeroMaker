//
//  Created by jcc on 2022/11/30.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public protocol ColorLoader: AnyObject {
    static var bundle: Bundle { get }
    #if canImport(UIKit)
    static func color(name: String) -> UIColor
    #endif
}

public extension ColorLoader {
    #if canImport(UIKit)
    @available(iOS 11.0, *)
    static func color(name: String) -> UIColor {
        guard let color = UIColor(named: name, in: bundle, compatibleWith: nil) else {
            fatalError("\(name) color not found in \(bundle)")
        }
        return color
    }
    #endif

    #if canImport(AppKit)
    @available(macOS 10.13, *)
    static func color(name: String) -> NSColor {
        guard let color = NSColor(named: name, bundle: bundle) else {
            fatalError("\(name) color not found in \(bundle)")
        }
        return color
    }
    #endif
}

