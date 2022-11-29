//
//  Created by jcc on 2022/11/29.
//

public extension Collection {
    
    
    subscript(safe position: Index) -> Element? {
        indices.contains(position) ? self[position] : nil
    }

    subscript(safe bounds: Range<Self.Index>) -> Self.SubSequence? {
        hasIndex(bounds) ? self[bounds] : nil
    }
}

public extension Collection {
    
    func hasIndex(_ bounds: Range<Index>) -> Bool {
        bounds.lowerBound >= startIndex && bounds.upperBound <= endIndex
    }
}

