//
//  Created by jcc on 2022/11/29.
//

#if canImport(Foundation)

import Foundation

public extension Bundle {
    var version: Optional<String> {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var build: Optional<String> {
        infoDictionary?["CFBundleVersion"] as? String
    }
}

#endif

