//
//  Created by jcc on 2022/12/1.
//

#if canImport(UIKit)
import UIKit

public extension UIImage {
    @available(iOS 13.0, *)
    static func dynamic(light: @autoclosure () -> UIImage, dark: @autoclosure () -> UIImage) -> UIImage {
        let lightImage = light()
        let darkImage = dark()
        let imageAsset = UIImageAsset()
        let lightTraitCollection = UITraitCollection(traitsFrom: [
            .init(userInterfaceStyle: .light),
            .init(displayScale: lightImage.scale),
        ])
        let darkTraitCollection = UITraitCollection(traitsFrom: [
            .init(userInterfaceStyle: .dark),
            .init(displayScale: darkImage.scale),
        ])
        imageAsset.register(lightImage, with: lightTraitCollection)
        imageAsset.register(darkImage, with: darkTraitCollection)
        return imageAsset.image(with: .current)
    }
}

#endif
