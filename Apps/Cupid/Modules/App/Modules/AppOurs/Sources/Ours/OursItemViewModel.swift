//
//  OursItemViewModel.swift
//  AppOurs
//
//  Created by jcc on 2023/3/3.
//

import UICore
import Center

class OursItemViewModel: ViewModel {
    let sectionID: Int
    let itemID: Int
    let title: String
    let image: UIImage?
    let detailText: String?
    let corners: UIRectCorner?
    let backgroundColor: UIColor?
    let coupleInfo: CoupleInfo?
    init(sectionID: Int, itemID: Int, title: String, image: UIImage? = nil, detailText: String? = nil, coupleInfo: CoupleInfo? = nil, corners: UIRectCorner? = nil, backgroundColor: UIColor? = OursModule.color(name: "Cell.BackgroundColor.Main")) {
        self.sectionID = sectionID
        self.itemID = itemID
        self.title = title
        self.image = image
        self.detailText = detailText
        self.coupleInfo = coupleInfo
        self.corners = corners
        self.backgroundColor = backgroundColor
        super.init()
    }
}

extension OursItemViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sectionID)
        hasher.combine(itemID)
    }

    public static func == (lhs: OursItemViewModel, rhs: OursItemViewModel) -> Bool {
        lhs.sectionID == rhs.sectionID && lhs.itemID == rhs.itemID
    }
}

