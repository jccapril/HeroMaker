//
//  Created by jcc on 2022/11/29.
//

import Foundation

public extension Dictionary {
    enum MergingStrategy {
        case replaceExisting
        case keepExisting
    }
}

public extension Dictionary {
    mutating func merge(_ other: Dictionary, strategy: MergingStrategy = .replaceExisting) {
        switch strategy {
        case .replaceExisting:
            merge(other) { _, new in new }
        case .keepExisting:
            merge(other) { current, _ in current }
        }
    }

    func merging(_ other: Dictionary, strategy: MergingStrategy = .replaceExisting) -> Dictionary {
        switch strategy {
        case .replaceExisting:
            return merging(other) { _, new in new }
        case .keepExisting:
            return merging(other) { current, _ in current }
        }
    }

    mutating func merge(_ other: Dictionary?, strategy _: MergingStrategy = .replaceExisting) {
        guard let other = other else { return }
        merge(other)
    }

    func merging(_ other: Dictionary?, strategy _: MergingStrategy = .replaceExisting) -> Dictionary {
        guard let other = other else { return self }
        return merging(other)
    }
}

public extension Dictionary {
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        lhs.merging(rhs)
    }

    static func + (lhs: [Key: Value], rhs: [Key: Value]?) -> [Key: Value] {
        guard let rhs: [Key: Value] = rhs else { return lhs }

        return lhs.merging(rhs)
    }

    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs)
    }
}

