//
//  Created by jcc on 2022/11/29.
//

public extension Result where Success == Void {
    static var success: Self { .success(()) }
}

