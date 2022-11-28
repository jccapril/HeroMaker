//
//  Created by  on 2022/11/28.
//

import Foundation
import UIKit

public protocol Toastable: UIView {
    func createView(for toast: Toast)
}
