//
//  Created by jcc on 2022/12/1.
//

import Foundation

@propertyWrapper
public struct Trimmed {
    private var value: String = ""

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }

    public var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
