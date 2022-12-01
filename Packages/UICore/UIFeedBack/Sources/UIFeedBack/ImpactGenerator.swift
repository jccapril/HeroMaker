//
//  Created by jcc on 2022/12/1.
//

import UIKit

@available(iOS 10.0, *)
public class ImpactGenerator {
    private lazy var generators = [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator]()

    init() {}
}

@available(iOS 10.0, *)
public extension ImpactGenerator {
    subscript(style: UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator {
        get {
            switch generators[style] {
            case let .some(impactFeedbackGenerator):
                return impactFeedbackGenerator
            case .none:
                let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: style)
                generators[style] = impactFeedbackGenerator
                impactFeedbackGenerator.prepare()
                return impactFeedbackGenerator
            }
        }
        set { fatalError("Unavailable") }
    }
}

