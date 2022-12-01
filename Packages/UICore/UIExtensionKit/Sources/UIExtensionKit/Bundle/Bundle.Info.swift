//
//  Created by jcc on 2022/12/1.
//

import Foundation

public extension Bundle {
    var displayName: Optional<String> {
        infoDictionary?["CFBundleDisplayName"] as? String
    }
}

