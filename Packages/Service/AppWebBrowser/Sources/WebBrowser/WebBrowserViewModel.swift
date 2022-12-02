//
// Created by jcc on 2022/6/22.
//

import Foundation
import UICore

class WebBrowserViewModel: ViewModel {
    let url: URL

    init(url: URL) {
        self.url = url
        super.init()
    }
}
