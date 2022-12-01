//
//  Created by jcc on 2022/12/1.
//

import UIKit

@available(iOS 10.0, *)
public class SelectionGenerator {
    private lazy var generator: UISelectionFeedbackGenerator = {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        return generator
    }()

    init() {}
}

@available(iOS 10.0, *)
public extension SelectionGenerator {
    var shared: UISelectionFeedbackGenerator { generator }
}
