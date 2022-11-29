//
//  Created by jcc on 2022/11/29.
//

#if canImport(Foundation)
import Foundation

public extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

#endif

