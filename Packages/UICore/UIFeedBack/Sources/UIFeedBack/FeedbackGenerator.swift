//
// Created by jcc on 2022/6/20.
//

import UIKit

public enum FeedbackGenerator {}

public extension FeedbackGenerator {
    @available(iOS 10.0, *)
    static let impact = ImpactGenerator()
    @available(iOS 10.0, *)
    static let selection = SelectionGenerator()
    @available(iOS 10.0, *)
    static let notification = NotificationGenerator()
}
